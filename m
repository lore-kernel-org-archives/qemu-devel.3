Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E24AD3EE68
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 13:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viv4g-0007Xn-KI; Thu, 22 Jan 2026 08:50:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1viv4M-0007Ug-T9
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 08:49:55 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1viv4K-00051A-6f
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 08:49:53 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 26B075BCD3;
 Thu, 22 Jan 2026 13:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769089790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x7uEp1Fh2R8IxkaO7NtUxioQNDa5MBJkW8yoVx2TadE=;
 b=r3mOZo7ijDvBROZ0IlzcapAvJFbofqFcTwlOmzWbd/VPiWCUVYvoIH9f+S7GXpQUJ6SAD5
 vKb4dn6S66W9vqZunZJXvR2koKTJKFBMk5jnCLzJfoN2MJVLtlE5KwDP4RCIsvIfJKIZCo
 BjARBWoCfn08XekWlyCmXikWvrYg9b0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769089790;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x7uEp1Fh2R8IxkaO7NtUxioQNDa5MBJkW8yoVx2TadE=;
 b=Fxd4lOFD27xyQZXk/2DJdAsk2flNf3R5iK52v3noqAv7pAmFGYdFNgXpXfRRs60PJ72Ufj
 Um08atueMFL8sFCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769089790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x7uEp1Fh2R8IxkaO7NtUxioQNDa5MBJkW8yoVx2TadE=;
 b=r3mOZo7ijDvBROZ0IlzcapAvJFbofqFcTwlOmzWbd/VPiWCUVYvoIH9f+S7GXpQUJ6SAD5
 vKb4dn6S66W9vqZunZJXvR2koKTJKFBMk5jnCLzJfoN2MJVLtlE5KwDP4RCIsvIfJKIZCo
 BjARBWoCfn08XekWlyCmXikWvrYg9b0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769089790;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x7uEp1Fh2R8IxkaO7NtUxioQNDa5MBJkW8yoVx2TadE=;
 b=Fxd4lOFD27xyQZXk/2DJdAsk2flNf3R5iK52v3noqAv7pAmFGYdFNgXpXfRRs60PJ72Ufj
 Um08atueMFL8sFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DE4F1395E;
 Thu, 22 Jan 2026 13:49:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dgQ7E/0qcmnjdQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 22 Jan 2026 13:49:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 17/31] migration: Add a qdev property for StrOrNull
In-Reply-To: <CAFEAcA89vswCip53OAPFzLwz5EMnWBtsM61YD0Nc_kYrM4NuCw@mail.gmail.com>
References: <20251223142959.1460293-1-peterx@redhat.com>
 <20251223142959.1460293-18-peterx@redhat.com>
 <CAFEAcA89vswCip53OAPFzLwz5EMnWBtsM61YD0Nc_kYrM4NuCw@mail.gmail.com>
Date: Thu, 22 Jan 2026 10:49:46 -0300
Message-ID: <871pjhlptx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email, linaro.org:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 23 Dec 2025 at 14:32, Peter Xu <peterx@redhat.com> wrote:
>>
>> From: Fabiano Rosas <farosas@suse.de>
>>
>> The MigrationState is a QOM object with TYPE_DEVICE as a parent. This
>> was done about eight years ago so the migration code could make use of
>> qdev properties to define the defaults for the migration parameters
>> and to be able to expose migration knobs for debugging via the
>> '-global migration' command line option.
>>
>> Due to unrelated historical reasons, three of the migration parameters
>> (TLS options) received different types when used via the
>> query-migrate-parameters QMP command than with the
>> migrate-set-parameters command. This has created a lot of duplication
>> in the migration code and in the QAPI documentation because the whole
>> of MigrationParameters had to be duplicated as well.
>>
>> The migration code is now being fixed to remove the duplication and
>> for that to happen the offending fields need to be reconciled into a
>> single type. The StrOrNull type is going to be used.
>>
>> To keep the command line compatibility, the parameters need to
>> continue being exposed via qdev properties accessible from the command
>> line. Introduce a qdev property StrOrNull just for that.
>>
>> Note that this code is being kept in migration/options.c as this
>> version of StrOrNull doesn't need to handle QNULL because it was never
>> a valid option in the previous command line, which took a string.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> Acked-by: Peter Xu <peterx@redhat.com>
>> Link: https://lore.kernel.org/r/20251215220041.12657-4-farosas@suse.de
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>
> Coverity also suspects a leak in the get function (CID 1643920):
>
>> +static void get_StrOrNull(Object *obj, Visitor *v, const char *name,
>> +                          void *opaque, Error **errp)
>> +{
>> +    const Property *prop = opaque;
>> +    StrOrNull **ptr = object_field_prop_ptr(obj, prop);
>> +    StrOrNull *str_or_null = *ptr;
>> +
>> +    if (!str_or_null) {
>> +        str_or_null = g_new0(StrOrNull, 1);
>
> We allocate memory here, but we never pass this pointer
> on to anybody else, and we don't free it either.
>

Thank you, I'll look into both issues right away.


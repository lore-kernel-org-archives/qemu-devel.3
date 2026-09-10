Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4625C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 12:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4e23-0001qs-9t; Thu, 10 Sep 2026 08:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4e20-0001qk-33
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 08:37:33 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4e1x-0002Ro-Gq
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 08:37:31 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5C7771FDB2;
 Thu, 10 Sep 2026 12:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789043843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JvuzATIMGkVXHCcOMUsUHyXHCcplWV6elVu0rmVCgCs=;
 b=OVpu/XSj/IXO/Kc3B909yrpdJ7HQLaWISSIlh3MXE82yajyxlQopBny4IpLMtzs2/i1JZ6
 GdLNwAnPnu2pufKZ++d7Zn2n44jRu3VaTmz0z/woh+KDclF4Pu/ho7v0VnZPkssSoodpGv
 vk50td9iJJQiBM6aVOal5OlKsREY8Tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789043843;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JvuzATIMGkVXHCcOMUsUHyXHCcplWV6elVu0rmVCgCs=;
 b=a9YJBM+XeIaEekCSSyMTjZJmF9F7PUWrak2FRvPZmzPn2HU7QdYjIbgR5IC9+VrAVCladD
 3P8QDM6wqR/JmxBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789043839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JvuzATIMGkVXHCcOMUsUHyXHCcplWV6elVu0rmVCgCs=;
 b=qlIKeREiiqK7GyboALYL8CDG7UzT1Juq59A3e6mmIXG8MuiTatSiiJnybcQrzzqSJB21J8
 aRjn/+Lr5Lc6nfXlZu+ilJ50xV8FkshHdkVC6YU5SZBSincAqZLpTBuw65pjnrOpCzLJWx
 ZhOvXb/KirKGOr+N7uOz3HN9HsBhB1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789043839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JvuzATIMGkVXHCcOMUsUHyXHCcplWV6elVu0rmVCgCs=;
 b=26aH9UogX3AeFsvvlClnlwYj4mb1AFEgHr4slgi3fOR3JBPzhVGKOAmMfEGdxbv2NSgn0w
 KAykaaPF/4TIa9BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D39DD13180;
 Thu, 10 Sep 2026 12:37:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SQbjKH6komqAWQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 10 Sep 2026 12:37:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, "Dr . David Alan Gilbert" <dave@treblig.org>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 11/18] migration: HMP: Fix bandwidth parameters
In-Reply-To: <875x0dhc9u.fsf@pond.sub.org>
References: <20260909214509.237309-1-farosas@suse.de>
 <20260909214509.237309-12-farosas@suse.de> <875x0dhc9u.fsf@pond.sub.org>
Date: Thu, 10 Sep 2026 09:37:12 -0300
Message-ID: <87zexpth8n.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> The max-bandwidth and avail-switchover-bandwidth parameters are
>> declared as bytes/second in migration.json and interpreted as such
>> throughout the code, except in HMP where they're expected to be
>> provided as mebibytes.
>>
>> Fix the HMP code to parse the values as bytes.
>
> I wouldn't call this a fix.  The choice of unit was clearly intentional.
> Doesn't mean we must not change it now.  David, what do you think?
>

Hm, but if the code uses bytes in arithmetic throughout, there must be
bugs lingering somewhere. Although I haven't verified that. Nonetheless,
I can use a different terminology, no worries.


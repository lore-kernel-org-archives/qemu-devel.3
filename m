Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9B4EE2092
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 12:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voKxW-0003Ta-Cr; Fri, 06 Feb 2026 07:29:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1voKxU-0003SE-Py
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:29:12 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1voKxT-0004Tb-BG
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:29:12 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 21D133E6FB;
 Fri,  6 Feb 2026 12:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770380948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+fMkAk9hoqA17k67gRajMzajcz4AJWlozYS1BtkbtIw=;
 b=R+X5CV1R1GD6eEIfdB+EX4jbZBw1V3QmJhyhZe3X6btHfcguePFJD4zjb00UwTLaIFE0A2
 75Ob/ncxd2MVgwdpj16s0urqiO3w5uKlEymgcFccVIvV+mx7eiMJ54+HxcxEMwhCUE1k7v
 6gPJPqIFe1GXwxx7bvRaRnPri/7XXIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770380948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+fMkAk9hoqA17k67gRajMzajcz4AJWlozYS1BtkbtIw=;
 b=gkvZKDr4BkwgmCuPfMGp9iJhwjJT2A5eTLhAgMMD9Xu80SzrhJ4PqywOe4KnC+r5a/MQYz
 IX325OGPaeUNgJDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=R+X5CV1R;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gkvZKDr4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770380948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+fMkAk9hoqA17k67gRajMzajcz4AJWlozYS1BtkbtIw=;
 b=R+X5CV1R1GD6eEIfdB+EX4jbZBw1V3QmJhyhZe3X6btHfcguePFJD4zjb00UwTLaIFE0A2
 75Ob/ncxd2MVgwdpj16s0urqiO3w5uKlEymgcFccVIvV+mx7eiMJ54+HxcxEMwhCUE1k7v
 6gPJPqIFe1GXwxx7bvRaRnPri/7XXIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770380948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+fMkAk9hoqA17k67gRajMzajcz4AJWlozYS1BtkbtIw=;
 b=gkvZKDr4BkwgmCuPfMGp9iJhwjJT2A5eTLhAgMMD9Xu80SzrhJ4PqywOe4KnC+r5a/MQYz
 IX325OGPaeUNgJDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D7773EA63;
 Fri,  6 Feb 2026 12:29:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fvLNE5PehWkuVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Feb 2026 12:29:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, ppandit@redhat.com
Subject: Re: [PATCH v2 8/9] migration/options: Stop freeing s->parameters
 members individually
In-Reply-To: <aYUWwSxnsWn1Dfu0@x1.local>
References: <20260202224101.20568-1-farosas@suse.de>
 <20260202224101.20568-9-farosas@suse.de> <aYUWwSxnsWn1Dfu0@x1.local>
Date: Fri, 06 Feb 2026 09:29:04 -0300
Message-ID: <87a4xmqcmn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 21D133E6FB
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Feb 02, 2026 at 07:41:00PM -0300, Fabiano Rosas wrote:
>> Expecting every pointer member from s->parameters to be freed
>> individually is prone to leave some fields forgotten when the code is
>> eventually updated. Use a dealloc visitor to free them all at once.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/options.c | 24 +++++++++++++++++-------
>>  1 file changed, 17 insertions(+), 7 deletions(-)
>> 
>> diff --git a/migration/options.c b/migration/options.c
>> index 733aae51a8..cc5a66750c 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -1002,11 +1002,21 @@ AnnounceParameters *migrate_announce_params(void)
>>      return &ap;
>>  }
>>  
>> -static void migrate_tls_opts_free(MigrationParameters *params)
>> +static bool migrate_params_free(MigrationParameters *params, Error **errp)
>>  {
>> -    qapi_free_StrOrNull(params->tls_creds);
>> -    qapi_free_StrOrNull(params->tls_hostname);
>> -    qapi_free_StrOrNull(params->tls_authz);
>> +    Visitor *v = qapi_dealloc_visitor_new();
>> +    bool ret;
>> +
>> +    /*
>> +     * qapi_free_MigrationParameters can't be used here because
>> +     * MigrationParameters is embedded in MigrationState due to qdev
>> +     * needing to access the offset of the migration properties inside
>> +     * the migration object.
>> +     */
>
> Ohhhhhhhh.... thanks for the comment!
>

There's some amount of rigidness caused by qdev requirements
unfortunately.

I'm not sure if I ever posted it, but I wrote some code to move the
parameters into a MigrationOptions object so we could make
MigrationState not be a TYPE_DEVICE anymore. But then we'd end up with
something like -global migration-options by default, so it kinda killed
the idea.

> Reviewed-by: Peter Xu <peterx@redhat.com>
>
>> +    ret = visit_type_MigrationParameters_members(v, params, errp);
>> +    visit_free(v);
>> +
>> +    return ret;
>>  }


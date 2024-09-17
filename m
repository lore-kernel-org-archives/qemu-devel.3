Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C690ACAC596
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 19:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqdlc-00088o-1Q; Tue, 17 Sep 2024 15:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sqdkb-0006b5-JI
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 15:20:38 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sqdkZ-00040U-R8
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 15:20:37 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C6EDC2245F;
 Tue, 17 Sep 2024 19:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726600834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ql7Vr+OH0cbKZBjQSnnP7y632ZT9mxma2WUmuH++XE=;
 b=seGQ5lTv6HeumIeNgQZAhmPnb0wNUDUFu0S07jjdwxCVvypOme3E/0DF+VCTI4eshEist2
 T5re0rPQjwSFl2QmsUPFOE0RonFtq7JL5BlEZM0TBcs2cUqmcYy30WGNIS+aROgAoQbN47
 vyvcOiP2j5uB0XY/8EQh936lv57Pcco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726600834;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ql7Vr+OH0cbKZBjQSnnP7y632ZT9mxma2WUmuH++XE=;
 b=Dlg13PxgVIIn6bdwcoWUBF+RDLf8BflqlFDWT8mv5qBZtrmcO0J6mw4WOnNF1svhwDLmi5
 zxLbDOb9PBdN1ZDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PGcBMYb1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="w/KIbgi/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726600833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ql7Vr+OH0cbKZBjQSnnP7y632ZT9mxma2WUmuH++XE=;
 b=PGcBMYb1mAFaFjcAo+/Uwab86aRfhA7s3ZcoOF6nFcZakA2NUd2xT4qvy/oJpNSPWHipv+
 f2PGi5hdvK0me4WLudZRrerCFCnyYbNiwtHRFCq6abrkjhcHqndak/mtQXm34iBDQfkY+U
 r9zZWt6wJdgyGOJo7uj0FN9xhbsckWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726600833;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ql7Vr+OH0cbKZBjQSnnP7y632ZT9mxma2WUmuH++XE=;
 b=w/KIbgi/8XWhPL7riIPkbDKCgndqYIAGFxajACO5ed9HWlGxfo+i195fzUPvzq1aWMCif5
 8tU7In4Q8OzPFlAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C536139CE;
 Tue, 17 Sep 2024 19:20:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id datfBYHW6WbaEwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Sep 2024 19:20:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] migration/savevm: Remove extra load cleanup calls
In-Reply-To: <ZunVqQsnReeqnorV@x1n>
References: <20240917185802.15619-1-farosas@suse.de>
 <20240917185802.15619-2-farosas@suse.de> <ZunVqQsnReeqnorV@x1n>
Date: Tue, 17 Sep 2024 16:20:30 -0300
Message-ID: <87a5g6ytmp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: C6EDC2245F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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
List-Id: <qemu-devel.nongnu.org>
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

> On Tue, Sep 17, 2024 at 03:58:01PM -0300, Fabiano Rosas wrote:
>> There are two qemu_loadvm_state_cleanup() calls that were introduced
>> when qemu_loadvm_state_setup() was still called before loading the
>> configuration section, so there was state to be cleaned up if the
>> header checks failed.
>> 
>> However, commit 9e14b84908 ("migration/savevm: load_header before
>> load_setup") has moved that configuration section part to
>> qemu_loadvm_state_header() which now happens before
>> qemu_loadvm_state_setup().
>> 
>> Remove the cleanup calls that are now misplaced.
>> 
>> Fixes: 9e14b84908 ("migration/savevm: load_header before load_setup")
>
> Considering it's a cleanup, do you mind if I further remove this Fixes but
> just mention it in commit message (so as to make Michael's life easier when
> backport)?

Sure, go ahead.

>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/savevm.c | 2 --
>>  1 file changed, 2 deletions(-)
>> 
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index d500eae979..d0759694fd 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -2732,13 +2732,11 @@ static int qemu_loadvm_state_header(QEMUFile *f)
>>      if (migrate_get_current()->send_configuration) {
>>          if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
>>              error_report("Configuration section missing");
>> -            qemu_loadvm_state_cleanup();
>>              return -EINVAL;
>>          }
>>          ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0);
>>  
>>          if (ret) {
>> -            qemu_loadvm_state_cleanup();
>>              return ret;
>>          }
>>      }
>> -- 
>> 2.35.3
>> 


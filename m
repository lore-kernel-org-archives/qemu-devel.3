Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE633E6FE31
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 16:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smcBc-0008H8-Cj; Fri, 06 Sep 2024 12:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1smcBa-0008AB-Ej; Fri, 06 Sep 2024 12:51:50 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1smcBX-0006FT-8J; Fri, 06 Sep 2024 12:51:50 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 575DD1F891;
 Fri,  6 Sep 2024 16:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725641504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iC5lNAOCrvH45YcbshhAPP5FpJ5bVuJZrPq/jqZW6zU=;
 b=APNxiewRuMoKEx1bcFXSmeOz5FedU7s9jdEzhZTgOVXGfkFU+gdwIOQTGDYjqm1pIbWnud
 aT5FcJFeMG0C6DUPnemSyYmCUxPdPiZPwhuFqsJ0VYo2X1g5Q1yb7C93vJoedXdAmBatyU
 HmiOByf/1A8Tf2iHD2cWNj7UrHcVfyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725641504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iC5lNAOCrvH45YcbshhAPP5FpJ5bVuJZrPq/jqZW6zU=;
 b=D4ivtJkDV+y8eV2QFpD7LYhW9Lr2fQD0b7eEWJdEkBUjAuOFWMadsuuD7XVP5j05/9ot5+
 iylzO7rPpZHiKdCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725641504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iC5lNAOCrvH45YcbshhAPP5FpJ5bVuJZrPq/jqZW6zU=;
 b=APNxiewRuMoKEx1bcFXSmeOz5FedU7s9jdEzhZTgOVXGfkFU+gdwIOQTGDYjqm1pIbWnud
 aT5FcJFeMG0C6DUPnemSyYmCUxPdPiZPwhuFqsJ0VYo2X1g5Q1yb7C93vJoedXdAmBatyU
 HmiOByf/1A8Tf2iHD2cWNj7UrHcVfyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725641504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iC5lNAOCrvH45YcbshhAPP5FpJ5bVuJZrPq/jqZW6zU=;
 b=D4ivtJkDV+y8eV2QFpD7LYhW9Lr2fQD0b7eEWJdEkBUjAuOFWMadsuuD7XVP5j05/9ot5+
 iylzO7rPpZHiKdCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D132E136A8;
 Fri,  6 Sep 2024 16:51:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aSeLJR8z22bhXQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Sep 2024 16:51:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v7 2/4] migration/multifd: Fix p->iov leak in
 multifd-uadk.c
In-Reply-To: <88fb3407-b7d9-4461-a217-044a4b5aadcc@tls.msk.ru>
References: <20240828145650.15879-1-farosas@suse.de>
 <20240828145650.15879-3-farosas@suse.de>
 <88fb3407-b7d9-4461-a217-044a4b5aadcc@tls.msk.ru>
Date: Fri, 06 Sep 2024 13:51:41 -0300
Message-ID: <87o750lo82.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> 28.08.2024 17:56, Fabiano Rosas wrote:
>> The send_cleanup() hook should free the p->iov that was allocated at
>> send_setup(). This was missed because the UADK code is conditional on
>> the presence of the accelerator, so it's not tested by default.
>> 
>> Fixes: 819dd20636 ("migration/multifd: Add UADK initialization")
>> Reported-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   migration/multifd-uadk.c | 2 ++
>>   1 file changed, 2 insertions(+)
>> 
>> diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
>> index 89f6a72f0e..6e6a290ae9 100644
>> --- a/migration/multifd-uadk.c
>> +++ b/migration/multifd-uadk.c
>> @@ -132,6 +132,8 @@ static void multifd_uadk_send_cleanup(MultiFDSendParams *p, Error **errp)
>>   
>>       multifd_uadk_uninit_sess(wd);
>>       p->compress_data = NULL;
>> +    g_free(p->iov);
>> +    p->iov = NULL;
>>   }
>
> This sounds like something for stable-9.1.x, is it not?

Right, it is.

>
> Thanks,
>
> /mjt


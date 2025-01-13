Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D21E7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 12:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXJz5-0005rB-M4; Mon, 13 Jan 2025 07:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tXJz1-0005qZ-7P; Mon, 13 Jan 2025 07:55:56 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tXJyz-0006Qg-3Y; Mon, 13 Jan 2025 07:55:54 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 01FE12116F;
 Mon, 13 Jan 2025 12:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736772948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CBCZQq2JrHRZMNXoLgzekP/DxtmRNzfJD0ALiFFGDt8=;
 b=wNh00f8wgQs24kvQl+k9SWnmRRsA1qdgeKLiZE5aouEt8u5oWdiIc4gbLMFXLkrqnng5bi
 B+IAzzDxXabaaZL5H2EXMcwdo3NPF72Ujk6yyZumIh7PUCqaw6CdymTkC1Wo1C5ewOXE7x
 VHyXDezWoX5EbPcLyxueQx9uZtjvDzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736772948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CBCZQq2JrHRZMNXoLgzekP/DxtmRNzfJD0ALiFFGDt8=;
 b=hBvXT75zQBsfrEJVGMMKOgx85LTkCYFucXevmzU9f1ss9D6+kPq0rw3A3xoqjA8kgl+/OZ
 oFlmTdSz8aw0cvDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736772948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CBCZQq2JrHRZMNXoLgzekP/DxtmRNzfJD0ALiFFGDt8=;
 b=wNh00f8wgQs24kvQl+k9SWnmRRsA1qdgeKLiZE5aouEt8u5oWdiIc4gbLMFXLkrqnng5bi
 B+IAzzDxXabaaZL5H2EXMcwdo3NPF72Ujk6yyZumIh7PUCqaw6CdymTkC1Wo1C5ewOXE7x
 VHyXDezWoX5EbPcLyxueQx9uZtjvDzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736772948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CBCZQq2JrHRZMNXoLgzekP/DxtmRNzfJD0ALiFFGDt8=;
 b=hBvXT75zQBsfrEJVGMMKOgx85LTkCYFucXevmzU9f1ss9D6+kPq0rw3A3xoqjA8kgl+/OZ
 oFlmTdSz8aw0cvDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A1E313876;
 Mon, 13 Jan 2025 12:55:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QBcgEFMNhWeAGgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 13 Jan 2025 12:55:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>, Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>, qemu-devel@nongnu.org,
 peterx@redhat.com
Cc: linuxarm@huawei.com, zhangfei.gao@linaro.org, qemu-stable
 <qemu-stable@nongnu.org>
Subject: Re: [PATCH] migration/multifd: Fix compile error caused by
 page_size usage
In-Reply-To: <0198d019-1d50-4b94-ab15-9d2bdef183db@tls.msk.ru>
References: <20241203124943.52572-1-shameerali.kolothum.thodi@huawei.com>
 <0198d019-1d50-4b94-ab15-9d2bdef183db@tls.msk.ru>
Date: Mon, 13 Jan 2025 09:55:44 -0300
Message-ID: <87h662hnzj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 huawei.com:email]
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

> 03.12.2024 15:49, Shameer Kolothum via wrote:
>>  From Commit 90fa121c6c07 ("migration/multifd: Inline page_size and
>> page_count") onwards page_size is not part of MutiFD*Params but uses
>> an inline constant instead.
>> 
>> However, it missed updating an old usage, causing a compile error.
>> 
>> Fixes: 90fa121c6c07 ("migration/multifd: Inline page_size and page_count")
>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>
> This looks like a qemu-stable material, is it not?
>

Yes.

> I wonder how come thie code hasn't been compiled since 90fa121c6c07.

The various pieces of code that support hardware accelerators in
migration all depend on specific hardware and libraries, so it's all
gated behind CONFIGs that are not enabled by default. We don't have
resources to test this, it's up to the people interested in that code to
check that it still works.

I have suggested we move more code out of the CONFIGs to minimize the
amount of untested code, but we've ended up deciding that since we need
help from people to maintain it anyway, it's not worth the extra work to
isolate the hw-specific code even more.

>
> /mjt
>
>>   migration/multifd-uadk.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
>> index 6e6a290ae9..6895c1f65a 100644
>> --- a/migration/multifd-uadk.c
>> +++ b/migration/multifd-uadk.c
>> @@ -169,7 +169,7 @@ static int multifd_uadk_send_prepare(MultiFDSendParams *p, Error **errp)
>>               .src_len = page_size,
>>               .dst     = buf,
>>               /* Set dst_len to double the src in case compressed out >= page_size */
>> -            .dst_len = p->page_size * 2,
>> +            .dst_len = page_size * 2,
>>           };
>>   
>>           if (uadk_data->handle) {


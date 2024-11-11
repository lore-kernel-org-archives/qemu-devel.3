Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706CED3ABCE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 17:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAXwE-0008TP-6k; Mon, 11 Nov 2024 12:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tAXw1-0008Rr-Tf; Mon, 11 Nov 2024 12:10:44 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tAXvz-0000MY-UY; Mon, 11 Nov 2024 12:10:41 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A974921976;
 Mon, 11 Nov 2024 17:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731345036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3pDUfFL8mYFjpIM4v3KKicXnR6YXVFFWUcmcM3lLLwI=;
 b=THEiaujLyzW59U+mkAoRY+LgrJEcWeUV7g4ktRhDL9H4Xtw6glHLiN0pSCJL6XZf5hZwX6
 neClQFiMLmvhIY1XpcEdWrnLdAUmeNWC4ogeOgHvG10EGMnss+Oxl9g3Wv/lAIDC8W3CjU
 t70xnqFAo+d67HAX0cX+bOvJ3qdQeFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731345036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3pDUfFL8mYFjpIM4v3KKicXnR6YXVFFWUcmcM3lLLwI=;
 b=/xOgztKSLVHU/gao8HBGAjteozYTa5uP85nHjUFaSe/XP4eNF+LVCaf/u5RFHuA8aGwEHQ
 ZGVEsCta1pn0fWBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=19LzsK5I;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JFCwTFPR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731345034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3pDUfFL8mYFjpIM4v3KKicXnR6YXVFFWUcmcM3lLLwI=;
 b=19LzsK5It6x2/rTdtM3krTy/eJHfodPJIzqSSvtG/wLAdJlnXGzfEiIx3WKVGgEX67xNIP
 G0UW/tayAoAgCGzQnb38nOcDlfwGcE2t/EVBdyjQxgEpX6rtTY5y7Bh7wW+W5XPE4u7Fcj
 D19+BGx2XZjH+oucDviT8qKeCjFJ/2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731345034;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3pDUfFL8mYFjpIM4v3KKicXnR6YXVFFWUcmcM3lLLwI=;
 b=JFCwTFPReB+BnN0KtARf4qKSgoGSUbbxpLYnZ63PpMx05+sa1eb/IgZ/dflr3J8LuSwWhX
 utm8zzVgriMcclCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E605137FB;
 Mon, 11 Nov 2024 17:10:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VgXDOIk6MmdpGgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 11 Nov 2024 17:10:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>
Subject: Re: [PATCH] block: Fix leak in send_qmp_error_event
In-Reply-To: <aeef7f22-1102-4d03-a473-564d65e29892@linaro.org>
References: <20241111145214.8261-1-farosas@suse.de>
 <aeef7f22-1102-4d03-a473-564d65e29892@linaro.org>
Date: Mon, 11 Nov 2024 14:10:31 -0300
Message-ID: <87jzd9itmg.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A974921976
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 11/11/24 14:52, Fabiano Rosas wrote:
>> ASAN detected a leak when running the ahci-test
>> /ahci/io/dma/lba28/retry:
>>=20
>> Direct leak of 35 byte(s) in 1 object(s) allocated from:
>>      #0 in malloc
>>      #1 in __vasprintf_internal
>>      #2 in vasprintf
>>      #3 in g_vasprintf
>>      #4 in g_strdup_vprintf
>>      #5 in g_strdup_printf
>>      #6 in object_get_canonical_path ../qom/object.c:2096:19
>>      #7 in blk_get_attached_dev_id_or_path ../block/block-backend.c:1033=
:12
>>      #8 in blk_get_attached_dev_path ../block/block-backend.c:1047:12
>>      #9 in send_qmp_error_event ../block/block-backend.c:2140:36
>>      #10 in blk_error_action ../block/block-backend.c:2172:9
>>      #11 in ide_handle_rw_error ../hw/ide/core.c:875:5
>>      #12 in ide_dma_cb ../hw/ide/core.c:894:13
>>      #13 in dma_complete ../system/dma-helpers.c:107:9
>>      #14 in dma_blk_cb ../system/dma-helpers.c:129:9
>>      #15 in blk_aio_complete ../block/block-backend.c:1552:9
>>      #16 in blk_aio_write_entry ../block/block-backend.c:1619:5
>>      #17 in coroutine_trampoline ../util/coroutine-ucontext.c:175:9
>>=20
>> Plug the leak by freeing the device path string.
>>=20
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   block/block-backend.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/block/block-backend.c b/block/block-backend.c
>> index 85bcdedcef..a3b7f00188 100644
>> --- a/block/block-backend.c
>> +++ b/block/block-backend.c
>> @@ -2134,13 +2134,14 @@ static void send_qmp_error_event(BlockBackend *b=
lk,
>>   {
>>       IoOperationType optype;
>>       BlockDriverState *bs =3D blk_bs(blk);
>> +    char *path =3D blk_get_attached_dev_path(blk);
>
> Preferably using g_autofree,

Of course, I'll repost. Thanks!



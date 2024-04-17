Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E55C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 13:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx56g-0003Po-Oe; Wed, 17 Apr 2024 09:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rx56Z-0003Ot-Ul
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 09:13:41 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rx56W-0001uS-Um
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 09:13:38 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E870F2095A;
 Wed, 17 Apr 2024 13:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713359614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tfg1ZadM3m1pS8W00xXCXMQfgPaph017Yafs+1yojsc=;
 b=GIG/n9w5sujUk0drQUVUJPVv6DFoBk/tVLEoEVPF490UjkAHd8SGoKbKHisHFj6vl2Jcbs
 rlyvjchTCJSkHyp94niWNxrQySAJh1Dtk3iCDAO+BnfzQagq6WdcTXv9/sVgtCdPdzRxDh
 8VUD6zjsden1IycPBXimoTQzCbmT/RY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713359614;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tfg1ZadM3m1pS8W00xXCXMQfgPaph017Yafs+1yojsc=;
 b=tK8S++UoW6tOAKq+x9mGa2NTKT3RN7mDlDdl9qSrI1xyLfl5adB46CIC2TnJqS2WRH0hRd
 i+15C8hMl1wr1rBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=djmpAUQH;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FiROjeZ7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713359613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tfg1ZadM3m1pS8W00xXCXMQfgPaph017Yafs+1yojsc=;
 b=djmpAUQHswMg77gCZ0LJc9cabM+m4wypMjdKTAQNAn8JuIetd34ta/YSetgKCy+bGBPJjp
 smkcedKhzRrhv0pkfq1m0EOvRpT4UjYpV/MYKq09AB4x+Nu7zldV1FC6gme2SXYAYEVDJ7
 /7N80nbqh2X55V+44gaDin8aBOgT/ZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713359613;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tfg1ZadM3m1pS8W00xXCXMQfgPaph017Yafs+1yojsc=;
 b=FiROjeZ7WVKEduRQOGI9TMaS2H3l8+1X9wFWcA6aaW17yduHVvHwQCNV4tDMV0xwfKwoFQ
 GeTeK011yAhzzlAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7311B1384C;
 Wed, 17 Apr 2024 13:13:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MLKqDv3KH2ZqLgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Apr 2024 13:13:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Li Zhijian via <qemu-devel@nongnu.org>, zhanghailiang@xfusion.com,
 peterx@redhat.com
Cc: qemu-devel@nongnu.org, chen.zhang@intel.com, Wen Congyang
 <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>, Li
 Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v2] migration/colo: Fix bdrv_graph_rdlock_main_loop:
 Assertion `!qemu_in_coroutine()' failed.
In-Reply-To: <20240417025634.1014582-1-lizhijian@fujitsu.com>
References: <20240417025634.1014582-1-lizhijian@fujitsu.com>
Date: Wed, 17 Apr 2024 10:13:31 -0300
Message-ID: <87a5lsb090.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [0.79 / 50.00]; SEM_URIBL(3.50)[gitlab.com:url];
 BAYES_HAM(-3.00)[99.99%]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 BAD_REP_POLICIES(0.10)[]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 R_DKIM_ALLOW(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SUBJECT_HAS_EXCLAIM(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[nongnu.org,intel.com,huawei.com,gmail.com,fujitsu.com];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; TAGGED_RCPT(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.de:email]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: E870F2095A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Li Zhijian via <qemu-devel@nongnu.org> writes:

> bdrv_activate_all() should not be called from the coroutine context, move
> it to the QEMU thread colo_process_incoming_thread() with the bql_lock
> protected.
>
> The backtrace is as follows:
>  #4  0x0000561af7948362 in bdrv_graph_rdlock_main_loop () at ../block/graph-lock.c:260
>  #5  0x0000561af7907a68 in graph_lockable_auto_lock_mainloop (x=0x7fd29810be7b) at /patch/to/qemu/include/block/graph-lock.h:259
>  #6  0x0000561af79167d1 in bdrv_activate_all (errp=0x7fd29810bed0) at ../block.c:6906
>  #7  0x0000561af762b4af in colo_incoming_co () at ../migration/colo.c:935
>  #8  0x0000561af7607e57 in process_incoming_migration_co (opaque=0x0) at ../migration/migration.c:793
>  #9  0x0000561af7adbeeb in coroutine_trampoline (i0=-106876144, i1=22042) at ../util/coroutine-ucontext.c:175
>  #10 0x00007fd2a5cf21c0 in  () at /lib64/libc.so.6
>
> CC: Fabiano Rosas <farosas@suse.de>
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/2277
> Fixes: 2b3912f135 ("block: Mark bdrv_first_blk() and bdrv_is_root_node() GRAPH_RDLOCK")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>


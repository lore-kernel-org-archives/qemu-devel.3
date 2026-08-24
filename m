Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E68C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 19:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wya61-00056L-H1; Mon, 24 Aug 2026 15:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wya5h-00055g-GH
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 15:12:23 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wya5f-0004Oe-B6
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 15:12:16 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 27D9C1F796;
 Mon, 24 Aug 2026 19:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787598726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mtk74XZXaYmNeqA8HCvYTfYx7rvk4GCBlBIlZCHqCQI=;
 b=xsJGVq5xY/vxu0wJ6jynxTeG/nJ0JkqS8rwH3VwzFL2/ZMYZFJ0n4z7lrgW+pGMEVujV+1
 G59FkHTcgVfbr5dCbzIrua7nDsJMu5kLo8Xzg+evZkK3m+ql8AZdDpXFiay8cN2sA3PobN
 1j64TAWDGH2IHrVWr6+DbyMWe9O/8i8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787598726;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mtk74XZXaYmNeqA8HCvYTfYx7rvk4GCBlBIlZCHqCQI=;
 b=KtVUgx5RqfiE+Fa4OYXiHRkI547077PYWfEYPE1tM3WgWh6hcHfBCZqwHuZELpqRCPRdnJ
 Kt5RmWRA6R/0bdCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RlRxDk+r;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2VVSZuuv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787598722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mtk74XZXaYmNeqA8HCvYTfYx7rvk4GCBlBIlZCHqCQI=;
 b=RlRxDk+rbVa/D6eX9mCGGsRPFefSvhweafx9UmNz2ehvWRStt6tNihSz9jSRaWgbr0iqqd
 Fq8/143AT/TX+i2nUXjPQb1yeDOLGiWKSrl572ym4Q1JXVBxOn87rZKS5dGl4iUL+JN1Hk
 VkgMUMKgQNlTo8NpO4EcpKjaofXahBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787598722;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mtk74XZXaYmNeqA8HCvYTfYx7rvk4GCBlBIlZCHqCQI=;
 b=2VVSZuuvxZSOSGWmIjCflN9mifQr5PVBpVdnqiM2DH73ALymJNiM66L2pm4DEi4zstRtCQ
 webNg6v9vU9pDgAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBAAA13331;
 Mon, 24 Aug 2026 19:12:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sfbMIoGXjGp6KAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 24 Aug 2026 19:12:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Jack Wang <jinpu.wang@ionos.com>, Peter Xu <peterx@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>, Samuel
 Zhang <guoqing.zhang@amd.com>, Yanfei Xu <yanfei.xu@bytedance.com>
Subject: Re: [PATCH v2 00/10] migration/rdma: Fixes or drops
In-Reply-To: <20260820200322.3321036-1-peterx@redhat.com>
References: <20260820200322.3321036-1-peterx@redhat.com>
Date: Mon, 24 Aug 2026 16:11:59 -0300
Message-ID: <871pbnl4e8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 27D9C1F796
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> CI: https://gitlab.com/peterx/qemu/-/pipelines/2777122128
>
> v2:
> - Patch 2: remove two more unused trace points [Jinpu]
> - Patch 4: drop unused RDMALocalBlocks.init [Jinpu]
> - Patch 8: additional check for add overflow, fix off-by-one [Jinpu]
>
> This series includes some RDMA changes, either to drop some dead code, or
> to harden some checks for the incoming data stream, or both.
>
> Please have a look, this should close all RDMA recent AI reports (none of
> them are real security issues), thanks.
>
> Peter Xu (10):
>   migration/rdma: Introduce RDMA_CONTROL_NUM
>   migration/rdma: Remove unregister code
>   migration/rdma: Stick with rdma_ prefix for all tracepoints
>   migration/rdma: Drop RDMALocalBlock.is_ram_block
>   migration/rdma: Drop RDMALocalBlock.unregister_bitmap
>   migration/rdma: Drop RDMARegister.key.chunk
>   migration/rdma: Sanity check RDMA_CONTROL_REGISTER_REQUEST on buflen
>   migration/rdma: Sanity check RDMA_CONTROL_REGISTER_REQUEST chunks
>   migration/rdma: Sanity check upper bound of register MR address
>   migration/rdma: Sanity check compress request ranges
>
>  migration/rdma.c       | 349 +++++++++++++----------------------------
>  migration/trace-events |  81 +++++-----
>  2 files changed, 144 insertions(+), 286 deletions(-)

Queued, thanks!


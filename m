Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EECCC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 13:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxPNO-0005QZ-MK; Fri, 21 Aug 2026 09:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wxPNN-0005QK-6b
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:33:41 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wxPNL-0008C6-G3
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:33:40 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ABC043DFB;
 Fri, 21 Aug 2026 13:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787319213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qZw1LHqSdyKWYl80Xrr9GP/dHNLwgPQiyJscAEjB6T4=;
 b=negVkr/hwy2Aavy1RRaWdgl94hR2ovYl9n9yeDtqJ+aE+urDzT0CNkSqS7dK44jRNFSSVw
 xofrx0hW0FeaJHK7LhAnpP1FefM0/jTxT2gpXcVGyf2ws8lv2mp8u2wKhLTfRAd5b4N1dw
 Zgsxqk8zz3RIKA2X3t7hCMDeW488ICU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787319213;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qZw1LHqSdyKWYl80Xrr9GP/dHNLwgPQiyJscAEjB6T4=;
 b=ebxm14+0TPejL5KtnBCNYLXYzLEkJAnAzHFr8Sf1QodQYjVpzrcvX3LYcMscTiy7IcYEo0
 UasMi3s9WzlIzlBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787319209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qZw1LHqSdyKWYl80Xrr9GP/dHNLwgPQiyJscAEjB6T4=;
 b=knEI63PfLKVwvlkq+SvtKhGSOxDzGX45vAS8pn6TqTKuZH0kk0l9EwpEwBWuaHlK+YCxVe
 QLP1vYA3MXFnIRd+kFKtxV6SxCy/1N1TVBHH5Cb3n1Kp7eGSSLdd+r9ZkpZEUQSp+J8XsN
 Xzb+NKrHmvBRDD58GjptsSkaptasqQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787319209;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qZw1LHqSdyKWYl80Xrr9GP/dHNLwgPQiyJscAEjB6T4=;
 b=cj+91SRkEaXcRwHr2WmrUS9nwpxX/lzB94qaF4NEdm4vI+RzsvhAnlG6BI5EDcaqQl7CYp
 3izMF8dUgpCqidAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DA493329;
 Fri, 21 Aug 2026 13:33:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Nh5HCKlTiGqPGwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Aug 2026 13:33:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Jack Wang <jinpu.wang@ionos.com>, Peter Xu <peterx@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>, Samuel
 Zhang <guoqing.zhang@amd.com>, Yanfei Xu <yanfei.xu@bytedance.com>, Jinpu
 Wang <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH v2 08/10] migration/rdma: Sanity check
 RDMA_CONTROL_REGISTER_REQUEST chunks
In-Reply-To: <20260820200322.3321036-9-peterx@redhat.com>
References: <20260820200322.3321036-1-peterx@redhat.com>
 <20260820200322.3321036-9-peterx@redhat.com>
Date: Fri, 21 Aug 2026 10:33:26 -0300
Message-ID: <87a4qflhsp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, ionos.com:email,
 gitlab.com:url, suse.de:email, suse.de:mid]
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

> The value received on wire for head.chunks when registering new RDMA
> regions is not correctly checked.  Logically the value can still make
> ram_chunk_start() (of ram_chunk_end()) to overflow, having a result pointer
> very small, smaller than RDMALocalBlock.local_host_addr.
>
> Add the sanity check.
>
> Reported-by: Tristan (@TristanInSec)
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4011
> Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/rdma.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index f7356e759f..cf6688a4bc 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3369,7 +3369,7 @@ int rdma_registration_handle(QEMUFile *f)
>              }
>  
>              for (int count = 0; count < head.repeat; count++) {
> -                uint64_t chunk;
> +                uint64_t chunk, chunk_sum;
>                  uint8_t *chunk_start, *chunk_end;
>  
>                  reg = &registers[count];
> @@ -3399,6 +3399,14 @@ int rdma_registration_handle(QEMUFile *f)
>                  chunk = ram_chunk_index(block->local_host_addr,
>                                          (uint8_t *) host_addr);
>                  chunk_start = ram_chunk_start(block, chunk);
> +                if (uadd64_overflow(chunk, reg->chunks, &chunk_sum) ||
> +                    chunk_sum >= block->nb_chunks) {
> +                    error_report("%s: head.chunks contains illegal value"
> +                                 " (chunk=%"PRIu64", chunks=%"PRIu64", "
> +                                 "nb_chunks=%d)", __func__, chunk,
> +                                 reg->chunks, block->nb_chunks);
> +                    goto err;
> +                }
>                  chunk_end = ram_chunk_end(block, chunk + reg->chunks);
>                  /* avoid "-Waddress-of-packed-member" warning */
>                  uint32_t tmp_rkey = 0;

Reviewed-by: Fabiano Rosas <farosas@suse.de>


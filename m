Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0485F606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GdVGuvvM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLQso-0004tt-2O; Mon, 26 Oct 2026 16:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLQsl-0004t5-Es
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 16:01:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLQsh-0006Rw-5d
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 16:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793044877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PHaehCQ0wQ8ZOfxTlnao1Obq6yaB2FFbJG78UTqPOJA=;
 b=GdVGuvvMjZGycjwleEoapIBhFHQHVVr59Mmy4uKU/LPq016wo3b8NsP/NYIi7TGVlv46Ju
 /pRbPae12WrxIVa2Ocu6SnYDiqkB9SO0BoICmGHwv/tRep8Lzu+duuT+J3BFndV8WsqN8H
 OCj02wOSjUgI4trF7la94NfVVka73vs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-7orsXNkVMEqM-3RJwuRLWA-1; Mon,
 26 Oct 2026 16:01:08 -0400
X-MC-Unique: 7orsXNkVMEqM-3RJwuRLWA-1
X-Mimecast-MFC-AGG-ID: 7orsXNkVMEqM-3RJwuRLWA_1793044865
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73A371944DF9; Mon, 26 Oct 2026 20:01:01 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 61E2730002CB; Mon, 26 Oct 2026 20:00:58 +0000 (UTC)
Date: Mon, 26 Oct 2026 16:00:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Klaus Jensen <k.jensen@samsung.com>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
Subject: Re: [PATCH RESEND v3 2/7] dma-helpers: ensure IOV_MAX chunks end
 aligned
Message-ID: <20261026200057.GA629414@shajnocz.csb>
References: <20261026-align-nvme-mdts-with-linux-v3-0-a33bd7c32df9@samsung.com>
 <20261026-align-nvme-mdts-with-linux-v3-2-a33bd7c32df9@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-align-nvme-mdts-with-linux-v3-2-a33bd7c32df9@samsung.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 11:11:10AM +0100, Daniel Gomez wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
> 
> When submitting large IO beyond IOV_MAX, ensure the last dma mapped
> chunk ends on an aligned boundary and unmap the remainder so the next
> chunk submission takes it. Otherwise the discard path at the end of
> dma_blk_cb() drops the unaligned tail and those bytes are lost.
> 
> Reproducer: Write 8 MiB through unaligned path and read it back using
> the aligned path:
> 
> fio --name=demo --filename=/dev/nvme0n1 --rw=write --bs=8M --size=8M \
>     --direct=1 --iomem_align=4 --verify=crc32c
> 
> fio --name=demo --filename=/dev/nvme0n1 --rw=write --bs=8M --size=8M \
>     --direct=1 --verify=crc32c --verify_only
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>  system/dma-helpers.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/system/dma-helpers.c b/system/dma-helpers.c
> index 8ee83ce9e75..9004ad50ae3 100644
> --- a/system/dma-helpers.c
> +++ b/system/dma-helpers.c
> @@ -158,6 +158,17 @@ static void dma_blk_cb(void *opaque, int ret)
>          }
>          if (!mem)
>              break;
> +
> +        /* Ensure the last slot in the chunk ends on an aligned boundary */
> +        if (dbs->iov.niov == IOV_MAX - 1) {

The maximum number of iovec elements depends on the BlockDrivers that
make up this BlockBackend and it might not be IOV_MAX. blk_get_max_iov()
should be used instead of IOV_MAX.

> +            dma_addr_t aligned = QEMU_ALIGN_DOWN(dbs->iov.size + cur_len,
> +                                                 dbs->align);
> +            if (aligned <= dbs->iov.size) {
> +                dma_memory_unmap(dbs->sg->as, mem, cur_len, dbs->dir, 0);
> +                break;
> +          }
> +          cur_len = aligned - dbs->iov.size;

indentation is off here.

> +        }
>          qemu_iovec_add(&dbs->iov, mem, cur_len);

This can add an aligned-down number of bytes that is less than the
number of bytes that was mapped with dma_memory_map(). The next
dma_blk_unmap() invokes dma_memory_unmap() with this aligned-down
number and never unmaps the full original mapping we got from
dma_memory_map().

>          dbs->sg_cur_byte += cur_len;
>          if (dbs->sg_cur_byte == dbs->sg->sg[dbs->sg_cur_index].len) {
> 
> -- 
> 2.56.0
> 
> 



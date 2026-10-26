Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4221606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RCjtg7W5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLR2m-0007Lv-BG; Mon, 26 Oct 2026 16:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLR2i-0007LI-Uk
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 16:11:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLR2h-0007Mi-Kz
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 16:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793045498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OyiZpbxd+Imj+QtnS3zungK8l/llCVRzbb6hEOx9beU=;
 b=RCjtg7W5pdo3yNZcn8OOOf++u3zsI86aeAVjWCHmgbx3NryX9ST/8wt1+3KB7P5BhQwbmA
 dURutX6W4y1LfxGZ7LRi8ZF2Ierxsj2aIF8oOWrXYTNm3cbL9oAPbDLBuE3Q3hK1yfEOzn
 a8OoiP1fj/u8bS2Kw8f3pTwhYDvrCTo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-fH0iL6U_N4CoS_DykJNbaQ-1; Mon,
 26 Oct 2026 16:11:31 -0400
X-MC-Unique: fH0iL6U_N4CoS_DykJNbaQ-1
X-Mimecast-MFC-AGG-ID: fH0iL6U_N4CoS_DykJNbaQ_1793045490
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CE7F1954223; Mon, 26 Oct 2026 20:11:29 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA705195608C; Mon, 26 Oct 2026 20:11:27 +0000 (UTC)
Date: Mon, 26 Oct 2026 16:11:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Klaus Jensen <k.jensen@samsung.com>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
Subject: Re: [PATCH RESEND v3 4/7] dma-helpers: chunk dma_blk_cb at IOV_MAX
Message-ID: <20261026201126.GD629414@shajnocz.csb>
References: <20261026-align-nvme-mdts-with-linux-v3-0-a33bd7c32df9@samsung.com>
 <20261026-align-nvme-mdts-with-linux-v3-4-a33bd7c32df9@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-align-nvme-mdts-with-linux-v3-4-a33bd7c32df9@samsung.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335,
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

On Mon, Oct 26, 2026 at 11:11:12AM +0100, Daniel Gomez wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
> 
> dma_blk_cb() submits dbs->iov to io_func() in one shot, so callers
> must keep dbs->iov.niov below IOV_MAX or the host preadv()/pwritev()
> rejects the call.
> 
> Break the accumulation loop when niov reaches IOV_MAX. The existing
> re-entry path resumes mapping and submits a follow-up chunk under
> the same AIOCB, so callers no longer carry that constraint.
> 
> Suggested-by: Klaus Jensen <k.jensen@samsung.com>
> Acked-by: Jesper Wendel Devantier <foss@defmacro.it>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>  system/dma-helpers.c | 3 +++
>  1 file changed, 3 insertions(+)

What happens when two large writes to the same sector run concurrently?
Before, the result was either write A or write B. Now it's possible to
get an interleaving of write A and B's data. I think this violates block
device semantics and corrupts data. A serialization mechanism is needed
if you want to do this.

> 
> diff --git a/system/dma-helpers.c b/system/dma-helpers.c
> index d4fd33a3d4c..613fa548669 100644
> --- a/system/dma-helpers.c
> +++ b/system/dma-helpers.c
> @@ -175,6 +175,9 @@ static void dma_blk_cb(void *opaque, int ret)
>              dbs->sg_cur_byte = 0;
>              ++dbs->sg_cur_index;
>          }
> +        if (dbs->iov.niov >= IOV_MAX) {
> +            break;
> +        }
>      }
>  
>      if (dbs->iov.size == 0) {
> 
> -- 
> 2.56.0
> 
> 



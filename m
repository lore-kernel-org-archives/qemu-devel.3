Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5F5C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wofHJ-0000lH-72; Tue, 28 Jul 2026 06:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wofHG-0000Zm-Ky
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:43:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wofHB-0008OZ-F4
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785235387;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=0ZA2OufGi6Ts0BtjMEZj6rk3DwlaB1Bs/tYLGSOf6pc=;
 b=b1vgoQ/5B6zrDfpoADOAiaLO3PW8TcC5JVQJgROpa50/BJkg578GaeseEtu2AzhO+NP84F
 p054SRm/tkTg+Us9cfY4Ex5478n1ZfAbR2Zua1I/trLnJZiIsQB3RVIHUIcZQ3fWTZBAUP
 VqEFI5jYUqc1YlNPrULXu4HP3Z1BVRg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-VYWECZGxMC6Am6NdhJER5A-1; Tue,
 28 Jul 2026 06:43:03 -0400
X-MC-Unique: VYWECZGxMC6Am6NdhJER5A-1
X-Mimecast-MFC-AGG-ID: VYWECZGxMC6Am6NdhJER5A_1785235381
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0512180044F; Tue, 28 Jul 2026 10:43:00 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.113])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0AF2C1956086; Tue, 28 Jul 2026 10:42:55 +0000 (UTC)
Date: Tue, 28 Jul 2026 11:42:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Jihe Wang <wangjihe.mail@gmail.com>,
 boy juju <agx1657748706@gmail.com>, contact <contact@xchglabs.com>,
 david korczynski <david@adalogics.com>,
 "Brian Chastain (off_by_one / Curious-Keeper)" <brian@scalingsuccess.io>
Subject: Re: [PATCH v2] hw/nvme: fix cross-namespace copy dif buffer overflow
Message-ID: <amiHrAxsgrk-hTG4@redhat.com>
References: <20260728-fix-cross-ns-pract-v2-1-4641b842836f@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728-fix-cross-ns-pract-v2-1-4641b842836f@samsung.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 28, 2026 at 12:37:57PM +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> The NVMe specification allows a controller with multiple namespaces to
> use different LBA formats per namespace. One implication of this is that
> the destination namespace may have a metadata area for PI, but the
> source does not. In that case, the controller shall generate the
> protection information, but the bounce buffer is erroneously allocated
> without space for that, causing a buffer overflow.
> 
> Fix the allocation.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d522aef88d42 ("hw/nvme: add cross namespace copy support")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3387
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3692
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3841
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3853
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3936
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4031

FWIW, if you see people filing the same bug over & over you can
mark the newer ones as duplicates to stop them cluttering the
issue dashboard

The comment box type

  /duplicate #23423

and submit the comment, with no other text, and it'll close this
bug and link to #23423.

Patches then only need mention the one bug that remains open.

> Reported-by: Jihe Wang <wangjihe.mail@gmail.com>
> Reported-by: boy juju <agx1657748706@gmail.com>
> Reported-by: contact <contact@xchglabs.com>
> Reported-by: david korczynski <david@adalogics.com>
> Reported-by: Brian Chastain (off_by_one / Curious-Keeper) <brian@scalingsuccess.io>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
> Changes in v2:
> - use MAX instead of the tertiary if
> - assert that we don't 
> - Link to v1: https://lore.kernel.org/qemu-devel/20260728-fix-cross-ns-pract-v1-1-20f66766337f@samsung.com
> ---
>  hw/nvme/ctrl.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index a67e1598891c..7f28d2e3eb49 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -3210,7 +3210,7 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
>      uint16_t prinfow = ((copy->control[2] >> 2) & 0xf);
>      uint64_t slba;
>      uint32_t nlb;
> -    size_t len;
> +    size_t len, blen;
>      uint16_t status;
>      uint32_t dnsid = le32_to_cpu(req->cmd.nsid);
>      uint32_t snsid = dnsid;
> @@ -3331,10 +3331,13 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
>      }
>  
>      g_free(iocb->bounce);
> -    iocb->bounce = g_malloc_n(le16_to_cpu(sns->id_ns.mssrl),
> -                              sns->lbasz + sns->lbaf.ms);
> +    assert(g_size_checked_mul(&blen, le16_to_cpu(sns->id_ns.mssrl),
> +                              sns->lbasz + MAX(sns->lbaf.ms, dns->lbaf.ms)));
> +
> +    iocb->bounce = g_malloc(blen);
>  
>      qemu_iovec_reset(&iocb->iov);
> +    assert(len <= blen);
>      qemu_iovec_add(&iocb->iov, iocb->bounce, len);
>  
>      block_acct_start(blk_get_stats(sns->blkconf.blk), &iocb->acct.read, 0,
> 
> ---
> base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95
> change-id: 20260728-fix-cross-ns-pract-6934cc8205f2
> 
> Best regards,
> -- 
> Klaus Jensen <k.jensen@samsung.com>
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



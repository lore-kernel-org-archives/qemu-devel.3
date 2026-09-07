Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619C9C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ZrZ-00013U-Up; Mon, 07 Sep 2026 09:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x3ZrY-000136-Ki
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x3ZrW-0003dA-Sd
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788789496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eZZA+KZeA94FHg0PXloEGzz5CXdo+SMdeb8dMTmmeQM=;
 b=Gf36mPXIoR9c5aLrybIlb+Oa2O+XPSOWqhkizkiTu2cbx3J8cwsv7XAZ178ZWxr/jkLqOy
 hpXK3f+G+FScs4DLtfjHdt6x/v36fLWUr/pJCRk61z3w7FuzkmhRHrYGmRmgzBrSUDt4e1
 seLzBD0YMh6PpSzCre9cm3atSExtTk8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-ePhYPNcUMxyL4LKd_6miVQ-1; Mon, 07 Sep 2026 09:58:12 -0400
X-MC-Unique: ePhYPNcUMxyL4LKd_6miVQ-1
X-Mimecast-MFC-AGG-ID: ePhYPNcUMxyL4LKd_6miVQ_1788789491
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4994aebe932so45980555e9.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 06:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788789491; x=1789394291; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eZZA+KZeA94FHg0PXloEGzz5CXdo+SMdeb8dMTmmeQM=;
 b=DaGCnKxLjqpihyRPulKSLeES+8Qh/UmeNxkf1ILPlPrE9Vrsr6kB1HCDdtj8vNWCkl
 iCPc2a1OgarBRJzi7W25735tUAkCX7UkBXrlMsU5hko06KeZXIszS+T1x9A/mDYwpF9H
 ZyTctriW8kyzquVQn49CO43p/3NyTZlx9bVg7Iiode6xrVx2tKHoyklXPp644gPYVHTt
 KPj3Dfacrb7cvAWuXuvAIUZT41ItjeuuHqmYlojvMB1zLEJxq/eTO7D3KE/xtPAyRrOS
 Xa7bgINpZj8gmeDxNUjBZsMq4zfWlvbX+myW75w815EPv8QnAo5o6ucVmPH3GMZH5QNp
 lnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788789491; x=1789394291;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eZZA+KZeA94FHg0PXloEGzz5CXdo+SMdeb8dMTmmeQM=;
 b=TVL7Cnh64mZH6JwZUmi39C1YgCXiD4jkyzKJJtnwRbUHZZeRy3hPkyrnD/0OWLfBTP
 OniJSAtUhcIkxzweEsT7B3FmytY4pZp5emw6gRHrF/h5HZ1pBOw/F1z31Ny4hBqOBVoI
 9G45TreiGyu8Ndy0AlpYxB6SDC9YsFFDgyp/avcv2++X3XdanwBgDLhpucOf59fA5vBq
 Pxqr1t5dPPGjnikeJeRh4HsuJ5HgrwJ57HLwIMLsd1j/svX0Z+EzmI56lRnhrlHF89/x
 yy5QrmAVcuJ43ssDTHahOXU5Xdz4HEna9YxoCeVyL9prtdFQ8m4rAl45Nk2szP+lyC7a
 or5w==
X-Gm-Message-State: AFuF++kCL3/7wXWn58u6kMKsbIb6eRAAQofQTt3z3LH8nCjWaxBRcu+g
 QdynicNqXpksxQ/ILVuypx8VlXOqyY3b01pphrErSlXGI63k4oh2sZm9vCdikIGDxVZZeX1atAn
 c3FQ/miYrWQ98aAdPrLCP/tXv0YR8Mf1wc5FNj8eCmJZgLWyvjrdmJ/Le
X-Gm-Gg: AYBFou0k8RbVrttWXRe3mt45ploQov/NPruZn0Ncm7FCaOmz1srQl0o7RKd1vcQoiQQ
 eqa7R8quo4lhe0MvRupLMYjU5/ksF+gGWtlB0xPJ2RKlTW3/o3XIKVR1/QXpBsqJVE5N5M2Z5SX
 PMStdt6UnUsC3IYUHdszrSbr+mDNmrTedoOwxpY9Wcj2s/5PHNKPJ7U0O0TfhI8BwRTXV5A7WbD
 Yoq2kNyjKmLUFmplU008EvcoOoNjoulHT1WTk7mx7M/Icbbzqs2wwIFy4mbNSIzU6rtMiy+Wji5
 gMgqwLszsvePpje/Cx8nKY9HYi2ACZqu4StWQIfFDlv7Btacj6kaF5e0UijZPUKuLTgUaZt1dO/
 f88vjCCdrju5jgVeAqleFyCY2iRfVawpXbC20IJlc8nR4vw==
X-Received: by 2002:a05:600c:1990:b0:49c:f512:2361 with SMTP id
 5b1f17b1804b1-49cf82524a2mr342861975e9.14.1788789491444; 
 Mon, 07 Sep 2026 06:58:11 -0700 (PDT)
X-Received: by 2002:a05:600c:1990:b0:49c:f512:2361 with SMTP id
 5b1f17b1804b1-49cf82524a2mr342861355e9.14.1788789491019; 
 Mon, 07 Sep 2026 06:58:11 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee6158e9sm398706535e9.12.2026.09.07.06.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:58:10 -0700 (PDT)
Date: Mon, 7 Sep 2026 15:58:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de, 
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
Subject: Re: [PATCH v4 02/10] vhost: add vhost_reset_owner op
Message-ID: <ap6p_XeJ9NAXpuPn@sgarzare-redhat>
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
 <20260820113955.509478-3-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260820113955.509478-3-andrey.drobyshev@virtuozzo.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 20, 2026 at 02:39:47PM +0300, Andrey Drobyshev wrote:
>Add a VhostOps callback issuing VHOST_RESET_OWNER, wired up for the kernel
>backend.  The CPR (checkpoint-restore) path uses it to release device
>ownership on the source so the destination can reclaim it later with
>VHOST_SET_OWNER.
>
>Originally-by: Mark Kanda <mark.kanda@oracle.com>
>Originally-by: Steve Sistare <steven.sistare@oracle.com>
>Originally-by: Ben Chaney <bchaney@akamai.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost-kernel.c          | 6 ++++++
> include/hw/virtio/vhost-backend.h | 1 +
> 2 files changed, 7 insertions(+)
>
>diff --git a/hw/virtio/vhost-kernel.c b/hw/virtio/vhost-kernel.c
>index 3390b48c6f1..55d316b88e9 100644
>--- a/hw/virtio/vhost-kernel.c
>+++ b/hw/virtio/vhost-kernel.c
>@@ -261,6 +261,11 @@ static int vhost_kernel_set_owner(struct vhost_dev *dev)
>     return vhost_kernel_call(dev, VHOST_SET_OWNER, NULL);
> }
>
>+static int vhost_kernel_reset_owner(struct vhost_dev *dev)
>+{
>+    return vhost_kernel_call(dev, VHOST_RESET_OWNER, NULL);
>+}
>+
> static int vhost_kernel_get_vq_index(struct vhost_dev *dev, int idx)
> {
>     assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
>@@ -385,6 +390,7 @@ const VhostOps kernel_ops = {
>         .vhost_get_features_ex = vhost_kernel_get_features,
>         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
>         .vhost_set_owner = vhost_kernel_set_owner,
>+        .vhost_reset_owner = vhost_kernel_reset_owner,
>         .vhost_get_vq_index = vhost_kernel_get_vq_index,
>         .vhost_vsock_set_guest_cid = vhost_kernel_vsock_set_guest_cid,
>         .vhost_vsock_set_running = vhost_kernel_vsock_set_running,
>diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
>index d878d7b733a..6c949e6a38d 100644
>--- a/include/hw/virtio/vhost-backend.h
>+++ b/include/hw/virtio/vhost-backend.h
>@@ -204,6 +204,7 @@ typedef struct VhostOps {
>     vhost_get_features_op vhost_get_features;
>     vhost_set_backend_cap_op vhost_set_backend_cap;
>     vhost_set_owner_op vhost_set_owner;
>+    vhost_set_owner_op vhost_reset_owner;

Should we introduce `vhost_reset_owner_op` ?

Stefano

>     vhost_reset_device_op vhost_reset_device;
>     vhost_get_vq_index_op vhost_get_vq_index;
>     vhost_set_vring_enable_op vhost_set_vring_enable;
>-- 
>2.47.1
>



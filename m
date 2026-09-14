Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9E8C88E70
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6778-0008Jd-4Z; Mon, 14 Sep 2026 09:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x6774-0008JH-Jq
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 09:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x6772-0008Eg-GM
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 09:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789393966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G6J0f4KsxoGeRI5A8fzIdxQdFH23+wrPMOQiEiffT7s=;
 b=gSuzt/lIATJOe4+EugrqMzR/Qxh3KGfhN7ITfue3WACXuDpnRiYzh+VG1dr5BXbqsTMirb
 6OmU5WjTETp+iwAw5PoIKtliqfbwwsx5tOIFMBRdsakFGMMwYH3GIojU2d82Bye4Q2gei0
 I3O+g7NfOO5mWLxOX610bcskU3CSdIw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-9mIkZ1WLOr2Eij3fd9fxhg-1; Mon, 14 Sep 2026 09:52:43 -0400
X-MC-Unique: 9mIkZ1WLOr2Eij3fd9fxhg-1
X-Mimecast-MFC-AGG-ID: 9mIkZ1WLOr2Eij3fd9fxhg_1789393962
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-486f3dbf7d2so2031271f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 06:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789393962; x=1789998762; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G6J0f4KsxoGeRI5A8fzIdxQdFH23+wrPMOQiEiffT7s=;
 b=gtQMp+JAuvZ8inLiSORk9CAhl1fhSej67CkfX3tMlzA9XVnDqpVoRXxVkbd0dQZgVY
 rB1LKbnt0aFqJDpKwOEPIUoiW7CLnhyLtXhIHp0WikCbFyOaBMIQDS+Q7vuLS8tCA5F7
 WY5q9dIC+ZkHFmQkWAhwwQ+f++yp8Gqb0MVO3vwiMKU21FwJU9Mb6mcuNh3e09hA8vX4
 vzDOHiFg5uDi2yp/xS8M2nUi4KjjU/8zWG6Cft6pDCpIAWNI9DakjiKlsIwXhqQvlOoQ
 3nEDASQ4MCZuqyeDdxBE4tf2XPsB8uP7l9oaDJ53eSazXsUPIF+FPilfn4YH5tRjSGt5
 NR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789393962; x=1789998762;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G6J0f4KsxoGeRI5A8fzIdxQdFH23+wrPMOQiEiffT7s=;
 b=IdUAGrKLK1zoPTbajeCHerHTDyqysSjCFStjRqZg+JoIQpmwivs1H/EsDzVul4P30u
 8uw/HDilJDv9qADbvRlMvxuAduHSeSSYdBMzVvPVk/5mI5ESdBX9m4fJ5ZC2fpfzBdhV
 C7G4FUQP/0xjpruDcgxNvc9XAeFG1RTdgp711PP5bN490YrZPhB406Tmiyy77n+FAya1
 zJyZZMSzKsnEQZwVSDptiKTTXiJd3rZPetLQVbPHTz2daGC4y8wjzxUxFDsA86KnBSkh
 B5+sG1OIYIMWu0hjlESF8WV9E9Yf9EUpFQjGnlCEHFmdRRznf2AMiuKoNSLFHaMWEycJ
 079Q==
X-Gm-Message-State: AFuF++kFDVXguxbJKjqcfZ2P6OpPx7CigmcqrI+wt0iLE/N7VzEfRjMM
 LDM3KylXPZTxXxQ6QW+ZZ+TWbFkVGMnnYmSE9MRqdyD+M+vL0ZOTLICgzZQtBv0XaLWYFANCBLh
 blLxTpCC4UBAKarl2FZy29599C0zwsHpmkcRNonWxB0tSpdr+0USlJhaH
X-Gm-Gg: AYBFou1n5KR8Rbhul3oL/4x/9Am8kCW0ECo7g+ElHs+1TxOV/dJfU22ieEt1CZbNmqX
 Fj3ApTI8EbTqpf8p9NB9eZIjFsh2373usWsZMYSYQLOCTY7sE9qk2MmjVDoeTyGOSQyZDwU5kUi
 C9cuZV65AfZrKEkQ2WXIfL4uTcvP7J4JhmwSJv+ZtrvTBqss+YtNwPqTW0TbP8EFvuYvHqLD7OZ
 AHKOeFBW4o9kbIeya6tGL/5uleTzePaf1iWxh8gZZ0zz/f6PW8kgtHxygnbEiM7PH4yiHSBrzmC
 /v+bJ/ew96tKH3bHtiWRfLC/LCaKNzH8unN0Zh2Jg9CVEv2h8fEPfaJ08trB3k1i99J3t5Mpv/G
 2HUuu2onmq3zsVR2rtHc7byFkc8GmEN+1e80/CR+rbMy/OQ==
X-Received: by 2002:a05:6000:714:b0:486:f9a0:c3c1 with SMTP id
 ffacd0b85a97d-48702ad29a1mr3616771f8f.25.1789393961955; 
 Mon, 14 Sep 2026 06:52:41 -0700 (PDT)
X-Received: by 2002:a05:6000:714:b0:486:f9a0:c3c1 with SMTP id
 ffacd0b85a97d-48702ad29a1mr3616708f8f.25.1789393961347; 
 Mon, 14 Sep 2026 06:52:41 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e81asm28593645f8f.7.2026.09.14.06.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 06:52:40 -0700 (PDT)
Date: Mon, 14 Sep 2026 15:52:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org, 
 farosas@suse.de, peterx@redhat.com, clg@redhat.com, dongli.zhang@oracle.com
Subject: Re: [PATCH v5 06/14] vhost: add vhost_reset_owner op
Message-ID: <aqf8DPjdqdEKOwBL@sgarzare-redhat>
References: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
 <20260914-up-vsock-vhost-v5-v5-6-d17423589f48@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260914-up-vsock-vhost-v5-v5-6-d17423589f48@virtuozzo.com>
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

On Mon, Sep 14, 2026 at 11:37:37AM +0300, Andrey Drobyshev wrote:
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
> include/hw/virtio/vhost-backend.h | 2 ++
> 2 files changed, 8 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

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
>index d878d7b733a..a8ec35f6263 100644
>--- a/include/hw/virtio/vhost-backend.h
>+++ b/include/hw/virtio/vhost-backend.h
>@@ -104,6 +104,7 @@ typedef int (*vhost_get_features_op)(struct vhost_dev *dev,
>                                      uint64_t *features);
> typedef int (*vhost_set_backend_cap_op)(struct vhost_dev *dev);
> typedef int (*vhost_set_owner_op)(struct vhost_dev *dev);
>+typedef int (*vhost_reset_owner_op)(struct vhost_dev *dev);
> typedef int (*vhost_reset_device_op)(struct vhost_dev *dev);
> typedef int (*vhost_get_vq_index_op)(struct vhost_dev *dev, int idx);
> typedef int (*vhost_set_vring_enable_op)(struct vhost_dev *dev,
>@@ -204,6 +205,7 @@ typedef struct VhostOps {
>     vhost_get_features_op vhost_get_features;
>     vhost_set_backend_cap_op vhost_set_backend_cap;
>     vhost_set_owner_op vhost_set_owner;
>+    vhost_reset_owner_op vhost_reset_owner;
>     vhost_reset_device_op vhost_reset_device;
>     vhost_get_vq_index_op vhost_get_vq_index;
>     vhost_set_vring_enable_op vhost_set_vring_enable;
>
>-- 
>2.47.1
>



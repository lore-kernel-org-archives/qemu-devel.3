Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137A2C79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3am2-0003MC-VH; Mon, 07 Sep 2026 10:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x3alz-0003Jj-F8
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x3alx-0001lt-Tr
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788792997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ppmhWMRYRmBZPsREk8WToBNLqO3ON5K8Ok5Q7AMfxII=;
 b=MobR0q12Y1M9PCbpgGO0BSuwek0Z/VBwEw6KnMa1tFgapPAq0WkfLDQ9yKyF6MYRHvkgmj
 lTKsFfClZutMFidhinGGYSlYY03Zodtwomf5PND68Q6LWZzhqnAdD5tMTP538LheXu0jXG
 wFL8deG0gAyJhlBFmWJdcFO4Z+ZTzFc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-0hYWLwlcPByZYzMM1NhX9w-1; Mon, 07 Sep 2026 10:56:36 -0400
X-MC-Unique: 0hYWLwlcPByZYzMM1NhX9w-1
X-Mimecast-MFC-AGG-ID: 0hYWLwlcPByZYzMM1NhX9w_1788792995
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48436db95e1so2521304f8f.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 07:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788792995; x=1789397795; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ppmhWMRYRmBZPsREk8WToBNLqO3ON5K8Ok5Q7AMfxII=;
 b=VHHuXKGNLanrNg+8FmayouONM1WNAYqyiSmZGBZVGkYWziWX8PTzPMYTR6c2DPlef9
 V9wSPMFUFSBH9sN3pD9SPeaBGQyKtE8tKaFbDYRpj7KNB4GZfYB18vanbEVGNd7y6tqJ
 DwJ06feqXApgertjgLmKPA1KWUoHi2iTvlCAX0whyhBwkPVuOCSOiG9WOo2SfCNha3bC
 H53tB9MOx7Thy22HzbV7Aczkk/+ggjpcN4UOy9dPGE8umUt81Ij30b2rM+j4ORit6gCw
 +4mR1+8tjgAVTZY8bH5mGcthTi+WkWVgxcCqd2v+ZU7eDzlCHfkHovroa5W+kRYWp7iF
 Ljvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788792995; x=1789397795;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ppmhWMRYRmBZPsREk8WToBNLqO3ON5K8Ok5Q7AMfxII=;
 b=HPJXx73oDqO2TZyPbTXmcz+JB1mIsiXkAfV0LzPVvPvHW4gNth/ZEXRSMYTp/bothc
 SgoaoMBwNLbLjypcRyVvn/87p247uicVps+uEw5PH6Wwd4dVWWptXFc9b4NttTEtQmFX
 blzUQ0T3+6Kz2TBAkNLvG3Ckz5WOEijgXVStOpS6z8/KzPdrboLKxrF9AzcXuISpAf9j
 gM5LwXE0uDY+iPRky0duTWefEPurqNBVAjobuo2tvTDt8E0VtrwvDz4g+zWsF3S/gDQ+
 opPxURydQK78Sr2BAetyD7BtMpEu6mfnBkuMzLdCgiKUIMjTOz1RTi+KX5GQ0QcQiJEQ
 Otng==
X-Gm-Message-State: AFuF++nma7zyDWeclY4OlufgyITY6IyXCUzQcoQ6/2w80HRzKA8G+20C
 itCHbbLmqE5m1fSVRX/hTHk7ND5gVOfkDI11aHt87q/6RUo/jvPHl7OvgaQr3ahD+ro6kgz4Ll6
 iAttmntrzXeD4FnSjnIn19XNQrGqb6VOVLgixeBp5cyx7Ucq60RkInHHoC0NMf3Nb
X-Gm-Gg: AYBFou3voilacZMhTRsybv58K9xJrAxqffcE1kjeNazW8XotlqyAJKeWYwwZso02Cpv
 WtxOmZW5Bt08tzvjh7/0ZSmT9TqYnP5div1Z9FdYr7Ej0U5uEhzag8YHQZNI6oTGjIEZZgDrIdY
 x+/TpihIrhiW+zBSVO9Ansh+Tyg/qB9EKten2mbVvbZSd3qXRWmV/RlY61jkTht85vT5J7gzMeX
 6vh4aWmsJJmvheMoZhe+wxNMn2TqZ6V6wYzukoA3Me1IlVVRXcrtddouTFPIX735Vh4r6XxyB90
 X6n6i/0pd1/uezbWmdXp6ViCy6gJlN4+Ev2jXcBAp2sEgD2SRx/Avp3oROuphHB6LBisujpeDp4
 9tV6vgsw6YbpZpMXGHYsbOGQpAvtPv11hnBFF9knE78/CAw==
X-Received: by 2002:a05:6000:4694:b0:482:ee81:f0ca with SMTP id
 ffacd0b85a97d-485872a56e6mr20700560f8f.12.1788792994824; 
 Mon, 07 Sep 2026 07:56:34 -0700 (PDT)
X-Received: by 2002:a05:6000:4694:b0:482:ee81:f0ca with SMTP id
 ffacd0b85a97d-485872a56e6mr20700520f8f.12.1788792994278; 
 Mon, 07 Sep 2026 07:56:34 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588392b3esm33461244f8f.12.2026.09.07.07.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 07:56:33 -0700 (PDT)
Date: Mon, 7 Sep 2026 16:56:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de, 
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
Subject: Re: [PATCH v4 08/10] vhost: add vhost_dev_set_owner() /
 vhost_dev_reset_owner() helpers
Message-ID: <ap7I31Lch-pyql9J@sgarzare-redhat>
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
 <20260820113955.509478-9-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260820113955.509478-9-andrey.drobyshev@virtuozzo.com>
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

On Thu, Aug 20, 2026 at 02:39:53PM +0300, Andrey Drobyshev wrote:
>Wrap the set_owner/reset_owner backend ops in dev-level helpers, matching
>other vhost_dev_* wrappers, so device code can take or release ownership
>without reaching into vhost_ops directly.  vhost_dev_init() now uses
>vhost_dev_set_owner(). Both return -ENOSYS if the backend has no such op.
>
>No functional change.  These are used by the following vhost-vsock patch to
>hand a device between owners during CPR.
>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost.c         | 20 +++++++++++++++++++-
> include/hw/virtio/vhost.h | 13 +++++++++++++
> 2 files changed, 32 insertions(+), 1 deletion(-)
>
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index 2bb9a23fee4..ea17bf01080 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -1690,6 +1690,24 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
>     return 0;
> }
>
>+int vhost_dev_set_owner(struct vhost_dev *hdev)
>+{
>+    assert(hdev->vhost_ops);
>+    if (!hdev->vhost_ops->vhost_set_owner) {
>+        return -ENOSYS;
>+    }
>+    return hdev->vhost_ops->vhost_set_owner(hdev);
>+}
>+
>+int vhost_dev_reset_owner(struct vhost_dev *hdev)
>+{
>+    assert(hdev->vhost_ops);
>+    if (!hdev->vhost_ops->vhost_reset_owner) {
>+        return -ENOSYS;
>+    }
>+    return hdev->vhost_ops->vhost_reset_owner(hdev);
>+}
>+
> int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>                    VhostBackendType backend_type, uint32_t busyloop_timeout,
>                    Error **errp)
>@@ -1707,7 +1725,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>         goto fail;
>     }
>
>-    r = hdev->vhost_ops->vhost_set_owner(hdev);
>+    r = vhost_dev_set_owner(hdev);
>     if (r < 0) {
>         error_setg_errno(errp, -r, "vhost_set_owner failed");
>         goto fail;
>diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>index 9b98d34dd04..44e65968d9b 100644
>--- a/include/hw/virtio/vhost.h
>+++ b/include/hw/virtio/vhost.h
>@@ -178,6 +178,19 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
> int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
>                            VhostBackendType backend_type, Error **errp);
>
>+/**
>+ * vhost_dev_set_owner() / vhost_dev_reset_owner() - take / release ownership

I'm not sure this is a common practice in kernel-doc format.
I think we should add 2 differnt blocks, one for each function.

Stefano

>+ * @hdev: the common vhost_dev structure
>+ *
>+ * Take (VHOST_SET_OWNER) or release (VHOST_RESET_OWNER) ownership of a
>+ * device that has already been set up.  Used to hand a device over during
>+ * CPR.  Returns -ENOSYS if the backend has no such op.
>+ *
>+ * Return: 0 on success, negative errno on failure.
>+ */
>+int vhost_dev_set_owner(struct vhost_dev *hdev);
>+int vhost_dev_reset_owner(struct vhost_dev *hdev);
>+
> /**
>  * vhost_dev_cleanup() - tear down and cleanup vhost interface
>  * @hdev: the common vhost_dev structure
>-- 
>2.47.1
>



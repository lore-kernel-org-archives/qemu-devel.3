Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E6BEE3691
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvP-0005vH-De; Thu, 12 Feb 2026 09:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXuz-0005O9-Qe
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXut-00066i-Ib
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gplk9ekMQ9pSZ/sJ6RCmeWHrM9FXdUM1xTfytnwRqZ8=;
 b=BZ2cQNcdis3rpT4vCX4waF9g2qZ7vxuFMH19MP6tpsz0kJwdQCbomXHkt5UFneKdE/Mr1z
 3H9yYXGTmGcAN0+CnwqhkF2Q3srge2yeEMgW8YjuahM7Nem0ErWSi20TS0OAstzQVjZYtO
 BPpRw684B2Zd7d8Ra8Fv7qCf+QTZAsI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-Pxu2k--PMq-Y-gOWA4lu_w-1; Thu, 12 Feb 2026 09:43:34 -0500
X-MC-Unique: Pxu2k--PMq-Y-gOWA4lu_w-1
X-Mimecast-MFC-AGG-ID: Pxu2k--PMq-Y-gOWA4lu_w_1770907413
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4803b4e3b9eso64142985e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907412; x=1771512212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gplk9ekMQ9pSZ/sJ6RCmeWHrM9FXdUM1xTfytnwRqZ8=;
 b=Q2s+LHIJCmp/9RCIvt21ifZ9QTUuETw1SxsW707pg2KqBruqjaFZs7sZU/1SqekfkK
 qTMnEl6oWixW++a0GTjmWnlbFQEDJNQY0UvBPbIst8ZC4Dz2ff4Qw+9RK2/14XHIOOFf
 /gdrHacBXirzdqvP28EFh2XOGzZvrYWU5kaTtZN3Olhgloj9Z3KXXtJeL8bna56fnQuT
 229KjVf3oo+ZFE151dVe4d+bbXsfh/7UsmGnCm+1R5MwZd5QGFrY8xcu8g99Z97OxLt+
 a8eBWT5Hlm6k5AyUCkQEdR5m7wL3JAxdFT9Gi+0pZvMufvqz9SuwOk2mE+0RrNoFjg4D
 B9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907412; x=1771512212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gplk9ekMQ9pSZ/sJ6RCmeWHrM9FXdUM1xTfytnwRqZ8=;
 b=XPWysOfKrNmBzb/yPXw4JvxS3HjS2VNWeDKzrG9j0ZiFEEHRv4Q1nyY7BzhbnkfYGk
 Me5eDidfqaq1og0eGu7NZrLcFeiTouH6DA8qec/JJbqUE8iCXOI5G3PzcmUAVk3Wc6Jt
 GlaHke8HezYsHw4sY9SKA0xTEx4wxniVTB0SUdgK+MPcQUGgL8LRgRSHf760KQd8FXkM
 XklSe74+9hLuk2u+DteMHj3tAUKaE52jWf8QEVoLKA8obkKx7tHO98t7X0aK3vnOK9vA
 vBUeo1i9QedWH8BDsTqYik/dWcVNdcNQe0zwXyutECkeVXIOE9cQvSsANIM2rH+kCBIb
 jgBA==
X-Gm-Message-State: AOJu0Yx0lqCk4bsU+/tqYsEN6Iv7UVm3nfK5J6ipCtCbknWIhqSpO4fI
 cwDoVeunoMGulHn98NgFKmB5mWkrSJecnFaV25M2LArJqpsYBtetcCIsjsFJOyUN9n1GBWpTitB
 oX348NnRNm/pG34h8YcvYM4GGOoGdCLq4o7xkLywSbgmiYQGlS9UbbgpVEUvBzfRgob+Htk9yjU
 QVZ+JMzOIUZEcm2KH+t1tnI39FlE+6UkTdlgeZHUkO
X-Gm-Gg: AZuq6aImjtPDai2U60xRazKm+WczS3dG6jHa3PStP7RpSp+OZaJp2Dt+FN+0yZiIim7
 HRiWP8KCs6ElxiEjCVSXled2RUX8yOzHz5c8P00nQbKc9ttG0nZn+4EMFBbUZmWT0rCgafbkJoa
 3ylL/OIs1EiP/wRLRWCnXoHChCiIwTe4b3G6UrqDw0YBTXVxKzG/My/QV1OGs3uQnlaalXs4mfP
 +J9F5qCK//DlVT4YQ0IqL3pfuBZXFrQCS31jodZbutdp0Xe9wQShniYe4ZtGF6QAgZmrk3yp2C7
 kc1l9YZ+S9MItK+269qS+U28btZ2+AeUzP+etGNkohX9Mze9ShAp9SY07cnLtsG3JumJKLEIpb/
 pNdGByBA0hIKEwGJ+z05lcnzrnjsXjM8TtxkEom1E7Txz1OyWrQTpkV00CARXj/JrtjlZyw2KDt
 szQTwk3QWa2154WdEOqk/3C2LJbisJj3QroueXhUBfBa3CyuNpP7w=
X-Received: by 2002:a05:600c:3512:b0:477:7ae0:cd6e with SMTP id
 5b1f17b1804b1-483656ae17amr44335095e9.5.1770907412053; 
 Thu, 12 Feb 2026 06:43:32 -0800 (PST)
X-Received: by 2002:a05:600c:3512:b0:477:7ae0:cd6e with SMTP id
 5b1f17b1804b1-483656ae17amr44334415e9.5.1770907411472; 
 Thu, 12 Feb 2026 06:43:31 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835a64674esm70564035e9.3.2026.02.12.06.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:43:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 20/41] hw/virtio/virtio-mmio: Remove
 VirtIOMMIOProxy::format_transport_address field
Date: Thu, 12 Feb 2026 15:42:22 +0100
Message-ID: <20260212144244.22579-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The VirtIOMMIOProxy::format_transport_address boolean was only set
in the hw_compat_2_6[] array, via the 'format_transport_address=off'
property. We removed all machines using that array, lets remove
that property, simplifying virtio_mmio_bus_get_dev_path().

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260108033051.777361-20-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/virtio/virtio-mmio.h |  1 -
 hw/virtio/virtio-mmio.c         | 15 ---------------
 2 files changed, 16 deletions(-)

diff --git a/include/hw/virtio/virtio-mmio.h b/include/hw/virtio/virtio-mmio.h
index 1eab3c0dece..1644d098105 100644
--- a/include/hw/virtio/virtio-mmio.h
+++ b/include/hw/virtio/virtio-mmio.h
@@ -66,7 +66,6 @@ struct VirtIOMMIOProxy {
     uint32_t guest_page_shift;
     /* virtio-bus */
     VirtioBusState bus;
-    bool format_transport_address;
     /* Fields only used for non-legacy (v2) devices */
     uint32_t guest_features[2];
     VirtIOMMIOQueue vqs[VIRTIO_QUEUE_MAX];
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 0b0412b22f2..742ca3d3e4d 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -764,8 +764,6 @@ static void virtio_mmio_pre_plugged(DeviceState *d, Error **errp)
 /* virtio-mmio device */
 
 static const Property virtio_mmio_properties[] = {
-    DEFINE_PROP_BOOL("format_transport_address", VirtIOMMIOProxy,
-                     format_transport_address, true),
     DEFINE_PROP_BOOL("force-legacy", VirtIOMMIOProxy, legacy, true),
     DEFINE_PROP_BIT("ioeventfd", VirtIOMMIOProxy, flags,
                     VIRTIO_IOMMIO_FLAG_USE_IOEVENTFD_BIT, true),
@@ -827,19 +825,6 @@ static char *virtio_mmio_bus_get_dev_path(DeviceState *dev)
     virtio_mmio_proxy = VIRTIO_MMIO(virtio_mmio_bus->parent);
     proxy_path = qdev_get_dev_path(DEVICE(virtio_mmio_proxy));
 
-    /*
-     * If @format_transport_address is false, then we just perform the same as
-     * virtio_bus_get_dev_path(): we delegate the address formatting for the
-     * device on the virtio-mmio bus to the bus that the virtio-mmio proxy
-     * (i.e., the device that implements the virtio-mmio bus) resides on. In
-     * this case the base address of the virtio-mmio transport will be
-     * invisible.
-     */
-    if (!virtio_mmio_proxy->format_transport_address) {
-        return proxy_path;
-    }
-
-    /* Otherwise, we append the base address of the transport. */
     section = memory_region_find(&virtio_mmio_proxy->iomem, 0, 0x200);
     assert(section.mr);
 
-- 
2.52.0



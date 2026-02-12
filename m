Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1579EEE3691
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvS-0005yp-MW; Thu, 12 Feb 2026 09:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXv8-0005VB-9A
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXv6-0006CR-HQ
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+kngmgvEBoYtSag4vTJFF8aM743+lT79utmLBi9cYQA=;
 b=apg5tju1p/9Mu8/8LW+H8cjLo8utkTpxCGdkZiiroiB/8rGCkmxMM9REmBoxdn/LprO6YY
 caPGxCi59colw/oKuyoXwBYAqKj+NNbhJi5GEE2NT1bgr01bWtvIFaFTeoZchE4b26ztOX
 hFsYnxTOapYjT6Qso7Uruherd+1NLzU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375--Bu183f8NY60BoDVSbq0WA-1; Thu, 12 Feb 2026 09:43:50 -0500
X-MC-Unique: -Bu183f8NY60BoDVSbq0WA-1
X-Mimecast-MFC-AGG-ID: -Bu183f8NY60BoDVSbq0WA_1770907429
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4804157a3c9so57189765e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907428; x=1771512228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kngmgvEBoYtSag4vTJFF8aM743+lT79utmLBi9cYQA=;
 b=RbQ81Yz1aBAiKextZDeeFn1k8+26g4fJF8asE66Pc2u6+Mjs/yl/wml1+Bp0l0Exoi
 AxOk1a/tj7oCcxFN0TEBZfD3SqbvoO/y41TQHY1dCTIb8ZPX94965RrcRT+0OR8K5fsq
 HeRvYg4vEgpxXBmkfQOBBSJTPCyuHCv4F1vPB9R+vnOgPQet0EHP7kbCg2KE7yM3E7Ac
 SlbpR/AlEzJwUijfaFPXCTYKbtf4X0TTnipUwFfP0aekjcS05P5ijsxiUEgjdSGTbEvv
 dk9uJRuRtzKzzf87cOVyohivbV3gT9Pc+qo34QwsxWNFDMW6CHner1PeY2c/+HQErxbA
 Fs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907428; x=1771512228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+kngmgvEBoYtSag4vTJFF8aM743+lT79utmLBi9cYQA=;
 b=EJwITgy2eyygk0z1/hkuRfGnnIRHZfZM3Nxube7sKlSkMUzqr72t8WOezJzN+MC0Bc
 H8rSasLxqh2Sr9NZXeH/Kd3CB+rwPL4dsLU2eOx4yh/Eo/qa23ugsaBnYvbguE339dvD
 X8wNJRRUwEknTXoq3Hyt3Qjfoh4lZHslA0+4k5kvQwbl9lYG4A1aJxX+f0t4nlkMSvsA
 dhg/0UKQmQ88d3MjFGDbtq8UIiqepsnooK0HWNRimX3gxbmzqtXwTFAxDNSaTuvqru7W
 P4MQBIsMRLXqFRpGXj1UmVMm6aiUKIL4lNQf0fmJ0wKi3P/hz9O5pqUvg/VwO9OYwCwY
 JG+w==
X-Gm-Message-State: AOJu0YyOsDL1ghe8fw7vwlNCVajRUeRyMLb/pijWfEBzo35XGz5UTgo5
 4Hf79dpXh2xkzdYb0qQKh4Fwu7KkYSG9Vsrfib5223vE85LObFfkZdriZRGRfjjKotBa/tLtlIk
 Y+w0B0RPoRWRb0PztgZNDWU5GIxvjDwcd+kLdxgb3u7w6Yj/sXV6SfawEBeZWMUdx9pwYGh9Wrb
 K5Wj5OY55F0rEtZ9EnwOELls5aAV+vViIOMNL08raP
X-Gm-Gg: AZuq6aKINjEpekAqI6tSD+Wa0o6pvHSmuiESFXwp5xrXNW78aYFeanMnaTxTirCU8pE
 pJX1ux7DQp3eLaMLu4UvOFe1uETMY/JfgTLgIxAWyMbQBLAh4es22vwxn+/5HX163hAvDMfW/b8
 cm0H9sVciHWHmCxNigci1dB2H1a2KXR8uH9zxjAYQ/zHTjudGc/iWSTXyfrv/R57ni9tJLOHl4o
 yAH1YII8S3OC0lcNMiu4RrHtcmdl3hU15hm9NJEDf9bG8WkHgVJWBxTYAROEri3FmZuoJ5g+tJK
 r1rix0aJk1dmBGFkBQdWznge+OoLytjHjxzWKn/K2trC/TjSUuN3xsub2RQEbeH1yWTpvDYbY/r
 vC7Je4HNh470+RMnwJjE2HjIU2xOKfkuMfMRs0GBgjgrDMYoG4jqoWrqFw/3ZXs3jfUd2TfQvkH
 PFd7IR027GTLtBE3z5xyLlxHzwHu9EA9C0aqh0uJL3bAEIhNRYrvM=
X-Received: by 2002:a05:600c:8b2f:b0:47e:e48b:506d with SMTP id
 5b1f17b1804b1-483656da45cmr49457505e9.16.1770907427603; 
 Thu, 12 Feb 2026 06:43:47 -0800 (PST)
X-Received: by 2002:a05:600c:8b2f:b0:47e:e48b:506d with SMTP id
 5b1f17b1804b1-483656da45cmr49456565e9.16.1770907426867; 
 Thu, 12 Feb 2026 06:43:46 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e5c550sm13671917f8f.36.2026.02.12.06.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:43:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 27/41] hw/virtio/virtio-pci: Remove
 VirtIOPCIProxy::ignore_backend_features field
Date: Thu, 12 Feb 2026 15:42:29 +0100
Message-ID: <20260212144244.22579-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The VirtIOPCIProxy::ignore_backend_features boolean was only set
in the hw_compat_2_7[] array, via the 'x-ignore-backend-features=on'
property. We removed all machines using that array, lets remove
that property, simplify by only using the default version.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260108033051.777361-27-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/virtio/virtio-pci.h | 1 -
 hw/virtio/virtio-pci.c         | 5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 639752977ee..581bb830b79 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -150,7 +150,6 @@ struct VirtIOPCIProxy {
     uint16_t last_pcie_cap_offset;
     uint32_t flags;
     bool disable_modern;
-    bool ignore_backend_features;
     OnOffAuto disable_legacy;
     /* Transitional device id */
     uint16_t trans_devid;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 1e8f90df34e..fe13a7a9503 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2040,8 +2040,7 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
      * Virtio capabilities present without
      * VIRTIO_F_VERSION_1 confuses guests
      */
-    if (!proxy->ignore_backend_features &&
-            !virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
+    if (!virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
         virtio_pci_disable_modern(proxy);
 
         if (!legacy) {
@@ -2443,8 +2442,6 @@ static const Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT, false),
     DEFINE_PROP_BIT("page-per-vq", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT, false),
-    DEFINE_PROP_BOOL("x-ignore-backend-features", VirtIOPCIProxy,
-                     ignore_backend_features, false),
     DEFINE_PROP_BIT("ats", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_ATS_BIT, false),
     DEFINE_PROP_BIT("x-ats-page-aligned", VirtIOPCIProxy, flags,
-- 
2.52.0



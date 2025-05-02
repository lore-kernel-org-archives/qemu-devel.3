Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8072C3ABB0
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 19:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAvbb-00014E-V8; Fri, 02 May 2025 14:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvao-00079b-9B
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:58:38 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAval-0005go-E3
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:58:37 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e5deb6482cso6238450a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 11:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746212313; x=1746817113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OvirrR3TiqgBPme4BwNGSV4VqzG47GBw5DwB3TzFavY=;
 b=afZqr4MI3noG/qSTyUTCbppF3OXeyj01ByXbyxvhFCFT6XKWo2+q0XnaI+VMonWfFV
 JbeNsKCMWRhtPLc2OU4TgY14d5ra0hGMkVPGdB+mgvyFUhlx+0+l5cLLB4SV9XtouMCh
 lt7j+aX7KOiMyGGTCnS/l5ApkqOAqgc4MsrAIxi4zsnrbHkOnQBPubptp6h9T9LDuup0
 3j7vv+U74vDjhLEoceHDptg/cQRzwfpr2e7USeiaM+UXVUsdMW67BmeqXM82/b7r0Ze7
 vVUxGsSFkgjtIz2JU+kMieftADh7sFmJKvIcV3pGw3yPLZJZv40X5b50wqStKBlhcYTJ
 JwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746212313; x=1746817113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OvirrR3TiqgBPme4BwNGSV4VqzG47GBw5DwB3TzFavY=;
 b=Op+d4TvJU1/qaCBoHGD5ukD2d6XKtbbXOZmqZ/TaPmjFjb1ohXEB6d82MftgvT7Tw5
 g1+td4ciBZnNMN0JtbSE/5B2q8zRybeEO/guun1LfvpIvx5p7DtMLRRGVr64wGVpckMo
 dcr4MhyoRbhizCTDn5MOuXN4N5qDltpPy8YEwxLRZpogaEFTzbzuT03P3xlTQfp10R24
 0I0VRm421ipZet2OTUPtG8efC+SrEJFTEBJXAB5OcFmFIRJDgwpGEcKO8NIuDCgjXa0D
 NoO4OV2EoEegKGAUoBfUglHVz9heSHgnFG3A7I51t2aUoEBbsPWb/GAg8tVyaJAMZoKa
 Vc4w==
X-Gm-Message-State: AOJu0Yxw1ytJvQvZYeCbg0OPrEpMnZL30prIpGFEEnDXz1Ypwncjr0nv
 /Cm3QOJPi2KlpFRFdiZFb1gYQ6k9j5JepYvF8fyLn6omu8rYGsEWPGew0G4WiaZFbLxgkHlXlxW
 4
X-Gm-Gg: ASbGnct58kdvocslDh2jpShZ4BAelocux77/4pOMl6HEE5bHC+DSNZhh67H3FkVI7dp
 JAO8xY9Uh3OoObr/VQg7MlND00ojxDrzNbQR6USkdDWPKGVoXWtBHVAVQRRhFgl/6TjS0SaJg5A
 8xHDtrx70finPvmet+DjppfQYWrH0siVs8jL0h67PwzYsA5jvbQtpP6MTn6m8GLp0MyBd9qAi/y
 wG/xXpEopLFzdF7MaJvoO34SjoAOnc7mVcBJpZpH0NdxfGavMfjWVgy+gL6RB0Sgx8i2N4jWAcC
 WEhLefDNBEW2QnUY+mqwPesqZ+utC+bLffDN7xPdFpef/n+imsgujJ/nCwbjszKTCc01cKFdi7y
 Js7MTbcBKNmwMq5C5G5uLuqfXH0GrSZQ=
X-Google-Smtp-Source: AGHT+IGZ6wVeevyDsC+s4yACGzGUdWe3H7+qZMuHK+2rKbQWUFgefD64pbso4UAGgULjofY9yaR2gg==
X-Received: by 2002:a17:906:4fc5:b0:aca:c67d:eac0 with SMTP id
 a640c23a62f3a-acefe63defemr673247266b.0.1746212313493; 
 Fri, 02 May 2025 11:58:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891a311bsm88214366b.54.2025.05.02.11.58.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 11:58:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v3 17/19] hw/virtio/virtio-pci: Remove
 VirtIOPCIProxy::ignore_backend_features field
Date: Fri,  2 May 2025 20:56:49 +0200
Message-ID: <20250502185652.67370-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502185652.67370-1-philmd@linaro.org>
References: <20250502185652.67370-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The VirtIOPCIProxy::ignore_backend_features boolean was only set
in the hw_compat_2_7[] array, via the 'x-ignore-backend-features=on'
property. We removed all machines using that array, lets remove
that property, simplify by only using the default version.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/virtio/virtio-pci.h | 1 -
 hw/virtio/virtio-pci.c         | 5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index f962c9116c1..9838e8650a6 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -149,7 +149,6 @@ struct VirtIOPCIProxy {
     int config_cap;
     uint32_t flags;
     bool disable_modern;
-    bool ignore_backend_features;
     OnOffAuto disable_legacy;
     /* Transitional device id */
     uint16_t trans_devid;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 8d68e56641a..7c965771907 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1965,8 +1965,7 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
      * Virtio capabilities present without
      * VIRTIO_F_VERSION_1 confuses guests
      */
-    if (!proxy->ignore_backend_features &&
-            !virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
+    if (!virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
         virtio_pci_disable_modern(proxy);
 
         if (!legacy) {
@@ -2351,8 +2350,6 @@ static const Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT, false),
     DEFINE_PROP_BIT("page-per-vq", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT, false),
-    DEFINE_PROP_BOOL("x-ignore-backend-features", VirtIOPCIProxy,
-                     ignore_backend_features, false),
     DEFINE_PROP_BIT("ats", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_ATS_BIT, false),
     DEFINE_PROP_BIT("x-ats-page-aligned", VirtIOPCIProxy, flags,
-- 
2.47.1



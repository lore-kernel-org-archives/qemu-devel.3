Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927D6C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOku-0003If-Iz; Mon, 12 May 2025 04:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOjy-0001UR-Jo
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:42:27 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOjw-0001rJ-Vk
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:42:26 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a0ac853894so3599167f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747039343; x=1747644143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3kxaR/wAkaJaIx+pHgtintPSbDvCY+67DbaRSgHW/bQ=;
 b=USeaVPFyCPiQTxg6j6zAlHnWCC53HIaB8fLkuBntp2GT2Fu3KnA5HhJgxgFZDcE2Se
 q9Ddj4QUV6d7SQgXa9v38nZkw/wh7wmhdGN84jhlOj/vqA02ZXaQVDTAcu9x4H9FqWkj
 vTUCoZYPP7DUdW4snCup/bS+zKg2PLJwsv6LuRYDHfjgybVAHnkuCsd7vD2DiF5QD5Vh
 xu9e+P0mlbPa4pDFfbDgEGqnCb22kaZGeer5w/rCQkdnA2rsAw3+fa5zEh0LmGW8O2Ta
 gZHiJDwojuFGEOtfE6JjLGZdbRj9ZWHzjz28p4nduagZnDZszcYSgx46tN86u6PWNbWT
 nF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039343; x=1747644143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3kxaR/wAkaJaIx+pHgtintPSbDvCY+67DbaRSgHW/bQ=;
 b=KFQy1uGnhSVw6uiChFHgUfhp9cAgHS3VNLxX4hf4U4627DvrmgGpt2mwyH/NkLBdtt
 lg2870P5SlX1ijReCYQ7CZNXajJ6gFLJbL4DMcppYH4t/Zl6PFpt8TgVy4dPFy13YNDG
 pNVz5DXNRAwLEaXIegV6IiMFSlk9lEHa3YSWYb1EZA08s+18LmpHmIIhHh1f0pjXG8Qf
 0MwbodJu0CVUep5yIb+kjyacV7tgoavUzXFw0H0LwWlX+O3TBHB8rkU59vHIPZlV7KjK
 oORB9j+AaoezFkqGGtAmzN5taxTQ9s4ah07/1I6vw2HXMuRizOVDgoW5zArzKbVp79yn
 0o4A==
X-Gm-Message-State: AOJu0YzTINv0ya8/1jwTE/4lmf715wW/L2uScisOmtjBbxsimOojNbkz
 d+rHoDKOZ0yzLJUaLMlbzpxdLLIFpvCy+c8SgCHVxy/h3ancWBmbM1k4X0p7t8Ceqgh3c0fNE+5
 sc0/O9w==
X-Gm-Gg: ASbGncuSWU7gqf6FIORrn5Xs4CbiyTPu3HKE6ak3GLxwH8rHyHsSypiBNMMZwQBUWQo
 txA9cgZoa1llfw7jMnYJW5kXzxvXEKQInTkyKqlJK56opRiaKQvlqC3Nhz4JhLshFmTedNe/fps
 1lsJM7nM5CnY/xfxF6XuQ44A0hZyEUQwmdhM/sPC+T/tzqMLrNb9M7ZK24j5oEyt4lSHRLWk2Hm
 UN7k2sWQ78Z/V9fCPpnPJWuMQeGCDbzveme+MX4iKW45sBcdyQuiHy5Y8eu7J1t3k6CvhD+96iF
 2DoLHegdYR8223VqEERU7cB8Ssv5dRxkAvKZBz3Htelcuu8AlVhA1Nj5WTLF9q1ntWvmPsqBuLd
 fu32/wp7lsTyIbcNdca3OuBs=
X-Google-Smtp-Source: AGHT+IGoQ4Ccgr7t0TvBLniiAtqU1nzhNFO/qDYCwHmFdB5FxhJdD/IdGIqajcVQsbomIr/YVGCEtQ==
X-Received: by 2002:a05:6000:4313:b0:3a0:90c3:dd90 with SMTP id
 ffacd0b85a97d-3a1f6427809mr8694082f8f.11.1747039343167; 
 Mon, 12 May 2025 01:42:23 -0700 (PDT)
Received: from localhost.localdomain (129.163.185.81.rev.sfr.net.
 [81.185.163.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4bc06sm11624364f8f.87.2025.05.12.01.42.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 May 2025 01:42:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 17/19] hw/net/vmxnet3: Remove
 VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS definition
Date: Mon, 12 May 2025 10:39:46 +0200
Message-ID: <20250512083948.39294-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512083948.39294-1-philmd@linaro.org>
References: <20250512083948.39294-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS was only used by the
hw_compat_2_5[] array, via the 'x-old-msi-offsets=on' property.
We removed all machines using that array, lets remove all the
code around VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/net/vmxnet3.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 83d942af179..3cf5d71f478 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -42,18 +42,13 @@
 #define VMXNET3_MSIX_BAR_SIZE 0x2000
 
 /* Compatibility flags for migration */
-#define VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS_BIT 0
-#define VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS \
-    (1 << VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS_BIT)
 #define VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT 1
 #define VMXNET3_COMPAT_FLAG_DISABLE_PCIE \
     (1 << VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT)
 
 #define VMXNET3_EXP_EP_OFFSET (0x48)
-#define VMXNET3_MSI_OFFSET(s) \
-    ((s)->compat_flags & VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS ? 0x50 : 0x84)
-#define VMXNET3_MSIX_OFFSET(s) \
-    ((s)->compat_flags & VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS ? 0 : 0x9c)
+#define VMXNET3_MSI_OFFSET    (0x84)
+#define VMXNET3_MSIX_OFFSET   (0x9c)
 #define VMXNET3_DSN_OFFSET     (0x100)
 
 #define VMXNET3_BAR0_IDX      (0)
@@ -61,8 +56,7 @@
 #define VMXNET3_MSIX_BAR_IDX  (2)
 
 #define VMXNET3_OFF_MSIX_TABLE (0x000)
-#define VMXNET3_OFF_MSIX_PBA(s) \
-    ((s)->compat_flags & VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS ? 0x800 : 0x1000)
+#define VMXNET3_OFF_MSIX_PBA   (0x1000)
 
 /* Link speed in Mbps should be shifted by 16 */
 #define VMXNET3_LINK_SPEED      (1000 << 16)
@@ -2122,8 +2116,8 @@ vmxnet3_init_msix(VMXNET3State *s)
                         &s->msix_bar,
                         VMXNET3_MSIX_BAR_IDX, VMXNET3_OFF_MSIX_TABLE,
                         &s->msix_bar,
-                        VMXNET3_MSIX_BAR_IDX, VMXNET3_OFF_MSIX_PBA(s),
-                        VMXNET3_MSIX_OFFSET(s), NULL);
+                        VMXNET3_MSIX_BAR_IDX, VMXNET3_OFF_MSIX_PBA,
+                        VMXNET3_MSIX_OFFSET, NULL);
 
     if (0 > res) {
         VMW_WRPRN("Failed to initialize MSI-X, error %d", res);
@@ -2221,7 +2215,7 @@ static void vmxnet3_pci_realize(PCIDevice *pci_dev, Error **errp)
     /* Interrupt pin A */
     pci_dev->config[PCI_INTERRUPT_PIN] = 0x01;
 
-    ret = msi_init(pci_dev, VMXNET3_MSI_OFFSET(s), VMXNET3_MAX_NMSIX_INTRS,
+    ret = msi_init(pci_dev, VMXNET3_MSI_OFFSET, VMXNET3_MAX_NMSIX_INTRS,
                    VMXNET3_USE_64BIT, VMXNET3_PER_VECTOR_MASK, NULL);
     /* Any error other than -ENOTSUP(board's MSI support is broken)
      * is a programming error. Fall back to INTx silently on -ENOTSUP */
@@ -2472,8 +2466,6 @@ static const VMStateDescription vmstate_vmxnet3 = {
 
 static const Property vmxnet3_properties[] = {
     DEFINE_NIC_PROPERTIES(VMXNET3State, conf),
-    DEFINE_PROP_BIT("x-old-msi-offsets", VMXNET3State, compat_flags,
-                    VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS_BIT, false),
     DEFINE_PROP_BIT("x-disable-pcie", VMXNET3State, compat_flags,
                     VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT, false),
 };
-- 
2.47.1



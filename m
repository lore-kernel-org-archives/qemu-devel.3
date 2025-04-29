Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F75C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9lfT-0004aG-U6; Tue, 29 Apr 2025 10:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9ler-0003X3-NT
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:10:07 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9len-0006Vz-Es
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:10:00 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso4535240f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745935795; x=1746540595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+H9UYlRmqVO8yptjvYMIoxPGGH/04VbttZQFCTzfSSI=;
 b=Sbk3vCA5vCtt21Z/i7B8G5BcuAJbZiMleeb/lV4qPIb57mod6W6myT7tZhDpwmUMMm
 sgXPmtHm0SB2jt3a/UTv07RnIteRb7jKeEda2dwkM3xdj4eoYPvHfVk1nz+b1ZBFoUdw
 ZIxW9/BOe2ZRZ6d6woAKkDFp7XIBs2/6jL5SU9e603PkgkZ+7VDHoApHGdExFj24FiZ3
 Qv7j/bB0RwG8mWE1VO3KFM1d9/E/CD0eYsJcP+MKSNqblon/S0+DhrGw+t6q24ZMVHr2
 IxsaHZdIDJv4sFXTD/qUTIOWBrJUhlzdvFktAISik0G0+8nEpyBBWso299LPcIp/qBGq
 8oHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935795; x=1746540595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+H9UYlRmqVO8yptjvYMIoxPGGH/04VbttZQFCTzfSSI=;
 b=cgmdf1qkDF4P23nIZujdirl6xCJQ26a64HSGYRqL0+S7t5BSNSe+J7m2LBzjQzRYti
 i8vgiD/tOMnPlgJXiITzjzw+/ieWmigOeFtjSoulsQOKng2DosiE6hElzRzCVdlJH8mN
 coaSsrXqd1eDOWihvvnKdrZ/+17kKj6XCLbctYLsFcy7k2mRpUUmlMgTapbNg3Q/T4Tf
 qbHMuIOEe1NkKXHIBSIX9ZROTU+OZ0CrcX1Mo4Wyyj9XqL57000hEiCyheLzYk01hSPa
 J/X3tIcPWtWrXe4B16csXaEsshUlzQEnNoICVq55y1JgJeIW/5c3+rKdEQETPG6fXmL6
 DXag==
X-Gm-Message-State: AOJu0YwxWVWBMuXGdo/D4YHO+WVRhK9KcuSLtKmqku/cGosPtd9BNkq0
 WuYeWJ10fZUN4LIfpH9XHFVOiuysN7ITaRCmR7sJ32oCMGyRCuHJklYuCi64+kBQZvoxAwC7KTf
 r
X-Gm-Gg: ASbGncsG6bElI2C9ZS5mxcurXdm2KCd8X+dJvjG61ZSPfR1uqC+c/q33xGS87WT0Ykr
 rMn5XL4eAMMqnkpwrLVWcd1I1BCl6jyOE9IDrB8xr6WelFzn8MxVF/3Q2PnKpJ2zs6snX4Pkh4j
 VMy0hFB5DclWa53NOzIDfA51tWpq1x0dXkRKQh9+wCJwuKo5VG8sisz832B7TTZ83Kf1+h8QLGc
 3uPIe2ADVNaWI+cCx+sS8OQae1MK1J7/9tgo4VR7QoeDhaZGxrMMGWkDz5s4me0h4Pv1Nk0voJZ
 38+bsjDyNC14HoajSnlCkZ3gL4oF3gQcI9CSP5sjm2xPWiLPAaE3EVAUzgMQuF7KzfRzLnG4+w3
 H8dMR5yGvSCWIzDP5kg0w
X-Google-Smtp-Source: AGHT+IFpWx5aqDpYBbB6uRP2wJNrnFWKMAwD2ZyZRWg94EiWPLlMkY9XrxQt3yF69kCl71q9eD7Bsw==
X-Received: by 2002:a05:6000:3112:b0:39f:bfa:7c90 with SMTP id
 ffacd0b85a97d-3a08a51cbe4mr2658356f8f.13.1745935795537; 
 Tue, 29 Apr 2025 07:09:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5e351sm13788043f8f.100.2025.04.29.07.09.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 07:09:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 17/19] hw/net/vmxnet3: Remove
 VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS definition
Date: Tue, 29 Apr 2025 16:08:23 +0200
Message-ID: <20250429140825.25964-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429140825.25964-1-philmd@linaro.org>
References: <20250429140825.25964-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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



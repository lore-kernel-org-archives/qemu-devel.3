Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B926AC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJWb-0006sG-98; Tue, 06 May 2025 10:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJTI-0008DG-C3
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:40:40 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJTF-0001rT-Hi
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:40:35 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso3592093f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542432; x=1747147232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+H9UYlRmqVO8yptjvYMIoxPGGH/04VbttZQFCTzfSSI=;
 b=QD95Q3K25aBwrOqCje3E+BPf+9W7CGje6YPW6owQse39uhEFNnZdShaCdcyI0+jdms
 15ZfxyLk5d4rJER5D8UNXcwZw24ff6YxtupMK3LWjEWracdW8t4cSb1hmIRP5XxJblK+
 ZKlrg5405kMEiUsJUfyisLKh4PZPohYYclz9fzmv+hdS8c1nwXCExD9RJmSA2rwY0lC0
 FfeTO1+HpGkTxT9iLdPObY3jo9tVHsn7gEKP8LpsR/PYEpF/Z5QiXnpR+m5KDgytr53l
 6D802h+qaCmT04JiUzVI3qn4hDn9tn8p/ZD9VB3FKAaUK9YXnqom3TM8DDlfX4ylcn0K
 bJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542432; x=1747147232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+H9UYlRmqVO8yptjvYMIoxPGGH/04VbttZQFCTzfSSI=;
 b=N5t0UYZCNq/eB62N6KagiBr2XN2nG6MuDkbOXIQjLbCcQcTjpNL7o9MLmUT7xyd03T
 HVGXMFJI/MT4kQaIPMDnEBkGedg9zDylg+ORhsFsWdJKcaiAV8ts0bQOfeVsf7fYmXX5
 C72XvK059x9dMXZbkGdW47glE9Ovd/v4qi92ezIpgIRPV+GnufrVDGobyOOUa4yTcg9t
 Tqdhs33IKnxKj7nBLe+nRsrWckwR+7KBl6ebuNbzz3U+XgDbOXWQ+bScQKWMcX6avlgD
 KQ0SUfiZrX3fygqrm9xpJZwle/s8r8C8uU0eJN/b2nXMjXAQ2taiTOICa2y0Jti6E3KB
 P7RQ==
X-Gm-Message-State: AOJu0YxJFesYPBTny/fBXuNP2XeRMrb5IGqpDzR+EhBCk20lIN50FKcA
 zFjiY1VQiDQN9jePynq0xxm2cHY1jC2oYD/laLijlNg2ytcP0OE2ib+Zh8R3Qe+EogUeh8dfe3t
 R
X-Gm-Gg: ASbGncs+I3LRPRscPG+mDciQlTZd+LajPq/f8rQqnA9+IcDYvieLRcP0Qc3QLnJ/Uqz
 9YcK8ZtuqV7JMOIWz0odfK4EY2cL6oc4yVmLFVZ6il/LHr8llVvLV7llbKLOHlt6+ApHoWvmNjF
 0I8kNFXLgGXiYwLSxFNruhBcqF56Ma3xZvA11awnYz0cbEZ3zjYLJr3ApmVJuc5sNnewLHwirBK
 BCQxUGrek6RVLbbyiTGbO4z4Y+lMnuIyP/Zb6j4cQmcNNSOqRNGgKViCEszcfR+ZXAxB+Tjr2fv
 F0ShOAxw3d+Ty4GGbOA8HccDJvZC6VqxvBvyZ33AQtXEjenTb+cCZ7WrJDCZ53/Em1dpiejmVPM
 I7lYOrlcrW/bqIR30qRt6
X-Google-Smtp-Source: AGHT+IFbmlIt/t3s1h/1cSSNIcX03WX2J4CEhO5YpD9L8HMyaYX6Zq5g1inlzMRT4HtaZ2De9dkWRg==
X-Received: by 2002:a05:6000:184f:b0:3a0:9dda:c2e2 with SMTP id
 ffacd0b85a97d-3a0b43f8fc1mr7077f8f.22.1746542431760; 
 Tue, 06 May 2025 07:40:31 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b107c4sm13919157f8f.76.2025.05.06.07.40.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:40:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-block@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 17/19] hw/net/vmxnet3: Remove
 VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS definition
Date: Tue,  6 May 2025 16:39:03 +0200
Message-ID: <20250506143905.4961-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143905.4961-1-philmd@linaro.org>
References: <20250506143905.4961-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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



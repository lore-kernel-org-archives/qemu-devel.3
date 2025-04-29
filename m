Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A122FC3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9lfR-0004Ta-Dy; Tue, 29 Apr 2025 10:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9lex-0003Ys-JX
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:10:13 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9let-0006Y9-IQ
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:10:06 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c14016868so6138062f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745935801; x=1746540601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pj+GFYlfc9iJo6yTyQ5Nz9Q5zJ67gCxIABOM4SRTAcA=;
 b=gXh/bVlQdJQTMAVRSkqnIAWAV7I9YCDkmkcdrfeZk4cRDELaohkEJ4fvil/Pj+ClqL
 9hMGN41Gkv8BYsBQcuhePMjskOeFOt1sEYadga3ZHJvU0j1PxpPLeP9K6s3UPURMWBPQ
 TMX9tZ/XCP8U+jOME8tT1MKiW1jFIBUjlbOpkhqhYK43Geu64w+GSb8Xp1T/u7PnbC9q
 pM0/fkCrU4Ni8X6RYUNOOO/78vLa+TiFFnKBkyz3SLTvQ4UX5ayOkxRI03DBBGWf7Yd4
 65W/r3WO5WY6sSiufIAa9ovMddvtR5stOiuZhC0D8s6Fv7003ht/snQXMSFaXRVE/3Yo
 eFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935801; x=1746540601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pj+GFYlfc9iJo6yTyQ5Nz9Q5zJ67gCxIABOM4SRTAcA=;
 b=xHj040E04T8rnPOGqI4ECcaWXsau+dIkly+iG+72G8J5qgcGVGIqZqCVmPilYJsHjS
 OHFlM9fYlXMTfeSkg1xSC9yc9cClrS3e3H/pr1tKIexN49wWIpBxz61mvshHGkCf2r+Z
 W/kSIFLr8HmCm7gr3mgEe8WDUGddcfLDF+4ZRPEwRYa6tIwh2cj3vOFXbwFyNwlU9q10
 pd2JBPbuhbnpSpr9R3T9eQle4GkCJOo3bj5wty5LTa2T+qsilrHRA+RHtGJS2nYwyVQ5
 wD+C6apHsJifujYDPPxYnt2ZBDC5+McW0aPcozI6bpsZQDl/4P6YhbSbrU3kVwqEUnO1
 E8JQ==
X-Gm-Message-State: AOJu0YyfuQlOLUFPc8Gp5I2lcD96oDEF8gBQGOphmBCP6yuDbVBjORfH
 EL69MSKVqBSnU12qtnUC5phvPjNK8VhMS5rluSUr02jeRZGWviK3ltbglfk/BV0Lm/3TMcrt1ry
 b
X-Gm-Gg: ASbGncvi7RkUE2xpS4IE2Z0ivCp/j0C7DeHOVj6IQez8GXCDXl46ZeeQFzInWoZCEkc
 4XA/0pSlcgAb7BDJ7+qWkoLu53kAhgVVu7Ha/XEF8JPe1nUcSz7XZ2v4z+EwoLXMHCeIjkU4UEx
 J+ifaIxJPegRZyoVNJ2gpWbo/U+sVZGeKfREh9hW2j0EXqBxFpPspdxn3vc7DnNPj2Ac0ptnjIQ
 2+yKnmNBt1lwveXrGGwupmyXjjLJAtt7tJHWo0H18PNBsWtecE8vdJGzoCumBunXN5etakSnjo5
 NTfIQIPSgBGyZ+5/ybh16DBaN3yIF4LBA9luCtPOl33882ZMFQEtMuD1fwgC79EAbM8DlZqN+S4
 KW3xbrwRgHbFPNfu6sfFU
X-Google-Smtp-Source: AGHT+IFVIY3rxNjKTFlO6YgU4hgP6PjtliadrJgM6zPKxeh0WA+yTsyWX+d11aO7yYXRFK0J0prRBA==
X-Received: by 2002:a05:6000:507:b0:3a0:8119:7ab3 with SMTP id
 ffacd0b85a97d-3a0890ab0a3mr2962571f8f.15.1745935801186; 
 Tue, 29 Apr 2025 07:10:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8da58sm14202431f8f.15.2025.04.29.07.09.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 07:10:00 -0700 (PDT)
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
Subject: [PATCH v2 18/19] hw/net/vmxnet3: Remove
 VMXNET3_COMPAT_FLAG_DISABLE_PCIE definition
Date: Tue, 29 Apr 2025 16:08:24 +0200
Message-ID: <20250429140825.25964-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429140825.25964-1-philmd@linaro.org>
References: <20250429140825.25964-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

VMXNET3_COMPAT_FLAG_DISABLE_PCIE was only used by the
hw_compat_2_5[] array, via the 'x-disable-pcie=on' property.
We removed all machines using that array, lets remove all the
code around VMXNET3_COMPAT_FLAG_DISABLE_PCIE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/net/vmxnet3.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 3cf5d71f478..d080fe9b38a 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -41,11 +41,6 @@
 #define PCI_DEVICE_ID_VMWARE_VMXNET3_REVISION 0x1
 #define VMXNET3_MSIX_BAR_SIZE 0x2000
 
-/* Compatibility flags for migration */
-#define VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT 1
-#define VMXNET3_COMPAT_FLAG_DISABLE_PCIE \
-    (1 << VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT)
-
 #define VMXNET3_EXP_EP_OFFSET (0x48)
 #define VMXNET3_MSI_OFFSET    (0x84)
 #define VMXNET3_MSIX_OFFSET   (0x9c)
@@ -2466,8 +2461,6 @@ static const VMStateDescription vmstate_vmxnet3 = {
 
 static const Property vmxnet3_properties[] = {
     DEFINE_NIC_PROPERTIES(VMXNET3State, conf),
-    DEFINE_PROP_BIT("x-disable-pcie", VMXNET3State, compat_flags,
-                    VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT, false),
 };
 
 static void vmxnet3_realize(DeviceState *qdev, Error **errp)
@@ -2476,9 +2469,7 @@ static void vmxnet3_realize(DeviceState *qdev, Error **errp)
     PCIDevice *pci_dev = PCI_DEVICE(qdev);
     VMXNET3State *s = VMXNET3(qdev);
 
-    if (!(s->compat_flags & VMXNET3_COMPAT_FLAG_DISABLE_PCIE)) {
-        pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
-    }
+    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
 
     vc->parent_dc_realize(qdev, errp);
 }
-- 
2.47.1



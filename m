Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E5DCD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 17:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUpTu-0003o4-Ds; Wed, 03 Jun 2026 13:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wUpTr-0003nm-Fx
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:34:15 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wUpTp-0003Hz-MO
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:34:15 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-304545f5206so17668997eec.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 10:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780508052; x=1781112852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KENayTV64ozrbrycI3tpvUimBTS8XEoQD01DiY02LlE=;
 b=iMUmP0ZK7bJLGMZS+RdgSkTORVOI7I2pNL6DKnt3OrMHJ/uLQ6YsjOL25W97OvLrb6
 qLGiRdR5RIB1QIyw2QlDeQ7hd0gH265kG7GcJ9cpz1pKyvmJFwCMjjSIBFuNccIOARQv
 DGVi0mUfcwARw1Wrk80W3b9xQ5Qdnbnv9sSeMOgN4a+dku7mOvN6N/Q7U80To8nBbjj5
 bHDgX9JMiPMbw/7NB/5YPbAMeTIJXsTBs9vCqh9qetkOoCDjtGACAF+1Uvx+s29fVKVF
 FDkTnQjpqcK8W8D2VPgjqcVCfYpLrPgpUcTifQeQHtRSpLT4LMR+81pr8kLsrwwLE2Hc
 +4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780508052; x=1781112852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KENayTV64ozrbrycI3tpvUimBTS8XEoQD01DiY02LlE=;
 b=E2io98omnxBX75nRXPsJ5vPGE85zSVYMYiRqR1lIVDVnhkkdoAPOprUiIMcaW5ZMQj
 JeRfzZf0Rh9zAAeE11BC/6/wsly7Wnp8dGLi7Ak7AASFXYkkISuuxwlVKjYCjWT8b3gj
 aXOPiHSB/BQWPomxqbmOkCeWll6enZqqG4YO07y6PzfGHppRzGgx4N4PLSlmCWHNLVR7
 cpJAkw/feYNnOO1zA+i/av0QVRkNbt4eYaGNZnHxP6+0TQziTdJ01Hr6ttY7+E7vRxBW
 4lv4wfVAqgAMbg6BQLfBZj6mf5HHIy7lN1aeoEjk1R6MDKZnSypcOD8RKCFP1Uocy4kD
 X0nA==
X-Gm-Message-State: AOJu0Yxwy5cE47gpAi1zzl+u8XjWvAnrIa9I8i4dOQ2iUvCN4hbEQRwB
 fH0ioTDATQ2xO0Vwhayo2okLc7vaKjYl4+aS838NAjywciYiHuoPc4glENJ1nyR5ng==
X-Gm-Gg: Acq92OGiZ/0Y/XM4h0bSDqmFsdDl7XCnUcIhRrTTxV1I/+5kKzcV3MEyknO51VGssGZ
 2wkY2N3fBFSjQ8UQ0sKEejpl35vQDU9lURVKpxSyvnbzRsR1kfUC5s9T+QJ6L4upheMsCShQ/pD
 OaWfbReFlN9JWrN4yYbLPwB2bymVZ3CbareJYxyziA9pMoTVLJ2OWkx6I4LkKgnFoQVCn4AmBe7
 mfaM8pd5KHuqiIkYLqPnCGt7DgbTvarrSDzUYMNXDvnMbhKtlbr2drYE5ThR5PP1Qs8EL0EpSj2
 IOPPH5ZkI2ezyJdDVIjmrXV/JwcPMP08WdypCpRRa0BrYrkKTDuJ+CmF4eVJpGE2ej3cw9HrBMH
 Z5BhC54D9nKtMpk3AZqcbE7UMNXzDYUw5fpbU/E0oj/GOlslcGpUAWvtAyBb0PG25HO6/kuUVPl
 kbg92nhXHL6xHZjlPJ38jI+CllJHD0UH230CzTSUgaqw==
X-Received: by 2002:a05:7301:6787:b0:303:a1af:5042 with SMTP id
 5a478bee46e88-3074f703362mr2795426eec.0.1780508052070; 
 Wed, 03 Jun 2026 10:34:12 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffa:7da0:c45e:b5c8:d6e8:bd7e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074d9fde90sm4354810eec.0.2026.06.03.10.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 10:34:11 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH 3/6] hw/pci: Promote pci_patch_ids() to public
 pci_rom_patch_ids()
Date: Thu,  4 Jun 2026 01:33:51 +0800
Message-ID: <20260603173355.36121-4-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603173355.36121-1-tomitamoeko@gmail.com>
References: <20260603173355.36121-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=tomitamoeko@gmail.com; helo=mail-dy1-x1342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Remove the static qualifier from pci_patch_ids() and rename it to
pci_rom_patch_ids(), adding a declaration in include/hw/pci/pci.h so
external callers can reuse it.

Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Tested-by: K S Maan <kirandeepmaan45@gmail.com>
---
 hw/pci/pci.c         | 4 ++--
 include/hw/pci/pci.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 17ce7d8394..f8a554654b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2488,7 +2488,7 @@ uint8_t pci_rom_calculate_checksum(uint8_t *ptr, uint32_t size)
 
 /* Patch the PCI vendor and device ids in a PCI rom image if necessary.
    This is needed for an option rom which is used for more than one device. */
-static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
+void pci_rom_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
 {
     uint16_t vendor_id;
     uint16_t device_id;
@@ -2648,7 +2648,7 @@ static void pci_add_option_rom(PCIDevice *pdev, Error **errp)
 
         if (pdev->rom_need_patch_id) {
             /* Only the default rom images will be patched (if needed). */
-            pci_patch_ids(pdev, ptr, size);
+            pci_rom_patch_ids(pdev, ptr, size);
         }
     }
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 551ab16139..b52517d292 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -1104,5 +1104,6 @@ void pci_set_power(PCIDevice *pci_dev, bool state);
 int pci_pm_init(PCIDevice *pci_dev, uint8_t offset, Error **errp);
 
 uint8_t pci_rom_calculate_checksum(uint8_t *ptr, uint32_t size);
+void pci_rom_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size);
 
 #endif
-- 
2.53.0



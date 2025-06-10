Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1933DC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 13:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyZg-0000Vi-Up; Tue, 10 Jun 2025 08:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyYT-0007ni-Rq
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:58:18 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyYQ-0002i3-Bz
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:58:16 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a525eee2e3so4085359f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560291; x=1750165091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NsM3LWHZll8CDgTMYcVvtFIDSa02yxNPgaUuG9wfk94=;
 b=J3dDY8TCUToHo/4IP1KtufwoVdkgFiMjLxClqKBsteLRly0iZfwCDmMyKvJP++LGF1
 N8YAL9e9FuhSganHRtZacxgsLudXxzc8d4opgBtah9XjKE7Vx209JgqV77AtKnr8cMfK
 JYrwng5nKEbEvKZdkWEYdg91XmDesYcVMiZxvverLGgdzY3uToJneFvh+mZ+8aupXPET
 ZRcwgobDyKiITCm1Fp5lkvbg0Iqqmxi25NmxDpHF6Ki0i09ANg4I2LhYjXFuz//V2xz9
 edIff1LYalDR9pljJt+yAhOBq4m1kaqihaK3kYFCsWqgAC71nxW4QqT3UTMDfbYxFhzT
 KckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560291; x=1750165091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NsM3LWHZll8CDgTMYcVvtFIDSa02yxNPgaUuG9wfk94=;
 b=NdGGsQJvMq9guexyQzSdRMcF1WiNZnERwIFBbXosXv0khnNeMdtBVlkNrZb6cwLK63
 LbTKNsUjKKBTnw5Wcuqi9iu0uMMQfRgD2QkG/RScCjpIc0uKAUIzLA/SJHBlA+Vp5bY5
 CfDjwro2q//JvkgGk0vBSINYBTlpvoVz0ySTiY8Ue3uYLjRTRQc2iEn6x0+77Rzx4SRm
 txv2ZghwiCkurXZCMPVDdyzhO0qzgJY5uQOmxp86IKZuKhCN48eWauELjgWvlJ5ZmB5j
 xIwMyykj0UPZ1oEWJg2zzHH/2h00QHwRJVFJD6lLhLi4VVFKz5thV4rdrgwO+JultwWG
 yFfQ==
X-Gm-Message-State: AOJu0YwTDoJwxFouP4j8FspdqsSh02Tl1tWoOeyt6xvAVVg1yWWFbWwT
 rWda8ncZezBGEOlwAmwaRhq2ZUijWi3dkwODXN+AqEIhchF3DvtZwS/69xreh23TGIyoqTXYMiT
 LhaEGrCY=
X-Gm-Gg: ASbGncsfWy6yirp/tZeGNzNA2AgY4oq3EOc6v/zCh+1T9KOqaKCh7ftNWgJLNnT08Eo
 wpZZAhw6CqGJO3MyW6wVHYyB++vNxdJh6GumxyN3Sc0EDCB59ap76CrUJbuLteyRoOwlrTTqjKL
 zsPAnSBTLxVie/M5TsoZJA9HqRALdXCHDs2bJebxpXDSM6Aezk+zLRhabC8K8r7NKSKgMnNRZAz
 GofpVYyZjnSnCFzcooN01+8lSyWPOajkA9HWOIOq3Ees5I3Xhigzvegw2E48p4jjzaOiDQei5wm
 zKraTUzbegg1hQ5ipvXNjjZW8R0X8xywjYYyyJHv1fwNZqAH15FQ98buVaxuMs4PAVHwMy9U5P/
 5g1EHEtQUbl5k7KLmMBFVthTyDEM89Ax3W7mgLAmHDw==
X-Google-Smtp-Source: AGHT+IEVAOT4SSr5CJIUSvG4dXnxT3n0qXPiq6u2ePwMeeQSe8h7ZC27Hiwf8bxFC5/nTuqsFP3wWw==
X-Received: by 2002:a5d:5f49:0:b0:3a5:2fe2:c9e1 with SMTP id
 ffacd0b85a97d-3a53188e42bmr11600920f8f.30.1749560291354; 
 Tue, 10 Jun 2025 05:58:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229d96fsm12174152f8f.7.2025.06.10.05.58.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:58:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/24] hw/riscv/riscv-iommu: Remove definition of
 RISCVIOMMU[Pci|Sys]Class
Date: Tue, 10 Jun 2025 14:56:30 +0200
Message-ID: <20250610125633.24411-22-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

RISCVIOMMUPciClass and RISCVIOMMUSysClass are defined with missed
parent class, class_init on them may corrupt their parent class
fields.

It's lucky that parent_realize and parent_phases are not initialized
or used until now, so just remove the definitions. They can be added
back when really necessary.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250606092406.229833-6-zhenzhong.duan@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/riscv/iommu.h   | 6 ++----
 hw/riscv/riscv-iommu-pci.c | 6 ------
 hw/riscv/riscv-iommu-sys.c | 6 ------
 3 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu.h
index b03339d75ce..8a8acfc3f07 100644
--- a/include/hw/riscv/iommu.h
+++ b/include/hw/riscv/iommu.h
@@ -30,14 +30,12 @@ typedef struct RISCVIOMMUState RISCVIOMMUState;
 typedef struct RISCVIOMMUSpace RISCVIOMMUSpace;
 
 #define TYPE_RISCV_IOMMU_PCI "riscv-iommu-pci"
-OBJECT_DECLARE_TYPE(RISCVIOMMUStatePci, RISCVIOMMUPciClass, RISCV_IOMMU_PCI)
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStatePci, RISCV_IOMMU_PCI)
 typedef struct RISCVIOMMUStatePci RISCVIOMMUStatePci;
-typedef struct RISCVIOMMUPciClass RISCVIOMMUPciClass;
 
 #define TYPE_RISCV_IOMMU_SYS "riscv-iommu-device"
-OBJECT_DECLARE_TYPE(RISCVIOMMUStateSys, RISCVIOMMUSysClass, RISCV_IOMMU_SYS)
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStateSys, RISCV_IOMMU_SYS)
 typedef struct RISCVIOMMUStateSys RISCVIOMMUStateSys;
-typedef struct RISCVIOMMUSysClass RISCVIOMMUSysClass;
 
 #define FDT_IRQ_TYPE_EDGE_LOW 1
 
diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
index 1f44eef74ea..cdb4a7a8f03 100644
--- a/hw/riscv/riscv-iommu-pci.c
+++ b/hw/riscv/riscv-iommu-pci.c
@@ -68,12 +68,6 @@ typedef struct RISCVIOMMUStatePci {
     RISCVIOMMUState  iommu;   /* common IOMMU state */
 } RISCVIOMMUStatePci;
 
-struct RISCVIOMMUPciClass {
-    /*< public >*/
-    DeviceRealize parent_realize;
-    ResettablePhases parent_phases;
-};
-
 /* interrupt delivery callback */
 static void riscv_iommu_pci_notify(RISCVIOMMUState *iommu, unsigned vector)
 {
diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
index 74e76b94a5c..e34d00aef64 100644
--- a/hw/riscv/riscv-iommu-sys.c
+++ b/hw/riscv/riscv-iommu-sys.c
@@ -53,12 +53,6 @@ struct RISCVIOMMUStateSys {
     uint8_t *msix_pba;
 };
 
-struct RISCVIOMMUSysClass {
-    /*< public >*/
-    DeviceRealize parent_realize;
-    ResettablePhases parent_phases;
-};
-
 static uint64_t msix_table_mmio_read(void *opaque, hwaddr addr,
                                      unsigned size)
 {
-- 
2.49.0



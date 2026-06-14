Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18020CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDK-0007rw-UK; Sun, 14 Jun 2026 15:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCk-0007EF-Jn
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCi-0002Oy-SS
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FczVbIScfdeHNZS44E/9RwCeDdg9P6d3ILixOOMivMk=;
 b=ZaYgNzcxbqTfTKEQf+kXVSeVkJOzDixTLzGuPAydkfu2mJYbD3/YVQc/VPWT6ELPH60x/q
 M6EEm1zm4eHhrNblPr6VtY8O3I1fh72AuVpvUitZKpeamsltJH9pZUKBneXlDLQWo8Nhiq
 T1aSNL96dGD4mCROUUSMpO2m2epAgBg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-dectmnEZMB2ocKuTyTA63A-1; Sun, 14 Jun 2026 15:09:06 -0400
X-MC-Unique: dectmnEZMB2ocKuTyTA63A-1
X-Mimecast-MFC-AGG-ID: dectmnEZMB2ocKuTyTA63A_1781464146
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-46011aa5000so1115200f8f.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464146; x=1782068946; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FczVbIScfdeHNZS44E/9RwCeDdg9P6d3ILixOOMivMk=;
 b=SyKhsYYexLTsujGAeEXpxh4Dy7ULVi8d54GWg4yC9KBRBqpYQ6/o7CHU9DhRumVCni
 bnIkU03uIKwlAeMlYw9qhVk1yzFXGUe2oq394Cxdvje3aZPQ64p62IRVeJhTX363XJ7j
 36GOjdp0BCNWdN/MdchXCNNKrXZe1q0XIU6gvN8rckfJBUROLJ2XLgpQSdh2i0aYPxZG
 1PXed+UE4LKRwEYjJnxsvl+nsi4KTQtofUobTZyReiPkEIRHmsnIo4e6hufc7jwRr4q/
 2jaVzrF4delEfkBj3ly18zxzjVeXVMzdE81ywP5er9ujPZh+bCyIYqDclYltYfIM/Q1U
 LndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464146; x=1782068946;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FczVbIScfdeHNZS44E/9RwCeDdg9P6d3ILixOOMivMk=;
 b=jUvFz4e7OScgIzfuuOUALcHX2whubn+Ny/EENvbD3cBGJGiWa6xDxI3I53AOhlKA5P
 xfnVfYFqkS6WqIl0H3aMHdmRu37vXuFBRVLzHK5+L3npEEQsm+iaIMUA6BiMKazkXQfX
 4opFTexBOhJowFg7JAJPpu4ZxbhoVsnkr3ILv+koWu9KCCwAnjNXtVesS9d4VIORaD64
 ldbS7Kk0m4g7o8NOJa4BUNnyOiTmhJK7ZVj4qFVNim04ESrNG7bfMnAOeZZ/NcC1yuXE
 vL4MH/MtyRqucU9/t4RxslfT3zoF5wHx4NS98iRWRo3QX85pGqiZD8WQmP6e1qah1E3e
 S1uw==
X-Gm-Message-State: AOJu0YyozNFbYM6Y1YGv7I+DZwQz//e/vhpicOy+mp5H6PGA6XJL9aJI
 dLZFKHm+m98DxRr84alpStFHWXGe2ym9OPW2/da8u0H/6qcZRXwKN1LtWpirJ4piFugJYNxiNjE
 op99fucyuzJVoPuxYgSMbcUWwJQ3cmQy/B9rVO/WHgE4bsQcwB8Qx73TWZIfe07v1s/Q9tceLkq
 u63T6kYt7qNzpRxrH5wIWT3vQV8uAS/7Tpzw==
X-Gm-Gg: Acq92OEtT1xZOhrWWzfp6pxfk71HSPO3m2spYQiosOywTxS547vTZYAIce8eqN3TMk2
 /X4X0r6RPF5F2JiLCrfNANcNNUQfnTResiDbY+V04+/yeLBh5uSBvwm8zbcD2xQTTmtk4Y9eCrg
 SAxH/wY2pqpGB8RLAMU3LSk5966+MLP7FpGjQ/N3hzBQ+d/InVzInxTOcvMNrmXNhF1hO1OyZGD
 Ve9QZqiJRUAEyh81+Irueptl6Dj0WpiMN7ZWgyFzsQAu21VTQUXMIrRhzsSQS4cXIOVT0i4YYB2
 JDSIgkfHJi9k8tH95rp+ddZI18yoOaoD7QD9Y4eIWBBOjU4KlfKSxRzNKhq++20MRc1x55QczvW
 +FJF//xKha7sry3QbxCciZGGt/tPRa5uHeXNXaJOTZQQ=
X-Received: by 2002:a05:6000:184b:b0:43d:77a8:3baf with SMTP id
 ffacd0b85a97d-46074b84e9emr10021081f8f.32.1781464145599; 
 Sun, 14 Jun 2026 12:09:05 -0700 (PDT)
X-Received: by 2002:a05:6000:184b:b0:43d:77a8:3baf with SMTP id
 ffacd0b85a97d-46074b84e9emr10021031f8f.32.1781464144999; 
 Sun, 14 Jun 2026 12:09:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c4240sm25273555f8f.27.2026.06.14.12.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:04 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 079/106] amd_iommu: Use switch case to determine mmio register
 name
Message-ID: <25e92816c8d1e4c4f35a1c076d9d5f3a90e17a93.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Sairaj Kodilkar <sarunkod@amd.com>

This makes it easier to add new MMIO registers for tracing and removes
the unnecessary complexity introduced by amdvi_mmio_(low/high) array.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260302115130.5903-2-sarunkod@amd.com>
---
 hw/i386/amd_iommu.c | 74 ++++++++++++++++-----------------------------
 hw/i386/amd_iommu.h |  4 ---
 2 files changed, 26 insertions(+), 52 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 99b05b2ab6..1c44848aa9 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -35,29 +35,6 @@
 #include "kvm/kvm_i386.h"
 #include "qemu/iova-tree.h"
 
-/* used AMD-Vi MMIO registers */
-const char *amdvi_mmio_low[] = {
-    "AMDVI_MMIO_DEVTAB_BASE",
-    "AMDVI_MMIO_CMDBUF_BASE",
-    "AMDVI_MMIO_EVTLOG_BASE",
-    "AMDVI_MMIO_CONTROL",
-    "AMDVI_MMIO_EXCL_BASE",
-    "AMDVI_MMIO_EXCL_LIMIT",
-    "AMDVI_MMIO_EXT_FEATURES",
-    "AMDVI_MMIO_PPR_BASE",
-    "UNHANDLED"
-};
-const char *amdvi_mmio_high[] = {
-    "AMDVI_MMIO_COMMAND_HEAD",
-    "AMDVI_MMIO_COMMAND_TAIL",
-    "AMDVI_MMIO_EVTLOG_HEAD",
-    "AMDVI_MMIO_EVTLOG_TAIL",
-    "AMDVI_MMIO_STATUS",
-    "AMDVI_MMIO_PPR_HEAD",
-    "AMDVI_MMIO_PPR_TAIL",
-    "UNHANDLED"
-};
-
 struct AMDVIAddressSpace {
     PCIBus *bus;                /* PCIBus (for bus number)              */
     uint8_t devfn;              /* device function                      */
@@ -1540,31 +1517,31 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
     }
 }
 
-static inline uint8_t amdvi_mmio_get_index(hwaddr addr)
+static inline
+const char *amdvi_mmio_get_name(hwaddr addr)
 {
-    uint8_t index = (addr & ~0x2000) / 8;
-
-    if ((addr & 0x2000)) {
-        /* high table */
-        index = index >= AMDVI_MMIO_REGS_HIGH ? AMDVI_MMIO_REGS_HIGH : index;
-    } else {
-        index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW : index;
+    /* Return MMIO names as string literals */
+    switch (addr) {
+#define MMIO_REG_TO_STRING(mmio_reg) case mmio_reg: return #mmio_reg
+    MMIO_REG_TO_STRING(AMDVI_MMIO_DEVICE_TABLE);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_BASE);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_BASE);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_CONTROL);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_BASE);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_LIMIT);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EXT_FEATURES);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_HEAD);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_TAIL);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_HEAD);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_TAIL);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_STATUS);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL);
+#undef MMIO_REG_TO_STRING
+    default:
+        return "UNHANDLED";
     }
-
-    return index;
-}
-
-static void amdvi_mmio_trace_read(hwaddr addr, unsigned size)
-{
-    uint8_t index = amdvi_mmio_get_index(addr);
-    trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
-}
-
-static void amdvi_mmio_trace_write(hwaddr addr, unsigned size, uint64_t val)
-{
-    uint8_t index = amdvi_mmio_get_index(addr);
-    trace_amdvi_mmio_write(amdvi_mmio_low[index], addr, size, val,
-                           addr & ~0x07);
 }
 
 static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)
@@ -1584,7 +1561,7 @@ static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)
     } else if (size == 8) {
         val = amdvi_readq(s, addr);
     }
-    amdvi_mmio_trace_read(addr, size);
+    trace_amdvi_mmio_read(amdvi_mmio_get_name(addr), addr, size, addr & ~0x07);
 
     return val;
 }
@@ -1742,7 +1719,8 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
         return;
     }
 
-    amdvi_mmio_trace_write(addr, size, val);
+    trace_amdvi_mmio_write(amdvi_mmio_get_name(addr), addr, size, val, offset);
+
     switch (addr & ~0x07) {
     case AMDVI_MMIO_CONTROL:
         amdvi_mmio_reg_write(s, size, val, addr);
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 7af3c742b7..17b7ba899f 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -45,10 +45,6 @@
 #define AMDVI_CAPAB_FLAG_IOTLBSUP     (1 << 24)
 #define AMDVI_CAPAB_INIT_TYPE         (3 << 16)
 
-/* No. of used MMIO registers */
-#define AMDVI_MMIO_REGS_HIGH  7
-#define AMDVI_MMIO_REGS_LOW   8
-
 /* MMIO registers */
 #define AMDVI_MMIO_DEVICE_TABLE       0x0000
 #define AMDVI_MMIO_COMMAND_BASE       0x0008
-- 
MST



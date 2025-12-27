Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14056E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQuA-00029V-6A; Sat, 27 Dec 2025 04:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQu8-00029H-L4
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQu6-0006qL-RK
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7dZhd1TJrGMuB/APYTvzoI0KrpziUdotLVGl/UiitoY=;
 b=WamZ+MXqt0BerMVbVxlvaK7JcsOY7PbJdryh9WnhnaBKP5xgsaxbX70Sy/NT1LB3UlNKEM
 BeSvBt8GviEzLPe6hKunhIxF+2SRP9IhadNq1V4lpYf9Rna7xEF0zOdI960UPr0IsX+Q7D
 uJLiTUsq1+2fJRGIeqjiT+6p5fZHT9Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-bcAPrjScONal8lpWqDSoZA-1; Sat, 27 Dec 2025 04:48:03 -0500
X-MC-Unique: bcAPrjScONal8lpWqDSoZA-1
X-Mimecast-MFC-AGG-ID: bcAPrjScONal8lpWqDSoZA_1766828882
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4792bd2c290so73500055e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828882; x=1767433682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7dZhd1TJrGMuB/APYTvzoI0KrpziUdotLVGl/UiitoY=;
 b=WCyBHNmzrZ94pheQjntz+bXwR/Gn2Q+DUrH3Yj3P3mzWJgp4xoCBpIQosJyVLykA7f
 aHoRmLBn2gC1E5e3OI6/fN/DH/K84BVQa+S6LvqUTpTifD4xGGyBvjmRTjxrh/mRL3NL
 TZo1Nwt+F7bQTnmcRJTkGBTJ4WXx+GoGLA9N1gfMPQhqc8Zu4Fl+oZDXFeOy8dVmuOd5
 zPrTNepHoRFI0kI6JESACige6pReuSvKXyUurUxW48cGSVGSLU893+pTTEqsWrqIeN9j
 d5xz7MAX85J9eSi35R4Em4lorzfvfibCRiZFiq8qB/rfXnncCPnVFzmfCXGFeeiRW+mT
 5iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828882; x=1767433682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7dZhd1TJrGMuB/APYTvzoI0KrpziUdotLVGl/UiitoY=;
 b=LgRLO7JFqPSIggi7GMnRbTXqJU1Yf8v4bAbayRa32GI87gNwPYDp19EDJTtZr4ETiC
 hVulJq3ik/9KqhY0Q1zAACP11V7nIBBxRM0HGLxe2pqCqo+/kWZu4v50C6U9X5kspm2T
 wyuOKbU3n0Lz+BAlH+VLWgkdeCYrWYj0yS1g4XgU2wZq7YZBezVuNo6YnXCI211gSzxR
 wQRxRlgFK+ydYSFS0fiZpRnZW63l67Zjr2EZz7QjyDe9X1KD+a52AaqvPWYOQG2rHw6r
 ntCUpVa1toHOTqaxGrWEiUigeqYqWn+AZHnDYSeEXPdGHXsd/QkfjbZ32K8dgWfwAVZU
 M49Q==
X-Gm-Message-State: AOJu0YzXEf6gn5vXCIbS/TDZmIy0xAfNDfuYA3/8M8GEMPXYPshlVrC8
 XWrAP7ZaEqXPphHVVeIKJZBIMMvW9+BOcM6qZ/zqQhvj2LQJHK1pWF/a9UNWKs86IrwoYslmigS
 VE2SKekDYpM9RY3kPJgXEM/AcGN1D+LO/cg0saF61fXgEMIKRKrpu7FCg3jwnEUl7dq+GW/LcK8
 6VMpHNuLCqA49L6h0QXRkFmSHi+n+XMq5HS7j4mkbT
X-Gm-Gg: AY/fxX74a4uhTV1zlXpaeCtqDr49rKfH16e0QIOKShXzuOJRD4Ul5/hVii0OHZRylDr
 0UF1rC2dFOrmQnLVxQHGQdJpeFkrSbNx/hORvknOMyFUKscGQ5aqi0ibAm4zhlQUqTTTzOwg8a2
 OmBNT56WqP5hJFoDDZ9ZX+RJYJOMDFbrTs4v0uKkAAsFWL43caMAMURV9qng/fUCI+KLTHLSJMb
 qjoGvgBXXntHPa19a449mV4kFvGodxLtUc3Nc59cRgCEv2Aab/69cxGb9eFsddt8wE/Cl+aKf4L
 SuewSmWelmWsjmxHYgWtZKCJx0hG6tEQquk3D5bE+/d4p/ZNNt0zlF0mdyQlP3xKcRZtd6ygZGs
 zd4wQEqxLX9MEm0Zcps01fJNAcUK2oINLvmTO9XUiauC89x7CVDLRGQ8V0RkPSylHgLWfYuMgP2
 qaNxZa2F2CzqzVjiI=
X-Received: by 2002:a05:600c:4f94:b0:477:c71:1fc1 with SMTP id
 5b1f17b1804b1-47d19595e3dmr274109605e9.19.1766828881746; 
 Sat, 27 Dec 2025 01:48:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFToZ968yGx9ycARSj2nZd0RxtA6xp/fE83aQxLcFTVABds3HwP7JhbbjX5YjFwA4h/LDJ2fA==
X-Received: by 2002:a05:600c:4f94:b0:477:c71:1fc1 with SMTP id
 5b1f17b1804b1-47d19595e3dmr274109345e9.19.1766828881171; 
 Sat, 27 Dec 2025 01:48:01 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa08efsm50567011f8f.29.2025.12.27.01.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 075/153] i386/cpu: Reorganize arch lbr structure definitions
Date: Sat, 27 Dec 2025 10:46:40 +0100
Message-ID: <20251227094759.35658-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

- Move ARCH_LBR_NR_ENTRIES macro and LBREntry definition before XSAVE
  areas definitions.
- Reorder XSavesArchLBR (area 15) between XSavePKRU (area 9) and
  XSaveXTILECFG (area 17), and reorder the related QEMU_BUILD_BUG_ON
  check to keep the same ordering.

This makes xsave structures to be organized together and makes them
clearer.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211060801.3600039-4-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c95b772719c..a183394eca7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1652,6 +1652,14 @@ typedef struct {
 
 #define NB_OPMASK_REGS 8
 
+typedef struct {
+    uint64_t from;
+    uint64_t to;
+    uint64_t info;
+} LBREntry;
+
+#define ARCH_LBR_NR_ENTRIES 32
+
 /* CPU can't have 0xFFFFFFFF APIC ID, use that value to distinguish
  * that APIC ID hasn't been set yet
  */
@@ -1729,24 +1737,6 @@ typedef struct XSavePKRU {
     uint32_t padding;
 } XSavePKRU;
 
-/* Ext. save area 17: AMX XTILECFG state */
-typedef struct XSaveXTILECFG {
-    uint8_t xtilecfg[64];
-} XSaveXTILECFG;
-
-/* Ext. save area 18: AMX XTILEDATA state */
-typedef struct XSaveXTILEDATA {
-    uint8_t xtiledata[8][1024];
-} XSaveXTILEDATA;
-
-typedef struct {
-       uint64_t from;
-       uint64_t to;
-       uint64_t info;
-} LBREntry;
-
-#define ARCH_LBR_NR_ENTRIES            32
-
 /* Ext. save area 15: Arch LBR state */
 typedef struct XSaveArchLBR {
     uint64_t lbr_ctl;
@@ -1757,6 +1747,16 @@ typedef struct XSaveArchLBR {
     LBREntry lbr_records[ARCH_LBR_NR_ENTRIES];
 } XSaveArchLBR;
 
+/* Ext. save area 17: AMX XTILECFG state */
+typedef struct XSaveXTILECFG {
+    uint8_t xtilecfg[64];
+} XSaveXTILECFG;
+
+/* Ext. save area 18: AMX XTILEDATA state */
+typedef struct XSaveXTILEDATA {
+    uint8_t xtiledata[8][1024];
+} XSaveXTILEDATA;
+
 QEMU_BUILD_BUG_ON(sizeof(XSaveAVX) != 0x100);
 QEMU_BUILD_BUG_ON(sizeof(XSaveBNDREG) != 0x40);
 QEMU_BUILD_BUG_ON(sizeof(XSaveBNDCSR) != 0x40);
@@ -1764,9 +1764,9 @@ QEMU_BUILD_BUG_ON(sizeof(XSaveOpmask) != 0x40);
 QEMU_BUILD_BUG_ON(sizeof(XSaveZMM_Hi256) != 0x200);
 QEMU_BUILD_BUG_ON(sizeof(XSaveHi16_ZMM) != 0x400);
 QEMU_BUILD_BUG_ON(sizeof(XSavePKRU) != 0x8);
+QEMU_BUILD_BUG_ON(sizeof(XSaveArchLBR) != 0x328);
 QEMU_BUILD_BUG_ON(sizeof(XSaveXTILECFG) != 0x40);
 QEMU_BUILD_BUG_ON(sizeof(XSaveXTILEDATA) != 0x2000);
-QEMU_BUILD_BUG_ON(sizeof(XSaveArchLBR) != 0x328);
 
 typedef struct ExtSaveArea {
     uint32_t feature, bits;
-- 
2.52.0



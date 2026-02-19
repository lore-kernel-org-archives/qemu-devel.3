Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F89E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt5MM-00043H-EF; Thu, 19 Feb 2026 09:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt5M6-0003mV-Lx
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:50:19 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt5M1-00084a-Ip
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:50:13 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4362d4050c1so1024455f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771512590; x=1772117390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4pZISeQmIvegKoRTYoESdyMYYIAKgWJJGLkjR5mmgVc=;
 b=SNO87mJr2PCx+2yplju7dFPeoYf92wV+JZsETzLoLiTWHnGMz1VdxXH4aQGG2qOYHe
 me8q0ym0JLwwNOfWVyOwmrO54/hckLY06BOahST9CegrOpNbECfuEHes93Qy6h+fesgu
 dFBzowT6oFH45aQPw0adcowvWJf5EL8lohpexzGE4QK7vwenNcofmEPe1PSsA27ONdlZ
 dP5jERflBzw2CSt4rCI2YyOs0ExvskIHFhNqC/v8hf5IrI9WiPHdWAaq1CAeUCJQ3HQz
 rxxI01eiLRH6zBGUNQbkLkIgCa7pDL3bASRJKYEAggmhunyJYWXa1slXOmqLh35YK3os
 Qu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771512590; x=1772117390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4pZISeQmIvegKoRTYoESdyMYYIAKgWJJGLkjR5mmgVc=;
 b=oj6K+DFDETq86MF/KbQZ8AKpMxvbmSquoulUm/+KnCyePXiDXk7aQ3owr8O3S5YWzI
 aYnqdKU2mcaJ5i8O/6/YJOuxOwqS4rcshQS10oDIPC1luSCp7w8uDGpUcLhGoKV6dLGr
 8kzHAWjQx7KklT3cu+/ODML2j/+TfrNItIIW71XbVTNhAnLeLm5MJnvRYDhd2Vp8/v0e
 /LeaPEwndMA9rsg1c3itfTx5QFkCDeihZVbuK4PUdFXadHCP3SAQz4Ep3vzbgmfi+pw8
 u1ClCVKK9E9p4sOP9bCKUT19CWP8a0+hkUmc3zFlS19BEdCDcct7M+pJJa4fYCMnTMIo
 rBKA==
X-Gm-Message-State: AOJu0YyE1q/NRR+kttohrBd+TO8rClUtvy8csC3kLyANtOVkZj+M48J2
 vkeD216Bf1Yw+GR517C2DHzkso+YxPBGaJzYgxaKUVQHFjAJaHzuF3U1aFjL0Ha8
X-Gm-Gg: AZuq6aKfHgYYoytJ5zct1sQdd56apP6C/Zq25cu9+XpANomIjs9Few6yjvUZMTrFSJ2
 rn8QiJ1k0WCNy/3/NhJ96R4U7AIjGPq+8UAG27jBLtKB8Lh+Rhl/Q210qu0FqSSwvVaZV+XkUMh
 gWg/m8khT6IeVq6L6VGyN4IOsLaknPK51kLeauVm2IjktaI7SWvet78oJurEnSq5OqkdmgbCB1o
 HB4GAVoz7f7d7NfiVnAGb4ykxVLYmw2eDKboapW20h8Eok+OzccxEvxgmaQdPRTCxTDi+BuzWQq
 RGrgn83y7eQTsBpYCe2dnzguE8FrKjZg0g5YLMPfWbtL41Wxu34q0q6yg3/22u/OdnD0o4I6oGz
 oxP9unZNlD0VBFUHK6iDZi66pZLPYEhjCTWQc9393hlVEgTAGESpXpfn0jvchIkV3SNUDSnS+bJ
 rUDT2Vg8xxZM5vJjliRx9PUhw2hYUbC7c5NH4ztVx6QJg6XtQmP2pilbdmrXP0fuleuelX
X-Received: by 2002:a05:6000:1aca:b0:437:7221:67fd with SMTP id
 ffacd0b85a97d-437978c99f0mr40731455f8f.11.1771512590068; 
 Thu, 19 Feb 2026 06:49:50 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-129-182.adsl.net.t-com.hr.
 [93.143.129.182]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d82sm50163087f8f.31.2026.02.19.06.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:49:49 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 26/33] system/memory: implement FDT_GENERIC_MMAP interface
Date: Thu, 19 Feb 2026 15:48:54 +0100
Message-ID: <20260219144901.3317747-8-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219144901.3317747-1-ruslichenko.r@gmail.com>
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
 <20260219144901.3317747-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

The patch implements TYPE_FDT_GENERIC_MMAP interface
for the MemoryRegion class.

This enables memory region objects to be automatically
constructed by FDT parser based on the 'reg' property
in the Device tree. The implementation parses register
tuples and set base address, size and priority properties.

Optionally parent container can be set of newly created
memory region.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 system/memory.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/system/memory.c b/system/memory.c
index fc1f6cff0c..81e6846c60 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -38,6 +38,8 @@
 
 #include "memory-internal.h"
 
+#include "hw/core/fdt_generic_util.h"
+
 //#define DEBUG_UNASSIGNED
 
 static unsigned memory_region_transaction_depth;
@@ -3783,6 +3785,57 @@ static gboolean mtree_info_flatview_free(gpointer key, gpointer value,
     return true;
 }
 
+static bool memory_region_parse_reg(FDTGenericMMap *obj,
+    FDTGenericRegPropInfo reg, Error **errp)
+{
+    MemoryRegion *mr = MEMORY_REGION(obj);
+    uint64_t base_addr = ~0ull;
+    uint64_t total_size = 0;
+    uint64_t max_addr = 0;
+    int i;
+
+    if (!reg.n) {
+        return false;
+    }
+
+    for (i = 0; i < reg.n; ++i) {
+        base_addr = MIN(base_addr, reg.a[i]);
+        max_addr = MAX(max_addr, reg.a[i] + reg.s[i]);
+        total_size += reg.s[i];
+        if (reg.p[i] != reg.p[0]) {
+            error_setg(errp, "FDT generic memory parser does not support"
+                       "mixed priorities");
+            return false;
+        }
+    }
+
+    if (total_size != max_addr - base_addr) {
+        error_setg(errp, "FDT generic memory parse does not "
+        "spport discontiguous or overlapping memory regions");
+        return false;
+    }
+
+    /*
+     * FIXME: parent should not be optional but we need to implement
+     * reg-extended in kernel before we can do things properly
+     */
+    if (reg.parents[0]) {
+        object_property_set_link(OBJECT(mr), "container", reg.parents[0],
+                                 &error_abort);
+    }
+    object_property_set_int(OBJECT(mr), "size", total_size, &error_abort);
+    object_property_set_int(OBJECT(mr), "addr", base_addr, &error_abort);
+    object_property_set_int(OBJECT(mr), "priority", reg.p[0], &error_abort);
+    return false;
+}
+
+static void memory_region_class_init(ObjectClass *oc, const void *data)
+{
+    FDTGenericMMapClass *fmc = FDT_GENERIC_MMAP_CLASS(oc);
+
+    fmc->parse_reg = memory_region_parse_reg;
+}
+
 static void mtree_info_flatview(bool dispatch_tree, bool owner)
 {
     struct FlatViewInfo fvi = {
@@ -4037,6 +4090,11 @@ static const TypeInfo memory_region_info = {
     .instance_size      = sizeof(MemoryRegion),
     .instance_init      = memory_region_initfn,
     .instance_finalize  = memory_region_finalize,
+    .class_init         = memory_region_class_init,
+    .interfaces         = (InterfaceInfo[]) {
+        { TYPE_FDT_GENERIC_MMAP },
+        { },
+    },
 };
 
 static const TypeInfo iommu_memory_region_info = {
-- 
2.43.0



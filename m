Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE0ECCF9EC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMPJ-0000DL-8i; Mon, 27 Oct 2025 08:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDMOn-0008K2-Vp
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:32:38 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDMOh-0005Qt-O2
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=wFCezcQ7fh5qeB/Zli5cwGtrrz+6fzqC0Kwv+DN1bYU=; b=vCe0LAtTgZhyv01
 unEaIJVM57xZxZBaj5DIK96qR94w2TcqIImi/lsB9kDdo3MpxnUzPAVz/0YlQcpMQzWiOTSzahdw2
 xS+Fps2dQ3/n69Hqs2WmWixKyO5hdzkMK9tDOH2TtAFVUxHvptbAJ+bml0kmUZ/Vj5dkcdW7w6/Mu
 RI=;
Date: Mon, 27 Oct 2025 13:35:12 +0100
Subject: [PATCH v2 3/3] hw/riscv: Widen OpenSBI dynamic info struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-feature-single-binary-hw-v1-v2-3-44478d589ae9@rev.ng>
References: <20251027-feature-single-binary-hw-v1-v2-0-44478d589ae9@rev.ng>
In-Reply-To: <20251027-feature-single-binary-hw-v1-v2-0-44478d589ae9@rev.ng>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, palmer@dabbelt.com
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since fw_dynamic_info is only used for non 32 bit targets, target_long
is int64_t anyway.  Rename struct to fw_dynamic_info64 and use int64_t.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/hw/riscv/boot_opensbi.h | 14 +++++++-------
 hw/riscv/boot.c                 | 22 ++++++++++++----------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/include/hw/riscv/boot_opensbi.h b/include/hw/riscv/boot_opensbi.h
index 18664a174b..ab9999be3f 100644
--- a/include/hw/riscv/boot_opensbi.h
+++ b/include/hw/riscv/boot_opensbi.h
@@ -29,17 +29,17 @@ enum sbi_scratch_options {
 };
 
 /** Representation dynamic info passed by previous booting stage */
-struct fw_dynamic_info {
+struct fw_dynamic_info64 {
     /** Info magic */
-    target_long magic;
+    int64_t magic;
     /** Info version */
-    target_long version;
+    int64_t version;
     /** Next booting stage address */
-    target_long next_addr;
+    int64_t next_addr;
     /** Next booting stage mode */
-    target_long next_mode;
+    int64_t next_mode;
     /** Options for OpenSBI library */
-    target_long options;
+    int64_t options;
     /**
      * Preferred boot HART id
      *
@@ -55,7 +55,7 @@ struct fw_dynamic_info {
      * stage can set it to -1UL which will force the FW_DYNAMIC firmware
      * to use the relocation lottery mechanism.
      */
-    target_long boot_hart;
+    int64_t boot_hart;
 };
 
 /** Representation dynamic info passed by previous booting stage */
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 4eadcff26c..64608e58c7 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -387,7 +387,8 @@ void riscv_rom_copy_firmware_info(MachineState *machine,
                                   uint64_t kernel_entry)
 {
     struct fw_dynamic_info32 dinfo32;
-    struct fw_dynamic_info dinfo;
+    struct fw_dynamic_info64 dinfo64;
+    void *dinfo_ptr = NULL;
     size_t dinfo_len;
 
     if (riscv_is_32bit(harts)) {
@@ -397,15 +398,17 @@ void riscv_rom_copy_firmware_info(MachineState *machine,
         dinfo32.next_addr = cpu_to_le32(kernel_entry);
         dinfo32.options = 0;
         dinfo32.boot_hart = 0;
+        dinfo_ptr = &dinfo32;
         dinfo_len = sizeof(dinfo32);
     } else {
-        dinfo.magic = cpu_to_le64(FW_DYNAMIC_INFO_MAGIC_VALUE);
-        dinfo.version = cpu_to_le64(FW_DYNAMIC_INFO_VERSION);
-        dinfo.next_mode = cpu_to_le64(FW_DYNAMIC_INFO_NEXT_MODE_S);
-        dinfo.next_addr = cpu_to_le64(kernel_entry);
-        dinfo.options = 0;
-        dinfo.boot_hart = 0;
-        dinfo_len = sizeof(dinfo);
+        dinfo64.magic = cpu_to_le64(FW_DYNAMIC_INFO_MAGIC_VALUE);
+        dinfo64.version = cpu_to_le64(FW_DYNAMIC_INFO_VERSION);
+        dinfo64.next_mode = cpu_to_le64(FW_DYNAMIC_INFO_NEXT_MODE_S);
+        dinfo64.next_addr = cpu_to_le64(kernel_entry);
+        dinfo64.options = 0;
+        dinfo64.boot_hart = 0;
+        dinfo_ptr = &dinfo64;
+        dinfo_len = sizeof(dinfo64);
     }
 
     /**
@@ -419,8 +422,7 @@ void riscv_rom_copy_firmware_info(MachineState *machine,
     }
 
     rom_add_blob_fixed_as("mrom.finfo",
-                           riscv_is_32bit(harts) ?
-                           (void *)&dinfo32 : (void *)&dinfo,
+                           dinfo_ptr,
                            dinfo_len,
                            rom_base + reset_vec_size,
                            &address_space_memory);

-- 
2.51.0



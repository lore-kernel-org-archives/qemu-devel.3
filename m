Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A540C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQI-00074G-3a; Fri, 12 Apr 2024 03:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQF-00073N-MF
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:07 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQA-0007CC-55
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:06 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1e3f17c64daso5127205ad.3
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907240; x=1713512040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eklEK2wKipko2sVrTrkRStnjaxK8ouvGtZK4O7yNiB8=;
 b=z7SOZbESsgy6Oh1B6l6CTV/J+ZkpqBYBQ0l8DyLCVz8LWPrR1twOeLuxkmNhpVoVd1
 ATx90Y8MkmqyZJkNxbYCiYoSvLW4sB3mhdLq511GdD2VX6sxqvGdZmIJ95voIBtRkVIX
 q2v44sC8BHE9hcM3FTOU9vkdauVzAywdEZlI75KpMz5qYdEf41yl0o0XS6MoOsP2B4r5
 EjkydIFNXXy8DihOjzCWE8aZiTYPNnTI2+hwm3GLKRS85LSqC3bGmerxU/CV6HvaMqfH
 4ch+tuIO1uoe+0M9nsGnTmfokQiUJFRoJ3GTnMIYTQGiPWnyeaHdTQoieTaKJt9tGst0
 i4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907240; x=1713512040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eklEK2wKipko2sVrTrkRStnjaxK8ouvGtZK4O7yNiB8=;
 b=mz0CSWysTo4T7Z31NZGx8ghb8TvC/qbCDJALdSGsyhpVQuox8iW41Ns1mPUZgmSQgW
 qCTBZgBeQBNYsSQMpAYY5j/MLkVhlktwfox7AuSM12M1+s07yLApirZcAnAwrL46Ek62
 oOq3Zd9jwWtJoZq0v35OcnKftd82MnPFkJZzdHI+OOOda/M2AoESgAXQWzbvyCffpNTD
 61lhDKhEgSWynUPnOveRga/dPxpYVeH+AhJFbIq1WuckPTob+b2zX+neM2u2r0LZtwH5
 eGSJgV2M8VBzRu49T59PDvjfgDfS23nDzpHLyK7/lD0i8S8PFyhSEaeIKGH5MHBuWgju
 7SEg==
X-Gm-Message-State: AOJu0Yz/O9Zf/RaIxmtVgyqRUPgdkyWOTXzP1w6foEBonIdBG6YN/ln/
 XbNFkke7tp86xZo9Wua83fJcmL+BWwDi/ztoGE8eGV1Q7hpPaz+LgK9wq8XYLj575z3GUP2bwou
 M
X-Google-Smtp-Source: AGHT+IHRoCaQBLRCMfpgHITORef7Ww94gaAHa9USlmODv+7b2qZbtkicv2BX+QafBAWtyCv9hjWXqg==
X-Received: by 2002:a17:903:2442:b0:1e0:bddf:7ed0 with SMTP id
 l2-20020a170903244200b001e0bddf7ed0mr1741815pls.27.1712907240555; 
 Fri, 12 Apr 2024 00:34:00 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.34.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:34:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/27] disas/microblaze: Merge op->name output into each
 fprintf
Date: Fri, 12 Apr 2024 00:33:35 -0700
Message-Id: <20240412073346.458116-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

In the common case, issue one single fprintf.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/microblaze.c | 80 +++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/disas/microblaze.c b/disas/microblaze.c
index c729c76585..a537ac65dd 100644
--- a/disas/microblaze.c
+++ b/disas/microblaze.c
@@ -830,54 +830,52 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
         return 4;
     }
 
-    fprintf_func (stream, "%s", op->name);
-      
     switch (op->inst_type) {
     case INST_TYPE_RD_R1_R2:
-        fprintf_func(stream, "\t%s, %s, %s",
-                     get_field_rd(inst), get_field_r1(inst),
+        fprintf_func(stream, "%s\t%s, %s, %s",
+                     op->name, get_field_rd(inst), get_field_r1(inst),
                      get_field_r2(inst));
         break;
     case INST_TYPE_RD_R1_IMM:
-        fprintf_func(stream, "\t%s, %s, %s",
-                     get_field_rd(inst), get_field_r1(inst),
+        fprintf_func(stream, "%s\t%s, %s, %s",
+                     op->name, get_field_rd(inst), get_field_r1(inst),
                      get_field_imm(inst));
         if (get_int_field_r1(inst) == 0) {
             print_immval_addr(info, immfound, immval, inst, 0);
         }
         break;
     case INST_TYPE_RD_R1_IMM5:
-        fprintf_func(stream, "\t%s, %s, %s",
-                     get_field_rd(inst), get_field_r1(inst),
+        fprintf_func(stream, "%s\t%s, %s, %s",
+                     op->name, get_field_rd(inst), get_field_r1(inst),
                      get_field_imm5(inst));
         break;
     case INST_TYPE_RD_RFSL:
-        fprintf_func(stream, "\t%s, %s",
-                     get_field_rd(inst), get_field_rfsl(inst));
+        fprintf_func(stream, "%s\t%s, %s",
+                     op->name, get_field_rd(inst), get_field_rfsl(inst));
         break;
     case INST_TYPE_R1_RFSL:
-        fprintf_func(stream, "\t%s, %s",
-                     get_field_r1(inst), get_field_rfsl(inst));
+        fprintf_func(stream, "%s\t%s, %s",
+                     op->name, get_field_r1(inst), get_field_rfsl(inst));
         break;
     case INST_TYPE_RD_SPECIAL:
-        fprintf_func(stream, "\t%s, %s",
-                     get_field_rd(inst), get_field_special(inst, op));
+        fprintf_func(stream, "%s\t%s, %s",
+                     op->name, get_field_rd(inst), get_field_special(inst, op));
         break;
     case INST_TYPE_SPECIAL_R1:
-        fprintf_func(stream, "\t%s, %s",
-                     get_field_special(inst, op), get_field_r1(inst));
+        fprintf_func(stream, "%s\t%s, %s",
+                     op->name, get_field_special(inst, op), get_field_r1(inst));
         break;
     case INST_TYPE_RD_R1:
-        fprintf_func(stream, "\t%s, %s",
-                     get_field_rd(inst), get_field_r1(inst));
+        fprintf_func(stream, "%s\t%s, %s",
+                     op->name, get_field_rd(inst), get_field_r1(inst));
         break;
     case INST_TYPE_R1_R2:
-        fprintf_func(stream, "\t%s, %s",
-                     get_field_r1(inst), get_field_r2(inst));
+        fprintf_func(stream, "%s\t%s, %s",
+                     op->name, get_field_r1(inst), get_field_r2(inst));
         break;
     case INST_TYPE_R1_IMM:
-        fprintf_func(stream, "\t%s, %s",
-                     get_field_r1(inst), get_field_imm(inst));
+        fprintf_func(stream, "%s\t%s, %s",
+                     op->name, get_field_r1(inst), get_field_imm(inst));
         /*
          * The non-pc relative instructions are returns,
          * which shouldn't have a label printed.
@@ -887,14 +885,15 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
         }
         break;
     case INST_TYPE_RD_IMM:
-        fprintf_func(stream, "\t%s, %s",
-                     get_field_rd(inst), get_field_imm(inst));
+        fprintf_func(stream, "%s\t%s, %s",
+                     op->name, get_field_rd(inst), get_field_imm(inst));
         print_immval_addr(info, immfound, immval, inst,
                           op->inst_offset_type == INST_PC_OFFSET
                           ? memaddr : 0);
         break;
     case INST_TYPE_IMM:
-        fprintf_func(stream, "\t%s", get_field_imm(inst));
+        fprintf_func(stream, "%s\t%s",
+                     op->name, get_field_imm(inst));
         if (op->instr != imm) {
             print_immval_addr(info, immfound, immval, inst,
                               op->inst_offset_type == INST_PC_OFFSET
@@ -902,37 +901,38 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
         }
         break;
     case INST_TYPE_RD_R2:
-        fprintf_func(stream, "\t%s, %s",
-                     get_field_rd(inst), get_field_r2(inst));
+        fprintf_func(stream, "%s\t%s, %s",
+                     op->name, get_field_rd(inst), get_field_r2(inst));
         break;
     case INST_TYPE_R2:
-        fprintf_func(stream, "\t%s",
-                     get_field_r2(inst));
+        fprintf_func(stream, "%s\t%s",
+                     op->name, get_field_r2(inst));
         break;
     case INST_TYPE_R1:
-        fprintf_func(stream, "\t%s",
-                     get_field_r1(inst));
+        fprintf_func(stream, "%s\t%s",
+                     op->name, get_field_r1(inst));
         break;
     case INST_TYPE_RD_R1_SPECIAL:
-        fprintf_func(stream, "\t%s, %s",
-                     get_field_rd(inst), get_field_r2(inst));
+        fprintf_func(stream, "%s\t%s, %s",
+                     op->name, get_field_rd(inst), get_field_r2(inst));
         break;
     case INST_TYPE_RD_IMM15:
-        fprintf_func(stream, "\t%s, %s",
-                     get_field_rd(inst), get_field_imm15(inst));
+        fprintf_func(stream, "%s\t%s, %s",
+                     op->name, get_field_rd(inst), get_field_imm15(inst));
         break;
         /* For tuqula instruction */
     case INST_TYPE_RD:
-        fprintf_func(stream, "\t%s",
-                     get_field_rd(inst));
+        fprintf_func(stream, "%s\t%s",
+                     op->name, get_field_rd(inst));
         break;
     case INST_TYPE_RFSL:
-        fprintf_func(stream, "\t%s",
-                     get_field_rfsl(inst));
+        fprintf_func(stream, "%s\t%s",
+                     op->name, get_field_rfsl(inst));
         break;
     default:
         /* if the disassembler lags the instruction set */
-        fprintf_func(stream, "\tundecoded operands, inst is 0x%04lx", inst);
+        fprintf_func(stream, "%s\tundecoded operands, inst is 0x%04lx",
+                     op->name, inst);
         break;
     }
     return 4;
-- 
2.34.1



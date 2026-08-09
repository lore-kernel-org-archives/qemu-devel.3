Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B46C5AD7B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC84-00015U-IJ; Sun, 09 Aug 2026 18:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC82-00012n-Jm
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:26 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC80-0007SK-L2
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:26 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-8486672f03cso1158458b3a.0
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314983; x=1786919783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wel1hASlWCOzbBEuzpslBrUlE+P7EagjaJSpRxfpogk=;
 b=aX3c8SjX2fbQsEX5ylTp2O30P+qyAB9mGQJ42MIGMlrsUtl4fRLfo+DJpSpxBgD/8r
 3j5DQt/vvWOabMkrRQGrFDN4N0XlNV4iBfrvPBgsSiQofl+FsR1S3LYbBKDyD45C2CrI
 pFXo5krM8I1N814rI2uCTpA1/++7K0g0QS5ZWbsOXUbCaBGCAVbQ9mQZgeq0Xm0dPhVy
 tAjzJPlGkOyMDx13pFU1snvfpaGr5pWevRcgvo5chCQfm7c40fRy5DSRePCQRZerg1bc
 /z/r+E+6gaLDUpYDiZmQzTRzRCf1X2ybq3ki5B2SK+fBSbuwjPfpDSYZN3o4OzfOrhhl
 EwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314983; x=1786919783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wel1hASlWCOzbBEuzpslBrUlE+P7EagjaJSpRxfpogk=;
 b=hS60Zx/D8mjAYbGPCKjPoDeg2A8FA6CCevFLAwtR4f8uR64x8GKpNXXTq+l5TTkZXu
 4o5+8WWMFroJvxNK3eGfiaHXfLuIWLFJbFBprdpUHaXDpt8nkQP76pry4GwqRj+Vmd04
 oyiA80nrk9PH+O2A3jY10icuTQkyxvOgaY9TAvoFaPtGq+KpjI8GsxSaZyESpWzHp9ss
 gWVY2U3jgS5trDeq8QeaZ3TsO+BWw3YXNcjWYTB5+H1QP8rCHE1XgNIpMyGfa1ia7/3p
 N+d9L5s8bTwMWZtWRotsCr1gVGVNT93L+eVa3Cksyq6WxufB34dC42/rROp4UbuGfVAc
 b/rQ==
X-Gm-Message-State: AOJu0YwFMyd3uJLe/yZYGRgNU2Db1VsWyt2MnwHtAAnSstSsZRA74g1n
 jfgZ2r2/OcNLCRT18OdeSuoF60lgfuvRSW4vmJdHDyfsuqXVTD5xscS2Gv9fr6c413pIVdzAOo0
 cfaqW
X-Gm-Gg: AR+sD11bBACm3q+ViBpm33/dVFcF57nsta/QHogSaVn36F30stTHtpcpvONpaFkyhzj
 rX9hDR1GCMhnZeavRegvDG5xhR1Vf0c7PPjZrFSYS91aLrgovZxMMj8kbDHl+Gmf6CHMzgC9Yno
 +oJOXNG0mN0NTV18IPjtupLvwnkcaSHjBrwybrfqfUQLMwqtry/DssqJLlDGbtaz6ILOxL6bIhZ
 kt0wvc1rjKCWIY+WxJeII0ZFqv0jvS5XXV+q/ekxXY06unu89I1KRkvzNmXuCIVQR0V9lBCdSaJ
 1eHOe9328ZtZN4JcKoJrdYvl1SzHr9Mn6rAjVp4kKkO4QAsA5iWr1f0ok2xpKZa4BWzLXg7ggN2
 Y7SI5vGIH3rB/GlH4W9I6jAhkL2oYF9tfARSROMbrlt0ZpsdPuo1AUB7TykxA4LG8Yl01DxJ74O
 fUIjznMm8A2XLYpqaaVmlcxa+4GskzZUKuB8zPVNCFMyuBZ15HYH7a3dVYywJMV1eUWyWWPmE5m
 CbuTydC6BaIxd57adbJ
X-Received: by 2002:a05:6a00:4394:b0:837:f79d:909 with SMTP id
 d2e1a72fcca58-84f2e0cc739mr45247502b3a.39.1786314983084; 
 Sun, 09 Aug 2026 15:36:23 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:36:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 29/56] disas/riscv: Handle aliases of csrrwi during decode
Date: Sun,  9 Aug 2026 15:35:18 -0700
Message-ID: <20260809223545.730664-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.h |  2 --
 disas/riscv.c | 28 ++++++++--------------------
 2 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index d8c5acd969..3bbcbf10fb 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -84,8 +84,6 @@ typedef enum {
     rvc_imm_eq_zero,
     rvc_imm_eq_n1,
     rvc_imm_eq_p1,
-    rvc_csr_eq_0x001,
-    rvc_csr_eq_0x002,
 } rvc_constraint;
 
 typedef enum {
diff --git a/disas/riscv.c b/disas/riscv.c
index 9ec79baf4d..d3cbfb86ac 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1063,8 +1063,6 @@ static const rvc_constraint rvcc_ret[] = { rvc_rd_eq_x0, rvc_rs1_eq_ra,
                                            rvc_end };
 static const rvc_constraint rvcc_jr[] = { rvc_rd_eq_x0, rvc_imm_eq_zero,
                                           rvc_end };
-static const rvc_constraint rvcc_fsrmi[] = { rvc_csr_eq_0x002, rvc_end };
-static const rvc_constraint rvcc_fsflagsi[] = { rvc_csr_eq_0x001, rvc_end };
 
 /* pseudo-instruction metadata */
 
@@ -1145,12 +1143,6 @@ static const rv_comp_data rvcp_subw[] = {
     { rv_op_illegal, NULL }
 };
 
-static const rv_comp_data rvcp_csrrwi[] = {
-    { rv_op_fsrmi, rvcc_fsrmi },
-    { rv_op_fsflagsi, rvcc_fsflagsi },
-    { rv_op_illegal, NULL }
-};
-
 static const rv_comp_data rvcp_fsgnj_s[] = {
     { rv_op_fmv_s, rvcc_fmv_s },
     { rv_op_illegal, NULL }
@@ -1722,7 +1714,7 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "csrrw", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
     { "csrrs", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
     { "csrrc", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
-    { "csrrwi", rv_codec_i_csr, rv_fmt_rd_csr_zimm, rvcp_csrrwi },
+    { "csrrwi", rv_codec_i_csr, rv_fmt_rd_csr_zimm },
     { "csrrsi", rv_codec_i_csr, rv_fmt_rd_csr_zimm },
     { "csrrci", rv_codec_i_csr, rv_fmt_rd_csr_zimm },
     { "flw", rv_codec_i, rv_fmt_frd_offset_rs1 },
@@ -4469,7 +4461,13 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     }
                 }
                 break;
-            case 5: op = rv_op_csrrwi; break;
+            case 5:
+                switch (operand_csr12(inst)) {
+                case 1: op = rv_op_fsflagsi; break;
+                case 2: op = rv_op_fsrmi; break;
+                default: op = rv_op_csrrwi; break;
+                }
+                break;
             case 6: op = rv_op_csrrsi; break;
             case 7: op = rv_op_csrrci; break;
             }
@@ -4991,16 +4989,6 @@ static bool check_constraints(rv_decode *dec, const rvc_constraint *c)
                 return false;
             }
             break;
-        case rvc_csr_eq_0x001:
-            if (!(imm == 0x001)) {
-                return false;
-            }
-            break;
-        case rvc_csr_eq_0x002:
-            if (!(imm == 0x002)) {
-                return false;
-            }
-            break;
         default: break;
         }
         c++;
-- 
2.43.0



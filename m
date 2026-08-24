Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35824C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbJ-00055b-Q9; Mon, 24 Aug 2026 01:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNap-0004UX-5B
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:35 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNaV-0002bH-90
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:19 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cbe6295f05bso2724769a12.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550670; x=1788155470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pELMg+WaaGuMaoeRzO7z5uC1+w1HHOpZNmw21D6h9tQ=;
 b=oNHkTZSlhFmmGpupC/F80E8ONHlc/LUTULR33J4TR5jPQ8FzGnNmGuwPehUQ5aHg0z
 grQqkFDFaUXo96p7QN1htJsGAKAj69kLwCQimwhPC5BcECirIDGKcpWIehjJmAkfq76Y
 9DL1L23pslnvdWgU47IIsBPCrQuHWK4sEuxXhf4nXwQIczs0s6GPSL4LsJMGVElrzg8Q
 ThZFQ+LDnddLDdum96UyKBqn1VUpuV3GH3BjBDqhyjiVth6OrGa+LjTFqacZkiD/Mj5F
 KgTydb59E3l6ktm5ff/pfodLls/AFdHaEgBJ73SWnGXOTcRkcMAifWV5uQXRm/rXXB7V
 dC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550670; x=1788155470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pELMg+WaaGuMaoeRzO7z5uC1+w1HHOpZNmw21D6h9tQ=;
 b=MAG57Sa8EvCN/haWgv9MfQoZcY3xJXO5I4TIsQgtiPu6c/qT/FFHEQupLUXk3lF/yF
 QAwj24ZFXFjI9CC31hMw/1RSk2o3A0hQXbWX1e+iI8E7EyWiWTD7nlvTnKsdlnbATDej
 WfWBek2aJNRHXniBdxXzBHps9Y1bShG23okKgVOpmCgy9lWXAmBVZf7lLHWaWWlWv7Ro
 1Zq2UhXqd38EBNUUVWbJTrL4cofqvm9tp/cDj8JoMSQdgr1hnOy4OY/DZX9Y1gfGSHbL
 spsPCwPFSe2lgoJWyzJz9NlFxm5NWdV+DQ8nfhWbFP3WmecYso//tez8o7y0JH5Pc7zH
 wAwA==
X-Gm-Message-State: AFuF++nxZVJgMMiw/hE2L+mIUC0U+ir0FbdtyfqY0TQLUNNt8RPUUS2v
 E0Ve6r0vgTdcaDYrBY9GFxF/EaJNsWzn/G9tfvJS+XIFPm3d2uH+A0q3jHX9Ew==
X-Gm-Gg: AR+sD11igShTI3q9TSMEZI5gI4S5q7E9odKe9OVK4Gv6GlWS/0jvmKXur9rW3tEOcrn
 Q2t5qbSu8OBH/MfOLCf/1NjTJK5oLW76i3t74MMDc5tSk8GZZLo4t/oDBhidW61iKQvhrl1Tsxa
 xMs5i85E3WOl+SKbR+Ziou8OWk+aS2CDS/H+jhEf89Qk9tseT8tGLmbn9A/TVUHCLMkGbSO4lcT
 IrUJhJeJk7Jav7wpqkhs1AOuLcbqREmYscgDmIyf0qMEbUZtEbB8j2+DmMOhyHoBdXVEWZ4QEZ7
 oDvyiwDd/x59tjARNLTxM8yu/GVGJpnDWCSumQBO8MYcfYIZ1QmMSYh9J0hWTWYNjKmbcAczE8Z
 aF2G7pGIvwmSDWBjQHxBhA6LVn0IWr2ezgNh/DxyvOgVPL/9whYUAG9mkDQrOXLpFVtBzD21uMw
 UrDevUzrFuzmAZAdorZ/cfKfUGMJHNWeQeRo4Q8jS6Es9/qm0rHb9wPH6qbiqi2l1OzIeDRVJus
 tH67A==
X-Received: by 2002:a17:90b:57c3:b0:395:8124:ac53 with SMTP id
 98e67ed59e1d1-395c4fa443fmr21220759a91.6.1787550670296; 
 Sun, 23 Aug 2026 22:51:10 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:51:09 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 56/96] disas/riscv: Handle aliases of csrrs during decode
Date: Mon, 24 Aug 2026 15:47:26 +1000
Message-ID: <20260824054806.2790041-57-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-24-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.h |  7 -----
 disas/riscv.c | 85 +++++++++++----------------------------------------
 2 files changed, 17 insertions(+), 75 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 900363c603..d8c5acd969 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -86,13 +86,6 @@ typedef enum {
     rvc_imm_eq_p1,
     rvc_csr_eq_0x001,
     rvc_csr_eq_0x002,
-    rvc_csr_eq_0x003,
-    rvc_csr_eq_0xc00,
-    rvc_csr_eq_0xc01,
-    rvc_csr_eq_0xc02,
-    rvc_csr_eq_0xc80,
-    rvc_csr_eq_0xc81,
-    rvc_csr_eq_0xc82,
 } rvc_constraint;
 
 typedef enum {
diff --git a/disas/riscv.c b/disas/riscv.c
index e464b8b075..9ec79baf4d 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1063,24 +1063,6 @@ static const rvc_constraint rvcc_ret[] = { rvc_rd_eq_x0, rvc_rs1_eq_ra,
                                            rvc_end };
 static const rvc_constraint rvcc_jr[] = { rvc_rd_eq_x0, rvc_imm_eq_zero,
                                           rvc_end };
-static const rvc_constraint rvcc_rdcycle[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc00,
-                                               rvc_end };
-static const rvc_constraint rvcc_rdtime[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc01,
-                                              rvc_end };
-static const rvc_constraint rvcc_rdinstret[] = { rvc_rs1_eq_x0,
-                                                 rvc_csr_eq_0xc02, rvc_end };
-static const rvc_constraint rvcc_rdcycleh[] = { rvc_rs1_eq_x0,
-                                                rvc_csr_eq_0xc80, rvc_end };
-static const rvc_constraint rvcc_rdtimeh[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc81,
-                                               rvc_end };
-static const rvc_constraint rvcc_rdinstreth[] = { rvc_rs1_eq_x0,
-                                                  rvc_csr_eq_0xc82, rvc_end };
-static const rvc_constraint rvcc_frcsr[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x003,
-                                             rvc_end };
-static const rvc_constraint rvcc_frrm[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x002,
-                                            rvc_end };
-static const rvc_constraint rvcc_frflags[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x001,
-                                               rvc_end };
 static const rvc_constraint rvcc_fsrmi[] = { rvc_csr_eq_0x002, rvc_end };
 static const rvc_constraint rvcc_fsflagsi[] = { rvc_csr_eq_0x001, rvc_end };
 
@@ -1163,19 +1145,6 @@ static const rv_comp_data rvcp_subw[] = {
     { rv_op_illegal, NULL }
 };
 
-static const rv_comp_data rvcp_csrrs[] = {
-    { rv_op_rdcycle, rvcc_rdcycle },
-    { rv_op_rdtime, rvcc_rdtime },
-    { rv_op_rdinstret, rvcc_rdinstret },
-    { rv_op_rdcycleh, rvcc_rdcycleh },
-    { rv_op_rdtimeh, rvcc_rdtimeh },
-    { rv_op_rdinstreth, rvcc_rdinstreth },
-    { rv_op_frcsr, rvcc_frcsr },
-    { rv_op_frrm, rvcc_frrm },
-    { rv_op_frflags, rvcc_frflags },
-    { rv_op_illegal, NULL }
-};
-
 static const rv_comp_data rvcp_csrrwi[] = {
     { rv_op_fsrmi, rvcc_fsrmi },
     { rv_op_fsflagsi, rvcc_fsflagsi },
@@ -1751,7 +1720,7 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "sfence.vma", rv_codec_r, rv_fmt_rs1_rs2 },
     { "wfi", rv_codec_none, rv_fmt_none },
     { "csrrw", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
-    { "csrrs", rv_codec_i_csr, rv_fmt_rd_csr_rs1, rvcp_csrrs },
+    { "csrrs", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
     { "csrrc", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
     { "csrrwi", rv_codec_i_csr, rv_fmt_rd_csr_zimm, rvcp_csrrwi },
     { "csrrsi", rv_codec_i_csr, rv_fmt_rd_csr_zimm },
@@ -4440,7 +4409,22 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 default: op = rv_op_csrrw; break;
                 }
                 break;
-            case 2: op = rv_op_csrrs; break;
+            case 2:
+                op = rv_op_csrrs;
+                if (operand_rs1(inst) == 0) {
+                    switch (operand_csr12(inst)) {
+                    case 0x001: op = rv_op_frflags; break;
+                    case 0x002: op = rv_op_frrm; break;
+                    case 0x003: op = rv_op_frcsr; break;
+                    case 0xc00: op = rv_op_rdcycle; break;
+                    case 0xc01: op = rv_op_rdtime; break;
+                    case 0xc02: op = rv_op_rdinstret; break;
+                    case 0xc80: op = rv_op_rdcycleh; break;
+                    case 0xc81: op = rv_op_rdtimeh; break;
+                    case 0xc82: op = rv_op_rdinstreth; break;
+                    }
+                }
+                break;
             case 3: op = rv_op_csrrc; break;
             case 4:
                 if (dec->cfg && dec->cfg->ext_zimop) {
@@ -5017,41 +5001,6 @@ static bool check_constraints(rv_decode *dec, const rvc_constraint *c)
                 return false;
             }
             break;
-        case rvc_csr_eq_0x003:
-            if (!(imm == 0x003)) {
-                return false;
-            }
-            break;
-        case rvc_csr_eq_0xc00:
-            if (!(imm == 0xc00)) {
-                return false;
-            }
-            break;
-        case rvc_csr_eq_0xc01:
-            if (!(imm == 0xc01)) {
-                return false;
-            }
-            break;
-        case rvc_csr_eq_0xc02:
-            if (!(imm == 0xc02)) {
-                return false;
-            }
-            break;
-        case rvc_csr_eq_0xc80:
-            if (!(imm == 0xc80)) {
-                return false;
-            }
-            break;
-        case rvc_csr_eq_0xc81:
-            if (!(imm == 0xc81)) {
-                return false;
-            }
-            break;
-        case rvc_csr_eq_0xc82:
-            if (!(imm == 0xc82)) {
-                return false;
-            }
-            break;
         default: break;
         }
         c++;
-- 
2.54.0



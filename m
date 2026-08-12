Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD08AC5DF65
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHUd-0007Pf-Pu; Wed, 12 Aug 2026 18:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUc-0007Ne-0J
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:14 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUX-00012L-H4
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:13 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-cb5b8572b70so1830227a12.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573928; x=1787178728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2Bx5O1ZI1QVZYD6dmG1bvsgZHVfVQdv6GanJptb3UeQ=;
 b=OM0XmJlGOOtlTZDTDZcJ/vDouccKX+qMg5WKGgSMRHCR5MsXuP3+4YrIOQ0zH4W4So
 IQVVyCRZbO/TY5XnUduIiPIBl8L72vs5vu5eR+xw7IMd7v5lQkyeilEfAjlI8RbrXXJB
 OLTOVLjihgCP4HbRYJQoxGSKEwg8KVNqSfYmGIgn2IqUy4B2FsGHApkw6uIgZjK0IfWl
 GIe/RE6LVmOfKKW7ul0DYgx7HmkVqc/VbQauKq4BEqYVZo5AfT3ezOk31ONOs/OSU4fn
 cGiouT9h1WywUkVaDbFNwyUPuwqAyNAoXcvvfo0AhDL3pkXP7jnO18gaGPVzjbKQznPg
 mLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573928; x=1787178728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2Bx5O1ZI1QVZYD6dmG1bvsgZHVfVQdv6GanJptb3UeQ=;
 b=Y9xjVH5pLiXrsb6QvW6OH3nd8zADG89hpzZbaH7iIQmkhsClxCO/gTfeQJtAs/K7Vi
 RaU8hqVTGVRPyEEL53MRvYGsMdHUAoI2RmDfaJFCLWcT6FmaGdQplcLh2EzZZmHc0oW6
 ljQhJPQ9qG3qJdsUsJ0sq74PX6is/5Myxxtz5Nm8W2KXilYW6gwReH/VM0+67+tc56p4
 JyNyqQhnTThUvoluyyaiRa856XhDbCrJ1hDXj5PRrglGaPRCJEKmVCMaaMgwXL7Mqsj+
 clVsOlFL4Y+7Pkk+RYNkwLxjUagp3EDfnWnvDDI7BkO4bFzbGjLNtRS+3gX4D6a1HWg+
 2/pg==
X-Gm-Message-State: AOJu0YySgNiiIEnC7Zd7itpWgz7PT4q+VZTlllN4oxTpqiIss71gqiiw
 zoQqhUfto1KQilNkJ8RXNCznhICAjtJIHd+6m2DYxFMH4mBVt4hQOMiR1sZ/ULMrqsoYuknEQw2
 IjT86
X-Gm-Gg: AR+sD10wSpGw84yoh/iVRdtaA4JK87iL3O7juNYnaL75AqLtPxvqY5YlxGxjwa/QVo1
 leKi4BRTvlWsQsPjLYxbghKkLNmcesS6sB007Dh5bJOqoVB94LIC4+vOHe3MLnvzhjND3PZVmrE
 b6Yh/HDSyyS42ppbMeYXYkT5fL8jlm/Kwczn02HEZej/FJ4rD2MIeq/FeSwvb0FzCHGS7HL3VPD
 YomXGEsB0Wbz4Ttlke3YRayzvnylelUV8SGZNVui/bYRXf1Q8ur4Ilxtc4wnNhldcfmknQr05W1
 Dn8mL4iOr5Z31VxE0mMG/N0XgZBAmsoSt/v+7DKIuWaTY+Y388Zg5pUgt/6+97+K2JmxQRocsME
 W/kIC5AaZezhiB2psSfJkwXm+KQpPItp1i5ttfbvigVzmUUmX+ECJpDRtPqzRDbeOxukG3NDV9F
 vtl92cN09W5nysWsxHLo7KBdlA09VJWsmevFFwLf24zqIPDE36CZPB6WCpFufn69HQxqRBFP8PL
 lHPTGkDWKfxc6hCnZZb
X-Received: by 2002:a05:6a20:c793:b0:3bf:9aa9:b2a4 with SMTP id
 adf61e73a8af0-3cc552de9dfmr2218383637.20.1786573928088; 
 Wed, 12 Aug 2026 15:32:08 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:32:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 23/52] disas/riscv: Handle aliases of csrrs during decode
Date: Wed, 12 Aug 2026 15:31:13 -0700
Message-ID: <20260812223142.349142-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.43.0



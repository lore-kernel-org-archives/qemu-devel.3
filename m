Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F62AC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtko-0004eA-7K; Wed, 19 Aug 2026 23:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtki-0004OS-VS
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:42 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkh-0004CY-Az
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:40 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38de840f2f0so1562107a91.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197658; x=1787802458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IJUxA2gEgVqA7Wq69py4RBGAGJf+JNTEdoMwMM1C2vc=;
 b=ccdl7UmauKb+4Luvcsw51T0pQgFuTjL/tRAhb/q5a64nQ0giWoxxe2pIaT+WXX84hz
 FV87i6wf5Pwu7uETQJuWjo5Znj/3JdKJ3BA5c1EaiaUYEdbvLilQTE9pbVArsyNG01EI
 sfvgI76POwxZeEWaa710ornaR3VG6fYKhybP4i63hlWoGhOhRKk3IrOgChkXKVzSo9NM
 aysHvB7cj9dvgUTLslVGk6OAns9sHEwQK5+nhF4R05GX8NABTXgnWkl8T7YSmE79+0R7
 pqhZ7+pazMD0j5KTLPDto2Z1oPAeuEdaPdl8DOEfHeuji3IFeGP7o4+9an73Ph21ijgq
 kGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197658; x=1787802458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IJUxA2gEgVqA7Wq69py4RBGAGJf+JNTEdoMwMM1C2vc=;
 b=C1L3kywKi6EcXal8uYMaunzo2R/ZLUkZkJyecxT6O2xJyPu9Hugp8udImT5UEPze5O
 TIhZXigthHeVZFmjWrwX2d5zyVOm37Dsn6CpJLjx55wiwFjXktYkusryoftUTOLPUHI9
 peSaxBRX7fSwHVXTU/xYFi6l5r8dxfXoKZrEspv//kWpynOQTnAkyTZYteKeklY6Ul2y
 tZhsqOj+npRn8R+AYdCx0j4BTQI+INH9SK86AL+jmj+zAGXTraYQcdLVriEEJ8CK7H92
 xD2WfifYrw8u/7u5KVrJ1W0+TVeCNVb75QRiC+og32A0ZNNeWiVgcmWdJhyBr4tSClFC
 xoVg==
X-Gm-Message-State: AFuF++kqPYm2zldB8tT83fxpDV4y/wiTqgZkZxvLr7YE16gHhhwXj845
 EWY51lVVfHtR3NK3npbXbu6myRj+5EiunON0UQLaNky9N+3gwvhzbbMwt8A3cw==
X-Gm-Gg: AR+sD12a/LCHrevMEwWk2pYlSBiIMtjfiEin29yvPJRZ1GVrEWVNdLEbDedQEEJ/Bhq
 LZaNefHfJuewhOEmK+BPFIserV6rZdB4edtGbptmpctH5N4rpr0b6kGKPFIv0vZ9YFvNHUwC8eh
 vsQShvU4h2AOfXzN7fGNJp0cTpyeYxLw9lEvdzvyxbvxVaHvNPoBb1SfSdShVOpFzirz3mIzL9M
 +hjjqmduqx5JKHhWoIwMTWCQ2qeKqiMnDN4lzZGqOHrvuJV8oaSK/HoMRfqjy9Epcx1CTYqorin
 Xp7jvPnnT+qv+FPAf9meJ0Z9djWgWaqXXJprUAnxU5Nd387sgRTUEUuIzPSOAScHGqCJD3QhQr1
 6irZWwCcspjOk1GQvKrISgvSk/Pz2C/nq589xtikrFENzeDA1O5eCoQukmDer/IQ0p4bG5mCwLe
 6uryF6AFtNWlVq/omY3AJQCLS7BAiRgmak1icztIoR4TqcP3RQa0R2Tn7RGGzE0yG+sr1tMBgsZ
 hy93b1FkibGGwlu
X-Received: by 2002:a17:90a:d2d0:b0:38e:7168:281 with SMTP id
 98e67ed59e1d1-395813f7597mr17687239a91.10.1787197658023; 
 Wed, 19 Aug 2026 20:47:38 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:47:37 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 60/93] disas/riscv: Handle aliases of csrrwi during decode
Date: Thu, 20 Aug 2026 13:43:57 +1000
Message-ID: <20260820034430.1186695-61-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102a.google.com
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
Message-ID: <20260812223142.349142-25-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.54.0



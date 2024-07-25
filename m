Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D906C3DA70
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Aj-0001PC-Ao; Thu, 25 Jul 2024 19:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8Ae-00013g-7r
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:52 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8Ac-0005PY-Gv
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:51 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-260e5b2dfb5so464803fac.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 16:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721951208; x=1722556008;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bfd/g3qnKmKlalH95hAzpJLDLKpqsukOO1ZJ1hRrjxo=;
 b=ARCvJmLiRApP+wSj0mfgosuQ73l9oFBCg/aWAgtn+5f6nLUiJfjEo8fG5JSCdEtSJd
 BGnOpqF96ku0Qh63tM9tMMK9ucHOG+/dj4lWS5kmTd+1xqiebhO7SibdgmdEb57evjOu
 sjdb341P9gS54hgFhAdH3SxNpXqycoiHNLLJbtGFFx01F/kszaHBlAL9wKF3bp2P1EEn
 zR0QH2tQ7NdWjtoKQJv402CaCcpBvaQ/VFVqzFuuw6g8foxDVBf42gsG/toFb32cpwIm
 +rjgBr1TupUoDMeyIFggQnOgXczIBOyAi8+nVWWGQJVjqVMVI3aS+LFS1zFn1ApLuRJ4
 bxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951208; x=1722556008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bfd/g3qnKmKlalH95hAzpJLDLKpqsukOO1ZJ1hRrjxo=;
 b=rfRtloZwfP0l7IohnXrxama7Xgu71Ty4uxlT5MnbIlDyqCrjJ++LrnRdjhV+hvrEo/
 rGr9LYyfrUf6tk483ilc7mKBzr5rznnWpO7Sfzn4BhnKZ32yxQGqWH4a/Nv/1yd4UHRy
 Fk5RPt410Pqs95KgBX20YdZtwmpc/zKx3LYDaHTFSIwDtb2EBiSnssBHzI808ZzhGG3L
 XZovc6AzoS4q/4p/H2FNDJLs4x6bBPqCoDfNETVg8QAKF/aTo54EczoXyMV2YFwBdves
 fDdhIIxJYa3O3EtqCGSVVCgaNFIzD+lKT01mldCTcTqbtRPXrjW9W2oZ7qempiJT5tbf
 RHeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFr73EKPQm+2XrVhNNT8F9cs8BfuaDUHWyxCeea+VVNNDfuSNpnzrFCCnLe944JIW0QKh+z92C88hA@nongnu.org
X-Gm-Message-State: AOJu0YxdAcYpHoBMXPJnVSEGt5GrSRQFr8n8lzPaGbeCLxEs5ty9PSkU
 n7KWn6yQ7CzzjgaVe6TZUEcmc2SmljqwT4hs2lq2ds9xUmJ2OSxVsCU4casNr7U=
X-Google-Smtp-Source: AGHT+IHoXVmXn+LxEPotC1APjvprE04G0CZCFolUXKcmTkKy7NvW7OomvTOR17WDsedu+o8GogGY/Q==
X-Received: by 2002:a05:6871:796:b0:260:e678:b657 with SMTP id
 586e51a60fabf-264a0ca319emr5377055fac.7.1721951208489; 
 Thu, 25 Jul 2024 16:46:48 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8128d0sm1647565b3a.118.2024.07.25.16.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:46:48 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH 19/24] disas/riscv: enable disassembly for zicfiss instructions
Date: Thu, 25 Jul 2024 16:46:08 -0700
Message-ID: <20240725234614.3850142-20-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240725234614.3850142-1-debug@rivosinc.com>
References: <20240725234614.3850142-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=debug@rivosinc.com; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Enable disassembly for sspush, sspopchk, ssrdp & ssamoswap.
Disasembly is only enabled if zimop and zicfiss ext is set to true.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 disas/riscv.c | 34 ++++++++++++++++++++++++++++++++++
 disas/riscv.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index c7c92acef7..c4e47fbc78 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -975,6 +975,11 @@ typedef enum {
     rv_op_amocas_b  = 944,
     rv_op_amocas_h  = 945,
     rv_op_lpad = 946,
+    rv_op_sspush = 947,
+    rv_op_sspopchk = 948,
+    rv_op_ssrdp = 949,
+    rv_op_ssamoswap_w = 950,
+    rv_op_ssamoswap_d = 951,
 } rv_op;
 
 /* register names */
@@ -2234,6 +2239,11 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "amocas.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "amocas.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "lpad", rv_codec_lp, rv_fmt_imm, NULL, 0, 0, 0 },
+    { "sspush", rv_codec_r, rv_fmt_rs2, NULL, 0, 0, 0 },
+    { "sspopchk", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
+    { "ssrdp", rv_codec_r, rv_fmt_rd, NULL, 0, 0, 0 },
+    { "ssamoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "ssamoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -2251,6 +2261,7 @@ static const char *csr_name(int csrno)
     case 0x0009: return "vxsat";
     case 0x000a: return "vxrm";
     case 0x000f: return "vcsr";
+    case 0x0011: return "ssp";
     case 0x0015: return "seed";
     case 0x0017: return "jvt";
     case 0x0040: return "uscratch";
@@ -3077,6 +3088,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 66: op = rv_op_amoor_w; break;
             case 67: op = rv_op_amoor_d; break;
             case 68: op = rv_op_amoor_q; break;
+            case 74: op = rv_op_ssamoswap_w; break;
+            case 75: op = rv_op_ssamoswap_d; break;
             case 96: op = rv_op_amoand_b; break;
             case 97: op = rv_op_amoand_h; break;
             case 98: op = rv_op_amoand_w; break;
@@ -4036,11 +4049,32 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                                                        extract32(inst, 26, 2)),
                                              4, 1, extract32(inst, 30, 1));
                         op = rv_mop_r_0 + imm_mop5;
+                        /* if zicfiss enabled and mop5 is shadow stack */
+                        if (dec->cfg->ext_zicfiss &&
+                            ((imm_mop5 & 0b11100) == 0b11100)) {
+                                /* rs1=0 means ssrdp */
+                                if ((inst & (0b011111 << 15)) == 0) {
+                                    op = rv_op_ssrdp;
+                                    }
+                                /* rd=0 means sspopchk */
+                                if ((inst & (0b011111 << 7)) == 0) {
+                                    op = rv_op_sspopchk;
+                                }
+                        }
                     } else if ((extract32(inst, 25, 7) & 0b1011001)
                                == 0b1000001) {
                         imm_mop3 = deposit32(extract32(inst, 26, 2),
                                              2, 1, extract32(inst, 30, 1));
                         op = rv_mop_rr_0 + imm_mop3;
+                        /* if zicfiss enabled and mop3 is shadow stack */
+                        if (dec->cfg->ext_zicfiss &&
+                            ((imm_mop3 & 0b111) == 0b111)) {
+                                /* rs1=0 and rd=0 means sspush */
+                                if (((inst & (0b011111 << 15)) == 0) &&
+                                    ((inst & (0b011111 << 7)) == 0)) {
+                                    op = rv_op_sspush;
+                                }
+                        }
                     }
                 }
                 break;
diff --git a/disas/riscv.h b/disas/riscv.h
index 1182457aff..4895c5a301 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -224,6 +224,7 @@ enum {
 
 #define rv_fmt_none                   "O\t"
 #define rv_fmt_rs1                    "O\t1"
+#define rv_fmt_rs2                    "O\t2"
 #define rv_fmt_offset                 "O\to"
 #define rv_fmt_pred_succ              "O\tp,s"
 #define rv_fmt_rs1_rs2                "O\t1,2"
-- 
2.44.0



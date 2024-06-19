Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77868C2BA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2Pi-0002Lk-Bh; Wed, 19 Jun 2024 17:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2Pf-0002J9-DU
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:15 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2Pc-0000d9-8E
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:15 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1f480624d0dso1643855ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 14:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830810; x=1719435610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKF85XYBPRWVEg3m5iDHLtbCWhvyq+hgk87lkUx4Hqo=;
 b=uR+gGS9HSEgrFLzqmKrKw8ZEQ6qRzVa/8vJE92YQMCcPwmHUxJytDunFtI1rZXt7yu
 rrl65NgZNqZtkwQqljaNwa1KyGd5rFQuUQnnKQZBAJnbisiyLabTOk5jAY60clm96ooi
 MTm3iMRr3bM36ytndqLIk3JK2UDjDxjM1vZsU/r3m1kF+yUt3d0soKAwv/amGMT18oM8
 vxMaqbr+PSo+V1efxtuuU7LbQqq3sVkdlWvNMt1x1l+jrlcS4Pzpnw302a+L95YhD5S0
 GfLbovbnYnjftiKxphfjxXB5lJvti77hyAxqOhlfAPWw9K4ac5TAbGYVxbxpRm3qKeCW
 wlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830810; x=1719435610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKF85XYBPRWVEg3m5iDHLtbCWhvyq+hgk87lkUx4Hqo=;
 b=RJdapb1N3hstIRNmt0rc3D9lybql3KwzCt3Izuu6jzrO0ArQhbBApbZ1eEXAqxuV0f
 7c4vLyl536DQIbwWCvDEDQDtRQsjCIJwR4W0lRTv9v1MrqXl/tilCFsRllZB0qQr9iZC
 3PJ7EFNAYpOZ14TxNSh9YAE0XHfmZrcmx2QlD1skD1Z/r1nL15S2p0xdVetBTeNRE4u9
 igAF6ocKawfoBHmKk4BKlL1fXZUWKp9rKiJ8CL6jIIUJUCVT2jBfjJUtSIwFjTt/45d4
 C9f318KM/cUGSX3QICuBFCYubzVolKdXJXTXrbVTqtbHdLzXdF2pjHAs6BpysAocnW43
 HgUQ==
X-Gm-Message-State: AOJu0YwPFfnkImLfpuuIX4KiDrmtFs2EELb8OGWJBT08SJKDyRy9Zmj/
 UkHgbyINCTT978u52nI5b81AvL/hT4zGAq2UqQgOmnJj+D2Jk0WT36wWJCfME90uMkKmqgraqnR
 d
X-Google-Smtp-Source: AGHT+IErmKnvH4ZSCh9vE1vOc0+PBVDFNaMMFgL5C52RRCSast1s4mTYROd8zq7kjdnTF9u1j6fO/Q==
X-Received: by 2002:a17:902:cece:b0:1f7:167d:e289 with SMTP id
 d9443c01a7336-1f9aa466115mr42797375ad.55.1718830809904; 
 Wed, 19 Jun 2024 14:00:09 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.14.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:00:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 17/24] tcg/loongarch64: Support LASX in tcg_out_vec_op
Date: Wed, 19 Jun 2024 13:59:45 -0700
Message-Id: <20240619205952.235946-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
References: <20240619205952.235946-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 223 +++++++++++++++++++------------
 1 file changed, 137 insertions(+), 86 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index ab1b67e028..dff966c395 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1833,76 +1833,125 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            const int const_args[TCG_MAX_OP_ARGS])
 {
     TCGType type = vecl + TCG_TYPE_V64;
+    bool lasx = type == TCG_TYPE_V256;
     TCGArg a0, a1, a2, a3;
-
-    static const LoongArchInsn cmp_vec_insn[16][4] = {
-        [TCG_COND_EQ] = {OPC_VSEQ_B, OPC_VSEQ_H, OPC_VSEQ_W, OPC_VSEQ_D},
-        [TCG_COND_LE] = {OPC_VSLE_B, OPC_VSLE_H, OPC_VSLE_W, OPC_VSLE_D},
-        [TCG_COND_LEU] = {OPC_VSLE_BU, OPC_VSLE_HU, OPC_VSLE_WU, OPC_VSLE_DU},
-        [TCG_COND_LT] = {OPC_VSLT_B, OPC_VSLT_H, OPC_VSLT_W, OPC_VSLT_D},
-        [TCG_COND_LTU] = {OPC_VSLT_BU, OPC_VSLT_HU, OPC_VSLT_WU, OPC_VSLT_DU},
-    };
-    static const LoongArchInsn cmp_vec_imm_insn[16][4] = {
-        [TCG_COND_EQ] = {OPC_VSEQI_B, OPC_VSEQI_H, OPC_VSEQI_W, OPC_VSEQI_D},
-        [TCG_COND_LE] = {OPC_VSLEI_B, OPC_VSLEI_H, OPC_VSLEI_W, OPC_VSLEI_D},
-        [TCG_COND_LEU] = {OPC_VSLEI_BU, OPC_VSLEI_HU, OPC_VSLEI_WU, OPC_VSLEI_DU},
-        [TCG_COND_LT] = {OPC_VSLTI_B, OPC_VSLTI_H, OPC_VSLTI_W, OPC_VSLTI_D},
-        [TCG_COND_LTU] = {OPC_VSLTI_BU, OPC_VSLTI_HU, OPC_VSLTI_WU, OPC_VSLTI_DU},
-    };
     LoongArchInsn insn;
-    static const LoongArchInsn neg_vec_insn[4] = {
-        OPC_VNEG_B, OPC_VNEG_H, OPC_VNEG_W, OPC_VNEG_D
+
+    static const LoongArchInsn cmp_vec_insn[16][2][4] = {
+        [TCG_COND_EQ] = {
+            { OPC_VSEQ_B, OPC_VSEQ_H, OPC_VSEQ_W, OPC_VSEQ_D },
+            { OPC_XVSEQ_B, OPC_XVSEQ_H, OPC_XVSEQ_W, OPC_XVSEQ_D },
+        },
+        [TCG_COND_LE] = {
+            { OPC_VSLE_B, OPC_VSLE_H, OPC_VSLE_W, OPC_VSLE_D },
+            { OPC_XVSLE_B, OPC_XVSLE_H, OPC_XVSLE_W, OPC_XVSLE_D },
+        },
+        [TCG_COND_LEU] = {
+            { OPC_VSLE_BU, OPC_VSLE_HU, OPC_VSLE_WU, OPC_VSLE_DU },
+            { OPC_XVSLE_BU, OPC_XVSLE_HU, OPC_XVSLE_WU, OPC_XVSLE_DU },
+        },
+        [TCG_COND_LT] = {
+            { OPC_VSLT_B, OPC_VSLT_H, OPC_VSLT_W, OPC_VSLT_D },
+            { OPC_XVSLT_B, OPC_XVSLT_H, OPC_XVSLT_W, OPC_XVSLT_D },
+        },
+        [TCG_COND_LTU] = {
+            { OPC_VSLT_BU, OPC_VSLT_HU, OPC_VSLT_WU, OPC_VSLT_DU },
+            { OPC_XVSLT_BU, OPC_XVSLT_HU, OPC_XVSLT_WU, OPC_XVSLT_DU },
+        }
     };
-    static const LoongArchInsn mul_vec_insn[4] = {
-        OPC_VMUL_B, OPC_VMUL_H, OPC_VMUL_W, OPC_VMUL_D
+    static const LoongArchInsn cmp_vec_imm_insn[16][2][4] = {
+        [TCG_COND_EQ] = {
+            { OPC_VSEQI_B, OPC_VSEQI_H, OPC_VSEQI_W, OPC_VSEQI_D },
+            { OPC_XVSEQI_B, OPC_XVSEQI_H, OPC_XVSEQI_W, OPC_XVSEQI_D },
+        },
+        [TCG_COND_LE] = {
+            { OPC_VSLEI_B, OPC_VSLEI_H, OPC_VSLEI_W, OPC_VSLEI_D },
+            { OPC_XVSLEI_B, OPC_XVSLEI_H, OPC_XVSLEI_W, OPC_XVSLEI_D },
+        },
+        [TCG_COND_LEU] = {
+            { OPC_VSLEI_BU, OPC_VSLEI_HU, OPC_VSLEI_WU, OPC_VSLEI_DU },
+            { OPC_XVSLEI_BU, OPC_XVSLEI_HU, OPC_XVSLEI_WU, OPC_XVSLEI_DU },
+        },
+        [TCG_COND_LT] = {
+            { OPC_VSLTI_B, OPC_VSLTI_H, OPC_VSLTI_W, OPC_VSLTI_D },
+            { OPC_XVSLTI_B, OPC_XVSLTI_H, OPC_XVSLTI_W, OPC_XVSLTI_D },
+        },
+        [TCG_COND_LTU] = {
+            { OPC_VSLTI_BU, OPC_VSLTI_HU, OPC_VSLTI_WU, OPC_VSLTI_DU },
+            { OPC_XVSLTI_BU, OPC_XVSLTI_HU, OPC_XVSLTI_WU, OPC_XVSLTI_DU },
+        }
     };
-    static const LoongArchInsn smin_vec_insn[4] = {
-        OPC_VMIN_B, OPC_VMIN_H, OPC_VMIN_W, OPC_VMIN_D
+    static const LoongArchInsn neg_vec_insn[2][4] = {
+        { OPC_VNEG_B, OPC_VNEG_H, OPC_VNEG_W, OPC_VNEG_D },
+        { OPC_XVNEG_B, OPC_XVNEG_H, OPC_XVNEG_W, OPC_XVNEG_D },
     };
-    static const LoongArchInsn umin_vec_insn[4] = {
-        OPC_VMIN_BU, OPC_VMIN_HU, OPC_VMIN_WU, OPC_VMIN_DU
+    static const LoongArchInsn mul_vec_insn[2][4] = {
+        { OPC_VMUL_B, OPC_VMUL_H, OPC_VMUL_W, OPC_VMUL_D },
+        { OPC_XVMUL_B, OPC_XVMUL_H, OPC_XVMUL_W, OPC_XVMUL_D },
     };
-    static const LoongArchInsn smax_vec_insn[4] = {
-        OPC_VMAX_B, OPC_VMAX_H, OPC_VMAX_W, OPC_VMAX_D
+    static const LoongArchInsn smin_vec_insn[2][4] = {
+        { OPC_VMIN_B, OPC_VMIN_H, OPC_VMIN_W, OPC_VMIN_D },
+        { OPC_XVMIN_B, OPC_XVMIN_H, OPC_XVMIN_W, OPC_XVMIN_D },
     };
-    static const LoongArchInsn umax_vec_insn[4] = {
-        OPC_VMAX_BU, OPC_VMAX_HU, OPC_VMAX_WU, OPC_VMAX_DU
+    static const LoongArchInsn umin_vec_insn[2][4] = {
+        { OPC_VMIN_BU, OPC_VMIN_HU, OPC_VMIN_WU, OPC_VMIN_DU },
+        { OPC_XVMIN_BU, OPC_XVMIN_HU, OPC_XVMIN_WU, OPC_XVMIN_DU },
     };
-    static const LoongArchInsn ssadd_vec_insn[4] = {
-        OPC_VSADD_B, OPC_VSADD_H, OPC_VSADD_W, OPC_VSADD_D
+    static const LoongArchInsn smax_vec_insn[2][4] = {
+        { OPC_VMAX_B, OPC_VMAX_H, OPC_VMAX_W, OPC_VMAX_D },
+        { OPC_XVMAX_B, OPC_XVMAX_H, OPC_XVMAX_W, OPC_XVMAX_D },
     };
-    static const LoongArchInsn usadd_vec_insn[4] = {
-        OPC_VSADD_BU, OPC_VSADD_HU, OPC_VSADD_WU, OPC_VSADD_DU
+    static const LoongArchInsn umax_vec_insn[2][4] = {
+        { OPC_VMAX_BU, OPC_VMAX_HU, OPC_VMAX_WU, OPC_VMAX_DU },
+        { OPC_XVMAX_BU, OPC_XVMAX_HU, OPC_XVMAX_WU, OPC_XVMAX_DU },
     };
-    static const LoongArchInsn sssub_vec_insn[4] = {
-        OPC_VSSUB_B, OPC_VSSUB_H, OPC_VSSUB_W, OPC_VSSUB_D
+    static const LoongArchInsn ssadd_vec_insn[2][4] = {
+        { OPC_VSADD_B, OPC_VSADD_H, OPC_VSADD_W, OPC_VSADD_D },
+        { OPC_XVSADD_B, OPC_XVSADD_H, OPC_XVSADD_W, OPC_XVSADD_D },
     };
-    static const LoongArchInsn ussub_vec_insn[4] = {
-        OPC_VSSUB_BU, OPC_VSSUB_HU, OPC_VSSUB_WU, OPC_VSSUB_DU
+    static const LoongArchInsn usadd_vec_insn[2][4] = {
+        { OPC_VSADD_BU, OPC_VSADD_HU, OPC_VSADD_WU, OPC_VSADD_DU },
+        { OPC_XVSADD_BU, OPC_XVSADD_HU, OPC_XVSADD_WU, OPC_XVSADD_DU },
     };
-    static const LoongArchInsn shlv_vec_insn[4] = {
-        OPC_VSLL_B, OPC_VSLL_H, OPC_VSLL_W, OPC_VSLL_D
+    static const LoongArchInsn sssub_vec_insn[2][4] = {
+        { OPC_VSSUB_B, OPC_VSSUB_H, OPC_VSSUB_W, OPC_VSSUB_D },
+        { OPC_XVSSUB_B, OPC_XVSSUB_H, OPC_XVSSUB_W, OPC_XVSSUB_D },
     };
-    static const LoongArchInsn shrv_vec_insn[4] = {
-        OPC_VSRL_B, OPC_VSRL_H, OPC_VSRL_W, OPC_VSRL_D
+    static const LoongArchInsn ussub_vec_insn[2][4] = {
+        { OPC_VSSUB_BU, OPC_VSSUB_HU, OPC_VSSUB_WU, OPC_VSSUB_DU },
+        { OPC_XVSSUB_BU, OPC_XVSSUB_HU, OPC_XVSSUB_WU, OPC_XVSSUB_DU },
     };
-    static const LoongArchInsn sarv_vec_insn[4] = {
-        OPC_VSRA_B, OPC_VSRA_H, OPC_VSRA_W, OPC_VSRA_D
+    static const LoongArchInsn shlv_vec_insn[2][4] = {
+        { OPC_VSLL_B, OPC_VSLL_H, OPC_VSLL_W, OPC_VSLL_D },
+        { OPC_XVSLL_B, OPC_XVSLL_H, OPC_XVSLL_W, OPC_XVSLL_D },
     };
-    static const LoongArchInsn shli_vec_insn[4] = {
-        OPC_VSLLI_B, OPC_VSLLI_H, OPC_VSLLI_W, OPC_VSLLI_D
+    static const LoongArchInsn shrv_vec_insn[2][4] = {
+        { OPC_VSRL_B, OPC_VSRL_H, OPC_VSRL_W, OPC_VSRL_D },
+        { OPC_XVSRL_B, OPC_XVSRL_H, OPC_XVSRL_W, OPC_XVSRL_D },
     };
-    static const LoongArchInsn shri_vec_insn[4] = {
-        OPC_VSRLI_B, OPC_VSRLI_H, OPC_VSRLI_W, OPC_VSRLI_D
+    static const LoongArchInsn sarv_vec_insn[2][4] = {
+        { OPC_VSRA_B, OPC_VSRA_H, OPC_VSRA_W, OPC_VSRA_D },
+        { OPC_XVSRA_B, OPC_XVSRA_H, OPC_XVSRA_W, OPC_XVSRA_D },
     };
-    static const LoongArchInsn sari_vec_insn[4] = {
-        OPC_VSRAI_B, OPC_VSRAI_H, OPC_VSRAI_W, OPC_VSRAI_D
+    static const LoongArchInsn shli_vec_insn[2][4] = {
+        { OPC_VSLLI_B, OPC_VSLLI_H, OPC_VSLLI_W, OPC_VSLLI_D },
+        { OPC_XVSLLI_B, OPC_XVSLLI_H, OPC_XVSLLI_W, OPC_XVSLLI_D },
     };
-    static const LoongArchInsn rotrv_vec_insn[4] = {
-        OPC_VROTR_B, OPC_VROTR_H, OPC_VROTR_W, OPC_VROTR_D
+    static const LoongArchInsn shri_vec_insn[2][4] = {
+        { OPC_VSRLI_B, OPC_VSRLI_H, OPC_VSRLI_W, OPC_VSRLI_D },
+        { OPC_XVSRLI_B, OPC_XVSRLI_H, OPC_XVSRLI_W, OPC_XVSRLI_D },
     };
-    static const LoongArchInsn rotri_vec_insn[4] = {
-        OPC_VROTRI_B, OPC_VROTRI_H, OPC_VROTRI_W, OPC_VROTRI_D
+    static const LoongArchInsn sari_vec_insn[2][4] = {
+        { OPC_VSRAI_B, OPC_VSRAI_H, OPC_VSRAI_W, OPC_VSRAI_D },
+        { OPC_XVSRAI_B, OPC_XVSRAI_H, OPC_XVSRAI_W, OPC_XVSRAI_D },
+    };
+    static const LoongArchInsn rotrv_vec_insn[2][4] = {
+        { OPC_VROTR_B, OPC_VROTR_H, OPC_VROTR_W, OPC_VROTR_D },
+        { OPC_XVROTR_B, OPC_XVROTR_H, OPC_XVROTR_W, OPC_XVROTR_D },
+    };
+    static const LoongArchInsn rotri_vec_insn[2][4] = {
+        { OPC_VROTRI_B, OPC_VROTRI_H, OPC_VROTRI_W, OPC_VROTRI_D },
+        { OPC_XVROTRI_B, OPC_XVROTRI_H, OPC_XVROTRI_W, OPC_XVROTRI_D },
     };
 
     a0 = args[0];
@@ -1910,9 +1959,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     a2 = args[2];
     a3 = args[3];
 
-    /* Currently only supports V64 & V128 */
-    tcg_debug_assert(type == TCG_TYPE_V64 || type == TCG_TYPE_V128);
-
     switch (opc) {
     case INDEX_op_st_vec:
         tcg_out_st(s, type, a0, a1, a2);
@@ -1921,7 +1967,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out_ld(s, type, a0, a1, a2);
         break;
     case INDEX_op_and_vec:
-        insn = OPC_VAND_V;
+        insn = lasx ? OPC_XVAND_V : OPC_VAND_V;
         goto vdvjvk;
     case INDEX_op_andc_vec:
         /*
@@ -1931,22 +1977,22 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
          */
         a1 = a2;
         a2 = args[1];
-        insn = OPC_VANDN_V;
+        insn = lasx ? OPC_XVANDN_V : OPC_VANDN_V;
         goto vdvjvk;
     case INDEX_op_or_vec:
-        insn = OPC_VOR_V;
+        insn = lasx ? OPC_XVOR_V : OPC_VOR_V;
         goto vdvjvk;
     case INDEX_op_orc_vec:
-        insn = OPC_VORN_V;
+        insn = lasx ? OPC_XVORN_V : OPC_VORN_V;
         goto vdvjvk;
     case INDEX_op_xor_vec:
-        insn = OPC_VXOR_V;
+        insn = lasx ? OPC_XVXOR_V : OPC_VXOR_V;
         goto vdvjvk;
     case INDEX_op_not_vec:
         a2 = a1;
         /* fall through */
     case INDEX_op_nor_vec:
-        insn = OPC_VNOR_V;
+        insn = lasx ? OPC_XVNOR_V : OPC_VNOR_V;
         goto vdvjvk;
     case INDEX_op_cmp_vec:
         {
@@ -1962,13 +2008,13 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                      cond == TCG_COND_LE ||
                      cond == TCG_COND_LT) &&
                     (-0x10 <= value && value <= 0x0f)) {
-                    insn = cmp_vec_imm_insn[cond][vece];
+                    insn = cmp_vec_imm_insn[cond][lasx][vece];
                     tcg_out32(s, encode_vdvjsk5_insn(insn, a0, a1, value));
                     break;
                 } else if ((cond == TCG_COND_LEU ||
                             cond == TCG_COND_LTU) &&
                            (0x00 <= value && value <= 0x1f)) {
-                    insn = cmp_vec_imm_insn[cond][vece];
+                    insn = cmp_vec_imm_insn[cond][lasx][vece];
                     tcg_out32(s, encode_vdvjuk5_insn(insn, a0, a1, value));
                     break;
                 }
@@ -1982,86 +2028,91 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                 a2 = TCG_VEC_TMP0;
             }
 
-            insn = cmp_vec_insn[cond][vece];
+            insn = cmp_vec_insn[cond][lasx][vece];
             if (insn == 0) {
                 TCGArg t;
                 t = a1, a1 = a2, a2 = t;
                 cond = tcg_swap_cond(cond);
-                insn = cmp_vec_insn[cond][vece];
+                insn = cmp_vec_insn[cond][lasx][vece];
                 tcg_debug_assert(insn != 0);
             }
         }
         goto vdvjvk;
     case INDEX_op_add_vec:
-        tcg_out_addsub_vec(s, false, vece, a0, a1, a2, const_args[2], true);
+        tcg_out_addsub_vec(s, lasx, vece, a0, a1, a2, const_args[2], true);
         break;
     case INDEX_op_sub_vec:
-        tcg_out_addsub_vec(s, false, vece, a0, a1, a2, const_args[2], false);
+        tcg_out_addsub_vec(s, lasx, vece, a0, a1, a2, const_args[2], false);
         break;
     case INDEX_op_neg_vec:
-        tcg_out32(s, encode_vdvj_insn(neg_vec_insn[vece], a0, a1));
+        tcg_out32(s, encode_vdvj_insn(neg_vec_insn[lasx][vece], a0, a1));
         break;
     case INDEX_op_mul_vec:
-        insn = mul_vec_insn[vece];
+        insn = mul_vec_insn[lasx][vece];
         goto vdvjvk;
     case INDEX_op_smin_vec:
-        insn = smin_vec_insn[vece];
+        insn = smin_vec_insn[lasx][vece];
         goto vdvjvk;
     case INDEX_op_smax_vec:
-        insn = smax_vec_insn[vece];
+        insn = smax_vec_insn[lasx][vece];
         goto vdvjvk;
     case INDEX_op_umin_vec:
-        insn = umin_vec_insn[vece];
+        insn = umin_vec_insn[lasx][vece];
         goto vdvjvk;
     case INDEX_op_umax_vec:
-        insn = umax_vec_insn[vece];
+        insn = umax_vec_insn[lasx][vece];
         goto vdvjvk;
     case INDEX_op_ssadd_vec:
-        insn = ssadd_vec_insn[vece];
+        insn = ssadd_vec_insn[lasx][vece];
         goto vdvjvk;
     case INDEX_op_usadd_vec:
-        insn = usadd_vec_insn[vece];
+        insn = usadd_vec_insn[lasx][vece];
         goto vdvjvk;
     case INDEX_op_sssub_vec:
-        insn = sssub_vec_insn[vece];
+        insn = sssub_vec_insn[lasx][vece];
         goto vdvjvk;
     case INDEX_op_ussub_vec:
-        insn = ussub_vec_insn[vece];
+        insn = ussub_vec_insn[lasx][vece];
         goto vdvjvk;
     case INDEX_op_shlv_vec:
-        insn = shlv_vec_insn[vece];
+        insn = shlv_vec_insn[lasx][vece];
         goto vdvjvk;
     case INDEX_op_shrv_vec:
-        insn = shrv_vec_insn[vece];
+        insn = shrv_vec_insn[lasx][vece];
         goto vdvjvk;
     case INDEX_op_sarv_vec:
-        insn = sarv_vec_insn[vece];
+        insn = sarv_vec_insn[lasx][vece];
         goto vdvjvk;
     case INDEX_op_rotlv_vec:
         /* rotlv_vec a1, a2 = rotrv_vec a1, -a2 */
-        tcg_out32(s, encode_vdvj_insn(neg_vec_insn[vece], TCG_VEC_TMP0, a2));
+        tcg_out32(s, encode_vdvj_insn(neg_vec_insn[lasx][vece],
+                                      TCG_VEC_TMP0, a2));
         a2 = TCG_VEC_TMP0;
         /* fall through */
     case INDEX_op_rotrv_vec:
-        insn = rotrv_vec_insn[vece];
+        insn = rotrv_vec_insn[lasx][vece];
         goto vdvjvk;
     case INDEX_op_shli_vec:
-        insn = shli_vec_insn[vece];
+        insn = shli_vec_insn[lasx][vece];
         goto vdvjukN;
     case INDEX_op_shri_vec:
-        insn = shri_vec_insn[vece];
+        insn = shri_vec_insn[lasx][vece];
         goto vdvjukN;
     case INDEX_op_sari_vec:
-        insn = sari_vec_insn[vece];
+        insn = sari_vec_insn[lasx][vece];
         goto vdvjukN;
     case INDEX_op_rotli_vec:
         /* rotli_vec a1, a2 = rotri_vec a1, -a2 */
         a2 = extract32(-a2, 0, 3 + vece);
-        insn = rotri_vec_insn[vece];
+        insn = rotri_vec_insn[lasx][vece];
         goto vdvjukN;
     case INDEX_op_bitsel_vec:
         /* vbitsel vd, vj, vk, va = bitsel_vec vd, va, vk, vj */
-        tcg_out_opc_vbitsel_v(s, a0, a3, a2, a1);
+        if (lasx) {
+            tcg_out_opc_xvbitsel_v(s, a0, a3, a2, a1);
+        } else {
+            tcg_out_opc_vbitsel_v(s, a0, a3, a2, a1);
+        }
         break;
     case INDEX_op_dupm_vec:
         tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
-- 
2.34.1



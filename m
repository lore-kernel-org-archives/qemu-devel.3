Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6829CEE0206
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 16:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soQYu-0003iR-G5; Wed, 11 Sep 2024 12:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYc-0002cU-KP
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:51:07 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYb-0003gv-1D
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:51:06 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-71798661a52so295b3a.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 09:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726073462; x=1726678262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yckJKrmE4doUh/0H+FLLTMdnHyJQpPXJPtVZq1bwd4E=;
 b=GCfVeQAWZqMGq7yuoGkQJeEzAClek/1s4J9QXEQMmK+WujmsiPPilzcFFUAPnX1CeJ
 xVSoSw9/wficOqIZw7Wr6MlFsk1tlBdZJRMzHDY5LBiIHThEChmKz+zNiDnv04x/W7sD
 VpHuJUMiej34dEuefF6rO/9DZkS+saQKBsa9P9H8E+SeXr/RE2RH9ngN90YfcTXCiXwa
 V3pgJrDZtBWyLCniWe59BCg6j7Eduulve79dqep899L64ofDfb1TJM0P2HCwjfx7ZjTb
 2OsjUiuC6mSp5uMSY1ntFYc1xT4zzDBRY41np/ipz+W6jbS05vQuMSfLwHtkQfn2H5ky
 O+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726073462; x=1726678262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yckJKrmE4doUh/0H+FLLTMdnHyJQpPXJPtVZq1bwd4E=;
 b=MbzNUUPOMBZQUym64qVP6m8HOtufXOhsx+acg/D3SkPGn9r6hNy56zIzbLZGXXUHH7
 K2BNYF3jnlfzECeYK7WdbUs5Cy3DMDMqEoIlhkleZft5cuKD9v1vNhBu15vMjWDPjumk
 OGBEt+yJ93fpMjfz6ovro65brSqg0Emf7HF/XrpjCHwPgK+DhO3Q/SiGmyWcruA5CG2b
 JwwhDxjsiotx4pN4TlYOjn1gQakYSRZrFGZKe+Ctq6B/kRcGbIMbXG603tZU5zRqNO12
 Om+CF2Vyw+2IyOQmFOBKCj4SNKgP9DepsksiQIFxELtcZNKEHIv1G5EPCuSIp6IK9+4H
 z9TQ==
X-Gm-Message-State: AOJu0YzgUilla3NTVvtZlcZqAKOcLktM4mCBTqy0N/y7Pc61na83q6WF
 rJapjS3mibWbb0QATTZtJUaPEsxlVTee/q0KUgTdANzeQy94BzsGLrH9BmIcYp5JM7MhQrNkRZh
 0
X-Google-Smtp-Source: AGHT+IEzBw0OIyfANDFPTB4uwT6VtbQR838iCS9GB/82YawqeeA4Uqg1YVSAzrSQpX/lqBV+trdeyw==
X-Received: by 2002:a05:6a00:124e:b0:70d:2a1b:422c with SMTP id
 d2e1a72fcca58-71907ee1396mr10585803b3a.7.1726073462284; 
 Wed, 11 Sep 2024 09:51:02 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe4e7esm3186947b3a.80.2024.09.11.09.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 09:51:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 philmd@linaro.org
Subject: [PATCH v2 14/18] tcg/i386: Implement vector TST{EQ,NE} for avx512
Date: Wed, 11 Sep 2024 09:50:43 -0700
Message-ID: <20240911165047.1035764-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911165047.1035764-1-richard.henderson@linaro.org>
References: <20240911165047.1035764-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  2 +-
 tcg/i386/tcg-target.c.inc | 31 ++++++++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 342be30c4c..c68ac023d8 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -224,7 +224,7 @@ typedef enum {
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       have_avx512vl
 #define TCG_TARGET_HAS_cmpsel_vec       1
-#define TCG_TARGET_HAS_tst_vec          0
+#define TCG_TARGET_HAS_tst_vec          have_avx512bw
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
     (((ofs) == 0 && ((len) == 8 || (len) == 16)) || \
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index d473dc7a5e..1bf50f1f62 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -462,6 +462,14 @@ static bool tcg_target_const_match(int64_t val, int ct,
 #define OPC_VPSRLVD     (0x45 | P_EXT38 | P_DATA16)
 #define OPC_VPSRLVQ     (0x45 | P_EXT38 | P_DATA16 | P_VEXW)
 #define OPC_VPTERNLOGQ  (0x25 | P_EXT3A | P_DATA16 | P_VEXW | P_EVEX)
+#define OPC_VPTESTMB    (0x26 | P_EXT38 | P_DATA16 | P_EVEX)
+#define OPC_VPTESTMW    (0x26 | P_EXT38 | P_DATA16 | P_VEXW | P_EVEX)
+#define OPC_VPTESTMD    (0x27 | P_EXT38 | P_DATA16 | P_EVEX)
+#define OPC_VPTESTMQ    (0x27 | P_EXT38 | P_DATA16 | P_VEXW | P_EVEX)
+#define OPC_VPTESTNMB   (0x26 | P_EXT38 | P_SIMDF3 | P_EVEX)
+#define OPC_VPTESTNMW   (0x26 | P_EXT38 | P_SIMDF3 | P_VEXW | P_EVEX)
+#define OPC_VPTESTNMD   (0x27 | P_EXT38 | P_SIMDF3 | P_EVEX)
+#define OPC_VPTESTNMQ   (0x27 | P_EXT38 | P_SIMDF3 | P_VEXW | P_EVEX)
 #define OPC_VZEROUPPER  (0x77 | P_EXT)
 #define OPC_XCHG_ax_r32	(0x90)
 #define OPC_XCHG_EvGv   (0x87)
@@ -3145,6 +3153,13 @@ static void tcg_out_cmp_vec_k1(TCGContext *s, TCGType type, unsigned vece,
         { OPC_VPCMPB, OPC_VPCMPW, OPC_VPCMPD, OPC_VPCMPQ },
         { OPC_VPCMPUB, OPC_VPCMPUW, OPC_VPCMPUD, OPC_VPCMPUQ }
     };
+    static const int testm_insn[4] = {
+        OPC_VPTESTMB, OPC_VPTESTMW, OPC_VPTESTMD, OPC_VPTESTMQ
+    };
+    static const int testnm_insn[4] = {
+        OPC_VPTESTNMB, OPC_VPTESTNMW, OPC_VPTESTNMD, OPC_VPTESTNMQ
+    };
+
     static const int cond_ext[16] = {
         [TCG_COND_EQ] = 0,
         [TCG_COND_NE] = 4,
@@ -3160,9 +3175,19 @@ static void tcg_out_cmp_vec_k1(TCGContext *s, TCGType type, unsigned vece,
         [TCG_COND_ALWAYS] = 7,
     };
 
-    tcg_out_vex_modrm_type(s, cmpm_insn[is_unsigned_cond(cond)][vece],
-                           /* k1 */ 1, v1, v2, type);
-    tcg_out8(s, cond_ext[cond]);
+    switch (cond) {
+    case TCG_COND_TSTNE:
+        tcg_out_vex_modrm_type(s, testm_insn[vece], /* k1 */ 1, v1, v2, type);
+        break;
+    case TCG_COND_TSTEQ:
+        tcg_out_vex_modrm_type(s, testnm_insn[vece], /* k1 */ 1, v1, v2, type);
+        break;
+    default:
+        tcg_out_vex_modrm_type(s, cmpm_insn[is_unsigned_cond(cond)][vece],
+                               /* k1 */ 1, v1, v2, type);
+        tcg_out8(s, cond_ext[cond]);
+        break;
+    }
 }
 
 static void tcg_out_k1_to_vec(TCGContext *s, TCGType type,
-- 
2.43.0



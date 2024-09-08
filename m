Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754D8ECE577
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 02:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sn7db-0003l5-Qe; Sat, 07 Sep 2024 22:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7da-0003fa-F9
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:50 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dY-00054Q-K4
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:50 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2d89dbb60bdso2270112a91.1
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2024 19:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725762407; x=1726367207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQ8ocbxlttrmmofg9gOzgPVyAWJvSO1BPV+Tn9L8tD4=;
 b=vUDhhs0gye/MX6X7LH/h5TNY6rXFHa4d8dpe9vIO4YgY/ZCsG/1DVMykHsKTnFhcnp
 zws0uAZsiBlV9lGsjRCzUqTsKIU1b1MZl7KNC5gdsHAJt9/ILCFbydU8RCFwducNIvZ3
 hrWHsO2g5fwECHkF4lble+dwISB0L0hNfexMzBwRSd6xg5dLjob7WQ270k7r82hrf+Wp
 BbUrha+/8g8nLWMd5a2b220qI3pB9fLt6ZN8HQrfFzAa75uJyBjF/nXjnt/AkLGieZy8
 y9Vc/np4M13Ud+1uATEsoVrmJp5Y7Gqgx4ebR2A1L8tUBvfr012IqvjHvZ8x3g7sttd2
 4DfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725762407; x=1726367207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQ8ocbxlttrmmofg9gOzgPVyAWJvSO1BPV+Tn9L8tD4=;
 b=Lkw+nemTNMZX6DUiR4jwVowBNcU+qOl4/SoRqzojcY9wjo5iFC5Tov5QU2lL2zETZl
 Mp1dwgPV+v4wP3fhYRLUiZHc50Vlo7vMkRWfztlN6yItm+vxzR2+sTknQKQKXeTX15lL
 NDkZbQpquxiL0Y+4qYw4SAI6uAvZ4OcBIqViHdjQz6GgsPo6LpW2yo5ItIMVmeQ7as79
 duqyj8D8FtryOkPswG4qQEBfyupklml3+k44o62Suc1Af95/3NqQFmMEqXXAptfzF5vq
 KKMnh6v4ppTDSnAZrXaDU360+RyxSIgP/UnFoqtLf2W+O3EivLT+9NmQPAQYuoqHwkTF
 l+xg==
X-Gm-Message-State: AOJu0Yy7T17yMQLHCnCfJv8fBJf3Xto5ZUpCDKE6W6ac0fkV8hPOxQEm
 47HwCwXFtvnjIMhq5+AKJbXrXYO5I5Ru5tWIp3O2fqz5ajyarX5PX7SAC1QLG1MLDookv+KbcDj
 J
X-Google-Smtp-Source: AGHT+IHt9lbe1ukWLjXQsrMwgsj9jxgvFcW1h4I0syWKgSSgt1ZokKs/2cSBLcvhg7mrp1g0fbdiiA==
X-Received: by 2002:a17:90b:4c41:b0:2d8:f11e:f7e with SMTP id
 98e67ed59e1d1-2daffa7d5b8mr4432655a91.12.1725762407046; 
 Sat, 07 Sep 2024 19:26:47 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadbfe46d4sm4084019a91.1.2024.09.07.19.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2024 19:26:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com
Subject: [PATCH 12/12] tcg/i386: Implement cmpsel_vec with avx512 insns
Date: Sat,  7 Sep 2024 19:26:32 -0700
Message-ID: <20240908022632.459477-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240908022632.459477-1-richard.henderson@linaro.org>
References: <20240908022632.459477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

The avx512 vpblendm* instructions exactly implement cmpsel,
using a predicate input.  Of course this matches nicely with
the avx512 predicate comparison instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 46 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 2a3ae28e85..8c363b7bfc 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -413,6 +413,10 @@ static bool tcg_target_const_match(int64_t val, int ct,
 #define OPC_UD2         (0x0b | P_EXT)
 #define OPC_VPBLENDD    (0x02 | P_EXT3A | P_DATA16)
 #define OPC_VPBLENDVB   (0x4c | P_EXT3A | P_DATA16)
+#define OPC_VPBLENDMB   (0x66 | P_EXT38 | P_DATA16 | P_EVEX)
+#define OPC_VPBLENDMW   (0x66 | P_EXT38 | P_DATA16 | P_VEXW | P_EVEX)
+#define OPC_VPBLENDMD   (0x64 | P_EXT38 | P_DATA16 | P_EVEX)
+#define OPC_VPBLENDMQ   (0x64 | P_EXT38 | P_DATA16 | P_VEXW | P_EVEX)
 #define OPC_VPCMPB      (0x3f | P_EXT3A | P_DATA16 | P_EVEX)
 #define OPC_VPCMPUB     (0x3e | P_EXT3A | P_DATA16 | P_EVEX)
 #define OPC_VPCMPW      (0x3f | P_EXT3A | P_DATA16 | P_VEXW | P_EVEX)
@@ -738,6 +742,16 @@ static void tcg_out_vex_modrm_type(TCGContext *s, int opc,
     tcg_out_vex_modrm(s, opc, r, v, rm);
 }
 
+static void tcg_out_evex_modrm_type(TCGContext *s, int opc, int r, int v,
+                                    int rm, int aaa, bool z, TCGType type)
+{
+    if (type == TCG_TYPE_V256) {
+        opc |= P_VEXL;
+    }
+    tcg_out_evex_opc(s, opc, r, v, rm, 0, aaa, z);
+    tcg_out8(s, 0xc0 | (LOWREGMASK(r) << 3) | LOWREGMASK(rm));
+}
+
 /* Output an opcode with a full "rm + (index<<shift) + offset" address mode.
    We handle either RM and INDEX missing with a negative value.  In 64-bit
    mode for absolute addresses, ~RM is the size of the immediate operand
@@ -3183,6 +3197,33 @@ static void tcg_out_cmp_vec(TCGContext *s, TCGType type, unsigned vece,
     }
 }
 
+static void tcg_out_cmpsel_vec_k1(TCGContext *s, TCGType type, unsigned vece,
+                                  TCGReg v0, TCGReg c1, TCGReg c2,
+                                  TCGReg v3, TCGReg v4, TCGCond cond)
+{
+    static const int vpblendm_insn[] = {
+        OPC_VPBLENDMB, OPC_VPBLENDMW, OPC_VPBLENDMD, OPC_VPBLENDMQ
+    };
+    bool z = false;
+
+    /*
+     * We have already eliminated !V3 && !V4.
+     * Swap to place constant in V4 to take advantage of zero-masking.
+     */
+    if (!v3) {
+        z = true;
+        v3 = v4;
+        cond = tcg_invert_cond(cond);
+    } else if (!v4) {
+        z = true;
+        v4 = v3;
+    }
+
+    tcg_out_cmp_vec_k1(s, type, vece, c1, c2, cond);
+    tcg_out_evex_modrm_type(s, vpblendm_insn[vece], v0, v4, v3,
+                            /* k1 */1, z, type);
+}
+
 static void tcg_out_cmpsel_vec(TCGContext *s, TCGType type, unsigned vece,
                                TCGReg v0, TCGReg c1, TCGReg c2,
                                TCGReg v3, TCGReg v4, TCGCond cond)
@@ -3196,6 +3237,11 @@ static void tcg_out_cmpsel_vec(TCGContext *s, TCGType type, unsigned vece,
         return;
     }
 
+    if (vece <= MO_16 ? have_avx512bw : have_avx512vl) {
+        tcg_out_cmpsel_vec_k1(s, type, vece, v0, c1, c2, v3, v4, cond);
+        return;
+    }
+
     if (tcg_out_cmp_vec_noinv(s, type, vece, TCG_TMP_VEC, c1, c2, cond)) {
         TCGReg swap = v3;
         v3 = v4;
-- 
2.43.0



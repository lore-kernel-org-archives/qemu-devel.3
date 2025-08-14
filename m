Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B898FCA0EE6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXdv-0003Ln-RO; Thu, 14 Aug 2025 09:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXd2-0002PM-KR
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:26 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXcx-0005C5-9m
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:24 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-76e2eb6d07bso918512b3a.3
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176653; x=1755781453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHjAyHFO49Xnsrf4XYBbOWKhIj7dGvot2d9bfnaFFuQ=;
 b=xSFtLu1fYuvWJtGQTx6g51ffCylKokfKa+akYiBujK70ISy5vYowH5w7y87mw0It1K
 zyAimLWb20a+Zqh+tiMta3dQjpR939wfngBOOuakBmBfzJu4fDweivjpDShKIZ/yi54e
 yXMECYOCeq+nt6/jJZ0C89SyDpaXDWhz9wra4UpV4NY/LCh5QtJ/7mwxg+9uPMfIANId
 L8f875R1XItjqIlc02EP1CMBpl6/b3edp2kgRQSNUO5yKNKR4CuQ5nIDvGo8t+AxJttT
 IMA7AsDdaZ1mjzZhMbp9BeoyR2MOsNoJgocmjyg61ucya11o7yaY9bEFFiAnl8wCfu3B
 gkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176653; x=1755781453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHjAyHFO49Xnsrf4XYBbOWKhIj7dGvot2d9bfnaFFuQ=;
 b=SqIECqy9Jjuo6m9vZfX3BTsp5uy/PebauGn+poPD5/0b+y1FgUaE0EvXgHnWfxKvds
 yMKqlDuZmcVq6xsBhJDvH6l2fy3b/ISjs7STKh7RYCILyhBoRA9bf4on5jMk4ecvrEYS
 g9euTdOoGpBBvFdoKAoNOVQ1Nz46gmiev2P46bkA6hDDlNaI5XDfUNSBGrWUtZYZLI3C
 3nOXh5fMR5hrDoXoN13Qhr9gYncw2h0+oiBl9eI/iW5GBGPD/XLnTiwRQ5ZcN63BJAkc
 IA2bus+UOSK4NxcCoActDqnLjUXzx8F3LN5bvxRUxSz7fhhU7CLK8eU3ZPFbX51cn/9P
 +9rw==
X-Gm-Message-State: AOJu0YwSQUL+7VsDHM6RvrgIGHWV5i9TwHma68f7miuOMqt83hPc0Ab+
 ls8TeZmlFzw8mOzMJ7WI48L7HBF3RA8iZVZlnnIVXFUS6AN/izhU/tkd6MNo6cLAb7C5BLLLhpf
 H06xa5Kc=
X-Gm-Gg: ASbGncstzleCaLLVbxeN0deb2e7+Wfbt88RRLXMBrlpe3ffKQu0Xa7SnkJAX795Op7U
 EzMZeqPURWpLdl0LxpgIgVlBHZhPms2zaDmddTXoMWHNcIMt83yoTOyruQZXuRkNFyt2N5K3rUq
 5weWLXbUyN1rMBq3GCUy21Wt9BcnLp+l951ur7iIF/cp4MSa7Q32y8pvalNLxJo/1lKxj6GgWNF
 D/nZzVwgiP3Vi/k8/nZqxfhSI5pXa8xOxUvKRRXI4jGYulX1VIH0m87APKDYweE9gJwQoMGkGp+
 OAxGZ6ff5mXQdg/KQtgaghylRW+V6fzhvq5V5OKFpMEtNW7cKMC6/RuUD0l0xoroPXTSC8WJe9O
 lCiV1YBR3dWrHO7xGk3BTLlGGO84bTgNod4Re6a5Hbgsov+I=
X-Google-Smtp-Source: AGHT+IEvfvwkn3SJsnKBE8qpJUlA0Chrb3qugGLDUvIlAaAfKfoCZICZxRPH/UFwIPHFp3W0xhAWug==
X-Received: by 2002:a05:6a00:23c4:b0:76b:ec81:bcc9 with SMTP id
 d2e1a72fcca58-76e2fb2f79emr4054458b3a.21.1755176653245; 
 Thu, 14 Aug 2025 06:04:13 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:04:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 57/85] target/arm: Implement GCSSTR, GCSSTTR
Date: Thu, 14 Aug 2025 22:57:24 +1000
Message-ID: <20250814125752.164107-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Note that CreateAccDescGCS() does not enable tagchecked,
and Data Aborts from GCS instructions do not set iss.isv.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 42 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/a64.decode      |  3 +++
 2 files changed, 45 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d803c10ac7..e0548f7180 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -139,6 +139,12 @@ static int core_user_mem_index(DisasContext *s, bool unpriv)
     return arm_to_core_mmu_idx(arm_user_mem_index(s, unpriv));
 }
 
+/* For a given translation regime, return the core mmu_idx for gcs access. */
+static int core_gcs_mem_index(ARMMMUIdx armidx)
+{
+    return arm_to_core_mmu_idx(regime_to_gcs(armidx));
+}
+
 static void set_btype_raw(int val)
 {
     tcg_gen_st_i32(tcg_constant_i32(val), tcg_env,
@@ -3902,6 +3908,42 @@ static bool trans_STLR_i(DisasContext *s, arg_ldapr_stlr_i *a)
     return true;
 }
 
+static bool trans_GCSSTR(DisasContext *s, arg_GCSSTR *a)
+{
+    ARMMMUIdx armidx;
+
+    if (!dc_isar_feature(aa64_gcs, s)) {
+        return false;
+    }
+
+    /*
+     * The pseudocode for GCSSTTR is
+     *
+     *   effective_el = AArch64.IsUnprivAccessPriv() ? PSTATE.EL : EL0;
+     *   if (effective_el == PSTATE.EL) CheckGCSSTREnabled();
+     *
+     * We have cached the result of IsUnprivAccessPriv in DisasContext,
+     * but since we need the result of arm_user_mem_index anyway, use
+     * the mmu_idx test as a proxy for the effective_el test.
+     */
+    armidx = arm_user_mem_index(s, a->unpriv);
+    if (armidx == s->mmu_idx && s->gcsstr_el != 0) {
+        gen_exception_insn_el(s, 0, EXCP_UDEF,
+                              syn_gcs_gcsstr(a->rn, a->rt),
+                              s->gcsstr_el);
+        return true;
+    }
+
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+    tcg_gen_qemu_st_i64(cpu_reg(s, a->rt),
+                        clean_data_tbi(s, cpu_reg_sp(s, a->rn)),
+                        core_gcs_mem_index(armidx),
+                        finalize_memop(s, MO_64 | MO_ALIGN));
+    return true;
+}
+
 static bool trans_LD_mult(DisasContext *s, arg_ldst_mult *a)
 {
     TCGv_i64 clean_addr, tcg_rn, tcg_ebytes;
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 4315ed8dab..d034d96b37 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -554,6 +554,9 @@ LDAPR_i         10 011001 10 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext
 LDAPR_i         00 011001 11 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext=1 sz=0
 LDAPR_i         01 011001 11 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext=1 sz=1
 
+# GCSSTR, GCSSTTR
+GCSSTR          11011001 000 11111 000 unpriv:1 11 rn:5 rt:5
+
 # Load/store multiple structures
 # The 4-bit opcode in [15:12] encodes repeat count and structure elements
 &ldst_mult      rm rn rt sz q p rpt selem
-- 
2.43.0



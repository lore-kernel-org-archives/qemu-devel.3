Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E85C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEG-0008UN-6y; Fri, 04 Jul 2025 12:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEE-0008UA-HB
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:34 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEC-0006BH-O0
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:34 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so1116103f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646330; x=1752251130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CXGsqn2ldYgeN44ysuqaE8o/89zuJWxYO0GwSq5pdq0=;
 b=y/0qhdbyLNh4RyQ22qRFzj/7K0+E+xux5UA6lQSeiStp4EEF21wtACN3RnHOtrATFR
 eLtnfMoLDrZfekbA5AS6OSQ3nDKYHbr4azx1Omg/PvZOeJji2L4zqmq9N0yqSRaBLz0k
 6GRX5Gy4dFn1uXKIxtiAoSk1JtbPbWnPLEeSSbHiJ4Q5YwmLD5nAa80qhjKWBKWm+ytg
 rchxqHeqK7Vk9a/eqvRkcnKLqTlyJS7fzW6R7R+rQi0i7k3V4jbMzFRw19B9j51L3WYo
 KvK5WeqgJeIGwDXeX+EHP5baqjcUu4aKxFVtkdWRABmnp4VIgwRPWlLGBzPQlpWsKNew
 VTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646330; x=1752251130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CXGsqn2ldYgeN44ysuqaE8o/89zuJWxYO0GwSq5pdq0=;
 b=IWWxAbW/DmFSImjcXLYefYZi7r+M0FlLruSBvHPZGqgOi+rb9Lzyq7Aw6uLMpEg/HT
 DdEojVq+rQgPKGYQpJnBqTAQ3f8W8RLNbH+Rukjt8/lBbBb3mCxkhBWs1bzxkCFl1XPg
 RDLcXWr/T8U6XG31JzZGBkNw4WsKGo4zPHuaFG2b/TTLSmwozdKaE59Kb2KtQ6XMueh8
 ozAYJv1ghpFFbkm9H4TJMNzv+f+tufImvQkG7wfSBSz2ze1Sd42JXKehA78Mxl4isrjh
 U7U13FiunHBRFYzb/DyKZQYtSDUERAhOi6OdcP5MLDvKbTXURAOwwMPxAGRd+E8wfXHV
 oe6w==
X-Gm-Message-State: AOJu0YzL9cxR3LEFC+RUChvSEJRJi6PGu8+r/8MoWZuK6irrhBkqFhsC
 w89MRq5xv2zx2l+4vcVxDzpuc2AOkJbD54UI3lndiWLdTP8F8g+FkO6N/hcNCLnCn9fNBi6kro+
 qr1jX
X-Gm-Gg: ASbGncsHEbUzTNys8FTB/Qg2h8Dq5qWDr1KwOLGGHp1/3eUikfAjRXr4NwAudWdXuCD
 bzTLQd74lbe9xnL1g11Oe97wz0V9MMsyOKKDZdfy8f919D6KFgcNv3fPW92x9SQsvTuKpNOwTAO
 ETTDIlEXKrdwoCKzIl7LrFLt5Ynvs+eNlKkjvFtr0V4aox+RWj2nhYL2rMKuDV/O6v+wsbikYy5
 Dhmc2dl+uF6ZZBGfd/6+CEks/DTtPtAKIcdBWvABBpOC2mRyf4kBqZPZBlj0/xEX4KxlYF9vYgw
 Pq3ObG7k6YRU7qaHF8zDLMakMDIC1DgUVaac9A5MmS/6k/50iWHYAHrtZF2LH/cYT6rU
X-Google-Smtp-Source: AGHT+IFhYuteHg1OpNUXl3629XiOV20PKgQrm1XPH1kJX+0v7IjT+F8ubbW7B+wRJqR7Ao2A/BWBfQ==
X-Received: by 2002:a05:6000:642:b0:3b4:9721:2b31 with SMTP id
 ffacd0b85a97d-3b497212dd7mr2596166f8f.5.1751646329677; 
 Fri, 04 Jul 2025 09:25:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 029/119] target/arm: Implement SME2 ZERO ZT0
Date: Fri,  4 Jul 2025 17:23:29 +0100
Message-ID: <20250704162501.249138-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-18-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h          |  1 +
 target/arm/tcg/sme.decode      |  1 +
 target/arm/tcg/translate-sme.c | 26 ++++++++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 3244e0740dd..c48d3b85871 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -80,6 +80,7 @@ typedef enum {
     SME_ET_Streaming,
     SME_ET_NotStreaming,
     SME_ET_InactiveZA,
+    SME_ET_InaccessibleZT0,
 } SMEExceptionType;
 
 #define ARM_EL_EC_LENGTH 6
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 628804e37a8..dd1f983941a 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -22,6 +22,7 @@
 ### SME Misc
 
 ZERO            11000000 00 001 00000000000 imm:8
+ZERO_zt0        11000000 01 001 00000000000 00000001
 
 ### SME Move into/from Array
 
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index e8b35781741..246f191eca2 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -27,6 +27,19 @@
 
 #include "decode-sme.c.inc"
 
+static bool sme2_zt0_enabled_check(DisasContext *s)
+{
+    if (!sme_za_enabled_check(s)) {
+        return false;
+    }
+    if (s->zt0_excp_el) {
+        gen_exception_insn_el(s, 0, EXCP_UDEF,
+                              syn_smetrap(SME_ET_InaccessibleZT0, false),
+                              s->zt0_excp_el);
+        return false;
+    }
+    return true;
+}
 
 /*
  * Resolve tile.size[index] to a host pointer, where tile and index
@@ -130,6 +143,19 @@ static bool trans_ZERO(DisasContext *s, arg_ZERO *a)
     return true;
 }
 
+static bool trans_ZERO_zt0(DisasContext *s, arg_ZERO_zt0 *a)
+{
+    if (!dc_isar_feature(aa64_sme2, s)) {
+        return false;
+    }
+    if (sme_enabled_check(s) && sme2_zt0_enabled_check(s)) {
+        tcg_gen_gvec_dup_imm(MO_64, offsetof(CPUARMState, za_state.zt0),
+                             sizeof_field(CPUARMState, za_state.zt0),
+                             sizeof_field(CPUARMState, za_state.zt0), 0);
+    }
+    return true;
+}
+
 static bool trans_MOVA(DisasContext *s, arg_MOVA *a)
 {
     static gen_helper_gvec_4 * const h_fns[5] = {
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDB1C41513
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJm5-00007t-JD; Sun, 26 May 2024 15:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJm2-0008VK-Dc
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:18 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJm0-0007js-PF
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:18 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f44b441b08so18562675ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752595; x=1717357395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+sSymu1dnFwbGzwBeecnIiy0Xpo0hk/urJzIGdDaAng=;
 b=SoUL/81SmvuXut0r705FLVvTlXZNG74rkLtjNl/Tu2uajHKRo3navNMoHUKm1PIa3T
 OS1vcvI+bdgeWKun/ek4SDsH+nuBK6gWi3hW0/nT4O2J5lLOHORbZWymgu1Uovw9IHEz
 j1yzwUloLmUh/zLax38kNz5DKa6cezKUSc5/9WqGAHW5JVG9trK+ueDxqCjfPO7wwv5b
 ngw1BvMO/dRh71Bl1lq98OyC02qUvhAAyxgciXT9/zBwN5JDyiEvgWk/Gc+Pm7Qg+kDx
 5c4ylxSJKE1aGUSoE+QIcvQZUNVSBKKLqvJHNN0VApma6s1kGidET21h22+d+O+S2x5e
 HsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752595; x=1717357395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+sSymu1dnFwbGzwBeecnIiy0Xpo0hk/urJzIGdDaAng=;
 b=umwy0zATlT4Z2jNOtMznqBLYT5UGCcXkmaFP88Y3ASp/pUi8RurOpRwWLdEhDM5NQt
 K2PwWLPSI4yu8UVQJLyWmCV+/PgqHCVP8hCH+eZZpUeXKg8iC2eWAKXOtfM4nksPrl3f
 c6ABvVcSfGccHkQT4k8BSzstP/36Om5pV3W7ghJ56NeZwGRZFAQ9waLuCYF5frheH5nP
 Oy/kvtUbrutmkHPCbdWVTIdDEr141un1d+2fWcsKz0X+EpiEwcAqQsWrL42/NnHBQcGX
 jXBMrMRuB+jZMd8L581U2Z+3MYXgSE/v9Vdm6NNw4YqYYgtgD88LjmY4JmJu2U5C+7pl
 E/Kw==
X-Gm-Message-State: AOJu0YyMH2S2umFe0Qo5Uf0Gcv8zBCy3gZAw0AbCGaThC5JXFjtmWhdd
 /+2S/vTw3ppDsAs4Y9ai5sSRIG+G/BFILeDgAOc8X9HfvNV2+9r9Ay/BY70MpbO5tmVz4irPDzG
 T
X-Google-Smtp-Source: AGHT+IHg+NZVBQPByPfGNtVRNYYvPoBi3EMtUyVeZp0B/yc9SNc+X208QpFDhiZfwnQG9xgYsUYYig==
X-Received: by 2002:a17:902:cecd:b0:1f3:139c:ce8d with SMTP id
 d9443c01a7336-1f4486e5f00mr88300015ad.5.1716752595384; 
 Sun, 26 May 2024 12:43:15 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 25/37] target/sparc: Implement UMULXHI
Date: Sun, 26 May 2024 12:42:42 -0700
Message-Id: <20240526194254.459395-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode | 1 +
 target/sparc/translate.c  | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 09c8adca37..508175eccd 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -389,6 +389,7 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
 
     ADDXC       10 ..... 110110 ..... 0 0001 0001 .....    @r_r_r
     ADDXCcc     10 ..... 110110 ..... 0 0001 0011 .....    @r_r_r
+    UMULXHI     10 ..... 110110 ..... 0 0001 0110 .....    @r_r_r
     LZCNT       10 ..... 110110 00000 0 0001 0111 .....    @r_r2
 
     ALIGNADDR   10 ..... 110110 ..... 0 0001 1000 .....    @r_r_r
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 313adcd95b..7bf1e7687e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -581,6 +581,12 @@ static void gen_op_smul(TCGv dst, TCGv src1, TCGv src2)
     gen_op_multiply(dst, src1, src2, 1);
 }
 
+static void gen_op_umulxhi(TCGv dst, TCGv src1, TCGv src2)
+{
+    TCGv discard = tcg_temp_new();
+    tcg_gen_mulu2_tl(discard, dst, src1, src2);
+}
+
 static void gen_op_sdiv(TCGv dst, TCGv src1, TCGv src2)
 {
 #ifdef TARGET_SPARC64
@@ -3919,6 +3925,8 @@ TRANS(ARRAY32, VIS1, do_rrr, a, gen_op_array32)
 TRANS(ADDXC, VIS3, do_rrr, a, gen_op_addxc)
 TRANS(ADDXCcc, VIS3, do_rrr, a, gen_op_addxccc)
 
+TRANS(UMULXHI, VIS3, do_rrr, a, gen_op_umulxhi)
+
 static void gen_op_alignaddr(TCGv dst, TCGv s1, TCGv s2)
 {
 #ifdef TARGET_SPARC64
-- 
2.34.1



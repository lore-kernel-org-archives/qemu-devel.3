Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81A0C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 21:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb5Bp-0004wc-Sr; Thu, 23 Jan 2025 16:56:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5Bo-0004vl-CM
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:56:40 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5Bm-0002ln-WE
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:56:40 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so786539f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 13:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737669397; x=1738274197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1BMW+C7jqPLrnYT1UisfzzT75nHHylLVxw3pRQiBjgM=;
 b=OEoezC6IxlWhLgUHahXWKu7697MUp+HoIsGJszv2rGoNiW/Tb+mU3Mk4X3nkTFaUZ5
 6Zrm4JL0aRNC/szn+z25mZsCe9GU3EQAZOf1TfhbZc+tb4V3LkCVAgf4twXq/nRXAIyc
 KtbEECX0dl5fYumHDPbc7EIAeSyMEju7Fim5KnvICQDi3GohOQ9s6pTJMmytst7/xUne
 l13fhvrYdvLy5/AaMT6NcnSbNojjZSmuNapFnAFWDyj8ut+Rq2VLuquXIZqxdYfzqUnq
 OYLhPBSGy+IjiIOp0KSQ3gqO7G08BEhJRCVy9tTJw6ziPGIzLPvaJ5LI4aErKpP9noRd
 eRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737669397; x=1738274197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1BMW+C7jqPLrnYT1UisfzzT75nHHylLVxw3pRQiBjgM=;
 b=hL+RMnua1K+QaadeZD2xF10k/OKUI/KZcdFljMwG+1328prHXfRcNaZyNV6QcWKYLg
 6ppMxzpd5yH2jQlNmDtgLocmD+Oid06lWuvvGajnEE/m5ZBEjYCgYzyw3eKTK7Ya1ZRQ
 ALAZOaBiiqME2FOdZpv1zVq9OWz2wCHeyF3fUHYGP/z5/ETIdgn1t7nkDFMYDfq5RgfW
 hhzFGYHWEnbUfLzUUrJelLJR+h2yHArMysIMTbLSEqb7OYCpm8iKYKx9uPUyHG3TR3ow
 q4eOAzSk6iz7UjaWT0wMziDzjRpDS1R1QienilhAkriuw8MovJF7w5+75CGWTxnPORZA
 cXMA==
X-Gm-Message-State: AOJu0Yx8d/PmS9nL/LWgs1+5wdfULC7t6nxpSHIKePCRp+plWznMuChj
 csdGJXD9TGuzGUIkSgm+221zWreEja8W1/KrWGtV8T+l8Kenr6z1B6fqF3cNeevEw3gwqEenBvF
 DFIU=
X-Gm-Gg: ASbGncuFtQrhYafqQIOHdrLA+tJ+D4UxCAKngXgBUtvQ95diMSMvJyR7wHEmHuC6xK+
 UoeAkg9hCMFKZeNJNOCzhASxsQge/ZZGpoxzRMlWrEyZVF+nw4ZTHzLjRPo1CBMRTKRtFe39WmX
 XcbPFZp9dLE+wviaLt8fm8cyzDNsraAF6DTVp6iw+SP62IJ/vvbqAzso4LyW3aZVu+OQSJ7ARwM
 zEKLwufcdp4K4hpEhkZYXNLSpfNIwyPdNp4BaYVgbTICVfFJIizSrcDix18oG2/TP1q4j8hR+yX
 0O0kAbuT1q9wdEUAvZ0X77161lk6r3Q3emDZ77oDivnbg+B5+MdLjok=
X-Google-Smtp-Source: AGHT+IHCDcgKMIOOS/0iKYYwJguoiOXTCB3GDrUqpKkEZa4TNnz/dUqMYE9dYP3RcVyvJGsBcqJOwA==
X-Received: by 2002:a05:6000:178e:b0:38a:a043:eacc with SMTP id
 ffacd0b85a97d-38bf5655a55mr23265382f8f.1.1737669397200; 
 Thu, 23 Jan 2025 13:56:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bbd93sm779002f8f.76.2025.01.23.13.56.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 13:56:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/15] target/ppc: Move ppc_ldl_code() to tcg-excp_helper.c
Date: Thu, 23 Jan 2025 22:55:59 +0100
Message-ID: <20250123215609.30432-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123215609.30432-1-philmd@linaro.org>
References: <20250123215609.30432-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/excp_helper.c     | 21 ---------------------
 target/ppc/tcg-excp_helper.c | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index b05eb7f5aec..8956466db1d 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -136,27 +136,6 @@ static void dump_hcall(CPUPPCState *env)
                   env->nip);
 }
 
-#ifdef CONFIG_TCG
-/* Return true iff byteswap is needed to load instruction */
-static inline bool insn_need_byteswap(CPUArchState *env)
-{
-    /* SYSTEM builds TARGET_BIG_ENDIAN. Need to swap when MSR[LE] is set */
-    return !!(env->msr & ((target_ulong)1 << MSR_LE));
-}
-
-uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
-{
-    uint32_t insn = cpu_ldl_code(env, addr);
-
-    if (insn_need_byteswap(env)) {
-        insn = bswap32(insn);
-    }
-
-    return insn;
-}
-
-#endif
-
 static void ppc_excp_debug_sw_tlb(CPUPPCState *env, int excp)
 {
     const char *es;
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 3402dbe05ee..6950b78774d 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -199,4 +199,22 @@ bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
     return false;
 }
 
+/* Return true iff byteswap is needed to load instruction */
+static inline bool insn_need_byteswap(CPUArchState *env)
+{
+    /* SYSTEM builds TARGET_BIG_ENDIAN. Need to swap when MSR[LE] is set */
+    return !!(env->msr & ((target_ulong)1 << MSR_LE));
+}
+
+uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
+{
+    uint32_t insn = cpu_ldl_code(env, addr);
+
+    if (insn_need_byteswap(env)) {
+        insn = bswap32(insn);
+    }
+
+    return insn;
+}
+
 #endif /* !CONFIG_USER_ONLY */
-- 
2.47.1



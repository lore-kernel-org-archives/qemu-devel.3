Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406E6E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4bB-0002Yz-L5; Tue, 07 Jan 2025 03:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aQ-0000MF-6A
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:19 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aH-0003MD-Je
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:11 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2f4448bf96fso17048679a91.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237102; x=1736841902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GzX6/F91wkbIfmKyxKVZ/uo9Sk/9JISOl4bNEDudAEQ=;
 b=WqYt96hTSXKYHqO1a86B7dJ1YXhcBFUgRK1N5UKxi3Ux8Xt6tvLWLI7sIA5Fzv7B0X
 4utdopYT2h0/j6G5OZ0C/WtoiFOhOMOmcWMyphZJmSI9w4gZCYPXBn905JjvHnotTPmF
 xeB+yCTBv2fea+od/svlifInlkLWWIk1SIEJcf4HdSmIV0airPYwH0mZxkAWjVzB0Lve
 id0aZbCjdD8aViJITMF996hAbxQi4JgvsH/UHpLHqIAgVMR4a7I6Myta84PnnS9MP0wH
 76QiZKS/mz9RiGlTQB5Pu0zyxLjPMGtQheTb76YgRFq/Ips3vXd/W8/jYSGau5oMymlt
 G4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237102; x=1736841902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GzX6/F91wkbIfmKyxKVZ/uo9Sk/9JISOl4bNEDudAEQ=;
 b=M38CNE1aTc+uC7V8IefR/gK9n92esu4ee2c2Op1aAb07HzsnJdByDWHMwj6lmX+X++
 DqCbL32rcUNAbNYMxzpBlSzHLuQ2+zymtJ9wV3ed/by1XCZNsUlx3Vj4NPsx45jmPWZZ
 ABmBcBAnMlA2pnrPgitiIjpe+LfMKe9yiOnKAbbxDJ3Vz0Gatf3GAhuFZz18+qDTFOxc
 KYLIH6Oa0WDR/+6UQz/Ot3UziRcRfLlp1oI5SswZsrM/4Gw4ETfqb4I5iXQtj263HDNz
 e1ZBhSRd9reYxotvF/iojKKq8AUxRhDc2niE1oVJEMVVZNYVknzCegXvkoKmJP93VvQB
 2U2A==
X-Gm-Message-State: AOJu0YxyUTnjQJgSIHVxvp25rNT0OEgjJUeo4DS8FiM/VaQFNikCoee+
 Jko3l2rZdWVe+BJ6fB16jTz4baJaKx+2hDsQe8QldB5yI4rJE6Rbr2RYnw6LNYAzgl4rLORoQ5l
 O
X-Gm-Gg: ASbGncuJf1ohtBS0Lt5XDStgaFm5C3WRMinnCKR+0WAx7yNuqzX7zATKZSdtXmne5Ka
 B918DSSgUogVYdkR5vEtgyEPSiX2/Q+T1Yi7S1b5UiBiP4nv4oleWSVfgscSFxvcNnni/ZMH67E
 d+1VMm+gkN493R3XzfAQEbouMOj2aTvQ8+f1/nSiH2L0Y+Qd8PZYgj85piDunlmO1H4du96/pOt
 l6M1heWw3bHs6gg6lVhy5oWykUleXV4n7F74sY7PW1WbtcSLyS+1HZ+bCvrzxiBPLA9gMLqvxHk
 chYy2LyzDVyCxsbLHw==
X-Google-Smtp-Source: AGHT+IHgCu+fKQjQyN2YrYMqHWgExRKVyeSfUZ8EZkeP+QyE1KNAuR/V+HC60EhjBibBAuesfwswXQ==
X-Received: by 2002:a05:6a00:330b:b0:728:e382:5f14 with SMTP id
 d2e1a72fcca58-72abdd7bae3mr71475739b3a.9.1736237102277; 
 Tue, 07 Jan 2025 00:05:02 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 44/81] tcg/sparc64: Use SRA, SRL for {s}extract_i64
Date: Tue,  7 Jan 2025 00:00:35 -0800
Message-ID: <20250107080112.1175095-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Extracts which abut bit 32 may use 32-bit shifts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target-has.h |  9 +++++++--
 tcg/sparc64/tcg-target.c.inc | 11 +++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index d9ca14cc3d..2db461efed 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -68,8 +68,8 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_deposit_i64      0
-#define TCG_TARGET_HAS_extract_i64      0
-#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract_i64      1
+#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
@@ -83,4 +83,9 @@ extern bool use_vis3_instructions;
 
 #define TCG_TARGET_HAS_tst              1
 
+#define TCG_TARGET_extract_valid(type, ofs, len) \
+    ((type) == TCG_TYPE_I64 && (ofs) + (len) == 32)
+
+#define TCG_TARGET_sextract_valid  TCG_TARGET_extract_valid
+
 #endif
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index afc778fae7..733cb51651 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1510,6 +1510,15 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mb(s, a0);
         break;
 
+    case INDEX_op_extract_i64:
+        tcg_debug_assert(a2 + args[3] == 32);
+        tcg_out_arithi(s, a0, a1, a2, SHIFT_SRL);
+        break;
+    case INDEX_op_sextract_i64:
+        tcg_debug_assert(a2 + args[3] == 32);
+        tcg_out_arithi(s, a0, a1, a2, SHIFT_SRA);
+        break;
+
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
@@ -1559,6 +1568,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
+    case INDEX_op_extract_i64:
+    case INDEX_op_sextract_i64:
     case INDEX_op_qemu_ld_a32_i32:
     case INDEX_op_qemu_ld_a64_i32:
     case INDEX_op_qemu_ld_a32_i64:
-- 
2.43.0



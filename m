Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F9CC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 17:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmc3D-00076g-0j; Mon, 24 Feb 2025 12:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2q-0006wV-0S
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:04 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2o-0005Zh-2P
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:03 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-221057b6ac4so89507705ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 09:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740417300; x=1741022100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0TfQANeGhBzfOc8Bs0tbxIBYA/LtaZzgi1bfrB1DlmU=;
 b=rTnFSdJamGElFp1ZU4oaKlclgm/xXS1fp9Bw51qeQ2+23bBuQZVjvikAfZoSP2bG90
 OSTuU5Ye80742u//4Pw4cq+BXwE6/nLytkuhwbdsoepIwmtS/nxEZR7GZYumFdF7xUHn
 m4kxbF/QKfN6v0ecTzVWVT0h9ncqDYlFJq0QDYOAAFcPYCvlEihVPAS8lm9iSHAEBgWm
 6XI0itYDUD55jPIV/XlUudfETCA7vJ+YyGpPacVR1S73Ob2WbDtT0MqwhER05XeAEsRN
 4aAyQ5KYgE4tfp5fRErxV3nE1ZZriRD1C8RW5SjjJuqyfxYnVhaHdBzurmr3DmY7eTaS
 ns6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740417300; x=1741022100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0TfQANeGhBzfOc8Bs0tbxIBYA/LtaZzgi1bfrB1DlmU=;
 b=m+Xa9jCERlMNTbOXG17rr+E9SHvkAvrcBKqm0zb9rCycprvECtxzDojQFgKM4177B+
 YsB3E7rmUpTt/FPp3YBmV3J3Uk2tGZ8ZYe6rQ0H6bSIAjHqe8TFbrrXCp3g28tieU2wU
 xkoz2X31eTn/53OQmKPqr/5lHoEux7rFp9p8tFLAu9rFdHu3ReMgJYDbGh1vbtDZCWxW
 R2ArJCnVi4dVe92f1Vm1aXyt8RLRRdrukYMHg2n0I6OOKS1xhIo2FoXVsu9tCFgCcOlZ
 bNS8bTB0Gu1YqfPmSXGFnaq3r5cDqZATS/7z8aLv4bVQuxnAzHSoA+Ie/ecrxdXE/pdB
 tELA==
X-Gm-Message-State: AOJu0Yzs3La6mXxzAcKRmAI+8dGSVCU1zZoBpw9q0mSeIcx24wOKl+qA
 R4mOzFhc/w/VtFPd+tjOXQLratEmiwN3In1brJTXec5YGEhmxs8w5P3i8XvhOUzcL1pAaNGohxM
 R
X-Gm-Gg: ASbGncts1Az8fTDBhnDCHTeds3icDHaIZiCLbYJHMc2EuyAdbKq7vg7LEp/cwtithI7
 WBSalzcfUiEC1Vxm7V++4rprl+RVTXdqNYH7l4JUoVBVtUEEkhDB3Ma6eAASLTzEvOBdZ+ZNgMM
 vRLzG/ECE+KsXGlMtjkWHjDpdgo42Li4kKaPx/7JmrUP1daPet1SugfJ2dp0w023VzC/T3dZ5Dm
 Li2CZibIlVoYETl3nQvheClodqk8PLO0agpumKbU6Y+9KBupoY3RztjQ36HCg5d+PzvbREsc8s/
 q9Fhna704dhG7IjdtI4Qww2J8dILFN9Gdf0=
X-Google-Smtp-Source: AGHT+IEg9XrXPmva+vJ8B7KslpF9yB+sBeZFVYu7dwQ10X630hpFPDndkR2dsj7+133HCeGKztzRyQ==
X-Received: by 2002:a05:6a21:513:b0:1ee:d53c:e888 with SMTP id
 adf61e73a8af0-1eef52c65e9mr24015554637.2.1740417299163; 
 Mon, 24 Feb 2025 09:14:59 -0800 (PST)
Received: from stoup.. ([2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425466besm20580780b3a.9.2025.02.24.09.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 09:14:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH v4 09/24] target/m68k: Use OS_UNSIZED in LEA, PEA, JMP
Date: Mon, 24 Feb 2025 09:14:29 -0800
Message-ID: <20250224171444.440135-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224171444.440135-1-richard.henderson@linaro.org>
References: <20250224171444.440135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

For LEA and PEA, while the manual says "size = (long)", it also says
that the pre-decrement and post-increment addressing modes are illegal.
For JMP, the manual says "unsized".  OS_UNSIZED is the way to signal
gen_lea_mode to reject those addressing modes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 4f70b77621..23449e4d22 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2561,7 +2561,7 @@ DISAS_INSN(lea)
     TCGv tmp;
 
     reg = AREG(insn, 9);
-    tmp = gen_lea(env, s, insn, OS_LONG);
+    tmp = gen_lea(env, s, insn, OS_UNSIZED);
     if (IS_NULL_QREG(tmp)) {
         gen_addr_fault(s);
         return;
@@ -2658,7 +2658,7 @@ DISAS_INSN(pea)
 {
     TCGv tmp;
 
-    tmp = gen_lea(env, s, insn, OS_LONG);
+    tmp = gen_lea(env, s, insn, OS_UNSIZED);
     if (IS_NULL_QREG(tmp)) {
         gen_addr_fault(s);
         return;
@@ -2909,7 +2909,7 @@ DISAS_INSN(jump)
      * Load the target address first to ensure correct exception
      * behavior.
      */
-    tmp = gen_lea(env, s, insn, OS_LONG);
+    tmp = gen_lea(env, s, insn, OS_UNSIZED);
     if (IS_NULL_QREG(tmp)) {
         gen_addr_fault(s);
         return;
-- 
2.43.0



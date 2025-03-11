Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC1AC28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzGa-00008x-P2; Tue, 11 Mar 2025 09:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzE3-000571-73; Tue, 11 Mar 2025 09:00:54 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzE1-00008m-7d; Tue, 11 Mar 2025 09:00:50 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2feae794508so8085256a91.0; 
 Tue, 11 Mar 2025 06:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698045; x=1742302845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6S9jU22byVS+8eEKHCDnlZgprjWuUh/KidjFhLfhjko=;
 b=g0JGOoSGfuoYUeXAaUG3BJg0XrY7UkTxVo0ysK9C/E1YDXltfl2bnN8D4H8FJiUWQ6
 ZKD6PmPOnGnuW6QpDSMs0WiA8GPBv7pVOgVqiwbFhS0ZPt/LL3sh/+/BLYs26Ivd/i9/
 1MXJLdiP53QCEZc+2SECahtLaKfl31CW857/KMzaCp0WC2ASLGO9CFyfWLegFjpuZmIN
 aV29qdHFwXTxs9qIXde9DwzmPgaY6dI30anBOOt3JzDogbWYe8jBLk1s2kD6jVLPFJLX
 mPSNzx3+OIfMaItDfJcIDr+KaCGdGOcEOvFOQE/taWJkDuIdZldkN9TmrQtQkikuAJQw
 DQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698045; x=1742302845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6S9jU22byVS+8eEKHCDnlZgprjWuUh/KidjFhLfhjko=;
 b=kXYySotCYwaWc7JtmxIAMwmvRofNZvH7ksBzM3H+dEUDIAD/lGvvfkXIEs5WtWUY9s
 SUSdCG9QL9SkrQ3HPZi5h8NoM/E7g7MJl5j/x8zMCoreXdQ5NkWkg1mfBChPmwpL6h2R
 sai0tXkf+1Y/7RY+v7cmBrVbMxJB+kYy0133gfcYYMAlQUwmHpOVof7AUI4zaLiO9iiy
 RhBw8g7jMds3bEqtCecc8B9EBY6Mcoop0flL8QErRfZhLtj7gddxXr7jg38tTNe1dCuv
 g++tYazpXGPLBpb2zM+oz/5zrBK18yVV9TpdC7HaErNYqVame2kwRY6FXzLVPJYcN/iN
 F8uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGW23q1tU5RDkApiUfTAyHEheisuVpVYJ0aaN+3E/ooVEgdvu6Bhz6irVs12QfIzo+MHqe9TvlbQ==@nongnu.org
X-Gm-Message-State: AOJu0Yxb1zgVbVE+BrJ0MY913Vge8Rg//s0iqceTFoK9BsNTfekVqZ0W
 AZaUiSddq1VsYYnk//eMQShW7o2ApUp5gcPAqwnaCjIQfDuq2vs7/XV8+w==
X-Gm-Gg: ASbGncuYOhZaqSM2lOV2C+UaNYG2omp3b1gmMyGKIyofAz51bElH+unh07MeUsyPBQ+
 xoBeTmIseoTLwg/FS1+Sr3NmyTKaAMqjuLvX5stdF7erJR/bwTnP6rKtdJC7RiWLr1ul5qBvjv1
 /VLHLUFpAr7q0gkRdF49sIrKCRwqT07mE82uwn1QXRUtzPmo+4rUV1DQfhlos1PmA13WQL+4FgR
 e26/3x3rJ8ev2cZZb/RcE7N6mwFhTiqVcBqfMbypqnShWWO3rTAV4MoFk2M1hvDcRcP4xTPdvRy
 bYfId+RNKcoWMJjWOJ7K5FXe+Q94h3qIJqx1UQqRsaB/D6atHZGCxU6IM/GqBg==
X-Google-Smtp-Source: AGHT+IEJNGqwgZToGOe1BXasTksgFUwuhGEsFPva1IxfrTL6K1igtZZvwGwUR4jjkaiHfpQAoTTBJQ==
X-Received: by 2002:a17:90b:1c05:b0:2ee:a583:e616 with SMTP id
 98e67ed59e1d1-2ff7ce6d543mr27900239a91.9.1741698044790; 
 Tue, 11 Mar 2025 06:00:44 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:00:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 45/72] target/ppc: Move ppc_ldl_code() to tcg-excp_helper.c
Date: Tue, 11 Mar 2025 22:57:39 +1000
Message-ID: <20250311125815.903177-46-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-ID: <20250127102620.39159-6-philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c     | 21 ---------------------
 target/ppc/tcg-excp_helper.c | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index b05eb7f5ae..8956466db1 100644
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
index 3402dbe05e..6950b78774 100644
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77869C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 03:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW6J1-0002Ll-Gk; Mon, 22 Jul 2024 23:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6Iy-0002EX-BI
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:12 -0400
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6Iw-0001wM-Cz
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:12 -0400
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-807687b6652so242365539f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 20:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721705708; x=1722310508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/SUfCnTpRQkNLbtLFhLzUNUB0u06MHsZx7MB+lBLUc=;
 b=AH2miezvy5+w2UaNmgmONX/dkTIGZ/197PKQxEB790pQ7RJi7XEtrKeGK74Kpr1+/m
 QLQ6HfdeCebJWAAi6ClfrsMpjY0jw+cQU1EUabtmyTH5oU2oLJlc9gJ/XyD/0PCpRU0q
 l/FVR2SY0HaOltlWuA2S4FKDj9QbjO145EQbOZFxTNqRDWGp5FgZPmQTW8T6wtxeMC02
 zZUkbGyTsNyaZaU0OdBeSfQ3cDVCVZhQ4wMT190FsGwcHyvn2zonauouSDdyLwUVFj00
 coQLOBH/qUrcKEEoH40kQ6CIYgNOJ5EVNjCeS6vH3Zh2l1sJgOO32Q1gYoymxFOY3gvA
 RnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721705708; x=1722310508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T/SUfCnTpRQkNLbtLFhLzUNUB0u06MHsZx7MB+lBLUc=;
 b=REAkXsLC8bFZyXX1hh45fHFmlu/RFpUuYzYj1hDyHiLNL02dObQpBwKUjGn5DXXM1o
 ZcWwvk3ITJdVKv48RUi1jx2NGWPjNJ8To42nZc2Cll8LNkorL+jiFV553GlxDLxxd3+c
 IizBze5J7BBux2wgF/CMCBJioavzdp4HY6WPOSdkI1lsTbkHrXgORmUifhQJ2dCQ+JmK
 3XslZ6rHCxKOAc7hLud5SyAdB2GS2BDwOVW8ANGpwqmtIkX2kdHooCpd4Bgcyx7487CU
 l23j1hkx2NBLWoE6S1PV27iLpm8j9BkLr+Az0Qn9bSeEdswjfXrNeKs9SvhDubZv/U+U
 tOnw==
X-Gm-Message-State: AOJu0Yy7LJrUxsGDf/uwhIXG3B2C4Gtp2tQDrgYjAjqprR181Ky72e/+
 5WorYKe/RAkqL0XT93Umz9k6HetdPlI1mbA5a1Z4+bxfHAxrLBS7mWI2C3fVH+8gmfjN7Cu9Os5
 Ko11QDQ==
X-Google-Smtp-Source: AGHT+IEJ7kzoscIvOIXojIF7Ih7UYqdmDUS2TYRnCovMCgWCcKsSd1uXJS0QeR1cFYz1mYsL28aK4w==
X-Received: by 2002:a05:6e02:1feb:b0:383:284:113 with SMTP id
 e9e14a558f8ab-3993ff97b4emr122662745ab.4.1721705707696; 
 Mon, 22 Jul 2024 20:35:07 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d2b96bfcasm2171380b3a.87.2024.07.22.20.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 20:35:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
	Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 04/12] target/ppc/mem_helper.c: Remove a conditional from
 dcbz_common()
Date: Tue, 23 Jul 2024 13:34:43 +1000
Message-ID: <20240723033451.546151-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240723033451.546151-1-richard.henderson@linaro.org>
References: <20240723033451.546151-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd32.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Instead of passing a bool and select a value within dcbz_common() let
the callers pass in the right value to avoid this conditional
statement. On PPC dcbz is often used to zero memory and some code uses
it a lot. This change improves the run time of a test case that copies
memory with a dcbz call in every iteration from 6.23 to 5.83 seconds.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20240622204833.5F7C74E6000@zero.eik.bme.hu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mem_helper.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index f88155ad45..361fd72226 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -271,12 +271,11 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
 }
 
 static void dcbz_common(CPUPPCState *env, target_ulong addr,
-                        uint32_t opcode, bool epid, uintptr_t retaddr)
+                        uint32_t opcode, int mmu_idx, uintptr_t retaddr)
 {
     target_ulong mask, dcbz_size = env->dcache_line_size;
     uint32_t i;
     void *haddr;
-    int mmu_idx = epid ? PPC_TLB_EPID_STORE : ppc_env_mmu_index(env, false);
 
 #if defined(TARGET_PPC64)
     /* Check for dcbz vs dcbzl on 970 */
@@ -309,12 +308,12 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
 
 void helper_dcbz(CPUPPCState *env, target_ulong addr, uint32_t opcode)
 {
-    dcbz_common(env, addr, opcode, false, GETPC());
+    dcbz_common(env, addr, opcode, ppc_env_mmu_index(env, false), GETPC());
 }
 
 void helper_dcbzep(CPUPPCState *env, target_ulong addr, uint32_t opcode)
 {
-    dcbz_common(env, addr, opcode, true, GETPC());
+    dcbz_common(env, addr, opcode, PPC_TLB_EPID_STORE, GETPC());
 }
 
 void helper_icbi(CPUPPCState *env, target_ulong addr)
-- 
2.43.0



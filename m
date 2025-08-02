Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FF8C87FD3
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 00:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLjx-0005x3-KB; Sat, 02 Aug 2025 19:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLiJ-0001Mh-Hi
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:32:33 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLiH-0005Cj-SP
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:32:31 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2ea34731c5dso2673779fac.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177549; x=1754782349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+ER0bRwaWJSVZXuKMTaNBSXf4hbZ3aeU4lFfN33xP8=;
 b=rGt8mPSzDtoe4puD1gMxHJD6hoSkYNEFLkJPmJN3T8INXF8dQMzFSRnfBRmTIKZSp0
 JHWhzIScRi0adwVin72uTRrYAEEaKJan+6+VDmE2Cv6VqkCcmtwZJVbuQIvALM+KdOYh
 1cRQB7SWPRuO38I7AomaJlDWZyFZ4ErvUcWC5xk8HZVqmrg7FQ6CbreHhpnjtMTUum4Y
 3Jvn3TYKXhzfaBoxxycrNnhjEHo2xMoZ2qN+thOHBBz9xWR/TQRkIVhhb0DXkl2V4q8g
 MYRK0MK4ji/5WnZOADoq25Zcjjvj6KueVZtlr7+33uGf9UmZRmOw93HbIJbawhRTGaZm
 BaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177549; x=1754782349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7+ER0bRwaWJSVZXuKMTaNBSXf4hbZ3aeU4lFfN33xP8=;
 b=T3IwMNyVWGy5dpd9PuK0FRtsw6N/HeFYUE0Sd87RWvJ9pg7zavtKYGdbnlqwBZbqUy
 JRfmBejF59tl5PXlVle0DuMWLvc6rqsiYQCgH1vBoRkY+dPSc+SMh96+OJ8WBF/lFItL
 etLzU/m72/Ple0zl+areSmHgzUfQagQ3b+Gg41Dn+SqJDfbeCVV55vb8qsdOew0P+DHT
 O82AhNP0iReTwZsxjYSS2cZCMAY7zUc9DRihAbgicnsLs49ekUDce3cSby/lJwYfXiad
 Vldj1P8grUjS1FNazPdotU/wHZirPPQ4DC4a9g2P6DCHvMO/MEd5isSRzBFTtW7dtQYN
 mvGw==
X-Gm-Message-State: AOJu0YzpJKPph7B8hHYMTDPPMxnwyhUFvMkPVFaW+mQH36C2SE5aqsLI
 UK7q3JZA0u8svVChRR3LajW1b7SsN9rOJHWTa79No0tdvvbHbJUBE07pxTNwyO+yBtrH/AcAA5/
 arAaHlPo=
X-Gm-Gg: ASbGncsoGrgP3RzGaVP7ED2Q0d7+8E97MRYCYOiiMleAJdBoms0cfU+2WOrvJoeA44s
 wfxUO6Os/GoJFe4n0syCCBDQMAoBEVuLkmaPSoPap7MYDKXB2NVaVXr2uir2242YC0vfvgKi8cd
 7ugpJWXVsHzbQ7QirmfyaMSdktoWmeET+t7TyxwYiHEO3ud1gOogpZatw69CJDCNQSNcsQuI+yt
 kmrr9dpTn+qJTwuoNmm46pMvnL6IKdWcG3P24xnJrtmypF51DEfn2oX8nW7fYM4HLvGkcdE8Fy+
 U+4GGcIBuNIQxv6kFggTZIxGIkmUEeztz/SMYcNR0EFMXPm4IuSciBD4/4pUY2T+/m1TKT6o24/
 F0yNrc8W4A5mYSRqexi/t218qIqSKgGCLl3SkIyW461XE27EWBKoA
X-Google-Smtp-Source: AGHT+IFJhpavev8tmCsno0hhsspVnsNFKxZqLAejzQxySeJtzBiiomFYZ2XygFfoD4LgIJjxIqNOGQ==
X-Received: by 2002:a05:6870:7041:10b0:30b:6a26:5193 with SMTP id
 586e51a60fabf-30b6a2652bfmr1588619fac.37.1754177548694; 
 Sat, 02 Aug 2025 16:32:28 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:32:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 31/85] include/hw/core/cpu: Widen MMUIdxMap
Date: Sun,  3 Aug 2025 09:28:59 +1000
Message-ID: <20250802232953.413294-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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

Widen MMUIdxMap to 32 bits.  Do not yet expand NB_MMU_MODES,
but widen the map type in preparation.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 2 +-
 accel/tcg/cputlb.c    | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 23eb849a9b..fc9a2291d5 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -201,7 +201,7 @@ struct CPUClass {
  * Fix the number of mmu modes to 16.
  */
 #define NB_MMU_MODES 16
-typedef uint16_t MMUIdxMap;
+typedef uint32_t MMUIdxMap;
 
 /* Use a fully associative victim tlb of 8 entries. */
 #define CPU_VTLB_SIZE 8
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 2a6aa01c57..416aaa1040 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -89,9 +89,6 @@
  */
 QEMU_BUILD_BUG_ON(sizeof(vaddr) > sizeof(run_on_cpu_data));
 
-/* We currently can't handle more than 16 bits in the MMUIDX bitmask.
- */
-QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
 #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
 
 static inline size_t tlb_n_entries(CPUTLBDescFast *fast)
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71C7D148A0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdieU-0001DR-EA; Thu, 08 Jan 2026 00:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdicQ-00084l-Sp
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:39 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdicO-0005Zr-0B
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:33 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c47ee987401so714935a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850291; x=1768455091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=egVbNojwa9yrj9wN1HcbccivbDY9V6hFbtE9omsyoj8=;
 b=gpel02JbgAfioRtaOmDLdvkrPnggH3jFNP7KD7hC/tqQtBFUt6CYVG0pE2H4eUymEq
 +riipawhp5FD+TTVUNgbzv3g4pICQUhNkBeRAUG2HOgjW271Frd/wHcr3IocSlVMB0Ya
 AAdb2zKZ5xYL2ij3G5wXYtlZ/D8/bQwhYwIiURrQCaKbliL7rY2HsOqjn1t8l1nqK/Tg
 I9ZCaFqzqhTOnf/jLJaChW7S9fv2xcE8KMFj0VeGaB1SZIxPZSv1OfL/ahQ8ULPbMDP9
 CQDS7jlsb5FiRDgDBaTNaeSUDdhgeFiCYb833oHIty+J6wQgRzJ4cyca00dZdpJpV2k2
 N8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850291; x=1768455091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=egVbNojwa9yrj9wN1HcbccivbDY9V6hFbtE9omsyoj8=;
 b=HFiPbzLd3K5LYzKzLuqkpK8as3CgZvTRg/7JEx2Be8nz2yPa4p4/brq0TnEos5gsvJ
 1yCsw6GI47SIoirVcNw4QMli3pzMh4d4NAmE7DjKcbYU+vgHadM2SS00m8ARYf1Jommy
 jgAjk/KlVkCDIhNYDxMtZ+kXBa2Y9fmE09JlxvGrLujM6tQWWbwWKD8ZmpmpsLYcY6OV
 /6P6jyB3vh0INTnmQZdByPzEhi9Bya4MrZ4zMQLpiCmwN6uEJZ/3wItHEtY49SrKYX+u
 KIXO7nDBvihD+JRM5yHK8wsZCWV8f7hz3bQUYBbbmeQmgRU89ThqWPKgjX9AGy3H4vxJ
 WcDA==
X-Gm-Message-State: AOJu0Yz/xSPFbhob+KIkCQVm8h0HrHGspmR3T0cXPBOS4KMQkA3VEMBE
 6rPm1QJpAnqCK61qG3U0X6bmvJQVfUI1xN1coXHl+L21D8uK2qrlflYLim4J1IS0Btb/e28icoF
 PR34xhfY=
X-Gm-Gg: AY/fxX51A9KMdulRoiEkaXnS1pynRTi20lNaj17rIK92aiFyCCf3hGRXNGTYthfI9/9
 TfizMNeaKweLoMubD3+PwXi3obgJ/u4Q0GjCAN+1eEJSERVCgoATucLHhWHxnzGvx+zAS+2qV58
 FJtrR8BW+VxGz6tvK8r9srP5uRNH97R/RNI2pfERsVfSxnPZx9sJmkkBnrOvX50biIrCiVkV/Aa
 mODOtCrbzIAXOvbUwAv/p/dRGVJ+Xox8qq0p97MNz5wPuSXpFWujJ9KR7o4gBywON1ptfwxlC4O
 MTTBqZ8D9Rd1bKUZosZCsQwwPuJeOD+OcQbGuaukR7cX+GaYt1IpdXWBTgDIveEcdyKTpMzKR2x
 UvAkciIGIb6aPwNoeSDZ3/Pf+rR2Sbn/95lMv51S8hLw0L0p5BFf4Qd2+jvnLM+TJrSq7zkYu9D
 pgks7cHKpL27RpAf5hiw==
X-Google-Smtp-Source: AGHT+IGZnZJUUMyBL/j0Kg9POXXNUURNrALphRiO1WSyoCgblBX7/4kCv9kYCUNYO4OuBrzLBrd/LA==
X-Received: by 2002:a05:6a20:94c7:b0:366:14b0:4b18 with SMTP id
 adf61e73a8af0-3898eb0ac5cmr4981015637.35.1767850290482; 
 Wed, 07 Jan 2026 21:31:30 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.31.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:31:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 34/50] accel/tcg/runtime: Remove 64-bit shift helpers
Date: Thu,  8 Jan 2026 16:30:02 +1100
Message-ID: <20260108053018.626690-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

These were only required for some 32-bit hosts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h |  4 ----
 accel/tcg/tcg-runtime.c | 15 ---------------
 2 files changed, 19 deletions(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 8436599b9f..698e9baa29 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -8,10 +8,6 @@ DEF_HELPER_FLAGS_2(rem_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
 DEF_HELPER_FLAGS_2(divu_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(remu_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 
-DEF_HELPER_FLAGS_2(shl_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(shr_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(sar_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
-
 DEF_HELPER_FLAGS_2(mulsh_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
 DEF_HELPER_FLAGS_2(muluh_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index fa7ed9739c..f483c9c2ba 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -55,21 +55,6 @@ uint32_t HELPER(remu_i32)(uint32_t arg1, uint32_t arg2)
 
 /* 64-bit helpers */
 
-uint64_t HELPER(shl_i64)(uint64_t arg1, uint64_t arg2)
-{
-    return arg1 << arg2;
-}
-
-uint64_t HELPER(shr_i64)(uint64_t arg1, uint64_t arg2)
-{
-    return arg1 >> arg2;
-}
-
-int64_t HELPER(sar_i64)(int64_t arg1, int64_t arg2)
-{
-    return arg1 >> arg2;
-}
-
 int64_t HELPER(div_i64)(int64_t arg1, int64_t arg2)
 {
     return arg1 / arg2;
-- 
2.43.0



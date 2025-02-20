Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA82EC021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9J4-0006qn-Tb; Thu, 20 Feb 2025 11:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9J3-0006lo-Cn
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:45 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9J0-0008CI-Hz
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:45 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-439950a45daso7357375e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068501; x=1740673301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QMqXQnyD0HN+nlQadMn1BYLhTf+pS86RpPb9K1JUA7E=;
 b=p/2YuBrTpuTMkHRRUxnJurWaU9KjjJWa/zGpNlTUi5eCSGPtxhDGz2gPr/1KiqTRxt
 0m0HCI9o42vJWRelXt0NLbSzbehFJtpgFQBYJcKWs6gb9/n9a8S6QsyZq7LLHmwCzV7P
 U92ZdV3cBdIVOV0YORR9A3YnRYK4W7TaTKwh1YwrqVXx8At4JTvdF0PrA8XqWtMgjKP/
 bUNEOqk59LNRk9KdFvnXkAITtFDOOAJ2AdlkGePokBhw8F3c9bsCzFjXvAaJdKP77oe3
 Koc0NtpgJTS9SKQ4v6dXHXQUrM7SrzIX8KFlHQ+llcXGU+Svod+apSoT3S11C8s8AmQV
 syLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068501; x=1740673301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QMqXQnyD0HN+nlQadMn1BYLhTf+pS86RpPb9K1JUA7E=;
 b=SB7oGG9lT4VkQUHH2hJXUrlrqFfh7Rz/3cK/PWx0yM1we3VoSA9mDgy/eDTjWkEeOZ
 Tlkj9pSzHKbAxCroNDlIaZICU+hmD5Y+dwl487gtdljKkgWVZrioCdFKd4JZf7z71FOw
 5jJB39kOoEQERLKfOYCHu8mSAKLMvWBLM04cTkdyw4KaSdkhlgKlc25FQ7Mk+jL0SRKf
 PyZgQw9hQ7yldmOJn1W7Zn2WL+3eJBuR147sJ6qO4nwTG3z2WvXlGy4Wb+Yp/fdfoQrP
 ltD6GPtzwIGh7tDl2iYi0L036+0gId1xrwRwdjVmXj4kgGp8yr+Q9AAA6njHIZy/tN6L
 x3Hw==
X-Gm-Message-State: AOJu0Ywr3kYhIQAG0QXbik5k8iR39ys9prEADNvbx46Oi+rBmTv/S7bP
 16tcKJdpmMl5XOK565RflH1T52Mzf7CS2cJwP5jJp13owUYAnM3NcXi6Y8FkXaHBjOcp/z61SKV
 +
X-Gm-Gg: ASbGnctMV+hireNiIngMBw4DCa+y/Rv6y+Cw/wV3dhIj4PoLc47xoDVrD7amrMgmZlx
 jWhYtMR2RbfrP1XSn6s7bzqjbQAihbXE89pesFiuR05pH5q9LyE28KUEmtJj7tiowtRWP5deuix
 lp8RgdIqj+MKVrPm5iwTf1hCCb4531DhTLhYLKT4bfe+waeivSF1qyziB8DRZh08M2HgilhFda8
 QmsCRZHW8ZqTIjKoUbuwZLFjhntbWevNrPBuehc1VLs/CBdlE9iusZFJeGwSfOrzMxAsPB4OQDY
 2mXBagPE/kabmnzxRwpsbQ==
X-Google-Smtp-Source: AGHT+IGps2knD0ITux4p8lvOa5zRXkRJtEzNFvecC6gDRSiU05Dzoy8R0651IqIi6hVtMhMnqnXMeQ==
X-Received: by 2002:a05:600c:354c:b0:439:9595:c8e8 with SMTP id
 5b1f17b1804b1-4399595cb04mr125263265e9.0.1740068500868; 
 Thu, 20 Feb 2025 08:21:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/41] target/arm: Remove CP_ACCESS_TRAP handling
Date: Thu, 20 Feb 2025 16:20:53 +0000
Message-ID: <20250220162123.626941-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

There are no longer any uses of CP_ACCESS_TRAP in access functions,
because we have converted them all to use either CP_ACCESS_TRAP_EL1
or CP_ACCESS_TRAP_UNCATEGORIZED, as appropriate. Remove the handling
of bare CP_ACCESS_TRAP from the access_check_cp_reg() helper, so that
it now asserts if an access function returns a value requesting a
trap without a target EL.

Rename CP_ACCESS_TRAP to CP_ACCESS_TRAP_BIT, to make it clearer
that this is an internal-only definition, not something that
it makes sense to return from an access function. This should
help to avoid future bugs where we return the wrong syndrome
value by mistake.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250130182309.717346-13-peter.maydell@linaro.org
---
 target/arm/cpregs.h        | 11 ++++++-----
 target/arm/tcg/op_helper.c | 13 ++++++++-----
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index fbf5798069d..fb3b84baa1e 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -328,12 +328,13 @@ typedef enum CPAccessResult {
      * Access fails due to a configurable trap or enable which would
      * result in a categorized exception syndrome giving information about
      * the failing instruction (ie syndrome category 0x3, 0x4, 0x5, 0x6,
-     * 0xc or 0x18).
+     * 0xc or 0x18). These traps are always to a specified target EL,
+     * never to the usual target EL.
      */
-    CP_ACCESS_TRAP = (1 << 2),
-    CP_ACCESS_TRAP_EL1 = CP_ACCESS_TRAP | 1,
-    CP_ACCESS_TRAP_EL2 = CP_ACCESS_TRAP | 2,
-    CP_ACCESS_TRAP_EL3 = CP_ACCESS_TRAP | 3,
+    CP_ACCESS_TRAP_BIT = (1 << 2),
+    CP_ACCESS_TRAP_EL1 = CP_ACCESS_TRAP_BIT | 1,
+    CP_ACCESS_TRAP_EL2 = CP_ACCESS_TRAP_BIT | 2,
+    CP_ACCESS_TRAP_EL3 = CP_ACCESS_TRAP_BIT | 3,
 
     /*
      * Access fails and results in an exception syndrome 0x0 ("uncategorized").
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index c69d2ac643f..fcee11e29ad 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -853,21 +853,24 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
 
  fail:
     excp = EXCP_UDEF;
-    switch (res & ~CP_ACCESS_EL_MASK) {
-    case CP_ACCESS_TRAP:
+    switch (res) {
+        /* CP_ACCESS_TRAP* traps are always direct to a specified EL */
+    case CP_ACCESS_TRAP_EL3:
         /*
          * If EL3 is AArch32 then there's no syndrome register; the cases
          * where we would raise a SystemAccessTrap to AArch64 EL3 all become
          * raising a Monitor trap exception. (Because there's no visible
          * syndrome it doesn't matter what we pass to raise_exception().)
          */
-        if ((res & CP_ACCESS_EL_MASK) == 3 && !arm_el_is_aa64(env, 3)) {
+        if (!arm_el_is_aa64(env, 3)) {
             excp = EXCP_MON_TRAP;
         }
         break;
+    case CP_ACCESS_TRAP_EL2:
+    case CP_ACCESS_TRAP_EL1:
+        break;
     case CP_ACCESS_TRAP_UNCATEGORIZED:
-        /* Only CP_ACCESS_TRAP traps are direct to a specified EL */
-        assert((res & CP_ACCESS_EL_MASK) == 0);
+        /* CP_ACCESS_TRAP_UNCATEGORIZED is never direct to a specified EL */
         if (cpu_isar_feature(aa64_ids, cpu) && isread &&
             arm_cpreg_in_idspace(ri)) {
             /*
-- 
2.43.0



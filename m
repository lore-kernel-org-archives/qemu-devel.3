Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F167CC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 03:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW6J8-0002oN-Di; Mon, 22 Jul 2024 23:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6J7-0002jr-Ai
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:21 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6J5-0001yh-Gh
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:21 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3daf0e73a5bso1294812b6e.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 20:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721705718; x=1722310518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uh4gAqAS6TTZXCMO8wLgp4N1p8byuXj34zq25Ai1zrU=;
 b=p52uYPIWwO8lYKuwnYun/0BYYakmQHATaLXmUawm5weeT8PmF9PTPPNRrec8jt1PNO
 NwWtWxmDWAFbgaYTLXOv8h8ylS1u95gNzRD6vLNgRT/t6Y7nbsqY9YAZDQ7Yu18zYLvr
 lARkZ2hIMD/iwPsQUY/FtxDmKZgrlJOq5WWuIpIFIfPVhGVZ5+w1rWgdDja7eztMI7NB
 AdqC2kbD4RubhadRWgJpBpu6sDT/OTamlGUM5vuiepnSHWwPz8nzEBexZ38VmwImnw5K
 oJfaydXdG9HZwRIGI3M04NRSI7WDFmPLWT1BEJ/le0lVukiAUdeFj1/2ZXOPyWJJDEKY
 krQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721705718; x=1722310518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uh4gAqAS6TTZXCMO8wLgp4N1p8byuXj34zq25Ai1zrU=;
 b=Wu91vOMgr4YJkFgNGe2PMCaEE9ThYC5f/C/7rlj+a9DF/c/gUd29/4WcEkTvpM/f9O
 SvBKMICJkfXfa3Qs3Lp/4ROwE4Y3rb44SkddIGm7ofidzT5CL+Lbtafi2X75bODwDbFM
 eG5T518GIzu1vURsi48r6+gmO+W5ZlLp9lBvpQ6NpJ7wsBFoAEIu5bbDblDWAgyGJ45O
 xoGIr7mU6IxQQohttfXGLZHxEMljuFobQMpO+shh0pZbp+zkXHkFPmq6MtQQA3yuOehB
 uJwMV59tkKg3dKNLHHIlC0jAEqKtGBkaHpf3ENx8GNDMYSoELUwNBoo7qtu5kyxK4dm4
 VvJw==
X-Gm-Message-State: AOJu0YyyUQy6RK0TuEKC436EPJQ+YKxBsC0TI2aycZX9o1aiDHlfZp0g
 xvYUAKoUEWQkb1FM4rMnV9K+S+F7KSaONtmb8x+gq5c1G3aL57aRGAiMod4e+76Vx1qdzlZNSVL
 W/UYfnA==
X-Google-Smtp-Source: AGHT+IFTbnn0KiQQBtdkxHYkTF/rWc2DJKfdPF68qi95FX4DlU7NJXy3c3SWRaBZ12mB2ThQQRzlvA==
X-Received: by 2002:a05:6808:1514:b0:3da:a0a5:a249 with SMTP id
 5614622812f47-3dae5fb0fbdmr11785351b6e.23.1721705718052; 
 Mon, 22 Jul 2024 20:35:18 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d2b96bfcasm2171380b3a.87.2024.07.22.20.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 20:35:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 08/12] target/ppc: Improve helper_dcbz for user-only
Date: Tue, 23 Jul 2024 13:34:47 +1000
Message-ID: <20240723033451.546151-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240723033451.546151-1-richard.henderson@linaro.org>
References: <20240723033451.546151-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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

Mark the reserve_addr check unlikely.  Use tlb_vaddr_to_host
instead of probe_write, relying on the memset itself to test
for page writability.  Use set/clear_helper_retaddr so that
we can properly unwind on segfault.

With this, a trivial loop around guest memset will no longer
spend nearly 25% of runtime within page_get_flags.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/mem_helper.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 24bae3b80c..953dd08d5d 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -280,20 +280,27 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     addr &= mask;
 
     /* Check reservation */
-    if ((env->reserve_addr & mask) == addr)  {
+    if (unlikely((env->reserve_addr & mask) == addr))  {
         env->reserve_addr = (target_ulong)-1ULL;
     }
 
     /* Try fast path translate */
+#ifdef CONFIG_USER_ONLY
+    haddr = tlb_vaddr_to_host(env, addr, MMU_DATA_STORE, mmu_idx);
+#else
     haddr = probe_write(env, addr, dcbz_size, mmu_idx, retaddr);
-    if (haddr) {
-        memset(haddr, 0, dcbz_size);
-    } else {
+    if (unlikely(!haddr)) {
         /* Slow path */
         for (int i = 0; i < dcbz_size; i += 8) {
             cpu_stq_mmuidx_ra(env, addr + i, 0, mmu_idx, retaddr);
         }
+        return;
     }
+#endif
+
+    set_helper_retaddr(retaddr);
+    memset(haddr, 0, dcbz_size);
+    clear_helper_retaddr();
 }
 
 void helper_dcbz(CPUPPCState *env, target_ulong addr, int mmu_idx)
-- 
2.43.0



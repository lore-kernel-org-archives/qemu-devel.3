Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DEBC3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 13:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx3wJ-0001B3-GR; Tue, 25 Mar 2025 09:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx3vY-0000sG-1J
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 09:02:46 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx3vV-000833-Eg
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 09:02:43 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43bb6b0b898so53663675e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 06:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742907759; x=1743512559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J/DOA8hAmAVfg6M/0jKhvBqsPxQAowypQJ33xuaxeRc=;
 b=zHmbEOfiP8/YbteXBDxqsoUfUnkBO+XvhsMFySm0A4rz6zkN/4owWPfPE5ry5a9uoN
 30Fi7C4a/dNw3xwEN9N42VSv6OlbTX8iV4SuUDoMIYrHNKxSjHMfdZEA+0vVZgz46F0G
 jp9OuIiZcaSkLeL/wE+/6dxd2nH0MuwU01eOn4OwXByd1AdMdmjDLyaepW+bvhk3W8Qz
 RV2mykVD23wVgXj3vS3OmgjKKUd3bfghJvDVz0HPw/GFEIBbQSrbjoH/P/t9+Kaku8N/
 391tv1UDo7Ye4z+1D7ltxh5HfegRfCgxT64SQyANdz49I9vTqF2YfLSBnsKwYg3EypUa
 EYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742907759; x=1743512559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J/DOA8hAmAVfg6M/0jKhvBqsPxQAowypQJ33xuaxeRc=;
 b=OrZya6DqYrCR9szV1b/FdxbRSqlrZtCBq5lW8nnbJBj5lGkyBSDRPhQajsSUP9T3+2
 ZINVJtfDRoZwUoVZzdBuRXWpROhyc5TXQiOxOsZnaRortIoSBzbA/ferxcJGrntGCV6j
 FG2PGEJumRPm8HMl16+LWYmxMsrmaVl3wrIwmIZrDXJN+riC/kH+J/zUbC4VqYWkHBSJ
 Mwd5FwgX6V2W+fiRiUujsTWOj83BWG49nyuwGToTSWMMxCwjttIiFwZmbBrX8TS90qs8
 9Mpj1wki2ep/cE+tq8E/zXUy5Vbh2EcDQ7wq9YN014oH3Ec5AjYwyTlyl5rCMl7Y8vVi
 KtjQ==
X-Gm-Message-State: AOJu0YxzF1WSB/esRcekG+ztcAcADLfa9sJgkc4jIdsXQ0oRbhIB/1GS
 rqxFlkWH+ESAeXXBa7rFn1mvz+E8ypUi+ea0ri7cRrgrVnQ7egSgW+hkG3Nk10hkulrfuSwaRtx
 z
X-Gm-Gg: ASbGncuENMfbHFMdZ5Y4Oue9sxPDEqzsrFrjzF6Bugy//FnYWuMfyAeKC5K8GvvDq8G
 qp+uEELsykXMzp+Swd6wa+yBXlxPuV9EOXxpjbumPY853hMQLKY9kaRu2KNw8B+VbfXZc1t8T6s
 0XtV3nAvlYl0PE3y8qgB7MUrbw6ym2+22ug2cJUZuic2XRFg11UfnwTkwn/vrxFcp4A/Io3PTrI
 kaLEjICk8nsTWvO5bgJxToACZ164fqcHyjkS5QBcNMEloqiZ4EWwX3SJH3X0kdDRs8UrjZ827jX
 MY3PURpIYG7y5+02Pe0d1f3OM1iygv3oxu1b4PSIAbAClHDf5JoJ/++5KQH13lTnnNyWtieOxv1
 nrBUgGxIYhlF4SSQK2mc=
X-Google-Smtp-Source: AGHT+IER1+XvWTZ4UFakvZLTuYePWcaH1fuaZlt1K+eW1Kk6zElKCMWesaNDlxy3KNbbqoADoz2RMw==
X-Received: by 2002:a05:6000:1ac9:b0:390:fbdd:994d with SMTP id
 ffacd0b85a97d-3997f910670mr15533763f8f.27.1742907758574; 
 Tue, 25 Mar 2025 06:02:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f43e50sm198899785e9.12.2025.03.25.06.02.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 06:02:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
Subject: [PATCH-for-10.1 3/5] target/ppc/gdbstub: Replace TARGET_LONG_SIZE ->
 sizeof(target_ulong)
Date: Tue, 25 Mar 2025 14:02:18 +0100
Message-ID: <20250325130221.76116-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325130221.76116-1-philmd@linaro.org>
References: <20250325130221.76116-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

TARGET_LONG_SIZE is equivalent of sizeof(target_ulong).
Since this is the single use of TARGET_LONG_SIZE in a
source file, use the equivalent form to be able to remove
the definition in a pair of commits.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/gdbstub.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 3b28d4e21c7..4d36dcfb563 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -367,6 +367,7 @@ static int gdb_get_spr_reg(CPUState *cs, GByteArray *buf, int n)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
+    target_ulong val;
     int reg;
     int len;
 
@@ -375,10 +376,7 @@ static int gdb_get_spr_reg(CPUState *cs, GByteArray *buf, int n)
         return 0;
     }
 
-    len = TARGET_LONG_SIZE;
-
     /* Handle those SPRs that are not part of the env->spr[] array */
-    target_ulong val;
     switch (reg) {
 #if defined(TARGET_PPC64)
     case SPR_CFAR:
@@ -402,6 +400,7 @@ static int gdb_get_spr_reg(CPUState *cs, GByteArray *buf, int n)
     }
     gdb_get_regl(buf, val);
 
+    len = sizeof(val);
     ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, len), len);
     return len;
 }
@@ -410,6 +409,7 @@ static int gdb_set_spr_reg(CPUState *cs, uint8_t *mem_buf, int n)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
+    target_ulong val;
     int reg;
     int len;
 
@@ -418,11 +418,11 @@ static int gdb_set_spr_reg(CPUState *cs, uint8_t *mem_buf, int n)
         return 0;
     }
 
-    len = TARGET_LONG_SIZE;
+    len = sizeof(val);
     ppc_maybe_bswap_register(env, mem_buf, len);
 
     /* Handle those SPRs that are not part of the env->spr[] array */
-    target_ulong val = ldn_p(mem_buf, len);
+    val = ldn_p(mem_buf, len);
     switch (reg) {
 #if defined(TARGET_PPC64)
     case SPR_CFAR:
-- 
2.47.1



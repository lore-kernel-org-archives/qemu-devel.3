Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88720C021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 17:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmc3J-0007D9-Qa; Mon, 24 Feb 2025 12:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc39-000768-Sq
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:24 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc38-0005oc-20
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:23 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-221057b6ac4so89516075ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 09:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740417320; x=1741022120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F68LQn6DxIAyz6GCkjhNecCIBRtM27bQXM5weTx5xew=;
 b=L5MWeGxyxywPWkrjUY73QGP78mEt1pvrXNw3ONO/FzZd1jYWZrUFuntk5NbkVL+U5d
 u7YkF+FZMCWulfoHCMDC/CpNVpl2hvO5qmy7FexutqJCbSHXBtuQcckmqR/RViD1MQZy
 tj7KQL9RS03xSn8uXSufgoxQBi3ftAuRLCDosjn69/j5LIWrEW093Eg5QBM7eYXPpKFB
 uCSPL1EpwBckVfvZEVSUoSzUSK8wsAfPekqIYpcTiVRqyCnABxay7m1ng9u10mnTpqAb
 qOoCC7p7wBEFto3VIKDzoNbu6CAsTJGXDnCdJEBKOU2OzhiS7du3Sz/MSChvxz13hDjK
 iMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740417320; x=1741022120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F68LQn6DxIAyz6GCkjhNecCIBRtM27bQXM5weTx5xew=;
 b=FOr2AvB6Q74BbCUObLIskRA8e/LZ6SZTPmM45RPSa2drecyDz3eFQvPcQdqllOWyZe
 6g9rVypwgMSjpTLggR/ZZquYmdDBJlH+LqPBS8s4AsTY5JQlhL0IXjW9fwkw02N3/OOG
 zOgTleDenPSmiTPY2KBm8foBMxTq++MDX37K7OLrdCxOW3QgnEsLhPoQsTC772iG94C1
 DwNQFRWRM0ulQSkpTTO4J/JZ7aLONyg4+D23uhsWas0S98lgRoqzSJD3Vt5Wd8jlAbgZ
 SQzRixPN433ZAzKNbZUDhq4DFgtOzIwwSdKswrCc4SZaGUYvEWbpnZBBSJq0CKZGQGfX
 JVUw==
X-Gm-Message-State: AOJu0Yzir/3qFIWmbDufmM2PAqeDzt7Y48LQ5+2j/aXSiuISiReli5V2
 lwaM130Kl/ns9k/avc3MxS2dntdYmIHYEwFM5n4p1nVlnjCkucKhXv4MnhvHtwe+Y74kwLwIDsq
 /
X-Gm-Gg: ASbGncs988GZcZqzQ/Y/pVWHDyRJsadjhBo05VBhJsMYG6fuZoUOkz8OHg79Y0wjH44
 k7Anr73hwGIeJHV71JlPRIMaC0HRA6oNna7kf6/dAeKmyCgXbB0SMlF6UCq7A30u61FgFRvMAZi
 WR5JZ9qz4k/ze4QMu31zgJblZTXBrcWP3d7z0O+mYwM0atF8atnjBjWQO5WqvzSNfjepsS4HPA9
 5Itb8EfcG0h/q7KQbX3XOybG15zlPcoqOPCGiXXWr61FZbby/khUS7fMGjm0CyopOZU+/h1rPK2
 JFUxife1Led7/H/U2naqbn90v/TGcz/MYfU=
X-Google-Smtp-Source: AGHT+IFihcbnFkxIEpUxNZoV4BKypejc4q+VGPbnfBAjXKlZ+KgETCl35hgfZoGDP4rDmxFszHoAvA==
X-Received: by 2002:aa7:88cb:0:b0:730:9801:d3e2 with SMTP id
 d2e1a72fcca58-73426ca536dmr28267292b3a.8.1740417320364; 
 Mon, 24 Feb 2025 09:15:20 -0800 (PST)
Received: from stoup.. ([2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425466besm20580780b3a.9.2025.02.24.09.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 09:15:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 23/24] target/m68k: Make vmstate variables static
Date: Mon, 24 Feb 2025 09:14:43 -0800
Message-ID: <20250224171444.440135-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224171444.440135-1-richard.henderson@linaro.org>
References: <20250224171444.440135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

These need not be exported beyond cpu.c.
Fix a typo in vmstate_fpu.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 7936b1a7e7..21ebc198cd 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -420,7 +420,7 @@ static int fpu_post_load(void *opaque, int version)
     return 0;
 }
 
-const VMStateDescription vmmstate_fpu = {
+static const VMStateDescription vmstate_fpu = {
     .name = "cpu/fpu",
     .version_id = 1,
     .minimum_version_id = 1,
@@ -442,7 +442,7 @@ static bool cf_spregs_needed(void *opaque)
     return m68k_feature(&s->env, M68K_FEATURE_CF_ISA_A);
 }
 
-const VMStateDescription vmstate_cf_spregs = {
+static const VMStateDescription vmstate_cf_spregs = {
     .name = "cpu/cf_spregs",
     .version_id = 1,
     .minimum_version_id = 1,
@@ -464,7 +464,7 @@ static bool cpu_68040_mmu_needed(void *opaque)
     return m68k_feature(&s->env, M68K_FEATURE_M68040);
 }
 
-const VMStateDescription vmstate_68040_mmu = {
+static const VMStateDescription vmstate_68040_mmu = {
     .name = "cpu/68040_mmu",
     .version_id = 1,
     .minimum_version_id = 1,
@@ -489,7 +489,7 @@ static bool cpu_68040_spregs_needed(void *opaque)
     return m68k_feature(&s->env, M68K_FEATURE_M68040);
 }
 
-const VMStateDescription vmstate_68040_spregs = {
+static const VMStateDescription vmstate_68040_spregs = {
     .name = "cpu/68040_spregs",
     .version_id = 1,
     .minimum_version_id = 1,
@@ -525,7 +525,7 @@ static const VMStateDescription vmstate_m68k_cpu = {
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
-        &vmmstate_fpu,
+        &vmstate_fpu,
         &vmstate_cf_spregs,
         &vmstate_68040_mmu,
         &vmstate_68040_spregs,
-- 
2.43.0



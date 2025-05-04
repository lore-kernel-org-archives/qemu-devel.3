Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27D3C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRv8-0002CK-7t; Sun, 04 May 2025 01:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRv2-00027f-Sy
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:40 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRv0-0004MZ-At
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:40 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so4872020b3a.2
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336577; x=1746941377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgL5ekQCPVNJfHfcPabdFrIvM+ux1exN882JD3eB0JI=;
 b=bR0e5VZ+UYG9/PqnHLkO1eNniohsgfpBVi3GJuCKBYf92ahzv0xePIWhNwwSlEA2a3
 DDPm9unFK/a2Vn5bg6aMNAG4JYPaEAL5LTyEGc6Jafgj7Cix3vZ9WiYdK1KJs/bQ8UfI
 erscQIqjP14fAGdZ1uHpHu+aZPgkAjDjqYpV2Y3548viEUhelQdLKG+aO6fBmpQ9K37Z
 aGdNmigrhweQJsaupKmaeE1KW4X0gD4izHYNhE8zbPO88ciMMRJGjGltfkjz2MTCWSwZ
 5C1NC89Bb5q93dJKHlQ0kSSkfHDMgZ9VN2HPnl5WNO8RxAlvfR2RkekJfzG5TTP4NnrM
 CPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336577; x=1746941377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fgL5ekQCPVNJfHfcPabdFrIvM+ux1exN882JD3eB0JI=;
 b=dxQLkCE9mIpBttCw/uASeP2oNMDPtFIkJcaN4INezhdB0zlnOWF5z10jrnVUgb4owu
 D5+QjHVP1VTj1VfInoRFqnK5nraEFFikoUOuqmsOBiozBCh7KeVIAJ1Oj6SHBoRpvyrA
 UZtzRnTrg15oe1/7ZdJMor9XMPKGwtbgS1NuwGF4+P6zTmUmPpCDlUWm61nmfdLWEsjV
 X3arKc1OoVcUFxfji4PGuYvzkUylv0idm8yfh1mYkOyeaVSAApi3z9w2tQJLFyeOEWkD
 QRa+aFWudmgOHdysFordF064aczTJpHXfoeiLxwR+kH81zzpM82NWBehVd++Wn/hNtRv
 zfmQ==
X-Gm-Message-State: AOJu0YxsXUzom7pprfbauewakfvj5MBlzWJhUC/pwVKgnCaNsWUtccFh
 Qs24PSmQDYgF1n+P0w9PUYHMheTCjJXBTtT5sXt6P3qKe62c4K5vL/Q+s4BJggkpbrSUNJQ+IAz
 jZB8=
X-Gm-Gg: ASbGncs9T+lB8qTNRK58cjW8BC37AcnQdLj6kBP5MuECsMMBz6zyeaWS585bupA1brq
 PV7tsa+QzXfpcspvI97IsHIcPJx1yr1gPuEEEr6XzF6QzW1Cjak6465aX3SAkLOQ5wpZBxVlsnw
 /9r92WUGy9q+we7SzXmFfmSRf/r17jNc6DjnBO4YgUz9TskgcKezt1DyTmYm2xNsqYuDYIriHfw
 8q6utEL6GNWhrjksDGEhwfO3ZQLtdo/PKopwWxgSKGUiwYHiQbbXVxlmY8FCwbKesGF0EDGeDKs
 h8olaRaScczLe0I+5YoVWaUwzUC9TSFOY2WfZ6C8
X-Google-Smtp-Source: AGHT+IG0fiHww8wHentCcO+BRbRdEEXumZMr2eqE2gcWz+lyA3vsJ3lxTr49JaERvR9Gf/hYkM+otg==
X-Received: by 2002:a05:6a00:2987:b0:740:5927:bb8b with SMTP id
 d2e1a72fcca58-7406ed59ab5mr4309964b3a.0.1746336577027; 
 Sat, 03 May 2025 22:29:37 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 19/40] target/arm/debug_helper: remove target_ulong
Date: Sat,  3 May 2025 22:28:53 -0700
Message-ID: <20250504052914.3525365-20-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/debug_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 357bc2141ae..50ef5618f51 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -381,7 +381,7 @@ bool arm_debug_check_breakpoint(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
-    target_ulong pc;
+    vaddr pc;
     int n;
 
     /*
-- 
2.47.2



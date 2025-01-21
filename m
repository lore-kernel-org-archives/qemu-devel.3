Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C33C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFET-0000Bp-Br; Tue, 21 Jan 2025 09:27:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFCQ-0002YK-Lx
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:25:52 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFCN-0003fQ-Th
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:25:50 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso40030625e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 06:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737469543; x=1738074343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fr9YdHbhOcKThpVgYMMFdjV9+ofIfxxdmaz/V1NjYlM=;
 b=WSqpmHGPk6i8G3sbwYP0y9gvZVDR0dZgpEIv9xnsHcsRAPNEGxC5/pR8Z99ENLi0IL
 sFjqADgkbU896wjWZBTDq/+/wPFGZysM6aTpVsckleLW3dhhsCZTCLZT8elARtmVLogD
 tmdOzpbCZV9V0TPicJdEuMSWYYXo0rKTTw4j1NMGSZTiMlYPmy5HiiRqk50h7fh3JPCe
 HvEzA0CQcX4zWh23/0cLyVF5994fUHcuq2fEBrnjRsipy+KNFJjI7J/smNGp2mVqwJFQ
 mdNganYAbLs1ErmUI865ncL1eCX7Sizu8vya1N0gWHImamppW/6hNBs7l8c8oeSiTrfl
 caOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737469543; x=1738074343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fr9YdHbhOcKThpVgYMMFdjV9+ofIfxxdmaz/V1NjYlM=;
 b=EbiCMdQg49UD1llvl3dha+2/0tWIKsZM1hRy1Npe96zbjT20k0tGN+orQ59K9QcekB
 4JFI4vdP12FUKPFGW1Df3cFw0NDSpiIvgvNnFxw+LDx7nAGwRuMnxp4ZNhF83+XkrSuP
 zgR7nUcmo+SE+VMeIhE1w/SWdmM5FCodf6fgEWeJkjgkxr8Wivj4rUnQI6h8GYdALQ3J
 JUMOO2gt4MU3ggsahjHs6bNjBRaVW2QXNxyonHJn/XULQFLCgbavitDYZPbGC9927w6p
 wTJ6nm3UVF5fhVc5gMN5d+bgvSxCs2osRIX/CxL/ULePSMA+9Ng5SnL6mVaSttbWOQRy
 7ilw==
X-Gm-Message-State: AOJu0Yw0C1hQWh2Zi2EN6vVKSubK6ZGrxeYMv9KMme+DScaMVRj7woCL
 QzT2ZZS9UJLiUcoAYNBCeZJpCPofu8OHajYw+jLzLD6IsIZIfNQSQZTlPhSpEtFsYoKh/Z1Ol1B
 G/5g=
X-Gm-Gg: ASbGnctoH0VbnUL6mG+x8bCtxYABYVpNLhaSSM14DXlb+nSvA+pUAMNIoyUImdXfACM
 OScz2IRj5zr1YP/BuxLrRVkgmlFafMBvC8Q/M0u715oGBi9uLTifAVUkcvsup9NbUgOg9D2busr
 3Rdmv7yOGz31NpghR2TNDv4td4KoEiHGPjwxgXyo3tqszamz5Qh8Wazx4HtnyV6fnzuc+AFTsSA
 JFsZe+JhVOmWkc/uDmbe1yNSW5VmmcMr5qRipqN+m6C7IdJEZfQuUcOBDxJVN5LcAA/eKlPiAhY
 WdeDdQS82M/OPtqbckLPcMDM6m1qzd+3/uboc2Cid8kN
X-Google-Smtp-Source: AGHT+IHZiO9H8UoGX6X1M2K5zPNmAaDRQIcmdu2Llnl02sgRHrc/qLvRlcC4n4j8oG1pmLQ0tOBk6Q==
X-Received: by 2002:a05:600c:310a:b0:434:e9ee:c1e with SMTP id
 5b1f17b1804b1-4389144ee14mr176936965e9.31.1737469543400; 
 Tue, 21 Jan 2025 06:25:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43890461fc6sm184735035e9.29.2025.01.21.06.25.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 06:25:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 25/28] target/sparc: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Tue, 21 Jan 2025 15:23:38 +0100
Message-ID: <20250121142341.17001-26-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121142341.17001-1-philmd@linaro.org>
References: <20250121142341.17001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index fbd38ec334a..94e807f9f84 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -776,11 +776,13 @@ static void sparc_restore_state_to_opc(CPUState *cs,
     }
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool sparc_cpu_has_work(CPUState *cs)
 {
     return (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
            cpu_interrupts_enabled(cpu_env(cs));
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int sparc_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -986,6 +988,7 @@ static const Property sparc_cpu_properties[] = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps sparc_sysemu_ops = {
+    .has_work = sparc_cpu_has_work,
     .get_phys_page_debug = sparc_cpu_get_phys_page_debug,
     .legacy_vmsd = &vmstate_sparc_cpu,
 };
@@ -1027,7 +1030,6 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = sparc_cpu_class_by_name;
     cc->parse_features = sparc_cpu_parse_features;
-    cc->has_work = sparc_cpu_has_work;
     cc->mmu_index = sparc_cpu_mmu_index;
     cc->dump_state = sparc_cpu_dump_state;
 #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
-- 
2.47.1



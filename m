Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B688C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2s82-0007Br-SM; Fri, 03 May 2024 08:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2s80-0007BY-Q2
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:35:05 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2s7x-0002mu-Ux
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:35:03 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41b4ff362a8so84755055e9.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 05:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714739700; x=1715344500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qqRJ8eeBmJ9DTjfEd9O3LsfL/F2mnryvwkwenTeFSg8=;
 b=AEfjwRULGyoT68QBorfmftXvVDXt8jM0fdkjXoSCOhAhEt2D7tN7NHptZ93gxSNTAZ
 IQxwdFwZiyFXCTFOQ61VJqwevz9+zGM+Up8D7isAFXt5RpyTHQFQtD/g7uIgoPw7SfUa
 C4b295SBm5y2HUzrf2rGjYKC+TZjbvCDvyT7sFE0yTmF8X6dAYkAOdXTLAf31G7HWW9F
 27DMob88CSVKagr1/H0fIpxGunD4rg6WmTNdSLfsyVIHmO8FGSnEmRYateD7Ju+Iszau
 hDvJw2KbA3bJCa9A3Q5MoSE2a6HMPQYB7XjO70zXwUkZ0R/tqwkE60qqQ5SfhRqViVGg
 ZOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714739700; x=1715344500;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qqRJ8eeBmJ9DTjfEd9O3LsfL/F2mnryvwkwenTeFSg8=;
 b=RgC2xHDRR5Y3qoraVWzXgz97aNoQi7yUv6BI4fRgTG+gVUJWf1Ju78nZgPkhjGi7ij
 JPzrlFQfNaRUJIPPSEftJl/noVR0JMJt8NmhrhEqoVy91bHsDsPKwSKFnUYh0Y8bewj/
 S6atZwnO4FE+f80zlFkEXV6NTKmWh4MsNUEYwYyVAR4if4Twoyd8lnM6J8LL7a1gPU7i
 R71jO42uZzsHT6lDjkGNGprAMxoDaekZMuOmVj97mjIzJq4Kee0kbf0VbhwyajAD/N22
 FAX118QNGaNFQRBJjLzgLpzzdKFm3KOPlmL/apCiFNeRiR34lK2KRRJNuVmWuQQv546c
 HKow==
X-Gm-Message-State: AOJu0YyP83NFiDacGCaksosThSN7MsheyLAJfpMLA/4Cr7zuyw2YHB3t
 8yk1hRmxmEJC+lHXIRiPvd/6Ql9G/IkArwdIOl/5rLvb0bsX2hieGgcoZXu//GGWDxggW5lr9sC
 7
X-Google-Smtp-Source: AGHT+IFAnN4tLlOcfMQEEZRiwzcSTQ00JWruAvcu3n3MJwlXFL67uYysto4VtbxXu6yKmscRZO3e0g==
X-Received: by 2002:a05:600c:3846:b0:41b:f116:8868 with SMTP id
 s6-20020a05600c384600b0041bf1168868mr2670578wmr.12.1714739699702; 
 Fri, 03 May 2024 05:34:59 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 n20-20020a05600c501400b0041aa79f27a0sm5502229wmr.38.2024.05.03.05.34.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 05:34:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/5] accel/tcg: Call tcg_flush_jmp_cache() again when
 creating user-mode cpu
Date: Fri,  3 May 2024 14:34:51 +0200
Message-ID: <20240503123456.28866-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Since v2:
- Introduce softmmu_specific_ss[]
- Fix broken rebased meson in patch 2

Since v1:
- Dropped patch #1 (use meson subdir_done)

Fix a bug introduced during a refactor in commit bb6cf6f016
("accel/tcg: Factor tcg_cpu_reset_hold() out"), affecting
user emulation. (cpu_reset is called during thread creation,
after cpu_realize).

This issue was noticed by Ilya when running WASM:
https://lore.kernel.org/qemu-devel/20221027141856.w5umjgklawgu7pqv@heavy/

Philippe Mathieu-Daudé (5):
  accel/tcg: Move SoftMMU specific units to softmmu_specific_ss[]
  accel/tcg: Move system emulation files under sysemu/ subdirectory
  accel/tcg: Do not define cpu_exec_reset_hold() as stub
  accel/tcg: Introduce common tcg_exec_cpu_reset_hold() method
  accel/tcg: Always call tcg_flush_jmp_cache() on reset

 accel/tcg/internal-common.h                   |  2 ++
 accel/tcg/{ => sysemu}/tcg-accel-ops-icount.h |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.h  |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops-rr.h     |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops.h        |  0
 accel/tcg/cpu-exec.c                          |  6 ++++++
 accel/tcg/{ => sysemu}/icount-common.c        |  0
 accel/tcg/{ => sysemu}/monitor.c              |  4 ++--
 accel/tcg/{ => sysemu}/tcg-accel-ops-icount.c |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.c  |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops-rr.c     |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops.c        |  5 ++---
 accel/tcg/translate-all.c                     |  5 -----
 accel/tcg/user-exec-stub.c                    |  4 ----
 accel/tcg/user-exec.c                         |  5 +++++
 accel/tcg/meson.build                         | 17 ++++-------------
 accel/tcg/sysemu/meson.build                  | 11 +++++++++++
 17 files changed, 32 insertions(+), 27 deletions(-)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-icount.h (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.h (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-rr.h (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops.h (100%)
 rename accel/tcg/{ => sysemu}/icount-common.c (100%)
 rename accel/tcg/{ => sysemu}/monitor.c (99%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-icount.c (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.c (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-rr.c (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops.c (99%)
 create mode 100644 accel/tcg/sysemu/meson.build

-- 
2.41.0



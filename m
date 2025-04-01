Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43ABEC3601B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWgv-0006ce-NY; Tue, 01 Apr 2025 04:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWgt-0006cS-Ka
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:09:47 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWgq-0005hP-11
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:09:46 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so41333725e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743494981; x=1744099781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=onlaOa0wLpR489FRvJtJWd94e66LthZJ01DW6X1kQEU=;
 b=OI5PQgVwBIqD/FxPka4GFq7W1yT+QMKdDDBWlH1kZfZY/3lkxRoGBb/nkDDdZHJUrR
 VUB1lLG4lA9OeZyJc5FFIDyv3iz7E5N1DubgZ4WhULFecjE0ahSCMhXJEGVNeQWbyCgE
 cVdclzgNOlgD5r1SBhO0E1GihqiqcS987lgfYEiW4E5PWoqir1sc2tRV/DpI/JtBOcQ8
 elWdvdg8NtmCAgxSEEhvXBwbz+GvfhFC4wlRFu7hKXVXAMUsO5GFNfymiXKY3F0TWBRi
 goI753SeJJ0Er+cPAyysXyFvHIj5UyP4NCCZDED+sJhh9EI0dNAPmXm9hAl1GXFCWTHI
 YMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743494981; x=1744099781;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=onlaOa0wLpR489FRvJtJWd94e66LthZJ01DW6X1kQEU=;
 b=VZcozcg6oj4hgOB4FVjZhXxS/ppP/GevWrd9YSvNogkbWk1ZxJPbXO5mZUaMCasvC2
 lJAbUetd6jL0aMoaw6POoj5qWoJ9sj4HmtRYD+dpm76LItfDSGaVcbgF2RQ+DB5aCEcL
 o0PEfT86KIS1JC6pbD2D/dastHiPaAPuUNGaII0Q6DqiDy0FOicc6l+QzRaZrbqEmjUf
 KbsXhFRnaWN0RNiBlxP0sPV8/NvTWs1DsJCKtWHFKUfv+PrFGbs+6AQV82wdmsJJ8quj
 1/RlLy91sGTKzVAgqN29lJdNm1Uy7MKHDkB+qwZTHr36Ael61Q5tC3tslGYPzKakyoBN
 sGrA==
X-Gm-Message-State: AOJu0YwtWjBUXWMV3kiV9XytqkTBXR3Kg/HMZ+eo7N8cmcltt3WUZaai
 cDIyAsflrj0tQelm6DB03wJFARRfOF3dOaQEFYzTMGa2Hjaqk4dnYqXO+0gPBpq4G35RmM380bt
 g
X-Gm-Gg: ASbGncvBBiE6eMr3wqBpEegnWQf/K7XCBirYnWKSN/dNcr5hNPblrIAt7KB1UjCVp0w
 vZB1JCDNXWfgHzgyiCQQZPS7JwQ+tsSU8CRNbGNsjqkrftQ/4QVLaDybAqzJitKpzUq4+/fQCRL
 EmitQt8QMPiSz6Sb7gqz1sIhpHqrU6Pyjkkh+H66nQnImI2v3dnsIfT/uvoSkp9SD/wOy7dR/oB
 Pjq07WED3onS0z72S6YmcXxK2HzK4OMrgbTaA9aAW1YTaq2dB7BtpeLvMxub7yPAqC8ewAfy0LQ
 y30EQKYo2If1eL6A8ojkUSKepYjHaJNgieSfNNJ7f91p1hjM4qWQFNciH+QOKNfW/L/UvhcJzr8
 MRjfY+xf3bwWLmIuS2eo=
X-Google-Smtp-Source: AGHT+IH5npJpSEKMJq9Ss21Hz5FXYnnBfPAZ3klsq9M4W1gtBYivQonOvkPQCVUrrqQTcaN5wBNkJw==
X-Received: by 2002:a05:6000:2a83:b0:39c:1257:cd3e with SMTP id
 ffacd0b85a97d-39c1257d4damr7260448f8f.56.1743494980771; 
 Tue, 01 Apr 2025 01:09:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fcd78bdsm146514415e9.24.2025.04.01.01.09.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:09:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 00/24] cpus: Restrict SoftMMU mmu_index() to TCG
Date: Tue,  1 Apr 2025 10:09:13 +0200
Message-ID: <20250401080938.32278-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

mmu_index() is specific to TCG SoftMMU,
move CPUClass::mmu_index() to TCGCPUOps::mmu_index().

Philippe Mathieu-Daudé (24):
  hw/core/cpu: Update CPUClass::mmu_index docstring
  accel/tcg: Introduce TCGCPUOps::mmu_index() callback
  target/alpha: Restrict SoftMMU mmu_index() to TCG
  target/arm: Restrict SoftMMU mmu_index() to TCG
  target/avr: Restrict SoftMMU mmu_index() to TCG
  target/hppa: Restrict SoftMMU mmu_index() to TCG
  target/i386: Remove unused cpu_(ldub,stb)_kernel macros
  target/i386: Restrict cpu_mmu_index_kernel() to TCG
  target/i386: Restrict SoftMMU mmu_index() to TCG
  target/loongarch: Restrict SoftMMU mmu_index() to TCG
  target/m68k: Restrict SoftMMU mmu_index() to TCG
  target/microblaze: Restrict SoftMMU mmu_index() to TCG
  target/mips: Restrict SoftMMU mmu_index() to TCG
  target/openrisc: Restrict SoftMMU mmu_index() to TCG
  target/ppc: Restrict SoftMMU mmu_index() to TCG
  target/riscv: Restrict SoftMMU mmu_index() to TCG
  target/rx: Restrict SoftMMU mmu_index() to TCG
  target/s390x: Restrict SoftMMU mmu_index() to TCG
  target/sh4: Restrict SoftMMU mmu_index() to TCG
  target/sparc: Restrict SoftMMU mmu_index() to TCG
  target/tricore: Restrict SoftMMU mmu_index() to TCG
  target/xtensa: Restrict SoftMMU mmu_index() to TCG
  hw/core/cpu: Remove CPUClass::mmu_index()
  exec: Restrict cpu-mmu-index.h to accel/tcg/

 include/{exec => accel/tcg}/cpu-mmu-index.h |  9 +++---
 include/accel/tcg/cpu-ops.h                 |  3 ++
 include/exec/cpu_ldst.h                     |  2 +-
 include/hw/core/cpu.h                       |  3 --
 target/i386/cpu.h                           |  3 --
 target/i386/tcg/seg_helper.h                | 10 +++---
 target/i386/tcg/tcg-cpu.h                   |  2 ++
 accel/tcg/translator.c                      |  2 +-
 semihosting/uaccess.c                       |  2 +-
 target/alpha/cpu.c                          |  2 +-
 target/arm/cpu.c                            | 13 ++++----
 target/arm/gdbstub64.c                      |  2 +-
 target/avr/cpu.c                            |  2 +-
 target/hppa/cpu.c                           |  2 +-
 target/hppa/mem_helper.c                    |  2 +-
 target/i386/cpu.c                           | 34 ---------------------
 target/i386/tcg/seg_helper.c                | 17 +++++++++++
 target/i386/tcg/tcg-cpu.c                   | 18 +++++++++++
 target/i386/tcg/translate.c                 |  2 +-
 target/loongarch/cpu.c                      |  2 +-
 target/loongarch/cpu_helper.c               |  2 +-
 target/m68k/cpu.c                           |  2 +-
 target/microblaze/cpu.c                     |  2 +-
 target/microblaze/helper.c                  |  2 +-
 target/microblaze/mmu.c                     |  2 +-
 target/mips/cpu.c                           |  2 +-
 target/openrisc/cpu.c                       |  2 +-
 target/openrisc/translate.c                 |  2 +-
 target/ppc/cpu_init.c                       |  2 +-
 target/riscv/cpu.c                          |  6 ----
 target/riscv/tcg/tcg-cpu.c                  |  6 ++++
 target/rx/cpu.c                             |  2 +-
 target/s390x/cpu.c                          |  2 +-
 target/sh4/cpu.c                            |  2 +-
 target/sparc/cpu.c                          |  4 +--
 target/sparc/mmu_helper.c                   |  2 +-
 target/tricore/cpu.c                        |  2 +-
 target/tricore/helper.c                     |  2 +-
 target/xtensa/cpu.c                         |  2 +-
 target/xtensa/mmu_helper.c                  |  2 +-
 40 files changed, 91 insertions(+), 91 deletions(-)
 rename include/{exec => accel/tcg}/cpu-mmu-index.h (78%)

-- 
2.47.1



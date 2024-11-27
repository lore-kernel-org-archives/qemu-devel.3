Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F023D6ACC3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 12:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGGyn-0004c6-Ny; Wed, 27 Nov 2024 07:17:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGGyg-0004bc-UI
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:17:08 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGGyd-0008HP-6v
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:17:05 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3824a089b2cso4072617f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 04:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732709821; x=1733314621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ykizpikhbbR64k89NcHFPcFupVTJPLDj3sT73UvG9LQ=;
 b=sy7ZcN5wMh/jw4F7rjO5W+NkOY7WgS1AdEVT+XZZq/4zhMpG+Tdxh+2yqP5qpgaONC
 7tHs2wGjci0mrq8r0tnLT9W719+eqr0cB4q0SUljGWS6KLcTDWtNHqsImIpSITm4RZ6c
 WWsZzqozoFXW/4SQa+dJDKdgsLi4uZRdEjAuvRkCgSJllI0CrJBj3n0XgqD6gETjsVrg
 ErL97eusFZQubCmfidrNQnUoMB2MxzNFDcZKrETNykxwNBKpBnuEfFi02bb3mKc7TFWn
 zI9T25qwTzXSk1r+zlvPsLlTchHnNk/BvaAM+EsLcKo6/Q/IoOH7aXIYUc8r0rZySQwP
 VPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732709821; x=1733314621;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ykizpikhbbR64k89NcHFPcFupVTJPLDj3sT73UvG9LQ=;
 b=EwZr13we2kEHA/PffuqpLV4PsFJiIXbUIPgmiyQNLjtCx8Y5pYeVX3C5bW0nDbrbnV
 vax2HJoSWdRI/9u4WQ8sEMU02oPLGzix6/2u+RkwpY0F0HFdRNI/y+cUr8NPpGmyJ79k
 AQvUETnlSv0XUYUTq/SIeXf4tRDq23fjjHO/Tfs/0JPzD1+TxaAHaY7f6SZ26ZvUDbd6
 Yr4mLitjVh2/krD/sAEbO+hPYQqNOr7aOxCTC8T7rscad3zYYfIJ4pk39bWZSqYRLhSt
 UfMsWFuo6imN/7+hvzbx24KnoW3Caxlud7ZmWmzDS6Ei4Pa3lKo1d4Tru/BcxKeyLVJc
 nI2g==
X-Gm-Message-State: AOJu0YwghlhigL84uCp3mclwHepgQNO4/hTTyMPHFCVQVtfV3hqdjRQ0
 5oUxkJ2gXcaFd6EHbpTD0rSbysIAvgH+iim78BIXh8WSiKFh5ssbGjHpVUzn5F8n5FIo8/f/qIz
 W
X-Gm-Gg: ASbGncs0v1LwgLOPsdZ4p7qCXAaMKM7f67fhBjE8+FEjzCN4nkZVYEwHCsLBsTgtyr2
 G7VaRjhSczJkwbk8q5o9KtUyjUdprIONbKJb+nPG8gC7s+/YNhZCQUw8IOolYnOM/d3n0XbSbf4
 o3LKhogH2YUI/hLKRftpkvr9tNAM3DhGfgi0MYDAU9CPhR5rQzQHtHkMd9n1gm9EuAY9Aoh2Tca
 0EmxTZ7RGxO9BooXx9wa/+o0Y4BqWm94yYEG9X1KlonqBZ2APL4oQjcryRJDzihrv0Bf6zDBWUE
 t+7zKlzCpnBT0aClMXI+8uWLg5kV6yKPhI25Va0A2b8=
X-Google-Smtp-Source: AGHT+IGxpTU+8ZwAuK4sdirLAuQpjVZ44+p7Zvonp3A6yklx9gBM81ElXcvd1gRFp+9gq7Dk0qjeeQ==
X-Received: by 2002:a05:6000:692:b0:382:3e51:4b1d with SMTP id
 ffacd0b85a97d-385c6eba043mr2630634f8f.20.1732709821229; 
 Wed, 27 Nov 2024 04:17:01 -0800 (PST)
Received: from localhost.localdomain
 (plb95-h02-176-184-14-96.dsl.sta.abo.bbox.fr. [176.184.14.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fad6270sm16073937f8f.14.2024.11.27.04.17.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Nov 2024 04:17:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 0/6] accel/tcg: Allow tcg_exec_realizefn() initialize
 multiple frontends
Date: Wed, 27 Nov 2024 13:16:52 +0100
Message-ID: <20241127121658.88966-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Little step toward heterogeneous emulation. After few trivial
cleanups, allow accel_cpu_common_realize() -> tcg_exec_realizefn()
to call frontend TCGCPUOps::initialize() for different targets.

Philippe Mathieu-Daudé (6):
  target/ppc: Indent ppc_tcg_ops[] with 4 spaces
  accel/tcg: Declare local tcg_ops variable in tcg_exec_realizefn()
  accel/tcg: Rename TCGCPUOps::initialize() as initialize_once()
  include: Expose QemuArch in 'qemu/arch_id.h'
  accel/tcg: Add TCGCPUOps::arch_id field
  accel/tcg: Allow tcg_exec_realizefn() initialize multiple frontends

 include/hw/core/tcg-cpu-ops.h |  9 ++++++---
 include/qemu/arch_id.h        | 28 ++++++++++++++++++++++++++++
 include/sysemu/arch_init.h    | 28 +++-------------------------
 accel/tcg/cpu-exec.c          | 13 +++++++------
 target/alpha/cpu.c            |  3 ++-
 target/arm/cpu.c              |  3 ++-
 target/arm/tcg/cpu-v7m.c      |  3 ++-
 target/avr/cpu.c              |  3 ++-
 target/hexagon/cpu.c          |  3 ++-
 target/hppa/cpu.c             |  3 ++-
 target/i386/tcg/tcg-cpu.c     |  3 ++-
 target/loongarch/cpu.c        |  3 ++-
 target/m68k/cpu.c             |  3 ++-
 target/microblaze/cpu.c       |  3 ++-
 target/mips/cpu.c             |  3 ++-
 target/openrisc/cpu.c         |  3 ++-
 target/ppc/cpu_init.c         | 30 +++++++++++++++---------------
 target/riscv/tcg/tcg-cpu.c    |  3 ++-
 target/rx/cpu.c               |  3 ++-
 target/s390x/cpu.c            |  3 ++-
 target/sh4/cpu.c              |  3 ++-
 target/sparc/cpu.c            |  3 ++-
 target/tricore/cpu.c          |  3 ++-
 target/xtensa/cpu.c           |  3 ++-
 24 files changed, 97 insertions(+), 68 deletions(-)
 create mode 100644 include/qemu/arch_id.h

-- 
2.45.2



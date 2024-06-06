Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CB6C27C5E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 03:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF3ol-0003Vr-Km; Wed, 05 Jun 2024 23:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF3ok-0003Vc-AI
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:29:34 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF3of-0003m3-CQ
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:29:31 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-681bc7f50d0so1150636a12.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 20:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717644568; x=1718249368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yAhR3pNp27v16bA5nOHMXZRb+BlQPJ5i0gki3Nov2RY=;
 b=VpwnyseQ6A6sitwyP7Pbp9DZffVpbL3P1J5bEG0H7lHZne1w1ehjYJH9Mc/K/BX9sm
 bKksvw9nZHhXf6mn88V+RlLY8k0lKQoXcWGgynzoGR09B+YAtZQ3y36+cLMRCFsQbnly
 b9mqN9oOqNvFifLyq5r6q9gy38dLz5jctS49Wh0DAwt65YVe9TzuqrdY+nvmYxev4PBB
 +/Q+yA8XT7uRkgZdGzQTDczNvG8KdyBictIu7wx8iPm5XmQJuhn+/76mmD9oVqQI4AX4
 LkmBzNSuu87KQpJYvu522U1/f3BtaaXbNC0UXfsnxezkeCI1t99d+HGuh80NIy3FI4tG
 zC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717644568; x=1718249368;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yAhR3pNp27v16bA5nOHMXZRb+BlQPJ5i0gki3Nov2RY=;
 b=SPpHUL+zxQOycRhiasqZuz5mLJzoYOlLPNxWjjkgmyTUDPXUbKME88ip10g2O3HcON
 tVEgzkRTM3DjDNSoCaWbRjaDVJPWUNU/JcEe3b4AjOKi6ZV55EY6b3x+xEfMSk+YtldZ
 Th0ltcTDkXgAN9V/10ik2Kbv88Yj/ADR9UE8OxurpLx5g52rawzTyRYZpypzJpnliOdD
 R9UDBuE1dfXKSjSCpB6iugAq427HbHIFznF2gdT2R4u4XeBS2LVpcrAMUKRR4piblt5E
 pvi6GBE625ORJZ2m6tMISKVdOF3YBlt7FGGKpdsWcj1qJuQTgOmVUqQojgSmj376V5Mc
 /t0g==
X-Gm-Message-State: AOJu0Ywu+BS4ZnplPQY8yeqdYqmN96DH3zXJryVMFy8GGrd5nb+HJnWW
 Hq+8momIymffAXV7vGqQpXvYRcJGHM1VEiyhN7e68Hjt19X/Mp7bGKTThaNNy4SUc0WWGp8t1R8
 7
X-Google-Smtp-Source: AGHT+IFYYJ7QDTo19I2yw3H79XsK9boZahz5VtPVrdbFPK8onHVlQDyZLgX4pvzpBMcWlKKCY3aRtQ==
X-Received: by 2002:a17:90a:9a8:b0:2b9:fc72:547e with SMTP id
 98e67ed59e1d1-2c2999d8736mr1971559a91.18.1717644567806; 
 Wed, 05 Jun 2024 20:29:27 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c254a76729sm4826265a91.0.2024.06.05.20.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 20:29:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v2 0/9] plugins: Use unwind info for special gdb registers
Date: Wed,  5 Jun 2024 20:29:17 -0700
Message-Id: <20240606032926.83599-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


This is an attempt to fix
https://gitlab.com/qemu-project/qemu/-/issues/2208
("PC is not updated for each instruction in TCG plugins")

I have only updated target/{i386,arm} so far, but basically all
targets need updating for the new callbacks.  Extra points to
anyone who sees how to avoid the extra code duplication.  :-)


r~


Richard Henderson (9):
  tcg: Introduce INDEX_op_plugin_pc
  accel/tcg: Set CPUState.plugin_ra before all plugin callbacks
  accel/tcg: Return the TranslationBlock from cpu_unwind_state_data
  plugins: Introduce TCGCPUOps callbacks for mid-tb register reads
  target/i386: Split out gdb-internal.h
  target/i386: Introduce cpu_compute_eflags_ccop
  target/i386: Implement TCGCPUOps for plugin register reads
  target/arm: Add aarch64_tcg_ops
  target/arm: Implement TCGCPUOps for plugin register reads

 include/exec/cpu-common.h     |  9 +++--
 include/hw/core/cpu.h         |  4 +-
 include/hw/core/tcg-cpu-ops.h | 14 +++++++
 include/tcg/tcg-op-common.h   |  1 +
 include/tcg/tcg-opc.h         |  1 +
 target/arm/internals.h        |  8 +++-
 target/i386/cpu.h             |  2 +
 target/i386/gdb-internal.h    | 65 +++++++++++++++++++++++++++++++
 accel/tcg/plugin-gen.c        | 49 +++++++++++++++++++++---
 accel/tcg/translate-all.c     |  9 +++--
 plugins/api.c                 | 36 +++++++++++++++++-
 target/arm/cpu.c              | 40 ++++++++++++++++++-
 target/arm/cpu64.c            | 55 ++++++++++++++++++++++++++
 target/arm/tcg/cpu-v7m.c      |  2 +
 target/i386/gdbstub.c         |  1 +
 target/i386/helper.c          |  6 ++-
 target/i386/tcg/cc_helper.c   | 10 +++++
 target/i386/tcg/tcg-cpu.c     | 72 +++++++++++++++++++++++++++--------
 tcg/tcg-op.c                  |  5 +++
 tcg/tcg.c                     | 10 +++++
 20 files changed, 360 insertions(+), 39 deletions(-)
 create mode 100644 target/i386/gdb-internal.h

-- 
2.34.1



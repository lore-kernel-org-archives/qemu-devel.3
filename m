Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E06C10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 12:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1mas-0006BM-Gv; Tue, 30 Apr 2024 08:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mam-00068B-6W
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:28:16 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1maj-0001ki-C3
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:28:14 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5708d8beec6so7040658a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 05:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714480091; x=1715084891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2tBp0mlEikyBoUziZaOlwZMYYgeW174NsUEHbMeFk28=;
 b=D1djEO06bELmaz26JAtU0ogkMJqqlRPLXSEkK2RHk/AmQIwJMIELk3v3y/uxUSqpIy
 DdR9uVYm4QsjmW71MI1VS+j/uIHBTZR714usAHqrRX1Y/P9gOCUJK99w1Pb9gyPUHyWk
 fMFhUNuT/GDpoVUwvcTzd05OULBjK3hhP37czRmRIg/yv/nYhaGtEqm8V9JrP1Y7/2hQ
 JuokZn7xRBMOo2Ht8reYMJsHgJUxDhFB888TUE2MkPxSjggYCcayMa3DPSp1m1F9Ozwl
 2w3ws8LfZteWDmmfUvkx4xb54hRV4tznLl32/2W3uv1CA+HOGu6/YgBm5H+wtrHiLcVG
 yqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714480091; x=1715084891;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2tBp0mlEikyBoUziZaOlwZMYYgeW174NsUEHbMeFk28=;
 b=cdzZYR88o5pwGSl/9TlFRh7TcQTb3q2ZYav6ykeW2uJy8qQwoFig36Qk/1zUTzDvE8
 2IPUTSd+QN7pkr1sp/zmwSX4KnkSTAQLwm+IYUg0TYg+954/k/bA910h0hV0eUIIWLUZ
 BKfplbyKYAX2KS93Q8TXh+ffmtgSy4swZ6lKdN9sD+TqIjczFHQGH+84m61y7WqMfJ6J
 dhpL/VwwDGHA5saUpo019ohLd+zfUUBQ+64RJrepbVT9PBA3H8Y6BpYFcwTHt2IUC0Zj
 eXf/FbXXUDj2TjERWq2UMp1uTb6CxFWvwIfFERfsdQUGDUyw65YZuiKZaSDLQWVT+I2K
 VU2g==
X-Gm-Message-State: AOJu0YwbJA+T4DUADu/36qduVdbz0+V2qeNEynqrchTKrERSgoyoXHaD
 2mVzi/2u3fL8Lk7RUFcruKIrucwFr5okCoUffcXyjS69aSjXWK2sUsuIDIGZqEkCPaARGY8l3qa
 w
X-Google-Smtp-Source: AGHT+IGPLx+TVUvWu5qeFhKmKzau1URV5u70IUZED+IMtKUei3OSVUtPB3NoKNCHRe37hoIKmMNk6g==
X-Received: by 2002:a50:baed:0:b0:56e:7722:553 with SMTP id
 x100-20020a50baed000000b0056e77220553mr11669296ede.24.1714480091173; 
 Tue, 30 Apr 2024 05:28:11 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 b10-20020aa7dc0a000000b0056fe755f1e6sm14005139edu.91.2024.04.30.05.28.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 05:28:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/13] exec: Rework around CPUState user fields (part 2)
Date: Tue, 30 Apr 2024 14:27:54 +0200
Message-ID: <20240430122808.72025-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

Missing WASM testing by Ilya (branch available at
https://gitlab.com/philmd/qemu/-/commits/tcg_flush_jmp_cache)

Since v2:
- Move cpu_loop_exit_requested() to "exec/cpu-loop.h"
- Added R-b tags

Since v1:
- First 13 patches queued
- Restrict qemu_plugin_vcpu_exit_hook() to (TCG) plugins
- Restrict cpu_plugin_mem_cbs_enabled() to TCG (plugins)
- Addressed Richard review comments on the others:
  - Move cpu_plugin_mem_cbs_enabled()
  - Do not move mem_io_pc, waiting for [*]
  - Mention can_do_io restricted

Finish extracting TCG fields from CPUState:
- Extract tcg_cpu_exit() from cpu_exit()
- Introduce AccelOpsClass::exit_vcpu_thread()
- cpu_exit() calls exit_vcpu_thread=tcg_cpu_exit for TCG
- Forward declare TaskState and more uses of get_task_state()
- Introduce TCG AccelCPUState
- Move TCG specific fields from CPUState to AccelCPUState
- Restrict "exec/tlb-common.h" to TCG
- Restrict iommu_notifiers, icount to system emulation

[*] https://lore.kernel.org/qemu-devel/20240416040609.1313605-3-richard.henderson@linaro.org/

Based-on: https://gitlab.com/philmd/qemu/-/commits/accel-next

Philippe Mathieu-Daudé (13):
  accel/tcg: Restrict qemu_plugin_vcpu_exit_hook() to TCG plugins
  accel/tcg: Restrict cpu_plugin_mem_cbs_enabled() to TCG
  accel/tcg: Move @plugin_mem_cbs from CPUState to
    CPUNegativeOffsetState
  accel/tcg: Move @plugin_state from CPUState to TCG AccelCPUState
  accel/tcg: Restrict cpu_loop_exit_requested() to TCG
  accel/tcg: Restrict IcountDecr / can_do_io / CPUTLB to TCG
  accel/tcg: Move @jmp_env from CPUState to TCG AccelCPUState
  accel/tcg: Move @cflags_next_tb from CPUState to TCG AccelCPUState
  accel/tcg: Move @iommu_notifiers from CPUState to TCG AccelCPUState
  accel/tcg: Move @tcg_cflags from CPUState to TCG AccelCPUState
  accel/tcg: Restrict icount to system emulation
  accel/tcg: Move icount fields from CPUState to TCG AccelCPUState
  accel/tcg: Move @tb_jmp_cache from CPUState to TCG AccelCPUState

 accel/tcg/internal-common.h      | 18 ++++++++++
 accel/tcg/tb-jmp-cache.h         |  4 +--
 accel/tcg/tcg-accel-ops.h        |  1 +
 accel/tcg/vcpu-state.h           | 20 +++++++++++
 include/exec/cpu-loop.h          | 35 +++++++++++++++++++
 include/exec/exec-all.h          | 17 ----------
 include/exec/tlb-common.h        |  4 +++
 include/hw/core/cpu.h            | 58 ++++++++------------------------
 include/qemu/plugin.h            |  2 +-
 include/qemu/typedefs.h          |  1 -
 accel/tcg/cpu-exec-common.c      |  2 +-
 accel/tcg/cpu-exec.c             | 52 +++++++++++++++-------------
 accel/tcg/cputlb.c               |  2 +-
 accel/tcg/icount-common.c        |  7 ++--
 accel/tcg/plugin-gen.c           |  9 +++--
 accel/tcg/tb-maint.c             |  6 ++--
 accel/tcg/tcg-accel-ops-icount.c | 14 ++++----
 accel/tcg/tcg-accel-ops.c        |  2 ++
 accel/tcg/translate-all.c        |  9 ++---
 accel/tcg/watchpoint.c           |  5 +--
 hw/core/cpu-common.c             |  9 +++--
 linux-user/main.c                |  2 +-
 plugins/core.c                   |  9 ++---
 system/physmem.c                 | 37 +++++++++++++++-----
 target/arm/tcg/helper-a64.c      |  1 +
 target/s390x/tcg/mem_helper.c    |  1 +
 26 files changed, 195 insertions(+), 132 deletions(-)
 create mode 100644 include/exec/cpu-loop.h

-- 
2.41.0



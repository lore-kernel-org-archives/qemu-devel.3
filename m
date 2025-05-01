Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E19C3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANKt-00055n-VY; Thu, 01 May 2025 02:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANKt-00055T-BS
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:23:55 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANKr-00070X-DG
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:23:55 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso626078b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080631; x=1746685431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rkK6B1xUwpIIGqtDFIUiUmTkZGBt+hJWF4dMkT/mNuo=;
 b=EG/nYcDfLfxqTcXK5qWNK5c6RYD6iUt64n1dcpMiCaI7/lc+VnnK7ZqXirAEN7FIzv
 5HAHFLkI6GWMNr7GV3Z7H2il+/YHzvxek48Gmqk7vYOv66Nyn0fbhcoE0uS8EXLS27Mn
 PcBAzyAjWFgIzhaYip8iYwbLjJWxO6dLiCXy35D92Hib4XRnE2L75Hnrt146l8/1xp/j
 nGT1/K0TMVoDBkxKB/tEeJHtU+wREjawm5JA8ilOZawtuokwls0Z+gb3Fc38IeMzDfcz
 lw7WvyikxU+dgiRBVBdMQZMY+htZK9D9z94ahDe0azAwp7SPu742Rc+JbAvhdB/uD1qN
 hZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080631; x=1746685431;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rkK6B1xUwpIIGqtDFIUiUmTkZGBt+hJWF4dMkT/mNuo=;
 b=sdt30Eb0i5PcZWnXoQeZFpH4QeOoCbzbbyY+KeECHgO1fgYLdhHYErgcmH6mzd2Nk5
 3XQarFeH8hMSleZP9rwheBJ/ST2mUBphBa1gGd2pYbWI3weRcwZLSy4QoPuIoNwRRYAM
 j3LSNVN0aQJbrc3nWOMdPvmb2+OTolVa6k4q/KNTQtrWDYPLjUZzZsL3UKGzjEc9dupe
 teljWIlTSzQ8cDbqDQSs/ZSJrIJpXZ0pw8GNzoXWnVUBrXy+hKHUaaJAq6OjUsQnpn9z
 MGZyRsdb0a51ykicPn3bh6Z6FcPi8CrB6k2ZwhBudNK4USyzJkaQ00wNSrW3cV3RlrFr
 1KLA==
X-Gm-Message-State: AOJu0YwHtkmu3nZ6aUykmdZdeAsTd+gPx/2A9dGLGtp88kpDmKs9RZh1
 Y127GkJvoHQ9rGwGo+7RRSqLuB4CpJ0egLkeqK6KrhSyJjmN5/PodTcwtnt/YYXdTLUzRww8/UI
 S
X-Gm-Gg: ASbGncvVZ0pX39gH0dQnlv3e6NP3uqckUtaNdv2k3uwYo/Lu14hB4tVPhUDAxHIPHuK
 YnOHM8GLFnKmtY1SDiVfh3fLznm1oD7YovQFCsqSKEmqkKfjub5ea+aHQ2WKtrkjk0DuKARQfq8
 T7Bt0iPJr2Kc464Iuh84XBN1pAPiQyUnq9311rYr3Qx+g7LOMSObQbvK8Xfo3ZGqKO0tlO4Gx0+
 2l8JupfhokG0Xm3B7JLPsoIdlw5rbYXTmBzT4HwvUdQH/wzKroEfcCFHupP+NXV0n59tI+PMdRB
 Y+Us2Q1RawS/Pr4GAiIguiG7DOw4Weijmgr41yYY
X-Google-Smtp-Source: AGHT+IE+QE3VdhRxsOSZO494VE5KFtC0CSO9PmXREhijoNUJXdUHnZkCg1m0jSY9sHBEloCWq/dRiA==
X-Received: by 2002:a05:6a00:2450:b0:73e:30af:f479 with SMTP id
 d2e1a72fcca58-74038a834fcmr8492876b3a.19.1746080631530; 
 Wed, 30 Apr 2025 23:23:51 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:23:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 00/33] single-binary: compile target/arm twice
Date: Wed, 30 Apr 2025 23:23:11 -0700
Message-ID: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

More work toward single-binary.

Some files have external dependencies for the single-binary:
- target/arm/machine.c: migration
- target/arm/gdbstub.c: gdbhelpers
- target/arm/arm-qmp-cmds.c: qapi
They will not be ported in this series.

Built on {linux, windows, macos} x {x86_64, aarch64}
Fully tested on linux-x86_64

v1
--

- target/arm/cpu.c

v2
--

- Remove duplication of kvm struct and constant (Alex)
- Use target_big_endian() (Anton)

v3
--

CI: https://github.com/pbo-linaro/qemu/actions/runs/14765763846/job/41456754153
- Add missing license for new files (Richard)
- target/arm/debug_helper.c
- target/arm/helper.c
- target/arm/vfp_fpscr.c
- target/arm/arch_dump.c
- target/arm/arm-powerctl.c
- target/arm/cortex-regs.c
- target/arm/ptw.c
- target/arm/kvm-stub.c

Philippe Mathieu-Daudé (1):
  target/arm: Replace target_ulong -> uint64_t for HWBreakpoint

Pierrick Bouvier (32):
  include/system/hvf: missing vaddr include
  meson: add common libs for target and target_system
  target/arm: move kvm stubs and remove CONFIG_KVM from kvm_arm.h
  target/arm/kvm-stub: add kvm_arm_reset_vcpu stub
  target/arm/cpu: move arm_cpu_kvm_set_irq to kvm.c
  accel/hvf: add hvf_enabled() for common code
  target/arm/cpu: remove TARGET_BIG_ENDIAN dependency
  target/arm/cpu: remove TARGET_AARCH64 around aarch64_cpu_dump_state
    common
  target/arm/cpu: remove TARGET_AARCH64 in arm_cpu_finalize_features
  target/arm/cpu: compile file twice (user, system) only
  target/arm/cpu32-stubs.c: compile file twice (user, system)
  target/arm/helper: use i64 for exception_pc_alignment
  target/arm/helper: user i64 for probe_access
  target/arm/helper: extract common helpers
  target/arm/debug_helper: only include common helpers
  target/arm/debug_helper: remove target_ulong
  target/arm/debug_helper: compile file twice (user, system)
  target/arm/helper: restrict include to common helpers
  target/arm/helper: replace target_ulong by vaddr
  target/arm/helper: expose aarch64 cpu registration
  target/arm/helper: remove remaining TARGET_AARCH64
  target/arm/helper: compile file twice (user, system)
  target/arm/vfp_fpscr: compile file twice (user, system)
  target/arm/arch_dump: remove TARGET_AARCH64 conditionals
  target/arm/arch_dump: compile file once (system)
  target/arm/arm-powerctl: compile file once (system)
  target/arm/cortex-regs: compile file once (system)
  target/arm/ptw: replace target_ulong with uint64_t
  target/arm/ptw: remove TARGET_AARCH64 from arm_casq_ptw
  target/arm/ptw: compile file once (system)
  target/arm/meson: accelerator files are not needed in user mode
  target/arm/kvm-stub: compile file once (system)

 meson.build                    |   78 ++-
 include/system/hvf.h           |   15 +-
 target/arm/helper.h            | 1152 +------------------------------
 target/arm/internals.h         |    6 +-
 target/arm/kvm_arm.h           |   83 +--
 target/arm/tcg/helper.h        | 1153 ++++++++++++++++++++++++++++++++
 accel/hvf/hvf-stub.c           |    5 +
 target/arm/arch_dump.c         |    6 -
 target/arm/cpu.c               |   47 +-
 target/arm/cpu32-stubs.c       |   26 +
 target/arm/debug_helper.c      |    6 +-
 target/arm/helper.c            |   21 +-
 target/arm/hyp_gdbstub.c       |    6 +-
 target/arm/kvm-stub.c          |   87 +++
 target/arm/kvm.c               |   29 +
 target/arm/ptw.c               |   17 +-
 target/arm/tcg/op_helper.c     |    2 +-
 target/arm/tcg/tlb_helper.c    |    2 +-
 target/arm/tcg/translate-a64.c |    2 +-
 target/arm/tcg/translate.c     |    2 +-
 accel/hvf/meson.build          |    1 +
 target/arm/meson.build         |   43 +-
 22 files changed, 1436 insertions(+), 1353 deletions(-)
 create mode 100644 target/arm/tcg/helper.h
 create mode 100644 accel/hvf/hvf-stub.c
 create mode 100644 target/arm/cpu32-stubs.c

-- 
2.47.2



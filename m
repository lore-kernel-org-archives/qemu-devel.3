Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20F0CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcTq-0002vW-1A; Tue, 28 Oct 2025 01:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcTn-0002uf-La
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:42:47 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcTk-0002Vb-ID
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:42:47 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4710022571cso57174725e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 22:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761630162; x=1762234962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TxoiiHiCXSU5nnAYSK/zPyoSYUOWJlUR2QXU/IE63io=;
 b=LBEmlCUnXiujsqlXLefqHgAEgdafC4M9og4BC8N7XxstckDA/hVhpTCwySjvGRNeiF
 e7uAhVLe+/LtwYkCADh9oFJNl0MTKG8ekXyhZFA23sTl9XDcA75Mh9dsPF6uvHbY8iF4
 CY1zASEOKkqKwFi10EWUFh4gHdnT4bHZfCpvbvBsQkc7ffKEvQVxL9/o6kc+BKgn8d31
 M7O94qdSaM7sTFo8W2K+dX+ZKmjbml55WUjZSul7G59Ztcit4SjBkiI7X6qRjrrPgh6p
 Mwmoi+5pRcEyB1ullo081cCUj32nXWzotoMDQ686nNIP7how2I4QwAk+QcZMZRjliSPD
 x9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761630162; x=1762234962;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TxoiiHiCXSU5nnAYSK/zPyoSYUOWJlUR2QXU/IE63io=;
 b=kx8ZCa+xMLR8ur7CQRJB7Y8wYaH3CJDR3bRn8qrhQQvJQvrI2eBnaTyhLPw7L+Kgwe
 EcFh+IBXZe6NiRi6tMd4MQmBaClbKlroyKeffdWS0+3jKdK0VDGZmlOZg7X9pC5mQPJX
 ChDpnnGp9ZttZM+c44v7avm/OpCjcm3HIEtcHPXvmvjJD0xakNKfEFmwCmQ0kqC4oDZG
 N9BvcdjputP4DGdMHELM8k/YhGT7wuaNXPmsJNLj1lQlKQTJ3JcII3Cpi0PrShKcfxEs
 t6uIZsIysA7SkYWgSiSwU0OPZUGn+EPBXgC/pDMTCjENgEfqllpuA/DVA/rtf0+8bt5B
 Mh9A==
X-Gm-Message-State: AOJu0YwJ2rHDGOvTseZVeqzh/hbcxUERZhY5dGOiYwuaUgbRr0DV9uzX
 Stogyb+Pk7QM8PUb8Ry4A0SByhaJ5SXfdGcqz6+J6D9eiAtiRxYvez0ISVepQuaEk33x2PZm97Z
 lNQTikHA=
X-Gm-Gg: ASbGncsQ8WlTohGZ8BCg6yROkh62wusx4n/sHIysBJOlt6iJhwd0ica2dS9cLLo+Xcp
 uc8ucJZSrRbq9WzRybIBpsD+lBf7IFDqE3CNgZJLiFFM3XMVPujuugkNpq+owN9Olgf5lbyOAq+
 JNFSrjODmkzMdpdAOpVNHN5gmXz/t5vzgb9JgtLM+Le6iV0wXhy+aJ7YjByV5VjcQeXRT0DcUHE
 BCQl3Dj68ZJ+FwPEklpYin3wYYoi6uKKvvvTyzW15EcIOmU/XuahQ/GpMgF9BE6QuMv2fGue9wb
 a97Hok/59UbezkoU+0eYHA0D5XQbgzSm3tOMM2aLFlVPvZO8pgwoBhQBPZYjfxaG1C4j7dQcM3r
 V2olqz+3dPOmwzKI3v4yD2kDJWT1y8G/G2rwFekAsg/B1YNO64C8S9HUq+IfVPO5tg8XZ5OLYv2
 Yr0cdL41TiRLf+iZx4VTxyi5aSII9t+aVe20WkXkaxj0WPQRpcmreleUk=
X-Google-Smtp-Source: AGHT+IF7Q9KXvh3Wq0e9aaTrFDFEqTMWeSbcpZpMzGTHGnZ9514f+gYsgGswlP29jJxc2c0CPtVAFg==
X-Received: by 2002:a05:600c:8718:b0:475:d917:7218 with SMTP id
 5b1f17b1804b1-47717e60bfbmr18246105e9.36.1761630161682; 
 Mon, 27 Oct 2025 22:42:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d514asm18274803f8f.23.2025.10.27.22.42.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 22:42:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/59] target/arm/hvf: Consolidate
Date: Tue, 28 Oct 2025 06:41:36 +0100
Message-ID: <20251028054238.14949-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Missing review: 15, 18, 26, 32, 33, 38 (up to #41 could be merged)
                42, 43 (up to #49 could be merged)
                50+

Since v2:
- Improve host page size/mask uses (rth)
- Remove cpu_test_interrupt in hvf_wfi (rth)

Since v1:
- Addressed Mads & Richard comments
- Fixed migration by reworking memory listeners
  (unfortunately the current broken code has been
   used as base for WHPX)
- Sync CNTV_CTL/CVAL_EL0
- Remove WFI racy signal implementation
- Simplify PSCI Suspend (I expect the same can be
  done for the other hvf_psci_cpu_off() calls).
- Emulate more missing registers (PMU & Monitor Dbg)

From v1:
- Fix a pair of memory leak
- Check a pair of return values
- Mention calls which must be run on vCPU thread
- Force MIDR
- Use hv_vcpu_config_create/hv_vcpu_config_get_feature_reg
  when not running on vCPU thread
- Factor hvf_handle_vmexit() / hvf_handle_exception(() out
- Call hv_vcpu_run() in loop
- Guard hv_vcpu_run() between cpu_exec_start/end()
- Restrict ARM specific in AccelCPUState

Based-on: <20250829152909.1589668-14-pbonzini@redhat.com>

Mohamed Mediouni (2):
  target/arm/hvf: Hardcode Apple MIDR
  target/arm/hvf: switch hvf_arm_get_host_cpu_features to not create a
    vCPU

Philippe Mathieu-Daudé (48):
  target/arm/hvf: Release memory allocated by hv_vcpu_config_create()
  target/arm/hvf: Trace vCPU KICK events
  target/arm/hvf: Check hv_vcpus_exit() returned value
  target/arm/hvf: Check hv_vcpu_set_vtimer_mask() returned value
  accel/hvf: Rename hvf_vcpu_exec() -> hvf_arch_vcpu_exec()
  accel/hvf: Rename hvf_put|get_registers -> hvf_arch_put|get_registers
  target/arm/hvf: Mention flush_cpu_state() must run on vCPU thread
  accel/hvf: Mention hvf_arch_init_vcpu() must run on vCPU thread
  target/arm/hvf: Mention hvf_sync_vtimer() must run on vCPU thread
  target/arm/hvf: Mention hvf_arch_set_traps() must run on vCPU thread
  accel/hvf: Mention hvf_arch_update_guest_debug() must run on vCPU
  target/arm/hvf: Mention hvf_inject_interrupts() must run on vCPU
    thread
  accel/hvf: Implement hvf_arch_vcpu_destroy()
  target/arm/hvf: Simplify hvf_arm_get_host_cpu_features()
  target/arm/hvf: Factor hvf_handle_exception() out
  target/i386/hvf: Factor hvf_handle_vmexit() out
  target/arm/hvf: Factor hvf_handle_vmexit() out
  target/arm/hvf: Keep calling hv_vcpu_run() in loop
  cpus: Trace cpu_exec_start() and cpu_exec_end() calls
  accel/hvf: Guard hv_vcpu_run() between cpu_exec_start/end() calls
  target/arm: Call aarch64_add_pauth_properties() once in host_initfn()
  accel/hvf: Restrict ARM specific fields of AccelCPUState
  target/arm: Rename init_cpreg_list() -> arm_init_cpreg_list()
  target/arm/hvf: Rename 'vgic' -> 'emu_reginfo' in trace events
  target/arm: Re-use arm_is_psci_call() in HVF
  target/arm: Share ARM_PSCI_CALL trace event between TCG and HVF
  target/arm/hvf/hvf: Document $pc adjustment in HVF & SMC
  accel/hvf: Trace prefetch abort
  accel/hvf: Enforce host alignment in hv_vm_protect()
  target/i386/hvf: Use host page alignment in ept_emulation_fault()
  accel/hvf: Skip WFI if CPU has work to do
  accel/hvf: Implement WFI without using pselect()
  accel/hvf: Have PSCI CPU_SUSPEND halt the vCPU
  accel: Introduce AccelOpsClass::cpu_target_realize() hook
  accel/hvf: Add hvf_arch_cpu_realize() stubs
  target/arm: Create GTimers *after* features finalized / accel realized
  target/arm/hvf: Really set Generic Timer counter frequency
  target/arm: Only allow disabling NEON when using TCG
  target/arm/hvf: Do not abort in hvf_arm_get_*_ipa_bit_size()
  hw/arm/virt: Warn when HVF doesn't report IPA bit length
  accel/hvf: Introduce hvf_arch_cpu_synchronize_[pre/post]exec() hooks
  target/i386/hvf: Flush vCPU registers once before vcpu_exec() loop
  target/arm/hvf: Flush vCPU registers once before vcpu_exec() loop
  accel/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0
  target/arm: Better describe PMU depends on TCG or HVF
  target/arm/hvf: Emulate PMU registers
  target/arm/hvf: Emulate Monitor Debug registers
  target/arm/hvf: Emulate PhysTimer registers

Richard Henderson (9):
  accel/hvf: Create hvf_protect_clean_range, hvf_unprotect_dirty_range
  target/i386/hvf: Use hvf_unprotect_page
  target/i386/hvf: Use address_space_translate in ept_emulation_fault
  accel/hvf: Simplify hvf_log_*
  accel/hvf: Move hvf_log_sync to hvf_log_clear
  accel/hvf: Simplify hvf_set_phys_mem
  accel/hvf: Drop hvf_slot and hvf_find_overlap_slot
  accel/hvf: Remove mac_slots
  target/arm/hvf: Implement dirty page tracking

 include/accel/accel-cpu-ops.h |   1 +
 include/system/hvf_int.h      |  49 ++--
 target/arm/hvf_arm.h          |  11 +
 target/arm/internals.h        |   2 +-
 accel/accel-common.c          |   5 +
 accel/hvf/hvf-accel-ops.c     |  28 +-
 accel/hvf/hvf-all.c           | 185 ++++--------
 cpu-common.c                  |   3 +
 hw/arm/virt.c                 |   8 +-
 target/arm/cpu.c              |  71 ++---
 target/arm/cpu64.c            |   8 +-
 target/arm/helper.c           |   2 +-
 target/arm/hvf/hvf.c          | 498 +++++++++++++++++++------------
 target/arm/machine.c          |  10 +-
 target/arm/tcg/psci.c         |   3 +
 target/i386/hvf/hvf.c         | 537 ++++++++++++++++++----------------
 target/i386/hvf/x86hvf.c      |   4 +-
 accel/hvf/trace-events        |   1 +
 target/arm/hvf/trace-events   |   6 +-
 target/arm/trace-events       |   3 +
 trace-events                  |   2 +
 21 files changed, 762 insertions(+), 675 deletions(-)

-- 
2.51.0



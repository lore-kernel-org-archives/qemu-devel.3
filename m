Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685C4CCFA06
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFrWY-0002eB-Ld; Mon, 03 Nov 2025 05:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrWW-0002cu-GV
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:10:52 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrWP-0002GJ-6b
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:10:52 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-429b7eecf7cso2917302f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762164641; x=1762769441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Urpcv0ablg+rYF+W5nKV1ldmAraUQoP9Z9ALtwzow6U=;
 b=Edr8++GhevHNdpeXZTA4hW7J3TroLk7hGbe0FWYAfJIXFEo5ycWrOmXBIjB7hCmXTH
 gwy6XhN21wKyAAJSY6D0zAP3gsfex9QbSzxlGLtn3vH2QcLmVn72r+f+htZcSce3BtFn
 7zlAyrdPtYZL/xibMcMD+9zs5Fi0dd6vkG2/tJTTrcVpgX650zMEDdA57Qh390H6m+U4
 RPbn6KFiEJGjt1Vi8e3b/gHD4VEqPI86MdJCPJwvGhEg9wxXML8Na0ljSQ+sCYPuLtcc
 lYfbsw0R/8V1ti6WbFWHIDsd4IrzlrhkQvRE0R4ZY05IBKL5XnkaluIoyWgB9FtrVyGe
 B1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762164641; x=1762769441;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Urpcv0ablg+rYF+W5nKV1ldmAraUQoP9Z9ALtwzow6U=;
 b=mPTKkl4Yo3mUdagMorJ8Hm61xpAqOR5bEnNjy3fZx9no07rIgDd3Xni4EoJyHWii6i
 /h1HDe9RuQCL/JjFxMWENsjBcmwktemMYdD1CGvEGQVQ4Kmxe7hLNE1qk9nH74mqv4Z7
 sxGumPKff8VulgGmeRCZiCJ7Si1VERzc/uMSJ9rlw+MMp6zHVmrDgazy1ol70Jzsq6YA
 jYyBmIZy+xu/EJmMLIq6uUAqkxc3jZxOlbHdIPRc6uvYyea3ETC9xT/PyHjcVIWSmBlT
 Xdre8Mox3SsuJm5pGnHe/jwA6v4Z1vrL3A6A9xQ+FsHdhyGYHXq9V5U87PWW8ywXUzNu
 SFfA==
X-Gm-Message-State: AOJu0Yx5njBw/ES7qRbgndLWOHCm2PSdGK6yNpWEYOSDmNFvjWsxzQ5b
 X3WCkW6hPd0iXyIufZgxJZWhY1nxxibgAo1qBwooJ4R7KvpKoJHhBEogkdrc89N0kFAGlZ6K7xL
 kJThz9d4=
X-Gm-Gg: ASbGncvI5fxluuc+RsH23K68sSqi5kx+e90vyOA1AxWwIsiZXkJ1XVeZr5MDuBgqC/A
 KagwKh2tzbc+SgqmyN7EDN+NhBfQuPIUjkQxLToaIzXzl4C5+IZjx5R04BGy4GJzKrS6q8FcWZc
 7pLqUb/iinvxiaAR1mufbks7oMKw2aFOA3JXtAE+TM6i6ePHwG2Ne9hYrAoNgOUQfjZLKyT/D5w
 sBedWEIgf4XveRaza1eMjWr91EktXNg9SKzfSIIHUNhdu1p2bMDicu2zZBWJm5SNNJ/7Qv6xoVg
 3jRC7nTSvqHMnNCIw0TbTWmegM+KnjdUopXEJFR0Mgola2UGZqlJPpo6a+i0ixe/RzsXHdqsqSZ
 MXBDsMnPy4cg5Z6EeD69snHfaHO9aqK2Ds6Ik+v+/3JZNluZ6pbAFjEAerxGLdvywcysFXksT75
 MaeeezNio0Ja0C+AsJpCWSyHzsF77Oq782N+ybOpxcIkpnCO7akTSummfIxxI=
X-Google-Smtp-Source: AGHT+IGKEkTKCoCJ9oJb+VLUea79wAZFkYy4nc81NlVWi28j7TzCMWzPhn0V3CnDUhQP2FbZuZn/ZQ==
X-Received: by 2002:a05:6000:2892:b0:429:cf03:8b2e with SMTP id
 ffacd0b85a97d-429cf038dc0mr4040622f8f.13.1762164640790; 
 Mon, 03 Nov 2025 02:10:40 -0800 (PST)
Received: from localhost.localdomain (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c13eaee6sm19167457f8f.33.2025.11.03.02.10.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Nov 2025 02:10:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 00/23] target/arm/hvf: Consolidate
Date: Mon,  3 Nov 2025 11:10:09 +0100
Message-ID: <20251103101034.59039-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Missing review: 8, 13, 22, 23

- Patches 1-11 fix migration on HVF
- Patches 12-14 remove a signal race with WFI
- Patches 15-18 correct guest timer frequency
- Patches 20-23 add missing VTimer synchronization

Since v3:
- Call qemu_real_host_page_mask/size once (rth)

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

Philippe Mathieu-Daudé (14):
  target/i386/hvf: Use host page alignment in ept_emulation_fault()
  accel/hvf: Enforce host alignment in hv_vm_protect()
  accel/hvf: Skip WFI if CPU has work to do
  accel/hvf: Implement WFI without using pselect()
  accel/hvf: Have PSCI CPU_SUSPEND halt the vCPU
  accel: Introduce AccelOpsClass::cpu_target_realize() hook
  accel/hvf: Add hvf_arch_cpu_realize() stubs
  target/arm: Create GTimers *after* features finalized / accel realized
  target/arm/hvf: Really set Generic Timer counter frequency
  target/arm: Only allow disabling NEON when using TCG
  accel/hvf: Introduce hvf_arch_cpu_synchronize_[pre/post]exec() hooks
  target/i386/hvf: Flush vCPU registers once before vcpu_exec() loop
  target/arm/hvf: Flush vCPU registers once before vcpu_exec() loop
  accel/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0

Richard Henderson (9):
  accel/hvf: Create hvf_protect_clean_range, hvf_unprotect_dirty_range
  target/i386/hvf: Use hvf_unprotect_dirty_range
  target/i386/hvf: Use address_space_translate in ept_emulation_fault
  accel/hvf: Simplify hvf_log_*
  accel/hvf: Move hvf_log_sync to hvf_log_clear
  accel/hvf: Simplify hvf_set_phys_mem
  accel/hvf: Drop hvf_slot and hvf_find_overlap_slot
  accel/hvf: Remove mac_slots
  target/arm/hvf: Implement dirty page tracking

 include/accel/accel-cpu-ops.h |   1 +
 include/system/hvf_int.h      |  26 ++--
 accel/accel-common.c          |   5 +
 accel/hvf/hvf-accel-ops.c     |  21 +---
 accel/hvf/hvf-all.c           | 186 +++++++++--------------------
 target/arm/cpu.c              |  67 +++++------
 target/arm/hvf/hvf.c          | 217 ++++++++++++++++++++--------------
 target/i386/hvf/hvf.c         |  61 ++++++----
 accel/hvf/trace-events        |   1 +
 9 files changed, 274 insertions(+), 311 deletions(-)

-- 
2.51.0



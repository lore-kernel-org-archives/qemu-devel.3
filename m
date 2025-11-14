Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CF4CEACCB
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 20:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK08a-00089N-S2; Fri, 14 Nov 2025 15:11:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK022-0006YY-TK
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:04:32 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK01z-0004hu-Q1
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:04:30 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so20340215e9.1
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 12:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763150665; x=1763755465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pXiZ10OJodTsvzbmca5AhlTxbQq2G43OiTHEwt1NF6s=;
 b=zeiKb0V7fAoWhw+eOhOVbt70wgu/s6YbzORN6Nfn7muO6O+Vwbhm3K0tWayxVTa0zE
 AMa/xajm9wr+T1OUys6HL/ynGZjl2RO04dn3OAYYYRGjJhlZToFLSNrvzhUFt+SX0TE2
 e5BOZcgSk5m02sS9wpk7cvdgKzvcYdRYrRkWnyPVEXZ/rQK3AMB4MOj/ytLlkr/6PQBd
 NdWOqi2aJNf3sTKWV4cOu2L03HcBjOogQ3dot2P1E4vdslQXnIsn5pX1enKzpdecidZY
 wj/QMr3aOKCLOJHmyFShK/eCRTPN+Wl2awCMesY993gzpLunqXd8tUUrGS8qwGdko7JF
 SRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763150665; x=1763755465;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pXiZ10OJodTsvzbmca5AhlTxbQq2G43OiTHEwt1NF6s=;
 b=fUMRqVOKCYWBHB7VmkIcuHCSsXhPKqhjXXc6jv0IQACEQaLT4EXMIwunRClv+RU27p
 HlsL83QDoXAOUQesURH9oev+cmqMhrwFoS+0Ibj+1MJ+ttfqa/cTlSRv3Kz0aoJuXDg7
 TXyvojnnJxxmvcTepMEU/gD20feVe+r2+adcVsLvydmC4PqQsLSBcKbX9WXJZNeKXaWq
 +KHxg36sqHhw4RLNQ+47mYQPABcX+slFZpRLicdNKuyqx283CyQBY7lN+UQFMb18xPTN
 qJzqr0hMSPfXMtqmnMiWMt3XDOKrU4b30KNYhkGmf+i2N+aDifH2rSs/HoAUQ4oeET3V
 8kpQ==
X-Gm-Message-State: AOJu0YxJHxQgbmyMJ0+dA8STtmVP7r7pIjbm+46AREKvslGfFyafV0LA
 mami8mdvvW52gJfthGe6v168kLntO6ROlgvnUtLlIsMM2cPRTfN3PEuf1xmSJS8u29329m8vk/g
 a1FvWJ/XJkg==
X-Gm-Gg: ASbGnct8SNl6hLLb0rJ5djC9zY16jrN9WWy7OsRO8WFT1bIFApN41lOmIHdoxkIGGSF
 9n6zfPCqMTn70vKPrJLQm6ZhvjShfbBa7/DBxvWP2QIsuvXRlDkzDRqkglJezhq9SgznZt17qEP
 ngRIy87QRPFbnrYs/augsqGaIku89Q1EqA9xjGAMcqFKwzjATCkR/CQt82cP1JB4Fr2UGZgjbgL
 AcDGgmqXq1GD1byiEfT3FqnIdav128IgFkLgGPObsSbZXZSbvSEEPay8ZPY/5CPTA7CKC0GzxEP
 98yzqj3/KD0CncyuvGb3Qi4dqFxE6/lQVz2qLXjJP9e5KglhJUCp6QfXWjKpdv7LjGlENj/9WN0
 ONsk8A7ZMfcQ+pEME5DTdtEY1RMHW7vlh1DQXTx3ew/0EfzZ1XUFVOYYO0fr3wlITOr2NxAhuRx
 A0Hq5KQ4634JlAml21MYyGI31A9E6SriHwZc7EfMUAyCTDwjWN7w==
X-Google-Smtp-Source: AGHT+IGUBIHzsq1P8/uWuOSpYFIyXySXSD46MQNmE8TE0vBNydQbGCrTh8qC68xDOh+23jpV0ghqPg==
X-Received: by 2002:a05:600c:4685:b0:45d:d353:a491 with SMTP id
 5b1f17b1804b1-4778fe59fe7mr44230515e9.1.1763150664924; 
 Fri, 14 Nov 2025 12:04:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477983657cdsm711425e9.5.2025.11.14.12.04.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 14 Nov 2025 12:04:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v5 00/19] target/arm/hvf: Consolidate
Date: Fri, 14 Nov 2025 21:04:02 +0100
Message-ID: <20251114200422.4280-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Missing review: #8

- Patches 1-11 fix migration on HVF
- Patches 12-14 remove a signal race with WFI
- Patches 15-18 correct guest timer frequency

Since v4:
- Rename gva -> gpa in hvf_set_phys_mem (Akihiko)
- Dropped missing VTimer synchronization patches for 10.2

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

Philippe Mathieu-Daudé (10):
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
 include/system/hvf_int.h      |  22 +---
 accel/accel-common.c          |   5 +
 accel/hvf/hvf-accel-ops.c     |  19 +---
 accel/hvf/hvf-all.c           | 186 ++++++++++------------------------
 target/arm/cpu.c              |  67 ++++++------
 target/arm/hvf/hvf.c          | 167 +++++++++++++++---------------
 target/i386/hvf/hvf.c         |  44 ++++----
 accel/hvf/trace-events        |   1 +
 9 files changed, 208 insertions(+), 304 deletions(-)

-- 
2.51.0



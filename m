Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7915C36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txD0K-0001jU-K4; Tue, 25 Mar 2025 18:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txD0C-0001HU-Ij
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:08 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txD0A-00071u-Nt
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:08 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-227aaa82fafso70974725ad.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742942644; x=1743547444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8bZod9/Bef7a2/eA+KY9AsDnUbdrym7gbB5cW28VBS8=;
 b=V5qlPgp0lbQ9f5wFu0PC4H2qllbEZp+TBWObIQgf5UtKi+/lTZk8IDTDxEa0lMSSIF
 v0fEQ/85YPUSMN1WSX0M57x80LBfoQ/DoD6NV5vURcLQvVRdZsWhsiuTGTH7PxuCPc4V
 6UtkaJ1dmDpk8nBvUk0tjfmpie/At+nLs5SnGFlriXGk5iDHMQ+Tw27zr2wgDEyKfGkW
 OqLYq0CqvWownhkZjW/316n6CWxlDhlGCZfDxkmFKSgLVelWutwvpLEiuwq/aEMKEtwW
 2262o9cgiuGL6CozHph8dBlLU6EbYh7gls4B5yl0f0Wkwr6V3JqmRri5eZG1iIvUzKPa
 STyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742942644; x=1743547444;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8bZod9/Bef7a2/eA+KY9AsDnUbdrym7gbB5cW28VBS8=;
 b=u0ZY0H+S0DFYtSVJF5c1F2M4bve/QV1viAis6u1To+OeWkeKUhEiai12YIiRPffwOM
 AQGr7GL5DPFGahm/eJin0PJCmjS8n+OSHdg8zf7Rb7z4d3C2Q0dWlhT24bLcCgyj/S+K
 2THRt4slQibhf1CE3D9Ca6pm2LVll3I6d7yqTFMGYE85HAxAbJ1tp5OxYzCoMQXFiIlY
 AveinUss+KkD3mRz/78Y10/JYgu6kfYXo9/2CRECL3hEoENAe1lsdqiKfVLV+jL0SZbG
 hwsCW1/nkoSDNMJEoXSVubc9Vwo0Qh77PgYCfjr7vhlfQXrFb0FvnV1USgdd2absv9H0
 ZKmA==
X-Gm-Message-State: AOJu0Yw1nOBS/YE/Jcj1UitxF3Nm+b6uS3DMzN09fR03sUHIFrTHxP64
 NwyXQMYeTzmINcrlxwqrJgkLS/3tlBsqzHViQ3RfOIsQXRl0yCp3zK6zCpXHQ0Qgc+8NWOEK/11
 Z
X-Gm-Gg: ASbGnctk71yS+n5MCBKh1eMqca/35Oy2r9L3B/aNrMhrvlrTMbkjaoirKFIyDPo6oCj
 FewVibjoG92ltEbt9IjE5g6SfbvoOr8xPWVx/wHZRISt2fnZqT880hqruRJf7ieG8Bromx4AYZ6
 5BAD/8LnGsp9++uYWK5IL2OkrIcm+uQhTFMWAmrpse8/rEIH5/YV+4LDBIjdONAitfgtc8VqbHa
 fm8hgqsu1SNn0utg4tCCZ5YsxW4RmHncUQi5ONnAWEeP2F1P4ErSwtnaTPiit3CyZa1CjRASEGR
 jFNWgDGocxuz/HOEaYgr135G1HP1HMPBL+9nH1vL0SnCxnT7CNqUtG54I7T2zoqFFyP7J6DkYXd
 f
X-Google-Smtp-Source: AGHT+IHT+3+46UyHTQa4pLoQRIjEyAIMLSm3bJKHgJkyv9g3FhyckvZHCUYrbN/bWCeU9PnqaNLQ9Q==
X-Received: by 2002:a05:6a00:1826:b0:732:2484:e0ce with SMTP id
 d2e1a72fcca58-73905a139fbmr23583324b3a.17.1742942644528; 
 Tue, 25 Mar 2025 15:44:04 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390611d3d6sm11111321b3a.94.2025.03.25.15.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 15:44:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 00/11] target/avr: Increase page size
Date: Tue, 25 Mar 2025 15:43:52 -0700
Message-ID: <20250325224403.4011975-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

For single-binary, we would really like to have a common TARGET_PAGE_BITS_MIN.

AVR's use of TARGET_PAGE_BITS == 8 is unfortunately too small.  This was due
to having mmio in the first 256 or 512 bytes and RAM starting immediately
afterward -- the softmmu page table mapping really doesn't like mixed i/o
and sram on the same page.

For v2, my solution is to map the balance of the first page with a ram device
instead of normal ram.  This way, the entire first page is always i/o.
In addition, add some symbolic names for the cpu registers in i/o 0x38-0x3f.


r~


Richard Henderson (11):
  target/avr: Fix buffer read in avr_print_insn
  target/avr: Improve decode of LDS, STS
  hw/core/cpu: Use size_t for memory_rw_debug len argument
  target/avr: Remove OFFSET_CPU_REGISTERS
  target/avr: Remove NUMBER_OF_IO_REGISTERS
  target/avr: Add defines for i/o port registers
  target/avr: Move cpu register accesses into system memory
  target/avr: Use cpu_stb_mmuidx_ra in helper_fullwr
  target/avr: Use do_stb in avr_cpu_do_interrupt
  hw/avr: Prepare for TARGET_PAGE_SIZE > 256
  target/avr: Increase TARGET_PAGE_BITS to 10

 hw/avr/atmega.h           |   1 +
 include/hw/core/cpu.h     |   2 +-
 target/avr/cpu-param.h    |   8 +-
 target/avr/cpu.h          |  21 ++-
 target/avr/helper.h       |   3 -
 target/sparc/cpu.h        |   2 +-
 hw/avr/atmega.c           |  39 +++++-
 target/avr/cpu.c          |  16 +++
 target/avr/disas.c        |  21 ++-
 target/avr/helper.c       | 262 ++++++++++++++++----------------------
 target/avr/translate.c    |  44 ++++---
 target/sparc/mmu_helper.c |   2 +-
 target/avr/insn.decode    |   7 +-
 13 files changed, 222 insertions(+), 206 deletions(-)

-- 
2.43.0



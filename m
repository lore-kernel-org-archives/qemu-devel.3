Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96C8C021A0
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 03:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgy3n-0005oN-B7; Sat, 08 Feb 2025 22:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tgy3j-0005oB-Qw
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 22:32:39 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tgy3h-0001PH-RP
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 22:32:39 -0500
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-21f5268cf50so26635595ad.1
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 19:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739071956; x=1739676756;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QYsSeGIBQIN4Xd6KssoggAwwiUFz1a+HTSCoc/7tD/E=;
 b=YvVhYZ6me2AwKBJzaOol1zCxykF4I5T83t8oh3Lb2LFBpAQywLSVPTdNcOSMlvRLbj
 H8ZW/LXY5sSvlYZkMHgwrX0DzqVTuE2Fb77QzQk2mVkhCI9LHffLi58laN3U+P8TvtEr
 SpAlUD4uWZebvBxwd9G+Y20X/Cx+AWp1V5+83azvbOI5tn1JUP0U+ficPcrQqsxAWbW9
 ffz+Jr5YFTbpz0T3wSobTajGdNc0kJVvuPCBnTxM77wC1y8FlWwgzWLH554PWdJGxgNY
 XEGg2C2WStiqRLkR6ioTWIj3SpeGKJI/FrR4eeogcMgfdbv0LQ82SyQEmF027GaFHTt0
 xwcw==
X-Gm-Message-State: AOJu0YyF5DdhhSDAT+IdlP/iXsTlmnEF71rooJq4Q1F6EsGes54J10Pk
 5XwJ4bZCznDXAjjrFDcJq0VoiPATKG/lskhmJVxLy2/gmtDjFKrW4mHCFY+K
X-Gm-Gg: ASbGncuVPH3m9dxdcPJ1Xzer1SHndedYjeYUOTOB27qPwUTC2e6hH6cDKkq2vvpH0Kz
 EKoLM+ObX2B+qW9/dqLMGtwK9lUVPNkgp0D5r39Sf7t8ob20klpJNrpxEGoKFXGy6St3oLm9vOD
 tLfKaT96mUwyyaRf5c84Lz+EIsTK75saTgoWIkJAHNjgcm6KiGBI94Cnu7FOW0ar+QlgD+hCd+5
 mHe9Zz9TrWI/eY8koVjfEibYW1DOpFqc00qFKDS3ZtQ/7lBy8NVcV6fU5zZe8SiXbC/Mu1SGqg2
 2NaXQLQzAcF7pSmc16zneFDeiS6zIni6GOP1aNkOGWN1TS4=
X-Google-Smtp-Source: AGHT+IEJ6rLEy887D+j3WT+Gl234IYFbkoSYfCDqCkqxCJS3vkyoq9MkFZLu5amvmkCUYQtoeAK6eA==
X-Received: by 2002:a17:902:cf11:b0:216:4a06:e87a with SMTP id
 d9443c01a7336-21f4e744803mr159912765ad.40.1739071955879; 
 Sat, 08 Feb 2025 19:32:35 -0800 (PST)
Received: from localhost.localdomain
 ([2607:fb90:9e97:4903:dc10:4530:8a3f:fdb6])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad5453e2366sm1333610a12.47.2025.02.08.19.32.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Feb 2025 19:32:35 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 0/4] hvf: use TCG emulation to handle data aborts
Date: Sat,  8 Feb 2025 19:32:29 -0800
Message-ID: <20250209033233.53853-1-j@getutm.app>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.180; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f180.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.07, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When the VM exits with an data abort, we check the ISV field in the ESR and when
ISV=1, that means the processor has filled the remaining fields with information
needed to determine the access that caused the abort: address, access width, and
the register operand. However, only a limited set of instructions which can
cause a data abort is nice enough for the processor to decode this way. Many
instructions such as LDP/STP and SIMD can cause an data abort with ISV=0 and for
that the hypervisor needs to manually decode the instruction, find the operands,
and emulate the access.

QEMU already ships with the ability to do this: TCG. However, TCG currently
operates as a stand-alone accelerator. This patch set enables HVF to call into
TCG when needed in order to perform a memory access that caused the abort.

One thing this enables is the ability to use virtio-vga with Windows for ARM64.
Currently, graphics support for Windows is flakey because you must first boot
with ramfb to get to the desktop where you can then install the virtio-gpu
drivers and then start up with virtio-gpu. Even then, there is a known issue
where Windows mistakingly thinks there are two monitors connected because the
boot display does not share a framebuffer with the GPU. This results in
sometimes a black screen when updating Windows.

Another issue is that the TPM driver uses LDP/STP to access the command buffer
and so the QEMU device which maps registers as MMIO will not work.

There are a couple major issues with the patch as it currently stands. First of
all, it is very slow. Because we do not track writes to code pages, to be safe
we flush TLBs and TBs every time we switch to emulation mode. We also need to
synchronize the register states between HVF and QEMU each time we enter and
exit emulation mode. Since we enter/exit emulation mode for every instruction
that causes the data abort, in the case of the VGA buffer being cleared in a
loop, this means we need to enter-exit emulation mode to execute a single
instruction for every pixel. Second, we don't support plugins at all. Lastly,
some of the CPU state used by TCG is not properly synchronized with HVF and so
subtle issues can occur. We may want to constrain the emulator to only run with
a known allowlist of instructions we wish to handle in a data abort.

I think these issues can be worked around but I want to know if people think
this approach is worth doing or if instead we should pursue alternatives such
as a more basic instruction decoder which only supports a subset of instructions
which are interesting for memory accesses.

Joelle van Dyne (4):
  cpu-exec: support single-step without debug
  cpu-target: support emulation from non-TCG accels
  hvf: arm: emulate instruction when ISV=0
  hw/arm/virt: enable VGA

 include/exec/cpu-common.h |   1 +
 include/hw/core/cpu.h     |  11 +++++
 include/system/hvf_int.h  |   2 +-
 target/arm/hvf_arm.h      |   5 ++
 target/arm/internals.h    |   3 +-
 accel/hvf/hvf-accel-ops.c |   2 +-
 accel/tcg/cpu-exec.c      |  35 +++++++++----
 accel/tcg/plugin-gen.c    |   4 ++
 accel/tcg/tb-maint.c      |   2 +-
 accel/tcg/tcg-accel-ops.c |   3 +-
 cpu-target.c              |  20 +++++++-
 plugins/core.c            |  12 +++++
 system/physmem.c          |   7 +--
 target/arm/hvf/hvf.c      | 100 ++++++++++++++++++++++++++++++++++++--
 target/i386/hvf/hvf.c     |   2 +-
 hw/arm/Kconfig            |   1 +
 16 files changed, 186 insertions(+), 24 deletions(-)

-- 
2.41.0



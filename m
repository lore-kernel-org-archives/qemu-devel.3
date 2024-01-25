Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4383C47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT329-0007SN-8W; Thu, 25 Jan 2024 11:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rT328-0007QP-0X
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:56:56 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rT324-00016D-CL
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:56:55 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40ed4690ee4so3325065e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 08:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706201811; x=1706806611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZeCoqulJucVMeGZeJh3AVKZGYWy92cXRHx62XhZNVWU=;
 b=wVCcmnAOwfWfXH6eBwAsUiotEO/EGIr9e2A0WY/Nm1f9BTmd+PG7o9yG/8wKQd1Y1J
 fEqC7JUb5ULN//ZT6wxz1OOMU/KiSvqvpI2b02FVDR4Ku18CQUaVrtdbsD9aV4A9r+zR
 qpEiwKkU8lmxmPAM7mgW33A6a/1Avxt0vRDv5tEAcsGtio9nMjAPe8/OTsXoUjQ/HeSV
 Ay+czTYPBe1V2Lgh7Pjhf7P8t2htmzPiV9Kd+/A0eKC0qJ3dvgDb0phSV/juIExy0Dqh
 WUsf62uBGCIeNrLEGFahEieR519Jj013lHOXV0XH/kn48MhzrLiNvW8svwujgx5TV32K
 +klA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706201811; x=1706806611;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZeCoqulJucVMeGZeJh3AVKZGYWy92cXRHx62XhZNVWU=;
 b=rZspQ+UTIpoYtbi5cohICmNBjVMK8D+2fDrSzFAn2Fj/dg3VbPQBoxefimEjZZZ0LS
 v+0jfvv7wITlXzPpFKHrgBP87PGg5A9Q06Y1xDEn4KY7tMXtw0v5jjUVI16gyXBaJ21U
 YGYPYKU9jSGwsOrutsoxTW1SfmBIrKPhpQ4hdT3CUgKnJBUqOYUE/bRiIGNn4DLgvneu
 Nzvr6aG033ehjKReGlegwfdxpd1UtGoyonVFCYBvb0ISHBOReDo7NEZVGfsGcF95ltXI
 PO+9LZvrsAd7W9V0MPAfTZdjOhWRcxbwBzqqp1ehnAQGwyDl4jLJNyOj8kGhau2uuXxs
 HJhw==
X-Gm-Message-State: AOJu0Yy7zK3jq+BqS5jy2lxd19VcWMMcHCXvlpf7uSC41vB/rq5TfWA6
 xkAB++S3Fs++DQC+y+3ZEooqegjUISbOr+elnO4BzUuHBdpUm49bpqYtuvT1J9mQUarWwk//lXw
 u
X-Google-Smtp-Source: AGHT+IEs9JI5+dzE9sbGKyzM77EHCGgsKATVpuajnSB9J1jLbapjWSUtUh1PXEKFy8Ig0oTSYejbew==
X-Received: by 2002:a05:600c:214d:b0:40e:94f9:229e with SMTP id
 v13-20020a05600c214d00b0040e94f9229emr23954wml.68.1706201810691; 
 Thu, 25 Jan 2024 08:56:50 -0800 (PST)
Received: from m1x-phil.lan (lec62-h02-176-184-19-125.dsl.sta.abo.bbox.fr.
 [176.184.19.125]) by smtp.gmail.com with ESMTPSA id
 v17-20020a05600c471100b0040ec7fcaea6sm3174210wmo.37.2024.01.25.08.56.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Jan 2024 08:56:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] hw,
 target: Prefer fast cpu_env() over slower CPU QOM cast macro
Date: Thu, 25 Jan 2024 17:56:44 +0100
Message-ID: <20240125165648.49898-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Use cpu_env() -- which is fast path -- when possible.
Bulk conversion using Coccinelle spatch (script included).

Philippe Mathieu-Daudé (2):
  scripts/coccinelle: Add cpu_env.cocci_template script
  bulk: Prefer fast cpu_env() over slower CPU QOM cast macro

 MAINTAINERS                               |  1 +
 target/i386/hvf/vmx.h                     |  9 ++--
 hw/i386/vmmouse.c                         |  6 +--
 hw/i386/xen/xen-hvm.c                     |  3 +-
 hw/intc/arm_gicv3_cpuif_common.c          |  3 +-
 hw/ppc/mpc8544_guts.c                     |  3 +-
 hw/ppc/pnv.c                              |  3 +-
 hw/ppc/pnv_xscom.c                        |  3 +-
 hw/ppc/ppce500_spin.c                     |  3 +-
 hw/ppc/spapr.c                            |  3 +-
 hw/ppc/spapr_caps.c                       |  6 +--
 target/alpha/cpu.c                        | 21 +++-----
 target/alpha/gdbstub.c                    |  6 +--
 target/alpha/helper.c                     | 12 ++---
 target/alpha/mem_helper.c                 |  9 ++--
 target/arm/cpu.c                          | 15 ++----
 target/arm/debug_helper.c                 |  6 +--
 target/arm/gdbstub.c                      |  6 +--
 target/arm/gdbstub64.c                    |  6 +--
 target/arm/helper.c                       |  9 ++--
 target/arm/hvf/hvf.c                      | 12 ++---
 target/arm/kvm.c                          |  3 +-
 target/arm/ptw.c                          |  3 +-
 target/arm/tcg/cpu32.c                    |  3 +-
 target/avr/cpu.c                          | 21 +++-----
 target/avr/gdbstub.c                      |  6 +--
 target/avr/helper.c                       |  9 ++--
 target/cris/cpu.c                         |  3 +-
 target/cris/gdbstub.c                     |  9 ++--
 target/cris/helper.c                      | 12 ++---
 target/cris/translate.c                   |  3 +-
 target/hppa/cpu.c                         |  6 +--
 target/hppa/int_helper.c                  |  6 +--
 target/hppa/mem_helper.c                  |  3 +-
 target/i386/arch_memory_mapping.c         |  3 +-
 target/i386/cpu-dump.c                    |  3 +-
 target/i386/cpu.c                         | 36 +++++---------
 target/i386/helper.c                      | 30 ++++--------
 target/i386/hvf/hvf.c                     |  6 +--
 target/i386/hvf/x86.c                     |  3 +-
 target/i386/hvf/x86_emu.c                 |  6 +--
 target/i386/hvf/x86_task.c                | 10 ++--
 target/i386/hvf/x86hvf.c                  |  6 +--
 target/i386/kvm/kvm.c                     |  6 +--
 target/i386/kvm/xen-emu.c                 | 30 ++++--------
 target/i386/tcg/sysemu/bpt_helper.c       |  3 +-
 target/i386/tcg/tcg-cpu.c                 | 12 ++---
 target/i386/tcg/user/excp_helper.c        |  3 +-
 target/i386/tcg/user/seg_helper.c         |  3 +-
 target/m68k/cpu.c                         | 30 ++++--------
 target/m68k/gdbstub.c                     |  6 +--
 target/m68k/helper.c                      |  3 +-
 target/m68k/m68k-semi.c                   |  6 +--
 target/m68k/op_helper.c                   |  9 ++--
 target/m68k/translate.c                   |  3 +-
 target/microblaze/helper.c                |  3 +-
 target/microblaze/translate.c             |  3 +-
 target/mips/cpu.c                         |  9 ++--
 target/mips/gdbstub.c                     |  6 +--
 target/mips/kvm.c                         | 27 ++++------
 target/mips/sysemu/physaddr.c             |  3 +-
 target/mips/tcg/exception.c               |  3 +-
 target/mips/tcg/op_helper.c               |  3 +-
 target/mips/tcg/sysemu/special_helper.c   |  3 +-
 target/mips/tcg/sysemu/tlb_helper.c       |  6 +--
 target/mips/tcg/translate.c               |  3 +-
 target/nios2/cpu.c                        |  9 ++--
 target/nios2/helper.c                     |  3 +-
 target/nios2/nios2-semi.c                 |  6 +--
 target/openrisc/gdbstub.c                 |  3 +-
 target/openrisc/interrupt.c               |  6 +--
 target/openrisc/translate.c               |  3 +-
 target/ppc/cpu_init.c                     |  9 ++--
 target/ppc/excp_helper.c                  |  3 +-
 target/ppc/gdbstub.c                      | 12 ++---
 target/ppc/kvm.c                          |  6 +--
 target/ppc/ppc-qmp-cmds.c                 |  3 +-
 target/ppc/user_only_helper.c             |  3 +-
 target/riscv/arch_dump.c                  |  6 +--
 target/riscv/cpu.c                        | 15 ++----
 target/riscv/cpu_helper.c                 | 13 ++---
 target/riscv/debug.c                      |  9 ++--
 target/riscv/gdbstub.c                    |  6 +--
 target/riscv/kvm/kvm-cpu.c                |  6 +--
 target/riscv/tcg/tcg-cpu.c                |  9 ++--
 target/riscv/translate.c                  |  3 +-
 target/rx/gdbstub.c                       |  6 +--
 target/rx/helper.c                        |  6 +--
 target/rx/translate.c                     |  3 +-
 target/s390x/cpu-dump.c                   |  3 +-
 target/s390x/gdbstub.c                    |  6 +--
 target/s390x/helper.c                     |  3 +-
 target/s390x/kvm/kvm.c                    |  6 +--
 target/s390x/tcg/excp_helper.c            |  9 ++--
 target/s390x/tcg/translate.c              |  3 +-
 target/sh4/cpu.c                          | 15 ++----
 target/sh4/gdbstub.c                      |  6 +--
 target/sh4/helper.c                       |  9 ++--
 target/sh4/translate.c                    |  3 +-
 target/sparc/cpu.c                        | 12 ++---
 target/sparc/gdbstub.c                    |  3 +-
 target/sparc/int32_helper.c               |  3 +-
 target/sparc/int64_helper.c               |  3 +-
 target/sparc/ldst_helper.c                |  6 +--
 target/sparc/mmu_helper.c                 | 15 ++----
 target/sparc/translate.c                  |  3 +-
 target/tricore/cpu.c                      | 12 ++---
 target/tricore/gdbstub.c                  |  6 +--
 target/tricore/helper.c                   |  3 +-
 target/tricore/translate.c                |  3 +-
 target/xtensa/dbg_helper.c                |  3 +-
 target/xtensa/exc_helper.c                |  3 +-
 target/xtensa/gdbstub.c                   |  6 +--
 target/xtensa/helper.c                    |  9 ++--
 target/xtensa/translate.c                 |  3 +-
 scripts/coccinelle/cpu_env.cocci_template | 60 +++++++++++++++++++++++
 116 files changed, 334 insertions(+), 548 deletions(-)
 create mode 100644 scripts/coccinelle/cpu_env.cocci_template

-- 
2.41.0



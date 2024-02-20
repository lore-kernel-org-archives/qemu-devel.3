Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A94FC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLsB-000872-1A; Tue, 20 Feb 2024 03:53:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLs7-00086d-Pj
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:03 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLs5-000883-Fm
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:03 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-563b7b3e3ecso6295733a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708419179; x=1709023979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jlABJvEucbY1KeNVifASjWFei49F4VgqUTPNkIySpbE=;
 b=Oe9gV6QBFvue3q1CZFE0/uNcooqDzYlfj26lb0K4SkpNzsfPG0F1oR+bJbv0So2PO5
 KxWoxrdYxwuoVIzMT9mGnIGMdc9hcovdVt+iE3YhffT+TqEnfWm5JPivwYd+6vzdwQRS
 ue129Zb9wf9y9CMm9kyCXMicTlAQPD/y0sbleH53W2nxPnYYhP01ul4mIRFsZOoAEJNQ
 Wae0zKK0J2VPT5eKAfvzuAwJWttyyMpLcZt8DpDsvTQzfYH0uYvesrCY+TtSZStN/k5O
 BWw+MfmxzBtw8YruBbUIsX4THRBRk0JdmLHBrbPJlCQFaQbeHm278h0QT2DqLU4ZQBBx
 dyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708419179; x=1709023979;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jlABJvEucbY1KeNVifASjWFei49F4VgqUTPNkIySpbE=;
 b=BNBiiNjnq9kM+r+wrI4aE2MRchp3sK08hz+4lbWGoHRZLXxPvMMUqMmjgy5VbWHmIc
 C8jbat8p2DjzLDBN9CDJuIdhMFF6gmFQxDSAh7xmv9WS8SY6PfoDcunDqFK3N33mRvby
 vywsD/UZTSYgQ5PcFVpzOpYwXFtk4KwxYFdg4ePGHlbSbnbQjK7hMnX6XjHRXEtAVRPK
 meJw4cycgaxTJcSEg+8a4UO0bC8R++j4WNpGuoNcrTOk8KxNVR4iDhkfOjSVflUum3+f
 rtkNh674Gjtx5F8AuUqYmIGqC4drttj09mmje4C0SJ5WPVf55zFITEObXs0+zK6zwH7S
 zI8g==
X-Gm-Message-State: AOJu0YwXlKHBDrUd3xLcuBvGdDpnRwY45l0UXaj3EJIb6gPCIXzcAkyj
 CdgABsZMOKHYru2E6A7UlHctlc/Yw4JA4fHcmtO7wSnc0SlCFMbj7KVVAuum6TA=
X-Google-Smtp-Source: AGHT+IGqpnFauq/AX6zaGfBK2latLhd50JrdS1JcvXGK//hGusSzfFeSKfql7hmCvPWaEqUvMeCkyw==
X-Received: by 2002:a17:906:b288:b0:a3e:8f38:cdad with SMTP id
 q8-20020a170906b28800b00a3e8f38cdadmr3084920ejz.70.1708419179430; 
 Tue, 20 Feb 2024 00:52:59 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 cu3-20020a170906ba8300b00a3d014fa12esm3747876ejd.196.2024.02.20.00.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:52:59 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v1 00/21] Trivial tree wide typo fixes
Date: Tue, 20 Feb 2024 10:52:07 +0200
Message-Id: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x531.google.com
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

Correct typos automatically found with the `typos` tool
<https://crates.io/crates/typos>

Manos Pitsidianakis (21):
  docs: correct typos
  tests: correct typos
  Xen headers: correct typos
  accel/tcg: correct typos
  loongson3: correct typos
  ppc: correct typos
  sh4: correct typos
  include/exec/memory.h: correct typos
  include/exec/plugin-gen.h: correct typos
  hw/arm/omap.h: correct typos
  hw/cxl/cxl_device.h: correct typos
  hw/net/npcm_gmac.h: correct typos
  hw/riscv/virt.h: correct typos
  pc-bios/README: correct typos
  qapi/ui: correct typos
  qemu-options.hx: correct typos
  ci/gitlab-pipeline-status: correct typos
  hexagon: correct typos
  m68k: correct typos
  s390x: correct typos
  target/sparc: correct typos

 include/exec/memory.h                          | 2 +-
 include/exec/plugin-gen.h                      | 2 +-
 include/hw/arm/omap.h                          | 2 +-
 include/hw/cxl/cxl_device.h                    | 4 ++--
 include/hw/net/npcm_gmac.h                     | 4 ++--
 include/hw/ppc/ppc4xx.h                        | 2 +-
 include/hw/riscv/virt.h                        | 4 ++--
 include/hw/xen/interface/arch-x86/xen-x86_64.h | 2 +-
 include/hw/xen/interface/arch-x86/xen.h        | 2 +-
 include/hw/xen/interface/event_channel.h       | 2 +-
 include/hw/xen/interface/grant_table.h         | 2 +-
 include/hw/xen/interface/hvm/hvm_op.h          | 2 +-
 include/hw/xen/interface/io/blkif.h            | 4 ++--
 include/hw/xen/interface/io/fbif.h             | 2 +-
 include/hw/xen/interface/io/kbdif.h            | 2 +-
 include/hw/xen/interface/io/ring.h             | 2 +-
 include/hw/xen/interface/memory.h              | 2 +-
 include/hw/xen/interface/physdev.h             | 4 ++--
 include/hw/xen/interface/xen.h                 | 4 ++--
 accel/tcg/ldst_atomicity.c.inc                 | 2 +-
 docs/devel/ci-jobs.rst.inc                     | 2 +-
 docs/devel/docs.rst                            | 2 +-
 docs/devel/testing.rst                         | 2 +-
 docs/interop/prl-xml.txt                       | 2 +-
 docs/interop/vhost-user.rst                    | 2 +-
 docs/system/devices/canokey.rst                | 2 +-
 hw/mips/loongson3_bootp.h                      | 4 ++--
 hw/ppc/ppc405.h                                | 2 +-
 hw/sh4/sh7750_regs.h                           | 2 +-
 pc-bios/README                                 | 2 +-
 qapi/ui.json                                   | 4 ++--
 qemu-options.hx                                | 4 ++--
 scripts/ci/gitlab-pipeline-status              | 2 +-
 target/hexagon/idef-parser/macros.inc          | 2 +-
 target/m68k/cpu.h                              | 7 ++++---
 target/ppc/translate/vmx-impl.c.inc            | 2 +-
 target/s390x/cpu_features_def.h.inc            | 2 +-
 target/sparc/asi.h                             | 8 ++++----
 tests/avocado/acpi-bits/bits-tests/smbios.py2  | 2 +-
 tests/avocado/mem-addr-space-check.py          | 6 +++---
 tests/avocado/reverse_debugging.py             | 2 +-
 41 files changed, 58 insertions(+), 57 deletions(-)


base-commit: da96ad4a6a2ef26c83b15fa95e7fceef5147269c
-- 
γαῖα πυρί μιχθήτω



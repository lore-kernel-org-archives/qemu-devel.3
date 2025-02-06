Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C24C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 15:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg3YF-0000Vy-D1; Thu, 06 Feb 2025 10:12:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg3YC-0000VO-Du
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:12:20 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg3YA-00013R-Kh
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:12:20 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso6960925e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 07:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738854736; x=1739459536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8BCcjDzgfAxt2OulGFEyuQAEjlOOH5IMxSJKBAO33gc=;
 b=qQNmKbnGNL3fKEPhFtDxaki40eTxCt3Lz4Xgp7+r02rv9t/eMfdFTJ4gkC4g1WMNeR
 9x2kJrxI34SAwNeZAuiAWgA895D41unVJewr9KnzEqbkwAS7DyQJ6vihjFB1mrVHdV9e
 M7B+jKzDWsR0cmsqPTIJkRR7Afs9NEJLGHFPkPOlVspmIKm4p7Naaw4QBMJ7VyMBJ5X9
 JnGvbPxPe4Pw9yToYGW252AmhrW/1lZGEGDHfSQ8HDXibzmaAnAJ4XJReHZXvaIHdJia
 3+vJSZJzxYp1vvTjA7a05VkD9s3Zg81UdX/VmYmlWaLTH+gGxRCtP63jNfhhZkdUcImR
 l1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738854736; x=1739459536;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8BCcjDzgfAxt2OulGFEyuQAEjlOOH5IMxSJKBAO33gc=;
 b=EOtzSXF8B15J/x5eTjPM2R196rL20/m6k13vcSq7NU9ErSkee+b4Bv1/Udy2QS8fGB
 C60dF7bjT2Jv1WRJZTez4IlywqQ/pQ3SycBDcsI5KbYE47rAEiQRvtk3zAQbzGB1K8S1
 lY0+IRCPPfOWv2RL+CO8S72gQc5PVDwIjgAbB65lBQiZQcJQUAlPUPvOqNjT6exWN3qO
 HdecbWImhU1Ld2TK9p2HPB7iPWVhu07WnkDl/5Ms0BTeBwGz25jD+v1EmMljnnFd5d+b
 SGvZvQBH+QNMu+r1DO4DFnX8Dt1Owc0TW8csqtWV0TpkGGfiSLiFiiCn+vRF/5IguHKZ
 9CHw==
X-Gm-Message-State: AOJu0YxQovfKtU4wMIJo9wtKlzpl3ptEO4p2Sr00a2LXhN5C66Lxwlit
 7QPFX01eiLB6NWTfumol2KPI4E82dl4zUloLIGRdnN5/gtAzr7cnvIFJ8JhMzB1MRgq/ACgGoAI
 G
X-Gm-Gg: ASbGncsEjNaY28uwjJ6IKYWIjQKOmLXSkWSmLMUYA20TlA1+mkjACCkl1fTCobFeTSZ
 LsSajDJGWZg45tDaWchE9+UuiTT0/y7zLRpGhXrYoBbPJGAf4bAJtA+GURWLN3Pf9SP7ztKL7oe
 UxzY/8CPIIFJRIwWiZUKm9e3pKPx18XN9Iqsd+6d8KU0a+Ah97AKpLH6wpe7O7rslf1trVouvLH
 0egf0voRELu42qYl9xlVYGLedeZtws/XJ11ZUwSaU4JjVrZ4Cx6FCDMjmX/cc3TK8yS5NVMkaSC
 DnOZTXMm+wu4AZ99fF/oSQ==
X-Google-Smtp-Source: AGHT+IG+6GYuC7QClIYqw9QiiXtdSL2bKE/oWW0hgqmdb9VIWKFgZtRlVhXxfNixn8dmslBnq+VxJw==
X-Received: by 2002:a05:600c:45d2:b0:434:e2ea:fc94 with SMTP id
 5b1f17b1804b1-4390d4360cbmr75881445e9.11.1738854736384; 
 Thu, 06 Feb 2025 07:12:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391d5283b2sm23591535e9.0.2025.02.06.07.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 07:12:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jia Liu <proljc@gmail.com>
Subject: [PATCH 0/6] hw: Centralize handling,
 improve error messages for -machine dumpdtb
Date: Thu,  6 Feb 2025 15:12:08 +0000
Message-Id: <20250206151214.2947842-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

We originally implemented '-machine dumpdtb' in a fairly ad-hoc way:
every machine using FDT is supposed to call qemu_fdt_dumpdtb() once
it has finished creating and modifying the DTB; if the user passed in
the machine option then qemu_fdt_dumpdtb() will write the FDT to a
file and then exit QEMU.

Somewhat later we implemented the QMP and HMP dumpdtb commands; for
these to work we had to make all the FDT-using machines set
MachineState::fdt to point to the FDT blob.

This means we can clean up the handling of the -machine option, so we
can implement it in one place in machine.c.  The benefit of this is:
 * boards only need to do one thing, not two
 * we can have better error messages for the "user asked us to
   dump the DTB but this board doesn't have one" case

(In particular the bug report
https://gitlab.com/qemu-project/qemu/-/issues/2733
is essentially because we silently ignore the option if there
is no DTB to dump.)

The openrisc machines and the MIPS boston machine both were not
setting MachineState::fdt, so the HMP/QMP dumpdtb don't work for
those machines; the series starts by fixing those bugs.  Then we can
implement the centralized handling of the machine option.  Finally we
get to fix the "no error message" problem:

 $ qemu-system-aarch64 -M raspi4b,dumpdtb=/tmp/d.dtb
 qemu-system-aarch64: This machine doesn't have an FDT
 (Perhaps it doesn't support FDT at all, or perhaps you need to
 provide an FDT with the -fdt option?)

The fact that there are three places that report "this machine
doesn't have an FDT" is a bit of a wart, stemming largely from the
fact that the QMP dumpdtb command is only conditionally present if
CONFIG_FDT.  In theory we could make it unconditional, but I opted to
leave that can of worms for another day...

thanks
-- PMM

Peter Maydell (6):
  monitor/hmp-cmds.c: Clean up hmp_dumpdtb printf
  hw/openrisc: Support monitor dumpdtb command
  hw/mips/boston: Check for error return from boston_fdt_filter()
  hw/mips/boston: Support dumpdtb monitor commands
  hw: Centralize handling of -machine dumpdtb option
  hw/core/machine.c: Make -machine dumpdtb=file.dtb with no DTB an error

 include/hw/loader-fit.h      | 21 +++++++++++++++++---
 include/hw/openrisc/boot.h   |  3 ++-
 include/system/device_tree.h |  2 --
 hw/arm/boot.c                |  2 --
 hw/core/loader-fit.c         | 38 ++++++++++++++++++++----------------
 hw/core/machine.c            | 23 ++++++++++++++++++++++
 hw/loongarch/virt.c          |  1 -
 hw/mips/boston.c             | 16 ++++++++++-----
 hw/openrisc/boot.c           |  8 +++++---
 hw/openrisc/openrisc_sim.c   |  2 +-
 hw/openrisc/virt.c           |  2 +-
 hw/ppc/e500.c                |  1 -
 hw/ppc/pegasos2.c            |  1 -
 hw/ppc/pnv.c                 |  1 -
 hw/ppc/spapr.c               |  1 -
 hw/riscv/boot.c              |  2 --
 monitor/hmp-cmds.c           |  2 +-
 system/device_tree-stub.c    |  5 ++++-
 system/device_tree.c         | 22 ++++++---------------
 19 files changed, 93 insertions(+), 60 deletions(-)

-- 
2.34.1


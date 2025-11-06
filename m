Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5950DCCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 11:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGy2z-00057B-Rl; Thu, 06 Nov 2025 06:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vGy2w-000568-NF
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 06:20:55 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vGy2v-0002mC-2T
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 06:20:54 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-3c9c379af8aso604078fac.1
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 03:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762428051; x=1763032851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FVLPIkOhOr0kWfPAsqCVD844+MTUZuwpkrJrqoRh7xw=;
 b=cQlZaRDZ7vgCTnjcwT9YV14AvwhJoODfbUZeiUvHJSc36nyIIEl/AzvKvJYvLQZGtl
 3Ujl3zmblsViktU77dlPEK3YA9gMBKlnr/OBHEbXvoQKtA+kslDkh5CTldemCukru0uB
 0stk55KAaFrs1flB7JOVCVAz0x/VK3UgSxzynxbdmONaxVlCcAEn081BTgRQiiULoMl4
 HR4QnfIcRRA9IEbZRAocRq7FwABF99OHIfl8wdgIjCnjOAhA1azvqDlrEsp9rkOaOBgm
 A+bCDgva8f5/qn6l16ejAuSxdEBzoMyVmOubGZ2DgM/qksyBSnLO8pWAW6WwTJe1+e/K
 njqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762428051; x=1763032851;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FVLPIkOhOr0kWfPAsqCVD844+MTUZuwpkrJrqoRh7xw=;
 b=aQlVPLtuwjJyvzeIuSwGfbyyw697CQUGnzKFXrgjxAh2HLCWdmF4HdDLqQ6ZC9reWE
 jtBUWtcY532lyFrNJmZp+MUs8WH+V/15oe2mxM0BJNq6ZK1vsx1/Y/fnT3nMybPzQEry
 JZZXYAYjcnwyJL4ldkuQdzNLAjB5P0ol6xnwPIn4H/JsNVhga51+C79SwzYDvqhyn8jR
 yvimyhPkX1JXnDwVtB5wzZpIj05/j65UKMg8KmAdfOZHvQPGkQfrsb2h8AxbPmL8f1LA
 Td/1XmOF3bXnx+pZ37ZMcJPilzyZ3r70YQoLGtEX5K2Pktoe4QmpKLVjZT5cFcK8DpV5
 JCow==
X-Gm-Message-State: AOJu0YzXWFW4UeVjHROPQ9LPcgbSc9SXlVcvfb3uWa8q3VmO1mM9jCgY
 4FFzQ70YUPB69lWL8esHXZH1cTazcDj6q7aPmzeE4sjCJWsLLSsN6dIp+/AU7ASe+MQIzK0YoQJ
 m3upq9V0=
X-Gm-Gg: ASbGncsB/PDTrTjNg8DvEmhbQCxeczvEyPrJXnDyZjp8alU6D0YGGxispXNB/KbVaxC
 cvBKPJBB0+3Sy8Kp/EneCSCTMdRAUTQHjVaNVKuQM7uTDINgsQUZnTh6CDbMzz5ikKKirCZmTBU
 v/NDLp4HT79N+eS/cJKT6wGYc1FAPa8gXGHBM0R9KZFQpuSKyLgHThAdK+ul67HC5zhjwKG/YoA
 2evxi8VK0lQJmmQoMchw4U1/Pq0qbWD8WTe54jU60T7u8dFzo4ea2RL/kiqSgQoKOlsoh/e7mU/
 cugqW/+E9zsDXbrrMDP8aukDu6O4VecDg7TiqNkQ01QM/NJ+ZJDexLNDq2CExxj1KKrGlGtDIZ0
 Z+XxPT+5Ugqju81dXG9yMunu1JwlNHXAwqjyxrhlDmLxG7VuWYh3Kabfxt9I5Yc6b6fvU6FjXAi
 k3rDG5BbFxM0Qfo/FVBWZGCRzznh35ehPdRq0bIMTZ
X-Google-Smtp-Source: AGHT+IHteyb15fjdZx78BgqTRQ0Ph/o/HiNDAAPTSeNs+6I4rJHACE482L/pCOTiIi97EvkZHcRgFw==
X-Received: by 2002:a05:6871:408b:b0:3e1:2ec3:3a13 with SMTP id
 586e51a60fabf-3e2e2fbc08emr1550205fac.11.1762428050746; 
 Thu, 06 Nov 2025 03:20:50 -0800 (PST)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc2:7873:e847:e589:d030:667d])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e30a439b97sm932716fac.16.2025.11.06.03.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 03:20:49 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 0/2] riscv: riscv,isa fixes + check script
Date: Thu,  6 Nov 2025 08:20:42 -0300
Message-ID: <20251106112044.162617-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2d.google.com
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

Hi,

We have an array called isa_edata_arr[] in target/riscv/cpu.c which
needs to be always kept in the RISC-V specification riscv,isa order.
Easier said that done: as more and more extensions are added we're
failing to keep up with the array ordering in the review process.

I have considered changing how we're retrieving riscv,isa to not rely on
the array ordering (in fact I have code that does that). We would sort
the enabled extensions using riscv,is ordering during init time, before
writing it in the DT, ignoring the current isa_edata_arr ordering. When
all was said and done that sounded a bit extreme and I think there's
other stuff we can try first.

Patch 2 in this series is a python script I put together to, hopefully
help us identify if we're messing up the isa_edata_arr ordering and fix
it before pushing changes upstream. I used it to validate the changes I
did in patch 1 (the usual 'fix isa_edata_arr ordering' patch) and I can
tell that the script picked up *way* more ordering errors that I was
able to identify on my own. 

I didn't made any CI related changes w.r.t this new script but it is
something to consider - if changes in target/riscv/cpu.c are made, run
this script to validate the array again.

Patches based on alistair/riscv-to-apply.next.


Daniel Henrique Barboza (2):
  target/riscv/cpu.c: isa_edata_arr[] ordering fixes
  scripts: RISC-V python script to check isa_edata_arr[]

 scripts/riscv-isaedata-check.py | 164 ++++++++++++++++++++++++++++++++
 target/riscv/cpu.c              |  17 ++--
 2 files changed, 174 insertions(+), 7 deletions(-)
 create mode 100755 scripts/riscv-isaedata-check.py

-- 
2.51.1



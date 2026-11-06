Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C982D60A2607
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=univ-grenoble-alpes.fr header.i=@univ-grenoble-alpes.fr header.a=rsa-sha256 header.s=2020 header.b=Zrr5RxSH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPMeh-0007FT-Sn; Fri, 06 Nov 2026 11:19:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xPMeX-0007Dt-Rq; Fri, 06 Nov 2026 11:18:57 -0500
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xPMeV-0004Di-MA; Fri, 06 Nov 2026 11:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1793981931;
 bh=QxBrdvKzIIgdMiNL1E8tVT5VjQRr9ovEaCOim1wsUHw=;
 h=From:To:Cc:Subject:Date:From;
 b=Zrr5RxSHTbTG/hJnni073qM6Kv/Fc9VD2RAyWEVIUdeTaFBUr8HNv93y4RpUCRs/i
 ybBt9tnJcFOSrjrZP6cRVIYC03urOCBYQjna3qegd6rgpAKhyOQZH3M5eNAEBcWEq0
 hOPPFCxhP5dAZlkoObXOhhjHWg8bBUxmwAOfdhbXf73Tr9fwo5pp0OrW0mE9HiZB59
 4Tt4nrdn/6+hpDuybwabZfpHFD+uH/RsfDGFV1XWZSWiqQihjWMQN4t8VEVVXEgGMy
 Mllw6NUfF/hUsu9Rql4jyTEwOZLcp7Wnjc9x+RBg44m+6KUThGepehqpUaN5FOj+l6
 xlS7o+saHz5lw==
Received: from mailhub-1.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 7E66B4026F;
 Fri,  6 Nov 2026 17:18:51 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub-1.u-ga.fr (Postfix) with ESMTP id 7A6D9FF853;
 Fri,  6 Nov 2026 17:18:51 +0100 (CET)
Received: from naga.tima.u-ga.fr (naga.tima.u-ga.fr [147.171.132.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 0FB9040056;
 Fri, 06 Nov 2026 17:18:50 +0100 (CET)
From: frederic.petrot@univ-grenoble-alpes.fr
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, daniel.barboza@oss.qualcomm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH v3 0/4] target/riscv: Correct undefined behaviors in x-rv128
Date: Fri,  6 Nov 2026 17:18:39 +0100
Message-ID: <20261106161843.2075117-1-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (petrotf@univ-grenoble-alpes.fr)
 via submission-587 ACL (41)
Received-SPF: pass client-ip=152.77.200.56;
 envelope-from=frederic.petrot@univ-grenoble-alpes.fr;
 helo=zm-mta-out-3.u-ga.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>

Peter reported undefined behaviors in x-rv128 pmp configuration
registers accesses detected by the clang sanitizer.
This series introduces a 128-bit version of these accesses, and
corrects other out-of-bound shifts within the handling of interrupts
that were triggered afterwards.

Changes in v3:
- Extract the "interrupt" bitfield in the different versions of the
  cause register in a separate field of cpu.h and build the cause
  registers value on demand,
- Add these new fields into the machine migration state,
- Check that the pmp registers used in rv128 are only those allowed,
- Add tcg tests for mcause and scause accesses.

Changes in v2:
- I messed up and directly assigned a 0 to an Int128, so v2 corrects
  that.

Frédéric Pétrot (4):
  target/riscv: fix pmp sanitize error for x-rv128
  target/riscv: fix riscv_cpu_do_interrupt sanitize error for x-rv128
  target/riscv: Update machine state
  target/riscv: [ms]cause tcg tests for x-rv128

 target/riscv/cpu.c                    |   1 +
 target/riscv/cpu.h                    |   4 +
 target/riscv/machine.c                |   4 +
 target/riscv/tcg/cpu_helper.c         |  20 +++-
 target/riscv/tcg/csr.c                | 131 +++++++++++++++++++++-----
 target/riscv/tcg/csr.h                |   3 +
 target/riscv/tcg/pmp.c                |  38 ++++++++
 tests/tcg/riscv64/system/meson.build  |  14 +++
 tests/tcg/riscv64/test-rv128-mcause.S | 101 ++++++++++++++++++++
 tests/tcg/riscv64/test-rv128-scause.S |  94 ++++++++++++++++++
 10 files changed, 382 insertions(+), 28 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-rv128-mcause.S
 create mode 100644 tests/tcg/riscv64/test-rv128-scause.S

-- 
2.43.0



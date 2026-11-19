Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2482060A2614
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=univ-grenoble-alpes.fr header.i=@univ-grenoble-alpes.fr header.a=rsa-sha256 header.s=2020 header.b=hzMXQEws
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU5Rx-0001p5-3b; Thu, 19 Nov 2026 11:57:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xU5Ru-0001oE-2U; Thu, 19 Nov 2026 11:57:26 -0500
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xU5Rs-0002pb-0r; Thu, 19 Nov 2026 11:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1795107439;
 bh=fq2K0Uv22T54omN0+zxsNaylpVG0fozr5znb7Mv2oCs=;
 h=From:To:Cc:Subject:Date:From;
 b=hzMXQEwsx3DtvhBixjf71+rmWv9S0B9nLVmMgtA3hqnRG9GInM9QAASpKNlhOd95G
 wFTOUXheY0i5hVs2qEJNJ5+ucyj8u6G2kUCcKs9vwCKM3yogNNLToRf4Jqi3bARn7K
 rus14oboCHBxRcv6XuM5Mzosesi/kk+8jRf1Ji0AoXK2VNfWZKPZtB0XcIpGRqg764
 +bJI0pLJos7jU33wk+Cb6z/FABhvR7KkNFE6PYhsdTUMH79lErRugFLFo0Ny5T5ANZ
 l/LfPRah2dhojyRpiXYy1SKymnlFumBheUKUmMLHYjHzPu00X43PaO5It1fCgKLpR7
 OeYxjB2SFv25w==
Received: from mailhub-1.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id A55504029D;
 Thu, 19 Nov 2026 17:57:19 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [152.77.18.2])
 by mailhub-1.u-ga.fr (Postfix) with ESMTP id A1718FF853;
 Thu, 19 Nov 2026 17:57:19 +0100 (CET)
Received: from naga.tima.u-ga.fr (pers-185-75.vpn-inp.grenoble-inp.fr
 [147.171.185.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 2AC0514009A;
 Thu, 19 Nov 2026 17:57:19 +0100 (CET)
From: frederic.petrot@univ-grenoble-alpes.fr
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, peter.maydell@linaro.org,
 daniel.barboza@oss.qualcomm.com, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH v4 0/4] target/riscv: Correct undefined behaviors in x-rv128
Date: Thu, 19 Nov 2026 17:57:12 +0100
Message-ID: <20261119165716.130978-1-frederic.petrot@univ-grenoble-alpes.fr>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>

Peter reported undefined behaviors in x-rv128 pmp configuration
registers accesses detected by the clang sanitizer.
This series introduces a 128-bit version of these accesses, and
corrects other out-of-bound shifts within the handling of interrupts
that were triggered afterwards.

Changes in v4:
- Change version_id in machine states as we are adding new fields,
- Add Fixes: trailers in commits
Note that Sashiko AI reports a misuse of riscv_cpu_sxl in patch 2, 
while all calls are related to the use of scause (or vscause). 

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
 target/riscv/machine.c                |  12 ++-
 target/riscv/tcg/cpu_helper.c         |  20 ++++-
 target/riscv/tcg/csr.c                |  95 ++++++++++++++++++++----
 target/riscv/tcg/csr.h                |   3 +
 target/riscv/tcg/pmp.c                |  38 ++++++++++
 tests/tcg/riscv64/system/meson.build  |  14 ++++
 tests/tcg/riscv64/test-rv128-mcause.S | 101 ++++++++++++++++++++++++++
 tests/tcg/riscv64/test-rv128-scause.S |  94 ++++++++++++++++++++++++
 10 files changed, 362 insertions(+), 20 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-rv128-mcause.S
 create mode 100644 tests/tcg/riscv64/test-rv128-scause.S

-- 
2.43.0



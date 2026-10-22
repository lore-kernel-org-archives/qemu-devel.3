Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5908B606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=univ-grenoble-alpes.fr header.i=@univ-grenoble-alpes.fr header.a=rsa-sha256 header.s=2020 header.b=bPyhv4p1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJnbR-0003Un-Dg; Thu, 22 Oct 2026 03:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xJnbG-0003TA-55; Thu, 22 Oct 2026 03:52:34 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xJnbD-0003Cn-Ny; Thu, 22 Oct 2026 03:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1792655548;
 bh=Dkciry6et/ifW+uU+i2xvgHj2I0vUFOhC26z8mab1SA=;
 h=From:To:Cc:Subject:Date:From;
 b=bPyhv4p1CwyS5z0+BaaB+0ALqJr88El4B+Ur6N4M4TpnOw+C3iFwTsc3kCvVYMgPx
 67ZzEnPwCXqQ6PJ7Gj6/UVCeypFFG8+VdThhACceH0p+LHmUVMsD/Z/ItINAqsDKy9
 jCb7gu5b7RFMMiJs61SO3lsKvlvMUHgfZTB8MPHktx9KZApw6UOzB1chxezioVhBMG
 XdRhXTSyW0u8TMre2w+2kpPUJ3IiSvaQhkHLplS9RodB/4o21BeLTRST4zgeTA1bd+
 pU6h+BthR8iRBTDRHmQBDLzzn8TIm/bVG1ctplmpYPxOdDxE8bRrpoj5lr2bZuKMZI
 8cIXbH2YWKLEA==
Received: from mailhub-2.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 2F8E140274;
 Thu, 22 Oct 2026 09:52:28 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub-2.u-ga.fr (Postfix) with ESMTP id 2ACDAFF855;
 Thu, 22 Oct 2026 09:52:28 +0200 (CEST)
Received: from naga.home (88-170-236-106.subs.proxad.net [88.170.236.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 4A96B4004A;
 Thu, 22 Oct 2026 09:52:27 +0200 (CEST)
From: frederic.petrot@univ-grenoble-alpes.fr
To: peter.maydell@linaro.org, daniel.barboza@oss.qualcomm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH 0/2] Correct undefined behaviors in x-rv128
Date: Thu, 22 Oct 2026 09:52:16 +0200
Message-ID: <20261022075219.312757-1-frederic.petrot@univ-grenoble-alpes.fr>
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

Frédéric Pétrot (2):
  target/riscv: fix pmp sanitize error for x-rv128
  target/riscv: fix riscv_cpu_do_interrupt sanitize error for x-rv128

 target/riscv/cpu.h            |  2 ++
 target/riscv/tcg/cpu_helper.c | 14 ++++++--
 target/riscv/tcg/csr.c        | 66 ++++++++++++++++++++++++++---------
 target/riscv/tcg/csr.h        |  3 ++
 target/riscv/tcg/pmp.c        | 38 ++++++++++++++++++++
 5 files changed, 105 insertions(+), 18 deletions(-)

-- 
2.43.0



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51728606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=univ-grenoble-alpes.fr header.i=@univ-grenoble-alpes.fr header.a=rsa-sha256 header.s=2020 header.b=qomcqjYs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqrw-0000l9-4R; Thu, 22 Oct 2026 07:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xJqrp-0000kW-HX; Thu, 22 Oct 2026 07:21:53 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xJqrn-0004aI-Ig; Thu, 22 Oct 2026 07:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1792668108;
 bh=3WSRV9GM09bGa7BidJj+hQFzNTvZSOm4XKFBSQ6WOpI=;
 h=From:To:Cc:Subject:Date:From;
 b=qomcqjYsgVpTq/uJgSDDPqt54uh4Ls8cePT7uP/qYlDkCjJ/xbWZwW9xLvyiP5SY6
 MzHrpECgSOlfsoWlfDBEeK1G84mK9vTCA4G/KtAD4VJYB13gBxZt2p9Bkd5eVsIOVD
 paAlR/cU6yasTdysIcfWxBJ30kq3S/9Fpw5w8xZJS4Y05fvisBRH1ZsfRdMQ6/cdp+
 YUcCefeLuD9hIDAIm4JQVhodTKmha8auZRO/iTw+9T7t9HkVZmyK9bzTq3sZFZESB6
 L2MuwmguLabaSyfbmBPHv92mTllfqD7CWmOD9WuXmTx8UVD2KSDxxxJyQJWzziLTPZ
 H7WytEvTWCY8A==
Received: from mailhub-2.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 5469440221;
 Thu, 22 Oct 2026 13:21:48 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [152.77.18.2])
 by mailhub-2.u-ga.fr (Postfix) with ESMTP id 4FDE6FF855;
 Thu, 22 Oct 2026 13:21:48 +0200 (CEST)
Received: from naga.tima.u-ga.fr (naga.tima.u-ga.fr [147.171.132.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id C852E140049;
 Thu, 22 Oct 2026 13:21:47 +0200 (CEST)
From: frederic.petrot@univ-grenoble-alpes.fr
To: peter.maydell@linaro.org, daniel.barboza@oss.qualcomm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH v2 0/2] Correct undefined behaviors in x-rv128
Date: Thu, 22 Oct 2026 13:21:43 +0200
Message-ID: <20261022112145.356726-1-frederic.petrot@univ-grenoble-alpes.fr>
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

Changes in v2:
- I messed up and directly assigned a 0 to an Int128, so v2 corrects
  that

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



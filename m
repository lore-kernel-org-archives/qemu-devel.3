Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA5C606D805
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=univ-grenoble-alpes.fr header.i=@univ-grenoble-alpes.fr header.a=rsa-sha256 header.s=2020 header.b=G2n1ttxI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPMen-0007Lr-Em; Fri, 06 Nov 2026 11:19:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xPMeZ-0007EJ-AE; Fri, 06 Nov 2026 11:18:59 -0500
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1xPMeV-0004E4-LH; Fri, 06 Nov 2026 11:18:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1793981932;
 bh=70m9Os0id7lXuj2YS7O+SmI2K61D9n4d7lwY0rlz3cI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G2n1ttxI0s+YlsldjOf1Mg3wDAgkgurdLHmGyNhmqJ5aGxwxXnSdQD7Yyrz68c/Bp
 PNVXaI4qaGNIJSrWBVfAgaqRnobarR08GbG5+yXj/bmvL/wf0uFQzqRIuDismkvtXx
 5xwr53an8Xw58o7FKIkkJ4W2iSNUM5dUONNYFpCMv9wM7cLQj3U472GIjcaPXuSAa7
 OcS7o9x73g8rDhhFAClME4jcRy/heMaWCRkrvW+JKYlcTljb339cX6d+HX6Xr2YDjb
 OQlTq/IWFyCC1FQOn2z8Q3fBl4KOVGfREmSaf187UWlG1xKDtwaKMiMWb+1nHZnkiP
 J6i2FWUegdAqQ==
Received: from mailhub-2.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 370B84029D;
 Fri,  6 Nov 2026 17:18:52 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub-2.u-ga.fr (Postfix) with ESMTP id 3313BFF855;
 Fri,  6 Nov 2026 17:18:52 +0100 (CET)
Received: from naga.tima.u-ga.fr (naga.tima.u-ga.fr [147.171.132.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 0002240056;
 Fri, 06 Nov 2026 17:18:51 +0100 (CET)
From: frederic.petrot@univ-grenoble-alpes.fr
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, daniel.barboza@oss.qualcomm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH v3 3/4] target/riscv: Update machine state
Date: Fri,  6 Nov 2026 17:18:42 +0100
Message-ID: <20261106161843.2075117-4-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106161843.2075117-1-frederic.petrot@univ-grenoble-alpes.fr>
References: <20261106161843.2075117-1-frederic.petrot@univ-grenoble-alpes.fr>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>

Addition of the interrupt flags of the cause registers into
machine migration state.

Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
---
 target/riscv/machine.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 0de06e9588..080a983a19 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -114,6 +114,7 @@ static const VMStateDescription vmstate_hyper = {
         VMSTATE_UINT64(env.vsscratch, RISCVCPU),
         VMSTATE_UINT64(env.vsepc, RISCVCPU),
         VMSTATE_UINT64(env.vscause, RISCVCPU),
+        VMSTATE_UINT64(env.vscause_int, RISCVCPU),
         VMSTATE_UINT64(env.vstval, RISCVCPU),
         VMSTATE_UINT64(env.vsatp, RISCVCPU),
         VMSTATE_UINT16(env.vsiselect, RISCVCPU),
@@ -126,6 +127,7 @@ static const VMStateDescription vmstate_hyper = {
         VMSTATE_UINT64(env.sscratch_hs, RISCVCPU),
         VMSTATE_UINT64(env.sepc_hs, RISCVCPU),
         VMSTATE_UINT64(env.scause_hs, RISCVCPU),
+        VMSTATE_UINT64(env.scause_int_hs, RISCVCPU),
         VMSTATE_UINT64(env.stval_hs, RISCVCPU),
         VMSTATE_UINT64(env.satp_hs, RISCVCPU),
         VMSTATE_UINT64(env.mstatus_hs, RISCVCPU),
@@ -615,9 +617,11 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT64(env.stvec, RISCVCPU),
         VMSTATE_UINT64(env.sepc, RISCVCPU),
         VMSTATE_UINT64(env.scause, RISCVCPU),
+        VMSTATE_UINT64(env.scause_int, RISCVCPU),
         VMSTATE_UINT64(env.mtvec, RISCVCPU),
         VMSTATE_UINT64(env.mepc, RISCVCPU),
         VMSTATE_UINT64(env.mcause, RISCVCPU),
+        VMSTATE_UINT64(env.mcause_int, RISCVCPU),
         VMSTATE_UINT64(env.mtval, RISCVCPU),
         VMSTATE_UINT16(env.miselect, RISCVCPU),
         VMSTATE_UINT16(env.siselect, RISCVCPU),
-- 
2.43.0



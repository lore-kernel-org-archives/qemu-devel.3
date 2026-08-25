Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B98C61DB6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyo61-00031z-If; Tue, 25 Aug 2026 06:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wyo60-00031a-JB; Tue, 25 Aug 2026 06:09:32 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wyo5y-0002g1-OV; Tue, 25 Aug 2026 06:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1787652567;
 bh=J5B4/lNTroYD/nD4SiHMimb+gpYVo2Iss0+didhrzic=;
 h=From:To:Cc:Subject:Date:From;
 b=uhPlrXm/oWrWQ6LRA40y3veBL+NWOW1oYP15ZQsGMMan1rjeXlFl+Jtp1uYNRTzZw
 a4mPC5eH9Ous27NUkrzjqZjXeLp9AK6k8jD2S0oLZBIEl+UVWw/r3R9Fs5VgT5k7fh
 6DN1XH47rTT/+TpTiMf1UvJVGFfpdkl9Jg92+OUeVDhPE4mnwXct7CQlHNDvF5q65d
 hRq+7+qPh89rlq8Zx35J3DUPgRSPlirC12QzGvNDkEXhB7UYEA0GPQqnU/OqVribQh
 TDzmMwsX/JsmJw8RzFjhorXrzRkaZXxn/6BbyPcJzueRrIKGB/W0VnjjtigBRHQxlD
 LyV6hf6eC6Gvg==
Received: from mailhub-1.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id C482940245;
 Tue, 25 Aug 2026 12:09:27 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [152.77.18.2])
 by mailhub-1.u-ga.fr (Postfix) with ESMTP id C04E2FF85D;
 Tue, 25 Aug 2026 12:09:27 +0200 (CEST)
Received: from naga.. (pers-185-231.vpn-inp.grenoble-inp.fr [147.171.185.231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 3327E14004C;
 Tue, 25 Aug 2026 12:09:27 +0200 (CEST)
From: frederic.petrot@univ-grenoble-alpes.fr
To: daniel.barboza@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH v3 0/1] target/riscv: correct cbo and lq disassembly
Date: Tue, 25 Aug 2026 12:09:21 +0200
Message-ID: <20260825100922.387919-1-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.43.0
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>

The CBO instructions were, AFAIU, disassembled erroneously.
In addition, lq (load-quad, a RV128 instruction) shares the same
opcode space as the CBOs, which also led to incorrect dasm for that
instruction (understandable since RV128 is an experimental feature).
To avoid overlaps, we now require that lq is decoded only if
rd is not 0, as CBO requires the field corresponding to rd to be zero,
both in dasm and decodetree.

Changes in v3:
- rebase on master
- squash the 3 original patches, at they did not make sense
  anymore after rebasing

Frédéric Pétrot (1):
  disas/riscv.c: Correct dasm for cbo and lq

 disas/riscv.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.43.0



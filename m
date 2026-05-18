Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121E1CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 13:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOy26-0000eG-MD; Mon, 18 May 2026 09:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pm_bounces@pm.mtasv.net>)
 id 1wOxkS-0004ql-QN
 for qemu-devel@nongnu.org; Mon, 18 May 2026 09:11:14 -0400
Received: from mta220-ab1.mtasv.net ([50.31.205.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pm_bounces@pm.mtasv.net>)
 id 1wOxkM-0006qQ-26
 for qemu-devel@nongnu.org; Mon, 18 May 2026 09:11:05 -0400
X-KumoRef: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoicWVtdS1kZXZlbEBub25nbnUub3JnIn0=
DKIM-Signature: v=1; a=rsa-sha256; d=pm.mtasv.net; s=pm20250806;
 c=relaxed/relaxed; 
 bh=VeFHp6FKvmaH2pBv5/p25VIf65/VpOb+0qoRGNbvAyY=;
 h=from:to:subject:date:mime-version:content-type:sender:cc:date:message-id;
 t=1779109860; x=1779714660;
 b=iqBQlH3qAuNJqnaJ1vJ1S8nguUbwsoAoZbtUST+hVD4Jeo1ASehxNarHQV6Xi3ZctTQ9u0ALH
 kMxzqoJ9rOh37UQIc3lQngdm5Dskw6aOV3AxNcSUoAl2bvhssTtbwYQGHihmmX+lmsheDNNBBMa
 w0zohfk6LoIkvz7Q3tw6flZuPfmsSnhGD+piXnfa35CbzBm5xTIg91xNp7c066lRubjQcZ28AoZ
 tZ4amHq+ovInuN7nUBqn4iIJrn6qzevCihDPnCdIA6UWMXglUnZO4lryzrTszPGWwarwA7e5vSC
 2DVoPRFBH8M9m82lPecz9VgM3cFQKvOpnzNHAWGZ7MeQ==;
Received: from ip-172-26-31-179.us-east-2.compute.internal (172.26.31.179)
 by production-pmta-useast2.internal.postmarkapp.com (KumoMTA 10.97.242.151) 
 with ESMTP id 04096c4652bb11f193700292cb89fe79 for <qemu-devel@nongnu.org>;
 Mon, 18 May 2026 13:11:00 +0000
From: SignKirigami <prcups@krgm.moe>
Date: Mon, 18 May 2026 13:11:00 +0000
Subject: [PATCH 0/4] target/loongarch: add LVZ support for TCG
Message-Id: <75d2c4d9-aa2e-4660-9a47-1cf0f8a23f7b@mtasv.net>
To: qemu-devel@nongnu.org
Cc: SignKirigami <prcups@krgm.moe>, Bibo Mao <maobibo@loongson.cn>,
 xianglai li <lixianglai@loongson.cn>, Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.52.0
Feedback-ID: s9655927-_:s9655927:a251693:postmark
X-Complaints-To: abuse@postmarkapp.com
X-Job: 251693_9655927
X-PM-Message-Id: 75d2c4d9-aa2e-4660-9a47-1cf0f8a23f7b
X-PM-RCPT: |bTF8MjUxNjkzfDk2NTU5Mjd8cWVtdS1kZXZlbEBub25nbnUub3Jn|
X-PM-Message-Options: v1;
 1.4KqlDEvRmpl6Fe-aOcI5GA.-Okxl7-e35Wp8XDclql3SK_UgNO1Fw2eAET7IBNGaGeLuhsKL-r24vKKsYMfQRoVoGVekKI2VzTxsG3szNL6JWE0b9rBfME_jmilbV2eTYPbRpsp1MDB43yGDEEMI__B0qCuLJ6n6euQXLqTPhMwQXf80HWksb6Q0hGTmD8-E89UtzoMvHutwe-decmS9-Sr
X-virtual-MTA: mta220-ab1
X-PM-MTA-Pool: transactional-2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=50.31.205.220;
 envelope-from=pm_bounces@pm.mtasv.net; helo=mta220-ab1.mtasv.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 18 May 2026 09:29:19 -0400
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
Reply-To: prcups@krgm.moe
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch implements Loongson VirtualiZation (LVZ) extension support
for LoongArch's TCG target. With this patch, it is now possible to
start a nested KVM-accelerated virtual machine on a TCG-emulated virtual
machine.

Cc: Bibo Mao <maobibo@loongson.cn>
Cc: xianglai li <lixianglai@loongson.cn>
Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>

SignKirigami (4):
  target/loongarch: add LVZ CPU state and CSR metadata
  target/loongarch: add LVZ guest runtime support
  target/loongarch: translate LVZ CSR and trap instructions
  target/loongarch: virtualize guest TLB and address translation

 target/loongarch/cpu-csr.h                    |  42 ++
 target/loongarch/cpu-mmu.h                    |  37 +-
 target/loongarch/cpu.c                        | 132 ++++
 target/loongarch/cpu.h                        | 125 +++-
 target/loongarch/cpu_helper.c                 | 119 ++--
 target/loongarch/csr.c                        | 122 ++++
 target/loongarch/csr.h                        |   3 +
 target/loongarch/disas.c                      |  10 +
 target/loongarch/insns.decode                 |  17 +
 target/loongarch/internals.h                  |   8 +-
 target/loongarch/kvm/kvm.c                    |   1 +
 target/loongarch/machine.c                    | 249 ++++---
 target/loongarch/tcg/constant_timer.c         |  62 +-
 target/loongarch/tcg/csr_helper.c             | 127 +++-
 target/loongarch/tcg/helper.h                 |  30 +-
 .../tcg/insn_trans/trans_privileged.c.inc     | 353 +++++++++-
 target/loongarch/tcg/op_helper.c              |  83 ++-
 target/loongarch/tcg/tcg_cpu.c                | 182 +++--
 target/loongarch/tcg/tcg_loongarch.h          |   6 +-
 target/loongarch/tcg/tlb_helper.c             | 629 +++++++++++++-----
 target/loongarch/tcg/translate.c              |   6 +-
 target/loongarch/translate.h                  |   2 +
 22 files changed, 1909 insertions(+), 436 deletions(-)

--=20
2.52.0


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1909CD4F56
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 00:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP7vK-0003uc-Ui; Mon, 18 May 2026 20:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pm_bounces@pm.mtasv.net>)
 id 1wP7vI-0003uD-91
 for qemu-devel@nongnu.org; Mon, 18 May 2026 20:03:00 -0400
Received: from mta210a-ord.mtasv.net ([104.245.209.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pm_bounces@pm.mtasv.net>)
 id 1wP7vF-0002sg-Ms
 for qemu-devel@nongnu.org; Mon, 18 May 2026 20:02:59 -0400
X-KumoRef: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoicWVtdS1kZXZlbEBub25nbnUub3JnIn0=
DKIM-Signature: v=1; a=rsa-sha256; d=pm.mtasv.net; s=pm20250806;
 c=relaxed/relaxed; 
 bh=VeFHp6FKvmaH2pBv5/p25VIf65/VpOb+0qoRGNbvAyY=;
 h=from:to:subject:date:mime-version:content-type:sender:cc:date:message-id;
 t=1779148976; x=1779753776;
 b=FqlkeJScuBhTU6kt7/LFnmMPLUYgJLRZ6BtQQKdtI5NtMRKI/kicg6SUlMurzwIn+lYZRl2ST
 C9pS2CV2wvpJQJLy+AWrmf4GMfVWe9PPwwJrzmsfdK6BnDZU12PoIr5WstOZKNIiWSc4v5ovNII
 utVgQ7MePa34UVogQ0yiNgAq4evzkKTtWBY0aJQhTzjFGJjXOJZnT7AcpEKP8pFviMb1gfQm1E4
 z1iYDv1WkABZ4WqDn+GUI/xw9pSe6H/VuP2cXvPCcV7+MqUywpPfkxr6HIybKs4fiQ/qsZBFgZz
 TpdDNuRDx68jisPHcs5d5zjxh2txtKsYE08/h2Is+dPg==;
Received: from ip-172-26-21-11.us-east-2.compute.internal (172.26.21.11)
 by production-pmta-useast2.internal.postmarkapp.com (KumoMTA 10.97.240.249) 
 with ESMTP id 16f209e3531611f1992c029aa6c00279 for <qemu-devel@nongnu.org>;
 Tue, 19 May 2026 00:02:56 +0000
From: SignKirigami <prcups@krgm.moe>
Date: Tue, 19 May 2026 00:02:56 +0000
Subject: [PATCH 0/4] target/loongarch: add LVZ support for TCG
Message-Id: <28e575ca-c2bc-4ff5-b686-0459f743ec65@mtasv.net>
To: qemu-devel@nongnu.org
Cc: SignKirigami <prcups@krgm.moe>, Bibo Mao <maobibo@loongson.cn>,
 xianglai li <lixianglai@loongson.cn>, Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.52.0
Feedback-ID: s9655927-_:s9655927:a251693:postmark
X-Complaints-To: abuse@postmarkapp.com
X-Job: 251693_9655927
X-PM-Message-Id: 28e575ca-c2bc-4ff5-b686-0459f743ec65
X-PM-RCPT: |bTF8MjUxNjkzfDk2NTU5Mjd8cWVtdS1kZXZlbEBub25nbnUub3Jn|
X-PM-Message-Options: v1;
 1.3SM2p0lQzyFussJ4qnYt-g.ytOLMYT9GCjoMJEpVIO9y5_SPRy_0qKWVAkg8recux17dor26BIJe66uk834OHy0T5OEX60CtPGS99mpi89kXF6eJJ-ffBImm8h2c8KvywR3UDeRuRR_SRaKbIhwuC3KNbf4IuX71IVkwzPMAGgX0HsgXfL6d3cw_SeqBgyOzpqOIVWX4sot-jcPomjh46-V
X-virtual-MTA: ord-104-245-209-210
X-PM-MTA-Pool: transactional-2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=104.245.209.210;
 envelope-from=pm_bounces@pm.mtasv.net; helo=mta210a-ord.mtasv.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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


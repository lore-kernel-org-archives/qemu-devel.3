Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488D3606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJDV-0000YV-A8; Tue, 17 Nov 2026 08:27:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1xTJDT-0000Y8-Ng
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:27:19 -0500
Received: from atcsqr.andestech.com ([220.128.198.184])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1xTJDQ-0003tF-T0
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:27:19 -0500
Received: from mail.andestech.com (atcpcs53.andestech.com [10.0.1.153])
 by Atcsqr.andestech.com with ESMTPS id 6AHDQlwo073908
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 17 Nov 2026 21:26:47 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs53.andestech.com
 (10.0.1.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Tue, 17 Nov
 2026 21:26:47 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Nov
 2026 21:26:47 +0800
To: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
CC: <alistair.francis@wdc.com>, <liwei1518@gmail.com>,
 <daniel.barboza@oss.qualcomm.com>, <zhiwei_liu@linux.alibaba.com>,
 <chao.liu@processmission.com>, Alvin Chang <alvinga@andestech.com>
Subject: [PATCH v1 0/2] target/riscv: Write zero into mtinst/htinst for
 Zicfiss instructions
Date: Tue, 17 Nov 2026 21:26:36 +0800
Message-ID: <20261117132638.1452474-1-alvinga@andestech.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs53.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 6AHDQlwo073908
Received-SPF: pass client-ip=220.128.198.184;
 envelope-from=alvinga@andestech.com; helo=Atcsqr.andestech.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-to:  Alvin Chang <alvinga@andestech.com>
From:  Alvin Chang via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On any trap into M-mode or HS-mode, a zero, or a transformed instruction may be
written automatically into the appropriate trap instruction CSR, mtinst or
htinst. The privileged spec section "Transformed Instruction or
Pseudoinstruction for mtinst or htinst" lists the instructions that may
automatically write a value into mtinst/htinst CSR, and the section also says:
"If a synchronous trap occurs for a standard instruction for which no
transformation has been defined, the trap instruction register shall be written
with zero".

The instructions (SSAMOSWAP, SSPUSH and SSPOPCHK) defined in the Zicfiss
extension are not listed in that section of the privileged spec. Thus, the
mtinst/htinst shall be written with zero for these three instructions.

Alvin Chang (2):
  target/riscv: Write zero into mtinst/htinst for SSAMOSWAP faults
  target/riscv: Write zero into mtinst/htinst for SSPUSH/SSPOPCHK faults

 target/riscv/instmap.h        | 17 ++++++++++++++++-
 target/riscv/tcg/cpu_helper.c | 23 +++++++++++++++++++----
 2 files changed, 35 insertions(+), 5 deletions(-)


base-commit: e9fa1f66f0d47c74b6766e1b8b87ad7c2a9394d5
-- 
2.43.0



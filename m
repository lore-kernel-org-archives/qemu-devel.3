Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCFFC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 15:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnfje-0001Fw-VL; Thu, 27 Feb 2025 10:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saveliy.motov@syntacore.com>)
 id 1tnf6L-0001sB-Ad; Thu, 27 Feb 2025 09:43:01 -0500
Received: from m.syntacore.com ([178.249.69.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saveliy.motov@syntacore.com>)
 id 1tnf6J-0008Tb-Oo; Thu, 27 Feb 2025 09:43:01 -0500
Received: from pmg.syntacore.com (localhost.localdomain [127.0.0.1])
 by m.syntacore.com (Proxmox) with ESMTP id 49C66B41D0A;
 Thu, 27 Feb 2025 17:42:50 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:message-id:mime-version:reply-to:subject:subject
 :to:to; s=m; bh=lXcvzY6oM7PnHnSHGdN2RWdkDuNl+VbimIXamDB54rU=; b=
 r0yXkiS5jDDZKHiYaGXrWi3K2diiDBIBnBaUk/sc5pmYvo90woVc6eZX7HzUIRLu
 jNh/F8eeehH/JWabe5wf5y17xUrFvbYiNPsik7+4f68zeirDfGxjJJ5i43gQheEe
 Y2ow9jg2jhRDSmLt65FJW2xMaB1gR277p6A/Oj+PzvMGrVj1M9LctTjQ2Yj+0Xql
 3DKZXCVo6/YJpsIUW1Q2/ZzHvIAfZ89t5gvivV2qlmlREm8qlAps41EsjR3Mrfd+
 ZKi6FVWvqka/lf2pvms2Z1WTnzamMiMmYVeLj3SfOkIVXO/ejNY2S6Kw814EePdI
 Jt5ZnmtT8hm7ineDHGz/6A==
Received: from S-SC-EXCH-01.corp.syntacore.com (mail.syntacore.com
 [10.76.202.20])
 by m.syntacore.com (Proxmox) with ESMTPS id 32EE0B41D05;
 Thu, 27 Feb 2025 17:42:50 +0300 (MSK)
Received: from le14u.yadro.com (172.17.5.46) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Feb 2025 17:41:40 +0300
From: Saveliy Motov <saveliy.motov@syntacore.com>
To: <palmer@dabbelt.com>
CC: <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>,
 <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>, Saveliy Motov
 <saveliy.motov@syntacore.com>
Subject: [PATCH 0/2] riscv: Fix Zkr bugs
Date: Thu, 27 Feb 2025 17:41:58 +0300
Message-ID: <20250227144200.69270-1-saveliy.motov@syntacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.5.46]
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
Received-SPF: pass client-ip=178.249.69.228;
 envelope-from=saveliy.motov@syntacore.com; helo=m.syntacore.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 27 Feb 2025 10:23:37 -0500
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

This series fixes Zkr extension bugs.
- Fix Zkr CSR first reading
- Fix Zkr higher bits in riscv64 machine


Saveliy Motov (2):
  target/riscv/csr.c: Fix first Zkr CSR reading
  target/riscv/cpu_bits.h: Fix [63:32] bits in Zkr seed csr

 target/riscv/cpu.c      |  3 +++
 target/riscv/cpu.h      |  4 ++++
 target/riscv/cpu_bits.h | 10 +++++-----
 target/riscv/csr.c      |  7 ++++++-
 4 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.34.1




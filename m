Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA64CF31A1
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 08:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svuzF-0000sW-VW; Wed, 02 Oct 2024 04:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <evgenii.prokopiev@syntacore.com>)
 id 1svuzB-0000np-7W; Wed, 02 Oct 2024 04:45:29 -0400
Received: from mta-03.yadro.com ([89.207.88.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <evgenii.prokopiev@syntacore.com>)
 id 1svuz8-0006VT-Rr; Wed, 02 Oct 2024 04:45:28 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 820F0E0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1727858720;
 bh=YWgp+nUhRuaUeTwcZgW6/CrX71g4ZWUTBkPmFsdMynw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=QXpi7L0TcC1uYJCZYcZwvfJSeLapKzg99981wVcFutFw1U/CVPi2szQoh6WJ3Cs+N
 2jyreiYwrtt9pNyFwb0tFHgLz9aA0gP6MPnNcAcdCG6/oTMjseDnBDCHJkjyfsl+4A
 2arATOWEq4qiY6LQMMKtM0t//gyIql2qaXswyZdmBggdJ91KR3ZyBpfbQLxjdHDLNC
 xgDUdIJ0wrJQYwomaE5bnyOZEocZLYmrz2SOc4DHIEhc2PMqGxRHxhx1OpLcBtHNez
 WYZauhpaj6vI2uLdlx/ox0KN/Fo+yyk8feM71pVgDwBEeOR7I431QfB4leiKG8CqHj
 tC2chnO5kIzmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1727858720;
 bh=YWgp+nUhRuaUeTwcZgW6/CrX71g4ZWUTBkPmFsdMynw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=GHWVYnE2hikWZkvLULnz3ELdeqhCUlaxkK65K9CQqO79084Ps194NMn5sDNQJTq8d
 se9HEl6q1XQpgiOnuB7A8TCJY0ilqGpcoXvsImIPihqeB0m6yJ9E2ZdVae32USR4RG
 TNPlTGt+UNEsJqtf/k/3SDig4LTCzaZDGJyH8oVKV7JH9lcH+PbLvcjYILToLLNr8f
 EhFpPM6dCzS2YvGGr9gmb2WC7lQk7QrM164Yh+dJxqEcVnMe+t4+7/iskfAVSw0sy1
 6DoGMoOUDZBZDNUt5hxg77Jxty1Em0uxXDufzljCHwhHHHkHDWl3acvA6wYHkdEzQI
 7dpB0rT0fF4VQ==
From: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>
To: <alistair23@gmail.com>
CC: <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>,
 <dbarboza@ventanamicro.com>, <evgenii.prokopiev@syntacore.com>,
 <liwei1518@gmail.com>, <palmer@dabbelt.com>, <qemu-devel@nongnu.org>,
 <qemu-riscv@nongnu.org>, <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v3] target/riscv/csr.c: Fix an access to VXSAT
Date: Wed, 2 Oct 2024 11:44:36 +0300
Message-ID: <20241002084436.89347-1-evgenii.prokopiev@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAKmqyKMmYPG0_jyrJFxvnxhTGTCAz4L5Lf6FouZpy3ZtywNiGA@mail.gmail.com>
References: <CAKmqyKMmYPG0_jyrJFxvnxhTGTCAz4L5Lf6FouZpy3ZtywNiGA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.253;
 envelope-from=evgenii.prokopiev@syntacore.com; helo=mta-03.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

The register VXSAT should be RW only to the first bit.
The remaining bits should be 0.

The RISC-V Instruction Set Manual Volume I: Unprivileged Architecture

The vxsat CSR has a single read-write least-significant bit (vxsat[0])
that indicates if a fixed-point instruction has had to saturate an output
value to fit into a destination format. Bits vxsat[XLEN-1:1]
should be written as zeros.

Signed-off-by: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
Changes since v2:
    - Added reviewed-by tag
 target/riscv/csr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index bd080f92b5..69c41212e9 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -717,7 +717,7 @@ static RISCVException write_vxrm(CPURISCVState *env, int csrno,
 static RISCVException read_vxsat(CPURISCVState *env, int csrno,
                                  target_ulong *val)
 {
-    *val = env->vxsat;
+    *val = env->vxsat & BIT(0);
     return RISCV_EXCP_NONE;
 }
 
@@ -727,7 +727,7 @@ static RISCVException write_vxsat(CPURISCVState *env, int csrno,
 #if !defined(CONFIG_USER_ONLY)
     env->mstatus |= MSTATUS_VS;
 #endif
-    env->vxsat = val;
+    env->vxsat = val & BIT(0);
     return RISCV_EXCP_NONE;
 }
 
-- 
2.34.1



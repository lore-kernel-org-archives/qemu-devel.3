Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B478CF9C6F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 14:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stSYN-00039P-55; Wed, 25 Sep 2024 09:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <evgenii.prokopiev@syntacore.com>)
 id 1stORe-000602-BI; Wed, 25 Sep 2024 05:36:26 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <evgenii.prokopiev@syntacore.com>)
 id 1stORZ-0008AE-HS; Wed, 25 Sep 2024 05:36:26 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com C936DC0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1727256969;
 bh=z/sx2kxPVDkp5x2w+RFTNagjW1kQB8TFAPd4Lz+i6vk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=L8LyRf2Xk1ZqCgT5NKprAMkdNXxbEpRKAihlU4cRQ23vmjGKcJU1nmU9wIltK52h1
 DRWU3A/atd6Z51x7g7c4wwY7z2+oHYJUqe+hsjgUKunko8gdBR7AIiL6ounl5LFgZF
 mgqQx5Mm3MrtoR3nnaMJq6g7Xe9cOyAZ1W5+eUpmdMWaBIgr52vuEucnY0jOM+FlIC
 WcMZhVQ/o5fpIS0y3ZwtDon4zQgWknBcmoXwl+Ptz28wFb8Cey42c57W8KoeiyZwsY
 bRQvnzPdnAav9O+HDlSIItbU0TVDF2yDBMzTYPKvSyTK8G7C95joSjmlUFATdNTuEX
 K2CXxPdfSjilA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1727256969;
 bh=z/sx2kxPVDkp5x2w+RFTNagjW1kQB8TFAPd4Lz+i6vk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=xGI70o6Yub1hf727+OC9diTEKTQ7u7SqAsZd/BEQZQ1IQqOz0z2XbthwdSe9k25LF
 YDRskqjmT7scfYVLLoeePzb9A0EaYvpjIwWiSKFIOJ2fo7dePd5cbp6hTF6zgwzumk
 RM7c7aDO3JZpLP1vbwyFkrHqX623lws0PHfbSsTommlLlWOK+q4UzoLlv+4qLXbX/D
 UM5YNOShIF/EIjy++b1qUJV/gpMg5PMA30+l/BqtR2bDyGbX7OzhhIY1jTmHjb07Cq
 u7uszjwQuAJhMrajuJaLNIGHcZVSjFbRKOx1ts+vssRAW7eAVN8cM8BCJjOycRTGnZ
 +5fBVsCdsertg==
From: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>
To: <palmer@dabbelt.com>
CC: <evgenii.prokopiev@syntacore.com>, <alistair.francis@wdc.com>,
 <bmeng.cn@gmail.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: [PATCH] target/riscv/csr.c: Fix an access to VXSAT
Date: Wed, 25 Sep 2024 12:35:31 +0300
Message-ID: <20240925093531.382347-1-evgenii.prokopiev@syntacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-06.corp.yadro.com (172.17.10.110) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=evgenii.prokopiev@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 25 Sep 2024 09:59:35 -0400
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
---
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



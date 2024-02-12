Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33700C4829C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 17:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZZsH-0006j3-5I; Mon, 12 Feb 2024 12:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irina.ryapolova@syntacore.com>)
 id 1rZZsD-0006gk-L5; Mon, 12 Feb 2024 12:13:41 -0500
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irina.ryapolova@syntacore.com>)
 id 1rZZsA-0004gs-Sh; Mon, 12 Feb 2024 12:13:41 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 3C9EFC0005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1707758017;
 bh=s/XN3CO0iJeMqY5zI5HVlTnKgwEGUPwXTodK87ckfDQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=L8Qt2Tm371evm6pyjYyMsuYmzcfKBMKSCJjppDpWms/5SgQuNFVv/LGe/7XlsAhUa
 62dROXh8zFMocp17BcYuLOWyzFFJL1JqKmJnCqt3NJF+jv/kBrHLVO+fJUJ5z3qGpy
 He6AVa43R/0/Ad0qMcNzNzGL1hNnaeTLfyIkHPHlxCVH5szwKL5Wu7orYHVmf7ySDN
 +jJO7+kpjmKv4x+s28xj3bxQe8SbV4Eyy4+qE7GAtc19yAFU3nDEpmhUk3bwwbyg1X
 vCaTFT1PvkIoRBkRcYgvy07CnvWc6qWkIEfyujSlraqeVajwMUTDvWRm88VE3YAoEl
 c1CV7NozwrD4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1707758017;
 bh=s/XN3CO0iJeMqY5zI5HVlTnKgwEGUPwXTodK87ckfDQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=pYqTPwsvUHqFXrNjgZP+sNOo53/WGZgq5axCR3yeHMRU5DfvRCRUzUNLsUu5efoDY
 Bwd1uc4/SPT003hRakU9Xb9aUO2y3XQa20psfNWRu7+ppBjv8OZ1I5ONC+5Pb+9nrH
 uUqzQrY9CWwg50uJxCIQCWjheNQTDYL7Ul62qONLafLuZtAi8zMtWgsgZJY5GdQ26s
 rW6nbaCUf9qXnIUhd1+WadhnIXcBBhJ+HUp2T9ltwJnuq3C6W39GaJ4P1l394QIYFn
 +o9Yti/E12AgJehCY3Lxh2gpAmiUhBB8C5ssK+kvk4WVMTJl7jhlFLOb0n/oifGryf
 Ga2yBzlVJe32Q==
From: Irina Ryapolova <irina.ryapolova@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bin.meng@windriver.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, Irina Ryapolova
 <irina.ryapolova@syntacore.com>
Subject: [PATCH 1/2] target/riscv/csr.c: Add functional of hvictl CSR
Date: Mon, 12 Feb 2024 20:13:19 +0300
Message-ID: <20240212171320.47361-1-irina.ryapolova@syntacore.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=irina.ryapolova@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

CSR hvictl (Hypervisor Virtual Interrupt Control) provides further flexibility
for injecting interrupts into VS level in situations not fully supported by the
facilities described thus far, but only with more active involvement of the hypervisor.
(See riscv-interrupts-1.0: Interrupts at VS level)

Signed-off-by: Irina Ryapolova <irina.ryapolova@syntacore.com>
---
 target/riscv/csr.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 674ea075a4..0c21145eaf 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3585,6 +3585,21 @@ static int read_hvictl(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_hvictl(CPURISCVState *env, int csrno, target_ulong val)
 {
     env->hvictl = val & HVICTL_VALID_MASK;
+    if (env->hvictl & HVICTL_VTI)
+    {
+        uint32_t hviid = get_field(env->hvictl, HVICTL_IID);
+        uint32_t hviprio = get_field(env->hvictl, HVICTL_IPRIO);
+        /* the pair IID = 9, IPRIO = 0 generally to represent no interrupt in hvictl. */
+        if (!(hviid == IRQ_S_EXT && hviprio == 0)) {
+            uint64_t new_val = BIT(hviid) ;
+             if (new_val & S_MODE_INTERRUPTS) {
+                rmw_hvip64(env, csrno, NULL, new_val << 1, new_val << 1);
+            } else if (new_val & LOCAL_INTERRUPTS) {
+                rmw_hvip64(env, csrno, NULL, new_val, new_val);
+            }
+        }
+    }
+    
     return RISCV_EXCP_NONE;
 }
 
-- 
2.25.1



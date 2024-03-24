Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07789C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 15:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roPUe-000350-QM; Sun, 24 Mar 2024 11:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irina.ryapolova@syntacore.com>)
 id 1roPUT-00031L-9N; Sun, 24 Mar 2024 11:10:29 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irina.ryapolova@syntacore.com>)
 id 1roPUD-0003uo-BF; Sun, 24 Mar 2024 11:10:28 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com CEF8CC0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1711293008;
 bh=CAjZspP8C5v+WwgLeVybd6oIM+r5EjOuZQnBIrurUS8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=L1YJmejiN0xLrJ3ldIycK4EJVRhEH/FX6LhBKVvDQt+rJ4/N+rX/gMDFZghXe/4ru
 WTU1owi2GkQzRiwk0tdn1ZHJw9VbpRSEzHSp3eyXLjpYGNvELR2UDBc1i5xqrcfS3K
 uUeqhOn3QLAA0nCJV3BBrNQ6EynJgfhCQzyLlG51ewU6ihkLBjMDLvn2JJM0OQIddQ
 LqwHwuL6MY42uxezxXd8zZv3/Y/xp/AVVFoCrjA1grUpdRCcLcvE31aRbJ5iC9iz1L
 4QqpIyL+QRnwA7gnUzuvaLz5q65OulVutMBDUC2xqHImzHEdBihVb8wkaL5/3dvKdC
 dg01g8TuIkJcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1711293008;
 bh=CAjZspP8C5v+WwgLeVybd6oIM+r5EjOuZQnBIrurUS8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=PZE/vLsitk0hI4p9SE2/H76uXPvol7GezcPuXEDrUuR1ZypcjNqYFBAjdv2mesBpj
 L9WGYfo6NgD5q1NM6xp5kwgRix8DgNAQB3CTV7+8NLR4dsColQ1qMc/CX9lMTDKpJn
 pm6tcucahAAOZgjiYVDjjGJ7zT1R0jH5S8kJhnZwhLPXsT/79L5r2tPGj7aHi0e/qN
 gqYG4AOveS+YdqxuTQSv/4Jlm39/anrs5ZfR5bndLOzpQwFoFcTMjnxx2IFpRKPPjq
 uwkmshoq2RS4a2NDVgIBFpFjWXTpHUgwxLug6AYfzy9BFfItz4AJEYfL0WM/94+5S1
 uWsmUi05LrLBQ==
From: Irina Ryapolova <irina.ryapolova@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bin.meng@windriver.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, Irina Ryapolova
 <irina.ryapolova@syntacore.com>
Subject: [PATCH v3 1/2] target/riscv/csr.c: Add functional of hvictl CSR
Date: Sun, 24 Mar 2024 18:09:48 +0300
Message-ID: <20240324150949.20822-2-irina.ryapolova@syntacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240324150949.20822-1-irina.ryapolova@syntacore.com>
References: <20240324150949.20822-1-irina.ryapolova@syntacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: T-EXCH-08.corp.yadro.com (172.17.11.58) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=irina.ryapolova@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

A hypervisor must use hvictl for any of the following:
• asserting for VS level a major interrupt not supported by hvien and hvip;
• implementing configurability of priorities at VS level for major interrupts beyond those sup-
ported by hviprio1 and hviprio2; or
• emulating an external interrupt controller for a virtual hart without the use of an IMSIC’s
guest interrupt file, while also supporting configurable priorities both for external interrupts
and for major interrupts to the virtual hart.

All hvictl fields together can affect the value of CSR vstopi (Virtual Supervisor Top Interrupt)
and therefore the interrupt identity reported in vscause when an interrupt traps to VS-mode.
When hvictl.VTI = 1, the absence of an interrupt for VS level can be indicated only by setting
hvictl.IID = 9. Software might want to use the pair IID = 9, IPRIO = 0 generally to represent
no interrupt in hvictl.

(See riscv-interrupts-1.0: Interrupts at VS level)

Signed-off-by: Irina Ryapolova <irina.ryapolova@syntacore.com>
---
Changes for v2:
  -added more information in commit message
Changes for v3:
  -applied patch in master
---
 target/riscv/csr.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 726096444f..4c2cbcd59f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3613,6 +3613,21 @@ static RISCVException write_hvictl(CPURISCVState *env, int csrno,
                                    target_ulong val)
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



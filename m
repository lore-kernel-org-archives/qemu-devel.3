Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D1AC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmz2E-0005SA-PR; Wed, 20 Mar 2024 12:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irina.ryapolova@syntacore.com>)
 id 1rmz29-0005RH-Ej; Wed, 20 Mar 2024 12:43:21 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irina.ryapolova@syntacore.com>)
 id 1rmz25-0000BD-0o; Wed, 20 Mar 2024 12:43:19 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com CD7A3C0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1710952990;
 bh=Yh85yE6RTbimQ5Ular9YpwnUYaZCpSZWsNYbd1JI97c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=lDrkqAad/8yVYQQZ1EZ7m5T5xvnEhCfqgDrS5GgokhctD45jcEeonSRtsQ4Qvpv/c
 NO6Vp/Tno9xKyH1ajPwG10exozK48TM8LbFel8kzGggSqVnPDmD2Mjpq3xosElukhL
 k/ql1K3vphC+E2vY62zIRLAK9zPpHZ3yGl1JBbcTI5fSFpWrGLwNv+Jqwn32BoTiXC
 sNp4IbCoMCUQ2uQbE8Rpq0aWHBReIsss5aZwormehiZo58R8/3oS7Omx8S+3aNDq4J
 fq5tMLaFYAllaAQmQkNjM+Pd3qdsvfRB/cltNzpJrVnY/j/lsIZ3NTFGnehcyWqj/c
 Xt+0VYqxuI7Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1710952990;
 bh=Yh85yE6RTbimQ5Ular9YpwnUYaZCpSZWsNYbd1JI97c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=J/Xft96NOsdqm2Ak5nSrwL6ydz5YAGI6JS3VXBO3ZXYeuzVJSbsCXWOVg47dr5Y8p
 MBOg/fNvRLgjkHKU56HeiJVl7Pdf03C5jJuNzn35CuQflhPOTN7rjdg2TbWCWrYEQp
 WAsn/GwP3FJNYvnOrHdrjb95k9sHEHIxLeGa4cwoGM8gyrhGS9Gen7qX3nba9I7WO2
 gBbClVc/nyCjLFz6pk283h6/4dRaY2gYd7eeyUErCfzyHaxjGrEbmA2crO+2cafMf9
 Gpw/MjQTkgqgjp+AoEh4pI5ixtgYyyfBgxq4AHbCmZAzVxgq9sS/5qk+uccgHMIsaB
 yUd8JW5pY2yfw==
From: Irina Ryapolova <irina.ryapolova@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bin.meng@windriver.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, Irina Ryapolova
 <irina.ryapolova@syntacore.com>
Subject: [PATCH v2 1/2] target/riscv/csr.c: Add functional of hvictl CSR
Date: Wed, 20 Mar 2024 19:42:58 +0300
Message-ID: <20240320164259.19205-1-irina.ryapolova@syntacore.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
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



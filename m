Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491D7C48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 17:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZZrB-00067Z-A2; Mon, 12 Feb 2024 12:12:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irina.ryapolova@syntacore.com>)
 id 1rZZr9-00066o-7i; Mon, 12 Feb 2024 12:12:35 -0500
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irina.ryapolova@syntacore.com>)
 id 1rZZr7-0004S8-Hj; Mon, 12 Feb 2024 12:12:34 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 05990C0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1707757944;
 bh=s/XN3CO0iJeMqY5zI5HVlTnKgwEGUPwXTodK87ckfDQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=IqUwrcu9F95LkOvhuAd3Gb/B33RKr4V+8YUlAamO3kKIIB5ktz5HKE9Jl3PAY70BM
 w1WeMCLu//ByqaWa9iYZ/Q05ASrUmUziE9Q++r/akML0Zkfx+yrDf+8YDgxpEkXDz0
 01Jshw9LsLbPrLSoE8Z0kogrbHzsGH+XcB3cg3kWMAt9OAzVk+WrFzfuLJcIbM+Qz2
 eKp00VJ4Pvb8DIbkusrZu85DR7v6RyUtXPgAIbYSV1GTpJf5kVSrBcJRRy78YE6zc5
 kcNPUj1KesLjqFP2jyE2sY9NKAAYST0Mieky7RB4AyfgDSygHjbqTuRyBWcoz2qKjp
 OE7Q68vF5ilHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1707757944;
 bh=s/XN3CO0iJeMqY5zI5HVlTnKgwEGUPwXTodK87ckfDQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=HBNP5jkwVCECcVWgUHgH6WYPAwn4XG0fuGQ2lS19BYDfPE6oaLJgiitAH2L1T12LQ
 4oEnX/EGOcdFl9Nsp8Ip+dCDHera12aqfHRUlpmL+GDrghFDC0cPJKWVkZZaA2tsFI
 0QF6UrA/hxVWRIepdNZeouOeDRA71PlRRiIckvMqrZDphDMk9rmjKNHbI3PI35RGiI
 rEmUzxURgnec4ChRsuzWdtQSMc6if14+CIJ6lmky1jcNE/zmfilQE20DLFsutez1HX
 MkUM+lcVHMv56Lzux0gbpMkrEApx2R2h/mvpM11PywHxMrvu3fZtgNEqlO7qgG0oX7
 6Ts3D1FwZmV7g==
From: Irina Ryapolova <irina.ryapolova@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bin.meng@windriver.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, Irina Ryapolova
 <irina.ryapolova@syntacore.com>
Subject: [PATCH 1/2] target/riscv/csr.c: Add functional of hvictl CSR
Date: Mon, 12 Feb 2024 20:11:55 +0300
Message-ID: <20240212171156.47293-1-irina.ryapolova@syntacore.com>
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



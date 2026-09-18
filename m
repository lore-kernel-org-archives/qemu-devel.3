Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFE5C982DF
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 20:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7fDb-0001KB-OR; Fri, 18 Sep 2026 16:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1x7fDZ-0001Jd-DX; Fri, 18 Sep 2026 16:29:57 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1x7fDX-0003D1-Q7; Fri, 18 Sep 2026 16:29:57 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9EEB440A20;
 Fri, 18 Sep 2026 20:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378FC1F000FF;
 Fri, 18 Sep 2026 20:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789763394;
 bh=/QkkhWti4U0cgjOq7ipLejpbLll6u8Vh1wDZGs+1W40=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lLQV1yy3OYKOHLzBsvL1MICLItq7E3PkEtygISaB9UwlQnt2bJzenWb5RmFCHxYt8
 V0p2GwyXBjWUfssUPrBztGA85UiCK4cKhOPISiB4YZ3bvfxrale9anJi5cnetM3J0l
 cQm4GMw1XO0sIN9KOqttPDM11j5FoS/+T9diGGGoFs3CJWw3uP3vAzQMCVshmJCLYJ
 B/wfm2NuA75n/hp6mpUfZcLzyFXs6SWjKWBuBMhAGo80WjID9yam8fmZ0H5GdPpMQn
 +SQTYboNZlvDOJ85MfK8/5wPrwk0Yc5V6aAgPQGydtX8SI3a5Pf9vRkUg35DZaAR8g
 WKlmSBTUTrabA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Helge Deller <deller@gmx.de>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PULL 1/4] linux-user/riscv: honor zicntr=false for base counterCSRs
Date: Fri, 18 Sep 2026 22:29:44 +0200
Message-ID: <20260918202947.5322-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918202947.5322-1-deller@kernel.org>
References: <20260918202947.5322-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: wangyang <wangyang25@otcaix.iscas.ac.cn>

In user-only builds, the base cycle and instret CSRs bypass the zicntr
feature gate because the check is inside the system-mode block. Move the
check before the conditional block so an explicitly disabled zicntr
extension makes the CSRs illegal in linux-user mode.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4148

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/riscv/tcg/csr.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index bd4b6dc114..061bc9db77 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -111,6 +111,13 @@ static RISCVException vs(CPURISCVState *env, int csrno)
 
 static RISCVException ctr(CPURISCVState *env, int csrno)
 {
+    if ((csrno >= CSR_CYCLE && csrno <= CSR_INSTRET) ||
+        (csrno >= CSR_CYCLEH && csrno <= CSR_INSTRETH)) {
+        if (!riscv_cpu_cfg(env)->ext_zicntr) {
+            return RISCV_EXCP_ILLEGAL_INST;
+        }
+    }
+
 #if !defined(CONFIG_USER_ONLY)
     RISCVCPU *cpu = env_archcpu(env);
     int ctr_index;
@@ -127,10 +134,6 @@ static RISCVException ctr(CPURISCVState *env, int csrno)
 
     if ((csrno >= CSR_CYCLE && csrno <= CSR_INSTRET) ||
         (csrno >= CSR_CYCLEH && csrno <= CSR_INSTRETH)) {
-        if (!riscv_cpu_cfg(env)->ext_zicntr) {
-            return RISCV_EXCP_ILLEGAL_INST;
-        }
-
         goto skip_ext_pmu_check;
     }
 
-- 
2.54.0



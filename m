Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E9DC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAmS2-0006mO-Iw; Sun, 27 Sep 2026 06:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmRV-00060n-0D; Sun, 27 Sep 2026 06:49:15 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmRR-00011x-KA; Sun, 27 Sep 2026 06:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790506130; bh=F8Mnu38w6TDpKEb9cUhklNwECBAnO6D4ScqWUob4GiQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SLKuPxwumOSaA9+MioPfij8YsqIJO/8MM4+B/x5FxAd1Py57o+0kiIrwbNWctPXf3
 UDgeZyARk+imOB5HZcCu7ANc42KS0Zd8pxWuSEIOkHhVNeLC28MCydcyjExO++OTko
 TKtl1ZAt14WfR70Pu9r5IwIHRnZvfM04QS3LNObeoLqohgfwGnN7BWR2hU3xxcD3KF
 zHlAdW8fuPNq4RbZEVcsEiAgVMQAD7JD5wPkedcT4TEukooJqtYZPt84u0pfMd6aGc
 FXfk4NqA8GDMz77rieVNkos5wspGGXYyIzDk/GAywayc/P3bdou93+uYhkEIan7+ou
 IwPkkUub6sCvA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8084E1D8B5E;
 Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7D890432165;
 Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 55BF15E774; Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 v2 63/92] linux-user/riscv: honor zicntr=false for
 base counterCSRs
Date: Sun, 27 Sep 2026 13:47:39 +0300
Message-ID: <20260927104821.196183-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
(cherry picked from commit ebfde6dafff2ebfb653d8b9a620ea52a4f714f5b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 23fc77e3106..a4cd126999a 100644
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
2.47.3



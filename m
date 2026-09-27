Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686A2C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjHx-000085-BZ; Sun, 27 Sep 2026 03:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjHf-0008W4-So; Sun, 27 Sep 2026 03:26:52 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjHe-0005P7-8M; Sun, 27 Sep 2026 03:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790494004; bh=PdaqPbz4ZAoS3tU56IUiiMPYochh7rPTqKNCeHsUGfs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jWlmkq7IGVwKVr5w7GgFxuj78Jjb5pf1yFuGuMzR/NlzLMpyP4TT2uBLORd5rV6r/
 SzXDUCNmkK6un2fl5e9oLqwhtokmmjFXXbi/truRcAOkPqVQVTK5M39CIhFrWKtcNq
 7SqIRh0BjQl56vZR8dUD053b2TgtKlYHv3S99eqr1MUzv70AUmCJOGrWgWmLceed/d
 vi0zY9XGEJicsKhR9svWhLszM4C+r2uH9964as2omPZodODcd0D1ABatQLkNLQuRqw
 9REhNZHVuOMO7AkzxIsB3/Lnb/Asw7E7/PX1FjD/b4BdZPaeMUHuGsWO+WoKS4rtUQ
 fgPxWVo3QrTLw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A14951D8AB6;
 Sun, 27 Sep 2026 10:26:44 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 88CBF432048;
 Sun, 27 Sep 2026 10:26:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 5941E5E61B; Sun, 27 Sep 2026 10:26:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 v2 52/72] linux-user/riscv: honor zicntr=false for
 base counterCSRs
Date: Sun, 27 Sep 2026 10:25:44 +0300
Message-ID: <20260927072622.93656-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
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

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 9d43dbfab81..8dbe82c7f6d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -107,6 +107,13 @@ static RISCVException vs(CPURISCVState *env, int csrno)
 
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
@@ -123,10 +130,6 @@ static RISCVException ctr(CPURISCVState *env, int csrno)
 
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



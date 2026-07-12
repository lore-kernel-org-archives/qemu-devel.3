Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CB3C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wileS-0006fe-VU; Sun, 12 Jul 2026 00:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wileR-0006bg-B4; Sun, 12 Jul 2026 00:18:47 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wileP-0006an-KG; Sun, 12 Jul 2026 00:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829781; bh=8tvbo7R8D3FJVz7Rst07ERGgZegYTk/poZ6DLCMFnQc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=L9NF39jUBZQl8AMzkJqy8atwHaZXabeQ0X1hVWV8uaLHtacHhSS4aC+R3GhAY4ny4
 9/03KM6oBIQ59ilIZ6apwrVgVqtsSyWV4n5JuvP+7H/qudx5wtP7jBn9bdr1dAPlnt
 XejAkelp19eoaIDfpvqKiZqYqGsIl9vJDr9NakgmKdS1Z6nwbk9yeDIzq1yM6P8Jmi
 I4gd890klgiZBx4JaS5aDhdARnINxvW+FqP1oUIDdfXgxMMD86y6QxHYKTwWX3kGx+
 3XGoK6xkjXBx7XqyItMWX4uq5lZgn/vczInRSXCjOMzaczZdVwwHffxQYxuKveq3zz
 tNpb2OZ37kKqA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 608BC1C0BF9;
 Sun, 12 Jul 2026 07:16:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 947F03EB959;
 Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 5A854133F5; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, ZhengXiang Qin <qinzhengxiang@foxmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 30/75] target/riscv: avoid abort when reading vtype
 before env->xl is set
Date: Sun, 12 Jul 2026 07:14:48 +0300
Message-ID: <20260712041539.108341-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
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

From: ZhengXiang Qin <qinzhengxiang@foxmail.com>

TCG plugins may read registers from the vcpu_init_cb() callback.  For
vtype, this reaches read_vtype() before env->xl has been initialized.

In that case read_vtype() currently hits g_assert_not_reached() because
env->xl is zero.  Fall back to the CPU's maximum XLEN only for this
early-init case.

Fixes: 638181a180bd ("core/cpu-common: initialise plugin state before thread creation")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3545
Signed-off-by: ZhengXiang Qin <qinzhengxiang@foxmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <tencent_FB929239B227F05F30D62745E38BA01D4307@qq.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 46d96da1309869af6261d1997623b7a5212814d8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index a5c1143a7b4..607dd385d69 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -914,7 +914,16 @@ static RISCVException read_vtype(CPURISCVState *env, int csrno,
                                  target_ulong *val)
 {
     uint64_t vill;
-    switch (env->xl) {
+    int xl = env->xl;
+    /*
+     * TCG plugins can read registers before env->xl is initialized.
+     * Fall back to the CPU's maximum XLEN in that early-init case.
+     */
+    if (xl == 0) {
+        xl = riscv_cpu_mxl(env);
+    }
+
+    switch (xl) {
     case MXL_RV32:
         vill = (uint32_t)env->vill << 31;
         break;
-- 
2.47.3



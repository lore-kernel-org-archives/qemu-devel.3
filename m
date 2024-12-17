Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F66AE7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 08:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNTBC-0003WJ-QL; Tue, 17 Dec 2024 03:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1tNTB9-0003VD-Fp; Tue, 17 Dec 2024 03:43:43 -0500
Received: from out28-123.mail.aliyun.com ([115.124.28.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1tNTB4-0006Lk-Vc; Tue, 17 Dec 2024 03:43:43 -0500
Received: from TC-DZ-03-0020.tc.local(mailfrom:lc00631@tecorigin.com
 fp:SMTPD_---.agA.55d_1734425002 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 17 Dec 2024 16:43:24 +0800
From: Chao Liu <lc00631@tecorigin.com>
To: bmeng.cn@gmail.com, liwei1518@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, zqz00548@tecorigin.com,
 Chao Liu <lc00631@tecorigin.com>
Subject: [PATCH v1 1/1] target/riscv: Fix handling of NOP for vstart >= vl in
 vext_vx_rm_2()
Date: Tue, 17 Dec 2024 16:43:05 +0800
Message-ID: <0b9e98cf4003198bda24ac56e128e4393682963e.1734424581.git.lc00631@tecorigin.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <cover.1734424581.git.lc00631@tecorigin.com>
References: <cover.1734424581.git.lc00631@tecorigin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.123;
 envelope-from=lc00631@tecorigin.com; helo=out28-123.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

fix: https://lore.kernel.org/all/20240322085319.1758843-8-alistair.francis@wdc.com/
Signed-off-by: Chao Liu <lc00631@tecorigin.com>
---
 target/riscv/vector_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index a85dd1d200..54bac5922a 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2154,8 +2154,6 @@ vext_vv_rm_1(void *vd, void *v0, void *vs1, void *vs2,
              uint32_t vl, uint32_t vm, int vxrm,
              opivv2_rm_fn *fn, uint32_t vma, uint32_t esz)
 {
-    VSTART_CHECK_EARLY_EXIT(env);
-
     for (uint32_t i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             /* set masked-off elements to 1s */
@@ -2179,6 +2177,8 @@ vext_vv_rm_2(void *vd, void *v0, void *vs1, void *vs2,
     uint32_t vta = vext_vta(desc);
     uint32_t vma = vext_vma(desc);
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     switch (env->vxrm) {
     case 0: /* rnu */
         vext_vv_rm_1(vd, v0, vs1, vs2,
-- 
2.47.1



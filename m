Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6556DCC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHGHu-0000r4-Au; Thu, 15 Oct 2026 03:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xHGHo-0000qR-0B; Thu, 15 Oct 2026 03:54:01 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xHGHl-0004Pl-U2; Thu, 15 Oct 2026 03:53:59 -0400
Received: from [172.17.0.2] (unknown [124.16.137.194])
 by APP-03 (Coremail) with SMTP id rQCowAB3ejiQhtBqGt7SCg--.12533S3;
 Thu, 15 Oct 2026 15:53:52 +0800 (CST)
From: wangyang <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@c-sky.com>
Subject: [PATCH] target/riscv: enforce SSE precedence for ssp CSR access
Date: Thu, 15 Oct 2026 07:53:51 +0000
Message-Id: <179205083114.38010.14805105927981160340@otcaix.iscas.ac.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CM-TRANSID: rQCowAB3ejiQhtBqGt7SCg--.12533S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AryDKF17CFyxXFyrXFy5urg_yoW8WF1UpF
 18G390ka9YgF9Fyan3Jr1qgF13Gw1rJwsrXw1xuw4jvw15ArW5GasIgF43tFyrJFWDGr42
 9r42yF4ruF4DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9Sb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
 j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw
 1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l
 c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026x
 CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
 JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
 1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
 Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr
 1UYxBIdaVFxhVjvjDU0xZFpf9x07j02NZUUUUU=
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When menvcfg.SSE is clear, ssp access below M mode raises an
illegal-instruction exception before virtual-instruction classification.
Apply the henvcfg/senvcfg checks for VS/VU and preserve the user-only
path.
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4226
Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
 target/riscv/tcg/csr.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 061bc9d..98dcb0e 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -204,15 +204,34 @@ static RISCVException cfi_ss(CPURISCVState *env, int cs=
rno)
         return RISCV_EXCP_NONE;
     }
=20
-    /* if bcfi not active for current env, access to csr is illegal */
-    if (!cpu_get_bcfien(env)) {
 #if !defined(CONFIG_USER_ONLY)
-        if (env->debugger) {
-            return RISCV_EXCP_NONE;
-        } else if (env->virt_enabled) {
+    if (env->debugger) {
+        return RISCV_EXCP_NONE;
+    }
+
+    /* priv < M and menvcfg.SSE =3D 0 must raise illegal-instruction */
+    if (!(env->menvcfg & MENVCFG_SSE)) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    if (env->virt_enabled) {
+        if (env->priv =3D=3D PRV_S) {
+            if (env->henvcfg & HENVCFG_SSE) {
+                return RISCV_EXCP_NONE;
+            }
+            return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
+        }
+        if (env->priv =3D=3D PRV_U) {
+            if ((env->henvcfg & HENVCFG_SSE) &&
+                (env->senvcfg & SENVCFG_SSE)) {
+                return RISCV_EXCP_NONE;
+            }
             return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
         }
+    }
 #endif
+
+    if (!cpu_get_bcfien(env)) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
=20
--=20
2.43.0



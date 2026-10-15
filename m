Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121CDCC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHGTw-00050I-3k; Thu, 15 Oct 2026 04:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xHGTT-0004mg-Te; Thu, 15 Oct 2026 04:06:11 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xHGTP-0005Xv-D7; Thu, 15 Oct 2026 04:06:02 -0400
Received: from [172.17.0.2] (unknown [124.16.137.194])
 by APP-03 (Coremail) with SMTP id rQCowACnqzljidBqlxvTCg--.35814S3;
 Thu, 15 Oct 2026 16:05:55 +0800 (CST)
From: wangyang <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@c-sky.com>
Subject: [PATCH] target/riscv: enforce SSE precedence for ssp CSR access
Date: Thu, 15 Oct 2026 08:05:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CM-TRANSID: rQCowACnqzljidBqlxvTCg--.35814S3
Message-Id: <6AD08963.0F1C25.05843@cstnet.cn>
X-Coremail-Antispam: 1UD129KBjvJXoW7AryDKF17CFyxXFyrXFy5urg_yoW8WF1rpF
 18G390ka9Ygas2yan3Jr1DWF13G3WrJwsrXw1xuw4jvr15ArW5GasIgF43tFyrJFWDGr42
 9r42yF4ruF4DAa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBIb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
 j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_Wr
 ylYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l
 w4CEF2IF47xS0VAv8wCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GFyl42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
 kF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0QVy7UUUUU==
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
---
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



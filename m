Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B293CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHGHu-0000rX-OI; Thu, 15 Oct 2026 03:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xHGHl-0000qO-Ew; Thu, 15 Oct 2026 03:53:58 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xHGHi-0004Pa-Iq; Thu, 15 Oct 2026 03:53:57 -0400
Received: from [172.17.0.2] (unknown [124.16.137.194])
 by APP-03 (Coremail) with SMTP id rQCowAA3PjyJhtBqhd3SCg--.13579S3;
 Thu, 15 Oct 2026 15:53:45 +0800 (CST)
From: wangyang <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@c-sky.com>
Subject: [PATCH] target/riscv: mask inactive senvcfg.SSE on read
Date: Thu, 15 Oct 2026 07:53:44 +0000
Message-Id: <179205082482.38010.4219595518391444693@otcaix.iscas.ac.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CM-TRANSID: rQCowAA3PjyJhtBqhd3SCg--.13579S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKrW8JrWrKrWrGF48ZF17GFg_yoWfWrc_Cr
 4rur97ZaykZanFkFWDZw1rAryYk3y8Ka4rKaySkrZ0gry2gFyUZ3WkWFyDury5uw48G3Z3
 t3ZrGr4xWw17AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbakYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
 82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAw
 Av7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF
 7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
 IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
 MI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
 WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
 6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
 IYCTnIWIevJa73UjIFyTuYvjxU4JPEUUUUU
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

The CFI rules make senvcfg.SSE read as zero when menvcfg.SSE is clear.
In VU mode it also reads as zero when henvcfg.SSE is clear. Mask the
readback to match those rules.
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4224
Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
 target/riscv/tcg/csr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 061bc9d..7fd148d 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -3322,6 +3322,14 @@ static RISCVException read_senvcfg(CPURISCVState *env,=
 int csrno,
     }
=20
     *val =3D env->senvcfg;
+
+    if (env_archcpu(env)->cfg.ext_zicfiss) {
+        if (!(env->menvcfg & MENVCFG_SSE) ||
+            (env->virt_enabled && !(env->henvcfg & HENVCFG_SSE))) {
+            *val &=3D ~SENVCFG_SSE;
+        }
+    }
+
     return RISCV_EXCP_NONE;
 }
=20
--=20
2.43.0



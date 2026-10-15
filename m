Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DCCCC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHGTt-0004wP-Ie; Thu, 15 Oct 2026 04:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xHGTM-0004ks-Vt; Thu, 15 Oct 2026 04:05:58 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xHGTI-0005XR-Np; Thu, 15 Oct 2026 04:05:55 -0400
Received: from [172.17.0.2] (unknown [124.16.137.194])
 by APP-03 (Coremail) with SMTP id rQCowACHjz1aidBqyRrTCg--.61219S3;
 Thu, 15 Oct 2026 16:05:46 +0800 (CST)
From: wangyang <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@c-sky.com>
Subject: [PATCH] target/riscv: make mnstatus.MNPELP writable with Zicfilp
Date: Thu, 15 Oct 2026 08:05:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CM-TRANSID: rQCowACHjz1aidBqyRrTCg--.61219S3
Message-Id: <6AD0895A.0F1C22.05843@cstnet.cn>
X-Coremail-Antispam: 1UD129KBjvdXoW7GFWrKryfJw1xCry7AF17GFg_yoWftrgEgr
 4fuFykWa1vvws29FWUAr1rArZ5Cry09F1fKw43JF4F9ry7WF17Aa4vqa4UJr4Uuw1UtF1F
 y3ZxJ3y7Cr4UAjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbSxYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
 82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtw
 Av7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwAK
 zVAC0xCFj2AI6cx7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8ZwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUsoGQUUUUU
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

Zicfilp adds MNPELP to mnstatus, and MNRET consumes it when restoring ELP.
Include the field in write_mnstatus() when Zicfilp is implemented.
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4222
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
---
 target/riscv/tcg/csr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 061bc9d..fdb55b8 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -5584,6 +5584,10 @@ static RISCVException write_mnstatus(CPURISCVState *en=
v, int csrno,
         mask |=3D MNSTATUS_MNPV;
     }
=20
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        mask |=3D MNSTATUS_MNPELP;
+    }
+
     /* mnstatus.mnie can only be cleared by hardware. */
     env->mnstatus =3D (env->mnstatus & MNSTATUS_NMIE) | (val & mask);
     return RISCV_EXCP_NONE;
--=20
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3B2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 21:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZdgd-0002PT-5V; Thu, 01 Aug 2024 17:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1sZdYn-0005c2-1T; Thu, 01 Aug 2024 17:42:09 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1sZdYk-0001f4-5K; Thu, 01 Aug 2024 17:42:08 -0400
DKIM-Signature: a=rsa-sha256; bh=UkruwxpzGN0nWml852+v7xpPKHyhVVIZCJ8N7KBWdEc=; 
 c=simple/simple; d=git.sr.ht; h=From:Date:Subject:Reply-to:To;
 q=dns/txt; s=20240113; t=1722548523; v=1;
 b=A1T+o2bcUkLdcso2OAw/NNR3mcMWXAX6LJfoxjvFiAwmVhu7p7IhusWzH/doagoP3hQZXjKI
 tJtyY4yVbbn2e8p9mEpKXpPCJjI83kQNKDgmTk46ceYoSHSQ1C0fcUQWOJQZwh0L3GlWtku2//A
 5LmIPRU371pUMlWGkXwdaxPn91+yiPOV5cD5vXwYvF8ungRLvNRW3UQyg86kszB2W/zpFmuKSqJ
 0urccIcMompil4BNjdZSSzMCqiCqPj7c3nyW6iHd01lVIC6E+X/iSavIBYm/wj19t+EtKOkV253
 Vuo2k6zyDNUVTQzgH+HAzi8ElGsnU/KQJSvAvoHXnS0sA==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 1B1CE2026C;
 Thu,  1 Aug 2024 21:42:03 +0000 (UTC)
From: ~arichardson <arichardson@git.sr.ht>
Date: Thu, 01 Aug 2024 13:22:57 -0700
Subject: [PATCH qemu] target/arm: add support for 64-bit PMCCNTR in AArch32
 mode
Message-ID: <172254852305.13451.4513785887599072710-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 01 Aug 2024 17:50:11 -0400
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
Reply-To: ~arichardson <mail@alexrichardson.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alex Richardson <alexrichardson@google.com>

See https://developer.arm.com/documentation/ddi0601/2024-06/AArch32-Registers=
/PMCCNTR--Performance-Monitors-Cycle-Count-Register?lang=3Den

Signed-off-by: Alex Richardson <alexrichardson@google.com>
---
 target/arm/helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8fb4b474e8..94900667c3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5952,6 +5952,12 @@ static const ARMCPRegInfo v8_cp_reginfo[] =3D {
       .access =3D PL1_RW, .accessfn =3D access_trap_aa32s_el1,
       .writefn =3D sdcr_write,
       .fieldoffset =3D offsetoflow32(CPUARMState, cp15.mdcr_el3) },
+    { .name =3D "PMCCNTR", .state =3D ARM_CP_STATE_AA32,
+      .type =3D ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_64BIT,
+      .cp =3D 15, .crm =3D 9, .opc1 =3D 0,
+      .access =3D PL0_RW, .resetvalue =3D 0, .fgt =3D FGT_PMCCNTR_EL0,
+      .readfn =3D pmccntr_read, .writefn =3D pmccntr_write,
+      .accessfn =3D pmreg_access_ccntr },
 };
=20
 /* These are present only when EL1 supports AArch32 */
--=20
2.43.4


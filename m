Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC5FD3EE66
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 14:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vivPz-0000ZF-Tk; Thu, 22 Jan 2026 09:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zengzhijin@linux.spacemit.com>)
 id 1vivPw-0000Yz-JE; Thu, 22 Jan 2026 09:12:12 -0500
Received: from smtpbg150.qq.com ([18.132.163.193])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zengzhijin@linux.spacemit.com>)
 id 1vivPq-0002iN-38; Thu, 22 Jan 2026 09:12:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
 s=mxsw2412; t=1769091106;
 bh=q6KJildkzXHvPB5BlReLg3muY+4KdW4Nfh5FYbfjhnk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=kZ3q2Xql2ONuQT/XwT1B6kp1l0VEUS5vyZhoprXwedmVVVfKYPVSrYQuKkMvzBpqa
 73NcZLcEOF1L9zymMXAelN2ulCPoF656pDCqq8C8EevZ6pmt85ImOaSSk3hbwPmuzP
 2Hjc810K9doj1pTKpPCgaZzSUQJiokWdhjt1KQgI=
X-QQ-mid: esmtpgz15t1769091100t5540b49a
X-QQ-Originating-IP: ChQUmlOV2i4RzQqv2FmXs/auGUNWZVzWhqkiOx3F1jE=
Received: from ZhijinZeng.localdomain ( [27.42.97.15])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 22 Jan 2026 22:11:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15019275036717591452
EX-QQ-RecipientCnt: 5
From: Zhijin Zeng <zengzhijin@linux.spacemit.com>
To: qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, qemu-devel@nongnu.org,
 Zhijin Zeng <zengzhijin@linux.spacemit.com>
Subject: [PATCH] tcg/riscv: Fix fractional LMUL constraint check error
Date: Thu, 22 Jan 2026 22:11:36 +0800
Message-ID: <D95DCA3EC325E4A4+20260122141136.2276-1-zengzhijin@linux.spacemit.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: N23nuY4pfFF+TvT4h3MeKZ6MAYfkd1QxSSONzccU0QkXeOMNVfJ/fv6d
 oiqBDPPSqE6I8I2mmeh+LfJJX/mnZLwYQcVLH9TREvHrGEnYBcmPehu9ggj6GaRLUdIgWDa
 EsYA/CibJ/qua9wopNcfZHabqCsHZATCWO5KBLroF/3/2gol5lLEOHdkW/FiysFt0zZEnPB
 pi9CKqWoE8c41jXJYeaZeM/682UC98mhwZ9nPHiZnqenS8HTZ3zwyQmshZTPjTf5n1uv6R1
 CmbVyXPi2NfG5z0IdgTWT+FPH7PbX5arU/lxjx70qAZ4lcZaqv+e2d+AthfCDGNv6PMCl1z
 eHOB2o8xB+iUKdxKHI3HL+F+EUaZnBAbJGaM3HcF4ZHJFR1P3OWfGc/mhwLqeAAABwIHspR
 ov0bytMZjItn4jzEYotU4yoxyeSXin/Y/go7loiERLTAeis0BeOtwoGul7FTtkHVM5XmbBl
 MNgx92+dTlyWtE0c7+oqmDDTr9bQVFZ5ZfAHZ/vGEM0rUQFwC9IAmn35Vab8+lN0BXZqpl/
 jhMARLDJbLvcQVmGuxbFPpW0MvH485G2Q0sm3b5t1vHbp9VOjxY6GZbnWL49wFfM4yFK9i7
 wkx9z3kbWFvj/AzrLreIxhzz3RbqcMrrvvPefR3LYvXa3J8q3fu8cYdYC0YtTJQVgeGL8au
 Z8Iq4bniZmzP9IMEWWKBW8m02DGwDzuQUcsXbFMY+dAnnmlw589aWyoomLiDxvunI2bb9mt
 sCtL2JRD7+bQGP3I1p1+HsPgbLhDdZQuzqp/h4eu3uj1utM51hnk0ZvWaUCC4Zd1gPm0TQ3
 i06XmFzQlzjICpYD98LfIk4WY6oUt7/5WoXOKuVfodf+mNpNBACca89vdnnFonCkzkCgRxA
 zwWVfZYUmlgbNlJxqxU5f3HNbmdUWfmvqS+xTPPBzVnrbzSJ4Ru2NJ+HJiYcl7cCibeOfv8
 HpiIJ06+NysR10FMNUTtfJJ/2Mmo8KJ3SMA8Hqqamae4PBoqKjJwlm6hJfA1pDBo8zBoW0Z
 YqGS410TikkxH+PZ8JZzk4DYPb+K1JnNjpFZRFXBIQ0Z+mpNnFxUspXdhcnPxpcb2OS+G4q
 pdpMCHkG3LRvgB4bF10XEJe2Zw+djr5dYvPvO78ACrm/QRHHFICqNA=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
Received-SPF: none client-ip=18.132.163.193;
 envelope-from=zengzhijin@linux.spacemit.com; helo=smtpbg150.qq.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

According to RVV Spec Section 3.4.2, the correct constraint for fractional LMUL
is `SEWMIN <= sew <= LMUL * ELEN`, not `SEWMIN <= sew <= LMUL * VLEN`.

When parsing the instructions
`vsetivli zero, 2, e64, mf2, ta, mu; vmv.s.x v24, s3` with riscv_zve64x, an
illegal instruction exception should be reported but isn't. This patch fixes
the issue.

Signed-off-by: Zhijin Zeng <zengzhijin@linux.spacemit.com>
---
 target/riscv/vector_helper.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 2de3358ee8..f0315629ec 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -47,18 +47,17 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     target_ulong reserved = s2 &
                             MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
                                             xlen - 1 - R_VTYPE_RESERVED_SHIFT);
-    uint16_t vlen = cpu->cfg.vlenb << 3;
     int8_t lmul;
 
     if (vlmul & 4) {
         /*
          * Fractional LMUL, check:
          *
-         * VLEN * LMUL >= SEW
-         * VLEN >> (8 - lmul) >= sew
-         * (vlenb << 3) >> (8 - lmul) >= sew
+         * ELEN * LMUL >= SEW
+         * ELEN >> (8 - lmul) >= sew
+         * (cpu->cfg.elen) >> (8 - lmul) >= sew
          */
-        if (vlmul == 4 || (vlen >> (8 - vlmul)) < sew) {
+        if (vlmul == 4 || (cpu->cfg.elen >> (8 - vlmul)) < sew) {
             vill = true;
         }
     }
-- 
2.43.0



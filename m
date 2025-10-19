Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C7BCCD195
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 08:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAOdt-0001Hc-6j; Sun, 19 Oct 2025 04:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vAOdq-0001H5-NN; Sun, 19 Oct 2025 04:19:51 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vAOdo-0001Bn-79; Sun, 19 Oct 2025 04:19:50 -0400
Received: from [172.130.10.190] ([115.90.12.10]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59J8JKZX064785
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 19 Oct 2025 17:19:29 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=G4PFKtsEjb0gdmxwA92BjcCQP0H6kLJFDLEVhXcG1J0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1760861970; v=1;
 b=t0VQRfnFXYvPIg8ka3YsxGsx5YzDC0ey2ZQJxseW3tCtLncXx4lnT/jgrKwqE/b2
 yHmla8e2D5kUsantS8IvwOZels7p8Dj/xlcrps3YBLYriJZDRgmhYgtnanNiBNaR
 aI8/zMhvmZDd2YEh1cMWA787hZ4I4YMSrmzNGSfOv5zFMjHBaKN0xyXfCa7fvCoP
 /IXwQtUAZGt3y7pqb7ZCLzfmOCHtqz1dtzIhixeZBKXBVr0Vsi21LX3QxqZ7iJL4
 Mj1Lcl4ewgxrqCvHmg7u2cSvm9d6YjeLi/wHY8rRlch7gtMzWoPyIOfEbs9ES5QZ
 E6r17j6p5gkxQZMbiLJD7g==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 19 Oct 2025 17:19:18 +0900
Subject: [PATCH] target/riscv: Fix a uninitialized variable warning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-vlen-v1-1-f7352a402f06@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAWf9GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0NL3bKc1DxdY4NEU/NkA+OkFEtjJaDSgqLUtMwKsDHRsbW1AOeEkQt
 WAAAA
X-Change-ID: 20251019-vlen-30a57c03bd93
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

riscv_cpu_validate_v() left its variable, min_vlen, uninitialized if
no vector extension is available, causing a compiler warning. Avoid
the warning by calling g_assert_not_reached() in the case.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 target/riscv/tcg/tcg-cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 1150bd14697c..acbfac5d9e2c 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -426,6 +426,8 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
         min_vlen = 64;
     } else if (cfg->ext_zve32x) {
         min_vlen = 32;
+    } else {
+        g_assert_not_reached();
     }
 
     if (vlen > RV_VLEN_MAX || vlen < min_vlen) {

---
base-commit: c85ba2d7a4056595166689890285105579db446a
change-id: 20251019-vlen-30a57c03bd93

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>



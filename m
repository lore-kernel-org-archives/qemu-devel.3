Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA17C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 22:30:29 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFf4W-0000cM-70; Fri, 07 Jun 2024 15:16:20 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf4U-0000Po-A5; Fri, 07 Jun 2024 15:16:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf4S-0002sn-4q; Fri, 07 Jun 2024 15:16:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4EBCC6E55E;
 Fri,  7 Jun 2024 22:14:53 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8730FE2758;
 Fri,  7 Jun 2024 22:13:58 +0300 (MSK)
Received: (nullmailer pid 529422 invoked by uid 1000);
 Fri, 07 Jun 2024 19:13:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.1 49/71] target/arm: Disable SVE extensions when SVE is
 disabled
Date: Fri,  7 Jun 2024 22:13:30 +0300
Message-Id: <20240607191356.529336-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.1-20240607221321@cover.tls.msk.ru>
References: <qemu-stable-9.0.1-20240607221321@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2304
Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-id: 20240526204551.553282-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit daf9748ac002ec35258e5986b6257961fd04b565)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 985b1efe16..6e33481dfa 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -109,7 +109,11 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
          * No explicit bits enabled, and no implicit bits from sve-max-vq.
          */
         if (!cpu_isar_feature(aa64_sve, cpu)) {
-            /* SVE is disabled and so are all vector lengths.  Good. */
+            /*
+             * SVE is disabled and so are all vector lengths.  Good.
+             * Disable all SVE extensions as well.
+             */
+            cpu->isar.id_aa64zfr0 = 0;
             return;
         }
 
-- 
2.39.2



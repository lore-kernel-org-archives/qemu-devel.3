Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DDDCE7AB9
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 06:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smSru-0004iD-SL; Fri, 06 Sep 2024 02:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSrs-0004Yp-FM; Fri, 06 Sep 2024 02:54:52 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSrq-00030Y-RM; Fri, 06 Sep 2024 02:54:52 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EEEF68C23B;
 Fri,  6 Sep 2024 09:53:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B84031333F3;
 Fri,  6 Sep 2024 09:54:29 +0300 (MSK)
Received: (nullmailer pid 43342 invoked by uid 1000);
 Fri, 06 Sep 2024 06:54:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.7 06/53] hvf: arm: Do not advance PC when raising an
 exception
Date: Fri,  6 Sep 2024 09:53:36 +0300
Message-Id: <20240906065429.42415-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
References: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

hvf did not advance PC when raising an exception for most unhandled
system registers, but it mistakenly advanced PC when raising an
exception for GICv3 registers.

Cc: qemu-stable@nongnu.org
Fixes: a2260983c655 ("hvf: arm: Add support for GICv3")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-id: 20240716-pmu-v3-4-8c7c1858a227@daynix.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 30a1690f2402e6c1582d5b3ebcf7940bfe2fad4b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 09b31c318a..d7cc00a084 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1272,6 +1272,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint32_t rt)
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (!hvf_sysreg_read_cp(cpu, reg, &val)) {
             hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
+            return 1;
         }
         break;
     case SYSREG_DBGBVR0_EL1:
-- 
2.39.2



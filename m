Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF208606A32F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=rRyEL1Ym
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3E6-0005NF-6i; Mon, 16 Nov 2026 15:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Dz-0005DJ-9Y; Mon, 16 Nov 2026 15:22:47 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Dx-0003Yf-D4; Mon, 16 Nov 2026 15:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860372; bh=//3daFff3svNZm8zlxNb6WtICSOnd7Kpi2SydXWl6/I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rRyEL1YmZlXjqw0yVQaZDXR5M4ptxflsJLtwcEI/COAAxvRDdbGHA1S0TqXk5S1ZW
 yVSvrnLDxIUaSIMrLMKEXQ+cuUnzF2KiScMXPasT/T+Gg3rZEnyvpxQm8XW78yLrtm
 d+TzunlXei9PZ1i/mqdZJS6WbTiEq6Oewea9K7Sc9KRvP+Z73p/mKZ9q2N04mcOMxJ
 T9ERjhC0RvcbWz4u3F9IcTl33c+mUDjOm+55mPOTJPAx400YKcHK9Y9nXuIkG5vB07
 m3IXse8xGp5Zewe+8UKtFNZb5nWFCVrquh92/HBdRzh45jpivNYKu7HovvAiRK7TSe
 01I7H4O85+gYQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A9DAD1E715A;
 Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A6EB945FB93;
 Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 63BB6B8E16; Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 36/59] target/arm/ptw: check XN for ARMv6 in
 get_S1prot()
Date: Mon, 16 Nov 2026 23:18:40 +0300
Message-ID: <20261116201922.534306-36-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

The XN bits are supported in all ARMv6 and onward VMSA translation
tables, but we were ignoring them unless the CPU was at least v7.

For the ARM_FEATURE_V6 case, we retrieve the AP and XN bits in
get_phys_addr_v6() but we don't check the XN bit in get_S1prot().
Since you can't validly get to get_S1prot() except via
get_phys_addr_v6() or get_phys_addr_lpae(), we can remove the version
check entirely and need not explicitly check for "v6 or better"..

Change the `else if (arm_feature(env, ARM_FEATURE_V7))` check in
get_S1prot() to plain `else`.

Cc: qemu-stable@nongnu.org
Fixes: d8e052b3876356 ("target-arm: get_phys_addr_lpae: more xn control")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4367
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-id: 20261106-armv6-xn-check-v2-1-1291bb77a6c2@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: tweaked commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 7eacd04f49b901927e42641e5050245eb449d282)
(Mjt: context fixup for 10.0.x)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index da96a1df091..5086291483f 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1406,7 +1406,7 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
         if (regime_has_2_ranges(mmu_idx) && !is_user) {
             xn = pxn || (user_rw & PAGE_WRITE);
         }
-    } else if (arm_feature(env, ARM_FEATURE_V7)) {
+    } else {
         switch (regime_el(env, mmu_idx)) {
         case 1:
         case 3:
@@ -1424,8 +1424,6 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
         case 2:
             break;
         }
-    } else {
-        xn = wxn = 0;
     }
 
     if (xn || (wxn && (prot_rw & PAGE_WRITE))) {
-- 
2.47.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A262C021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 17:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlXAb-0001FO-Nf; Fri, 21 Feb 2025 12:50:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tlXAa-0001Dt-9s; Fri, 21 Feb 2025 12:50:36 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tlXAY-0001px-0h; Fri, 21 Feb 2025 12:50:35 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 577C5EFB6F;
 Fri, 21 Feb 2025 20:49:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 100121BB58B;
 Fri, 21 Feb 2025 20:49:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id EB60E53F91; Fri, 21 Feb 2025 20:49:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mikael Szreder <git@miszr.win>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.2 12/14] target/sparc: Fix register selection for all
 F*TOx and FxTO* instructions
Date: Fri, 21 Feb 2025 20:49:42 +0300
Message-Id: <20250221174949.836197-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.2-20250221204240@cover.tls.msk.ru>
References: <qemu-stable-9.2.2-20250221204240@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mikael Szreder <git@miszr.win>

A bug was introduced in commit 0bba7572d40d which causes the fdtox
and fqtox instructions to incorrectly select the destination registers.
More information and a test program can be found in issue #2802.

Cc: qemu-stable@nongnu.org
Fixes: 0bba7572d40d ("target/sparc: Perform DFPREG/QFPREG in decodetree")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2802
Signed-off-by: Mikael Szreder <git@miszr.win>
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
[rth: Squash patches together, since the second fixes a typo in the first.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250205090333.19626-3-git@miszr.win>
(cherry picked from commit 807c3ebd1e3fc2a1be6cdfc702ccea3fa0d2d9b2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 989c20b44a..cfcdf6690e 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -321,12 +321,12 @@ FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @q_d_d
 FNHADDs     10 ..... 110100 ..... 0 0111 0001 .....        @r_r_r
 FNHADDd     10 ..... 110100 ..... 0 0111 0010 .....        @d_d_d
 FNsMULd     10 ..... 110100 ..... 0 0111 1001 .....        @d_r_r
-FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @r_r2
-FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_d2
-FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @r_q2
-FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
-FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @d_r2
-FxTOq       10 ..... 110100 00000 0 1000 1100 .....        @q_r2
+FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @d_r2
+FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @d_d2
+FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @d_q2
+FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_d2
+FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @d_d2
+FxTOq       10 ..... 110100 00000 0 1000 1100 .....        @q_d2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
 FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_d2
 FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_q2
-- 
2.39.5



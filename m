Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCD3C02194
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 09:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfbKF-0006FN-Vi; Wed, 05 Feb 2025 04:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=dc2d=U4=miszr.win=git@fe-bounces.miszr.win>)
 id 1tfbKB-0006E0-RH
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 04:04:00 -0500
Received: from smtp.forwardemail.net ([207.246.76.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <SRS0=dc2d=U4=miszr.win=git@fe-bounces.miszr.win>)
 id 1tfbK8-0002ly-NB
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 04:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=miszr.win;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-257304d8b2;
 t=1738746235; bh=Tq+fp2HWyDXK3lzVFWHzHmixXBdrlEjZq2eKJn1cqcY=;
 b=FeKPFuh3RH594ta5cxe1xB6FF/bDK7VTRv5nu/o6U2OPMRISi+1xB0fU3nzw4+iKhgMq2JJFk
 zZixfD2GxVaz1MVh3qG35h1pJie3vhPjxaKusLK4yfmYnBSjFxGjT+ie5xR3XYHWkWxqDRGT/kc
 GMtR93u9Uuzy19eDd0kOsto=
X-Forward-Email-ID: 67a32979f2c6eba601968091
X-Forward-Email-Sender: rfc822; git@miszr.win, smtp.forwardemail.net,
 207.246.76.47
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Mikael Szreder <git@miszr.win>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Mikael Szreder <git@miszr.win>
Subject: [PATCH v2 2/2] target/sparc: Fix register selection for all F*TOx and
 FxTO* instructions
Date: Wed,  5 Feb 2025 10:03:33 +0100
Message-ID: <20250205090333.19626-3-git@miszr.win>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205090333.19626-1-git@miszr.win>
References: <20250205090333.19626-1-git@miszr.win>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.246.76.47;
 envelope-from=SRS0=dc2d=U4=miszr.win=git@fe-bounces.miszr.win;
 helo=smtp.forwardemail.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_FMBLA_NEWDOM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fixed a mistake I made in the FqTOx instruction.
Fixed issues in the FsTOx, FxTOs, FxTOd, FxTOq instructions.

Fixes: 0bba7572d40d ("target/sparc: Perform DFPREG/QFPREG in decodetree")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2802
Signed-off-by: Mikael Szreder <git@miszr.win>
---
 target/sparc/insns.decode | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 694a28d88c..cfcdf6690e 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -321,12 +321,12 @@ FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @q_d_d
 FNHADDs     10 ..... 110100 ..... 0 0111 0001 .....        @r_r_r
 FNHADDd     10 ..... 110100 ..... 0 0111 0010 .....        @d_d_d
 FNsMULd     10 ..... 110100 ..... 0 0111 1001 .....        @d_r_r
-FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @r_r2
+FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @d_r2
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @d_d2
-FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @q_q2
-FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
-FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @d_r2
-FxTOq       10 ..... 110100 00000 0 1000 1100 .....        @q_r2
+FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @d_q2
+FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_d2
+FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @d_d2
+FxTOq       10 ..... 110100 00000 0 1000 1100 .....        @q_d2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
 FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_d2
 FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_q2
-- 
2.48.1



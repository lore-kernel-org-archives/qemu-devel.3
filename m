Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7010CC02196
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texFw-00056z-Lh; Mon, 03 Feb 2025 09:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=d7fa=U3=miszr.win=git@fe-bounces.miszr.win>)
 id 1tex1V-0006pe-6w
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:02:01 -0500
Received: from smtp.forwardemail.net ([207.246.76.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <SRS0=d7fa=U3=miszr.win=git@fe-bounces.miszr.win>)
 id 1tex1T-0005Lk-HR
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=miszr.win;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-257304d8b2; t=1738591316;
 bh=raYIHEgeTxW3E2Hf+6kFG/cpXPTBsO8kwXXvuIO7W/Y=;
 b=ayWZonxJjH1ENVX0EMjEAe2xHr5140zunFL8LhjQkfHyE/WgiUpgAvUbvAZXmra5jKNmxDaXg
 UDQyKTaKdgWyNKya6Vo5ob61r5JHl34chOIU1zNhvzAab1LEdaagT5q0BU1g3a6om4E3U/ASEiw
 eAlcJjYYJd6OICOy78YZ/is=
X-Forward-Email-ID: 67a0cc50514bf110fcaed145
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
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Mikael Szreder <git@miszr.win>
Subject: [PATCH] target/sparc: Fix register selection for the fdtox and fqtox
 instructions
Date: Mon,  3 Feb 2025 15:01:30 +0100
Message-ID: <20250203140130.78240-1-git@miszr.win>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.246.76.47;
 envelope-from=SRS0=d7fa=U3=miszr.win=git@fe-bounces.miszr.win;
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
X-Mailman-Approved-At: Mon, 03 Feb 2025 09:16:47 -0500
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

A bug was introduced in commit 0bba7572d40d which causes the fdtox and
 fqtox instructions to incorrectly select the destination registers.
More information and a test program can be found in issue #2802.

Fixes: 0bba7572d40d ("target/sparc: Perform DFPREG/QFPREG in decodetree")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2802
Signed-off-by: Mikael Szreder <git@miszr.win>
---
 target/sparc/insns.decode | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 989c20b44a..694a28d88c 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -322,8 +322,8 @@ FNHADDs     10 ..... 110100 ..... 0 0111 0001 .....        @r_r_r
 FNHADDd     10 ..... 110100 ..... 0 0111 0010 .....        @d_d_d
 FNsMULd     10 ..... 110100 ..... 0 0111 1001 .....        @d_r_r
 FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @r_r2
-FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_d2
-FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @r_q2
+FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @d_d2
+FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @q_q2
 FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @d_r2
 FxTOq       10 ..... 110100 00000 0 1000 1100 .....        @q_r2
-- 
2.48.1



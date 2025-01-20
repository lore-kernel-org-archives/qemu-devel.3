Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDA2C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 21:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZzPG-0005j9-6O; Mon, 20 Jan 2025 16:34:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tZzPA-0005hd-Jv
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:33:56 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tZzP9-0000ub-0X
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:33:56 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 72A545C5E4C;
 Mon, 20 Jan 2025 21:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D628C4CEDD;
 Mon, 20 Jan 2025 21:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737408825;
 bh=hiowJEZim/pl10ariAxbjJF8nbwVOGWFYrx0bQiDF1U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MjB4xn1FLJpH5e2NjmdNt0mYlxktl1dCu//jnUe95BlgF/ttpcjZXFH88+pxbaySG
 brgpUdzMtcmDcreF6E2BAgTvRowQ5kEHcSTg3IjaHK15035dmHj/5GByKsoUwkO0p8
 ETMS1IVZgD4BLGiA+WUszClMSqI2Cb+4B48nEy4H4ejO8of7te/8OUaAPMATwtXCNQ
 tECwIziSZJ2h7ATTao7IGtgJJsMoqJpgx9HtrQLyVM41Zhy7XishB2n0jVHqe6oOib
 1gF4jjyQwMRuUZaGClXsgIImKqfx9RMDcndlbkaQM522ISsEDnjwhMEKQ7yxrpG7Rv
 uqzy21n0FixPg==
From: deller@kernel.org
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: deller@gmx.de
Subject: [PATCH v4 1/7] linux-user: netlink: Add missing IFA_PROTO to
 host_to_target_data_addr_rtattr()
Date: Mon, 20 Jan 2025 22:33:34 +0100
Message-ID: <20250120213340.359195-2-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250120213340.359195-1-deller@kernel.org>
References: <20250120213340.359195-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Fixes this warning:
 Unknown host IFA type: 11

IFA_PROTO has been introduced in kernel v5.18, and as such using it
unconditionally breaks build on Ubuntu 22.04.  Instead convert the IFA_XXX
values to QEMU_IDA_XXX values and use those instead.
Already existing IFA_XXX usages are converted to QEMU_IFA_XXX in a
followup-patch.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/fd-trans.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index c04a97c73a..05a944b32e 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -31,6 +31,22 @@
 #include "fd-trans.h"
 #include "signal-common.h"
 
+enum {
+    QEMU_IFA_UNSPEC,
+    QEMU_IFA_ADDRESS,
+    QEMU_IFA_LOCAL,
+    QEMU_IFA_LABEL,
+    QEMU_IFA_BROADCAST,
+    QEMU_IFA_ANYCAST,
+    QEMU_IFA_CACHEINFO,
+    QEMU_IFA_MULTICAST,
+    QEMU_IFA_FLAGS,
+    QEMU_IFA_RT_PRIORITY,
+    QEMU_IFA_TARGET_NETNSID,
+    QEMU_IFA_PROTO,
+    QEMU__IFA__MAX,
+};
+
 enum {
     QEMU_IFLA_BR_UNSPEC,
     QEMU_IFLA_BR_FORWARD_DELAY,
@@ -1140,6 +1156,7 @@ static abi_long host_to_target_data_addr_rtattr(struct rtattr *rtattr)
     /* binary: depends on family type */
     case IFA_ADDRESS:
     case IFA_LOCAL:
+    case QEMU_IFA_PROTO:
         break;
     /* string */
     case IFA_LABEL:
-- 
2.47.0



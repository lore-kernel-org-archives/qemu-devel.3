Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07186C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 13:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJLK-0000Sw-LM; Fri, 24 Jan 2025 08:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tbJKy-0000OU-D5
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:03:05 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tbJKw-0007G9-NX
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:03:04 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id F13335C5A69;
 Fri, 24 Jan 2025 13:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F5AC4CEE0;
 Fri, 24 Jan 2025 13:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737723780;
 bh=0dCMgv3HdlrGef/55pmBNQDksmQaq+s2c+t9E36FqCc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Cs0kJaSyrWMz36F1Au/9USwvNrXgQpp3NQq/G5+wT4XDRhhhhJsLia2zK29rHtKcI
 5ryhg8+NoqqO+SLtkSWLtK8x9OHgzCBZH5QjKg+P2PFZdgjtakcROuEoNzYlLnV6w/
 PN6DkGPY1cYqUyeJbakeaUdTsjj1Nq/oCV+o1dQBUwiZTwku4/4aVMesluIYL4JkIv
 00ZMtIhuKidxeEfqD9Eej2pV0oeiz70jdLoaxOgyJQXgyupec6IFBAjf1ODb/s2Sn9
 luvePZCl0Ie+dqdbwv1t5QouWEFysRpkJOjL5sLCXMQQOrPLX/wXVEor1mXJ3w3Nef
 ibCY9lG8QB44g==
From: deller@kernel.org
To: Laurent Vivier <laurent@vivier.eu>, Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PULL v3 1/6] linux-user: netlink: Add missing IFA_PROTO to
 host_to_target_data_addr_rtattr()
Date: Fri, 24 Jan 2025 14:02:49 +0100
Message-ID: <20250124130254.3134-2-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250124130254.3134-1-deller@kernel.org>
References: <20250124130254.3134-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Helge Deller <deller@gmx.de>

Fix this warning:
 Unknown host IFA type: 11

While adding IFA_PROTO, convert all IFA_XXX values over to QEMU_IFA_XXX values
to avoid a build failure on Ubuntu 22.04 (kernel v5.18 which does not know
IFA_PROTO yet).

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/fd-trans.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index c04a97c73a..2e714c8e56 100644
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
@@ -1138,20 +1154,21 @@ static abi_long host_to_target_data_addr_rtattr(struct rtattr *rtattr)
 
     switch (rtattr->rta_type) {
     /* binary: depends on family type */
-    case IFA_ADDRESS:
-    case IFA_LOCAL:
+    case QEMU_IFA_ADDRESS:
+    case QEMU_IFA_LOCAL:
+    case QEMU_IFA_PROTO:
         break;
     /* string */
-    case IFA_LABEL:
+    case QEMU_IFA_LABEL:
         break;
     /* u32 */
-    case IFA_FLAGS:
-    case IFA_BROADCAST:
+    case QEMU_IFA_FLAGS:
+    case QEMU_IFA_BROADCAST:
         u32 = RTA_DATA(rtattr);
         *u32 = tswap32(*u32);
         break;
     /* struct ifa_cacheinfo */
-    case IFA_CACHEINFO:
+    case QEMU_IFA_CACHEINFO:
         ci = RTA_DATA(rtattr);
         ci->ifa_prefered = tswap32(ci->ifa_prefered);
         ci->ifa_valid = tswap32(ci->ifa_valid);
@@ -1398,8 +1415,8 @@ static abi_long target_to_host_data_addr_rtattr(struct rtattr *rtattr)
 {
     switch (rtattr->rta_type) {
     /* binary: depends on family type */
-    case IFA_LOCAL:
-    case IFA_ADDRESS:
+    case QEMU_IFA_LOCAL:
+    case QEMU_IFA_ADDRESS:
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "Unknown target IFA type: %d\n",
-- 
2.47.0



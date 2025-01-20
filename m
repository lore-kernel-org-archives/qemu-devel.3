Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6617FC02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 21:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZzPY-0005nP-Cb; Mon, 20 Jan 2025 16:34:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tZzPE-0005jA-Pg
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:34:02 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tZzPD-00010C-Dd
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:34:00 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 7CFE5A401CD;
 Mon, 20 Jan 2025 21:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9D1C4CEE0;
 Mon, 20 Jan 2025 21:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737408836;
 bh=k4VkITVHrnQIgAjKT5pMsLkQ4VZjsEIUUHqNErGrsUg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fp6ksFWvgrByCn5W0px5xtY2/xNivdmduH3CEZT8IsEg/r27yUmdO/bj44zh3QBwk
 dILjsb8orFTQctrrqL6gqAxQDA9hwjjjUXgU0QrfQc/NoDMXAqWisD4CdkjwClmYoc
 jMNSRTN/F6Bdk+dwwbZ9acO+vrT4DSKP3iceSx8Phi0wNV8/oUka5hgsbpXCBfg3IU
 5BCO2Kv//DNuLBIFR/8KwoPC/6M5lgSwW2ZE063OgSTdxP40Y3GzVN2/78hyCcyxdR
 fuMZ15nGPkC/5J48aljnfHhoxsqRYHWUwpXo1XfBxuKfAQFs5JNlsLAjU1c+fF0bDR
 SImAf4lPOrOaA==
From: deller@kernel.org
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: deller@gmx.de
Subject: [PATCH v4 7/7] linux-user: netlink: Use QEMU_IFA_XXX values instead
 of IFA_XXX
Date: Mon, 20 Jan 2025 22:33:40 +0100
Message-ID: <20250120213340.359195-8-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250120213340.359195-1-deller@kernel.org>
References: <20250120213340.359195-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91; envelope-from=deller@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Convert existing places to use QEMU_IFA_XXX values.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/fd-trans.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index 105b1f0713..f83d1f79d5 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -1192,21 +1192,21 @@ static abi_long host_to_target_data_addr_rtattr(struct rtattr *rtattr)
 
     switch (rtattr->rta_type) {
     /* binary: depends on family type */
-    case IFA_ADDRESS:
-    case IFA_LOCAL:
+    case QEMU_IFA_ADDRESS:
+    case QEMU_IFA_LOCAL:
     case QEMU_IFA_PROTO:
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
@@ -1501,8 +1501,8 @@ static abi_long target_to_host_data_addr_rtattr(struct rtattr *rtattr)
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



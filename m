Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954C9C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 03:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEgfy-0005zP-0l; Mon, 12 May 2025 23:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patch@thomaslambertz.de>)
 id 1uEb7O-0006Q0-8C
 for qemu-devel@nongnu.org; Mon, 12 May 2025 17:55:26 -0400
Received: from mail-108-mta159.mxroute.com ([136.175.108.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <patch@thomaslambertz.de>)
 id 1uEb7M-0002Za-G9
 for qemu-devel@nongnu.org; Mon, 12 May 2025 17:55:25 -0400
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta159.mxroute.com (ZoneMTA) with ESMTPSA id
 196c67a2c490008631.001 for <qemu-devel@nongnu.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 12 May 2025 21:50:17 +0000
X-Zone-Loop: 4a8c17801246378e1bcf90c447d68273f70d7f99ff33
X-Originating-IP: [136.175.111.3]
Message-ID: <7fb0245b-7221-4cca-abb6-111095f7eea5@thomaslambertz.de>
Date: Mon, 12 May 2025 23:50:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, philmd@linaro.org
From: Thomas Lambertz <patch@thomaslambertz.de>
Subject: [PATCH] hw/usb/dev-hid: Support side and extra mouse buttons for
 usb-tablet
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - aus.mxroute.com
X-AntiAbuse: Original Domain - nongnu.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - thomaslambertz.de
X-Get-Message-Sender-Via: aus.mxroute.com: authenticated_id:
 mail@thomaslambertz.de
X-Authenticated-Sender: aus.mxroute.com: mail@thomaslambertz.de
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Received-SPF: pass client-ip=136.175.108.159;
 envelope-from=patch@thomaslambertz.de; helo=mail-108-mta159.mxroute.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 12 May 2025 23:51:27 -0400
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

The necessary plumbing for side- and extra mouse buttons to reach
usb-tablet is already done. But the descriptor advertises three buttons
max. Increase this to 5. Buttons are now identical to usb-mouse.

Signed-off-by: Thomas Lambertz <patch@thomaslambertz.de>
---
  hw/usb/dev-hid.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index 54d064e54e..96623aa322 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -491,14 +491,14 @@ static const uint8_t qemu_tablet_hid_report_descriptor[] = {
      0xa1, 0x00,		/*   Collection (Physical) */
      0x05, 0x09,		/*     Usage Page (Button) */
      0x19, 0x01,		/*     Usage Minimum (1) */
-    0x29, 0x03,		/*     Usage Maximum (3) */
+    0x29, 0x05,		/*     Usage Maximum (5) */
      0x15, 0x00,		/*     Logical Minimum (0) */
      0x25, 0x01,		/*     Logical Maximum (1) */
-    0x95, 0x03,		/*     Report Count (3) */
+    0x95, 0x05,		/*     Report Count (5) */
      0x75, 0x01,		/*     Report Size (1) */
      0x81, 0x02,		/*     Input (Data, Variable, Absolute) */
      0x95, 0x01,		/*     Report Count (1) */
-    0x75, 0x05,		/*     Report Size (5) */
+    0x75, 0x03,		/*     Report Size (3) */
      0x81, 0x01,		/*     Input (Constant) */
      0x05, 0x01,		/*     Usage Page (Generic Desktop) */
      0x09, 0x30,		/*     Usage (X) */
-- 
2.43.0



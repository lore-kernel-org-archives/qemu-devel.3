Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFBDC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 10:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetel-0005Ez-3V; Thu, 24 Jul 2025 06:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1ueteY-00058c-UM; Thu, 24 Jul 2025 06:58:24 -0400
Received: from imap5.colo.codethink.co.uk ([78.40.148.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1ueteW-0007kB-DT; Thu, 24 Jul 2025 06:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n8v6+1Kh5Cy1cMv5Z1SZIgofUDpGyDKxo42xZMiWgQw=; b=LGEN/S9oePV1J8JEpZSmrB7Y9I
 akyh3SPK9zEEwPWwayWf5CmfQA1BnHoJl5qGAAhM7Z02AHuJPqQHgzYGngaFWFAxQjXCH470/8UDZ
 U6U02phPWCiXiOB/CIzwMzGPaugwEOmbs4JUFF3SGxz2P+fHJxkEY5CHA4GrH+lszcFRr/q0P+rIz
 w7TqDBJhoqqgQDj4AbuM9SRjvr3SAC9rd/kJn7BPXRZJ5d1HBJn2HTj4SWwm+JCKFsIhVTZsTk4Dh
 vToA4OPB6YPu0oSzEIhLlxthS5Zfq02kekFUJNIWHImu0hZRBsY6ycI0P68u6CUVRWg9E9hGkRpgW
 7rAAhkQw==;
Received: from [167.98.27.226] (helo=rainbowdash)
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1ueteM-006uVd-RJ; Thu, 24 Jul 2025 11:58:10 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
 (envelope-from <ben@rainbowdash>) id 1ueteM-00000002vYu-2Cia;
 Thu, 24 Jul 2025 11:58:10 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: qemu-block@nongnu.org,
	philmd@linaro.org,
	bmeng.cn@gmail.com
Cc: qemu-devel@nongnu.org,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] hw/sd/sdcard: fix spi_cmd_SEND_CSD/CID state check
Date: Thu, 24 Jul 2025 11:58:07 +0100
Message-Id: <20250724105807.697915-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=78.40.148.171;
 envelope-from=srv_ts003@codethink.com; helo=imap5.colo.codethink.co.uk
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.158,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The addition of specific handlers for mmc-spi for SEND_CSD and
SEND_CID has broken at least Linux and possibly also u-boot's
mmc-spi code.

It looks like when adding the code, it is checking for these
commands to not be in sd_standby_state but the check looks to
have been accidentally reversed (see below)

     if (sd->state != sd_standby_state) {
         return sd_invalid_state_for_cmd(sd, req);
     }

Linux shows the following:

[    0.293983] Waiting for root device /dev/mmcblk0...
[    1.363071] mmc0: error -38 whilst initialising SD card
[    2.418566] mmc0: error -38 whilst initialising SD card

Fixes: da954d0e32444f122a4 ("hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers (CMD9 & CMD10)")
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 hw/sd/sd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 49fc79cf8a..e6c1ba7c5d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1317,7 +1317,7 @@ static sd_rsp_type_t sd_cmd_SEND_IF_COND(SDState *sd, SDRequest req)
 /* CMD9 */
 static sd_rsp_type_t spi_cmd_SEND_CSD(SDState *sd, SDRequest req)
 {
-    if (sd->state != sd_standby_state) {
+    if (sd->state == sd_standby_state) {
         return sd_invalid_state_for_cmd(sd, req);
     }
     return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
@@ -1336,7 +1336,7 @@ static sd_rsp_type_t sd_cmd_SEND_CSD(SDState *sd, SDRequest req)
 /* CMD10 */
 static sd_rsp_type_t spi_cmd_SEND_CID(SDState *sd, SDRequest req)
 {
-    if (sd->state != sd_standby_state) {
+    if (sd->state == sd_standby_state) {
         return sd_invalid_state_for_cmd(sd, req);
     }
     return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
@@ -1345,7 +1345,7 @@ static sd_rsp_type_t spi_cmd_SEND_CID(SDState *sd, SDRequest req)
 
 static sd_rsp_type_t sd_cmd_SEND_CID(SDState *sd, SDRequest req)
 {
-    if (sd->state != sd_standby_state) {
+    if (sd->state == sd_standby_state) {
         return sd_invalid_state_for_cmd(sd, req);
     }
 
-- 
2.37.2.352.g3c44437643



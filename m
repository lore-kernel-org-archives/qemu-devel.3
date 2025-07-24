Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57971C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 13:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uew9x-0003Q6-L2; Thu, 24 Jul 2025 09:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1uew9g-00038K-A5; Thu, 24 Jul 2025 09:38:41 -0400
Received: from imap5.colo.codethink.co.uk ([78.40.148.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1uew9d-0005TT-Sa; Thu, 24 Jul 2025 09:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=okcskwRdSuiC5hs9UB+sH+Rn8qJh1MgoQYNpk2ItQ9s=; b=5xsEpYgM6IKTav3elMo/lyW7U+
 Y3TSxh8zgaobSRWEByC7EoAvhb0JXen2mjKktqU/odN734WNV7g3d8cw/43Pwj8fZMYdMyJoFBhB9
 NPvjSkNxXmpBTK+kZnyNjrmJMYEruBHZPrflohMZy3lUo8ijvuiry4jfVuFLfJc0dheVXiPI5yKjc
 GvNOI1Dtrgh32pVoR6JwuywDNkKr/l+lL//aEWBFuqgoAn04zNW/p1rD9fx2VXq1H1mT56dvafWdc
 5XdnZc607a/m/4bM8rV0WdeCYUxEzEnfpS6FsDQ/sx2VPNGGRPiLIUmSAe1J+znbP7witlU5DlvrL
 kXbO/n8A==;
Received: from [167.98.27.226] (helo=rainbowdash)
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uew9Y-0072BQ-7P; Thu, 24 Jul 2025 14:38:32 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
 (envelope-from <ben@rainbowdash>) id 1uew9Y-00000003eEO-02Xk;
 Thu, 24 Jul 2025 14:38:32 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: qemu-block@nongnu.org,
	philmd@linaro.org,
	bmeng.cn@gmail.com
Cc: qemu-devel@nongnu.org,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] hw/sd/sdcard: fix SEND_STATUS for SPI cards
Date: Thu, 24 Jul 2025 14:38:30 +0100
Message-Id: <20250724133830.869623-1-ben.dooks@codethink.co.uk>
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

When the code re-organisation for the SEND_STATUS command
was done it broke the ssi-sd code which is now throwing the
error "ssi_sd: error: Unexpected response to cmd 13" or a
similar one in newer code.

Fix this by returning sd_r1 instead of sd_r2_s

Fixes: 807f6adac3773c18772bf ("hw/sd/sdcard: Add sd_cmd_SEND_STATUS handler (CMD13)")
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 80b59c8ff9..4472d101f2 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1388,7 +1388,7 @@ static sd_rsp_type_t sd_cmd_SEND_STATUS(SDState *sd, SDRequest req)
     }
 
     if (sd_is_spi(sd)) {
-        return sd_r2_s;
+        return sd_r1;
     }
 
     return sd_req_rca_same(sd, req) ? sd_r1 : sd_r0;
-- 
2.37.2.352.g3c44437643



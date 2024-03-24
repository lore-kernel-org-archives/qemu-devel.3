Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47868C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 15:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roPfm-0006FM-8Y; Sun, 24 Mar 2024 11:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irina.ryapolova@syntacore.com>)
 id 1roPfl-0006FC-91
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 11:22:09 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irina.ryapolova@syntacore.com>)
 id 1roPfj-00063m-H9
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 11:22:09 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com DCCF9C0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1711293722;
 bh=3g6QPnEumO3m2dubq03r4CdJmKaZIbh2xTPTUVN0iMg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=LMi7kQHQRo5T1nDYgAz5Ymnjg1RSq1hcGYUJfwhN4rZHPOtPgs5jp5NMK33fKF85w
 NX8/0T6tN7vju7hcddFTwkT+eoOPfZqgGyAGenEy8JF6qL3NEkSNObyUAJvcRqZ4nU
 5sxuw2vKInbtyXtCtoR14W0Ss8GDAkcgGWSNkmAic/sAYdcEcBxq7ut0G/H/+mKDSs
 zOiZjpJu/XykZ8WVRUrOSRYFMhFMBLlxxE+9tTqHoylUVmnyDu8YQoXwowmje7UO8p
 rr3AzZHlWuQYQqFeuWHEPRN2a8f3+87Ds/MsI9LEaRfJFiLX0IpBPwCkwFATAt/P3M
 hU5RaDL1Vtadg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1711293722;
 bh=3g6QPnEumO3m2dubq03r4CdJmKaZIbh2xTPTUVN0iMg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=uh37kE1VXUt27r2WLksj4HzMTpRSyLKqibBZfJcyL9HwnKWWe5pxenTgjaHi317wA
 sgerctObIwMEXsfkyn5kzOZsPw8tYwIEVjTzXFR0UT/TR5oC0PImuXXyrm/2Ak0QIu
 Qt/mvPL4TIsFxyPMSbp4Lqcjb2jn3kZ/ZcQ5p6ynm6QW65jCbcrvjrqKBYoBNwwvUb
 chmBr0wNTtsEgYJgpP50wSOprdKAWElE45BAVTkuuG54Qx2MFxj8OtnGUrUdab+nlY
 JuUagsosG9bD3s9O2C8Fh8jnH/JepK7vl7DcCybMmsJEwIjRuOoju6vEYjaudLj+3U
 N2o2XQaz3yXfQ==
From: Irina Ryapolova <irina.ryapolova@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <marcandre.lureau@redhat.com>, <pbonzini@redhat.com>, Irina Ryapolova
 <irina.ryapolova@syntacore.com>
Subject: [PATCH] chardev/char-win-stdio: Fix keyboard input after exit Qemu on
Date: Sun, 24 Mar 2024 18:21:50 +0300
Message-ID: <20240324152150.21506-1-irina.ryapolova@syntacore.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=irina.ryapolova@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

After exit Qemu need to return the terminal to the default state.

Signed-off-by: Irina Ryapolova <irina.ryapolova@syntacore.com>
---
 chardev/char-win-stdio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index 1a18999e78..4fa2c3de8b 100644
--- a/chardev/char-win-stdio.c
+++ b/chardev/char-win-stdio.c
@@ -220,6 +220,7 @@ err1:
 static void char_win_stdio_finalize(Object *obj)
 {
     WinStdioChardev *stdio = WIN_STDIO_CHARDEV(obj);
+    DWORD dwMode;
 
     if (stdio->hInputReadyEvent != INVALID_HANDLE_VALUE) {
         CloseHandle(stdio->hInputReadyEvent);
@@ -230,6 +231,10 @@ static void char_win_stdio_finalize(Object *obj)
     if (stdio->hInputThread != INVALID_HANDLE_VALUE) {
         TerminateThread(stdio->hInputThread, 0);
     }
+
+    GetConsoleMode(stdio->hStdIn, &dwMode);
+    dwMode &= ~ENABLE_VIRTUAL_TERMINAL_INPUT;
+    SetConsoleMode(stdio->hStdIn, dwMode);
 }
 
 static int win_stdio_write(Chardev *chr, const uint8_t *buf, int len)
-- 
2.25.1



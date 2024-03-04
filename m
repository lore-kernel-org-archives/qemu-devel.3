Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916AFC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 07:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh2sF-0000cV-3s; Mon, 04 Mar 2024 02:36:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rh2sD-0000bq-K1; Mon, 04 Mar 2024 02:36:33 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rh2sB-0001WE-DJ; Mon, 04 Mar 2024 02:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YGVQIgMvq3sqtrQR8Eoo9eAm1kpHnXhFj7jwONKzVos=; b=d78iZqDsL+aF8flVhn+ClVPTYy
 EdaTyGalSQA05s3i6VpVWZ1K5gKI0xz9SNhC2cNKFwdEoOYL3UYA38mp3Vqm70i5TMKgPi4ltnVg1
 aivrgAVrHNxx5U3qNa4unfYLUB0N/c0nGUT67eJPDS2f3SJFcjlXdqeYN6Mm+aWdWXVYTu1RxLAPo
 t0m7wzuF8SOlDLJOZHSFTfqjC0PcRFsc32Obxu+RZDoEc2vO4TCwL0U3IAJglxNHYdojalhJiDFTn
 7JbxFA9qtd8Ie3yhPYwOxFHrUvIdAIWbYJjDN8GDk5f6QPv5tCF2WeG9QXGbCc+kDOisah85c7OYw
 ALz3Tf6y56Qz3EMubr2wVwGJmoM8ZTQB9ROYkSutnBVpzKeuTpQjS78PSVnPjqiOVzZ0MFpj0JqoN
 uBFC8k/AlSWsdGcTViPolgR/G6W94CKysBliqHSwVdy5IMXP1zR0HX5krqiRP0GxQtF1Cnu0bH+Kg
 myP3fEJXGPP7I22yp9xZReyuk16rD0VfevWGXLBHW7GTJ8cJMagw0onTBUFH3nie/5xX+mmQ4nt0Y
 fmnI+7PfbpeC5DuatJxhV8io7vQ8Zy//0UiG5zjCtGRbDlawxVhCbdcijnBskNMIaYu/5phbRqaJb
 jLwIPd3bAxlJumRKo+JRI9y3mPmq3LsqJRnl7Q3/s=;
Received: from [2a00:23c4:8bb2:1300:eb54:aec0:aa9a:72ab]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rh2rH-0001gw-9E; Mon, 04 Mar 2024 07:35:39 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Date: Mon,  4 Mar 2024 07:35:48 +0000
Message-Id: <20240304073548.2098806-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:eb54:aec0:aa9a:72ab
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH] mac_newworld: change timebase frequency from 100MHz to 25MHz
 for mac99 machine
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

MacOS X uses multiple techniques for calibrating timers depending upon the detected
hardware. One of these calibration routines compares the change in the timebase
against the KeyLargo timer and uses this to recalculate the clock frequency,
timebase frequency and bus frequency if the calibration exceeds certain limits.
This recalibration occurs despite the correct values being passed via the device
tree, and is likely due to buggy firmware on some hardware.

The timebase frequency of 100MHz was set way back in 2005 by commit fa296b0fb4
("PIC fix - changed back TB frequency to 100 MHz") and with this value on a
mac99,via=pmu machine the OSX 10.2 timer calibration incorrectly calculates the
bus frequency as 400MHz instead of 100MHz. The most noticeable side-effect is
the UI appears sluggish and not very responsive for normal use.

Change the timebase frequency from 100MHz to 25MHz which matches that of a real
G4 AGP machine (the closest match to QEMU's mac99 machine) and allows OSX 10.2
to correctly detect all of the clock frequency, timebase frequency and bus
frequency.

Tested on various MacOS images from OS 9.2 through to OSX 10.4, along with Linux
and NetBSD and I was unable to find any regressions from this change.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/mac_newworld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 3e796d2f6d..ff9e490c4e 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -77,7 +77,7 @@
 
 #define MAX_IDE_BUS 2
 #define CFG_ADDR 0xf0000510
-#define TBFREQ (100UL * 1000UL * 1000UL)
+#define TBFREQ (25UL * 1000UL * 1000UL)
 #define CLOCKFREQ (900UL * 1000UL * 1000UL)
 #define BUSFREQ (100UL * 1000UL * 1000UL)
 
-- 
2.39.2



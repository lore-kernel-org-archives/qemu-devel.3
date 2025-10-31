Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2111CCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 13:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEp9I-0003Dl-Ix; Fri, 31 Oct 2025 09:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu@bonslack.org>) id 1vEp94-0003BE-QW
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:26:24 -0400
Received: from bonnix2.bonnix.it ([37.247.49.194])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu@bonslack.org>) id 1vEp8w-0005BZ-JC
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:26:22 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 bonnix2.bonnix.it B7E2C2647CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bonslack.org;
 s=20220805; t=1761917169;
 bh=8sdgUCsD28WV9yoSIqpFSkVdhB4sj4EdJIShnNCENeM=;
 h=Date:From:Subject:To:Cc;
 b=ydYwekEPiBH5z6fEdOjbP4C4iyba1zQIwbwxPyxKx+23SoDWhm2ebPSPwtQ93B2kK
 WyzHClMTsa44EUvQSte/44hGeVCswBZmwrY3D6jV/uYh8qYukdyonl6aD9ItpWcSVS
 gYtv8IhHaWqTqAJQ7qcJ+ps2DlFiicEDvouRxgC8=
Received: from [10.0.0.70] (dynamic-adsl-84-220-72-247.clienti.tiscali.it
 [84.220.72.247])
 by bonnix2.bonnix.it (Postfix) with ESMTPSA id B7E2C2647CA;
 Fri, 31 Oct 2025 14:26:09 +0100 (CET)
Message-ID: <ab68ba71-acd1-4ef1-bdde-f72a9e8e3152@bonslack.org>
Date: Fri, 31 Oct 2025 14:26:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Luca Bonissi <qemu@bonslack.org>
Subject: [PATCH 5/7] Add termios2 support to ppc target
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
Content-Language: it
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=37.247.49.194; envelope-from=qemu@bonslack.org;
 helo=bonnix2.bonnix.it
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From 2aa0a13da0da6e3a804359f24cc1298b97cda45c Mon Sep 17 00:00:00 2001
From: Luca Bonissi <qemu@bonslack.org>
Date: Fri, 31 Oct 2025 13:31:36 +0100
Subject: [PATCH 5/7] Add termios2 support to ppc target

Signed-off-by: Luca Bonissi <qemu@bonslack.org>
---
 linux-user/ppc/termbits.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/linux-user/ppc/termbits.h b/linux-user/ppc/termbits.h
index eb226e0999..ae6ee8897c 100644
--- a/linux-user/ppc/termbits.h
+++ b/linux-user/ppc/termbits.h
@@ -20,6 +20,28 @@ struct target_termios {
     target_speed_t c_ospeed;               /* output speed */
 };
 
+struct target_termios2 {
+    target_tcflag_t c_iflag;               /* input mode flags */
+    target_tcflag_t c_oflag;               /* output mode flags */
+    target_tcflag_t c_cflag;               /* control mode flags */
+    target_tcflag_t c_lflag;               /* local mode flags */
+    target_cc_t c_cc[TARGET_NCCS];         /* control characters */
+    target_cc_t c_line;                    /* line discipline */
+    target_speed_t c_ispeed;               /* input speed */
+    target_speed_t c_ospeed;               /* output speed */
+};
+
+struct target_ktermios {
+    target_tcflag_t c_iflag;               /* input mode flags */
+    target_tcflag_t c_oflag;               /* output mode flags */
+    target_tcflag_t c_cflag;               /* control mode flags */
+    target_tcflag_t c_lflag;               /* local mode flags */
+    target_cc_t c_cc[TARGET_NCCS];         /* control characters */
+    target_cc_t c_line;                    /* line discipline */
+    target_speed_t c_ispeed;               /* input speed */
+    target_speed_t c_ospeed;               /* output speed */
+};
+
 /* c_cc character offsets */
 #define TARGET_VINTR 	0
 #define TARGET_VQUIT 	1
@@ -225,6 +247,8 @@ struct target_termios {
 #define TARGET_TIOCSBRK	0x5427  /* BSD compatibility */
 #define TARGET_TIOCCBRK	0x5428  /* BSD compatibility */
 #define TARGET_TIOCGSID	0x5429  /* Return the session ID of FD */
+#define TARGET_TIOCGRS485	0x542e
+#define TARGET_TIOCSRS485	0x542f
 #define TARGET_TIOCGPTN	TARGET_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TARGET_TIOCSPTLCK	TARGET_IOW('T',0x31, int)  /* Lock/unlock Pty */
 #define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open the slave */
-- 
2.50.1



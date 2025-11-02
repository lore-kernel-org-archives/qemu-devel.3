Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE6ACCF9E3
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 10:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFVKu-00043R-Fr; Sun, 02 Nov 2025 05:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <whitebox@nefkom.net>)
 id 1vFVKs-00043J-M2
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 05:29:22 -0500
Received: from mail-out.m-online.net ([212.18.0.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <whitebox@nefkom.net>)
 id 1vFVKq-00079s-1m
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 05:29:22 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4czrYN15BQz1r6RX;
 Sun,  2 Nov 2025 11:29:12 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4czrYN02Gxz1qqlS;
 Sun,  2 Nov 2025 11:29:11 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id dYXxlrFz9DII; Sun,  2 Nov 2025 11:29:02 +0100 (CET)
X-Auth-Info: J6129wB0pOSfme/z821AnrMKzxj4tCT72Z9cSJzVRLhBeK5EozILOc7qLQrOwDtX
Received: from igel.home (aftr-82-135-83-124.dynamic.mnet-online.de
 [82.135.83.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Sun,  2 Nov 2025 11:29:02 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
 id D13612C192A; Sun,  2 Nov 2025 11:29:01 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Luca Bonissi <qemu@bonslack.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,  Laurent Vivier
 <laurent@vivier.eu>,  qemu-devel@nongnu.org
Subject: Re: [PATCH 1/7] Add termios2 support to linux-user
In-Reply-To: <745f18b6-ee62-4903-9a56-dcb903b610cf@bonslack.org> (Luca
 Bonissi's message of "Fri, 31 Oct 2025 14:23:21 +0100")
References: <745f18b6-ee62-4903-9a56-dcb903b610cf@bonslack.org>
Date: Sun, 02 Nov 2025 11:29:01 +0100
Message-ID: <87cy606842.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=212.18.0.9; envelope-from=whitebox@nefkom.net;
 helo=mail-out.m-online.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Please test with the glibc testsuite:

$ ~-/qemu-x86_64 termios/tst-termios-linux | head -30
warning: could not become root outside namespace (Operation not permitted)
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ospeed = 0, expected 123456
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 0, expected 123456
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 75, expected 1200
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 9600, expected 456789
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ospeed = 0, expected 54321
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 0, expected 1234567890
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 0, expected 2400
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 50, expected 2400
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 2400, expected 50
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 75, expected 2400
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 2400, expected 75
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 110, expected 2400
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 2400, expected 110
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 134, expected 2400
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 2400, expected 134
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 150, expected 2400
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 2400, expected 150
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 200, expected 2400
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 2400, expected 200
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 300, expected 2400
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 2400, expected 300
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 600, expected 2400
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 2400, expected 600
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 1200, expected 2400
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 2400, expected 1200
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 1800, expected 2400
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 2400, expected 1800
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 4800, expected 2400
error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:194: c_ispeed = 2400, expected 4800

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."


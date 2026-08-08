Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519F6C55174
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsgu1-0006N3-Iw; Sat, 08 Aug 2026 09:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dreibh@simula.no>) id 1wseNa-0002Ay-01
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 06:34:14 -0400
Received: from mail-lr2-x06.google.com ([2a00:1450:4864:38::6])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dreibh@simula.no>) id 1wseNX-0000gE-Qq
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 06:34:13 -0400
Received: by mail-lr2-x06.google.com with SMTP id
 38308e7fff4ca-39f7d684247so2939921fa.1
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 03:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=simula-no.20251104.gappssmtp.com; s=20251104; t=1786185248; x=1786790048;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/z+1UkM0XJ5q0jYwCIu1jFHtvphtNFNeZC8/C42QARk=;
 b=Br2X8SsqDQ2S4RP3ouar4S/nQZE/MXyM5CXfgNOyxAnWze7ejCXvaQbLPhPNMH1QtR
 aqi9luuvSmKYypATFxq0W/2Y1qyt+LezJmjsFvou9H9nvCuN0dJbZa2g4i9qu9ihHuBq
 ig/yhTGIKUL3tnqdY7NWFaDemZwso8iNs7lV1YCjyVK1W3ZQl0oAtt6bYLLDH1CY9O4t
 WyfFpSckMOHu2eW/D8jNnpUWnSRNym7YAUzSmrS20EvenUmPwpf0dg1mdLlsX9uxiQzb
 U6hpbixPxctf7c3QYBh7Td1KWC5nBv/v0z24YMeVuTUuAr+7V3IKBuKUSarwe5nBFka7
 Wifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786185248; x=1786790048;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/z+1UkM0XJ5q0jYwCIu1jFHtvphtNFNeZC8/C42QARk=;
 b=qDwU7FbUvtZQAjQa6TLdPhMraaSHe22fn7Y423hSk/R3tYQdBvS/YGBA1HxC4VnxBN
 Huw8XTZ8ofyg46bCAxRrLVMOk4g1tr+3FCQkXAajtJjWLHnZ1bi7C3Gy+JnkvQMXpA3G
 id1c8LeWLcvoKKKEGDs0N8Zd7Lh3+b76Z6ecz3i+rs2TJ0H5N2KDaZ3CUSCetTfRXalZ
 OWa0JwzzLXCjmVyXTZpQrHqGiOIO/5CPH8IGMF7F2Gg5H5mdfgU9PrXxj++E+taKlNOn
 YT7NvCMqiujei0oOx9u9vlajUaDsLfoV0OQSGMY9/ism2o2NpmVjgf61OEqeD3d+miyJ
 IBiw==
X-Gm-Message-State: AOJu0YyQe4w+HCtC6D5Uninkwkv9C2WruNOHC1xZtWCRlq6Qy0ZkOyS1
 HGtsERa4fQmn1pZZFpXdPe8foZDrCd4lcvqZ3COHQ1Qx4bGsnMYPNUaCZ4I+yvttjO6gsweysP/
 Ka82dl7uo+iow
X-Gm-Gg: AR+sD12IoHpLLyWOzxNzpWc183gA2R4WgdvU2zrYcgatzRaNp4A7oBv+aZghiq1/sGH
 H4SF8WI8DHYd4+UTh9YBGBkMjoNBdDsJi66iRpbAt7GeAzxnD5snjjmOe8I0/ZlSH0iVnY1WCG0
 NkVdZY7704ZR5PbZOKhExZECFFQ9WgvwCjIL0KN4IDAYTIvD7FWdzX4tBUo054hPA4xWEf3h5ma
 gAH/pVKb7noNDUA8XMO641+tq30ToPokfFwi57FSMNP8CbqJ9bngKRh+fzcEY3EjNXDIUhARju8
 m9hW9BYmxMPY5/opQ6jtd8nqyJZsSNDAz4ofIskPx+8aeQtFvoP+MJsnzodpfmu4vQ58goZw91n
 OnM2ItgUjqcAJfwnL8kKa/x4Q5yNPASvEVqs10BX+R+k7exOz0gwQIBXG2sLsBzBX+lnoCnEWl/
 0QxG+N/QEb9Fl/68LYdVMyjhdkUDqnfM1qqpZnV8Se7Ve0N9VbO9+dKLjxqJfMG6gyIx/puT2N9
 6RoFgNgcr4plh3hERK8
X-Received: by 2002:a2e:be2b:0:b0:39f:a2be:bc4a with SMTP id
 38308e7fff4ca-39fbae0b9d2mr35065511fa.4.1786185248460; 
 Sat, 08 Aug 2026 03:34:08 -0700 (PDT)
Received: from nordmarka.crnalab.net ([178.232.16.23])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39fdda80e0dsm9455521fa.7.2026.08.08.03.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 03:34:08 -0700 (PDT)
From: Thomas Dreibholz <dreibh@simula.no>
To: qemu-devel@nongnu.org
Cc: Thomas Dreibholz <dreibh@simula.no>, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH] Fix for
 https://gitlab.com/qemu-project/qemu/-/work_items/4141:
Date: Sat,  8 Aug 2026 12:34:06 +0200
Message-ID: <20260808-solaris-qga-fix-b4-v1-1-80eafc48246c@simula.no>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2017; i=dreibh@simula.no;
 h=from:subject:message-id; bh=/pOBVLszhwGWvOuffrnWg+P4FroCOv76l53EXB/auSg=;
 b=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
 XgdwtoVGbcpWuEhR4Hh2JXIii1zdAKBfnVfb4Q==
X-Developer-Key: i=dreibh@simula.no; a=openpgp;
 fpr=21412672518D8B2D1862EFEF5CD5D12AA0877B49
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:38::6;
 envelope-from=dreibh@simula.no; helo=mail-lr2-x06.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 08 Aug 2026 09:15:31 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Using the correct paths for "shutdown", "reboot", etc. under Solaris.

Signed-off-by: Thomas Dreibholz <dreibh@simula.no>
---
This patch fixes the issue of the not-working shutdown command
in the QEMU Guest Agent under Solaris
(https://gitlab.com/qemu-project/qemu/-/work_items/4141) by
fixing the command paths from /sbin/ to /usr/sbin/ in the
Solaris build.
---
 qga/commands-posix.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 837be51c40..e24248a0f3 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -216,9 +216,17 @@ out:
     return retcode;
 }
 
+#ifdef CONFIG_SOLARIS
+#define POWEROFF_CMD_PATH "/usr/sbin/poweroff"
+#define SHUTDOWN_CMD_PATH "/usr/sbin/shutdown"
+#define HALT_CMD_PATH     "/usr/sbin/halt"
+#define REBOOT_CMD_PATH   "/usr/sbin/reboot"
+#else
 #define POWEROFF_CMD_PATH "/sbin/poweroff"
-#define HALT_CMD_PATH "/sbin/halt"
-#define REBOOT_CMD_PATH "/sbin/reboot"
+#define SHUTDOWN_CMD_PATH "/sbin/shutdown"
+#define HALT_CMD_PATH     "/sbin/halt"
+#define REBOOT_CMD_PATH   "/sbin/reboot"
+#endif
 
 void qmp_guest_shutdown(const char *mode, Error **errp)
 {
@@ -262,7 +270,7 @@ void qmp_guest_shutdown(const char *mode, Error **errp)
         return;
     }
 
-    const char *argv[] = {"/sbin/shutdown",
+    const char *argv[] = {SHUTDOWN_CMD_PATH,
 #ifdef CONFIG_SOLARIS
                           shutdown_flag, "-g0", "-y",
 #elif defined(CONFIG_BSD)
@@ -274,7 +282,7 @@ void qmp_guest_shutdown(const char *mode, Error **errp)
 
     /*
      * If the specific command exists (poweroff, halt or reboot), use it instead
-     * of /sbin/shutdown.
+     * of SHUTDOWN_CMD_PATH.
      */
     if (shutdown_cmd != NULL) {
         argv[0] = shutdown_cmd;

---
base-commit: 3e3ccab106f879b1512f8e0d51a827dd4de30e22
change-id: 20260808-solaris-qga-fix-b4-d25104a17fb7

Best regards,
-- 
Thomas Dreibholz <dreibh@simula.no>



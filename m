Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BEAEF06E1
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpASl-0001Zx-M8; Sun, 08 Feb 2026 14:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpARA-0000dS-7e
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:23 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAR7-00008D-8S
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:15 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-45f015a3259so820251b6e.2
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578815; x=1771183615;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hHaU0gphdQAEZRw0OsPSDHvXHSS/3DRZmHCcwSLpKf8=;
 b=qVcQf6BkQjS1F7i4tSsoU7XJ+WBAYvuC+9ccFVCmP1MCXb81UTizKbv9FWmPgm9Aye
 ATxQTEO8gPMHUNPpKGNB4TwAAmb8CN2G7tcZ3sny09m6lrFluNbFXESkS1PuiAzTT1Zw
 ozWD8+7XaTPuw/uq25WemHkFi0SPYuwxa4RvyiTXX1c3/8q2XabVBQvkVD0UvbcsiEZT
 eiVOA60WByd2FdguU6rwW+fJ5R+3CcCkgOgnLuzna3Nwp0lt1ZgkzzqyFYzDWRvdLufo
 6JF1tEL9uXJSVlUvA8rgDQlj1nUZHb8Zl/yolSroj8dVuEqEkiB7SYlvv3d+xA3uTI1h
 1/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578815; x=1771183615;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hHaU0gphdQAEZRw0OsPSDHvXHSS/3DRZmHCcwSLpKf8=;
 b=uvykGxRFykb4p4xA88A3tP1cFyD3r0N4y1xat0cfOfTIuFKzS7FFXy/5GiNhS+VT2i
 ht455VGTcLqBLgUbnlY3MscvxNRxPJsTdEFwzajvrQS2CbAdTYckWtRyuAethDmex4tr
 QKPgmKvfLqqZ+/5kpCHBBub3dXzVdKVpdiEjr2Grh3Bk/xEcCjY1Mkm9DcpG2XUHSi3e
 5txrx33JUCKIT9a2OnEbx4oBurT4g+j18gXGDKBOFfD5YFOFNV7AOKr/GpGAT+GYUJOu
 qjDsZrM+3eJgyq9vqR+Bhy2tAuX+H1rUWyIGKsMLT1t5AyXb8l7YmSdhsxLnIJwyVPuG
 Qctg==
X-Gm-Message-State: AOJu0YyxjoeXw6YvklXmGouRuSt7G77RNenuOPjBhD4vEQBhsVsEH1K4
 +YSB+O1yrVhwy4Zd3cSkKY1Y4/Onzl8vGQWzx0rWokxLdkOqOsAgB+TyDFQA6Gxpigk=
X-Gm-Gg: AZuq6aJLVjoraYGs0Uq2xpK2iaHMxKDd9F4vFqnQS7laQbLbwfCkthFWRsQx290nQev
 2wZdUYbOEdIw23Mw7JI1COdVqDIjOiOX9KbuT9c2hVO4eJ5T7P8DtPnyj5sUCqi1xhBDZ9VGkDA
 0KRF8pr9v7apBkazYluGqfQ0SpyGc6iJ/s6oVnemrIODduEOE01tg6yijRoJ3GndnvcJ2ORTD/d
 A9Ws4JkXWScSvKCf7L2PDcA7XceyCvBfrwKIvarPJIl04idOYhDV6TL9gvEJtPhP4Sp5/zZXPHS
 C4AMSN66xQ391SFjJIWEVUXejiQGptqdyYXA2GDP4Qz3wJpYsw3H5+Ig5MR8hEFrMPGQ9DeslTW
 8f+JAHhaZN8CECc59OcGm1UR3jhIYjjMYsh6E/X/Co2OiTj0ZzyMLe7V6wUdPZBC/KvIX3rlyWQ
 ==
X-Received: by 2002:a05:6820:20d:b0:65f:5b63:2bd with SMTP id
 006d021491bc7-66d09abcd8emr4002424eaf.16.1770578815495; 
 Sun, 08 Feb 2026 11:26:55 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:55 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:31 -0700
Subject: [PATCH v2 22/24] bsd-user: Implement System V semaphore calls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-bsd-user-claude-v2-22-58e5fcfdb84f@bsdimp.com>
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
In-Reply-To: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1441; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=8FLdgu0IsMrVsvsv4WPcofKeszO26XyJbuXenbnBrnk=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONhuqdl0SKw6E/QCxY6DYP5Xz4rXhVAQRNdc
 8ZPTRIbOXuJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjYQAKCRBsHNEofbAR
 AOk5D/4uddDT4OhpKg1Gm2kKdtM31FrwjWdcLprgbK/0M/PMDkgaK6OteYfs1VfAw7ewW/maNQL
 ZUlg31+Aao6l5YbttluW72bKrZZbWQTxBYU2ejX14FTMJWWYlDVn29Yjo/UFnsDplW7/qiH0xW6
 KoPvNmSN03fs5us5PSqTyJnJ82J4scna1yFAJegF+Ga+3W3j8cyqj0bpCzEsx8MtuopUElBkAxI
 9wAeZa0U6+dxsLx5T4EYmzUhDLlwV+Ui2drvn8wvEwBPdonhfbGRQLicKekrEtnEU4HiHTRMa3b
 h1/JY0qs/gyWm3qbCviXERBKakfmzugs8TWKo/89Ee5kXyvYbWmUGbQq5/5HPtKvUfy/GdpJ9Yq
 P5mQ+oEGgpiw8beG6+IpmbVZb0AoXvfByljBIJZuvNpzgUILIQ49Ef0B72hTljK043gmS9KT4Tj
 bqkz9lYoWDgSTVNlsJ/bnQjCk4KeU17Ns8xZlKdMl5brf4FNGHLc86f3pqusTVFUPoBClm+Gm2E
 ldsbVgjXuPfAtGziKAF+PMIGkBALUvZ3nRDpYf0AyFwOutshWWdRsa19aEgLpRHc+10vV6m9GuF
 zwB+sAqkGI2g8UDc2xWnmmiigx/zNSAot68xhhE1E+sy3kyvMpNqgkmGTPkKgYGa4gBOXnCpnuc
 lyRrKvIcpLixn0Q==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22c;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Stacey Son <sson@FreeBSD.org>

Wire up semget(2) and semop(2) syscalls to get System V semaphore
implementation, as well the undocumented __semctl used to implement the
bits of the interface in libc.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index ca2f6fdb66..ecdd5d7628 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -37,6 +37,7 @@
 #include "bsd-file.h"
 #include "bsd-mem.h"
 #include "bsd-proc.h"
+#include "bsd-misc.h"
 
 /* BSD dependent syscall shims */
 #include "os-stat.h"
@@ -879,6 +880,21 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_shmdt(arg1);
         break;
 
+        /*
+         * System V Semaphores
+         */
+    case TARGET_FREEBSD_NR_semget: /* semget(2) */
+        ret = do_bsd_semget(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_semop: /* semop(2) */
+        ret = do_bsd_semop(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___semctl: { /* __semctl() undocumented */
+        ret = do_bsd___semctl(arg1, arg2, arg3, arg4);
+        break;
+    }
     case TARGET_FREEBSD_NR_freebsd11_vadvise:
         ret = do_bsd_vadvise();
         break;

-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC331CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 03:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwuhT-00077h-TB; Thu, 11 Sep 2025 23:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwuh6-00072W-SA
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 23:43:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwugw-0007wi-57
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 23:43:28 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45dcfecdc0fso13695045e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 20:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757648592; x=1758253392; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wHCEqsSTuyjVHuzvnpEWX3Ow315g/CQPHH4Fiyg5ur4=;
 b=OYZ53INyFMBOKxLOjYQK8s1JJ/TNrZwKf9R9CGC3ZWor/NX6cppVaH3cXyfLMc6pRX
 co0WC7cIDwYQUCdZYtOlcEzJILM8W4sEzPTVAm9vCD+DmivmYCjG/ng6EqgEuafv/rpS
 diL2XYhxfw9U/ocifLZGEtfhx5NTPWEG8PmwMj/S1L4ArAyxhjDEmUIf2zHSje+ISVgV
 oun5v+Gkd0HAR9COaDONJOwqq7dAsJsCgrY1cmnbwx4OBnp9Qjy0cYGAr6qVZ/KyTMES
 XF6Fdev9fGFATnkGKVhBG3go0bcTSOgo5OzdP/ywyl40W1WlKOJPr2mF3MGXG6+YO+ci
 Lrkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757648592; x=1758253392;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wHCEqsSTuyjVHuzvnpEWX3Ow315g/CQPHH4Fiyg5ur4=;
 b=hp7wkvwua3AUBwFSMGSN5JA+q7m1tCqQNB5xkKLmfRHgD9rfT6E3Ft0hMr19H9fmd/
 JcZoWUkdpTzborhubl2dsBHF+ZHPF7TukYejrOTvJqF3bujdeQU0djcaxA7bN3wilaJM
 pe5XhO3RBAhNDUSrm5KAFgG9x/cbzQwBot0IkCy2dIP5QG9NYPet4sUQi514xI29bPD/
 It35uWlPeI+XF3ZHak0bpEsqnk8tF6KizHfoGUdi072tydpkFbMzC9KecOm88DSNq88y
 zRcUPMbSFu/dURHCNKbCXOEe+Z3ILGWljjk9LQRn4dKYDZgYf8zyiKCyFlQoVIrH362o
 hhPw==
X-Gm-Message-State: AOJu0YwGVd1WDVfgcDr4NJtbTJPoqAK6YSrAP8MmMJCducoYMYy9vJV5
 0qtK+WnOFbUOqrayQGDmBGxUIkgXJKc6+vTxKOBuGSMMa9HSFNUZyDpy
X-Gm-Gg: ASbGnct+PE/CeDvfoF4oWyH1bBifTt3fFx4VpG53CWqAi2af44Y01tfGkc/d41SxDpA
 C5EGHC2JZGACUIJ2W9XT9t6HwGCz/gVcYLf8J2G5YbOFKcCqdVUU8E9qHN06q7f2RTUgKQotFSl
 TE0LlovdE4jcz+yWbe5dSHu4WQr1Upn/9LVwhcf9PQjpSNGnMsf5wkVWRJEjNfNoW7uOsQVUFRc
 BMNGB+442TB/dOb3syeIcJCGSDr8TSKWeMUDoCf5lzI1D0Ltjbgw0EeEJptiSiI6aAO2CRSwrXJ
 SLkiD1Mf6kH/yW1nMbJct9BLMdM3Ymj3ChmZpx6QgvrLU5xYvSuMzdOyosP1mEAvNH012oqb/j5
 Z8VoB98ldF+fBfrzatJNzpQX9kSRDlvd2gzli5mFXAFlXdiPQRBBwzkJG/fvuEqE=
X-Google-Smtp-Source: AGHT+IE+N8rB4NBSBETKQwk0T6NiTWgcWMbth9PlgD8UbDQIYB3SspcqPf8tWEWNgibo8loQMJQuTA==
X-Received: by 2002:a05:600c:34d4:b0:453:2066:4a26 with SMTP id
 5b1f17b1804b1-45f211d008dmr20526415e9.16.1757648591611; 
 Thu, 11 Sep 2025 20:43:11 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-45e03719235sm45757555e9.1.2025.09.11.20.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 20:43:11 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Fri, 12 Sep 2025 05:39:55 +0200
Subject: [PATCH v4 10/10] char-win-stdio: add support for terminal size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-console-resize-v4-10-7925e444afc4@gmail.com>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
In-Reply-To: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Filip Hejsek <filip.hejsek@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757648577; l=1846;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=vJHlivNruwCHO6Go3XoN9GPqzA+0DPjU+IE60JkhFcM=;
 b=yQjfu7m0PrRV0fSxnbKbvjHDkhd/ZELNUst/joqUkBDR0YEfCq2qnqFwa4n576GY+bZswOueu
 foOCIwsfSRvB5WS4IvjIMofko8F6BlUIwE4PsBMKp93IdcP/XpfCav7
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Use GetConsoleScreenBufferInfo to obtain terminal size
and set ENABLE_WINDOW_INPUT to receive resize notifications.

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char-win-stdio.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index fb802a00b13ac4089abf3bd4f8c4198d8325764b..dbffbe1d11702367d4ecfcb63fad7c3c18324ad6 100644
--- a/chardev/char-win-stdio.c
+++ b/chardev/char-win-stdio.c
@@ -44,6 +44,20 @@ typedef struct WinStdioChardev WinStdioChardev;
 DECLARE_INSTANCE_CHECKER(WinStdioChardev, WIN_STDIO_CHARDEV,
                          TYPE_CHARDEV_WIN_STDIO)
 
+static void char_win_stdio_resize(Chardev *chr)
+{
+    HANDLE hStdOut = GetStdHandle(STD_OUTPUT_HANDLE);
+    CONSOLE_SCREEN_BUFFER_INFO ScreenBufferInfo;
+
+    if (GetConsoleScreenBufferInfo(hStdOut, &ScreenBufferInfo)) {
+        uint16_t rows = ScreenBufferInfo.srWindow.Right + 1
+                        - ScreenBufferInfo.srWindow.Left;
+        uint16_t cols = ScreenBufferInfo.srWindow.Bottom + 1
+                        - ScreenBufferInfo.srWindow.Top;
+        qemu_chr_resize(chr, rows, cols);
+    }
+}
+
 static void win_stdio_wait_func(void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
@@ -75,6 +89,9 @@ static void win_stdio_wait_func(void *opaque)
                 }
             }
         }
+        if (buf[i].EventType == WINDOW_BUFFER_SIZE_EVENT) {
+            char_win_stdio_resize(chr);
+        }
     }
 }
 
@@ -202,6 +219,8 @@ static void qemu_chr_open_stdio(Chardev *chr,
         } else {
             dwMode &= ~ENABLE_PROCESSED_INPUT;
         }
+        dwMode |= ENABLE_WINDOW_INPUT;
+        char_win_stdio_resize(chr);
     }
 
     SetConsoleMode(stdio->hStdIn, dwMode);

-- 
2.51.0



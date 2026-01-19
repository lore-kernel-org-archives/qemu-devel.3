Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883A9D4A5EB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 03:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhfx8-00076E-KY; Sun, 18 Jan 2026 22:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwk-00073w-8a
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:55 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwg-0004CB-26
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:52 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-64d30dc4ed7so7284241a12.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 19:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768793329; x=1769398129; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HMXELTh73T/FqcWvF/yPL2Xnmaqf2ybpkYLwr3NQgvI=;
 b=BHW+mrxJ/0viadEkAtkv7VobnzNbH27mc9TE/RQR7UjaEX9Oiis9rcK/cavhzRmW76
 hC7i6AQf45qT3j5LRNxLgY42odsBkon9lrpCuFiW8VdWkWJo0psM+cy6GqQkCzd2tnOl
 kr34T7W6lXAYoACkt++uGqmeK5neqEYKzW9Zn6kwjJ+IQmdj+zekeNbLAZOiyH9nwgxu
 eeh3lsdIp7s9IzwRm5jDjJil/fPcFgdX1k9z6IrfjSKFWgXQef6O+hNVSijXLU99RQY3
 WxejnfCaYYLLwI8opp2KzHYVHWfvaQVOd0NsF53kVUj8X47X1x9+cWu+0boKGg+lAEbs
 I+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768793329; x=1769398129;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HMXELTh73T/FqcWvF/yPL2Xnmaqf2ybpkYLwr3NQgvI=;
 b=eYH7ku0a6dMwUfHeGBILv7jxeJuvhdc0XmL4svD+T3hIpK5i6yoo/kdGVXf4QvVqIF
 JGS6E9qb6r0wxzYYV6hOCk2sdbiOjXR6A01L2J1YshC75vhgpetHa39/PeKXYBSkW+UJ
 4Sy5h1LEOKzNngqg3bvWMsbckKGY98237hM7/tsY0n/qSJvqd7/KDKdGduUOxaUA+XBV
 k6arkbMS+QhwubSADnW8A/xStomjUd3E/i73S5/INRSCvba3eJMTuGU6eQodaJ0WzD2u
 /aMNUc1FXF3VU4GK2yz6mtO0o2tJn/fd4540OcfrU48FXQtm/CF65PdfwTiuHhnf903S
 8IYg==
X-Gm-Message-State: AOJu0YwMkLf7J0gdlfZ1cwWOC+Ppd4uQVvy3BYtIHtwFY1+E8qHpJY3z
 BuE37cMLtQbYn/VipxHU+4cruSpadkE9e1/+7ra36/cB2YnsaVYKzxl0
X-Gm-Gg: AY/fxX7lDEvtvjRFg1lfGiDAYP2mWXhLG04exG4z1ZUficOk8+xrgVsVUvoDJ0Lsvp0
 OYy6xO4jMXyCMQxCGsEWOzBYseOuiZEjyI1Rh3poYF78xjEG6uzhSyeW4OE01mrB+oo58yOxZae
 v6GdTYrFkxjMHmJQW+D8KWIUffL4dSaDD4SjMsIDwsQKeM9tZl+OoELaKaAeNc5RZtGnjFq1Lkh
 jzTVMMTP1Yc4iNxQTlwA8o8Lf1vZDhEZqILJyWS2dUvLba5H/6tPGuuBEwibl7hS1FUpEe+S57k
 MdPUCu2xH7MDPETg7PmnMRVbJVbfNJ6JPaIICtivZR/TzxvZ0ZGM4Gn9k+s64Y7WHBaZaAolQL4
 jdQnL/fqOjdN4K4yeH32ej56MOBvHfJ0BO0xfuhTt8/8BAa4dM35v3frB7CSuRN/tyBjqEIBhXv
 ywM7d3P/Fh1w27+b8xJI9i4bJDIRMxriTXPv52ZsPS
X-Received: by 2002:a17:907:97ca:b0:b87:d09c:182c with SMTP id
 a640c23a62f3a-b87d09c1a61mr236340766b.21.1768793328575; 
 Sun, 18 Jan 2026 19:28:48 -0800 (PST)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm8695897a12.19.2026.01.18.19.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 19:28:48 -0800 (PST)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 19 Jan 2026 04:27:53 +0100
Subject: [PATCH v6 10/12] char-win-stdio: add support for terminal size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260119-console-resize-v6-10-33a7b0330a7a@gmail.com>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
In-Reply-To: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768793314; l=1842;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=dQSyY1EivjruPsWTiEY+498atfS47c91YdJNmIagRdU=;
 b=Y50NTGPmojPnxbnUzlk9Vl6GfNs2xDelDUVoLvu4nSYn+YdaZ7RHOC7K+NgX7ugZVFmND8YEY
 yX155uMrlfKDkW+FdtlNc252mWYbbEIFpogb4o95rVevpZtCeExZpCj
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ed1-x536.google.com
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

Use GetConsoleScreenBufferInfo to obtain terminal size
and set ENABLE_WINDOW_INPUT to receive resize notifications.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char-win-stdio.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index fb802a00b1..0d33138d0d 100644
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
+        uint16_t cols = ScreenBufferInfo.srWindow.Right + 1
+                        - ScreenBufferInfo.srWindow.Left;
+        uint16_t rows = ScreenBufferInfo.srWindow.Bottom + 1
+                        - ScreenBufferInfo.srWindow.Top;
+        qemu_chr_resize(chr, cols, rows);
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
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B15D5AE7C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 09:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8z8G-0005Fs-Tn; Thu, 07 Nov 2024 04:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t8z8F-0005Fc-0W
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 04:48:51 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t8z8D-0003un-7f
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 04:48:50 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3e602a73ba1so488278b6e.2
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 01:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1730972927; x=1731577727;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k8+sL3/NnUjknDx8O8NturBZXTqKMlru/+CvoMSlw0o=;
 b=a0efUspesCV6MCC1scTY1U0MrDDtfJQX4mVryiG83Cl4JbUEKqBVDei04GkwL8tj/M
 oi4Pmz/cWj8EtZyZIFwm5ArnhiYxWrojk1XG4TENZ4uMuhor5VstCaYmPpWGy9YOID2M
 Pvx3Aa339KrKZN13mha+KysIjrXIfS5gohPD6mVd1otO55ImsZQjysI/LVtFnLAwEsns
 cxKjdgZ8I3AWmdt8hFHMsrq30X9X0e656DBrTevpoUu96BBhuSqZ+DoW9QykZKvXIVDX
 BqXxTXv8l5aHhwFZ4CyL+c+PcvCY7b0ZJshFynqW+Ec9i/DdZHC6dsG8Ty9BI5aSFCMb
 0DAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730972927; x=1731577727;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k8+sL3/NnUjknDx8O8NturBZXTqKMlru/+CvoMSlw0o=;
 b=YmQ7/Muh6nn1K9rGW/uO36yJQVBHNzKvCmZm4IAqn1fS1cXMWMj3a4q+Ifd3xnnBLE
 pTMLOqzko0KzgBtRpeJXbt6dnhf4fZ7B8Mjlect8Oo2ImPkw32Q5JP89JaKE2RbxkcCo
 0Oq/f26mORMs4DRBuNrddGlQlaLBDbV8hV+oV4CYPXfcbLN4+82oKTbBql/xQF90s5Nf
 0R9GXBaLE0qsQNrAI/Z2WHYUGuryi2c1+g+l2G8QfXTcz86BFQCXBpCQEr89H8W7bsk4
 hO1vJ0uQbrWhoq1EDNIbYXtMoipf3KwJwLV2QGhmUil/fzHP9xkp0o81ggykEzNjm23f
 nRow==
X-Gm-Message-State: AOJu0YxeMtRNKMsXYLwPPO7ybb24QvaAuzM9OodxuoT+ELbZ0BUKzb0h
 m51HM31E0Z68qBjsVZ3d7N8DhrYSJcdm02pUINjWN+zlihn+41iNaPvK6MbVK6w=
X-Google-Smtp-Source: AGHT+IERVcXKFct4rwP6ZJ5IRaqE/4n/2Eug+/Zn685tGZHc6GvH2pWHbH/4DQVcN+zK4FOKpXSoqQ==
X-Received: by 2002:a05:6808:e88:b0:3e5:cf3b:4fc5 with SMTP id
 5614622812f47-3e78fcb7b36mr546436b6e.15.1730972927082; 
 Thu, 07 Nov 2024 01:48:47 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-7f41f5bcaadsm980699a12.24.2024.11.07.01.48.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 01:48:46 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 07 Nov 2024 18:48:44 +0900
Subject: [PATCH] tap-win32: Ignore keys too long
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-win32-v1-1-952d508e2546@daynix.com>
X-B4-Tracking: v=1; b=H4sIAPuMLGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQwNz3fLMPGMj3SSLNIMUQ9NkS0MjIyWg2oKi1LTMCrA50bG1tQACaFM
 dVwAAAA==
To: Jason Wang <jasowang@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::22f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22f.google.com
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

Registry keys get truncated and trigger -Wformat-truncation. Ignore
such truncated keys as they are invalid.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/tap-win32.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/net/tap-win32.c b/net/tap-win32.c
index 7edbd7163370..4081ba87991f 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -239,8 +239,12 @@ static int is_tap_win32_dev(const char *guid)
             return FALSE;
         }
 
-        snprintf (unit_string, sizeof(unit_string), "%s\\%s",
-                  ADAPTER_KEY, enum_name);
+        len = snprintf(unit_string, sizeof(unit_string), "%s\\%s",
+                       ADAPTER_KEY, enum_name);
+        if (len >= sizeof(unit_string)) {
+            ++i;
+            continue;
+        }
 
         status = RegOpenKeyEx(
             HKEY_LOCAL_MACHINE,
@@ -338,10 +342,13 @@ static int get_device_guid(
             return -1;
         }
 
-        snprintf(connection_string,
-             sizeof(connection_string),
-             "%s\\%s\\Connection",
-             NETWORK_CONNECTIONS_KEY, enum_name);
+        len = snprintf(connection_string, sizeof(connection_string),
+                       "%s\\%s\\Connection",
+                       NETWORK_CONNECTIONS_KEY, enum_name);
+        if (len >= sizeof(connection_string)) {
+            ++i;
+            continue;
+        }
 
         status = RegOpenKeyEx(
             HKEY_LOCAL_MACHINE,
@@ -617,10 +624,11 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
     if (rc)
         return -1;
 
-    snprintf (device_path, sizeof(device_path), "%s%s%s",
-              USERMODEDEVICEDIR,
-              device_guid,
-              TAPSUFFIX);
+    rc = snprintf(device_path, sizeof(device_path), "%s%s%s",
+                  USERMODEDEVICEDIR, device_guid, TAPSUFFIX);
+    if (rc >= sizeof(device_path)) {
+        return -1;
+    }
 
     handle = CreateFile (
         device_path,

---
base-commit: 7e3b6d8063f245d27eecce5aabe624b5785f2a77
change-id: 20241107-win32-b8f0d15c9122

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>



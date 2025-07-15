Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2566DC83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 08:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubb9F-00028X-7o; Tue, 15 Jul 2025 04:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubb8V-0001yI-1q
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:35:45 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubb8L-00018X-4O
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:35:31 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-455e6fb8057so38701325e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 01:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752568524; x=1753173324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ujuou/HsTIGGpDNPzNhDAwqfl7NDEvYALLAeh9IYtoA=;
 b=UgDPqybRFKp/8JOXC8KOernl4HaKMJ5K9gOknQKsLKDWWmtiE3qXvITKKbpiQMe8Wo
 fnvPsJSazR8GbUmHby4jKzwv0HvWsiSNYfxwqIeqIJ3mGGSm6o7Ek4yTOB2yxQsQzw08
 dhZgLhuf/oZTPZWJrYRytsZbdJUCbvPlUNQfnGPvmAhzzF+eZSwFO+O/ed+MmD15yAKy
 RloN2RrJqP/ru04WqOYvTQJ56hw5MTeT8vDf+lL9cc7LEDTJnp/xWJbrT8SkqUfYfUFE
 SsEJanwq8NkK3P8n9ftosqERSi3rwDuFP6kyM+IcvTRgdjKSS/wMtUoRNZcdbml5nV8r
 B48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752568524; x=1753173324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ujuou/HsTIGGpDNPzNhDAwqfl7NDEvYALLAeh9IYtoA=;
 b=IECgFL8DbA+800HHB5fsifkiM2GQCWFE6TT61/8rGOnGW3hWKekQA5R2Q0JrxJQ9aB
 +Tv8YxNM7Biu7atv5VEKYeW2hrShWqwtXLuqEgUZtA7z3IjZGXSwAf/chWr8esZWhek4
 b10nB0O5+GLmJBxUpJFhaVjj8F9usWNjyqj3wFbcOdJ2Nen/Oqt6/TgZR5TRHNFzqqxZ
 WQRWPDD9uJwJgT9HgEt/5OK7tRKEPHdOidfT26g9LvkIb7icvUJtqPlLu5W2FSaXmN35
 DLyHVDhbWgepOEoafkyyXYP5F8rB3nRN4XorgxQ5IN/aamrKlBpqEeMFDFbTKNvaq0iu
 6pNQ==
X-Gm-Message-State: AOJu0Yx5QAIeM0f2XQ/OMoBrtSq4H68NL2xBjCMgmpFU7udpe52BnHXJ
 onXHr8jVHc5cvsf9IeWhAxhccKWv8boht5NzGqAqKq9zJGnYo0DOm8aepNRGc4v5PtQLfG0C8Eu
 FpgBY
X-Gm-Gg: ASbGncsx3N8GOgpDSCtw3v4ZsthdVovNNXkG5wbbSQgQpDsFRcehOP9LMWvp/n6EEHq
 TQyQnv/LfmNjlqxlPk5LXsnCXfJZlqO+E3PcovQypfsgtAogjTB0tLc+zw+EOYRIrpoZg/bgvZc
 wBIHaZSJ/K4/xjlISs4UneahBsXnNfTE/5PRKTog4X7pwmLlZJ8272yWrYni4CJXPYd6yDHq8mv
 /56DlNNiI0YglIY2a9rm4QB0k+m3r2NjLJL7tSRhABBWNGmIBlGOVyPdBwCFyzIcG82Fwb7RA1R
 mqhCRK6NvRCP77AezLGULCyhaUcws8Fm820fZnmK3vF4pHkwIYdN6AQ63Bn0Trj1tSuqWKllxML
 TPISRzINMQMaFI4Gpke9PV447K82SbnPf2rPd5ZTCDcD7UClfBcVH17otrlavhVe0ic3Z6oLDai
 KZcg==
X-Google-Smtp-Source: AGHT+IHub3xmY1zG20qfMDkSjz6h4cIuZQVlmu4Oxi3QqDA6BUJd9+mUsSwG4XQ5UKK2mcN+zCNdcw==
X-Received: by 2002:a05:600c:8b84:b0:456:28d4:ef1 with SMTP id
 5b1f17b1804b1-45628d40fdcmr10803625e9.29.1752568524290; 
 Tue, 15 Jul 2025 01:35:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560f22cd29sm84291485e9.34.2025.07.15.01.35.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 01:35:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 1/2] system/os-win32: Remove unused Error** argument in
 qemu_socket_unselect
Date: Tue, 15 Jul 2025 10:35:16 +0200
Message-ID: <20250715083517.47556-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715083517.47556-1-philmd@linaro.org>
References: <20250715083517.47556-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

@errp is always NULL. Remove it, as unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/os-win32.h | 2 +-
 io/channel-socket.c       | 4 ++--
 util/oslib-win32.c        | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/system/os-win32.h b/include/system/os-win32.h
index 3aa6cee4c23..40712a948c3 100644
--- a/include/system/os-win32.h
+++ b/include/system/os-win32.h
@@ -172,7 +172,7 @@ static inline void qemu_funlockfile(FILE *f)
 bool qemu_socket_select(int sockfd, WSAEVENT hEventObject,
                         long lNetworkEvents, Error **errp);
 
-bool qemu_socket_unselect(int sockfd, Error **errp);
+bool qemu_socket_unselect(int sockfd);
 
 /* We wrap all the sockets functions so that we can set errno based on
  * WSAGetLastError(), and use file-descriptors instead of SOCKET.
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 3b7ca924ff3..6ee6217e7ac 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -454,7 +454,7 @@ static void qio_channel_socket_finalize(Object *obj)
             }
         }
 #ifdef WIN32
-        qemu_socket_unselect(ioc->fd, NULL);
+        qemu_socket_unselect(ioc->fd);
 #endif
         close(ioc->fd);
         ioc->fd = -1;
@@ -890,7 +890,7 @@ qio_channel_socket_close(QIOChannel *ioc,
 
     if (sioc->fd != -1) {
 #ifdef WIN32
-        qemu_socket_unselect(sioc->fd, NULL);
+        qemu_socket_unselect(sioc->fd);
 #endif
         if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_LISTEN)) {
             socket_listen_cleanup(sioc->fd, errp);
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index b7351634ece..7ac3482d449 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -180,7 +180,7 @@ static int socket_error(void)
 void qemu_socket_set_block(int fd)
 {
     unsigned long opt = 0;
-    qemu_socket_unselect(fd, NULL);
+    qemu_socket_unselect(fd);
     ioctlsocket(fd, FIONBIO, &opt);
 }
 
@@ -313,9 +313,9 @@ bool qemu_socket_select(int sockfd, WSAEVENT hEventObject,
     return true;
 }
 
-bool qemu_socket_unselect(int sockfd, Error **errp)
+bool qemu_socket_unselect(int sockfd)
 {
-    return qemu_socket_select(sockfd, NULL, 0, errp);
+    return qemu_socket_select(sockfd, NULL, 0, NULL);
 }
 
 int qemu_socketpair(int domain, int type, int protocol, int sv[2])
-- 
2.49.0



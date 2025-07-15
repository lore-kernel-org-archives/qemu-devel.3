Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FFBC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 08:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubb8t-00023S-H0; Tue, 15 Jul 2025 04:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubb8X-0001yS-4W
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:35:45 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubb8P-00019P-R4
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:35:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-455b002833bso11984035e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 01:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752568529; x=1753173329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sRy+AMpNOj3F4ZhL8KgKFbhnzxvnn58SBVMlcANxWwo=;
 b=jKgCucwy1/7DIZLBE2bVv6g5D6a1u8GvlGZJnS+68Mt+jT7v4v0a+vxHovqBec3vgV
 TjwQEDd/RW724qM9LfIdHQasRd7xRc0e+pJgRMhMrMesIHd+gqx2By3tWMw8dZKABu5x
 v4TPHGCMD1cCnDsF8SDdMinhl8iq01LxRPmeQgx4zVKEotL0A0zgItPP4Wnjj+M/yUsj
 GOfxpLxZW/r7SkRPkdMVHsVBQRpSY9R1d+SQD0EPCljTLz0m4Clw7GcMviPrFK8pzTRj
 hM/l+1KhnaaG+2ts4ZnGWUmL1YjzNINibWmE7WZJAhj6YPoPNzMXn5yy0fKmE87LJTXY
 L1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752568529; x=1753173329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sRy+AMpNOj3F4ZhL8KgKFbhnzxvnn58SBVMlcANxWwo=;
 b=SejrSst1pf61NY8DRZT/NEMAuNpmT23jcYadV4tAGgxZ3/9LiPjpWnl0GYorBx+HZj
 P7YATadyMl9NZE2vr1aLi2/dMSbjQ3rqzBhAtTCsmip3Av7pTiYrb9p8aQEpLI5n+VOU
 d+OnjnVqReR/8s1ybf2W8LggQT9KPfiOH9KX9OSa8KD3wp83YCf75GffYvcvaG/2HJl1
 ux3C3wTnT9ZmQKBbZiMa/5gF1CjjHqG98R2CFapMMlNamr7FG091l3DcXVk0zgkVbbwB
 t1Ez6PT+YGfDnhg8xh2jyYAUJArRPF89g7i/vHTpaJrc3M7CdpgYpw8/2nCeImqtpIEv
 YefQ==
X-Gm-Message-State: AOJu0YxzRVAOxIlhdcVNnEigXUhwl6yuDUNdfvaJOFkZJen4KVvZc3ux
 LwvF1mKlrLzI24FpzhqudBeqDPBeWKzQDfrZZ/LOgqF54RFeWbzzx8pGOxgsV8+MwGpTbR17p5d
 8fP7f
X-Gm-Gg: ASbGncuavuatTW4SMleua6W9WYOUb+6FLfM6lvPyJlUuwaopFZS/gp7Hujg5vUTlyyC
 Mr9CuvHDrGH/oDvv+eqCbrULNd7Bkrs1gzydFXNOYsPJN73K5YNHIbrHw6rVRS0mxSp6p3808pA
 A5yASCiPAIqH4VHuYGSiS7MRErfTEBL5/5vR9rm+SVyo7RJznM9sr63aFSFBrliOG/PtvpcenOI
 XqdqwWeeRZQBUy6wLM25W3IOqEnsvQR3ErySmSpQu+/CSHqp0aLdgj1LDssro/phMxholom7KYw
 mNAHlD1k2u0pG0Dnj1qqxKR4PHaYxs6Nr1JJiq1l9zgJZTeoNuS+wrLymI5xlPvLKGQ3SMmjiwz
 GHepjzXiF9WsrmnVv+ocfoPdgWacJGEic6qjHWtkUZ2YV4Wkk/hSAYN2M+5AI1WP5TUDxJUnZnA
 YWKA==
X-Google-Smtp-Source: AGHT+IGtOnE7bEu1nBbJG3vMCT/r6OW9M/BDk+GzDX7BvKcqB3+vuiB4YVURHiKGzqDDlT9+o6BKcA==
X-Received: by 2002:a05:600c:3b84:b0:442:e9eb:cba2 with SMTP id
 5b1f17b1804b1-456270595f5mr19264185e9.0.1752568529170; 
 Tue, 15 Jul 2025 01:35:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd241210sm156330475e9.0.2025.07.15.01.35.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 01:35:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 2/2] system/os-win32: Remove unused Error** argument in
 qemu_socket_select
Date: Tue, 15 Jul 2025 10:35:17 +0200
Message-ID: <20250715083517.47556-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715083517.47556-1-philmd@linaro.org>
References: <20250715083517.47556-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

@errp is always NULL. Remove it, as unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/os-win32.h |  2 +-
 util/aio-win32.c          |  2 +-
 util/oslib-win32.c        | 13 +++++--------
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/system/os-win32.h b/include/system/os-win32.h
index 40712a948c3..47882bc2f49 100644
--- a/include/system/os-win32.h
+++ b/include/system/os-win32.h
@@ -170,7 +170,7 @@ static inline void qemu_funlockfile(FILE *f)
 
 /* Helper for WSAEventSelect, to report errors */
 bool qemu_socket_select(int sockfd, WSAEVENT hEventObject,
-                        long lNetworkEvents, Error **errp);
+                        long lNetworkEvents);
 
 bool qemu_socket_unselect(int sockfd);
 
diff --git a/util/aio-win32.c b/util/aio-win32.c
index 6583d5c5f31..9c2f0fb86e7 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -121,7 +121,7 @@ void aio_set_fd_handler(AioContext *ctx,
 
         QLIST_INSERT_HEAD_RCU(&ctx->aio_handlers, node, node);
         event = event_notifier_get_handle(&ctx->notifier);
-        qemu_socket_select(fd, event, bitmask, NULL);
+        qemu_socket_select(fd, event, bitmask);
     }
     if (old_node) {
         aio_remove_fd_handler(ctx, old_node);
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 7ac3482d449..fed5ab14efb 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -292,21 +292,18 @@ char *qemu_get_pid_name(pid_t pid)
 
 
 bool qemu_socket_select(int sockfd, WSAEVENT hEventObject,
-                        long lNetworkEvents, Error **errp)
+                        long lNetworkEvents)
 {
     SOCKET s = _get_osfhandle(sockfd);
 
-    if (errp == NULL) {
-        errp = &error_warn;
-    }
-
     if (s == INVALID_SOCKET) {
-        error_setg(errp, "invalid socket fd=%d", sockfd);
+        error_setg(&error_warn, "invalid socket fd=%d", sockfd);
         return false;
     }
 
     if (WSAEventSelect(s, hEventObject, lNetworkEvents) != 0) {
-        error_setg_win32(errp, WSAGetLastError(), "failed to WSAEventSelect()");
+        error_setg_win32(&error_warn, WSAGetLastError(),
+                         "failed to WSAEventSelect()");
         return false;
     }
 
@@ -315,7 +312,7 @@ bool qemu_socket_select(int sockfd, WSAEVENT hEventObject,
 
 bool qemu_socket_unselect(int sockfd)
 {
-    return qemu_socket_select(sockfd, NULL, 0, NULL);
+    return qemu_socket_select(sockfd, NULL, 0);
 }
 
 int qemu_socketpair(int domain, int type, int protocol, int sv[2])
-- 
2.49.0



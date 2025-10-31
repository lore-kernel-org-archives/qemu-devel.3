Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DC8CCFA00
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 09:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElCw-0004E7-Un; Fri, 31 Oct 2025 05:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vElCv-0004Du-0u
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:14:05 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vElCr-0000Mf-7m
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:14:04 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-475dd559b0bso26316155e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 02:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761902033; x=1762506833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DnF9TrhQF4mGpbbEW8vk40DmB7TZGaqpJ23naRKT9B0=;
 b=uN81f7bSpr8UY7OOf6DTRG7NJEykz+o09FxUX7CQfjjLAktTOI3g0by7WOcdzhGqD/
 tVCnUWt9YElkoRDfTtTkYlxpCUhERdh6hzSiuUtScwAw3fPmKNDbARLEHznPU5x90hp0
 u0Gt7+1oD+0pARRpp5DL2SV7NLrlTTlJ35kFtc/W49jM/Oft7UUPoULyraQpIbA8vFs5
 H7SSYDfkhqbI4uGafRVwW9zp1vqJGwgHWnGpgyVizbqQXbGoCROR8wvTofllLEfrqaQy
 b8OHmZiIyD/5lqFcZusYbJnKU7m7wbYxGcQw/6C1YI/OsQ2w0Ssy71RdfEp0D7OkDHrl
 rUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761902033; x=1762506833;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DnF9TrhQF4mGpbbEW8vk40DmB7TZGaqpJ23naRKT9B0=;
 b=xCd4D5DlSKFjq8+FdDbrxoqfjdDXvyXXGQc4qHHAW0Av9sLv+Nr5jnik3fHVf0TD1u
 jpLFQkI0h27LCq6gvTsA4j1uodHgTndpJPRmqZu8qBfMXrzv7fbBj1uQuu/5SQtZnL0A
 QMJI2tC6uRlbwhSeXFgiEaKrMaM3NKMpKAeffDB9YZIkJvRSCzLM2K9dK3NsIi/R8zdE
 pX2DGiVbOsD+txQJDQfTja9HQskHTTSngfa/wWc44luHxhEWped+FvrzLrlE5RH9AlpH
 2GJlweS58R6HMwf3PxtgWY8sjfq9I+vIfq0wn+JVivH86WOKhPfkh6bj1NZDPdvRwIwK
 8zQg==
X-Gm-Message-State: AOJu0YxD5iIE2kp59KENuzTL+IJrXSJ1D+xGn0NF2EDP23bPbExJTs7f
 foffSOkKfj796C4WoOon3xIOJV9/MA/CMVnnKYVfXC62H7mwVqVHUpZFN2UsTHQs7GY5BctO6ku
 5NzLBBqDbP1SX
X-Gm-Gg: ASbGncsPBRbEiHOkmkatbV2LhPk6cvGPZ1cEWrujLWj/cf7PDQF+oEJxXjTs656o3iH
 svF+ySmNQ+S9dibJXPdXDq91zliYoH9lwlNf+ebe/czGYiZFIAuC28WI9KauI8RzEantt5aIWus
 LwZVNSLKOpHO69I3L3bYKx0P8LN1kKv6zxcxgKpOJHEH/CbBvfQ2DxDz4ESkugXVH4DyGcfe1gT
 ka+leEE9V7lUCcZ8LcIa2NeoxOIklWE/pbq/ZwzJCkLHP5tnMOQYSbl6nQPSWzubF87OwJ1hQS+
 BkV05qEWlK4eyVLTlEe/sGY91hrP0I5A4t6JDnqefaQD/FFke1Hdug+/ZF6THEpaC6x3vqmcQfN
 MmEFtIcSnUKcPdILidacKqtjR7d5pve3BzBOcWfqwGImu43ram9NBcBO6M1PQ0iwaq5795Bl0/b
 nzM4EYWwtEXMv8NT9QhTV+lpgwYJEoQrZsXnZXhkYN6NEzREhI
X-Google-Smtp-Source: AGHT+IGg9sWhRYmKz7i5SyV00AjVZbpy7ju6vXFd9M08cEDD7sLYWiMhNdO/tmhBSJjVV8muQ8NRrw==
X-Received: by 2002:a05:600d:434c:b0:477:b93:a7b8 with SMTP id
 5b1f17b1804b1-477328b8fdfmr12703645e9.8.1761902033430; 
 Fri, 31 Oct 2025 02:13:53 -0700 (PDT)
Received: from pc56.home (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477289adc18sm87828195e9.6.2025.10.31.02.13.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Oct 2025 02:13:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] io/channel: Have read/write functions take void * buffer
 argument
Date: Fri, 31 Oct 2025 10:13:51 +0100
Message-ID: <20251031091351.27625-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
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

I/O channel read/write functions can operate on any area of
memory, regardless of the content their represent. Do not
restrict to array of char, use the void* type, which is also
the type of the underlying iovec::iov_base field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/crypto/tlssession.h |  4 ++--
 include/io/channel.h        | 14 +++++++-------
 io/channel-tls.c            |  4 ++--
 io/channel.c                | 14 +++++++-------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
index 2e9fe11cf6e..28e419681e4 100644
--- a/include/crypto/tlssession.h
+++ b/include/crypto/tlssession.h
@@ -199,11 +199,11 @@ int qcrypto_tls_session_check_credentials(QCryptoTLSSession *sess,
  * These must return QCRYPTO_TLS_SESSION_ERR_BLOCK if the I/O
  * would block, but on other errors, must fill 'errp'
  */
-typedef ssize_t (*QCryptoTLSSessionWriteFunc)(const char *buf,
+typedef ssize_t (*QCryptoTLSSessionWriteFunc)(const void *buf,
                                               size_t len,
                                               void *opaque,
                                               Error **errp);
-typedef ssize_t (*QCryptoTLSSessionReadFunc)(char *buf,
+typedef ssize_t (*QCryptoTLSSessionReadFunc)(void *buf,
                                              size_t len,
                                              void *opaque,
                                              Error **errp);
diff --git a/include/io/channel.h b/include/io/channel.h
index 0f25ae0069f..db893a36288 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -437,7 +437,7 @@ ssize_t qio_channel_writev(QIOChannel *ioc,
  * a single memory region.
  */
 ssize_t qio_channel_read(QIOChannel *ioc,
-                         char *buf,
+                         void *buf,
                          size_t buflen,
                          Error **errp);
 
@@ -453,7 +453,7 @@ ssize_t qio_channel_read(QIOChannel *ioc,
  * single memory region.
  */
 ssize_t qio_channel_write(QIOChannel *ioc,
-                          const char *buf,
+                          const void *buf,
                           size_t buflen,
                           Error **errp);
 
@@ -475,7 +475,7 @@ ssize_t qio_channel_write(QIOChannel *ioc,
  *          without data, or -1 on error
  */
 int coroutine_mixed_fn qio_channel_read_all_eof(QIOChannel *ioc,
-                                                char *buf,
+                                                void *buf,
                                                 size_t buflen,
                                                 Error **errp);
 
@@ -495,7 +495,7 @@ int coroutine_mixed_fn qio_channel_read_all_eof(QIOChannel *ioc,
  * Returns: 0 if all bytes were read, or -1 on error
  */
 int coroutine_mixed_fn qio_channel_read_all(QIOChannel *ioc,
-                                            char *buf,
+                                            void *buf,
                                             size_t buflen,
                                             Error **errp);
 
@@ -514,7 +514,7 @@ int coroutine_mixed_fn qio_channel_read_all(QIOChannel *ioc,
  * Returns: 0 if all bytes were written, or -1 on error
  */
 int coroutine_mixed_fn qio_channel_write_all(QIOChannel *ioc,
-                                             const char *buf,
+                                             const void *buf,
                                              size_t buflen,
                                              Error **errp);
 
@@ -595,7 +595,7 @@ ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
  * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
  *
  */
-ssize_t qio_channel_pwrite(QIOChannel *ioc, char *buf, size_t buflen,
+ssize_t qio_channel_pwrite(QIOChannel *ioc, void *buf, size_t buflen,
                            off_t offset, Error **errp);
 
 /**
@@ -631,7 +631,7 @@ ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
  * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
  *
  */
-ssize_t qio_channel_pread(QIOChannel *ioc, char *buf, size_t buflen,
+ssize_t qio_channel_pread(QIOChannel *ioc, void *buf, size_t buflen,
                           off_t offset, Error **errp);
 
 /**
diff --git a/io/channel-tls.c b/io/channel-tls.c
index ce041795c19..b0cec27cb9c 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -26,7 +26,7 @@
 #include "qemu/atomic.h"
 
 
-static ssize_t qio_channel_tls_write_handler(const char *buf,
+static ssize_t qio_channel_tls_write_handler(const void *buf,
                                              size_t len,
                                              void *opaque,
                                              Error **errp)
@@ -43,7 +43,7 @@ static ssize_t qio_channel_tls_write_handler(const char *buf,
     return ret;
 }
 
-static ssize_t qio_channel_tls_read_handler(char *buf,
+static ssize_t qio_channel_tls_read_handler(void *buf,
                                             size_t len,
                                             void *opaque,
                                             Error **errp)
diff --git a/io/channel.c b/io/channel.c
index 852e684938c..8e8bd2efa84 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -310,7 +310,7 @@ ssize_t qio_channel_writev(QIOChannel *ioc,
 
 
 ssize_t qio_channel_read(QIOChannel *ioc,
-                         char *buf,
+                         void *buf,
                          size_t buflen,
                          Error **errp)
 {
@@ -320,7 +320,7 @@ ssize_t qio_channel_read(QIOChannel *ioc,
 
 
 ssize_t qio_channel_write(QIOChannel *ioc,
-                          const char *buf,
+                          const void *buf,
                           size_t buflen,
                           Error **errp)
 {
@@ -330,7 +330,7 @@ ssize_t qio_channel_write(QIOChannel *ioc,
 
 
 int coroutine_mixed_fn qio_channel_read_all_eof(QIOChannel *ioc,
-                                                char *buf,
+                                                void *buf,
                                                 size_t buflen,
                                                 Error **errp)
 {
@@ -340,7 +340,7 @@ int coroutine_mixed_fn qio_channel_read_all_eof(QIOChannel *ioc,
 
 
 int coroutine_mixed_fn qio_channel_read_all(QIOChannel *ioc,
-                                            char *buf,
+                                            void *buf,
                                             size_t buflen,
                                             Error **errp)
 {
@@ -350,7 +350,7 @@ int coroutine_mixed_fn qio_channel_read_all(QIOChannel *ioc,
 
 
 int coroutine_mixed_fn qio_channel_write_all(QIOChannel *ioc,
-                                             const char *buf,
+                                             const void *buf,
                                              size_t buflen,
                                              Error **errp)
 {
@@ -475,7 +475,7 @@ ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
     return klass->io_pwritev(ioc, iov, niov, offset, errp);
 }
 
-ssize_t qio_channel_pwrite(QIOChannel *ioc, char *buf, size_t buflen,
+ssize_t qio_channel_pwrite(QIOChannel *ioc, void *buf, size_t buflen,
                            off_t offset, Error **errp)
 {
     struct iovec iov = {
@@ -504,7 +504,7 @@ ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
     return klass->io_preadv(ioc, iov, niov, offset, errp);
 }
 
-ssize_t qio_channel_pread(QIOChannel *ioc, char *buf, size_t buflen,
+ssize_t qio_channel_pread(QIOChannel *ioc, void *buf, size_t buflen,
                           off_t offset, Error **errp)
 {
     struct iovec iov = {
-- 
2.51.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93516C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 15:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1oAr-0001zS-8B; Mon, 07 Apr 2025 11:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u1nlT-00025q-Py; Mon, 07 Apr 2025 10:47:55 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u1nlR-0001eB-7e; Mon, 07 Apr 2025 10:47:55 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22403cbb47fso46962625ad.0; 
 Mon, 07 Apr 2025 07:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744037271; x=1744642071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=maq8DmxjYyAbXMCny/cpZJZoQ4BH2LZVoK9JgpK4scU=;
 b=JT3Jvq91ncdL7Bdern5imau181sn7b6+oqdhh9jp+pI1bDLa3RdQVw//+AdTzugYX6
 g573ENQEsvCpV1XRSSO8c0FKYdvau8Y1TeORt2uZjHrTi4RhW1i0vMDCY4MLtLC3T2dn
 Km1YQ33t8CV5BbUe0gpTTvSqC06KU6sfJEAmJGRn3p+0qFdMEs3l1slTrkTk2BSmu3bx
 OkW3yLTP20QBhY6+9wXlHIfEdRnhl+jg4jPVa2ODfkRTlOnaecII7y8aURmoR8daPx+K
 wuCoC4V378Kjz0NUBMaTOPDX0TfntDUwneU0xGaIq+fT/DuoBlmJRG+gySOmHk3wokti
 VWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744037271; x=1744642071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=maq8DmxjYyAbXMCny/cpZJZoQ4BH2LZVoK9JgpK4scU=;
 b=Kiw9Cvw4IePuqZ3VC25lUUnRnH0V/rYiPUNsyU9ktwn4iewKZuKC6y9Mk2LI7NqD/E
 /g0Z3qedKzT8D5z+lcAEs2qdKRh7zH4VM4MPTrJlv+TTfyexcOauLgHvP7g8NyKKOIo1
 EN3p4YEjjwwd5IvhXpnAzHHCGEXuRPbJdIU08aScoep8BV4VAx0hNWfVjP8ZBrA4Ug/v
 zFDzHbezfitj8bqVoI+yoPoYLc2iSOOcApJMPth+8OsZkstFho918qGdQihMwGyy+2WC
 esb8Qw8ZmShUf7XIWnx4tQgzmD8Uq9bEXwi/eu+oI3vT0hcWFNDnsgMqHJFJHbdBJzhG
 rKPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWJ1Wy7PDSB1EjVBKe1DXmKEnJgu2X+lE3vPAxvbAEJ5YltfOu5ezzgco4+OS6PE135w5hqSZdQH/8HQ==@nongnu.org,
 AJvYcCX3HMvDpEXZyjghps2RKngTueRNbqGG2a2DHYU9gbvRGPMugJ74ZCLXv3HefCSn8o/XxInT4oV6JdtLeA==@nongnu.org,
 AJvYcCXUJZl/Z5Nc2lFNBZFnb52IaTvzPL5FafustHW0svlhi13Srqqry+tsyKm96DPnuFJ+E2SdZDvaYw==@nongnu.org
X-Gm-Message-State: AOJu0YziTb4E5Z4NrYRFXQpaKmPvWhdqhqZJKFxJHj2+RHNsBz7+D0uu
 3X5MDz2L/USPK+xmJ5vgRr9qPyMiM4M6ipI76u5MWlyDiNveZXaixT56WCiq
X-Gm-Gg: ASbGncvelCBAexKP/mjmcQATGrW4Vmh57BOF+Tvw3pv6tdL14bvWy7Hrx0/2L2Qimma
 2jDID+C8Qf3fMFnN8DQ6CPXSi7TL85TQqrW029nkgXw7hyKjzU99RTMgps1TbQeollVeLv+s7hH
 wo8vhyEZFua3I4RT2TGbRxxvB1DwjRw3MPeS4pky3eHEH2ceGbpgYWcIYCtJBGi11hoV5x4nfNy
 K68FwiADBLZBww/mYXswJSxPwhOcE2uF7029Kh/1GSuI29q3JS1WDMc3jPKzFgmN+LEZNErnu3b
 afMosyoNfAL1ckFlQ6tQDjSbH1CzArUWPx2DSA4wK3fUXHb4EFOJSz64MRk3SQ==
X-Google-Smtp-Source: AGHT+IGnRlE1J9xAQ8on+RsP6dF3OMiTxnoLy+/62yPs6hp1pQvN2FypIbgjstfQKJKk6OT9jCncrw==
X-Received: by 2002:a17:903:3bc6:b0:220:d79f:60f1 with SMTP id
 d9443c01a7336-22a8a8ced77mr165846205ad.42.1744037270688; 
 Mon, 07 Apr 2025 07:47:50 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:8768:486:6a8e:e855])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ef3c2sm8856960b3a.59.2025.04.07.07.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 07:47:50 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 02/10] various: Define macros for dependencies on emscripten
Date: Mon,  7 Apr 2025 23:45:53 +0900
Message-Id: <5f2a8fa2d7116b1d65b79fbb3a95244096fb7308.1744032780.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744032780.git.ktokunaga.mail@gmail.com>
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 07 Apr 2025 11:14:07 -0400
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

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 block/file-posix.c        | 18 ++++++++++++++++++
 include/qemu/cacheflush.h |  3 ++-
 os-posix.c                |  5 +++++
 util/cacheflush.c         |  3 ++-
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 56d1972d15..69f54505bd 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -110,6 +110,10 @@
 #include <sys/diskslice.h>
 #endif
 
+#ifdef EMSCRIPTEN
+#include <sys/ioctl.h>
+#endif
+
 /* OS X does not have O_DSYNC */
 #ifndef O_DSYNC
 #ifdef O_SYNC
@@ -2011,6 +2015,19 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
 }
 
 #ifndef HAVE_COPY_FILE_RANGE
+#ifdef EMSCRIPTEN
+/*
+ * emscripten exposes copy_file_range declaration but doesn't provide the
+ * implementation in the final link. Define the stub here but avoid type
+ * conflict with the emscripten's header.
+ */
+ssize_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
+                             off_t *out_off, size_t len, unsigned int flags)
+{
+    errno = ENOSYS;
+    return -1;
+}
+#else
 static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
                              off_t *out_off, size_t len, unsigned int flags)
 {
@@ -2023,6 +2040,7 @@ static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
 #endif
 }
 #endif
+#endif
 
 /*
  * parse_zone - Fill a zone descriptor
diff --git a/include/qemu/cacheflush.h b/include/qemu/cacheflush.h
index ae20bcda73..84969801e3 100644
--- a/include/qemu/cacheflush.h
+++ b/include/qemu/cacheflush.h
@@ -19,7 +19,8 @@
  * mappings of the same physical page(s).
  */
 
-#if defined(__i386__) || defined(__x86_64__) || defined(__s390__)
+#if defined(__i386__) || defined(__x86_64__) || defined(__s390__) \
+    || defined(EMSCRIPTEN)
 
 static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 {
diff --git a/os-posix.c b/os-posix.c
index 52925c23d3..9a7099e279 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -148,11 +148,16 @@ static void change_process_uid(void)
             exit(1);
         }
         if (user_pwd) {
+#ifdef EMSCRIPTEN
+            error_report("initgroups unsupported");
+            exit(1);
+#else
             if (initgroups(user_pwd->pw_name, user_pwd->pw_gid) < 0) {
                 error_report("Failed to initgroups(\"%s\", %d)",
                         user_pwd->pw_name, user_pwd->pw_gid);
                 exit(1);
             }
+#endif
         } else {
             if (setgroups(1, &user_gid) < 0) {
                 error_report("Failed to setgroups(1, [%d])",
diff --git a/util/cacheflush.c b/util/cacheflush.c
index 1d12899a39..e5aa256cd8 100644
--- a/util/cacheflush.c
+++ b/util/cacheflush.c
@@ -225,7 +225,8 @@ static void __attribute__((constructor)) init_cache_info(void)
  * Architecture (+ OS) specific cache flushing mechanisms.
  */
 
-#if defined(__i386__) || defined(__x86_64__) || defined(__s390__)
+#if defined(__i386__) || defined(__x86_64__) || defined(__s390__) || \
+    defined(EMSCRIPTEN)
 
 /* Caches are coherent and do not require flushing; symbol inline. */
 
-- 
2.25.1



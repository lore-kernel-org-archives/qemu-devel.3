Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9D3C3DA64
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 00:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1salde-00080A-W8; Sun, 04 Aug 2024 20:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saldd-0007vp-SI
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 20:31:49 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saldc-0002JW-97
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 20:31:49 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70d1c655141so7301749b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 17:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722817907; x=1723422707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V6ZlS+VMsFpi/JD9xfA3NQaSnzna6YC/nJ4q2H/FlJk=;
 b=FL00/yi0BB+1eNCp4Jl2CuQYIMPbINmyP0hYKnOoLPQ4hkKU9bZv7ko3kxEbpSm2iS
 YUI/WQub3LhHKooFSF1c7M6S1q1Fb+R1Ub5y4o4JY2he+Pe6YcN5iwTpk9H2M7vjGFv2
 F1DRtu9hKhEs4cHvfBLQzX2YlZoWLg/KNv7UnmVod3Q/xrfToWyWccpMrSFdbnmtXIKf
 vNs8ZQzqOXyDQtmwHqZHdUtGUL160mMoXsK8+9PvuVgpeIDm4TpFxTDcWRRq9Hfav126
 icbLcS5KEmQiCQGvMzbFMBGfJqY3+GjL/g7VOYKItWFx6fw85LLstrVw6FxbGmzp1jCy
 9Bcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722817907; x=1723422707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V6ZlS+VMsFpi/JD9xfA3NQaSnzna6YC/nJ4q2H/FlJk=;
 b=f5UDe403Kj7E6uXdpL1iX5PhOjrt18ks7cHXfYkNSq2XbbDTgnxMS0uKTGsE0wq4vq
 mBNjMj1hnm/nB3cORemNn4wetD23+rgZ6I8dNrPLK3G0TXvRHLJDLHy3k+XovZPwA2+x
 Z+/nbxvaqJ4gm2qvrVFsHE0IxpuFoEJc43ZJtixqGtuUgsP2nIT/od28gRGCKf8/WTg9
 YdyhlxXS0IW+Gm91yRUBUhak0gI2Y6xohI0miSt3rSrkiJ6hzQK6PgStQTC6B0wux36/
 rEqW38imEp91nMBPSP5N1pFQOSXzqB4Di8pjLeRKjyVv9iIvUkgQT0qXJUdu61Dxh4gX
 ctTA==
X-Gm-Message-State: AOJu0YyEjF815SCWC4XbdPNOD1MhRkju5O4FT+nddgU1fD8HzbjDFA3i
 dLndhVfzoQZWpVPGGU1L9VI4aTjsNCThOg+GCMVTpvunAMtCTbhJxwoO2nFuwCnZZseb62HYKhF
 GFUuZew==
X-Google-Smtp-Source: AGHT+IH6fhoe6GxYqp8faMs8tNpspGeK+SxjbQLgT/5zILlVRNg279qzJemFoQGNWGAWZneOqFdaSg==
X-Received: by 2002:a05:6a00:194a:b0:70d:3a5d:5d4a with SMTP id
 d2e1a72fcca58-7106cfafe51mr9332762b3a.12.1722817906752; 
 Sun, 04 Aug 2024 17:31:46 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ed16cb3sm4576038b3a.179.2024.08.04.17.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 17:31:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
Subject: [PULL 3/6] qemu/osdep: Split qemu_close_all_open_fd() and add fallback
Date: Mon,  5 Aug 2024 10:31:26 +1000
Message-ID: <20240805003130.1421051-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805003130.1421051-1-richard.henderson@linaro.org>
References: <20240805003130.1421051-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

From: Clément Léger <cleger@rivosinc.com>

In order to make it cleaner, split qemu_close_all_open_fd() logic into
multiple subfunctions (close with close_range(), with /proc/self/fd and
fallback).

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240802145423.3232974-3-cleger@rivosinc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/oslib-posix.c | 50 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 1e867efa47..9b79fc7cff 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -808,27 +808,16 @@ int qemu_msync(void *addr, size_t length, int fd)
     return msync(addr, length, MS_SYNC);
 }
 
-/*
- * Close all open file descriptors.
- */
-void qemu_close_all_open_fd(void)
+static bool qemu_close_all_open_fd_proc(void)
 {
     struct dirent *de;
     int fd, dfd;
     DIR *dir;
 
-#ifdef CONFIG_CLOSE_RANGE
-    int r = close_range(0, ~0U, 0);
-    if (!r) {
-        /* Success, no need to try other ways. */
-        return;
-    }
-#endif
-
     dir = opendir("/proc/self/fd");
     if (!dir) {
         /* If /proc is not mounted, there is nothing that can be done. */
-        return;
+        return false;
     }
     /* Avoid closing the directory. */
     dfd = dirfd(dir);
@@ -840,4 +829,39 @@ void qemu_close_all_open_fd(void)
         }
     }
     closedir(dir);
+
+    return true;
+}
+
+static bool qemu_close_all_open_fd_close_range(void)
+{
+#ifdef CONFIG_CLOSE_RANGE
+    int r = close_range(0, ~0U, 0);
+    if (!r) {
+        /* Success, no need to try other ways. */
+        return true;
+    }
+#endif
+    return false;
+}
+
+static void qemu_close_all_open_fd_fallback(void)
+{
+    int open_max = sysconf(_SC_OPEN_MAX), i;
+
+    /* Fallback */
+    for (i = 0; i < open_max; i++) {
+        close(i);
+    }
+}
+
+/*
+ * Close all open file descriptors.
+ */
+void qemu_close_all_open_fd(void)
+{
+    if (!qemu_close_all_open_fd_close_range() &&
+        !qemu_close_all_open_fd_proc()) {
+        qemu_close_all_open_fd_fallback();
+    }
 }
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF59C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 20:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfQUw-00087k-2U; Wed, 28 Feb 2024 15:25:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfQUs-00086E-Ov
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:25:47 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfQUd-0007Mv-2K
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:25:46 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5cfd95130c6so103368a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 12:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709151929; x=1709756729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6tPGvcWUCgEHkg4WhhgoNhXXsmKMPZyhGixNdkwuIE=;
 b=T4axga2FbF4om3bn1Y4hsgNRtmpOjBaUc4/NxeH+EEP0dtdxzMa8leX1rLiOPCadJr
 UafXs7ZNmgYCsdYndtyMgB/fse1N2+IJYQuJUjg+i1vZoczWhkjIX9SlVYtE1kw2lF9h
 hYU7/P3jPuRUZFYTs4cP8CdH7wStrQeZrYymAVLPNL57ECFQhTYJeWfWLPFu1wo8Ju5X
 FGnrGzKe9az6norOL3u4I61oxn6+0+gIiiwt+D6FQG6DVj52WQ2tMvSLiJM0hAWqPtaM
 vEWC0RANXD7QMVu7mLadL2wW7spVzHuv7mR+R3YUljAtZ7hl2KkeINAEQ9ag3FjoBLOb
 84Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709151929; x=1709756729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p6tPGvcWUCgEHkg4WhhgoNhXXsmKMPZyhGixNdkwuIE=;
 b=gTqmFA+Yloe7TveitLaMb+x34FgLzOTXB4FhzWE8PTxZ2VRXylShRm3x84vqJD5/ZL
 zXi3Ldu8CrWbBgaieoiLRUckuOZ3aS2tE9evWWZbS+iEltTha6M/ReFr0aJnUXQaJdmp
 cXNQnq5ddhcVaClptl5GXOPkOrsMIqD1bvpL14ajDBf5PX6nziA9sFCcsT51forgo0BW
 lQQNWBJlNeWHOvXYr+hjfg1PmrlR38HqjPT1e5lo510UZCxC5/sJR2OY7e9/lROZohz1
 QjXWAXJNcpYDg69xrza6y5M8pdMMfPw5SeSfSeotLkxrYV3IVFaYcVa5ojv5HO0An8bH
 kE3w==
X-Gm-Message-State: AOJu0YxhB3ONJeCg9pXBayDmE1jCDzz1+OqD9VkZT5lhKjG4G7Xv/y8U
 0OBpbSUc9/Plq2RtM7Cyulw54uDDeM1r9jo+H3EFt0zJts5pOO9BjWUkPLz1sqFn1W88/ca3L64
 h
X-Google-Smtp-Source: AGHT+IFpLKEaiu7JuvZ8j3W1ZjVyxMMXEWIJpJnC0TU19pabpd4XPWCuEh4EQADC6JBJztYQ7+DxkQ==
X-Received: by 2002:a17:90a:4206:b0:299:df2:66b2 with SMTP id
 o6-20020a17090a420600b002990df266b2mr262073pjg.22.1709151929447; 
 Wed, 28 Feb 2024 12:25:29 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 oh5-20020a17090b3a4500b0029ab712f648sm2118499pjb.38.2024.02.28.12.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 12:25:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, richard.purdie@linuxfoundation.org, mjt@tls.msk.ru,
 iii@linux.ibm.com
Subject: [PATCH v2 5/5] tests/tcg: Check that shmat() does not break
 /proc/self/maps
Date: Wed, 28 Feb 2024 10:25:18 -1000
Message-Id: <20240228202518.33180-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228202518.33180-1-richard.henderson@linaro.org>
References: <20240228202518.33180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Add a regression test for a recently fixed issue, where shmat()
desynced the guest and the host view of the address space and caused
open("/proc/self/maps") to SEGV.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <jwyuvao4apydvykmsnvacwshdgy3ixv7qvkh4dbxm3jkwgnttw@k4wpaayou7oq>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/linux/linux-shmat-maps.c | 55 ++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 tests/tcg/multiarch/linux/linux-shmat-maps.c

diff --git a/tests/tcg/multiarch/linux/linux-shmat-maps.c b/tests/tcg/multiarch/linux/linux-shmat-maps.c
new file mode 100644
index 0000000000..0ccf7a973a
--- /dev/null
+++ b/tests/tcg/multiarch/linux/linux-shmat-maps.c
@@ -0,0 +1,55 @@
+/*
+ * Test that shmat() does not break /proc/self/maps.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <sys/ipc.h>
+#include <sys/shm.h>
+#include <unistd.h>
+
+int main(void)
+{
+    char buf[128];
+    int err, fd;
+    int shmid;
+    ssize_t n;
+    void *p;
+
+    shmid = shmget(IPC_PRIVATE, 1, IPC_CREAT | 0600);
+    assert(shmid != -1);
+
+    /*
+     * The original bug required a non-NULL address, which skipped the
+     * mmap_find_vma step, which could result in a host mapping smaller
+     * than the target mapping.  Choose an address at random.
+     */
+    p = shmat(shmid, (void *)0x800000, SHM_RND);
+    if (p == (void *)-1) {
+        /*
+         * Because we are now running the testcase for all guests for which
+         * we have a cross-compiler, the above random address might conflict
+         * with the guest executable in some way.  Rather than stopping,
+         * continue with a system supplied address, which should never fail.
+         */
+        p = shmat(shmid, NULL, 0);
+        assert(p != (void *)-1);
+    }
+
+    fd = open("/proc/self/maps", O_RDONLY);
+    assert(fd != -1);
+    do {
+        n = read(fd, buf, sizeof(buf));
+        assert(n >= 0);
+    } while (n != 0);
+    close(fd);
+
+    err = shmdt(p);
+    assert(err == 0);
+    err = shmctl(shmid, IPC_RMID, NULL);
+    assert(err == 0);
+
+    return EXIT_SUCCESS;
+}
-- 
2.34.1



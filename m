Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20386CA0EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 11:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjzay-0007sN-Bc; Fri, 30 Aug 2024 07:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sjzax-0007ql-95
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:15:11 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sjzau-00072A-Bm
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:15:10 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4280ca0791bso15212645e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 04:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725016507; x=1725621307;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a/hvBKZnMPs4zc1u5bD0StsX+WI7xSzV//6Rq6fA0HY=;
 b=ZmsQXiL4Wzt3UcldiRpPcJd7+q7URo804riwW4Vn8i/xJucc88F8XBIUU27IvTlREi
 1EYtWYH5/cuoQE6LAQOzM8hdmAb/Rmk9Pa2Y2AJ5Mh2D09WOtp6djvpAIKsaM5QpDcXE
 pDVMmPkVjE1OekQ/6CvVpc4GgDgTNM8L725awl4k8m5/Msna0ICKMTVjI2vNhBbMmjbe
 Cp9BxjPum5TVe4q+W7gBU5LUQVYNr7B81vaWLPI+KjLJqtEoxvY2fu+VV71jihKS87YU
 m73cF4LbftRbDQfBrPL1k0leP1vkninAG46agca3qlBgu17RAlhzXFo1aYK0AKf5jHJK
 YcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725016507; x=1725621307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a/hvBKZnMPs4zc1u5bD0StsX+WI7xSzV//6Rq6fA0HY=;
 b=wA7N3HGBNfuUtNkzfjpaxlkL31QejVWpX/v2XchiqUR0jjPIxe1IjDDv9zvBzF0e6L
 /5jOeGNKDJ2EKiBy4cqxiF2LttFfsfugfujCOwIAf3KikNt+8RNCTxe7aGKTPSVD+ONj
 naWEBtJ9ns/jayaODzh+QnfGnP3nVCkxZSZp3nT3Ywj6EFHUzKlDlvSaPvD8iUmJCZLy
 nseYXb5Gl9WPpRBsWyBvIsdewX7qZBaCZwQ5bAbvY4zfBDnZ8E8+wrTS5QwiwQa59g9X
 AqvoS9h1DUiPixXpmYdu/Jp0VEIiSMeWpajJdjLqcVRRa6H7VpiDS4snltkSQiJIIifl
 LCug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYNn7mx7Ts+Y1fcbPzqncQzaJzusJXW8AKMToLwAyjd0qxkOEGpVkt41oAFZ3SROjmg3436icDtNBg@nongnu.org
X-Gm-Message-State: AOJu0Yz/reNKtyYHfekoplQ8D3N5UQdBLjMbXOCPZJz2XF/qY9WUZ6CX
 yPjUZHSMBe86WrL+9cDR6Td9PEsJPejJa4XWlsRORul7fdk6r+pEfJApYogXlZ4=
X-Google-Smtp-Source: AGHT+IEcqiQcswR7CpCsH3UPsL2pFAibczv2ddHVHOgOcpLsRYZBc4Mg2JZ2gw8YyqkhzWKxZeP9wQ==
X-Received: by 2002:a05:600c:1c18:b0:428:f0c2:ef4a with SMTP id
 5b1f17b1804b1-42bb01bac77mr46691615e9.13.1725016505983; 
 Fri, 30 Aug 2024 04:15:05 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ee4a590sm3713859f8f.9.2024.08.30.04.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 04:15:05 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/2] qemu/osdep: handle sysconf(_SC_OPEN_MAX) return value ==
 -1
Date: Fri, 30 Aug 2024 13:14:50 +0200
Message-ID: <20240830111451.3799490-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240830111451.3799490-1-cleger@rivosinc.com>
References: <20240830111451.3799490-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On some systems (MacOS for instance), sysconf(_SC_OPEN_MAX) can return
-1. In that case we should fallback to using the OPEN_MAX define.
According to "man sysconf", the OPEN_MAX define should be present and
provided by either unistd.h and/or limits.h so include them for that
purpose. For other OSes, just assume a maximum of 1024 files descriptors
as a fallback.

Fixes: 4ec5ebea078e ("qemu/osdep: Move close_all_open_fds() to oslib-posix")
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 util/oslib-posix.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 901dcccd73..abf3aa597d 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -44,6 +44,11 @@
 #include "qemu/thread-context.h"
 #include "qemu/main-loop.h"
 
+#ifdef CONFIG_DARWIN
+#include <limits.h>
+#include <unistd.h>
+#endif
+
 #ifdef CONFIG_LINUX
 #include <sys/syscall.h>
 #endif
@@ -928,6 +933,13 @@ static void qemu_close_all_open_fd_fallback(const int *skip, unsigned int nskip,
 void qemu_close_all_open_fd(const int *skip, unsigned int nskip)
 {
     int open_max = sysconf(_SC_OPEN_MAX);
+    if (open_max == -1) {
+#ifdef CONFIG_DARWIN
+        open_max = OPEN_MAX;
+#else
+        open_max = 1024;
+#endif
+    }
 
     assert(skip != NULL || nskip == 0);
 
-- 
2.45.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75754D216AA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iF9-0001Ze-GA; Tue, 15 Oct 2024 10:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t0iF8-0001TY-1w
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:09:46 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t0iF6-0002A1-J1
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:09:45 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20ca1b6a80aso32052315ad.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729001383; x=1729606183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qBvfu9ZFg8H1zZnEqrBx5S3pcTIeRNQv25oEte17SiQ=;
 b=Bl5flJUj/RI5w9JS5IZBUxn3lq5Z9wU4DRHTujkH54tQLAdZj7PzRHU5fSGWO7EPAg
 zjl2Ewwrs/GSPHTi9J7Utfeq2GQ9KnN7YIl0tT3xBkv6d0i+miu+R/L/N2eFr62iinhR
 Rpc1RHCDNQn13GzbsYNBBqTFYjwPaTOfnwbRte86J8SRgaFxUXImVC/Wrf6LsVdG/Jma
 CxrcG6MyhI3MZjr1Hu8PrkZqG7c9uOsOB8Y/fZT+Tywji5OfufhCA49mm7lHvxkOyTxe
 tvGNIuyElYWvLvzjdXcuV5eIzEX5rV++wGVRB/uWiL5PyUNGPT/9/KrpdFYEaVM4ldh+
 PVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001383; x=1729606183;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qBvfu9ZFg8H1zZnEqrBx5S3pcTIeRNQv25oEte17SiQ=;
 b=iU8CuDUvSa6cT7pTYMM63U+pLdQBUodnoWt6CYEvyFJE9AJukneUgalcIynMKBdevW
 Gk95B1rix0JIo/F81SyaAtgj7iPjgjphwy6pReTMVXXNKemtjiwBOZh2AQWsXuN14ILN
 yuIbU5Re2c6lc4Kr9cNRQkJ+YsraWrAyIiSWXnpJvt4ZVqBl9rMim5zyojpQBq9ytcLL
 gxjYj3TWDZWt+87vydx/ZlqikFfMtSjEFpPoXCetUbxjQSv+q//M8p4vLS1Z1IJ4TZeb
 0tWLgKlEQ8+1VzKIFU6uALiRwUZHYrZ3qWu1i5sSggfEZDyi/1mbJcnaOiw2Mi+s3l1K
 f0/A==
X-Gm-Message-State: AOJu0Yy+X+KMdO33oDqslt6SttIWKOP/askvrR8+Rijn3+o+DVtmwcke
 S3ZABhCaATtvg4WI6AeQR7b3f2vQ2Y6M6vF6bMbYPUDiG9HS2qSAew5LhZaUBzRMjq61/V0hUuj
 tdNQ=
X-Google-Smtp-Source: AGHT+IG/rGGtWs6RjsXq57VZmFArOe3FN9j1vHo3AQd/GD40EecEgttU23nHmZbBzE2+Ux6F00Llaw==
X-Received: by 2002:a17:903:184:b0:20c:631a:888d with SMTP id
 d9443c01a7336-20cbb199db4mr160490485ad.13.1729001382919; 
 Tue, 15 Oct 2024 07:09:42 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:3301:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1804c680sm12411505ad.233.2024.10.15.07.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:09:42 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH] linux-user: Clean up unused header
Date: Tue, 15 Oct 2024 14:09:22 +0000
Message-Id: <20241015140922.385470-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62c.google.com
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

Clean up unused (already commented-out) header from syscall.c.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 linux-user/syscall.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1354e75694..d1b0f7c5bb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -54,7 +54,6 @@
 #include <utime.h>
 #include <sys/sysinfo.h>
 #include <sys/signalfd.h>
-//#include <sys/user.h>
 #include <netinet/in.h>
 #include <netinet/ip.h>
 #include <netinet/tcp.h>
-- 
2.34.1



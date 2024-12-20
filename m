Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB897E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfiP-0001eL-4q; Fri, 20 Dec 2024 11:19:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhE-0007s5-1e
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:50 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhC-00084S-EB
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:47 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso14652195e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711463; x=1735316263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D6KbqFY6LsYqJaU3hcXj+0TFYmabAztkE0zO0OF00So=;
 b=WhIJX2Vt7EKAZSjKapc3o1ynqsKk4ivJH9F62vf6SGzx/od2/o4rZl5aQLUaLHUjVD
 uh9O12WUCVKpe8I/4uiWJWunxAZvaYE7Urgc35KtrCZuzwpGTeYMRz6t3EuBAsf5w4vN
 twEwRou1CwiQyHsZCX7QUbJK2iAjobff7K3ncUARo4T9EQWSe/LNxH3FAcJpfA4+ljem
 5A0ZHydk/lj4+rfB97oP8gTNEGRMduG4yns2nYyzbDm6PoSf01FBfGmiH1UiYujMht+a
 HjE7qilsUqM2nDbAzzneFoQdHcHKEJHU4f4XrwVfsMvfreJwMz5VXhiEAke8HMmifOWH
 +1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711463; x=1735316263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D6KbqFY6LsYqJaU3hcXj+0TFYmabAztkE0zO0OF00So=;
 b=kRfKq9MUm9VmETfVkDUn+UC/9Z8d4Ko//usTUrfyqPc3P/YQOW57y7OpaWE9PhZfI1
 yKfGtvbO9OBr0ngpmlmJKX6dqfMfuwC3rQU92WDZwuQ5STTdlzhPEkzZC982th4vnqS0
 dnTpNfRRO31FOvfgUZCL+rRVl5dBOMjqd6O8TyG8nDXhbKvbDmCZ9E/w5G+yOxfCZSID
 mYwPKYY3zGz1G0PlqmKtoRguDs0yIB4ZzbPkf+KqHtAfxZp5fV0gal+kQIHM4M0VVJDd
 1X5oKtPZ8Be8vWM9t8tiVyZijLBXqECNDLxz9Jvrlp3eI1Tr7par27OTQfGmWs6gpp9q
 GmhQ==
X-Gm-Message-State: AOJu0YzOwtZVvLezP7wj9nwMEfpUzK2a9A1jOTUBsV/SeDFo0ss1h/1y
 /1JLP0j4DqXlttCEDCOEeKHnDb10IItByPMh+5gsUShpoaXrz4AAT3rqpmGPgPytm2gqdUoUUAs
 o
X-Gm-Gg: ASbGncvclKMAXjlssBtkDSB7bJxDPUOtKCZ9dyvXLCMIeIu2sUP6H0tVJzJV5aVdEn1
 LaYXLOWhLr1Ry9pZj5UBlZrp/7Z1aLkMhYGsFezmlUQxNWoNt3jR6bxs6gb1USzkr/iVyn70VAA
 jOz2QZQVHeGglSNxuwD3E/cOaSU+6mQ5yTvv8yjmVk5TIsVkkQZiQkLtcrZJMEDSfgwhb8TETAw
 gfvzVdIbgsrTlLLgc59Kssb485PK5g1pajHs8nwM/3meJGN6l8er7AByKDSj4TtsTlldwGPFrA=
X-Google-Smtp-Source: AGHT+IHgAAv1LqUcAHKoGTELOSTBMuK/dno/ZZduJWw2vxvnM9dIj20slO5UR2XAoyqP3UeSR/M50w==
X-Received: by 2002:a05:6000:1785:b0:385:fd07:85f8 with SMTP id
 ffacd0b85a97d-38a222003abmr3310040f8f.29.1734711463337; 
 Fri, 20 Dec 2024 08:17:43 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b119d7sm83239195e9.20.2024.12.20.08.17.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:17:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 24/59] include: Include missing 'qemu/clang-tsa.h' header
Date: Fri, 20 Dec 2024 17:15:15 +0100
Message-ID: <20241220161551.89317-25-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

The next commit will remove "qemu/clang-tsa.h" of "exec/exec-all.h",
however the following files indirectly include it:

  $ git grep -L qemu/clang-tsa.h $(git grep -wl TSA_NO_TSA)
  block/create.c
  include/block/block_int-common.h
  tests/unit/test-bdrv-drain.c
  tests/unit/test-block-iothread.c
  util/qemu-thread-posix.c

Explicitly include it so we can process with the removal in the
next commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241212185341.2857-4-philmd@linaro.org>
---
 include/block/block_int-common.h | 1 +
 block/create.c                   | 1 +
 tests/unit/test-bdrv-drain.c     | 1 +
 tests/unit/test-block-iothread.c | 1 +
 util/qemu-thread-posix.c         | 1 +
 5 files changed, 5 insertions(+)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index ebb4e56a503..bb91a0f62fa 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -28,6 +28,7 @@
 #include "block/block-common.h"
 #include "block/block-global-state.h"
 #include "block/snapshot.h"
+#include "qemu/clang-tsa.h"
 #include "qemu/iov.h"
 #include "qemu/rcu.h"
 #include "qemu/stats64.h"
diff --git a/block/create.c b/block/create.c
index 6b23a216753..72abafb4c12 100644
--- a/block/create.c
+++ b/block/create.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "block/block_int.h"
+#include "qemu/clang-tsa.h"
 #include "qemu/job.h"
 #include "qemu/main-loop.h"
 #include "qapi/qapi-commands-block-core.h"
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 7410e6f3528..98ad89b390c 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -28,6 +28,7 @@
 #include "system/block-backend.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
+#include "qemu/clang-tsa.h"
 #include "iothread.h"
 
 static QemuEvent done_event;
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index 26a6c051758..1de04a8a13d 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -29,6 +29,7 @@
 #include "system/block-backend.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
+#include "qemu/clang-tsa.h"
 #include "qemu/main-loop.h"
 #include "iothread.h"
 
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index b2e26e21205..6fff4162ac6 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -17,6 +17,7 @@
 #include "qemu-thread-common.h"
 #include "qemu/tsan.h"
 #include "qemu/bitmap.h"
+#include "qemu/clang-tsa.h"
 
 #ifdef CONFIG_PTHREAD_SET_NAME_NP
 #include <pthread_np.h>
-- 
2.47.1



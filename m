Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE70C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 18:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoKW-0004gI-AH; Thu, 12 Dec 2024 13:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoKT-0004ez-M7
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:54:29 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoKS-0006Ys-23
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:54:29 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2161eb95317so9263235ad.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 10:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734029666; x=1734634466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HazQIxFPlU3a2oysjMUdZiZcfaWSWluyVNuDTpHIcic=;
 b=bI3Fxu08aimMMzeMbRWNnaGvT0OYeDXGchKhbBUvHN7YoK0qzzcFcELs6XnGozIx2r
 GuPGvQ6k4K8IIzbNll7p6tVDRolM8HvXciuP5iEvcfKtZo84JwB3r3bqHvmoPrP4S8Uc
 Gz26TaEHQzda1J4uvwtxeJq3CoEUHyapfP7VHn4ep242jnP3Jf2MvbyIFHc33VHlyRyg
 77ltblWonqTP9/7VcrTF8GEsJ1BKBhiFnfvOya6x+qoFyOaSqL79SPrMzcr2fLTOhTtE
 lKJeL3BJZrOlc+tpa89Kb8PvYQ7U7YQz64Vg4/66un/oq6wbyySHarz/oQ2qcy4PYjaf
 ypDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734029666; x=1734634466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HazQIxFPlU3a2oysjMUdZiZcfaWSWluyVNuDTpHIcic=;
 b=X7nkZiFkUUJN5YZLQUoSqdUHgg7KlMjg4C0nIdSWD7qRA0tM8hFPPa9LA3gOr8MQRQ
 UPUm4n8Ht8i1dQDpgrt9LGTw62H5apumURFJ7IURc/+rbXXV8EguIlcaXXywyNWTBOUN
 mAM5YjEhT9/V/cNLFy6ixx05WB2Wla/G9EHqYeA8mnrIefwPtgyNSPvT7Ze2/juKlJ0W
 NOB8xcxrV52phIXAK2wakahuc+HPfVr0OhL0hidou7Yz6vgajTbgY+Gw4AGEvYJUnM4A
 r1m+wa/xtBQIoHmJ14qrX009HUWi157PdOnKH3M02ZA6SfU/tmjQCd2SLRHlJFT/8mKa
 PkpQ==
X-Gm-Message-State: AOJu0YzW8aek+sXbhVRLTdX5lLHdhQo7tgYwtfy8yRDTtwV5OhARb8YP
 QXeG1YBVfjFnbKaImZrUIL2zmCgs5c1d4P8aczGJ+LVD2iCvmy6JMDuXkcszX8Bub/Dafkigyi1
 y
X-Gm-Gg: ASbGncv3r1XD+TvK35wEfDAqqCrvSYSJ1Y0j14RmmWeqLEMlA+W7c1BZs1cvyh/1TDP
 iFmmXxE+TLZ+hLGpiNAjr5Ph4jvUmY0fVjBPeE/6WLc/+vVz7hLJECqPSIRNLDWJIhfiRDKP/Nu
 sEu000P0+2FZMvKG2D+SX039qhODnJb3jK/At5zt057tjzIr3UizB27PDhcOnp7ce6s4pkM1SPg
 qGByHLOONF5Z7bpIJ2UgIh+4HcEI4DWswqXx/dN2wjR8e2gqGQKdFtpNb+QYrnM/OoJHsRwYZPo
 PpsHf95yWpcvUoqb7Gd1ou7SG2hO39g=
X-Google-Smtp-Source: AGHT+IF9eQRkoasWzSOsCuqjBjOJchsppkPiVwxtqX7cI2BenpC8dZjjHVxSxItYhkeZG00J1A+63g==
X-Received: by 2002:a17:903:1c2:b0:216:1ad2:1d5 with SMTP id
 d9443c01a7336-21778549cf8mr115840235ad.41.1734029665998; 
 Thu, 12 Dec 2024 10:54:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21781ced307sm29179555ad.31.2024.12.12.10.54.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 10:54:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/18] include: Include missing 'qemu/clang-tsa.h' header
Date: Thu, 12 Dec 2024 19:53:26 +0100
Message-ID: <20241212185341.2857-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212185341.2857-1-philmd@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x630.google.com
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
2.45.2



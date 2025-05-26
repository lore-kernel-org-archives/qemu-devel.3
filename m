Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD07C5B542
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 05:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJQPK-00073F-UM; Mon, 26 May 2025 01:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJQPI-00072w-63
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:29:52 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJQPG-0001yy-B4
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:29:51 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-23428770e1fso8239625ad.0
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748237388; x=1748842188;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tpEeShMgw5miBNRuoBOGCybk4Qn7aitvfKahD59h2tI=;
 b=OTgSycgq6dGaoV/G2Tq2gDzIBdBxY+kSMcIyowI/jetZTBabAWioSPO6Lkt+/o6GRp
 AulvXMjt2aGTi/+mbWvvxt2hlUXB1H/Bk9mr7xzc44eeHRF6fuOGvQzjrIPQhxQFzTen
 HQLIxKuydVnIQRG8go4pTvdFbgUTVZ/U9S+5m5e6EC9p073BJI/7eFY9B4Sg9UB3yW31
 zTQgSASAUHjgOxO7N4jZLzGjxpCpCPtqpfQLZo1Nn/lFWwdrO2TbXlBSGWmYd6V+n9je
 owTetqxPtoek9zTIwZBl7k90fi2XepTw/wsM5+qpLgSM9mopTHchHCiyOiksJZwCoZ41
 gQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748237388; x=1748842188;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tpEeShMgw5miBNRuoBOGCybk4Qn7aitvfKahD59h2tI=;
 b=U/YjyYTWo8ZhNK6mFweoXIjViRz/u48/K9Pj0IS3GIgXr284OzN6MOr8sCZhVPpZwn
 9diGHvEfjyCoa+FSIPDO/HfZHvOozFIUjS2paFsr1nNvtKfjO9Zch8La4/Hy9yPyOHkq
 DoflY2a0NXTLBUKkD6j1p/5OGG4armZBTUU+F74bbTXjuupLzE7MokSFPYhdkVa3k/5O
 9g9lREf97x+U0Gzez7YCR6JwwJ8txJPd7YCaDcvOo169aI0dozl83LYZsUy//aPIMpqg
 6Vr7w7RRMnnKmbmjQxmCsLrVtUrH8cMTeWWlEWIPqFW4l+YfalCMc+MY9Bm85j59uvDz
 NoxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpZWTZ/aHk5zif+QVpw8dvgtJQ2COo0BuTN4RLni2gpWPRLyuhNSYbvlBUCFycuKfNwXHHbD213Gf+@nongnu.org
X-Gm-Message-State: AOJu0YxFxvOtrRglILjEKNHrGQcl2rx35MQpNqOGEBG7jaCfb2KCnn+A
 8qJCaDwxyDBXyn2PVI4lFK2McL4R+B5kHjmPWvhrfP+ALp9Iihh3oSbvu8z7sFlSt/fl+jsUg5h
 6osCy
X-Gm-Gg: ASbGncsKCErmKM6XHKTAxSp66hLt2mWWDtifClZZ/cMI5+fiGddxn+2oqkVT8zlMYfj
 MAAyxfFK8jqrrIUTcRtHJ9a+eallKnDzoLGsMonaGYFPFSxRvslO0twtRcVZGwP2csMczIpE/Vq
 vx3jgJjIlQv62lEHlqu09+V9Xi117AS3P2j6NN3kZLT9F0pZuzJIIESF2N/mCKLeU7qXfWKjbLs
 Wn4WZYISqMFPEX3/IIbTTL48PyBPldVkQ2ihA4I6osYmHnKnF+ZvlfiMc+C9SDCMuis2Vq+cPHZ
 0oICypY5BeZ2ijCOGK+0CYEzX4vLq/6ixzr734lg5NUQUSXPOM67X1UX3PLY7WI=
X-Google-Smtp-Source: AGHT+IF6WmjZSaw/GAef5CH/6zOASqT9GmonH8ySxMIVaI06S7WghtXQ/SA9TE/UNx6hvTZoZr4uwA==
X-Received: by 2002:a17:902:da47:b0:234:854:20ba with SMTP id
 d9443c01a7336-23414fc8775mr131458255ad.40.1748237388681; 
 Sun, 25 May 2025 22:29:48 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-30f364907d4sm11457853a91.24.2025.05.25.22.29.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 22:29:48 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 26 May 2025 14:29:17 +0900
Subject: [PATCH v4 07/11] qemu-thread: Use futex if available for QemuLockCnt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-event-v4-7-5b784cc8e1de@daynix.com>
References: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
In-Reply-To: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org, 
 devel@daynix.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This unlocks the futex-based implementation of QemuLockCnt to Windows.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/qemu/lockcnt.h | 2 +-
 util/lockcnt.c         | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/qemu/lockcnt.h b/include/qemu/lockcnt.h
index f4b62a3f7011..5a2800e3f182 100644
--- a/include/qemu/lockcnt.h
+++ b/include/qemu/lockcnt.h
@@ -17,7 +17,7 @@
 typedef struct QemuLockCnt QemuLockCnt;
 
 struct QemuLockCnt {
-#ifndef CONFIG_LINUX
+#ifndef HAVE_FUTEX
     QemuMutex mutex;
 #endif
     unsigned count;
diff --git a/util/lockcnt.c b/util/lockcnt.c
index ca27d8e61a5c..92c9f8ceca88 100644
--- a/util/lockcnt.c
+++ b/util/lockcnt.c
@@ -12,10 +12,11 @@
 #include "qemu/atomic.h"
 #include "trace.h"
 
-#ifdef CONFIG_LINUX
-#include "qemu/futex.h"
+#ifdef HAVE_FUTEX
 
-/* On Linux, bits 0-1 are a futex-based lock, bits 2-31 are the counter.
+/*
+ * When futex is available, bits 0-1 are a futex-based lock, bits 2-31 are the
+ * counter.
  * For the mutex algorithm see Ulrich Drepper's "Futexes Are Tricky" (ok,
  * this is not the most relaxing citation I could make...).  It is similar
  * to mutex2 in the paper.

-- 
2.49.0



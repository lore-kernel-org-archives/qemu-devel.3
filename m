Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8D1C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 08:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDfwU-0006GK-J2; Sat, 10 May 2025 04:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDfwT-0006GA-6G
 for qemu-devel@nongnu.org; Sat, 10 May 2025 04:52:21 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDfwR-0005dr-Ie
 for qemu-devel@nongnu.org; Sat, 10 May 2025 04:52:20 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b20d46fcc86so2569856a12.3
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 01:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746867138; x=1747471938;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tpEeShMgw5miBNRuoBOGCybk4Qn7aitvfKahD59h2tI=;
 b=TZgYeuF4WJhIdMoOlexrADTbTicC0JKMoaFmDtHmv/b6C+QT+FGZQGz8LwL6WvXuGG
 aQ1jcwKyzyeWqzC+XvUBepNPYA2YVtUk7QG5GQe5KLHyQBcHcQHS4XyLR6WYnOA+wjtt
 MphQLAuFrDBitqpY+XEr+MIw/2HosZjLR5qbKSbJwSrRldk3pjEp9j1ZQcdrMjLBYYdV
 jGl3bnsJaCfT5/1MT2m8F4KJYnGuy1mO0BY4ufwKgHf8eFdZBJaSIi/tchusY0sLpsY6
 Jv+KKcbmK184J3K0bwpaEiX416H86yYhyVX+9plz6lROLSpzgOrYGRTUfq488oaXskXu
 inwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746867138; x=1747471938;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tpEeShMgw5miBNRuoBOGCybk4Qn7aitvfKahD59h2tI=;
 b=YKehevM4j+o6EsRaFjz9grqNbhJ/Pw9i7vCbZPKKYqm6Y+EWGaeomntYQMC4QztRXc
 57XY8F+IYD0EzD5R3xFEJgHtbO0zPKbIl0/EIG1DYIZDHeANk3VnyPC1wtWHxTPgP3Zf
 y4TPyLgAaDxx9QGzDBzX3OooRbCDl8iSPxngqHkDTUPH0qPYb7k7a2z3LUClaPktrqzn
 3tP+fzaH8UAtytrDkWP/NNWsPs7A41q8tB7Op9kP9GhEadaw9PcWc/tlRnVYCJ4+RK++
 l1cosY3zaP2kASmt4EgSWbxIXjfomNAcgWNLEvywvf19mYi0uOM+BFrLckSHTRYLz44k
 7ikA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnMFeISiOKI9HlcX7fWE0L4Wkrgt5VOG2ZK0E807XxEKqlFxUcjnW3gaehgu4vKmqgcw8jy9vblQdD@nongnu.org
X-Gm-Message-State: AOJu0YzDt7Xoc5JNASBafY712VwJJjppfG5k4XomLp++t2ZlXBtf8NHQ
 ckhwWl2VyPUhgfnEUy4o6AIV0TBZdKieb84W7vPspYquSFn4JzB0eqzgAiu0SiY//hk+i4K4OFO
 +
X-Gm-Gg: ASbGnct2QjRS+62iSRyTROdaujGchCcCWQsk17wl3h+AHe7J9aKvUSQsqSQ85jdU2Vq
 pkbiznBvPjEUq0O/7RDxaD+sNjOd6ReGdk3hPn+gcM+s82KXjijtsuBbl8MzSKjdv2SAlnO8eic
 MyU1BnzUdS9bPIDLnBgOkrOdGdmJe56L7FxyudF67t+yqfmRPlrPMIa5mfeZiNqCQei1BkqXBhP
 5q3nZOWrdAO98e7OZzUhXaRo8LKYNBsMBRJ1bxLh/89hPAsl2+j9mWwQEyHPMBWwMuN48FgUa4Y
 DYtnCVY1L9fhtD2sQjPP8RzFQb5ElX07i3XprOeP0R8hiN11njdBCDo=
X-Google-Smtp-Source: AGHT+IFN+q2QYtBWe92omJtRLBh0Hlz/Zi54U6gtR3XTbQzRMQT3iHM7nyQ32ZoXU4gONZjUdWicbg==
X-Received: by 2002:a17:902:e94d:b0:224:24d5:f20a with SMTP id
 d9443c01a7336-22fc91c2cdcmr108061545ad.48.1746867138122; 
 Sat, 10 May 2025 01:52:18 -0700 (PDT)
Received: from localhost ([157.82.203.223])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22fc82a4bf5sm29446015ad.241.2025.05.10.01.52.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 01:52:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 10 May 2025 17:51:50 +0900
Subject: [PATCH v2 5/9] qemu-thread: Use futex if available for QemuLockCnt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-event-v2-5-7953177ce1b8@daynix.com>
References: <20250510-event-v2-0-7953177ce1b8@daynix.com>
In-Reply-To: <20250510-event-v2-0-7953177ce1b8@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52a.google.com
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



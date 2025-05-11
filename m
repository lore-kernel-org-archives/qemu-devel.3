Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4031BC3ABCC
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 06:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDzsC-0002F9-CU; Sun, 11 May 2025 02:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDzsA-0002Eh-Jm
 for qemu-devel@nongnu.org; Sun, 11 May 2025 02:09:14 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDzs8-0003vq-MK
 for qemu-devel@nongnu.org; Sun, 11 May 2025 02:09:14 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22fa28c761dso24533815ad.2
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 23:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746943751; x=1747548551;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tpEeShMgw5miBNRuoBOGCybk4Qn7aitvfKahD59h2tI=;
 b=AhSeGWvxVV4vMYzf+gvd5w392tTmz5ntPXkbYqbyl7f6RNLkLDrafgX7xiuoYRf3r/
 0G97n7Xa5ChDNQwsUDcuHVKGx7df14mcIA9cL6RLja8w/4O4GUyVEg4+cENRqv3ew01B
 kKfaOsH/+6WYl3j18SuvNPY9Cw8VoXcgi4mbmylB+fKklrohuuVMFhSRE5XNzKHgp/uS
 iDtWhcLxxR5xeCsIrKZwaX7x1ST9g8JOKToi2YRLkOWg1D/bz2A+M+5sgFUPERZRkbZ2
 wUisp0GNjDWsEtgqHJ71iEazsUgVxXUsc4I04vA2IAddromIgQefcCjxR5sP91zJfwbM
 denA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746943751; x=1747548551;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tpEeShMgw5miBNRuoBOGCybk4Qn7aitvfKahD59h2tI=;
 b=T+/IjwvcB8JgcDwVjUgBFmySb9QMbpZcUevNbmcZs39frHfEpBiiD0ckSO47dPMSlh
 O+rlxx55L6CSKhevDhkftP54Vdq0//dzr4yu4vn9hayEfngWGRR1YvA8HNUleQJrDYB7
 uYIwf3CKNUS6fEl10pU1meL23yGy1H9OMKSe6ysgDsMbc/LjYpSx19AcQcnmrP7whxak
 /CzVjOsKXFulb8Y0TlXd5lut01EUVd3fyPTy3ZpDg2GwMh2yRPMrI3KdJz2YhXaXvZcN
 BdzqhtJ97c6itQt2w1Ncf+8PLq57n/nMzyRm1CcYWgXIyNYhXUE3LwYd2KN/QM0EN/1x
 +X5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgQj/3SS8TISxwGgRc9mhcpy9p4Uh1RQ6FMhTujscsiEQcOuLlMTgEOdu/s6y/1bfqqTe1vDAwKuiL@nongnu.org
X-Gm-Message-State: AOJu0YyKub5/WXiQlIlWx5VMW0R5DDBGIYYFPx6u39mdlJHSTp7UiHU5
 O0x5Byf4XJJH+1zq+02Y5GaORJT8rhydGja81yRBzh4g4pE14/7jVKK3yqaflLo=
X-Gm-Gg: ASbGncv01+lcPZYLidTr7FYWY4FtNboOV0EHj5/8M+6uZcJ5EH+avC85Sfi2QjKJtcK
 NMynXVVqyPmkc6ZX5jy7BYxHU7MqxoSjfhbLVj4mg5Kx0ECsCLaEFo5iNxxXgySxkZm9nBZgXsr
 bcvaBqH4+cRZYx5iDIwD4eHY7UIwhGhsdtrbItHWtnlEnZciRNjErIpbPN+LP5qkrX3YsDSUFbl
 D/NgVuOvf/KNDyUPoMW2lc9xFIjibTlHYmXGrnT4eo9GqjcUCj79V5O8IqizYkZGLkxxt87z0WS
 tEenS3c2VBO8kUmIa5OeUZjm2e4flI1lL3UBXdB9QPzQfOwZGGJo9Ko=
X-Google-Smtp-Source: AGHT+IEY7wvxnz3uvxKJrUo+La9xNnXMAu2NeSdWqQvPeXLmmbngsPkCRLJZCoGWnxVoky5ZbS6x6g==
X-Received: by 2002:a17:903:194b:b0:223:fb3a:8647 with SMTP id
 d9443c01a7336-22fc918fe99mr131860075ad.41.1746943751196; 
 Sat, 10 May 2025 23:09:11 -0700 (PDT)
Received: from localhost ([157.82.203.223])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22fc82705e5sm41845365ad.120.2025.05.10.23.09.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 23:09:10 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 11 May 2025 15:08:23 +0900
Subject: [PATCH v3 06/10] qemu-thread: Use futex if available for QemuLockCnt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250511-event-v3-6-f7f69247d303@daynix.com>
References: <20250511-event-v3-0-f7f69247d303@daynix.com>
In-Reply-To: <20250511-event-v3-0-f7f69247d303@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B53EF06E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpASc-0001Hg-EB; Sun, 08 Feb 2026 14:28:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpARG-0000e9-EZ
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:23 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAR9-0008VQ-Tf
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:22 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d1916d1e24so2928960a34.3
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578793; x=1771183593;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eIS23kxbxczTkTd9fyqEVyBaAcPXCz4C/tWVuntegW0=;
 b=oedlN70xy0qto/Z14DpGIkfGR2JO0M+/2nJjtruPRnvasd7mKp+IRzqKrwAt5pgGgo
 sM+IVTq3ygAI3JaFgbLQeijt+FWDuv/WY8OIX36hcPEcyKcB2EbhfED3ZnRwK57OmBbJ
 DhOyrSNa/gzT0ZhChgpGk0blPlHkUK9PJc1B9nQrkWT6K+Q0j90HUReituYI+F+ZLXP1
 q+hSqGz/nsWEQ9APdiAv83y5MtZnEp6R4bLhD+pSUM668kwW2aIZ1h6Au8Nrrl5tun5c
 9heonbw1Qce/2j2dOFL1xJW1wYytqRwBkewvKzh/Fmhuyj2eAp9e3MEhXIbEgPOBYAbc
 sTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578793; x=1771183593;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eIS23kxbxczTkTd9fyqEVyBaAcPXCz4C/tWVuntegW0=;
 b=aUxAvjw/PBysxqKlE6DP11wMAQvUCy9Bz1YMME+N6VmHeiWynYF+4K0XxyLQPGsFM+
 MaOMKxFe1riybVgcGUSCxThMsx7Y8RLrb3Ug2WxfHCGwnpgHQhEA9EAY4aTbWU9rAOwh
 PNZYAdL8pO2MiUOBh9O9p80ltSFnLxhiY2MgFiZrL3QKwscL/93DpELrxOtNf8MfNV2j
 4lbc8+IiQ75CVF4hlfYFV+HXfFSxcmzQa/5QeT/9rUetCjgD9L8HskCkORUtGeDNw2Jd
 yfB8478l0BGmBtZPL+kltBG1L4hLhjxELrqMm3XxygYofHii3szrMP9qTqYwfh7N/d3J
 Wv4w==
X-Gm-Message-State: AOJu0YylpPWXV//5O5Nj/J+qP5xXFaA3Ol2/pVOV6u/M0lQOcADh6sNR
 iNTy2dyQk2InM9P+dxIOUJ7Hv+db+QI+U1RmxRpyjfEFXz/lIdKjHsmec4ZZhjkr3nM=
X-Gm-Gg: AZuq6aJg14uXH2ldD/B2Zq6FGs16AXzL7S6+Fqs+u0JVWiV7JYjs6lwLtBxmZdGUfK8
 LGd8CKoGCVrBsLFlzABz+5STus7ESXGSu3lQG/1yeGni9A1akXDdjNKUDgq1ZPnIh1r8e2cHxeB
 LIA7ZiJkpwwJWf8H4sgY4Tg+q2lnjlmlNL/K+geMyakNkKUPkSLhnX3XYdKQ1j8Wuvf01YZ+nac
 JWU8hxaBlcOKvlukk1b5wjoNlJXe1pgBswUkMDb2jFCm1yJMoRyFNoInNsqXpjmF2OCPpaUUDSB
 oZFMyTl04yBqrZF1ufjAmjwF0kUXAJsmhYt0ainBAgpSe1S7puywZYHbBWusA47+li64dRPBOYs
 6VTCjAOST9EfadWiWhWQGUwWFAGaMNuhAKSUSe7NHDC2hgwOy+dAHkLAiR5oNObn7MmA1nlaCih
 G9VlX6sQeP4A==
X-Received: by 2002:a05:6820:207:b0:663:c86:e9e6 with SMTP id
 006d021491bc7-66d09ac045cmr3618835eaf.1.1770578793157; 
 Sun, 08 Feb 2026 11:26:33 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:32 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:16 -0700
Subject: [PATCH v2 07/24] bsd-user: Add target_to_host_semarray for
 semaphore operations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-bsd-user-claude-v2-7-58e5fcfdb84f@bsdimp.com>
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
In-Reply-To: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1714; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=fQTTJZxWvRkDOzmjm7pqV62DkOeFQ0ZfEtEDegHj38s=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONgFqIGcnBUjwQ1WQmCEp8vwloPWD2M2BGJ4
 gccMYixtmKJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjYAAKCRBsHNEofbAR
 ANTJEADspGEMqDGXUgIozzYeX3aVVmZc/ANjl+9rTCLf7/WkzZMX74AffArXCRnoxTl4a4PgpbA
 MXFiTPQGPfaX+09Wflu6AOcEUdM7TwiaYs5ERNRQXdn+JzFsTYYm+k0r0YV62uTQof6XO8IXcwa
 tFjqhxzIrT6sianWf8w7b0/JTRG7vUFE2FViqnmyGAhV+MbJuHVJ83FMXJBw4d3ATDT8QIVuDQy
 mzpYLOxnyU6Jvn1efF3zK2QuUGhV4wBYhSNObBVUI+TPpSLGHw6jZhm0hy2jJ44q+4oYK+6iLMR
 TzkCTjdlL5ycroNzI1n4aOT04Zi3GcUPweRUBqkUPsKBUEyNGBLi5348creotpKjfEkb8x232z5
 Z4CZg7YxYkuBk3w8lmrBKw4U8DSS04FLBk71FKmlsKERwo5z21t9uSEvQ4azUntROQXBX1LhhWe
 VS/WeyCjh+haCOh65QY3XArv0Jv8KEvfupuE74kt7JqaOCbY2hblmmbSlpMwimyVd0w2dLC5idJ
 5HGNLOx1oWW0zJk5bYTyvpJL9+Iw+RBQmcHkNKnAv0NxOfaZgKmcze+JA+PKnoJg0mLQxcvvcss
 FnltvjPKaYGEHZEPudpfbgnzsSDN0/UQWmpk6x9D+nWT7MikP/Hslka1Pbbbk4gp5zZxCoBJI4N
 YIwAQWUpfC4FAHA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x334.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Stacey Son <sson@FreeBSD.org>

Add target_to_host_semarray() to convert target semaphore array to host
format for semctl(2) SETALL operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index d2107b2f85..d9eb87db80 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -18,6 +18,11 @@
  */
 #include "qemu/osdep.h"
 
+#define _WANT_SEMUN
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/msg.h>
+#include <sys/sem.h>
 #include <sys/uuid.h>
 
 #include "qemu.h"
@@ -44,3 +49,33 @@ abi_long host_to_target_uuid(abi_ulong target_addr, struct uuid *host_uuid)
     unlock_user_struct(target_uuid, target_addr, 1);
     return 0;
 }
+
+abi_long target_to_host_semarray(int semid, unsigned short **host_array,
+        abi_ulong target_addr)
+{
+    abi_long ret;
+    int nsems, i;
+    unsigned short *array;
+    union semun semun;
+    struct semid_ds semid_ds;
+
+    semun.buf = &semid_ds;
+    ret = semctl(semid, 0, IPC_STAT, semun);
+    if (ret == -1) {
+        return get_errno(ret);
+    }
+    nsems = semid_ds.sem_nsems;
+    *host_array = (unsigned short *)g_malloc(nsems * sizeof(unsigned short));
+    array = lock_user(VERIFY_READ, target_addr,
+        nsems * sizeof(unsigned short), 1);
+    if (array == NULL) {
+        free(*host_array);
+        return -TARGET_EFAULT;
+    }
+    for (i = 0; i < nsems; i++) {
+        __get_user((*host_array)[i], array + i);
+    }
+    unlock_user(array, target_addr, 0);
+
+    return 0;
+}

-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB28EC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 17:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaHSp-0001qo-Rb; Fri, 11 Jul 2025 13:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaHSn-0001ok-7I
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:23:09 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaHSl-00032i-8R
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:23:08 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-40af40aef06so1221813b6e.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752254586; x=1752859386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j9c7MLf28ZTbIKD23Oq32+PYqLQBAflgfhnsqzK3gkY=;
 b=oM2kXR7886O8HgUWOwnHd0sKxjKNTw4NNVl1g9spxybWIMwxxgOOHu31UDFfkNqN6a
 WjtImwiGZlSwTloGC8kYwB2H0e0PBJtp7qarA4lflVCpOqYohJfT2huGZpCTTntXhAlp
 NshE4JPi7I67E+voOEVcHBkR7Q6cd9Fa2QimYTR83qUEeemvdfzmwOm9bS0bZC3iTe47
 rezX3QS33dma7pROyK1orkLbM63osAE9wjauFC5fOCVd/o/pNwq6koemtNJEExVeVQN5
 JSnTnTJSxlp4WKW884SOZTGC+HyDXUmGG7KcZZyoV7MLIFVa9EN9kxKViftneaweV9xD
 IopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752254586; x=1752859386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j9c7MLf28ZTbIKD23Oq32+PYqLQBAflgfhnsqzK3gkY=;
 b=iqzimvofFjMWfuosjdLdLss9/okxXbCgIDGdVKr72kESHlx9GE2smF99oIwuN6gEVl
 bVNE8ngKFo2PndQo/L+jOcQH0d4oCxvGGOmlZAOCDDBhdZVb8ZS+GOyX95n8atuYCabv
 UQFHpaiAsSgO71/2UyfdWuwuYwvurGHGW7jXmwm5ghUtbf0OmCRrOpX46zLOzAqksN3i
 rKtAcvfqnvFCRoiZWJVXrMVMDGW57yN3h7RetzmWFffzqfJr9RUOV7QFmBdWcl1yQv7x
 BUChGMmBTUNZNPAi00tUFaMfvYycI/ZH+YUzImUishUjeEmrge9xAUNKOGSAh9idshVq
 aSeQ==
X-Gm-Message-State: AOJu0YyUa0M5eDTZuesuFUh2Fcta+iFWkI+96zLEywpfzCdo0mfjSh+G
 sKwx0aNdHZMl3nbYKXWJUVhQ3ljp8mJrZFNqGY1Ok+sGvgvP+806BOeyjXKNtvfdwgheTIYziic
 1yrbOUvw=
X-Gm-Gg: ASbGncvBinx6BGdImJdkKs+xdzNhFCOTrOIMBSTwxFL2MmuiBFjT/PjcaYFEDQvrtul
 aZNEOeyGRxf3IiBaatV46FwRcbrg2AXzNEO0O7Lcy7JGBQYQu6D1gv8z37aTCIDvVdn4jA1sLjU
 +ehxr8+X0vCdo8fYueVco+z1m9MSCaVkjKPBFbqnZFxMmniGNaBcv5WimpAevdqykTNIqqJy3PX
 C4Ir5d2pMBX3XnoIbPWZf+VCZ6z9Kkysn7/XtMbGk97G96cLauTQXK9doVRtIlPbAotbokbxbNI
 AJUz4fdCVOOUfys2SLhp96rlamxvrygZl/84widjwU0jmM8zRN9R61mXJkrbGiqb/SHXvQwIh65
 H7+s47hBe/KUGK9pYtN19LmzXUp8AY1ZUrINvrKHYSZ5ZzcMdXRX30MrD57TyvP9vl0rXdZiwvE
 HFYYI4vjvkA+lBGYi0eck=
X-Google-Smtp-Source: AGHT+IHw3/nyT7cZtyEpyd8w5NxmZGvRfePs4WqPwcA4C1pXWxVaZiuhULOGMvaDsmQcz5tnAp7MSQ==
X-Received: by 2002:a05:6808:f91:b0:40c:f680:7775 with SMTP id
 5614622812f47-41511814a77mr3485333b6e.31.1752254586012; 
 Fri, 11 Jul 2025 10:23:06 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4141c77ada0sm602041b6e.44.2025.07.11.10.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 10:23:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 8/9] tcg: Use uintptr_t in tcg_malloc implementation
Date: Fri, 11 Jul 2025 11:22:53 -0600
Message-ID: <20250711172254.229201-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711172254.229201-1-richard.henderson@linaro.org>
References: <20250711172254.229201-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

Avoid ubsan failure with clang-20,
  tcg.h:715:19: runtime error: applying non-zero offset 64 to null pointer
by not using pointers.

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 6 +++---
 tcg/tcg.c         | 9 +++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 125323f153..0c2a319c11 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -357,7 +357,7 @@ static inline TCGRegSet output_pref(const TCGOp *op, unsigned i)
 }
 
 struct TCGContext {
-    uint8_t *pool_cur, *pool_end;
+    uintptr_t pool_cur, pool_end;
     TCGPool *pool_first, *pool_current, *pool_first_large;
     int nb_labels;
     int nb_globals;
@@ -706,7 +706,7 @@ size_t tcg_nb_tbs(void);
 static inline void *tcg_malloc(int size)
 {
     TCGContext *s = tcg_ctx;
-    uint8_t *ptr, *ptr_end;
+    uintptr_t ptr, ptr_end;
 
     /* ??? This is a weak placeholder for minimum malloc alignment.  */
     size = QEMU_ALIGN_UP(size, 8);
@@ -717,7 +717,7 @@ static inline void *tcg_malloc(int size)
         return tcg_malloc_internal(tcg_ctx, size);
     } else {
         s->pool_cur = ptr_end;
-        return ptr;
+        return (void *)ptr;
     }
 }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 50d40b9cbe..afac55a203 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1331,8 +1331,9 @@ void *tcg_malloc_internal(TCGContext *s, int size)
         p = s->pool_current;
         if (!p) {
             p = s->pool_first;
-            if (!p)
+            if (!p) {
                 goto new_pool;
+            }
         } else {
             if (!p->next) {
             new_pool:
@@ -1351,8 +1352,8 @@ void *tcg_malloc_internal(TCGContext *s, int size)
         }
     }
     s->pool_current = p;
-    s->pool_cur = p->data + size;
-    s->pool_end = p->data + p->size;
+    s->pool_cur = (uintptr_t)p->data + size;
+    s->pool_end = (uintptr_t)p->data + p->size;
     return p->data;
 }
 
@@ -1364,7 +1365,7 @@ void tcg_pool_reset(TCGContext *s)
         g_free(p);
     }
     s->pool_first_large = NULL;
-    s->pool_cur = s->pool_end = NULL;
+    s->pool_cur = s->pool_end = 0;
     s->pool_current = NULL;
 }
 
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB122C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 22:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua06f-0004m4-Hi; Thu, 10 Jul 2025 18:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ua06d-0004kO-32
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 18:51:07 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ua06Z-00040v-VC
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 18:51:06 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-611b246727cso696770eaf.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 15:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752187862; x=1752792662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sy3SZkcePzkyNyiYEyxCCVC2e0l22byb3XEX/kprAqA=;
 b=IjoplIMfFA7EVG9uAe//e2ndxkL/dfqw44d6HqaXirywteI2HEKbHi32SZlk5D3qnr
 P1G6zcKPU2H2Ueu3aec11vCfBEwyTnabLiPJDYRl7nU3qiWFeQXh3FfE3ZII7QplfRng
 ugSDbNqtGHFIvysQjd4BLZu/cIYOUCnge1yUyrQV0HWrBXJW57uhR/9kWuViXNnPQFY+
 QJfWNDB6ASOTgTXJKqn4iz9cxSJGEjjBHeAm1tYYm/XitUvbqSKKRj/XBjILv6ncHwTm
 i50OYJtp+T0ThtGg90kzHviBLKJgeflFhTqzfDHYODgaIk1wkzTaq8TvqLbeHD+QIml6
 AJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752187862; x=1752792662;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sy3SZkcePzkyNyiYEyxCCVC2e0l22byb3XEX/kprAqA=;
 b=daqIbLQwlLgtRQv2sgYYeSIIdikcdP1llXLUigexx4HkK5YO7O4cULTiGB1tiGyBTb
 uCJRk5OA2EEpg6UPLIyrrqKyGca3eETnWEG2F/e6eQV2kHvpio9PPRIbtp5alxYYEsI6
 42Ee0phXslyWQNOgupjS/U4f2n0ScByFw+2ZKqtHU7pXoxX7BoXDNhbR/S/K2n/iPbVj
 ztxTaN5lgW7kI7sFeC+9a9dABBSw+NvKZmyXWmstzEH8W8N681saTqXALUvsTDjZoOZt
 LofbeK6s2Rs+P8GyrYtD7py2svgrU7eN8jcmFDtd7Tb4dSjR8KCPZbblz75ZbRyAjmsb
 I76w==
X-Gm-Message-State: AOJu0YxvEnugNc5GNx281iTU0rV30cuxuSVG9jm2NxHlJAOy7jwy9pA3
 HxjC9rx0V4dyqdQNHcZqqp852Yx9VeBDz0Bea7GKUexQxp5r0yvYqgMQy5HpKKgHtOpBjfoxopI
 lmuod
X-Gm-Gg: ASbGncuvAOOEG16iP23iHU6xudVtTO5sdyKH2O0sJYfOUpt53ufdmKX5M/0GNPUTcNp
 hFPnirx6ecjtPTLahNkoLQzOaKZQn0IfVJ1gdDRg18YlO6gNeKS0bogMYX2DeIdBJWm5Ld8Aa8w
 zWrSAhnSamQ1L7LMIXq90RfsXRpfE+K0TrJHEhksXwZt5HL7EhkVw1Pgy+pOl/gFBSTpaPLH/om
 uCZ7Cd5qdsJSvYZCRghGOvWVH7+yPTXd6gr3FxzyAH0NckWWdONguWNfFmAh+0uFNs88Iz5aNN5
 gIhrg4jGkqt1JZtRRICeQeCSyJMQcyiJqNPlQVicXpqGjCeZraZ8JG1iNluw/3pQzpfxs7DWHRi
 Q7Zbh2S5OjkemNB39K2VbP92199+Scu2AUqZ0YVT9+KhsncvuiV9lOUdzez1qfk1bYG4kVx5Qq4
 KUSJ8xvvCv
X-Google-Smtp-Source: AGHT+IHj5W3YC7UQl5lN9ZpcE1lM08GhFq1IeWGMJBYWbC27h86Rjo5zAHSysWYZS/1Xg0/ItrcUsw==
X-Received: by 2002:a05:6871:5d06:b0:2d5:b914:fe2d with SMTP id
 586e51a60fabf-2ff270892c7mr745373fac.33.1752187861975; 
 Thu, 10 Jul 2025 15:51:01 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff111c35bfsm491670fac.1.2025.07.10.15.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 15:51:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] tcg: Use uintptr_t in tcg_malloc implementation
Date: Thu, 10 Jul 2025 16:50:53 -0600
Message-ID: <20250710225053.168169-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Supercedes: 20250618183759.9197-1-iii@linux.ibm.com
("[PATCH v2] tcg: Remove NULL arithmetic in tcg_malloc()")

Ilya, I think I prefer this solution to &dummy_pool.
What do you think?


r~

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



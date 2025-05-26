Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A1EC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJUVO-0005TV-Lk; Mon, 26 May 2025 05:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJUVM-0005TG-Us
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:52:24 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJUVK-0006yD-QT
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:52:24 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a365a6804eso1188801f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748253140; x=1748857940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aR6lRqD930QNwV0KQPKzvKXL6muKy4JBdOqOmeuiPZo=;
 b=XhhOrRCJDJemOVy5YZzniPk3f8laBBfMqeF7nhtp1KjDKIBn/4fI6turBX07iDZk7R
 iOVSwLQOcWXwxcV5Lfd/Mnxvwaq1chsv3tSyIL2yjN2d+fx/ISGyqsjLmmrjIsPjV+B0
 Y/ld0E5ecoF/nHKPhfJuYWSap9cf8Mw0IyU8nv/4q7fhwXKdwzQrwHlzTUgtOyXs0tMj
 IEaeNHZCQ1vGOC5oJAxo9c2rvXq5azt+nJXpFSPMOoVunnwmsnnRRVXRQUJC/dEPwHRZ
 hvXrv/5SZvlYV5tlcwq7z3x8w7qlzktZ6osgLvAy+Srp4njmRYmdWWhIE7hPkvAQVrPv
 MlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748253140; x=1748857940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aR6lRqD930QNwV0KQPKzvKXL6muKy4JBdOqOmeuiPZo=;
 b=m6ve4tWMTbahrMts9Pr9JMI52g3wio+u2p0+2M/KBCjGvTULGotkXIZemgUjQ3zPwt
 pastnXF7o9BPgIqlIgdeqzY7OqzO4D1MvgWvH9DvYSWUmD3pazCQJU67T8V7EocYhs1m
 spGECvscXvNd5MV5W0RZFQB6UBfWdan2FSOZQrk7TiAWm/bXXEzIxHxhj6wN76CeVTjs
 pUSbMtJDKbLgznaF05jhE7duoI6/HO7Q1KinKhSEO3BJEuSDtZu4J75BgiS/D/p51z0c
 pimq2ljT5IWHpjP3QrWUXqERh6Z890bg3iyyx1xL+gukwT0F1OykYBw3xw9TxSRCtZPE
 q9XQ==
X-Gm-Message-State: AOJu0YyQLVtE4mhvGB0KY95RhKec4uXAGpug08hwPL0FDArO7TBSUYJQ
 EAFIvmv3EKb19Ba57NoUZCQVO97sRrcMR55YePVL9t348Kvj7whCckF31vU/P9j/FK2zNl91eDm
 +NIUw3UHMDA==
X-Gm-Gg: ASbGnctDkH/o8kg+Ob1PmGlvnAEQec0ccWru3IzT99dLY9cQzbA7seKzal1gajrmXTY
 6DB4Qt2eY3nJt9Mvw2+fJZ95uDreI8D3Y7XXi0zagmhTc6MjuAxjzTKLODmoJ3D/ymy1tSWZ2WY
 mU9zhK2BJFp7hNDJ7iIVe3S6h244ploqBzripBUkMf6sZWVUXb+17C+/fBWFDEV8PmLfFz9i3xS
 sCGjQQeOas/fDAKYA4bYx3OYIpL/MiBGJ96KLNoHJwu5ExwtF1Lb7mpxYQmAfhx3TJA6wlWX+jG
 TyaL/4KJ0RNBzzZEtbtekDhBccu6jSHAaZ+ESyUD3HBU3KKywVFD83lU0DYVYyqpY7QRbCArSix
 qBwP2MDLA6DreXG73PI6Alx+21PXHCB0=
X-Google-Smtp-Source: AGHT+IGKIACfym+C4xWk0+bZ85wcdn30C9k9WhQcmEP9VptC0nQF6p/9S1rSMKpMNC94b7yToyIX4g==
X-Received: by 2002:a05:6000:4027:b0:3a3:7ba5:93a5 with SMTP id
 ffacd0b85a97d-3a4cb4601e4mr6901688f8f.26.1748253140220; 
 Mon, 26 May 2025 02:52:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4ce9dcc0asm6488300f8f.87.2025.05.26.02.52.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 May 2025 02:52:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/2] semihosting/uaccess: Remove uses of target_ulong type
Date: Mon, 26 May 2025 11:52:12 +0200
Message-ID: <20250526095213.14113-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250526095213.14113-1-philmd@linaro.org>
References: <20250526095213.14113-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Replace target_ulong by vaddr or size_t types to match
cpu_memory_rw_debug() prototype in "exec/cpu-common.h":

 >  int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
 >                          void *ptr, size_t len,
 >                          bool is_write);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/semihosting/uaccess.h | 12 ++++++------
 semihosting/uaccess.c         | 10 +++++-----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/semihosting/uaccess.h b/include/semihosting/uaccess.h
index 6bc90b12d6f..2093a498277 100644
--- a/include/semihosting/uaccess.h
+++ b/include/semihosting/uaccess.h
@@ -15,9 +15,9 @@
 #endif
 
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/tswap.h"
 #include "exec/page-protection.h"
+#include "exec/vaddr.h"
 
 /**
  * get_user_u64:
@@ -89,8 +89,8 @@
  *
  * The returned pointer should be freed using uaccess_unlock_user().
  */
-void *uaccess_lock_user(CPUArchState *env, target_ulong addr,
-                        target_ulong len, bool copy);
+void *uaccess_lock_user(CPUArchState *env, vaddr addr,
+                        size_t len, bool copy);
 /**
  * lock_user:
  *
@@ -103,7 +103,7 @@ void *uaccess_lock_user(CPUArchState *env, target_ulong addr,
  *
  * The returned string should be freed using uaccess_unlock_user().
  */
-char *uaccess_lock_user_string(CPUArchState *env, target_ulong addr);
+char *uaccess_lock_user_string(CPUArchState *env, vaddr addr);
 /**
  * uaccess_lock_user_string:
  *
@@ -112,10 +112,10 @@ char *uaccess_lock_user_string(CPUArchState *env, target_ulong addr);
 #define lock_user_string(p) uaccess_lock_user_string(env, p)
 
 void uaccess_unlock_user(CPUArchState *env, void *p,
-                         target_ulong addr, target_ulong len);
+                         vaddr addr, size_t len);
 #define unlock_user(s, args, len) uaccess_unlock_user(env, s, args, len)
 
-ssize_t uaccess_strlen_user(CPUArchState *env, target_ulong addr);
+ssize_t uaccess_strlen_user(CPUArchState *env, vaddr addr);
 #define target_strlen(p) uaccess_strlen_user(env, p)
 
 #endif /* SEMIHOSTING_SOFTMMU_UACCESS_H */
diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
index 4554844e15b..ff944d8c2f7 100644
--- a/semihosting/uaccess.c
+++ b/semihosting/uaccess.c
@@ -14,8 +14,8 @@
 #include "exec/tlb-flags.h"
 #include "semihosting/uaccess.h"
 
-void *uaccess_lock_user(CPUArchState *env, target_ulong addr,
-                        target_ulong len, bool copy)
+void *uaccess_lock_user(CPUArchState *env, vaddr addr,
+                        size_t len, bool copy)
 {
     void *p = malloc(len);
     if (p && copy) {
@@ -27,7 +27,7 @@ void *uaccess_lock_user(CPUArchState *env, target_ulong addr,
     return p;
 }
 
-ssize_t uaccess_strlen_user(CPUArchState *env, target_ulong addr)
+ssize_t uaccess_strlen_user(CPUArchState *env, vaddr addr)
 {
     int mmu_idx = cpu_mmu_index(env_cpu(env), false);
     size_t len = 0;
@@ -75,7 +75,7 @@ ssize_t uaccess_strlen_user(CPUArchState *env, target_ulong addr)
     }
 }
 
-char *uaccess_lock_user_string(CPUArchState *env, target_ulong addr)
+char *uaccess_lock_user_string(CPUArchState *env, vaddr addr)
 {
     ssize_t len = uaccess_strlen_user(env, addr);
     if (len < 0) {
@@ -85,7 +85,7 @@ char *uaccess_lock_user_string(CPUArchState *env, target_ulong addr)
 }
 
 void uaccess_unlock_user(CPUArchState *env, void *p,
-                         target_ulong addr, target_ulong len)
+                         vaddr addr, size_t len)
 {
     if (len) {
         cpu_memory_rw_debug(env_cpu(env), addr, p, len, 1);
-- 
2.47.1



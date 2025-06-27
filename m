Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B1AC77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 11:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV7DA-0005Aq-1z; Fri, 27 Jun 2025 07:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7Cr-00055L-9c
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:21 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7Cn-00077t-NU
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:20 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-453608ed113so19764705e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 04:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751023516; x=1751628316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFEb0bgv+2xGk9RmgZr4IJS3shLJx45QACChrHbJL0M=;
 b=JOv372kwf2xa92OfsjghTIAVDLabUBGLM42/hVfNqCtly8QJknYfCu4y2qbqRvD9x9
 JpsTj/n6vvYjbKSOitCauX5tcYIzFZcLYEYFMoP2ZKzbw0VNaAyL1VCeU0njg+bdAUT3
 k4odB6xPga9wgbTbDsvowEgNpopF0seDXhIwl4v2USXGnnUV8j3UbLahlbBbaBnf3ziW
 ydKIIZnK7eeCYWEW21Xxgu2ToVcFGRhtuiLZLbgTPDeGxP0LVfK0ZkCIwj08kjheWuB1
 9EOLQsGEFIngeMQVuJYbDOw+OQn+AR8LuTMpkdvFj5lKyedIGdCXUQ68ChFNq/TS9s6l
 FiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751023516; x=1751628316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFEb0bgv+2xGk9RmgZr4IJS3shLJx45QACChrHbJL0M=;
 b=Xf074khXjekaweDdaIVSFYpvD4Rfy86Y8okQZ0thJ6U8zP1rMt88iEFwrJDMPermBA
 FWBVvW7WiO3+//cKhfUUC7V1j43S1LnKNgIV/SEG5UqYxCHrnHMUwiER7t2PoG3jxAEh
 JxaFR/rDeXxolHjFCNXFwcjHJGMILpFYP8V/URRBOhcjpNHc4sofMo5PbCvFUvOB+Mzd
 hJg/8zDEAGxHiWnEXoORYitYBw3tbVOc2J8QZq/6LgjkC1OozOlMgx3hWS+cZKa9lJR1
 hTg1vE0LtaO3wtPU8eckY5afNA+xlc5B83nXHTXTUmLdqk6X/Cgikl1XFaZYt4iIG023
 Or4A==
X-Gm-Message-State: AOJu0Yx+B1kBNfeBr1R0x0P6PMwufhPG0e6zFFtK2Nc836veOp1i1yf3
 h4L2eumEbkn7quBPQyVxNasjmiSWk+KtPfVFLPCaj3awChBbnrCJheZsvBagCqFIgaI=
X-Gm-Gg: ASbGncvfvZWjud8gIv20KohmdN2RNra20XddYjJZrxgt1gvk4e6CZyp8bbAoXIvRmwN
 ORmzcFHeShij5WPcnNRtznkSZA4d8OSkpMQ4FdFzoACeXPYmHeGhcZa8+GwcUSIuwEvXvhdG0PN
 dCh3W/I6vUuC4/PA9gz0hgaWUHBfSC9YBK9eOPBa3l4+XCXr9Kf+bJexH4BxaCykMEDe1nWEyOq
 Gf0+pcdMGk8onQY/Tf+M0ExB/mge6y93fLCq0NyioVJFfLPPHZwiFyI5vXqjJRpciHRdSHtlheD
 p+qtt3Hq1DPG2huD+clJwndTADGkHBHWfDe5eQNLKykkfKImD8GKNek+sHJleeQ=
X-Google-Smtp-Source: AGHT+IESrMLOsO5v3Ll5bK0aV/YoVRqfvxfhpHS1NaRSAZ0R+zDjtml+XHBKyVWnq4JZ5pe3xhIIjw==
X-Received: by 2002:a05:600c:1551:b0:450:cd25:e68f with SMTP id
 5b1f17b1804b1-45390ac9011mr19595025e9.27.1751023515990; 
 Fri, 27 Jun 2025 04:25:15 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538233c05csm77901285e9.5.2025.06.27.04.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 04:25:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 751FF5F889;
 Fri, 27 Jun 2025 12:25:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 03/15] semihosting/uaccess: Remove uses of target_ulong type
Date: Fri, 27 Jun 2025 12:24:59 +0100
Message-ID: <20250627112512.1880708-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250627112512.1880708-1-alex.bennee@linaro.org>
References: <20250627112512.1880708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Replace target_ulong by vaddr or size_t types to match
cpu_memory_rw_debug() prototype in "exec/cpu-common.h":

 >  int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
 >                          void *ptr, size_t len,
 >                          bool is_write);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250526095213.14113-2-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/semihosting/uaccess.h | 12 ++++++------
 semihosting/uaccess.c         | 10 +++++-----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/semihosting/uaccess.h b/include/semihosting/uaccess.h
index 6bc90b12d6..2093a49827 100644
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
index 4554844e15..ff944d8c2f 100644
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
2.47.2



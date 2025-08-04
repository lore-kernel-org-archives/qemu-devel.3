Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329FDC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj0x7-0005ZN-8V; Mon, 04 Aug 2025 15:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj06Y-0001ER-5Y
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:40:17 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj06R-0001AM-3E
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:40:12 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-76bdc73f363so2879144b3a.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 11:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754332805; x=1754937605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gb/ReADUnlzi9AcO287uTsxkJfdtQt0rAfW8KkqAbww=;
 b=zMCNFRfAHmjl0d+ocNOY1g0YWXUbbL16gYhgW3z6jhfbivBloSIPft+57mgZmRZM1K
 2kfFkobctO7HAPQepWiumqs0WlX70Iu8h6SzZE6xkaXs0EIGxLn+R+H76/5bkm9fBqWz
 lWM8apa1uIlEKYF2YH065q5Xf8viv20YNAiSekFn3zWJmpgHu4KrJO4XiK+K6cVkuKLQ
 28eCE2fWbxsaUqq3qXrjGnfq7837JnSV+7OgbHKnwEakBQk0epHzz3g3+scWMNWwjVew
 cyTVODzHoknUNt5Uy/j62wQtnXro7LlM3eaD10iivxX4ffbbsiOVl+gMQWeh4CBPQPts
 HKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754332805; x=1754937605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gb/ReADUnlzi9AcO287uTsxkJfdtQt0rAfW8KkqAbww=;
 b=sYzVlLculYUeZgtDgsfD/xW1AJiS/HeL7yR7JULzgKYpDlOxIhwQTnV4aShCfOc2BX
 DulPDyPG62CCffFmONqQhvkUKiU2HdBBGs3yuLrO4lQqM7e/5osrGh7CxgB8o/MAGoH0
 r6MpTECcjx+i8SBfJOYunYqg8816WX4Fs/guDOJa1UAPMT08JMgY/6TWRhHPJrMUAiMC
 hcYfZL/VGWNYufLh89BlP/VkcD0NFa63qqT55zX4YbSgyN9zzUB4OStITG+9CeZNmy3j
 32fYnYSRzFlF879k48H1vjpNHMPFIfDC9o8NCheO/US9nuL7au9PI+e225b8Lxd9gnYU
 alMQ==
X-Gm-Message-State: AOJu0YyTf8khreHxWITBpDtzRGFuk8NJejj2bWYDcie88xR4YKREVMao
 XhwnJ6MKl8A0VGQqH99as0KyskWYm9mggHGzfHsQ70r0uGbiO86pCspz8FIxZ3siDA81FUys2kE
 ISZ5o
X-Gm-Gg: ASbGncu5LqTdtgCH5SsviVPmr+neXv+RhXWbcM3rstVCuG8p8KnfmMjGisOtyQpgvc8
 q7IaNhV1ThTYG0mPLaMyp9j5X5avBhHqAW+dI5Mv2BMDW8ciD97NcmPRkcLB7BfpcSz3zBR5Fhv
 bUUQCen30XQ7GREKiI971H7nXs6y2+hzFpRZCHwseIhIlQ6+rEJ3bidSUTuKSaTSG/QhV7DV/Cl
 EcTktLtZ8XEHiHpiNA81XtFS1dfFKa4r+WXlXAhgfuNmQ3tBnF974ZnEIW+kwW989RfBoEDKaxy
 SgKaNUPoiGe9CCgyf/Lghs6+Sk02DiFEd/aowzj8lJb7pzO0k0Zl7p2H/+O4xALEc4MhFWcxxlP
 HSl6LsR8MSHez4XhM7gcqDg==
X-Google-Smtp-Source: AGHT+IEhJ+hm/7krgWViWU9aVO/jARZNpLglTpvpKZedP0Ul0dkFCAHuQxR/Mdswcm/e9dY0lU1myQ==
X-Received: by 2002:a05:6a00:14d3:b0:76b:f9c9:2160 with SMTP id
 d2e1a72fcca58-76bf9c93355mr9373241b3a.6.1754332805490; 
 Mon, 04 Aug 2025 11:40:05 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bd78875cesm9940171b3a.15.2025.08.04.11.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 11:40:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, Weiwei Li <liwei1518@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 09/12] semihosting/arm-compat-semi: replace target_ulong
 with uint64_t
Date: Mon,  4 Aug 2025 11:39:47 -0700
Message-ID: <20250804183950.3147154-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804183950.3147154-1-pierrick.bouvier@linaro.org>
References: <20250804183950.3147154-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 semihosting/arm-compat-semi.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index c03096b253d..f593239cc9a 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -123,7 +123,7 @@ static GuestFD console_out_gf;
  */
 
 typedef struct LayoutInfo {
-    target_ulong rambase;
+    vaddr rambase;
     size_t ramsize;
     hwaddr heapbase;
     hwaddr heaplimit;
@@ -214,7 +214,7 @@ static LayoutInfo common_semi_find_bases(CPUState *cs)
  * global, and we assume that the guest takes care of avoiding any races.
  */
 #ifndef CONFIG_USER_ONLY
-static target_ulong syscall_err;
+static uint64_t syscall_err;
 
 #include "semihosting/uaccess.h"
 #endif
@@ -260,8 +260,8 @@ static void common_semi_rw_cb(CPUState *cs, uint64_t ret, int err)
 {
     /* Recover the original length from the third argument. */
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
-    target_ulong args = common_semi_arg(cs, 1);
-    target_ulong arg2;
+    uint64_t args = common_semi_arg(cs, 1);
+    uint64_t arg2;
     GET_ARG(2);
 
     if (err) {
@@ -300,9 +300,9 @@ static void common_semi_seek_cb(CPUState *cs, uint64_t ret, int err)
  * is defined by GDB's remote protocol and is not target-specific.)
  * We put this on the guest's stack just below SP.
  */
-static target_ulong common_semi_flen_buf(CPUState *cs)
+static uint64_t common_semi_flen_buf(CPUState *cs)
 {
-    target_ulong sp = common_semi_stack_bottom(cs);
+    vaddr sp = common_semi_stack_bottom(cs);
     return sp - 64;
 }
 
@@ -389,9 +389,9 @@ void semihosting_arm_compatible_init(void)
 void do_common_semihosting(CPUState *cs)
 {
     CPUArchState *env = cpu_env(cs);
-    target_ulong args;
-    target_ulong arg0, arg1, arg2, arg3;
-    target_ulong ul_ret;
+    uint64_t args;
+    uint64_t arg0, arg1, arg2, arg3;
+    uint64_t ul_ret;
     char * s;
     int nr;
     int64_t elapsed;
@@ -462,7 +462,7 @@ void do_common_semihosting(CPUState *cs)
 
     case TARGET_SYS_WRITEC:
         /*
-         * FIXME: the byte to be written is in a target_ulong slot,
+         * FIXME: the byte to be written is in a uint64_t slot,
          * which means this is wrong for a big-endian guest.
          */
         semihost_sys_write_gf(cs, common_semi_dead_cb,
@@ -688,11 +688,11 @@ void do_common_semihosting(CPUState *cs)
 
     case TARGET_SYS_HEAPINFO:
         {
-            target_ulong retvals[4];
+            uint64_t retvals[4];
             int i;
 #ifdef CONFIG_USER_ONLY
             TaskState *ts = get_task_state(cs);
-            target_ulong limit;
+            uint64_t limit;
 #else
             LayoutInfo info = common_semi_find_bases(cs);
 #endif
-- 
2.47.2



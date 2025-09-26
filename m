Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C079BCAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28Lf-0008Ep-Eg; Fri, 26 Sep 2025 09:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Ld-0008EN-7z
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:53 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Kw-00043r-17
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:52 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e37d10f3eso13265515e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 06:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758892677; x=1759497477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g/wqUDizy/NPKiHOFvPLPI/kIFdDzcoQO4p7ilmmc2A=;
 b=se1QDSdqYGcDisCrCL9JL9hexJNcB32m70iRujILgiQKjs46g8Ro6+LLq1E9g+EoMj
 Ox42oZyOpOnoxJSNKT8ZIzCEwP2jpsjPYvhYyUhepQJ4FkToe6wO3V3jQ/V5ALXSTQgo
 G/TxqUyMRXs2MWgKgyjWMIHy3nBRvYruKmC55ylKBi/R/0yjrumh/u8YcCLVMwaXZ4rl
 BPBE7nDl5sP+Ih30nJ37/uyB32JbJOWUnCMG6flQwZjes4fIoWcsW0klVBNhCN/8QdWi
 5dFlfw6MQUEFtTuIvxTlUARYEw/n7EEd6NQb8noD2AoX1aU7LuN8Mdua9vKvjqy0ouPC
 kQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758892677; x=1759497477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g/wqUDizy/NPKiHOFvPLPI/kIFdDzcoQO4p7ilmmc2A=;
 b=KNp3OEqhPjNsprkRUB+sw7N5E7j67hAXohScKQd3ql27hVP4ZQ8Hzty8KFvVlwnW4J
 FstVkpVn/2wcK0Cd7RGBY9OUh/tGj6CGLZJK6vo0o1OyXLsIwuOA9eZecODQmUz6eKtM
 5ibGnMvN+HqBloBe6W2iTNaRM/wl4zYj0F8MtMgp5McAJAK87Os/DOk9ZgSpGpujAKk2
 ifQu5LWWNZkpKnhmyqnSnViPI1MklwUP9boZ0OKehbeHsPa+eCMWfS/qY8QWeNTUKW7w
 jVMFiRWmQa06ApVVDlNAqHuGlTHQRHqqFYiJ16paU9OzAqc50VI8+3cKNGlfZHGNWUCJ
 VNVg==
X-Gm-Message-State: AOJu0YxsbzFyxe2ose8sSLpDiEhD010vYzwAzOS9tLESlwc98GytXjdM
 Kn90Rpq9XXuBlp5r8BubOU1uUdNWzQqbm+M/SF7bZyI4muLo5plTfirzmGOxtokWSD0=
X-Gm-Gg: ASbGncumFJbNrLjL68DRwIBm9dD9tn9NYTqME7bFavm82RObdNw5ZKqES8GALi96oCP
 Bvy3Vy7q1JgK71l1SnvIw0Udc/gVHVj66QRrAFe0Tpz4e8GxNC4ZA1AkJR/Jx9Q6gbkGL2Djs3J
 l1zuGqEQNBadigK7Vj/7TRDtIIkxoI/cIQ9GlfYE/obfjntnSfvRulV8eTabBrDKiaNQSvTS3k9
 06DjELE2fKLWeVpoAzkuFKPj6FRERVUIwkEvV6kw/1Sa+6fuRlKlM1q6DN5/lLUE6/I1/LEQouD
 YZqVLTic6mXfppyXD3Cemqnx5giBiwU7C2BQEdaEMMTQOtBzqOdNjgXNs/vLeMDtRWD1ZK9GhzK
 Mlu/1epafEM3HJQ2F6L3xnOU=
X-Google-Smtp-Source: AGHT+IEoyHkdMfK1FRJOTXJvPf43Jy2hYNLPEhhHi572lzLKYHFg7hPb/WfAZ/SwMOSpOVplD8VUGg==
X-Received: by 2002:a05:600c:4ec6:b0:46c:7097:6363 with SMTP id
 5b1f17b1804b1-46e329b441cmr64975835e9.13.1758892676415; 
 Fri, 26 Sep 2025 06:17:56 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb9e1bd14sm7371958f8f.28.2025.09.26.06.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 06:17:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C8CCB5F910;
 Fri, 26 Sep 2025 14:17:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 11/24] semihosting/arm-compat-semi: replace target_ulong
Date: Fri, 26 Sep 2025 14:17:30 +0100
Message-ID: <20250926131744.432185-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926131744.432185-1-alex.bennee@linaro.org>
References: <20250926131744.432185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Replace with vaddr or uint64_t where appropriate.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250822150058.18692-10-pierrick.bouvier@linaro.org>
[AJB: tweak commit message]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250922093711.2768983-13-alex.bennee@linaro.org>

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 6725dcf4ba7..29cdab66f73 100644
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
@@ -688,7 +688,7 @@ void do_common_semihosting(CPUState *cs)
 
     case TARGET_SYS_HEAPINFO:
         {
-            target_ulong retvals[4];
+            uint64_t retvals[4];
             int i;
 #ifdef CONFIG_USER_ONLY
             TaskState *ts = get_task_state(cs);
-- 
2.47.3



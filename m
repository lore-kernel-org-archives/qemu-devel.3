Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3101CAC5AA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 02:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0swk-0004Qs-BW; Mon, 22 Sep 2025 22:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swZ-0004IF-CK
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:51 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swI-0003hF-RH
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:50 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-77d94c6562fso5075577b3a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 19:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758595169; x=1759199969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tqfT+leZhy7Rg922mo2u8oPpLUYve9eJPBZJd2GWVis=;
 b=I3M2/Dmhwi4M106iH8BPZhLk+HEJvn6Z4zCWzwT7xDdQuoIMxgZzx65eZTNwsaxMBs
 4l9a51La/Sr2hz5BB8NUkE+aRuJhLZDFngJgig+4KS4+RYTuqcWE0bb6CuN4Q3r4tm7+
 RV/yc8w3Nu7b8Kv/3BH+n6I0jwzlbs8lIKe7REDyFU8lE9H1lPzW9LKEIUoXskD6sIdR
 b+Z1OKYd3co+F4VhNojWJ/arKvoK1xSunXzLL2V6Or7YRZvg5lij0gqyil8kB6a0vG2S
 A0ySRObbiMjVSFtIBW/bqnjxKsUi2klqdk7ilwCXvotn06GYE4IBdovzhFbPxoQ+eNjZ
 gBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758595169; x=1759199969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tqfT+leZhy7Rg922mo2u8oPpLUYve9eJPBZJd2GWVis=;
 b=iCS5meeHhQR8asYjQk6HWuXzTF4Ygi/D9TD2HO5FLnlvR+4JB2IIu6TLBIB9eTOJVL
 fVic6pdhzHEKaeFmi/Zc9KbN2ylj2Mbjm1bPpzZGhAvPQkBxKcqKgoLm6JnnRxTTkVUE
 myQFH6LEzX4Q9N3ulAbmCDEIvuFC6GMHADOAVH1zaaBlZPvkz7+CqlUyXvQxNermHwYT
 BQYfgeFxmez3ImGiatvEzk/yVCTKQ7x2dk5p29q4tTHv6Z6uedGIialzUCGCTdBAlmWo
 9KCX216vbD6D6Pyf9DLCFMUHbk6nR/uc6auQUdD+va/oNt2AkYC3tt221Cwl1PzBROeJ
 Bckg==
X-Gm-Message-State: AOJu0YzfLiKlclC/nJt3OpOJ518PA5mu0ux3mLetxQsLQtTz3alaHOhq
 csgp2Pw8pEfSoCcwKUU+3O6E/ZmNUX/NNnYPdiE3ATxzoJxHxr+en3wzRV8CYhBHXdvFmLXKYbJ
 JsCsx
X-Gm-Gg: ASbGncsSv2Sich3O1VG2QEVgeZZBAvR2zg19egZ5T2AV9iwTz3lO9TlGC0cj93Yr060
 /Wl92cO/nLLU0mRtDqLVdVdoHr1n5URBX9fdY1ohmZ9qAmidmeexXwV4jQ126TNzUeDle8xPd51
 RVdmUy5zlIIcxhAoAC+MDvrUL8+WQyhLdq+VUHlqrbEapvz2xRlGjyz+DZrd1O/EfQlcScTetoY
 RgRplh8Ek1lroX++QVNu5nLsJf5Y8jv5XRY6G7PmYmPJUyuxD0588B2OsgqnPFraAgwM67HjfI7
 eqFYJokJyA0uI1TqN2iDF/mxQ9eDpCPI7xvxxKrP41etH1Ofzb5ndQLuas43d7mtwclIDhreDpe
 IBGodJUCku8JPJBdiZvQxYdnFoE5At8keomH7zfE=
X-Google-Smtp-Source: AGHT+IErno92lfG+bJ1b4AjLPNa+us69nGKrvhN9BIwPqCk9C/+OIn0I3J2Bi71XpwCNL9PhpsWnWA==
X-Received: by 2002:a05:6a00:b91:b0:77c:6621:6168 with SMTP id
 d2e1a72fcca58-77f53ae6f76mr976584b3a.30.1758595169079; 
 Mon, 22 Sep 2025 19:39:29 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f0da43089sm9899622b3a.90.2025.09.22.19.39.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 19:39:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/12] linux-user: Use tb_flush_exclusive to start second
 thread
Date: Mon, 22 Sep 2025 19:39:11 -0700
Message-ID: <20250923023922.3102471-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923023922.3102471-1-richard.henderson@linaro.org>
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

When we start the second thread, we discard all translations
so that we can re-do them with CF_PARALLEL.  Since there is
as yet only one cpu, and we are processing a syscall, there
are no live translation blocks and we have exclusivity.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c    | 4 ++--
 linux-user/syscall.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 002e1e668e..bd2bbaf1f4 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1010,7 +1010,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         CPUState *cpu = thread_cpu;
         if (!tcg_cflags_has(cpu, CF_PARALLEL)) {
             tcg_cflags_set(cpu, CF_PARALLEL);
-            tb_flush(cpu);
+            tb_flush__exclusive();
         }
     }
 
@@ -1450,7 +1450,7 @@ abi_ulong target_shmat(CPUArchState *cpu_env, int shmid,
      */
     if (!tcg_cflags_has(cpu, CF_PARALLEL)) {
         tcg_cflags_set(cpu, CF_PARALLEL);
-        tb_flush(cpu);
+        tb_flush__exclusive();
     }
 
     if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 91360a072c..d9c394856f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6633,7 +6633,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
          */
         if (!tcg_cflags_has(cpu, CF_PARALLEL)) {
             tcg_cflags_set(cpu, CF_PARALLEL);
-            tb_flush(cpu);
+            tb_flush__exclusive();
         }
 
         /* we create a new CPU instance. */
-- 
2.43.0



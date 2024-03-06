Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12801C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsS7-0007co-Jk; Wed, 06 Mar 2024 09:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsS3-0007O6-BL
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:40:59 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsRx-0001Tt-9C
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:40:59 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33d90dfe73cso614845f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 06:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709736048; x=1710340848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nviOiWVWbJ3XjGVXW4/AZHv8DEOjXGh4DiERqDJEuQ4=;
 b=lorAkO2b7j/zbXYiVsPKjOt3PZXMCY+mSZ7BULkeJkjXnr97ytVWR9k3tiv7VtUKqX
 sZ++j+lK/k0d9CStwhex7Ow2OPsYepXL+UaPPdMg0VVgqYf6WE/lSECTp1u4JK1XjuE9
 ctVaYQOh4+W33IEODprBax72Wo+297vD4l39O2TPRW/6Jub0xx/BzBd+ifldgym39CHF
 P4e3L2MBs17/3FhY8Jbm8d2AKTP7fhq4DRZDOi/JUA1eOQXosmFO8ClY6QoScehRwZz4
 l3lXFtVyi2dYoNAiNTZyTWXHNLULFnLkbXy68IbeZE2r6HD0qDrMVOg5+KGJp2Qq9td6
 ZGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736048; x=1710340848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nviOiWVWbJ3XjGVXW4/AZHv8DEOjXGh4DiERqDJEuQ4=;
 b=mPotsysm1R9R2zs0v5zqc85wqpCJ6EV67nyZa8Bb8L6HCBnXF+zMvZoce8LiSf3lw8
 i4VWdhkBGfMcxMgI+PT1Uq4c7eG3WAGj2ZQWbQL9soT1m1FIpPAE+ePPyGrMED3w+QZI
 aOhMeKZaTU0JPxkMDE3Ns5lX1xSTW5Kl0+xEGBfqlRGikA9o9Dw9ZG7m4f0yNi2L+PhK
 gSVX6hSe3hOBKRBXEf06ytLDYB7YWj425CRi14hL2iY03w4qZ+btcMyfEeRyzLCHCcI0
 7k7o48RZFDVku3Mo0Y2eCxt61tZWWdNuuih9i4fqq+Ilzvfw3u/G1TbHxd8RjQvTurv2
 /aUg==
X-Gm-Message-State: AOJu0YxUcNEevbfsa34HnBloI9XTxi72/OFkpu5X96dH2Lnq4S+q5w9R
 ngMW5S9WbQzlmtHSRKaXC84Z9IxaFbISZpAig6hSPzMtWmnKj7x17kSpyaqVltKzkZ+1W9aXrpe
 i
X-Google-Smtp-Source: AGHT+IG5TcZEFOC0RNFcDJVYOC8ElAkOG7kdVOHHrhvegrEBII+k8NRpBqX2OOpejx3qi2ENgmWqdA==
X-Received: by 2002:adf:8902:0:b0:33d:69c1:e7af with SMTP id
 s2-20020adf8902000000b0033d69c1e7afmr4427895wrs.9.1709736047766; 
 Wed, 06 Mar 2024 06:40:47 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bj1-20020a0560001e0100b0033e48db23bdsm4998270wrb.100.2024.03.06.06.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:40:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A1D265F9CF;
 Wed,  6 Mar 2024 14:40:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/29] gdbstub: Introduce gdb_handle_detach_user()
Date: Wed,  6 Mar 2024 14:40:23 +0000
Message-Id: <20240306144041.3787188-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306144041.3787188-1-alex.bennee@linaro.org>
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

The upcoming follow-fork-mode child support needs to perform certain
actions when GDB detaches from the stopped parent or the stopped child.
Introduce a user-specific hook for this.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240219141628.246823-11-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240305121005.3528075-12-alex.bennee@linaro.org>

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index b4905c7181a..b4724598384 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -198,6 +198,7 @@ void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx); /* user */
 void gdb_handle_set_catch_syscalls(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_supported_user(const char *gdb_supported); /* user */
 bool gdb_handle_set_thread_user(uint32_t pid, uint32_t tid); /* user */
+bool gdb_handle_detach_user(uint32_t pid); /* user */
 
 void gdb_handle_query_attached(GArray *params, void *user_ctx); /* both */
 
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 3eb93162aa8..17efcae0d0e 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1024,6 +1024,12 @@ static void handle_detach(GArray *params, void *user_ctx)
         pid = get_param(params, 0)->val_ul;
     }
 
+#ifdef CONFIG_USER_ONLY
+    if (gdb_handle_detach_user(pid)) {
+        return;
+    }
+#endif
+
     process = gdb_get_process(pid);
     gdb_process_breakpoint_remove_all(process);
     process->attached = false;
diff --git a/gdbstub/user.c b/gdbstub/user.c
index b048754c4f8..1a7b582a40d 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -391,6 +391,11 @@ bool gdb_handle_set_thread_user(uint32_t pid, uint32_t tid)
     return false;
 }
 
+bool gdb_handle_detach_user(uint32_t pid)
+{
+    return false;
+}
+
 /*
  * Execution state helpers
  */
-- 
2.39.2



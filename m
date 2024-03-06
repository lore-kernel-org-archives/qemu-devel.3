Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6C8C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsS5-0007RR-FK; Wed, 06 Mar 2024 09:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsS1-0007He-Mk
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:40:57 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsRx-0001U4-9P
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:40:57 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-412f988d552so3111965e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 06:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709736050; x=1710340850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jj9/o2DyJDCE0FhDPwfUuDQ3010vyufY1i8QLxETkb8=;
 b=EbAFzWgGn/cw08LVjK3s3PI367efrPXzGMpMLr5EaiWLLRu0HoKDcjhwk75lFrbAKV
 4Ml5DLVrXUvyr3KNzpytC/Mgtxw76Hd+IqoIR9KDIyMEsB8oAX826RjSPwOSqt+7ZWqV
 4jNNsfQZe9ffNudulaQBLVhxsl780HgLO5c9au+Ek0ZWoJ99kkjtQip35xuaDFP7JshB
 lrVaYA/F8jCmbudlbaz7FVN9nFHuk3p/U3sQ5hSbW+eGTevU9+axKAvoIR23iAabfojG
 hnUh5UfCDPFzEtRV7mqAscdcmG3STMIpaINQe13q5GAKpe3bXySBoKm7PdlmsDgyiPRK
 dZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736050; x=1710340850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jj9/o2DyJDCE0FhDPwfUuDQ3010vyufY1i8QLxETkb8=;
 b=tyGzOpt4s56PnQ+/1u1NzipxPSSlH3QTPrj5/jOnb2qqA0mx2EnWxDAlo2WkIX8gZv
 +b4zvq9y+oN/wvBsdHoay4M0a04yal82r+GyXzRiAuoINb3rz/EWwMmEI//CgEuqn0UO
 osgq1j0YrP8GN4g20CVflgPXvWS7UsdHCROjQX/mXt4ATs6S8Amzwg5pHMfsHZXSgQNF
 dHigj4RK1ssTwNN6diNRC9swqr36Y1YBf5PW5osEM6+dU44vFxzLmzTXJ/DYAq2f9zYv
 Xrrp3HOd5do3Ocqg8MGBCwnyRDXuTukB+muTa8xW9aq8YqDd745dSN/gMk62tV75PMO7
 q/oA==
X-Gm-Message-State: AOJu0Yxq5PXz4QflJYBVzCrxWn4mOn2j4R5kjYiJkEWcQPxRa7yO6Yd6
 qhNUlkKM0pySm8bSppQhFR/NkxELKRdfx7oUOYo/XfhKQSeRehGU3TXgsuHJi8A=
X-Google-Smtp-Source: AGHT+IHlIqr1ytYFQnjbdF9zum9yzQ8P9Ri4gjI7w7e0QFrA9b0pFdcyQOlXgwEjgjbi8iSnV1pu3w==
X-Received: by 2002:a05:600c:1d87:b0:412:e7d6:4464 with SMTP id
 p7-20020a05600c1d8700b00412e7d64464mr5534316wms.32.1709736049842; 
 Wed, 06 Mar 2024 06:40:49 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p7-20020a05600c358700b00412b6fbb9b5sm12114412wmq.8.2024.03.06.06.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:40:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8E3185F8A9;
 Wed,  6 Mar 2024 14:40:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/29] gdbstub: Introduce gdb_handle_set_thread_user()
Date: Wed,  6 Mar 2024 14:40:22 +0000
Message-Id: <20240306144041.3787188-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306144041.3787188-1-alex.bennee@linaro.org>
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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
actions when GDB switches between the stopped parent and the stopped
child. Introduce a user-specific hook for this.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240219141628.246823-10-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240305121005.3528075-11-alex.bennee@linaro.org>

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index e6063835b1f..b4905c7181a 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -197,6 +197,7 @@ void gdb_handle_v_file_readlink(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx); /* user */
 void gdb_handle_set_catch_syscalls(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_supported_user(const char *gdb_supported); /* user */
+bool gdb_handle_set_thread_user(uint32_t pid, uint32_t tid); /* user */
 
 void gdb_handle_query_attached(GArray *params, void *user_ctx); /* both */
 
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 7be4418dcb5..3eb93162aa8 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1099,6 +1099,7 @@ static void handle_cont_with_sig(GArray *params, void *user_ctx)
 
 static void handle_set_thread(GArray *params, void *user_ctx)
 {
+    uint32_t pid, tid;
     CPUState *cpu;
 
     if (params->len != 2) {
@@ -1116,8 +1117,14 @@ static void handle_set_thread(GArray *params, void *user_ctx)
         return;
     }
 
-    cpu = gdb_get_cpu(get_param(params, 1)->thread_id.pid,
-                      get_param(params, 1)->thread_id.tid);
+    pid = get_param(params, 1)->thread_id.pid;
+    tid = get_param(params, 1)->thread_id.tid;
+#ifdef CONFIG_USER_ONLY
+    if (gdb_handle_set_thread_user(pid, tid)) {
+        return;
+    }
+#endif
+    cpu = gdb_get_cpu(pid, tid);
     if (!cpu) {
         gdb_put_packet("E22");
         return;
diff --git a/gdbstub/user.c b/gdbstub/user.c
index c9e8b83d720..b048754c4f8 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -386,6 +386,11 @@ void gdb_handle_query_supported_user(const char *gdb_supported)
 {
 }
 
+bool gdb_handle_set_thread_user(uint32_t pid, uint32_t tid)
+{
+    return false;
+}
+
 /*
  * Execution state helpers
  */
-- 
2.39.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625A4C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsS4-0007Q4-KR; Wed, 06 Mar 2024 09:41:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsS3-0007Or-If
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:40:59 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsRx-0001Tz-8z
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:40:59 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33d9c3f36c2so1158809f8f.2
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 06:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709736049; x=1710340849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=soJfHp369BNDgXM8MEutI1aVk/FtLr15JEFPPe/Y+aw=;
 b=BN9ky0vGmQDhv6nUjiPsINkWHSt8zA3q8wcMkLECZOy10slKLaSW5ZEsqZpm69MVIC
 rdOWTDmaKmI9u+c5+hV81YEQjRaJTctmOFChnRGg7IS+jrEgrardBoEeLix/8aAiBGzQ
 lyU0bGPTSly9SlmtwSr3LofDDmBVyCdy0yMJ8S9cvTCuQqnJD4nrRrMNgcUk4863udkb
 4Y+WJuUF5g4t2QsMkeFzFPugWfUF25yuHPDKixVENgwnxvNUdQmphginqKIJnqkUgrog
 7QJXoQ9mep1BcWve5Xu4JzZb/Rr5C28NVpCkyxpvkRyqHYtJIpdbmjY2di6Lt9pJkTqV
 S9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736049; x=1710340849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=soJfHp369BNDgXM8MEutI1aVk/FtLr15JEFPPe/Y+aw=;
 b=KiLUMb96W2ub1kuZvaoGx28dVb5YgeKxrUsY3hbR+fCQ2F/pnhUDGPSvAVvk5dISXz
 kGZw7QGRHd3jlkDIn6xFNIDpMq5r+rZjNfg1oCR3O3KB5OIVsmapK/PtHDiRYGy5vDlx
 8Smf/R+qXVOf8Joy1QHzQRaEjVm7mC8SYz6HHbPf2Fvnz0FdBSceammVW4D22eFmlcPD
 TUOeaR9yKdoDoqdVFebt5BQDIvNXOHfWsCcNvGUf5Knm+Hdaki4jiBpM9s2hQUAI5KqK
 QU7/zIsQBXg0lPEmrforUyd5snqQtWfeRaW5SxBFgMEEoW/rfGi7HlkRVKcJE9UPW7mv
 VF9Q==
X-Gm-Message-State: AOJu0YyjwE5RlaR1uJ+/wp9HAL5WDDv5x3sv8Tj4X3WwCOAE/XWSwA9Z
 m8DRV6TSxOBwO33PFWWMyvZQNRL8ufBW6Cl1oGQ6RRJ8WayMSkYuxN152g+9nqs=
X-Google-Smtp-Source: AGHT+IGd1z+Vh9m+OUvvvf14GpCGogGRJepxf8zuguXq/e0sEOVfhrAcgxSwGi2m9JNmWpbQhbmTxg==
X-Received: by 2002:adf:e60b:0:b0:33e:ed4:f9f6 with SMTP id
 p11-20020adfe60b000000b0033e0ed4f9f6mr11093285wrm.37.1709736049335; 
 Wed, 06 Mar 2024 06:40:49 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v7-20020a5d59c7000000b0033e475940fasm5392620wry.66.2024.03.06.06.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:40:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 78B705F9CE;
 Wed,  6 Mar 2024 14:40:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/29] gdbstub: Introduce gdb_handle_query_supported_user()
Date: Wed,  6 Mar 2024 14:40:21 +0000
Message-Id: <20240306144041.3787188-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306144041.3787188-1-alex.bennee@linaro.org>
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

The upcoming follow-fork-mode child support requires advertising the
fork-events feature, which is user-specific. Introduce a user-specific
hook for this.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240219141628.246823-9-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240305121005.3528075-10-alex.bennee@linaro.org>

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 56b7c13b750..e6063835b1f 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -196,6 +196,7 @@ void gdb_handle_v_file_pread(GArray *params, void *user_ctx); /* user */
 void gdb_handle_v_file_readlink(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx); /* user */
 void gdb_handle_set_catch_syscalls(GArray *params, void *user_ctx); /* user */
+void gdb_handle_query_supported_user(const char *gdb_supported); /* user */
 
 void gdb_handle_query_attached(GArray *params, void *user_ctx); /* both */
 
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 2909bc8c69f..7be4418dcb5 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1655,9 +1655,15 @@ static void handle_query_supported(GArray *params, void *user_ctx)
     g_string_append(gdbserver_state.str_buf, ";qXfer:exec-file:read+");
 #endif
 
-    if (params->len &&
-        strstr(get_param(params, 0)->data, "multiprocess+")) {
-        gdbserver_state.multiprocess = true;
+    if (params->len) {
+        const char *gdb_supported = get_param(params, 0)->data;
+
+        if (strstr(gdb_supported, "multiprocess+")) {
+            gdbserver_state.multiprocess = true;
+        }
+#if defined(CONFIG_USER_ONLY)
+        gdb_handle_query_supported_user(gdb_supported);
+#endif
     }
 
     g_string_append(gdbserver_state.str_buf, ";vContSupported+;multiprocess+");
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 866a25f9c06..c9e8b83d720 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -382,6 +382,10 @@ void gdbserver_fork_end(CPUState *cpu, pid_t pid)
     disable_gdbstub(cpu);
 }
 
+void gdb_handle_query_supported_user(const char *gdb_supported)
+{
+}
+
 /*
  * Execution state helpers
  */
-- 
2.39.2



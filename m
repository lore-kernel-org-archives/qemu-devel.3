Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C17C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 14:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrf4S-0000qE-1U; Tue, 02 Apr 2024 10:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf4P-0000oC-PL
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:25:01 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf4M-0007ey-Ck
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:25:01 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41569f1896dso11754595e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 07:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712067896; x=1712672696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AnqQaUG1ZoPVgZF2Ex29MI5m2mNV0++IO/ZIMEDgcJ8=;
 b=KaaWZEWuBTXcgD+t8c+UuZgyzchRVRKAKfidaFXEGMXyahqM7coIWX70CvU/Lp+BPP
 QwsmuXrLgXZArjO7JkNZJGyL1MujOdIYcoH6HpuCZL4Kq6rEYd/H20Wdmr6JF6AAZ6V3
 1oxsqpkKDjRpqmuu3IdqsoVzParI2lV+CspYzKdH9uUM8u7RDO9mrdHbZq4VbJD6yEx8
 6lQ8AIoqVQ0Dr+tVmoDlPfIM52fH4/vl3Roie0gKNvtafrOoi8KRqYHPi5HB/yq99lux
 8tlvnNKFRNYuQYlnkfhrGdk8XTeMqupXdIwoVtrZgqMEjeYmoy875MLmQdVAXwCPxNie
 UPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712067896; x=1712672696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AnqQaUG1ZoPVgZF2Ex29MI5m2mNV0++IO/ZIMEDgcJ8=;
 b=jFoOox/Zh/vWGLV6FKeasLyDiDgerkARfaJ7LCUd3KY8/HwG2E53mUB+kuvksKOQqb
 5fxs5Hyncd16oMQTcwffhDhOuvs7wkYqTqPzSl3ZkPkEN5jTm29Ka/aEa2aacC8Ojvwj
 s2GWYEfTc0dDeKo69wQoslmbFn2XXbXivU52coXRmdoGiAlRUdwjNtst5oMJ0au+yXLB
 68FCZdfxtnh4grPk7QUYApBQz0YYWUo29kUbbArABxM7GADSwWdYNf1UAu5HfrpIO/ko
 hKwtB1+wpnkBJ7u7cjld9z/xAzFSvBo+M7vl2BYbz9ufXxLy9UtzBHaGTtXysRD8W/G3
 WUgw==
X-Gm-Message-State: AOJu0Yy+5tAdTHHybUHBj6jy5Tglcfc2oyWzqlescH2gaITt/jiCH2d0
 TrbWe65VpWoblrndZE8SkDAiYw9mwvxyIg3auW+cPpTu9ZvLptRqWl5T3by8qI1FmgqlyJl/Xvz
 jjgc=
X-Google-Smtp-Source: AGHT+IFjRWWqwBYV0XJAWcClqbaYZG/hgJysFiD/espoX/7BuA6K9XVvWp7g04khszacdMl9w6MpwA==
X-Received: by 2002:a05:600c:3554:b0:414:6ee:a392 with SMTP id
 i20-20020a05600c355400b0041406eea392mr9854928wmq.8.1712067895857; 
 Tue, 02 Apr 2024 07:24:55 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 ay15-20020a5d6f0f000000b003434c764f01sm5886406wrb.107.2024.04.02.07.24.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Apr 2024 07:24:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 03/15] gdbstub/system: Rename 'user_ctx' argument as 'ctx'
Date: Tue,  2 Apr 2024 16:24:18 +0200
Message-ID: <20240402142431.70700-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240402142431.70700-1-philmd@linaro.org>
References: <20240402142431.70700-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240313213339.82071-4-philmd@linaro.org>
---
 gdbstub/internals.h | 8 ++++----
 gdbstub/system.c    | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 66c939c67f..32f9f63297 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -187,7 +187,7 @@ typedef union GdbCmdVariant {
 
 #define get_param(p, i)    (&g_array_index(p, GdbCmdVariant, i))
 
-void gdb_handle_query_rcmd(GArray *params, void *user_ctx); /* system */
+void gdb_handle_query_rcmd(GArray *params, void *ctx); /* system */
 void gdb_handle_query_offsets(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_xfer_auxv(GArray *params, void *user_ctx); /*user */
 void gdb_handle_query_xfer_siginfo(GArray *params, void *user_ctx); /*user */
@@ -201,11 +201,11 @@ void gdb_handle_query_supported_user(const char *gdb_supported); /* user */
 bool gdb_handle_set_thread_user(uint32_t pid, uint32_t tid); /* user */
 bool gdb_handle_detach_user(uint32_t pid); /* user */
 
-void gdb_handle_query_attached(GArray *params, void *user_ctx); /* both */
+void gdb_handle_query_attached(GArray *params, void *ctx); /* both */
 
 /* system only */
-void gdb_handle_query_qemu_phy_mem_mode(GArray *params, void *user_ctx);
-void gdb_handle_set_qemu_phy_mem_mode(GArray *params, void *user_ctx);
+void gdb_handle_query_qemu_phy_mem_mode(GArray *params, void *ctx);
+void gdb_handle_set_qemu_phy_mem_mode(GArray *params, void *ctx);
 
 /* sycall handling */
 void gdb_handle_file_io(GArray *params, void *user_ctx);
diff --git a/gdbstub/system.c b/gdbstub/system.c
index a3ce384cd1..d235403855 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -488,13 +488,13 @@ bool gdb_can_reverse(void)
  */
 
 void gdb_handle_query_qemu_phy_mem_mode(GArray *params,
-                                        void *user_ctx)
+                                        void *ctx)
 {
     g_string_printf(gdbserver_state.str_buf, "%d", phy_memory_mode);
     gdb_put_strbuf();
 }
 
-void gdb_handle_set_qemu_phy_mem_mode(GArray *params, void *user_ctx)
+void gdb_handle_set_qemu_phy_mem_mode(GArray *params, void *ctx)
 {
     if (!params->len) {
         gdb_put_packet("E22");
@@ -509,7 +509,7 @@ void gdb_handle_set_qemu_phy_mem_mode(GArray *params, void *user_ctx)
     gdb_put_packet("OK");
 }
 
-void gdb_handle_query_rcmd(GArray *params, void *user_ctx)
+void gdb_handle_query_rcmd(GArray *params, void *ctx)
 {
     const guint8 zero = 0;
     int len;
@@ -539,7 +539,7 @@ void gdb_handle_query_rcmd(GArray *params, void *user_ctx)
  * Execution state helpers
  */
 
-void gdb_handle_query_attached(GArray *params, void *user_ctx)
+void gdb_handle_query_attached(GArray *params, void *ctx)
 {
     gdb_put_packet("1");
 }
-- 
2.41.0



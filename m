Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE13C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpch-00008Z-E1; Tue, 30 Jul 2024 12:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpcg-0008VR-Cd
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:50 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpce-0003Yw-MP
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:50 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a7ac469e4c4so5072566b.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722356567; x=1722961367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AUsqRXTeW3XYv9I38g7wul3S13NoPU/K/kBqTz9dI9c=;
 b=vWppsQGgXHW3oQ6/lKX6BZudG7Y8hA2XpcOhpaxA27HEr8j+eoW2wIPG/OAK8AhsoE
 YCSTD+00v3Al3rsgqWgvxDC9wn6pqP/mr3X/50XiJkjKzmJlTb12ocIg/jTcCbS/Thrl
 5evHY2xXb3VatZ659UCM0lOnv3j3zNG80TpC1vzzTMlki4Fke6oH2JPEAh/GBHNuo5sL
 lTDPe3AlTX28imCtIHWdzFYWS/Egh6mEyaiMCDJryGl5atiUY99P2PehlOku4RDTUJRX
 xdc6bh9oMvIOGAPHurBybm+HlZWtdg53PS2KXqOrsFz9QFblvVnTTcECh7BQ9e19DWBe
 TowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722356567; x=1722961367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AUsqRXTeW3XYv9I38g7wul3S13NoPU/K/kBqTz9dI9c=;
 b=rjz0XvuTVJF0WV5S/L01isTGCLCPVBQH5x0yZo2Vq5DOJn0LdxFL81HRbThd6f4acC
 4OurimzSOI4691/Ww7XsuxrnhNYlCiGnVMiB+GSXdpgLuJ8tlN/foGpN681XA/Qv7kyl
 i54Kam3QZLu9ypkGWDYuN1jNS9EuhJRYGlr54AYTJwR9Zf5DWXaKKGZYNyCkQQnlYXMV
 4iJx9c3hLJ2ePHboewKsnMHUNG48O7vKy+/QiicS6tOHWBMsSgMonGOLvXbIJpbfTnRN
 K2gG3z9xkDioDiVjRirfYa3e9Deq/cWw/3ZlTwvM2bBjsdnVOL842vYFX8D9Arh0q8ke
 cHZQ==
X-Gm-Message-State: AOJu0YygrqgePLGOAm9FMzDwrHPbtA7uiea4Ho4dbXqPQcZReqSdTEG+
 bgEZLH7ToHksUZqpdYTXvTQLWPAZySM0c0dh3lHHj3SGQBS4mvcm5nP+uubjgrY=
X-Google-Smtp-Source: AGHT+IEemkYjxqr397Z5iEE5jkEbUAkPbEgoV8UFaCxLXwBdWOC1YI29FMc8YSHOQVwwXCBQ47RKkA==
X-Received: by 2002:a17:907:3fa5:b0:a7a:bae8:f2b5 with SMTP id
 a640c23a62f3a-a7d85a9b845mr309430166b.36.1722356566935; 
 Tue, 30 Jul 2024 09:22:46 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad411bcsm655186466b.109.2024.07.30.09.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:22:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1AB8A5FA0F;
 Tue, 30 Jul 2024 17:22:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 13/14] contrib/plugins: add compat for g_memdup2
Date: Tue, 30 Jul 2024 17:22:36 +0100
Message-Id: <20240730162237.1425515-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730162237.1425515-1-alex.bennee@linaro.org>
References: <20240730162237.1425515-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

We were premature if bumping this because some of our builds are still
on older glibs. Just copy the compat handler for now and we can remove
it later.

Fixes: ee293103b0 (plugins: update lockstep to use g_memdup2)
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2161
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240729144414.830369-14-alex.bennee@linaro.org>

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 6a7e9bbb39..62981d4e09 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -101,6 +101,31 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     plugin_cleanup(id);
 }
 
+/*
+ * g_memdup has been deprecated in Glib since 2.68 and
+ * will complain about it if you try to use it. However until
+ * glib_req_ver for QEMU is bumped we make a copy of the glib-compat
+ * handler.
+ */
+static inline gpointer g_memdup2_qemu(gconstpointer mem, gsize byte_size)
+{
+#if GLIB_CHECK_VERSION(2, 68, 0)
+    return g_memdup2(mem, byte_size);
+#else
+    gpointer new_mem;
+
+    if (mem && byte_size != 0) {
+        new_mem = g_malloc(byte_size);
+        memcpy(new_mem, mem, byte_size);
+    } else {
+        new_mem = NULL;
+    }
+
+    return new_mem;
+#endif
+}
+#define g_memdup2(m, s) g_memdup2_qemu(m, s)
+
 static void report_divergance(ExecState *us, ExecState *them)
 {
     DivergeState divrec = { log, 0 };
-- 
2.39.2



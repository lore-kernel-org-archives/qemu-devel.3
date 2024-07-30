Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EC2C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpch-000092-IZ; Tue, 30 Jul 2024 12:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpcf-0008TF-R2
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:49 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpce-0003Yl-3C
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:49 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2f029e9c9cfso76608631fa.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722356566; x=1722961366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LRXaIONybMmBdGeWuB9Y8awgTfEnHzKiFMl1WGBWlGA=;
 b=xuW2kCW/jI52nHiLJvt+6z06PHOyeuxOVM5cNIj33G3LdfEpb5kxBsawTQhyEmIYWB
 50qVa742At3ElK9oNk2Ms8Kip3XE3BovgY2gSwrgr4GGKRwxgu3ap8/8Vf+QBS0nfgr3
 43SIcxuKOnYDWa8KI3dCWC1VKLGCwgw8fUcQpcmLgqOd3iGqq4//W+k+RbMj0rw4GobB
 fYEB9KmgvKRL9uGzA1mxHLS08gxPE+uHA/dbaxeqG6OWUA7ydXZjNVvWxYwF7f7rvU1W
 W9PdtNWXVIhrMfho6j6Rq1kUR6YwnHDJRppMGjgPZcdFsYCjv9ETrbrKKEu2fb+Ty1mJ
 2+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722356566; x=1722961366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LRXaIONybMmBdGeWuB9Y8awgTfEnHzKiFMl1WGBWlGA=;
 b=dUAa6olayr9YZxVW+4wgx/HyjNtyP2rcFts0m5BY2dCDEfDScSaplAmXd0ooIKjjsC
 ZCxaK42NCcFVWB2ktX+KLWi3lQTZ/lOo2YHr5Jt2tUpWr7QBr3RZ6fM2WJL03Sd3BASG
 OOH+riFQtRfkcAKpgTAAI0u9CUM/yA1O2+A53fVSAYtNOi5pmoHtWXHw1j8QV6dPqojm
 /1DUxxLikJfad2Ck9gGA6+r1uv97fHiW1l+LKBmebQMEt/rUcxxpw8+by6JO1nv+E+ZY
 EzsojLd81iK5sgEzjkJZGOR4jcrhTHXN0MQfl2pjfT2um6LRWv5cw/Yw2MRQJ4C9BD/4
 kU0Q==
X-Gm-Message-State: AOJu0YzENlDSwHHVk0M5zDuajAmBawxgpdsBNDZWrzS6pIg/fJ+9+AmO
 MZCgLgNquz6tZLxvnyKV9bmtE/CXUxDMFNOHsYwkjjfKgzPeM3yGqht2cS7apes=
X-Google-Smtp-Source: AGHT+IGilBLlabcjhrmJda3t0H32vDLoMbv4O5r7LPBmiq+46F/2/hZ3UNJbiPiekn3iWBQpfkG0dQ==
X-Received: by 2002:a2e:9a87:0:b0:2ef:2f9e:dd19 with SMTP id
 38308e7fff4ca-2f12edfeefbmr95149631fa.2.1722356565999; 
 Tue, 30 Jul 2024 09:22:45 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad41027sm660084466b.122.2024.07.30.09.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:22:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 043CA5FA0E;
 Tue, 30 Jul 2024 17:22:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 12/14] contrib/plugins: be more vocal building
Date: Tue, 30 Jul 2024 17:22:35 +0100
Message-Id: <20240730162237.1425515-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730162237.1425515-1-alex.bennee@linaro.org>
References: <20240730162237.1425515-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x236.google.com
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

With the conversion to meson and removing the old QEMU Makefile
baggage we became very silent when building the plugins. Bring in a
copy of the quiet-command logic (and some magic COMMAs) so we can at
least assure developers we are building them.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2457
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240729144414.830369-13-alex.bennee@linaro.org>

diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index 98a89d5c40..edf256cd9d 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -39,26 +39,41 @@ endif
 
 SONAMES := $(addsuffix $(SO_SUFFIX),$(addprefix lib,$(NAMES)))
 
-# The main QEMU uses Glib extensively so it's perfectly fine to use it
+# The main QEMU uses Glib extensively so it is perfectly fine to use it
 # in plugins (which many example do).
 PLUGIN_CFLAGS := $(shell $(PKG_CONFIG) --cflags glib-2.0)
 PLUGIN_CFLAGS += -fPIC -Wall
 PLUGIN_CFLAGS += -I$(TOP_SRC_PATH)/include/qemu
 
+# Helper that honours V=1 so we get some output when compiling
+quiet-@ = $(if $(V),,@$(if $1,printf "  %-7s %s\n" "$(strip $1)" "$(strip $2)" && ))
+quiet-command = $(call quiet-@,$2,$3)$1
+
+# for including , in command strings
+COMMA := ,
+
 all: $(SONAMES)
 
 %.o: %.c
-	$(CC) $(CFLAGS) $(PLUGIN_CFLAGS) -c -o $@ $<
+	$(call quiet-command, \
+		$(CC) $(CFLAGS) $(PLUGIN_CFLAGS) -c -o $@ $<, \
+	        BUILD, plugin $@)
 
 ifeq ($(CONFIG_WIN32),y)
 lib%$(SO_SUFFIX): %.o win32_linker.o ../../plugins/libqemu_plugin_api.a
-	$(CC) -shared -o $@ $^ $(LDLIBS)
+	$(call quiet-command, \
+		$(CC) -shared -o $@ $^ $(LDLIBS), \
+		LINK, plugin $@)
 else ifeq ($(CONFIG_DARWIN),y)
 lib%$(SO_SUFFIX): %.o
-	$(CC) -bundle -Wl,-undefined,dynamic_lookup -o $@ $^ $(LDLIBS)
+	$(call quiet-command, \
+		$(CC) -bundle -Wl$(COMMA)-undefined$(COMMA)dynamic_lookup -o $@ $^ $(LDLIBS), \
+		LINK, plugin $@)
 else
 lib%$(SO_SUFFIX): %.o
-	$(CC) -shared -o $@ $^ $(LDLIBS)
+	$(call quiet-command, \
+		$(CC) -shared -o $@ $^ $(LDLIBS), \
+		LINK, plugin $@)
 endif
 
 
-- 
2.39.2



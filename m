Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7EBC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYRc3-0004W8-GJ; Mon, 29 Jul 2024 10:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRc1-0004OS-NW
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:33 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRbt-0008Q3-Cs
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:33 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5a2ffc346ceso5322527a12.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 07:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722264264; x=1722869064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RIOayMEsJA1tkmepteKB9T0FXWTwbDeTnBtcVohO/HQ=;
 b=vrz7AqpY0TeQ9/WAPxNm5oFSfMpOi4siqTB17ebTmwHEDG/t0vhuTJpW+G7JqxBK+f
 RmJCEiIF70+kJe70TsWh+RqongjyO3z5NvWRRuh1mLYz4Y3oEWPRewT4JLBXMkTmooHj
 pZsGUDWq8p5ewK1qy808Nr8uFr7B/huXBpIGCNKU+43o7KFNXa/CQZvNMgWFqS4CQv7G
 7k19hi1U3Y3UohipcWFzN5kWGk6XstRciq54GAbsvWDQGOnWPhuaHadHnEajt1hSb/0L
 V2yKU91SUud4NGBBKPy2Mvlj80HpnoW8gnFzh7iZHIWZfhDPcE13WIt4fFznIghORmM+
 pC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722264264; x=1722869064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RIOayMEsJA1tkmepteKB9T0FXWTwbDeTnBtcVohO/HQ=;
 b=U24osGjbA8cHM9XpdQjgrLaEyLL2pxLYgZ9l9vly2zkUpQBk3S27k9zL7fw5bh4GhY
 0jbfVmSFVVHD8/yqiu9Rc0NXN3k7PXs7dgOroJMe+0FlP3ElQ0T675D9mGzJeaCMl8QZ
 S4fJES0GThWqfgoRs4I9B/CmFnfyXTfibgOYbinsSTOBxl/FocPL3aHVmBz/eJwovead
 k7v6J+AU5vXi1691E22bJTS1LLZjp4uPC7lPYSNGWB1LvvY8Qwm/CUwMENYxrKeTFya/
 1fq1wev584+SS1fnbeF1V6s8fER+BrF/CrzTeWuTtccXLebYszzCl0HBDQjh3skhX2Co
 iOaA==
X-Gm-Message-State: AOJu0YzRhHIppF4aVb64B2br+Adkp1+4zXV7iHrtEX5UWZhxqprV3kOb
 oPcsmEZXT7giU/CjDdbhfUwDs1MafVCHrogs8zHy4YA1hE32Vgtpscg8H6EtKq4=
X-Google-Smtp-Source: AGHT+IFBqzVWW8HN4yEEamLBDbG/voeZt/brB68Ctd58ksy7qlSURXpWYpi+y2eacnqXtSPvTiYy9A==
X-Received: by 2002:a17:907:3d9e:b0:a77:ab40:6d7f with SMTP id
 a640c23a62f3a-a7d401781femr483657566b.43.1722264263519; 
 Mon, 29 Jul 2024 07:44:23 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad91080sm518097066b.160.2024.07.29.07.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 07:44:19 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 43DE05FA11;
 Mon, 29 Jul 2024 15:44:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Song Gao <gaosong@loongson.cn>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 12/14] contrib/plugins: be more vocal building
Date: Mon, 29 Jul 2024 15:44:12 +0100
Message-Id: <20240729144414.830369-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240729144414.830369-1-alex.bennee@linaro.org>
References: <20240729144414.830369-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

With the conversion to meson and removing the old QEMU Makefile
baggage we became very silent when building the plugins. Bring in a
copy of the quiet-command logic (and some magic COMMAs) so we can at
least assure developers we are building them.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2457
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
Maybe we should just move to a meson build as proposed here:

https://gitlab.com/qemu-project/qemu/-/issues/1710
---
 contrib/plugins/Makefile | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

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



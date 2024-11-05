Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDC8D1267D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 10:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8H2I-00039s-Ut; Tue, 05 Nov 2024 05:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t8H2C-0002xc-29
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:43:41 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t8H29-0003Qk-HS
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:43:39 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c9850ae22eso6524336a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 02:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730803416; x=1731408216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5IOvvSHHpse3ZvASXv69Y+T+V6sjL0EftOtV43EOvAQ=;
 b=sde7SnJSGUz6iUqi0uri72PxR9YvDEGpPfnJUc810TyAlQabOb2sKFHZheM64YLKZq
 albB3ZAMVeeg8XgHOwDQEfaPnZu6HRy65iVEw/LZh/c2/Ru9hjqVkGntELs9pcDzL3V5
 fN9TX+cP69Nb9KvWpjq6KRehimPWFdp2BcuJAtjhK273TcNaB3Dl722r6kAx8WQmcQxC
 OiExna+iCq2GzZUXf72onuhGNrXa3ZB3P3ZgvemqDcVSRtciZpRdDBEAwUn0w0Es9Pgz
 T4mXxFjQ3iwtyem61eMDb27x2Fp4AhYokqHgqjwUXVyjYbMRKMS7jJ6ZvSMk9XmQUuwb
 Oiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730803416; x=1731408216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5IOvvSHHpse3ZvASXv69Y+T+V6sjL0EftOtV43EOvAQ=;
 b=TKRWO7OTndJdT7K6k/k19c0VVkX0WehRlYoUw3Of6k4MdGiBK+rlMtGSly8U2kyRwz
 xXDSlO6HyO9eukELcV2HyA0CWaaUF61Z+6N2EnY5MCO3xA+7p2muG3vClWEB+W0AiQrT
 LXt9EiUJWhwCpDiYbi90qwPK30INI0PWhxNb6PyCtdffVfmaogZlSRaWCjkheTBPk021
 s1AokGNfd6qeY488Nvyc+/iRqom1KXXKAHBuCaH6l4W4k4HoB0SkB1nbTWgshJ/GeKTl
 qnuOlNTseylEwZBZWCHkPQNww5dKU6eTIX2AVVw92pGMLM1V1JQw82oe3n7akRa6ATe5
 zX2Q==
X-Gm-Message-State: AOJu0Yxfs50EjnAxwY3HBtukNJI958TQ+mYpZVCwJoHMP8cb7+ckRbnq
 67qR4m6AypNpPsGe3N4fVcn5xy0owGMem/xXH+K5T0J68YDe0v0K1BkeqIVBXow=
X-Google-Smtp-Source: AGHT+IE0cwdsKIZD32IFBZCZqJ4eunJjVIuqxHmdnHhkWohXvjtHICnpJAUu3WiWkqrDlN0qb2aO3g==
X-Received: by 2002:a17:907:8686:b0:a9a:212d:4ecb with SMTP id
 a640c23a62f3a-a9de5d702eemr3669556966b.12.1730803415865; 
 Tue, 05 Nov 2024 02:43:35 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb1813a33sm116606766b.185.2024.11.05.02.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 02:43:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E9E1E5F8EB;
 Tue,  5 Nov 2024 10:43:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 3/3] contrib/plugins: remove Makefile for contrib/plugins
Date: Tue,  5 Nov 2024 10:43:33 +0000
Message-Id: <20241105104333.2534823-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241105104333.2534823-1-alex.bennee@linaro.org>
References: <20241105104333.2534823-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Now replaced by meson build.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241023212812.1376972-4-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/configure b/configure
index f24940ca77..096b1fddb7 100755
--- a/configure
+++ b/configure
@@ -1077,7 +1077,6 @@ if test "$plugins" != "no" && test $host_bits -eq 64; then
         plugins="no"
     else
         plugins=yes
-        subdirs="$subdirs contrib/plugins"
     fi
 fi
 
@@ -1708,7 +1707,6 @@ LINKS="$LINKS .gdbinit scripts" # scripts needed by relative path in .gdbinit
 LINKS="$LINKS tests/avocado tests/data"
 LINKS="$LINKS tests/qemu-iotests/check tests/qemu-iotests/Makefile"
 LINKS="$LINKS python"
-LINKS="$LINKS contrib/plugins/Makefile "
 for f in $LINKS ; do
     if [ -e "$source_path/$f" ]; then
         symlink "$source_path/$f" "$f"
@@ -1794,22 +1792,6 @@ if test "$default_targets" = "yes"; then
   echo "CONFIG_DEFAULT_TARGETS=y" >> $config_host_mak
 fi
 
-# contrib/plugins configuration
-echo "# Automatically generated by configure - do not modify" > contrib/plugins/$config_host_mak
-echo "SRC_PATH=$source_path/contrib/plugins" >> contrib/plugins/$config_host_mak
-echo "PKG_CONFIG=${pkg_config}" >> contrib/plugins/$config_host_mak
-echo "CC=$cc $CPU_CFLAGS" >> contrib/plugins/$config_host_mak
-echo "CFLAGS=${CFLAGS-$default_cflags} $EXTRA_CFLAGS" >> contrib/plugins/$config_host_mak
-if test "$host_os" = windows; then
-  echo "DLLTOOL=$dlltool" >> contrib/plugins/$config_host_mak
-fi
-if test "$host_os" = darwin; then
-  echo "CONFIG_DARWIN=y" >> contrib/plugins/$config_host_mak
-fi
-if test "$host_os" = windows; then
-  echo "CONFIG_WIN32=y" >> contrib/plugins/$config_host_mak
-fi
-
 # tests/tcg configuration
 mkdir -p tests/tcg
 echo "# Automatically generated by configure - do not modify" > tests/tcg/$config_host_mak
diff --git a/Makefile b/Makefile
index 917c9a34d1..b65b0bd41a 100644
--- a/Makefile
+++ b/Makefile
@@ -187,11 +187,6 @@ SUBDIR_RULES=$(foreach t, all clean distclean, $(addsuffix /$(t), $(SUBDIRS)))
 $(SUBDIR_RULES):
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" $(notdir $@),)
 
-ifneq ($(filter contrib/plugins, $(SUBDIRS)),)
-.PHONY: plugins
-plugins: contrib/plugins/all
-endif
-
 .PHONY: recurse-all recurse-clean
 recurse-all: $(addsuffix /all, $(SUBDIRS))
 recurse-clean: $(addsuffix /clean, $(SUBDIRS))
@@ -307,11 +302,6 @@ help:
 	$(call print-help,cscope,Generate cscope index)
 	$(call print-help,sparse,Run sparse on the QEMU source)
 	@echo  ''
-ifneq ($(filter contrib/plugins, $(SUBDIRS)),)
-	@echo  'Plugin targets:'
-	$(call print-help,plugins,Build the example TCG plugins)
-	@echo  ''
-endif
 	@echo  'Cleaning targets:'
 	$(call print-help,clean,Remove most generated files but keep the config)
 	$(call print-help,distclean,Remove all generated files)
diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
deleted file mode 100644
index bbddd4800f..0000000000
--- a/contrib/plugins/Makefile
+++ /dev/null
@@ -1,87 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# This Makefile example is fairly independent from the main makefile
-# so users can take and adapt it for their build. We only really
-# include config-host.mak so we don't have to repeat probing for
-# programs that the main configure has already done for us.
-#
-
-include config-host.mak
-
-TOP_SRC_PATH = $(SRC_PATH)/../..
-
-VPATH += $(SRC_PATH)
-
-NAMES :=
-NAMES += bbv
-NAMES += execlog
-NAMES += hotblocks
-NAMES += hotpages
-NAMES += howvec
-
-# The lockstep example communicates using unix sockets,
-# and can't be easily made to work on windows.
-ifneq ($(CONFIG_WIN32),y)
-NAMES += lockstep
-endif
-
-NAMES += hwprofile
-NAMES += cache
-NAMES += drcov
-NAMES += ips
-NAMES += stoptrigger
-NAMES += cflow
-
-ifeq ($(CONFIG_WIN32),y)
-SO_SUFFIX := .dll
-LDLIBS += $(shell $(PKG_CONFIG) --libs glib-2.0)
-else
-SO_SUFFIX := .so
-endif
-
-SONAMES := $(addsuffix $(SO_SUFFIX),$(addprefix lib,$(NAMES)))
-
-# The main QEMU uses Glib extensively so it is perfectly fine to use it
-# in plugins (which many example do).
-PLUGIN_CFLAGS := $(shell $(PKG_CONFIG) --cflags glib-2.0)
-PLUGIN_CFLAGS += -fPIC -Wall
-PLUGIN_CFLAGS += -I$(TOP_SRC_PATH)/include/qemu
-
-# Helper that honours V=1 so we get some output when compiling
-quiet-@ = $(if $(V),,@$(if $1,printf "  %-7s %s\n" "$(strip $1)" "$(strip $2)" && ))
-quiet-command = $(call quiet-@,$2,$3)$1
-
-# for including , in command strings
-COMMA := ,
-
-all: $(SONAMES)
-
-%.o: %.c
-	$(call quiet-command, \
-		$(CC) $(CFLAGS) $(PLUGIN_CFLAGS) -c -o $@ $<, \
-	        BUILD, plugin $@)
-
-ifeq ($(CONFIG_WIN32),y)
-lib%$(SO_SUFFIX): %.o win32_linker.o ../../plugins/libqemu_plugin_api.a
-	$(call quiet-command, \
-		$(CC) -shared -o $@ $^ $(LDLIBS), \
-		LINK, plugin $@)
-else ifeq ($(CONFIG_DARWIN),y)
-lib%$(SO_SUFFIX): %.o
-	$(call quiet-command, \
-		$(CC) -bundle -Wl$(COMMA)-undefined$(COMMA)dynamic_lookup -o $@ $^ $(LDLIBS), \
-		LINK, plugin $@)
-else
-lib%$(SO_SUFFIX): %.o
-	$(call quiet-command, \
-		$(CC) -shared -o $@ $^ $(LDLIBS), \
-		LINK, plugin $@)
-endif
-
-
-clean distclean:
-	rm -f *.o *$(SO_SUFFIX) *.d
-	rm -Rf .libs
-
-.PHONY: all clean
-.SECONDARY:
-- 
2.39.5



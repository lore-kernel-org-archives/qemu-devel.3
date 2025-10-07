Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E86CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 11:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v66Iq-0002mc-Jv; Tue, 07 Oct 2025 07:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66IU-0002Yc-5W
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:56:05 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66ID-0001Jc-Qx
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:56:01 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so54279635e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 04:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759838137; x=1760442937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a76lm/FvL+H9qR+yT/bygLJJanUbAcVb3PSUoyR2HNk=;
 b=IgF/vmog+qhbK5NFZeXM04Ul+PMPehVMtn2LeBlI5W1V7tCnAqFG1InLfkC5nXHuqx
 fHY0hT3/uMJrcrLEUb9sv7EROc7uyozRX2X1tf6u0FWCJsybIpg2FFRsmhdTaSM2yVcx
 TInjZXjwnK25tre/q0iXtWwzHFe3OVq00ipdmeISPW/ZjxP3RKA5eoG8DikhSDmYsFgv
 WX4pOyUHIzQe7U9ARI7RDjpO8dHf5LyTvdJBxTk6BWK/AtekjUsxzydY9LHRQAI4YEvB
 A7ZCULF9vjeUOm66eYzHR/Uh5e4pKJwzAWK6C4wsz9uCYFzTtbAsyiSC1foHnnLjXtDm
 qQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838137; x=1760442937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a76lm/FvL+H9qR+yT/bygLJJanUbAcVb3PSUoyR2HNk=;
 b=CqkpQuRpY+8PsAILNe2zAu5x3PVbJ/uriNzasUAMkwxj9wu7K9+ODfGfzdZI+b4h3C
 /iGy4eGJYlI3opIYpu6vAJA7glOUT3+bs7n8bpThnS7I7vuJIHAtmsBzhhP38li3ikgV
 6qSzsLGNriYzkrDz+aWnJKQXnrY73rNBpyE077QTekCH6zLiSbh5o3aisbyssuerzALK
 cXbzrGnz+ZZ8AwXaIelbHuGzlVvnuF+xi8Gc3Qc6veMb2IE4wDiphT8n2KIvDb56UXc0
 IURAuWBNrKo6+Zcnb5iWci3MTeBHCZzFe7tgN7MCHH4Ci3tspIqYMkAIQa51/LFe6bD7
 0bkQ==
X-Gm-Message-State: AOJu0Yzn/8QbHJCzEBIVKCRQmPJJ6MZQeITSg2tp+sgzxyiCxuzQvi0h
 C2MIJ/vkS+IOSHiglpqU3Qgr4jzFFmD9tBqkhCg2KReKA+jkCezu6d7y7ZjPEAzk4pE=
X-Gm-Gg: ASbGncuJhVOU37qDtoLmI7scZON71qqwTJmxRFXJxbQsM/ZaJJiNJSHxJGuiVZFMsCc
 Lt2V1Sg7g946Bhwy1S34+mqAOSeYmQW47Kql4PbrbtGRrhBqtAa2OdzY5/9mZ0UrwEWjzpyVr/d
 OiUIJRkq1q2VIHz8CqD7ML9SxtJb3BgSquPIkYPiRadqp+Lq7P4lqdTuwOT0uFZTOWDtb+nGf7Y
 2AIEp80XBk+gtQagVQ/oCFxS9RS22dc6k50CRYfepg8MDaZkiLebHUJbjGU9Jplv+DdD3jENlFs
 ovc3EsqAv+uVRvr8W2JxC/n0qr81jmVxzzY+tqWn+Oa/ucGhi8bYM4oXb3ZAuQxb9NR3nV2Mqaj
 K29J+xBdTdNLRofHU3aIiazPS9Dxpsuq81lm4u+UM7mQtqgJfftU=
X-Google-Smtp-Source: AGHT+IHZ6uvgyCCTqDM7AzOg8sE4ky8DiHGJK0x4uVBCPJ90YMj++UDeTEpiar99SU4CesSjyvGvww==
X-Received: by 2002:a05:600c:1f11:b0:46e:6d5f:f68 with SMTP id
 5b1f17b1804b1-46e7110c4ccmr115685735e9.12.1759838136729; 
 Tue, 07 Oct 2025 04:55:36 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6b8bsm25118036f8f.4.2025.10.07.04.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 04:55:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D4D6160357;
 Tue, 07 Oct 2025 12:55:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/17] tests/functional: Provide GDB to the functional tests
Date: Tue,  7 Oct 2025 12:55:18 +0100
Message-ID: <20251007115525.1998643-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007115525.1998643-1-alex.bennee@linaro.org>
References: <20251007115525.1998643-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

The probe of GDB is done in 'configure' and the full path is passed to
meson.build via the -Dgdb=option.

Meson then can pass the location of GDB to the functional tests via an
environment variable: QEMU_TEST_GDB.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <20251003141820.85278-4-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/configure b/configure
index 78445cbb4b3..21d1679f58e 100755
--- a/configure
+++ b/configure
@@ -2003,6 +2003,8 @@ if test "$skip_meson" = no; then
   test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
   test "$plugins" = yes && meson_option_add "-Dplugins=true"
   test "$tcg" != enabled && meson_option_add "-Dtcg=$tcg"
+  test -n "$gdb_bin" && meson_option_add "-Dgdb=$gdb_bin"
+
   run_meson() {
     NINJA=$ninja $meson setup "$@" "$PWD" "$source_path"
   }
diff --git a/meson_options.txt b/meson_options.txt
index fff1521e580..5bb41bcbc43 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -36,6 +36,8 @@ option('trace_file', type: 'string', value: 'trace',
 option('coroutine_backend', type: 'combo',
        choices: ['ucontext', 'sigaltstack', 'windows', 'wasm', 'auto'],
        value: 'auto', description: 'coroutine backend to use')
+option('gdb', type: 'string', value: '',
+       description: 'Path to GDB')
 
 # Everything else can be set via --enable/--disable-* option
 # on the configure script command line.  After adding an option
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 0ebe6bc52a6..f4bd21220ee 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -58,6 +58,7 @@ meson_options_help() {
   printf "%s\n" '  --enable-ubsan           enable undefined behaviour sanitizer'
   printf "%s\n" '  --firmwarepath=VALUES    search PATH for firmware files [share/qemu-'
   printf "%s\n" '                           firmware]'
+  printf "%s\n" '  --gdb=VALUE              Path to GDB'
   printf "%s\n" '  --iasl=VALUE             Path to ACPI disassembler'
   printf "%s\n" '  --includedir=VALUE       Header file directory [include]'
   printf "%s\n" '  --interp-prefix=VALUE    where to find shared libraries etc., use %M for'
@@ -323,6 +324,7 @@ _meson_option_parse() {
     --disable-fuzzing) printf "%s" -Dfuzzing=false ;;
     --enable-gcrypt) printf "%s" -Dgcrypt=enabled ;;
     --disable-gcrypt) printf "%s" -Dgcrypt=disabled ;;
+    --gdb=*) quote_sh "-Dgdb=$2" ;;
     --enable-gettext) printf "%s" -Dgettext=enabled ;;
     --disable-gettext) printf "%s" -Dgettext=disabled ;;
     --enable-gio) printf "%s" -Dgio=enabled ;;
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 2a0c5aa1418..725630d3082 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -77,6 +77,12 @@ foreach speed : ['quick', 'thorough']
     test_env.set('PYTHONPATH', meson.project_source_root() / 'python:' +
                                meson.current_source_dir())
 
+    # Define the GDB environment variable if gdb is available.
+    gdb = get_option('gdb')
+    if gdb != ''
+      test_env.set('QEMU_TEST_GDB', gdb)
+    endif
+
     foreach test : target_tests
       testname = '@0@-@1@'.format(target_base, test)
       if fs.exists('generic' / 'test_' + test + '.py')
-- 
2.47.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4A7D1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 17:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdtYU-0000rW-Oh; Thu, 08 Jan 2026 12:12:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vdtYS-0000p1-Lr
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:12:12 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vdtYR-0000EM-1B
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:12:12 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7aa2170adf9so2131053b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 09:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767892329; x=1768497129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KSK09h4xKjsISSidIbADfOirq0TnGihmtXpNzolifyA=;
 b=TPX5UbspAs0hs3M7LshnQ9H9ihHtBbwKQEwcVoP/4eylFkqzZ7SZi8R9i69OXjkjyG
 5D2xIygL+TCJ793+gkl68Vtclj12iLy4xvzf5EXTagzTWXw39UFjrabStKtCpnMB2Gz8
 S+y+zDn+3IlhMP3G7J1qI/cfOX2TZ97349d31CgaUuC6tuYyinWa8vPjR93WrTGpTnuG
 NRepfCSHwIB9H+cd0jBviZcoGm4NV5DCb0szGxHGQbvfK3W2l5jzys7/Pj6uU2XG7Ljf
 WvjuwnfeBELZf70NKQ4vIWLVoAvoeFv0/VnbQvDMRp4iRn8mM8EaA/KLO58LfS4TjEpb
 zpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767892329; x=1768497129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KSK09h4xKjsISSidIbADfOirq0TnGihmtXpNzolifyA=;
 b=MtLQdQqQhBfGZRO1b8adDr6nykyHrcvwTbX0CDfGZ76RsIBlZ/XrfQp6iiRRHrT8Nx
 kZGBUDtDv0beoTJJNVxgWgEePMCGsZhU3ZSLf/ot2hm2gj6bCVoLKaZigE4T3Qm92Bnq
 HgUTepfJvLyQqMryM77Oz867eHujF9nYLNKBO4Uqrpg1OtZhXFaUBOJmgbAZN3qeIK2K
 QxuAHXrE1flk5ZL2Fs5v9FkD/QsJBnTkpaqVyicqi36fq2JFKFOkWJyEmYB6vvlyERSx
 xh4CB+ayMk+6c7NWkHgJWDPiiGVxWyq/vIYdRN+SsaxVEObFQbDCJIGMR3DDG04jXsMw
 RMFQ==
X-Gm-Message-State: AOJu0YzxJGJKQAfO9ZXMY4H99RNb3L0uejcIq7bbhsIJk5I6kvkUXUiz
 0jj/5YBsWp+N7P4+tkhRHiona65+Kos3Yp0aSzxhlI2OExjwnXvit6Oc2q76PwWJ
X-Gm-Gg: AY/fxX6uqB4emBke2S2IDna7kAcM6ROk1voS+jVQ3LvGb4A2C56p2Xl9K0Q+XeDKKP6
 Xtfyb9RLb+EcoEKM8A85m51FAQTLnIe1cc9/5Ld831bZ/nAt9Wg5lp1newrfAMyIRc2MLAKBi81
 AnMlg5jWcej7WnYbrBjJpwOVAVF2JqKY7/AVp0vd+z92tHCCEweJJ8A73UISupdVbgTX7xODTVa
 h5Si7BodX571PND5AybJaau/Uuqz8plXt2GMLSz+0+yoMAzSSjbPuwYdRHtfgQh8fNxK18BnMU5
 vAqplGrXTktryZWIbSfRdyZ8v+N+NWUGlM848VRv1slRGZSndepfOmYEqeyqKGAuST74j9MFBFg
 X5Azm3HUhg50Yz4HZ64mLLQ8MqjAOLze6knqS4xae2HaoCSblfRY98TzgX3X5nkfvGA3yxLDF9k
 CQujpZUlHWhw==
X-Google-Smtp-Source: AGHT+IE6hOP0aJJspvb7o/9YaIT/qdhZ+oI7HN43/4DVGM9ezRtCg7GHzoXuyNgnWzBGVA4nzWGcEQ==
X-Received: by 2002:a05:6a20:7486:b0:35f:b243:46cb with SMTP id
 adf61e73a8af0-3898f8f4c75mr7271084637.12.1767892329400; 
 Thu, 08 Jan 2026 09:12:09 -0800 (PST)
Received: from ktock.. ([240d:1a:3b6:8b00:7ace:63ca:408f:4cc4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a507sm82808355ad.3.2026.01.08.09.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 09:12:08 -0800 (PST)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 2/4] configure: Enable to propagate -sMEMORY64 flag to
 Emscripten
Date: Fri,  9 Jan 2026 02:11:26 +0900
Message-ID: <a2f068c7884a629fe3e4b297368d70b0956ab048.1767886100.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1767886100.git.ktokunaga.mail@gmail.com>
References: <cover.1767886100.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Currently there are some engines that don't support wasm64 (e.g. unsupported
on Safari[1]). To mitigate this issue, the configure script allows the user
to use Emscripten's compatibility feature, "-sMEMORY64=2" flag[2].

Emscripten's "-sMEMORY64=2" flag still enables 64bit pointers in C code. But
this flag lowers the output binary into wasm32, with limiting the maximum
memory size to 4GB. So QEMU can run on wasm32 engines.

[1] https://webassembly.org/features/
[2] https://emscripten.org/docs/tools_reference/settings_reference.html#memory64

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 configure | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 92bfc5f976..326d27dab1 100755
--- a/configure
+++ b/configure
@@ -182,6 +182,10 @@ EXTRA_CXXFLAGS=""
 EXTRA_OBJCFLAGS=""
 EXTRA_LDFLAGS=""
 
+# The value is propagated to Emscripten's "-sMEMORY64" flag.
+# https://emscripten.org/docs/tools_reference/settings_reference.html#memory64
+wasm64_memory64=1
+
 # Default value for a variable defining feature "foo".
 #  * foo="no"  feature will only be used if --enable-foo arg is given
 #  * foo=""    feature will be searched for, and if found, will be used
@@ -239,6 +243,8 @@ for opt do
   ;;
   --without-default-features) default_feature="no"
   ;;
+  --wasm64-32bit-address-limit) wasm64_memory64="2"
+  ;;
   esac
 done
 
@@ -521,7 +527,7 @@ case "$cpu" in
     CPU_CFLAGS="-m32"
     ;;
   wasm64)
-    CPU_CFLAGS="-m64 -sMEMORY64=1"
+    CPU_CFLAGS="-m64 -sMEMORY64=$wasm64_memory64"
     ;;
 esac
 
@@ -779,6 +785,8 @@ for opt do
   ;;
   --disable-rust) rust=disabled
   ;;
+  --wasm64-32bit-address-limit)
+  ;;
   # everything else has the same name in configure and meson
   --*) meson_option_parse "$opt" "$optarg"
   ;;
@@ -904,6 +912,8 @@ Advanced options (experts only):
   --disable-containers     don't use containers for cross-building
   --container-engine=TYPE  which container engine to use [$container_engine]
   --gdb=GDB-path           gdb to use for gdbstub tests [$gdb_bin]
+  --wasm64-32bit-address-limit Restrict wasm64 address space to 32-bit (default
+                               is to use the whole 64-bit range).
 EOF
   meson_options_help
 cat << EOF
-- 
2.43.0



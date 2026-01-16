Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FF3D4A5F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgaaY-00054G-8B; Thu, 15 Jan 2026 22:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaaW-000542-Ev
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:33:28 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaaU-0005Bz-Ow
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:33:28 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-81345800791so1007150b3a.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534405; x=1769139205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5K8Gno/91nHdx8Gqv7HA5rsj9100ib32U380sespwo=;
 b=X50EyF5Qrq15rI0D5/LuYuTj/kj9kr/xeSRVyTD0CnWjDFcPxcjzIGdllfrD8yG+U0
 Y1YW3R7JP1DzdUFv9wFDsoNwaW3PmYRUkCtxBVWz73btDiZP/MZt7IYcloQ+zHYZXNR0
 ZylOYAKT3s1QNlEBTOnzzEXyeNPZr73ieZMJ+4Wlkoka81f/PM8lS7RN7QGGJXRNjCWF
 +sBgi7O4nc13XJsMvle1/QvJXcdR/nOBY7XD4e5EcLLyf3i3sBE39lfhgtvauQeRFle9
 yLaoOe8jcjJeALVrHtx6QKd25ymYs7hCIhG5EvSHAaVZaM6/igPmy42C2ASiPm30gfNp
 VBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534405; x=1769139205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k5K8Gno/91nHdx8Gqv7HA5rsj9100ib32U380sespwo=;
 b=Gqucd5SNN9h16blKiEiJ77zZMywFPzMFfzjBD6Yco7zMykxZRdbo87CsMeP9VBX+T6
 15sssyYy4XZRqPMYruJfEZbaIG1cs5qeRCaCGB1BMcUpvD41q8XN1nkf8YSwitpCLoHB
 pHQNskakjkCFpOEPJXm5fX/CUH00dCWYj6oJSnuqlEBM6ttAvFWDbBhIEHn4SkE6rXCS
 oyfuG0p/70chmkC1IoKFtkCx5LikonDlVDzU+ttLpLXRM52h9Ete2UQl+ASRo41QUVW0
 7GM6CFusEkK1uLTowjNYuF3vhXIKR/skpUej37QhorG7I69kiYYcx8O8q8SvQP79rSdG
 akag==
X-Gm-Message-State: AOJu0Yz427cuJ2jf1BR4zaIVcEJJyxyjT/a/CM8pTFncs8el3E+qtxfB
 D8TQje7X+SDRDnTBo6BzLjMHCluP3ZVC+htL+PjntgmJAJ9BMK3zvP9kJFnGhM6p49Y938Lp0Es
 3ePn2W6ipnw==
X-Gm-Gg: AY/fxX7aokVpEnccoCKCaA46gME+XBSzjFpa3auUFJZYW5SZUpkOSW3BHbJBhySpoZG
 F/YyOa4S0+7E3pk5FaNfDyd24VrZqvV2SlWMjNaNPkxafqAnbEgbluYIjF5yfi6zevP+fiunasF
 mgQS/C4zaSu2Gwa5So5VrwAzJ1ej7rioxaGm2buaIsoMvHlh6pPTz4O2p+7sIeAP35MOimf1cWr
 lgg/y9YZsRGpKUB4hu7mvEwbugRNDImWeSLPLupFH9mJUAXWzJnLlGFEjJDk+Zj5YoUMJeKo2Eo
 +wO4VELWnlauqB8PF0r4TDfFoXtrYkVdMI+IZ/ccouxtbSCRQufggMjdBgzIDzR3ISdtkPrQ2Qj
 R9kLu8uKi4mkVJNwyTQraE+E7yVd6GgefLjGPRoqYg5lJiTzFltu3nc+K9RbvPIng8WkTkfNXE6
 lG/lNdL0U2KU72ew2bkw==
X-Received: by 2002:a05:6a00:94c7:b0:81f:4a36:1c7c with SMTP id
 d2e1a72fcca58-81fa179f582mr1210055b3a.23.1768534405337; 
 Thu, 15 Jan 2026 19:33:25 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:33:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 02/58] configure: Enable to propagate -sMEMORY64 flag to
 Emscripten
Date: Fri, 16 Jan 2026 14:32:08 +1100
Message-ID: <20260116033305.51162-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

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
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a2f068c7884a629fe3e4b297368d70b0956ab048.1768308374.git.ktokunaga.mail@gmail.com>
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



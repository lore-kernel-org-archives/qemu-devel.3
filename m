Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927EFCA0EF7
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoQyx-0004sG-5z; Tue, 19 Aug 2025 14:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQyw-0004rx-6F; Tue, 19 Aug 2025 14:22:50 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQyu-0003lR-7t; Tue, 19 Aug 2025 14:22:49 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-244581cc971so66734785ad.2; 
 Tue, 19 Aug 2025 11:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627766; x=1756232566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zvwZVYkwT7L+29JJJedvOVMf75yz0b8pNBu4QKDuOyI=;
 b=cgHyR3ezyAIJu7KHaR4zlNK8BomaDoWXQzVUIF+/oLM8Mn8ZTnrhdyqu1Rot3KdFvQ
 LEgSd8SddgMIOxxe5ApLKFhxbDmVWcu5hXRyw4Q7ygiydarURg8GnQU7B/UaahYf6Mef
 69OeM5RO4kcHJiR0eK/hDiOo6jWbr22ohrsqIVed5j9LWvpy4i7+GlKN2SgO8dlPZ0z8
 SYDEJ/vSZ1ftGIpQefo1UC6BL9OtqwgUFV6vccpbgJ0FeKBrRGUITU01lL9QvzYNjfFn
 ENHfwtzD7vgB2mzdEsFAwDE+hmX/pBbN25Tb036NUB2s0517IXuSi3IiItJxY2eCHa1G
 iJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627766; x=1756232566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvwZVYkwT7L+29JJJedvOVMf75yz0b8pNBu4QKDuOyI=;
 b=w1bLX9+X73SAtJ2tjmiyqpNW9Mg807RVOby75Qb92XW83EsfQJLnG/DfsUErBeEmEr
 /8I/oOdzCmWlooJNF9JGGnFbJUZkETdRk8ZG7RE2EN78KtgQ/mnOt6AygF6B+EMi+ml6
 3bgPeGXu7B2KOZXWOSvzdV/icoc2jogIUwn8hE1u4D840I4mdsaoZotsaR38vsxgUlhg
 NXbxIYqPQdj0kGVbabQ2UyEoRmVEWARNGaTsV4bClJ44RRvw5nJhN3S5UkzbxLlDO/G0
 6tiyDnHMsm00UGXqH8pfIuJfVVC1KNHSW45tbaIsTZuMGvh/3u9Yc5pNH7ZG/UV4dpD2
 2heg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDo0zkCLNYU3t4EPBGznu9+rrZAOSRL90xNKZoiA+jZD1QzJELQ+l/wZJat5pFk1BUkszStUPdtQ==@nongnu.org,
 AJvYcCXnr1eCxmyB2C/hfNLi4uG0Z1RYZtQY4dxUwHC4u5YR4udf9M2zbCAMMDSt9IvOgzlZhxlGdMH2lhz+PQ==@nongnu.org
X-Gm-Message-State: AOJu0Yzmbv2PBPGLEMfm0dJHEXHhQ5Xyj2Pulbu5jv4U3UjNbKrGT+3F
 iMGoVdzBQbtBHTjr7PUz4QlawrWBKf4D1x2GU9L9rgQSzhRodly+lVgZw1kazE2n
X-Gm-Gg: ASbGncuOyaDUZd/II1Mk4wIdN1SHLKnLif1BY/0QLejenW/WfHX6H3pIeahaJGGHc9w
 +n2bpjvDimeksD3938Y8XSxNcF5BdYGJ3lKbo5jC6vs1yiWiVmUub7j531q3rG/W+HIjIyRJzAj
 sR8K3FlotQbWri+w3hrOz5Pr+9Pw/kGiiWz5MwkAXVkgxe4sFPXKEigzn2C5irYWbMF+ZKIO0b5
 arcTd6rXls5/InpxqtVjcrPkkDNy73VPvOidis4eAU/cdvm2RzhFiQW8CKC+7GKcpkMoSbkY/gi
 u+Br8sSM9rOL+wVn5vyXkTp6p4VpLUnL3H6xV8ilMHkafmBdbJaBpDGVx/EFzB99B+n6n01XriQ
 toS4JSC26ZBBc7rF0xv6n8Q==
X-Google-Smtp-Source: AGHT+IEnH7r5HCtDn1tBZq14+QqiRFSdewNpZPU4arw+CqSkaiw8ixeWuTyGfm0qKedCQAY0kVuU1A==
X-Received: by 2002:a17:902:f682:b0:23f:df36:5f0c with SMTP id
 d9443c01a7336-245e047d995mr51450535ad.29.1755627766028; 
 Tue, 19 Aug 2025 11:22:46 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:22:45 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH 02/35] configure: Enable to propagate -sMEMORY64 flag to
 Emscripten
Date: Wed, 20 Aug 2025 03:21:31 +0900
Message-ID: <574dee5a5cb19d15dbfbe94cea31de23189596a9.1755623521.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62a.google.com
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

V1:
- This commit is under review in another patch series so please ignore it
  here.

diff --git a/configure b/configure
index 7f3893a42f..0587577da9 100755
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
 
@@ -537,7 +543,7 @@ case "$cpu" in
     CPU_CFLAGS="-m32"
     ;;
   wasm64)
-    CPU_CFLAGS="-m64 -sMEMORY64=1"
+    CPU_CFLAGS="-m64 -sMEMORY64=$wasm64_memory64"
     ;;
 esac
 
@@ -795,6 +801,8 @@ for opt do
   ;;
   --disable-rust) rust=disabled
   ;;
+  --wasm64-32bit-address-limit)
+  ;;
   # everything else has the same name in configure and meson
   --*) meson_option_parse "$opt" "$optarg"
   ;;
@@ -920,6 +928,8 @@ Advanced options (experts only):
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



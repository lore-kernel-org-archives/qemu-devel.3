Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C47D1BDD3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80sa-0006V0-6P; Mon, 04 Nov 2024 12:28:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sT-0005vw-5n
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sQ-0000OU-Pl
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3lFu90NjWg0SYteCDLmbz/R+IMonQxZkD/nPXECqYIo=;
 b=QiBIU70+cphWbGy/HUEP43RTU4Xnywzfnp2xThjIKYJeHoIq2srCjVwe70EqcNh4lBLW0a
 TXizQw4o13m1cEBBI8/4hKykeWttFnNtQ7+yHc75l8C8jpskZAjaiI7J9B1/eOul6D3PWf
 FmxqH4L1xHz1iox2NBo70mfdjCPzMy8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-ZBIq9ld6Ma--gUdGCqix-Q-1; Mon, 04 Nov 2024 12:28:28 -0500
X-MC-Unique: ZBIq9ld6Ma--gUdGCqix-Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d5116f0a6so2225260f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741307; x=1731346107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3lFu90NjWg0SYteCDLmbz/R+IMonQxZkD/nPXECqYIo=;
 b=vVKcG/BK9ZzH/Dp93zbNhTMQ6yAC8CNBRajSMVBPj4oqpNNfy3ImMTEsbLFpKBoffs
 acjfGuI2RvPcpfObQjWlRtskD4qKt3jPLQz9mxA12xzmuUt8NJLkoNWaoXaHiIoBcvxL
 zwujGQ7/wbumR6Ev3tTfEiE26N9IgYc9+WYpFzQZ4e0VHWSsvkSTeG6sNVSoZcClr8pn
 bQU2C7dxVxbYNrp+tulbmonNNNdw9RHR8KmI7iSjiyP9qOd/NDmBx8MTHrWK2Xux+4EM
 gwk+UOUCkfXYsuBrpaEY2rN7KH7McRLB27sV/37qC+63PGzljbG7j9kiJmaUU2q/oZQ/
 /nAw==
X-Gm-Message-State: AOJu0YzYWFWxOZ/UCQKl6Fjg9k/QtUqGwGXO/41u5IzRZS5NUMZW5wHW
 8fi34JaDILpuVp9m/HFzG/Aji9O/Sh6FSx1GM2cJUV+SZtbuJNj7R3yGDcpzxrNDb+5yu53NJ11
 fXmCY5gHvgkHiAOAdjThAXHrgeVVgzwNOAsvDY6Mug0jVP8hzXM2imxdfLq3dOr91Wh/lvlC/7L
 ZXsB7Op1jbtPy/2APhHBST/V0rV2XZMy+ZU7+cKT4=
X-Received: by 2002:a05:6000:4027:b0:37d:4ebe:164a with SMTP id
 ffacd0b85a97d-381c7ac7704mr11244110f8f.50.1730741306752; 
 Mon, 04 Nov 2024 09:28:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWX9YvBoN2s2gc9thcdztDytmiVtAAfFVQut6N7TQ2ig1lwfrSbQvrt0IfyY4vpP1XrneOig==
X-Received: by 2002:a05:6000:4027:b0:37d:4ebe:164a with SMTP id
 ffacd0b85a97d-381c7ac7704mr11244067f8f.50.1730741306273; 
 Mon, 04 Nov 2024 09:28:26 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7bf7sm13917889f8f.9.2024.11.04.09.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:28:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 29/40] rust: silence unknown warnings for the sake of old
 compilers
Date: Mon,  4 Nov 2024 18:27:08 +0100
Message-ID: <20241104172721.180255-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Occasionally, we may need to silence warnings and clippy lints that
were only introduced in newer Rust compiler versions.  However, this
would fail when compiling with an older rustc:

error: unknown lint: `non_local_definitions`
   --> rust/qemu-api/rust-qemu-api-tests.p/structured/offset_of.rs:79:17

So by default we need to block the unknown_lints warning.  To avoid
misspelled lints or other similar issues, re-enable it in the CI job
that uses nightly rust.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   | 8 ++++++++
 .gitlab-ci.d/buildtest.yml    | 2 +-
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 4 ++++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index aa0b0fc5584..2f7e0550105 100644
--- a/meson.build
+++ b/meson.build
@@ -3341,6 +3341,14 @@ if have_rust and have_system
   # Prohibit code that is forbidden in Rust 2024
   rustc_args += ['-D', 'unsafe_op_in_unsafe_fn']
 
+  # Occasionally, we may need to silence warnings and clippy lints that
+  # were only introduced in newer Rust compiler versions.  Do not croak
+  # in that case; a CI job with rust_strict_lints == true ensures that
+  # we do not have misspelled allow() attributes.
+  if not get_option('strict_rust_lints')
+    rustc_args += ['-A', 'unknown_lints']
+  endif
+
   # Apart from procedural macros, our Rust executables will often link
   # with C code, so include all the libraries that C code needs.  This
   # is safe; https://github.com/rust-lang/rust/pull/54675 says that
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 19ba5b9c818..aba65ff833a 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -128,7 +128,7 @@ build-system-fedora-rust-nightly:
     job: amd64-fedora-rust-nightly-container
   variables:
     IMAGE: fedora-rust-nightly
-    CONFIGURE_ARGS: --disable-docs --enable-rust
+    CONFIGURE_ARGS: --disable-docs --enable-rust --enable-strict-rust-lints
     TARGETS: aarch64-softmmu
     MAKE_CHECK_ARGS: check-build
   allow_failure: true
diff --git a/meson_options.txt b/meson_options.txt
index 0ee4d7bb86b..e46199a3232 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -376,3 +376,5 @@ option('x86_version', type : 'combo', choices : ['0', '1', '2', '3', '4'], value
 
 option('rust', type: 'feature', value: 'disabled',
        description: 'Rust support')
+option('strict_rust_lints', type: 'boolean', value: false,
+       description: 'Enable stricter set of Rust warnings')
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 6d08605b771..e898b20307d 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -47,6 +47,8 @@ meson_options_help() {
   printf "%s\n" '                           getrandom()'
   printf "%s\n" '  --enable-safe-stack      SafeStack Stack Smash Protection (requires'
   printf "%s\n" '                           clang/llvm and coroutine backend ucontext)'
+  printf "%s\n" '  --enable-strict-rust-lints'
+  printf "%s\n" '                           Enable stricter set of Rust warnings'
   printf "%s\n" '  --enable-strip           Strip targets on install'
   printf "%s\n" '  --enable-tcg-interpreter TCG with bytecode interpreter (slow)'
   printf "%s\n" '  --enable-trace-backends=CHOICES'
@@ -490,6 +492,8 @@ _meson_option_parse() {
     --disable-spice-protocol) printf "%s" -Dspice_protocol=disabled ;;
     --enable-stack-protector) printf "%s" -Dstack_protector=enabled ;;
     --disable-stack-protector) printf "%s" -Dstack_protector=disabled ;;
+    --enable-strict-rust-lints) printf "%s" -Dstrict_rust_lints=true ;;
+    --disable-strict-rust-lints) printf "%s" -Dstrict_rust_lints=false ;;
     --enable-strip) printf "%s" -Dstrip=true ;;
     --disable-strip) printf "%s" -Dstrip=false ;;
     --sysconfdir=*) quote_sh "-Dsysconfdir=$2" ;;
-- 
2.47.0



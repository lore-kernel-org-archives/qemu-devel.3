Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11447D68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBzOE-00071v-NL; Fri, 15 Nov 2024 11:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBzNk-0006aR-Fc
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:41:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBzNh-0002NO-K2
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731688873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=21GUR4wAO6jBo8H2QNojVW9mDn5/11rbisElFvTu3Ac=;
 b=O5iBOantgcMRRkvYxy/ZajPJIu59OZa1PnKSnQ8hyN0BKfoQkXcDscGOgg9gWoPqmG6WWd
 tsgMgSHEeB5rLeHCKxmLmzXIVQLcwmSAVwkYz+p+taJhDkPOiuSVkcNtP8jATg2mjpFoEF
 0DjcDbZ0D+pHXCnN/4msijrARMFnByE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-xhTJKQNgMh6bbdd4Vsexeg-1; Fri, 15 Nov 2024 11:41:11 -0500
X-MC-Unique: xhTJKQNgMh6bbdd4Vsexeg-1
X-Mimecast-MFC-AGG-ID: xhTJKQNgMh6bbdd4Vsexeg
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-432d9bb0f19so12053475e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731688868; x=1732293668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=21GUR4wAO6jBo8H2QNojVW9mDn5/11rbisElFvTu3Ac=;
 b=Qo63AfI8hdexbeIPiCtasz7zTQaMsZfafLAQmzTN3sQ1FJ1gtTjdxlpLTY1+cAOlPF
 nS7uD/ox/eAstVWF/W4xPDph67obNBxKcYu0joNo5c2UHDcxrPvQXia6ZZReLmTQQunR
 6MfkizlkD6qO9oJ4owNObLKo7z2qTtYZnmiyubHvIU9PKKykNDqkpl9ATrpDXhrhXPgN
 6olcRPtcWA4js0UyDmRgTvCP+la1PUUAuHlWVcTpFCl5pYBo1Id4LmwGU3/12JCSW3IR
 ayqFhUF1hktxqxpnCv0DAPZOotzPln6quyLoYM1byQgB19v+/hF97stFeGQfo9lDWkiI
 vkOQ==
X-Gm-Message-State: AOJu0YzW/QFo7vEZx65dQctwgfJmNRH+rVSFogAwn86ovNGk3yiTOUF8
 0CGlJLyz8p5oMShMXYm/iUtwvHUbv6mTK3kseQTTcgZD9ZLbSMySLgPgbELSdXrw8F4xyWr7t6K
 mDm6CurPdd76C7E+WVw7OJeTOg3uafoMU5eZ23LN9msHNVEUIirZHF9T61CTONpoAdNCM3wFFd8
 9T7JkWhRTJS1I6zMo9t15EI6lqHlFLEy4x0XzI7QA=
X-Received: by 2002:a05:600c:1c2a:b0:432:7c30:abf3 with SMTP id
 5b1f17b1804b1-432d974a829mr75294155e9.7.1731688868584; 
 Fri, 15 Nov 2024 08:41:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzhsQ+zoIdjAo89HZudwP7NIBS+t5yLbVTYFq13I7ZnhEC0s+mPpebu63A/9+ErVsY9h45gA==
X-Received: by 2002:a05:600c:1c2a:b0:432:7c30:abf3 with SMTP id
 5b1f17b1804b1-432d974a829mr75293945e9.7.1731688868197; 
 Fri, 15 Nov 2024 08:41:08 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da28bc11sm61758915e9.31.2024.11.15.08.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 08:41:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, berrange@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org, kwolf@redhat.com
Subject: [PATCH 10/12] rust: build: add "make clippy", "make rustfmt",
 "make rustdoc"
Date: Fri, 15 Nov 2024 17:40:23 +0100
Message-ID: <20241115164025.1917618-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115163944.1917393-1-pbonzini@redhat.com>
References: <20241115163944.1917393-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Abstract common invocations of "cargo", that do not require copying
the generated bindgen file or setting up MESON_BUILD_ROOT.

In the future these could also do completely without cargo and invoke
the underlying programs directly.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/meson.build        | 22 ++++++++++++++++++++++
 rust/qemu-api/README.md | 10 ++++++----
 rust/qemu-api/build.rs  |  9 +++++++--
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/rust/meson.build b/rust/meson.build
index def77389cdd..91e52b8fb8e 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -2,3 +2,25 @@ subdir('qemu-api-macros')
 subdir('qemu-api')
 
 subdir('hw')
+
+cargo = find_program('cargo', required: false)
+
+if cargo.found()
+  run_target('clippy',
+    command: [config_host['MESON'], 'devenv',
+              '--workdir', '@CURRENT_SOURCE_DIR@',
+              cargo, 'clippy', '--tests'],
+    depends: bindings_rs)
+
+  run_target('rustfmt',
+    command: [config_host['MESON'], 'devenv',
+              '--workdir', '@CURRENT_SOURCE_DIR@',
+              cargo, 'fmt'],
+    depends: bindings_rs)
+
+  run_target('rustdoc',
+    command: [config_host['MESON'], 'devenv',
+              '--workdir', '@CURRENT_SOURCE_DIR@',
+              cargo, 'doc', '--no-deps', '--document-private-items'],
+    depends: bindings_rs)
+endif
diff --git a/rust/qemu-api/README.md b/rust/qemu-api/README.md
index 53810f48882..ed1b7ab263d 100644
--- a/rust/qemu-api/README.md
+++ b/rust/qemu-api/README.md
@@ -5,13 +5,15 @@ This library exports helper Rust types, Rust macros and C FFI bindings for inter
 The C bindings can be generated with `bindgen`, using this build target:
 
 ```console
-$ ninja bindings.inc.rs
+$ make bindings.inc.rs
 ```
 
 ## Generate Rust documentation
 
-To generate docs for this crate, including private items:
+Common Cargo tasks can be performed from the QEMU build directory
 
-```sh
-pyvenv/bin/meson devenv -w ../rust cargo doc --no-deps --document-private-items
+```console
+$ make clippy
+$ make rustfmt
+$ make rustdoc
 ```
diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
index 06e79082b5f..33e7968ee76 100644
--- a/rust/qemu-api/build.rs
+++ b/rust/qemu-api/build.rs
@@ -20,8 +20,13 @@ fn main() -> Result<()> {
     let file = Path::new(&file);
     if !Path::new(&file).exists() {
         panic!(concat!(
-            "No generated C bindings found! If you want to run `cargo`, start a subshell\n",
-            "with `meson devenv`, or point MESON_BUILD_ROOT to the top of the build tree."
+            "\n",
+            "    No generated C bindings found! Maybe you wanted one of\n",
+            "    `make clippy`, `make rustfmt`, `make rustdoc`?\n",
+            "\n",
+            "    For other uses of `cargo`, start a subshell with\n",
+            "    `pyvenv/bin/meson devenv`, or point MESON_BUILD_ROOT to\n",
+            "    the top of the build tree."
         ));
     }
 
-- 
2.47.0



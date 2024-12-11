Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E7CE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZA-0002L1-Fp; Wed, 11 Dec 2024 11:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZ6-0001pR-3e
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:27:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZ2-0000J7-L5
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rO+WbGRzMRexJETWrTif2Ds1kn3dKu1gBbcNzz0Vto4=;
 b=gvksG4RB312af+yJSL6zKtgbWrp8zjXr1BN+eFAHFaOcxONUbmnz7dxyFZuEs9VfyWnYih
 wFaskFSAm+6LnvpVdEOU42cv0RZ5TTKCtIjRiDD9S6yHy/v7DRYpizi5Kp/6HqyxKGH9yV
 HX0zFH+Sza+IaFw+lLyWCJLfo/ZPpBo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-DX2w91FONjGYpf6t2Qg0LQ-1; Wed, 11 Dec 2024 11:27:50 -0500
X-MC-Unique: DX2w91FONjGYpf6t2Qg0LQ-1
X-Mimecast-MFC-AGG-ID: DX2w91FONjGYpf6t2Qg0LQ
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6e1b0373bso208758685a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934469; x=1734539269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rO+WbGRzMRexJETWrTif2Ds1kn3dKu1gBbcNzz0Vto4=;
 b=hp5wUXkS7nL66gXh6fCe/IzcuxjYI8PlNMgdN46Jnk0ymsuOExvXZ6KEmKlJfVGBSM
 eM9FnnMQa25Y5ywGFnL3AT6/LC0Ypt5daCijCRbnUeSBlpTEC9qrYg/nAvcR3Ww/cJxs
 AYEGw31simVpDo8sljvLghvvdkK20cHueSybL+rbublBEA2tIBR0j73hg7RbxOHO4bzi
 2zDqmFE9yL6VaPS0tZjZtLVZNyYhE0gwIEMm+Gi321uaNPljDbVJp8M1TwFeqa4i0QTp
 aQc5qCJ0C1fV3AJY40krzX8xT73f3zlT34ML63TJf8Loqw+OFKjqWSrOGtCV/pn84EoO
 zqjg==
X-Gm-Message-State: AOJu0YzsRcqRVuGK0s/JebQX05/BH87rpwHS0BWfHyc0c6kfGiLaa7aX
 s1Ng+ZlQeFShU6GhbEe0BKyfe3vJXI6kIeyC42JYDBernJNld7GcBHOWP4IyD2lBaUfnxixw6uc
 X1p4TuiDOvuQJDSqE208g+/4VXaBMVigo1GAeJBN1uI39k2cnLOHhCazV7m2H+UGbVGY7LyKH8y
 htLlVG99WWaCumjL5bHv0Nt3VQVwnQ3NKN/doP
X-Gm-Gg: ASbGncvo6myn6YreKfE8xpUU+JVumXTMTy/GV7VS/c1c4OSFTklFhL7pWLzmgBXKCjt
 yr9Rfo/c56upk/eomnGPZCBaFgiSN9IWoS6UPP4dQezz6JGXswjXBAWVhaDwiuCialvyy1FSPqE
 ogqr+hLxOl57VZhjy5io41PGcOPLlBI9IGAfN+GM5snTDXR8G+27DjctDkaZIxzaxMQNH1Y1LzD
 oZYxdw/r2zWIAxN39PNXMMsZcgXMgxyRTPqZS360zUQpFq+IOTCfHzH
X-Received: by 2002:a05:620a:6007:b0:7b3:5858:1286 with SMTP id
 af79cd13be357-7b6eb52648bmr605127485a.47.1733934469046; 
 Wed, 11 Dec 2024 08:27:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZe7EA/21zaW+fVwyv+kk0qIt9cxBgEdOKtPZm1zreJrfC6jp5uyoGkETsGzk02WFu72f27g==
X-Received: by 2002:a05:620a:6007:b0:7b3:5858:1286 with SMTP id
 af79cd13be357-7b6eb52648bmr605123685a.47.1733934468599; 
 Wed, 11 Dec 2024 08:27:48 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6f1b5c5dcsm8236285a.68.2024.12.11.08.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:27:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Junjie Mao <junjie.mao@hotmail.com>
Subject: [PULL 11/49] rust: build: add "make clippy", "make rustfmt",
 "make rustdoc"
Date: Wed, 11 Dec 2024 17:26:41 +0100
Message-ID: <20241211162720.320070-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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
index 40644d5e4fe..471e6c633df 100644
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
2.47.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80786D185EF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdpnZ-000884-EL; Thu, 08 Jan 2026 08:11:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpnX-00084T-Ju
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpnW-000849-0D
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767877889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X2CkPrmAjPj0SGqqtniQ7b64jK4eZjmHP1vEC37hTGs=;
 b=LKhYcgKvo6OkizESHScQjScrrGiEt3LZNVkHcJX0mc8tMEFL0ilKOEWbIoRjGCuQiVQpjH
 2ZJTy0szc8F0mo6lSswHsn1dgWl3+22YVGy0mQH0UP8P21/BSzv2rqAh9gfHZemyiot5Eb
 Y8e+nh3oIYxRf7yg2b5vWrcdE5HARr8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-kohOy7-YPWiBPJ45wvXy5w-1; Thu, 08 Jan 2026 08:11:28 -0500
X-MC-Unique: kohOy7-YPWiBPJ45wvXy5w-1
X-Mimecast-MFC-AGG-ID: kohOy7-YPWiBPJ45wvXy5w_1767877887
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47a83800743so10536025e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767877886; x=1768482686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X2CkPrmAjPj0SGqqtniQ7b64jK4eZjmHP1vEC37hTGs=;
 b=dh1xswT6ywq8EwIigCplt5NIekW7xxwgiJUn9B6+8cQcuNoWIN4YIQJ9DCHcPr3f8g
 YBVGGLqOxLpmHjrb61X7XYbJ7uP1GDJYiwP2Rc1342VmR/IM0wpYLw1mgOPZHOl+gtb0
 95n4VWwpzVJ8xZFRaOQoWWFtUCapjJflk+GPe3WjssxFE4dbLyVb/vvZ0nAn2IerSVsL
 +reDzcr8hzLg/13C4ifEOOwYO3cODAhaGenZ5n4hQ1OAxmLrpbKv/oDJXwrVLBa9ejLp
 B408NMK0US/QHMEqrWgCMV2vHhMUoKpOO6D2hedPT0HTr/YEQOH75WNuJFEPu7UtJxZJ
 8xLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767877886; x=1768482686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X2CkPrmAjPj0SGqqtniQ7b64jK4eZjmHP1vEC37hTGs=;
 b=joeapbSABYwpyR7Z3q/9QU80y6m5+l/ONGSkvqQvNCG0MiD/NCoUnRB1W+74pRmlCt
 FkK3Gpd9q+TRlBsYFJgAvStUOuwSYUC6uo4vsdXAVqJo4tpQWRlWyCzgzNgHfyEak/gT
 oA2kRlWkGv/2CjNQHnn4rOBNanGcni+2htN5MjxJtGROzrtsslnBQy2xrA3ifY/eACMk
 7Z7nzI17e8OZ9gKRLERKjdGO5DGi5F4Lz1gqrboTw4L+LCPayBciaoXUKa4ehX3YFURI
 wgzbm9sRHy/ZnmH5sVSgPtdEHmq5gtg4DUxt9Z90HfjCOko0OTmzFS8ateZfU7FtQQF3
 is5w==
X-Gm-Message-State: AOJu0Yy3NbyrO+pJk4wCRsLlnC4xNYuVwksTIFroWbUI+G3Rh0uIy/kG
 UO5mumR9WlJDfmsOMYa4JUYsmvJUV2PLMJQMB3+J+K0vngADFJCLQBNXOFvrGRtmTsrSjReqfRY
 HXs9XMeC19wUpjHGZvt9Fdm+efQgU+4QK9B7/rN+bnPdfkrCVZpJfcMUPVmJwAri9mxfyEMwdIN
 zSeEaR2YuTeOYvBwz0iHXK88rqAqwc9DEFjGWfgjTT
X-Gm-Gg: AY/fxX7Q2vJy/7dMMM9XC7mF/2kkXKOEM+2b9gQ06149Q3o0wiXycDoYkTW/ZkONcN6
 2HOF3hjIKiuep3g4BSL2VvFA22zXdhRXZUpSOLYm7r0jFMBwoK+lyNcT435dG+DBLaXZy2AiZrX
 h487RYoz0mAqc7d3ZbDJUCtRG6LQuVtkibRxVSlEFM9CrouuElDzuuBgZaLKICiOoXbLQdsOpQF
 YQuiVfZP0ZGQQKTCEqF7Xy7R6IaN30D2r6001APLCjEfV7435JRq5luM1rDroAtfG7B9wDi3+S6
 GAXe1WUIE1zPyvqtisIgqGYOzJzOobKEZuzVSHfGxu3qkX+ya6mdpTVPcuAZ3AbPgXbH08HZQ6D
 G70knNOngMgn3e9n8DlRocrYKVzaMPk9zzT7mjNoS0G+Jdhf2nZQupk+yz0mmT/2S3vtkaveF1e
 yXyMBN4zXM8w8pBg==
X-Received: by 2002:a05:600c:46c3:b0:477:a2f7:74de with SMTP id
 5b1f17b1804b1-47d7f404854mr137698415e9.3.1767877886263; 
 Thu, 08 Jan 2026 05:11:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJOUy2wsdEPWdJd5w6lCP1oLrGJraiAqzUrHKYXtwpn0d+29LjKgOmAnUJLS+N29zBXbNPjA==
X-Received: by 2002:a05:600c:46c3:b0:477:a2f7:74de with SMTP id
 5b1f17b1804b1-47d7f404854mr137698135e9.3.1767877885878; 
 Thu, 08 Jan 2026 05:11:25 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5edb7esm15860259f8f.30.2026.01.08.05.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 05:11:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org
Subject: [PATCH v2 14/16] rust/util: build QAPI types
Date: Thu,  8 Jan 2026 14:10:41 +0100
Message-ID: <20260108131043.490084-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108131043.490084-1-pbonzini@redhat.com>
References: <20260108131043.490084-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/meson.build      |  9 +++++++++
 rust/Cargo.lock       |  1 +
 rust/Cargo.toml       |  2 +-
 rust/util/Cargo.toml  |  1 +
 rust/util/meson.build | 17 +++++++++++++++++
 5 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/qapi/meson.build b/qapi/meson.build
index a46269b5a0c..a019ec19db1 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -130,3 +130,12 @@ foreach output : qapi_outputs
   util_ss.add(qapi_files[i])
   i = i + 1
 endforeach
+
+# TODO: build together with the other files, perhaps when Rust is not
+# optional and/or the Rust backend is complete (currently lacking
+# commands, events, modules)
+qapi_rs_files = custom_target('QAPI Rust',
+  output: 'qapi-types.rs',
+  input: [ files('qapi-schema.json') ],
+  command: [ qapi_gen, '-o', 'qapi', '-b', '@INPUT0@', '-B', 'qapi.backend.QAPIRsBackend' ],
+  depend_files: [ qapi_inputs, qapi_gen_depends ])
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index b6c9f934140..7bca9b189db 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -454,6 +454,7 @@ dependencies = [
  "glib-sys",
  "libc",
  "serde",
+ "serde_derive",
 ]
 
 [[package]]
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 45ebfa693a4..caddb93722e 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -20,7 +20,7 @@ anyhow = "~1.0"
 foreign = "~0.3.1"
 libc = "0.2.162"
 glib-sys = { version = "0.21.2", features = ["v2_66"] }
-serde = "1.0.226"
+serde = { version = "1.0.226", features = ["derive"] }
 serde_derive = "1.0.226"
 
 [workspace.lints.rust]
diff --git a/rust/util/Cargo.toml b/rust/util/Cargo.toml
index 554004816eb..9f6c52c5acd 100644
--- a/rust/util/Cargo.toml
+++ b/rust/util/Cargo.toml
@@ -18,6 +18,7 @@ foreign = { workspace = true }
 glib-sys = { workspace = true }
 libc = { workspace = true }
 serde = { workspace = true }
+serde_derive = { workspace = true }
 common = { path = "../common" }
 
 [lints]
diff --git a/rust/util/meson.build b/rust/util/meson.build
index 92d27957eda..7987056962c 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -63,3 +63,20 @@ rust.doctest('rust-util-rs-doctests',
      dependencies: util_rs,
      suite: ['doc', 'rust']
 )
+
+_qapi_cfg = run_command(rustc_args,
+  '--no-strict-cfg',
+  '--config-headers', config_host_h,
+  capture: true, check: true).stdout().strip().splitlines()
+
+_qapi_rs = static_library(
+  'qapi',
+  qapi_rs_files,
+  rust_args: _qapi_cfg,
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  link_with: [_util_rs],
+  dependencies: [common_rs, serde_rs],
+)
+
+qapi_rs = declare_dependency(link_with: [_qapi_rs])
-- 
2.52.0



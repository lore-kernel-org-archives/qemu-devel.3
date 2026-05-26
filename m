Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBBBCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 17:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRw1k-0002JM-Kf; Tue, 26 May 2026 13:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1g-0002EL-KC
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:57:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1e-00085r-KI
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779818229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iyZOn8vowMt4BCTJvMxz9ts52f+qcFqcdwze56Aj1uE=;
 b=Vv2fInNfeOk4FJuUIXNr8eYtjSZsgeZ7XYZLbp5FO9b1V8UWgZhyiMELULr3AETS6zAR/H
 /PkzB3x2Ru6Pl+FjGlYsy7ro5JUTarmrQ8IOhcigwKkeQN/692eRugC9J05CMocEvMfFs3
 Z03kyvC4qNShSrVKVJw9cixTQaXZeCA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-xa0KSzCbMJu-mhIAemwL3Q-1; Tue, 26 May 2026 13:57:07 -0400
X-MC-Unique: xa0KSzCbMJu-mhIAemwL3Q-1
X-Mimecast-MFC-AGG-ID: xa0KSzCbMJu-mhIAemwL3Q_1779818227
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4518f777225so7723214f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 10:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779818226; x=1780423026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyZOn8vowMt4BCTJvMxz9ts52f+qcFqcdwze56Aj1uE=;
 b=JAI5dgBlr9ngCBRLObyIBio9XXv21sQnWJMYsAddJUrBhD6XXHQ8svz7uPdiYM4QBK
 nsqvfk4/e48LjxjxjKyb3lBrmZNF7ERyC3X7cAhiRSNY2pgarbZ52wAA7jRJQDxNe4Ej
 L6zsfj+XAmi+U2zuzms1knpd2I8BkhrHETCrG0225VW1CoKr+4yFWkrWU25t1ox9b0db
 fkiI23btXe3iHhYwRaswFvtm+6U882kPPo4B0pabF5b+I+4MIC8HrPW8uoGK4inapGOW
 5PkomFaI4nzlwBqh9SQmAA0ClWNZ1I5NYLf7F9okphj6E/ypTUsWU2w6V+xlqXkS2pET
 foOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779818226; x=1780423026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iyZOn8vowMt4BCTJvMxz9ts52f+qcFqcdwze56Aj1uE=;
 b=TpAmv4a+X3U+aZmjBA18Eu+R/e1+tNloBL55CBy/PcGVdlCfbkF3X+m30pp/4bnNCw
 9s1E9PApARXRpQezKqM7YTFF2mGarHUISn/AWgOYtQ+uWdspF9LPL5jnt9XpzvNlPa8Y
 SlDj/I5NriSmVvI8k6p729oIqC7hVuu+SP8hYxMpj1XO105JqzLWiTWBbw8ii+98sGqM
 QiXSZLfddvrvt1Iu5jxLgcd9ivQK+SIbvYDpGEK0/qzXzHTVXwtXn7DA+QKW+mC8DF8h
 5iqMs3Uw8SjRmyFXl8g6oRV32Vck2YvlFHOOabu5i0Cs5fwugSEpxwk/lNtjnTMJ+Yu0
 TB0w==
X-Gm-Message-State: AOJu0Yxh7WWazBMiKxs7wAOXzF+7wSLlnE4pN5bcnoca1XdJdhUr5MLx
 85qLJ640GLqb96sFo53sj9xnEVrr74cvWTMyHq3FlQd3N0okIUXq0PKl0UVNRcUdmH0rgMbWU88
 ZyL7oxK3omUMKRtPVsudSnHq3d5iCdUP0IHARbTdP7iN7nqSd6bSWHW/sHrXwol32Q5IQiY8cx7
 ogSwXC+yAhxaCitjloH9eJi0NQ1AgAnO8YXRZdfk95
X-Gm-Gg: Acq92OEh3C/XRI1fqYPCRy2a2/0lLQt1izscByeD7gCt1X9kfSqrUDL0H+Xt3L7qPsN
 EeRNlKgesd8SzU5ibyXfx5IFqDXtmxrhtzHmBE5gT2Wge53jOVvzMWShOD795EEKUZ40uCi7vM3
 YilM9QBGu+hq0j42yhDYUs9eGwVdJtQQsCoIsJlNcNcmsgr3l8wcrr5bGyy0OM4q4aySY6toACs
 YUWqTuURxS0NLTOI3B+moEf8StdqGjGIVodU41sI2PQl11Op1KesJXAFoRIqcHjEozgFaMqF1e5
 GBXmvVXomm1LqjdPqJD6VndprmPCuImURohv/0HRUuFZBUr0nZap4O+jdA9aO3B5Hd+AaD0dih+
 VRo3i52lnyLM50eiOrqD+IAJHQpxFRe/YgF/WnWdOkZ+EUUR1/hXNVxPgnI1ID135ewPOwUczoa
 w1OPMj7UANhUS2UssbizJ/zaOY9P9uwpr6KOU9LA==
X-Received: by 2002:a05:600c:4e0d:b0:490:5655:8d3f with SMTP id
 5b1f17b1804b1-49056558e57mr254573445e9.28.1779818226712; 
 Tue, 26 May 2026 10:57:06 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0d:b0:490:5655:8d3f with SMTP id
 5b1f17b1804b1-49056558e57mr254572965e9.28.1779818226327; 
 Tue, 26 May 2026 10:57:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d47b82sm37377299f8f.19.2026.05.26.10.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 10:57:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH v3 17/19] rust/util: build QAPI types
Date: Tue, 26 May 2026 19:56:16 +0200
Message-ID: <20260526175618.227743-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526175618.227743-1-pbonzini@redhat.com>
References: <20260526175618.227743-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index b9e8636b8bc..c73f037d689 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -514,6 +514,7 @@ dependencies = [
  "glib-sys",
  "libc",
  "serde",
+ "serde_derive",
  "util-sys",
 ]
 
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index fe491f3aba6..15296ac8636 100644
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
index 0a0400278f3..069ab167e87 100644
--- a/rust/util/Cargo.toml
+++ b/rust/util/Cargo.toml
@@ -18,6 +18,7 @@ foreign = { workspace = true }
 glib-sys = { workspace = true }
 libc = { workspace = true }
 serde = { workspace = true }
+serde_derive = { workspace = true }
 common = { path = "../common" }
 util-sys = { path = "../bindings/util-sys" }
 
diff --git a/rust/util/meson.build b/rust/util/meson.build
index a8d9978e1a9..3edd8245bfc 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -18,3 +18,20 @@ rust.doctest('rust-util-rs-doctests',
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
2.54.0



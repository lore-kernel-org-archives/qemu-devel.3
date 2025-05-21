Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03D0C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 08:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHefY-0004sG-Mj; Wed, 21 May 2025 04:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHefN-0004oR-IA
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:19:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHefI-0000Bk-El
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747815541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vi+4q+DuQzXZ0fGkhLusAtF/e0P3HvxStkXaBrSnrE4=;
 b=JB+JZbjgiUk+ObPnAwvQDQThT4U+1xFvHuGHd1tRdgzyOF/o0NKYhupi8KuZ+3v0f80GB/
 9icjtBJyPC08b1qBDfHlDKEz+8Vod/h0YGzPfgv2dZGa8vhQOYeKfZ2sO6jfAujDIH255q
 JoEU/Oq9diVxXFoRam/SP7tVe5DpHSY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-QEU0NnXjO-eexIpeZCx7IQ-1; Wed, 21 May 2025 04:19:00 -0400
X-MC-Unique: QEU0NnXjO-eexIpeZCx7IQ-1
X-Mimecast-MFC-AGG-ID: QEU0NnXjO-eexIpeZCx7IQ_1747815539
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a364d2d0efso2278105f8f.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 01:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747815538; x=1748420338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vi+4q+DuQzXZ0fGkhLusAtF/e0P3HvxStkXaBrSnrE4=;
 b=f99dSmBFhJi6I4fn2b61HkRyHWyNSmhWybPlge/IAP/GM0WLoiTCpJ9BfyKKqkBueN
 mDO7WWtA3LBcNt8W7dV3GNsoZiatcMB9HAs7cJLRc5ioNGuHielQLSBFmwXH82cFyiqu
 sZNCi8nybBz/IRMXf3h63NiplJbPVVsYLx2mC2nQSc3qgyjHbWLZPGKAM3YJKAYdIMwd
 yxQpCptXYsjmV5POc+t/nuAzHUd6n4pBAU8XnP1JI513FqdorzYP05bQFhW5FYLHpkBd
 NMFMnRJgXGbG4lhaZdI9veHXFa56FWstPVEu6IRqzzkZI8LieTinzwvrSEy5FDvnVLAR
 JQsA==
X-Gm-Message-State: AOJu0Yy3oLbpPy20Byifs8NN5ejQ2P7r0tuSeQmsfrEYwRoYPylCt5Xq
 hKLk5kMc1BylzpYFXTnE5j5DWiElLU81BxVKGq4ymbOoWeIVm03s2u9hRh1pw1co2WI4UPjGRZo
 0Ti+YyXVc5JAjMmuNnE9j78xIvP6l1/L2MxP5ibD3jHIzaoNIq7RbiVRznWTPUUzJNTNByIv+xn
 cioRVc6Mk0/uyDeByvYAtLLmRbE2R92G9zSMwsP0GM
X-Gm-Gg: ASbGnctKFO/RxOX+mFF9NWSeVyV8PDmtyUM23EZeHd+fc7j/Fk1ZGDLJqdgYQAb+e8e
 t1aRhKcO4CrMlBSWEOK2nGN6Y3mDNoyaWWbQic5C3acfqUFh5KwnNkSOfBVjPqIYKeee9lIVfEQ
 U0Hem3B/ogSOEi6MNmmquNNTS4ASNs2/PByg5vljygbSdI+JNUVMp5/8b0E3/VTDmb0znQ9cuNq
 tBa7rYeI7RDL3JW0fcbY/TjKbI9xVm2HCqc6ebicllA6LwfcBTnkwkZ9L5lgkbE/5Gk3DavRmi2
 4+aITA7U4rXuww==
X-Received: by 2002:a05:6000:178c:b0:3a3:671e:3b7c with SMTP id
 ffacd0b85a97d-3a3671e3c09mr13633138f8f.48.1747815537933; 
 Wed, 21 May 2025 01:18:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5/Qifu/phEJO+eeNN2LYJDlQEQdW78L1t3/lI3cccD9T9g03PDze6s8YhzFAFetysJ0VAnQ==
X-Received: by 2002:a05:6000:178c:b0:3a3:671e:3b7c with SMTP id
 ffacd0b85a97d-3a3671e3c09mr13633102f8f.48.1747815537417; 
 Wed, 21 May 2025 01:18:57 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca5aba3sm18586266f8f.40.2025.05.21.01.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 01:18:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-rust@nongnu.org,
 manos.pitsidianakis@linaro.org
Subject: [RFC PATCH 4/6] rust: subprojects: add bitfield-struct
Date: Wed, 21 May 2025 10:18:43 +0200
Message-ID: <20250521081845.496442-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521081845.496442-1-pbonzini@redhat.com>
References: <20250521081845.496442-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The bitfield-struct is much smaller than "bilge" and supports "const"
expressions better.  The main disadvantage is that it does not let you
annotate enums as bitfields and does not integrate with arbitrary-int,
thus requiring manual size annotations for anything that is not a bool,
iNN or uNN.

Lack of support for arbitrary-int is a very minor change; enums are a
bit more annoying because they require manual implementation of two
functions from_bits() and into_bits(); however, that is already handled
by QEMU's bits! and #[derive(qemu_api_macros::TryInto)] utilities.
Together, these basically make the manual work go away.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/meson.build                              |  3 ++
 subprojects/.gitignore                        |  1 +
 subprojects/bitfield-struct-0.9-rs.wrap       |  7 ++++
 .../bitfield-struct-0.9-rs/meson.build        | 36 +++++++++++++++++++
 4 files changed, 47 insertions(+)
 create mode 100644 subprojects/bitfield-struct-0.9-rs.wrap
 create mode 100644 subprojects/packagefiles/bitfield-struct-0.9-rs/meson.build

diff --git a/rust/meson.build b/rust/meson.build
index f370b0ec939..58f14a70d6d 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -1,3 +1,6 @@
+subproject('bitfield-struct-0.9-rs', required: true)
+bitfield_struct_dep = dependency('bitfield-struct-0.9-rs')
+
 subdir('qemu-api-macros')
 subdir('bits')
 subdir('qemu-api')
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index d12d34618cc..180c3134864 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -9,6 +9,7 @@
 /arbitrary-int-1.2.7
 /bilge-0.2.0
 /bilge-impl-0.2.0
+/bitfield-struct-0.9.5
 /either-1.12.0
 /itertools-0.11.0
 /libc-0.2.162
diff --git a/subprojects/bitfield-struct-0.9-rs.wrap b/subprojects/bitfield-struct-0.9-rs.wrap
new file mode 100644
index 00000000000..dfdbbc853af
--- /dev/null
+++ b/subprojects/bitfield-struct-0.9-rs.wrap
@@ -0,0 +1,7 @@
+[wrap-file]
+directory = bitfield-struct-0.9.5
+source_url = https://crates.io/api/v1/crates/bitfield-struct/0.9.5/download
+source_filename = bitfield-struct-0.9.5.tar.gz
+source_hash = b2869c63ccf4f8bf0d485070b880e60e097fb7aeea80ee82a0a94a957e372a0b
+#method = cargo
+patch_directory = bitfield-struct-0.9-rs
diff --git a/subprojects/packagefiles/bitfield-struct-0.9-rs/meson.build b/subprojects/packagefiles/bitfield-struct-0.9-rs/meson.build
new file mode 100644
index 00000000000..e8badb7da18
--- /dev/null
+++ b/subprojects/packagefiles/bitfield-struct-0.9-rs/meson.build
@@ -0,0 +1,36 @@
+project('bitfield-struct-0.9-rs', 'rust',
+  meson_version: '>=1.5.0',
+  version: '0.9.5',
+  license: 'MIT',
+  default_options: [])
+
+subproject('quote-1-rs', required: true)
+subproject('syn-2-rs', required: true)
+subproject('proc-macro2-1-rs', required: true)
+
+quote_dep = dependency('quote-1-rs', native: true)
+syn_dep = dependency('syn-2-rs', native: true)
+proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
+
+rust = import('rust')
+
+_bitfield_struct_rs = rust.proc_macro(
+  'bitfield_struct',
+  files('src/lib.rs'),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_args: [
+    '--cap-lints', 'allow',
+    '--cfg', 'use_fallback',
+  ],
+  dependencies: [
+    quote_dep,
+    syn_dep,
+    proc_macro2_dep,
+  ],
+)
+
+bitfield_struct_dep = declare_dependency(
+  link_with: _bitfield_struct_rs,
+)
+
+meson.override_dependency('bitfield-struct-0.9-rs', bitfield_struct_dep)
-- 
2.49.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A84CCD188
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lQI-0008BT-KS; Thu, 09 Oct 2025 03:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQF-0008Ai-2C
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:50:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQ6-0004JQ-00
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q+W9mI2TEY8Vy131c26AX2u4Sj+/YtxNA/TPL0BdJ4c=;
 b=WRut60cqKRqNGoQXrQ3wE8i6QEsUrsxgJOlPtjmoNh8W0Q+O/J+3BNp1yKMjrwofDTvSvp
 m8q6fBogtPEGEWOUHzwBU/IiGF4EVMtQJPOrgLPa+idahrF46CHUc2wDzr3xegIozeBfZK
 KgwMvpnEXyc/eQ1s6kzkdv9OOecm7Tw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-IhnBmfLiMNqiBCmGbQ4hUQ-1; Thu, 09 Oct 2025 03:50:33 -0400
X-MC-Unique: IhnBmfLiMNqiBCmGbQ4hUQ-1
X-Mimecast-MFC-AGG-ID: IhnBmfLiMNqiBCmGbQ4hUQ_1759996232
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3efe4fcc9ccso558339f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996232; x=1760601032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q+W9mI2TEY8Vy131c26AX2u4Sj+/YtxNA/TPL0BdJ4c=;
 b=t+9RSqQIKwzk8p++qMO3nllWhKlsZvV455sxxN1K6+xhyt68gKXShTDHZxcHlpawtn
 HE30WtEM7XkgQMkivBvVNsSGCO+PLU6MvSywtzuDZsdXN+qY31iL2s5/p9PMUQaAMF5w
 /c66S30nTAB9KInM5o8xb/LNyM4YqzMY32SqxUS86+6hakygFpOiRHJvKDKCL40xqJin
 w9ebHdSraMt1uC25Rh6KL21d7Cd+pyNMcuhmenaBiW2gFW/jdWztWDNDVJK2xb6yVyoA
 jpYTj7TAflLxoNzuLmxJB6tNOMUmz2rKayRLTOAJ33LCgj7XwDoQGncO6XVyr31iw8Tv
 ORsQ==
X-Gm-Message-State: AOJu0Yx7uc4Okws+DOoVa28Z+vn7w2EHhAHGTTAUcR1PqN1wIe6rAlG4
 3jVJqaE+ZH16RpQ7zzwSk1jquvaN5cmsuskAg+rZvq/bS0PQrTiZi0ROmcjdJIolMyL1VA7pm/q
 /rICNfnOg2fVkqdvENg5SXigWFfnagUaKu+m4iyQ46BDA1jXiHGmplXOH0zYxOhUT0tNZ6cdAel
 idP9aIhZ28O6h94mSd1xY8LTfXFZUoUb/RNbphZ0QKbTY=
X-Gm-Gg: ASbGncs2RAaDXWdvu//GyeBjX0n6iOtl+KevtTAzC8aCRao8UzeKX9Xv6MFk5bIlOmt
 kdzt/COycdEy9hws5Tt/gbm0ADwonZiWhDjFBjn4oqG07mPQYnDcepdAvn4oajeoEtDgUM9gwXy
 5/X3iJYUqJFG/kzxibX86xJUPxhnwU2w9sqORgEPFlB3d3XieHaFL+/seXo3mTj+/vrdhCjda4O
 v5TAqu4wGDGxECzkIffv0qACU08U0rd+XvMq4wSqjhuRMkZYWCqmueBvTqnZ561R8r0cWVecR81
 XCgJKrFYiYD4JivQ6W9LZ950e2ckxVBjaOpP3hdV7VSGmPQyNPt4zrhh7NzNENYmray9yjMUgQW
 5EPGeuv9IjsZOyRp8ISzUd4cUfHhGHvB2WzWqlFLz+gWBySIp
X-Received: by 2002:a05:6000:4382:b0:424:21d8:de30 with SMTP id
 ffacd0b85a97d-4266e8e90eamr4189856f8f.62.1759996231586; 
 Thu, 09 Oct 2025 00:50:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBZhGy+5RcSO2LUdm0r+NLgSOcg/heS2pbzeCZ8Z8lMwtln/pj/fi2F0jU5nUXwExE6UvtPw==
X-Received: by 2002:a05:6000:4382:b0:424:21d8:de30 with SMTP id
 ffacd0b85a97d-4266e8e90eamr4189832f8f.62.1759996231083; 
 Thu, 09 Oct 2025 00:50:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6b8bsm33338305f8f.4.2025.10.09.00.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:50:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 02/35] subprojects: add glib-sys-rs
Date: Thu,  9 Oct 2025 09:49:52 +0200
Message-ID: <20251009075026.505715-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 rust/meson.build                              |  2 ++
 scripts/archive-source.sh                     |  1 +
 subprojects/.gitignore                        |  1 +
 subprojects/glib-sys-0.21-rs.wrap             |  7 ++++
 .../packagefiles/glib-sys-0.21-rs/meson.build | 33 +++++++++++++++++++
 5 files changed, 44 insertions(+)
 create mode 100644 subprojects/glib-sys-0.21-rs.wrap
 create mode 100644 subprojects/packagefiles/glib-sys-0.21-rs/meson.build

diff --git a/rust/meson.build b/rust/meson.build
index 695d5a62de9..6ba075c8c71 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -2,12 +2,14 @@ subproject('anyhow-1-rs', required: true)
 subproject('bilge-0.2-rs', required: true)
 subproject('bilge-impl-0.2-rs', required: true)
 subproject('foreign-0.3-rs', required: true)
+subproject('glib-sys-0.21-rs', required: true)
 subproject('libc-0.2-rs', required: true)
 
 anyhow_rs = dependency('anyhow-1-rs')
 bilge_rs = dependency('bilge-0.2-rs')
 bilge_impl_rs = dependency('bilge-impl-0.2-rs')
 foreign_rs = dependency('foreign-0.3-rs')
+glib_sys_rs = dependency('glib-sys-0.21-rs')
 libc_rs = dependency('libc-0.2-rs')
 
 subproject('proc-macro2-1-rs', required: true)
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index a725dd923dc..8f97b19a088 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -36,6 +36,7 @@ subprojects=(
   bilge-impl-0.2-rs
   either-1-rs
   foreign-0.3-rs
+  glib-sys-0.21-rs
   itertools-0.11-rs
   keycodemapdb
   libc-0.2-rs
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index 0b5d9634094..c00c8478372 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -13,6 +13,7 @@
 /bilge-impl-*
 /either-*
 /foreign-*
+/glib-sys-*
 /itertools-*
 /libc-*
 /proc-macro-error-*
diff --git a/subprojects/glib-sys-0.21-rs.wrap b/subprojects/glib-sys-0.21-rs.wrap
new file mode 100644
index 00000000000..313ced731ac
--- /dev/null
+++ b/subprojects/glib-sys-0.21-rs.wrap
@@ -0,0 +1,7 @@
+[wrap-file]
+directory = glib-sys-0.21.2
+source_url = https://crates.io/api/v1/crates/glib-sys/0.21.2/download
+source_filename = glib-sys-0.21.2.tar.gz
+source_hash = d09d3d0fddf7239521674e57b0465dfbd844632fec54f059f7f56112e3f927e1
+#method = cargo
+patch_directory = glib-sys-0.21-rs
diff --git a/subprojects/packagefiles/glib-sys-0.21-rs/meson.build b/subprojects/packagefiles/glib-sys-0.21-rs/meson.build
new file mode 100644
index 00000000000..8c5483311ed
--- /dev/null
+++ b/subprojects/packagefiles/glib-sys-0.21-rs/meson.build
@@ -0,0 +1,33 @@
+project('glib-sys-0.21-rs', 'rust',
+  meson_version: '>=1.5.0',
+  version: '0.21.2',
+  license: 'MIT',
+  default_options: [])
+
+subproject('libc-0.2-rs', required: true)
+libc_rs = dependency('libc-0.2-rs')
+
+_glib_sys_rs = static_library(
+  'glib_sys',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  rust_args: [
+    '--cap-lints', 'allow',
+    '--cfg', 'feature="v2_66"',
+    '--cfg', 'feature="v2_64"',
+    '--cfg', 'feature="v2_62"',
+    '--cfg', 'feature="v2_60"',
+    '--cfg', 'feature="v2_58"',
+  ],
+  # should also link with glib; don't bother doing it here since all
+  # QEMU targets have it
+  dependencies: [libc_rs],
+)
+
+glib_sys_dep = declare_dependency(
+  link_with: _glib_sys_rs,
+)
+
+meson.override_dependency('glib-sys-0.21-rs', glib_sys_dep)
-- 
2.51.0



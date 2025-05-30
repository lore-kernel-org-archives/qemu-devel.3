Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0514FC54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKu1u-00039e-Mm; Fri, 30 May 2025 03:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKty6-0004ef-GO
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKty3-0007HE-5h
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+cB7P9QdWDifQJVlY/SOJM17ntxZIz8n12yO/nrNn5c=;
 b=O8FOp4kyTVD21YDkqETvw7B3AXsmh4UMP108si/pRp3MseJDoaxbOpP7I5PPFFW5RLqwLR
 Q/UTUiriUnjwn6QSvvtOMHE9zya0Tqma+w/wDhRN7/2uz2m/1xn1lrOg50hmYFmFnEe1TW
 /kELvLE+YYTXSmks6niJDbNGB1deT5M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-kzq-wcY-P8i0ITl10x3nnQ-1; Fri, 30 May 2025 03:15:49 -0400
X-MC-Unique: kzq-wcY-P8i0ITl10x3nnQ-1
X-Mimecast-MFC-AGG-ID: kzq-wcY-P8i0ITl10x3nnQ_1748589348
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ad556f5f1a9so128316266b.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589347; x=1749194147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+cB7P9QdWDifQJVlY/SOJM17ntxZIz8n12yO/nrNn5c=;
 b=NeCgo4lbb8gRBGKuISbmP/oDTuHlBkmN7JAV2sTI05UJYkXUudZo0quOf2+LKwXz9W
 zol7obo8iIzF9ZAVxN1PBDr300QCArY85cS9n1Z1VFT0Iho/iil3gfUlPaVu1LXnLDyU
 pnOb9NCl0zeVgoGahxrPm3iaBF5/qiXS3fGXwWSJ7ReHjGSS60wbKiu1mpsBvJFEDC/n
 RI5QynwkNsIQAddOL/b4wBInNtwG+wzQFG1gtHhrD1vRpN8yQ2UJJsKTS+mieoPGHHfw
 L3bJMAmDS8Tz4Sggc6tQmfyi1EHI7wDDaWNlOvqIO0OIYNoz1eQXZDKaZ9/FcQ6hRlqy
 ZFGA==
X-Gm-Message-State: AOJu0YzVvLnuWoTGEhBNetAZdPNJAL2zTM9Wxh+9f6QCBxpCstGcAd0f
 OhQaak6lqXp1maluH+XEYrPZv6Cv6o/ufyD0oZcYhFfXV8VNh8QZzPQByEyMVBGF0LqFR5Vdbgj
 8uhqpBQAQiPUAtB1ZQiVsbTEBE8RivVnb03qYpt4wxT1oSro2gWvCeywnWu/GbB+vFlGBEc+c8E
 64aDhOqylSSRwbgJYJfUs8PaFf+tB2TDp5RRa4vCCO
X-Gm-Gg: ASbGncs0SgZciUvOx6v59RPRcPOKAjJ4YJWSqKCW0Dld+tNnXeHlQO6zzNA+sHn9JvX
 81IoeqLgn6aJp/7oTOswwi47v3bTq827n1C34zYH7fpDtfIOYr+vwcBoYteyszWt2VlUjInvlCK
 Wfo9Av0WXh/B+P24+zsNMDJTH2ntX5pttm0a3vdRwQCJjivBZvCiRWTxWzVw7n1XY0Mj5cADmJA
 9BwZRzFVMflfHzwQODrUKxv8aoie58JZ5jSu8KT5f3s5HUF6OSDFmB9mKzyOlO8ruaeCS/2BQcf
 4w68fchhbNA21A==
X-Received: by 2002:a17:907:60ca:b0:ad8:a2a8:23d1 with SMTP id
 a640c23a62f3a-adb3244b75cmr207244866b.49.1748589347279; 
 Fri, 30 May 2025 00:15:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQGB+BwNmBLJ9ZJd5Og1UabAY7GPVKGls5cl2oxkwMjEiD86I5U5crm5gbvHbhf1L9SKC2Sw==
X-Received: by 2002:a17:907:60ca:b0:ad8:a2a8:23d1 with SMTP id
 a640c23a62f3a-adb3244b75cmr207242566b.49.1748589346811; 
 Fri, 30 May 2025 00:15:46 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada6ad3a6d7sm276138566b.155.2025.05.30.00.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 70/77] rust: make declaration of dependent crates more
 consistent
Date: Fri, 30 May 2025 09:12:40 +0200
Message-ID: <20250530071250.2050910-71-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Crates like "bilge" and "libc" can be shared by more than one directory,
so declare them directly in rust/meson.build.  While at it, make their
variable names end with "_rs" and always add a subproject() statement
(as that pinpoints the error better if the subproject is missing and
cannot be downloaded).

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/meson.build   | 12 +++---------
 rust/meson.build                 | 16 ++++++++++++++++
 rust/qemu-api-macros/meson.build | 14 +++-----------
 rust/qemu-api/meson.build        |  4 +---
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 547cca5a96f..494b6c123cc 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -1,17 +1,11 @@
-subproject('bilge-0.2-rs', required: true)
-subproject('bilge-impl-0.2-rs', required: true)
-
-bilge_dep = dependency('bilge-0.2-rs')
-bilge_impl_dep = dependency('bilge-impl-0.2-rs')
-
 _libpl011_rs = static_library(
   'pl011',
   files('src/lib.rs'),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   dependencies: [
-    bilge_dep,
-    bilge_impl_dep,
+    bilge_rs,
+    bilge_impl_rs,
     qemu_api,
     qemu_api_macros,
   ],
@@ -21,6 +15,6 @@ rust_devices_ss.add(when: 'CONFIG_X_PL011_RUST', if_true: [declare_dependency(
   link_whole: [_libpl011_rs],
   # Putting proc macro crates in `dependencies` is necessary for Meson to find
   # them when compiling the root per-target static rust lib.
-  dependencies: [bilge_impl_dep, qemu_api_macros],
+  dependencies: [bilge_impl_rs, qemu_api_macros],
   variables: {'crate': 'pl011'},
 )])
diff --git a/rust/meson.build b/rust/meson.build
index 91e52b8fb8e..1f0dcce7d04 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -1,3 +1,19 @@
+subproject('bilge-0.2-rs', required: true)
+subproject('bilge-impl-0.2-rs', required: true)
+subproject('libc-0.2-rs', required: true)
+
+bilge_rs = dependency('bilge-0.2-rs')
+bilge_impl_rs = dependency('bilge-impl-0.2-rs')
+libc_rs = dependency('libc-0.2-rs')
+
+subproject('proc-macro2-1-rs', required: true)
+subproject('quote-1-rs', required: true)
+subproject('syn-2-rs', required: true)
+
+quote_rs_native = dependency('quote-1-rs', native: true)
+syn_rs_native = dependency('syn-2-rs', native: true)
+proc_macro2_rs_native = dependency('proc-macro2-1-rs', native: true)
+
 subdir('qemu-api-macros')
 subdir('qemu-api')
 
diff --git a/rust/qemu-api-macros/meson.build b/rust/qemu-api-macros/meson.build
index 6f94a4bb3c2..8610ce1c844 100644
--- a/rust/qemu-api-macros/meson.build
+++ b/rust/qemu-api-macros/meson.build
@@ -1,11 +1,3 @@
-subproject('proc-macro2-1-rs', required: true)
-subproject('quote-1-rs', required: true)
-subproject('syn-2-rs', required: true)
-
-quote_dep = dependency('quote-1-rs', native: true)
-syn_dep = dependency('syn-2-rs', native: true)
-proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
-
 _qemu_api_macros_rs = rust.proc_macro(
   'qemu_api_macros',
   files('src/lib.rs'),
@@ -16,9 +8,9 @@ _qemu_api_macros_rs = rust.proc_macro(
     '--cfg', 'feature="proc-macro"',
   ],
   dependencies: [
-    proc_macro2_dep,
-    quote_dep,
-    syn_dep,
+    proc_macro2_rs_native,
+    quote_rs_native,
+    syn_rs_native,
   ],
 )
 
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 1696df705bf..1ea86b8bbf1 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -2,8 +2,6 @@ _qemu_api_cfg = run_command(rustc_args,
   '--config-headers', config_host_h, '--features', files('Cargo.toml'),
   capture: true, check: true).stdout().strip().splitlines()
 
-libc_dep = dependency('libc-0.2-rs')
-
 # _qemu_api_cfg += ['--cfg', 'feature="allocator"']
 if get_option('debug_mutex')
   _qemu_api_cfg += ['--cfg', 'feature="debug_cell"']
@@ -37,7 +35,7 @@ _qemu_api_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
-  dependencies: [libc_dep, qemu_api_macros],
+  dependencies: [libc_rs, qemu_api_macros],
 )
 
 rust.test('rust-qemu-api-tests', _qemu_api_rs,
-- 
2.49.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272DCC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSeo6-0006Zx-43; Fri, 20 Jun 2025 12:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeo2-0006Yt-4y
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSenx-0000Gf-Kq
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750437688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R8LqKOiEsRIuredeKj7XdSZiPDaNUwtzibDGBjeZOjk=;
 b=jADsa4a3RXR62HrF/Nczknh8a72EVp/nOGM6mdcNNiE1lN0hVKkl8af15Ijfzk7YDApBPr
 3xAfyBzt3MBUtbMniHTxS8iGbr1T0RJ17+v5H0vIprf+4XcI1xOAFZzQRl3jxoTVb5X9BJ
 G1LWWpzME5Fc/kDlkYiWN6XcmlaNFrY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-hUnglG2MMuenMqGTSepNLg-1; Fri, 20 Jun 2025 12:41:27 -0400
X-MC-Unique: hUnglG2MMuenMqGTSepNLg-1
X-Mimecast-MFC-AGG-ID: hUnglG2MMuenMqGTSepNLg_1750437686
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-addcea380fcso135777066b.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750437686; x=1751042486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R8LqKOiEsRIuredeKj7XdSZiPDaNUwtzibDGBjeZOjk=;
 b=X/HNCaISg8CY1fAJjg5yvDNLUV1UF73yBWOpq3VY3Ti3IN51UvnltS0payqhGpAoGZ
 br15odiumkmv7fE9q9zBmrKDpZ+8on62iDyov1T+VmAusmjvwh1FfpYxc7lc9f0OEhz8
 SNV4uUj295AD8J94bUFDc3fl5/q6Us/A8+yR/ipzMQhxJudVr7WoFzxbqNTF6SXJM/0/
 AkbALbKw89mtHZ7bT+/lB+v8YQ2XmlnNSA2gDmUAzSSkRbjPBbo3GynECg1o+Yrt2Hhk
 4VT7YdM4IlWoNZqcwvrjV5gOB1Q/lvFwKhmfZL8AmVmOrN6PnlBJQXocgYEkKjnmUb12
 outw==
X-Gm-Message-State: AOJu0Yy8wmSixbyVes4dBQQYpZjxRSb0mDK6ERn1q45Eoxe00EX9rj4a
 QqM3ZfCO8Rw9teFkjxZgBadSiEknO1reh6PjaMiSdwwnYGrMEqbBke5HFwXZTEbozGxbKV4udE6
 L7LX1uaDIrikXyoXuUI6f0sj+RXdcJTPZyYbMtgSjKJhmML9Z77DtypPce4RkayOluSQbwqA+dz
 fQsTiNA3OZNd+IjgfeM+S//2nlbmHddMHgdIXNmYgg
X-Gm-Gg: ASbGncvbYA2F25OK8JIExVaz/ij1BuBkGmfitbifJXLjBjOZBXKR4rmD/pH2KyA0N9c
 eRpapphfuPXW2ycrmj+owAaMlaJWSJAURd1/g0iK47nhp3E3Y3EYvBPRCwckpuQHFKQZTIfcWv4
 9zDkfpPIcSDenD7ZuJidZnNhHbtA8UHPImc+CpBuSCMf/sbizAPnpsdmnaNcdK+SIhgrv6mpQmw
 rglC/qP+ZYAkj8mHhCKkFAwxp39Vb6xR+vx3punw+O+Lk1lTgLiZFSaGVlNBMVLnZEMYqDfmcJZ
 zw1+6zbTzuCyAYfQI4CiMTKScQ==
X-Received: by 2002:a17:907:3c82:b0:ad8:914b:7d0b with SMTP id
 a640c23a62f3a-ae0579cd940mr362858166b.11.1750437685592; 
 Fri, 20 Jun 2025 09:41:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu/17NnkqKbjAXxzlATiQ2kZziRH1iekLIrNK3R4CQv64r90Bgl7KbERmN/niOUR/dgFtbew==
X-Received: by 2002:a17:907:3c82:b0:ad8:914b:7d0b with SMTP id
 a640c23a62f3a-ae0579cd940mr362855566b.11.1750437685074; 
 Fri, 20 Jun 2025 09:41:25 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae053e809d4sm184987966b.26.2025.06.20.09.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:41:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 11/24] rust: move rust.bindgen to qemu-api crate
Date: Fri, 20 Jun 2025 18:40:39 +0200
Message-ID: <20250620164053.579416-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620164053.579416-1-pbonzini@redhat.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Once qemu-api is split in multiple crates, each of them will have
its own invocation of bindgen.  There cannot be only one, because
there are occasional "impl" blocks for the bindgen-generated
structs (e.g. VMStateFlags or QOM classes) that have to
reside in the same crate as the bindgen-generated code.

For now, prepare for this new organization by invoking bindgen
within the qemu-api crate's build definitions; it's also a
much better place to list enums that need specific treatment
from bindgen.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   | 41 -----------------------------------
 rust/{ => qemu-api}/wrapper.h |  0
 rust/meson.build              |  4 +++-
 rust/qemu-api/build.rs        |  2 +-
 rust/qemu-api/meson.build     | 41 +++++++++++++++++++++++++++++++++++
 5 files changed, 45 insertions(+), 43 deletions(-)
 rename rust/{ => qemu-api}/wrapper.h (100%)

diff --git a/meson.build b/meson.build
index 19ffa9cb34c..4676908dbb2 100644
--- a/meson.build
+++ b/meson.build
@@ -4234,47 +4234,6 @@ if have_rust
   else
     bindgen_args_common += ['--merge-extern-blocks']
   endif
-
-  bindgen_args = []
-  c_enums = [
-    'DeviceCategory',
-    'GpioPolarity',
-    'MachineInitPhase',
-    'MemoryDeviceInfoKind',
-    'MigrationPolicy',
-    'MigrationPriority',
-    'QEMUChrEvent',
-    'QEMUClockType',
-    'ResetType',
-    'device_endian',
-    'module_init_type',
-  ]
-  foreach enum : c_enums
-    bindgen_args += ['--rustified-enum', enum]
-  endforeach
-  c_bitfields = [
-    'ClockEvent',
-    'VMStateFlags',
-  ]
-  foreach enum : c_bitfields
-    bindgen_args += ['--bitfield-enum', enum]
-  endforeach
-
-  # TODO: Remove this comment when the clang/libclang mismatch issue is solved.
-  #
-  # Rust bindings generation with `bindgen` might fail in some cases where the
-  # detected `libclang` does not match the expected `clang` version/target. In
-  # this case you must pass the path to `clang` and `libclang` to your build
-  # command invocation using the environment variables CLANG_PATH and
-  # LIBCLANG_PATH
-  _qemu_api_bindings_inc_rs = rust.bindgen(
-    input: 'rust/wrapper.h',
-    dependencies: common_ss.all_dependencies(),
-    output: 'bindings.inc.rs',
-    include_directories: bindings_incdir,
-    bindgen_version: ['>=0.60.0'],
-    args: bindgen_args_common + bindgen_args,
-    )
   subdir('rust')
 endif
 
diff --git a/rust/wrapper.h b/rust/qemu-api/wrapper.h
similarity index 100%
rename from rust/wrapper.h
rename to rust/qemu-api/wrapper.h
diff --git a/rust/meson.build b/rust/meson.build
index e9f0879e296..331f11b7e72 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -20,6 +20,8 @@ proc_macro2_rs_native = dependency('proc-macro2-1-rs', native: true)
 
 qemuutil_rs = qemuutil.partial_dependency(link_args: true, links: true)
 
+genrs = []
+
 subdir('qemu-api-macros')
 subdir('bits')
 subdir('qemu-api')
@@ -33,5 +35,5 @@ if cargo.found()
     command: [config_host['MESON'], 'devenv',
               '--workdir', '@CURRENT_SOURCE_DIR@',
               cargo, 'fmt'],
-    depends: _qemu_api_bindings_inc_rs)
+    depends: genrs)
 endif
diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
index 1e720641d2b..7849486c1ba 100644
--- a/rust/qemu-api/build.rs
+++ b/rust/qemu-api/build.rs
@@ -14,7 +14,7 @@ fn main() -> Result<()> {
     let path = env::var("MESON_BUILD_ROOT")
         .unwrap_or_else(|_| format!("{}/src", env!("CARGO_MANIFEST_DIR")));
 
-    let file = format!("{path}/bindings.inc.rs");
+    let file = format!("{path}/rust/qemu-api/bindings.inc.rs");
     let file = Path::new(&file);
     if !Path::new(&file).exists() {
         panic!(concat!(
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 64c04dfd74b..5b8c7e5e8d5 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -7,6 +7,47 @@ if get_option('debug_mutex')
   _qemu_api_cfg += ['--cfg', 'feature="debug_cell"']
 endif
 
+c_enums = [
+  'DeviceCategory',
+  'GpioPolarity',
+  'MachineInitPhase',
+  'MemoryDeviceInfoKind',
+  'MigrationPolicy',
+  'MigrationPriority',
+  'QEMUChrEvent',
+  'QEMUClockType',
+  'ResetType',
+  'device_endian',
+  'module_init_type',
+]
+_qemu_api_bindgen_args = []
+foreach enum : c_enums
+  _qemu_api_bindgen_args += ['--rustified-enum', enum]
+endforeach
+c_bitfields = [
+  'ClockEvent',
+  'VMStateFlags',
+]
+foreach enum : c_bitfields
+  _qemu_api_bindgen_args += ['--bitfield-enum', enum]
+endforeach
+
+# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
+#
+# Rust bindings generation with `bindgen` might fail in some cases where the
+# detected `libclang` does not match the expected `clang` version/target. In
+# this case you must pass the path to `clang` and `libclang` to your build
+# command invocation using the environment variables CLANG_PATH and
+# LIBCLANG_PATH
+_qemu_api_bindings_inc_rs = rust.bindgen(
+  input: 'wrapper.h',
+  dependencies: common_ss.all_dependencies(),
+  output: 'bindings.inc.rs',
+  include_directories: bindings_incdir,
+  bindgen_version: ['>=0.60.0'],
+  args: bindgen_args_common + _qemu_api_bindgen_args,
+  )
+
 _qemu_api_rs = static_library(
   'qemu_api',
   structured_sources(
-- 
2.49.0



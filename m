Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1CFC021AD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 18:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkSDI-0005xh-3r; Tue, 18 Feb 2025 13:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkSD4-0005un-Uw
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:20:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkSD1-0007Xb-Mr
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739902839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+2s55xY4xuFkJaQb7IgaHFsyT2GfktWanOz++TYX8qQ=;
 b=KKjD/tVcqzEaTnlZ7knr83RNtYYyKfy1cDHpznA+uGj2Qo5h5qstIVLc8V/F0Ux6+vr5Ao
 jbQC+v2/pxNk7SS6gMlmAxP+YTtcTqxy+LeJVeSAnwPF/rSULGCClvKbV6vuU0tYMlVbrA
 9wVI69Yx2uzoUCSBN3vwL+vMsHmjYQQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-9hzx_4JWNKG0utQAxabvoA-1; Tue,
 18 Feb 2025 13:20:36 -0500
X-MC-Unique: 9hzx_4JWNKG0utQAxabvoA-1
X-Mimecast-MFC-AGG-ID: 9hzx_4JWNKG0utQAxabvoA_1739902835
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4F4719039C2; Tue, 18 Feb 2025 18:20:34 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.226.66])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47FA11800358; Tue, 18 Feb 2025 18:20:32 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: [PATCH v2 02/11] meson: Add rust_block_ss and link tools with it
Date: Tue, 18 Feb 2025 19:20:10 +0100
Message-ID: <20250218182019.111467-3-kwolf@redhat.com>
In-Reply-To: <20250218182019.111467-1-kwolf@redhat.com>
References: <20250218182019.111467-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 meson.build                | 36 ++++++++++++++++++++++++++++++++----
 storage-daemon/meson.build |  2 +-
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 6ee1757828..a08d029032 100644
--- a/meson.build
+++ b/meson.build
@@ -3640,6 +3640,7 @@ qom_ss = ss.source_set()
 system_ss = ss.source_set()
 specific_fuzz_ss = ss.source_set()
 specific_ss = ss.source_set()
+rust_block_ss = ss.source_set()
 rust_devices_ss = ss.source_set()
 stub_ss = ss.source_set()
 trace_ss = ss.source_set()
@@ -4217,7 +4218,11 @@ foreach target : target_dirs
   arch_deps += target_specific.dependencies()
 
   if have_rust and target_type == 'system'
-    target_rust = rust_devices_ss.apply(config_target, strict: false)
+    target_rust_ss = ss.source_set()
+    target_rust_ss.add_all(rust_block_ss)
+    target_rust_ss.add_all(rust_devices_ss)
+
+    target_rust = target_rust_ss.apply(config_target, strict: false)
     crates = []
     foreach dep : target_rust.dependencies()
       crates += dep.get_variable('crate')
@@ -4357,15 +4362,38 @@ if xkbcommon.found()
 endif
 
 if have_tools
+  tools_deps = []
+  if have_rust
+    tools_rust = rust_block_ss.apply({})
+    crates = []
+    foreach dep : tools_rust.dependencies()
+      crates += dep.get_variable('crate')
+    endforeach
+    if crates.length() > 0
+      rlib_rs = custom_target('rust_tools.rs',
+                              output: 'rust_tools.rs',
+                              command: [rust_root_crate, crates],
+                              capture: true,
+                              build_by_default: true,
+                              build_always_stale: true)
+      rlib = static_library('rust_tools',
+                            rlib_rs,
+                            dependencies: tools_rust.dependencies(),
+                            override_options: ['rust_std=2021', 'build.rust_std=2021'],
+                            rust_abi: 'c')
+      tools_deps += declare_dependency(link_whole: [rlib])
+    endif
+  endif
+
   qemu_img = executable('qemu-img', [files('qemu-img.c'), hxdep],
              link_args: '@block.syms', link_depends: block_syms,
-             dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
+             dependencies: tools_deps + [authz, block, crypto, io, qom, qemuutil], install: true)
   qemu_io = executable('qemu-io', files('qemu-io.c'),
              link_args: '@block.syms', link_depends: block_syms,
-             dependencies: [block, qemuutil], install: true)
+             dependencies: tools_deps + [block, qemuutil], install: true)
   qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
                link_args: '@block.syms', link_depends: block_syms,
-               dependencies: [blockdev, qemuutil, selinux],
+               dependencies: tools_deps + [blockdev, qemuutil, selinux],
                install: true)
 
   subdir('storage-daemon')
diff --git a/storage-daemon/meson.build b/storage-daemon/meson.build
index 5e61a9d1bd..92bc2e0cba 100644
--- a/storage-daemon/meson.build
+++ b/storage-daemon/meson.build
@@ -9,6 +9,6 @@ if have_tools
   qsd = executable('qemu-storage-daemon',
                    qsd_ss.sources(),
                    link_args: '@block.syms', link_depends: block_syms,
-                   dependencies: qsd_ss.dependencies(),
+                   dependencies: tools_deps + qsd_ss.dependencies(),
                    install: true)
 endif
-- 
2.48.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C4CC531DD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 00:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se1w6-0004H3-8w; Tue, 13 Aug 2024 20:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1se1w4-0004AX-Ij
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 20:32:20 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1se1w2-0000Vg-OX
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 20:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723595539; x=1755131539;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tnoGK4zKgNlqRyvEJd6ur7OOGmPN9kW2wVQiLIDtklo=;
 b=KJ5E89EGpWQPGmf6Nr4JosmOpWkgYnclwggtNtcLOfJ+fpUzHQ9Jsm1E
 0O2zNDsKO9F6+1zNPYRLnJq14YCTNdw33qaipS4+lcjkSpXmlreTzCQ/U
 B4roWEGpKfg5KV8YjRfpQ8PRyWc4FbqDRRy/Xey6OYcpgVWeUaXAUn2XZ
 yCsflRyzwHqPvGWtMJXygsbVbYOshxhXBSbzx4r++o0zLII3f284zG0DP
 PC1ml8RX1kgVmDDa9oYcY/y1CgPRS7W3dhdYV4Ldu8ivICSSXQN0i94VT
 IafXqAgqQ8neu9LvFofta3+ecMWatysatgNzPeMV0uJJ3X6v4m+1d+bYe Q==;
X-CSE-ConnectionGUID: 8Dq7ztlWQfKXHhlTho3MjQ==
X-CSE-MsgGUID: TqrDEs0FSAWvUirbrFRPqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21346405"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; d="scan'208";a="21346405"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 17:32:18 -0700
X-CSE-ConnectionGUID: pYY0dv08Q/qxsxTl3MnYFA==
X-CSE-MsgGUID: t0459Ns3Q0GaSDHPi6vKiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; d="scan'208";a="58472763"
Received: from junjie-optiplex-7080.sh.intel.com (HELO localhost.localdomain)
 ([10.239.48.46])
 by fmviesa006.fm.intel.com with ESMTP; 13 Aug 2024 17:32:15 -0700
From: Junjie Mao <junjie.mao@intel.com>
To: manos.pitsidianakis@linaro.org,
	pbonzini@redhat.com
Cc: alex.bennee@linaro.org, armbru@redhat.com, berrange@redhat.com,
 gustavo.romero@linaro.org, mads@ynddal.dk, marcandre.lureau@redhat.com,
 peter.maydell@linaro.org, philmd@linaro.org, pierrick.bouvier@linaro.org,
 qemu-devel@nongnu.org, richard.henderson@linaro.org, rowan.hart@intel.com,
 stefanha@redhat.com, thuth@redhat.com, zhao1.liu@intel.com
Subject: [RFC PATCH 2/2] rust: Specify Rust edition by rust_std=20XX
Date: Wed, 14 Aug 2024 17:08:20 +0800
Message-Id: <20240814090820.1251026-3-junjie.mao@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240814090820.1251026-1-junjie.mao@intel.com>
References: <20240814090820.1251026-1-junjie.mao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=junjie.mao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.125, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Junjie Mao <junjie.mao@intel.com>
---
 rust/hw/char/pl011/meson.build | 4 +---
 rust/meson.build               | 4 +---
 rust/qemu-api/meson.build      | 2 +-
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 1c139d3af9..518d4924a9 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -7,10 +7,8 @@ bilge_impl_dep = dependency('bilge-impl-0.2-rs')
 _libpl011_rs = static_library(
   'pl011',
   files('src/lib.rs'),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'c',
-  rust_args: rust_args + [
-    '--edition', '2021',
-  ],
   dependencies: [
     bilge_dep,
     bilge_impl_dep,
diff --git a/rust/meson.build b/rust/meson.build
index c321fa455e..590e9397c3 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -2,10 +2,8 @@ _lib_bindings_rs = static_library(
   '_bindings_rs',
   bindings_rs,
   gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
-  rust_args: rust_args + [
-    '--edition', '2021',
-  ],
 )

 subdir('qemu-api')
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index a169872026..997d478309 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -2,9 +2,9 @@ _qemu_api_rs = static_library(
   'qemu_api',
   [files('src/lib.rs')],
   gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: rust_args + [
-    '--edition', '2021',
     '--cfg', 'MESON_BINDINGS_RS',
   ],
   link_with: [
--
2.30.2


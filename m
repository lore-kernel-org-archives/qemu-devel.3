Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEF8C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMwE-0004Yz-Hm; Wed, 08 Jul 2026 03:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMvl-0003xJ-Ix; Wed, 08 Jul 2026 03:42:55 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMvj-0004mJ-5x; Wed, 08 Jul 2026 03:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496571; x=1815032571;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WJUO2y5KHHM7rOZrzGbV4thxJgi+eLmzgdWufafbEKM=;
 b=Ou3zzDDs4bD2DbZ3pCBYZa6krSczU77qudas5y/0PGOSdMzFW4QnE8lS
 D7mRPYi37gglGQZxzdBfYaV5kpcVTP9sR04TDaHf+DaJJuTX7WcBzjUmR
 cgpYRIbSaZZHa0K9giVKjrAlyrbV3dFKI/391y5IRESc/4BO60WtDpA65
 1SfnIxDvLz4gRav5DBEOG6C1SfL3VEegy4SKI3CoBawHQsNPppRTStMSl
 7QFq2qkHu20ZRyT4DzbJPmiaTbUjBja+wIwmpchLVbHAMdwocWdkPAlSJ
 O4eUS7odGs7ABYf6FT8WRtd1A98bL0r0Ztamy4Gui8sdUK4dPP7kKtrin w==;
X-CSE-ConnectionGUID: KcDQN6IRROC6W9wapy0NfQ==
X-CSE-MsgGUID: nB2vmGqxTeyz8K+xBUhPUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343245"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343245"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:42:49 -0700
X-CSE-ConnectionGUID: BHeSrczFRYSbzBDPXEI69w==
X-CSE-MsgGUID: +GhAnFniRBG8yzRU17aLcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251555935"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:42:45 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 06/26] rust: Add vm-memory in meson
Date: Wed,  8 Jul 2026 16:10:32 +0800
Message-Id: <20260708081052.2276617-7-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708081052.2276617-1-zhao1.liu@intel.com>
References: <20260708081052.2276617-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Integrate vm-memory into meson.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * Upgrade vm-memory to v0.18.0.
---
 rust/meson.build        | 2 ++
 rust/system/meson.build | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/rust/meson.build b/rust/meson.build
index b6711fe77dd3..12a61c93c6c4 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -11,6 +11,7 @@ subproject('foreign-0.3-rs', required: true)
 subproject('glib-sys-0.21-rs', required: true)
 subproject('libc-0.2-rs', required: true)
 subproject('probe-0.5-rs', required: true)
+subproject('vm-memory-0.18-rs', required: true)
 
 anyhow_rs = dependency('anyhow-1-rs')
 bilge_rs = dependency('bilge-0.2-rs')
@@ -19,6 +20,7 @@ foreign_rs = dependency('foreign-0.3-rs')
 glib_sys_rs = dependency('glib-sys-0.21-rs')
 libc_rs = dependency('libc-0.2-rs')
 probe_rs = dependency('probe-0.5-rs')
+vm_memory_rs = dependency('vm-memory-0.18-rs')
 
 subproject('proc-macro2-1-rs', required: true)
 subproject('quote-1-rs', required: true)
diff --git a/rust/system/meson.build b/rust/system/meson.build
index 89c1f2b84d17..d8e9f36ec1fd 100644
--- a/rust/system/meson.build
+++ b/rust/system/meson.build
@@ -2,7 +2,7 @@ _system_rs = static_library(
   'system',
   'src/lib.rs',
   link_with: [_bql_rs, _hwcore_rs, _migration_rs, _qom_rs, _util_rs],
-  dependencies: [glib_sys_rs, common_rs, qemu_macros, system_sys_rs],
+  dependencies: [glib_sys_rs, common_rs, qemu_macros, system_sys_rs, vm_memory_rs],
 )
 
 system_rs = declare_dependency(link_with: [_system_rs],
-- 
2.34.1



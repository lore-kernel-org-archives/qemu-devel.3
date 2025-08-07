Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B9DC87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzRx-00026G-F4; Thu, 07 Aug 2025 08:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzRD-0007xL-1A; Thu, 07 Aug 2025 08:09:41 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzR7-00058G-1A; Thu, 07 Aug 2025 08:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568573; x=1786104573;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KAVkpOsUfhfxB9jH1McPSIECphxKPwK1MhbX0BF1360=;
 b=kj9izV4nwjfDGiQvfN31w+sr5r/HsEKjgM+EJbaf47btJdravT9KDQzw
 sh//UJh1fZfHBy2YfXMJFhrVzCnE6PoB+9wLFOuAlCAjIfzxUFmosdYkL
 TVUaPtTxdn22OsvPFlTB1nY9lFoEtLOXFXUPJ+ySiDkXu837uGTr5HK3I
 kG+uvS7vN79InWa1Lat2bGl6scNamzk9N8Ubq2Ang7vLRNmtQ/nSEpaw+
 Y/UbjK4i2sqQ6TGskWDkdCQxz9BVQKQFthWQF0IK/Bz6huvk3wEtUqgda
 Zqz1a0JoPHMdPX69FLNazXBjuETUIz2x7jFkWosWg5aoJJx10EcJZ1PQ5 g==;
X-CSE-ConnectionGUID: kPqQZDh7SlGerl9pw2AVLA==
X-CSE-MsgGUID: 4uTB3dGWSsGX7Rt8xLYVTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036775"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036775"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:09:31 -0700
X-CSE-ConnectionGUID: dZ4OSF5MRWa+yUK8vLk8qQ==
X-CSE-MsgGUID: UJA19qDJQDGeh6BxxKqNEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701104"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:09:28 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 09/26] rust: Add vm-memory in meson
Date: Thu,  7 Aug 2025 20:30:10 +0800
Message-Id: <20250807123027.2910950-10-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807123027.2910950-1-zhao1.liu@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3,
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

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/meson.build          | 2 ++
 rust/qemu-api/meson.build | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/rust/meson.build b/rust/meson.build
index 331f11b7e72a..b7d151fb0349 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -3,12 +3,14 @@ subproject('bilge-0.2-rs', required: true)
 subproject('bilge-impl-0.2-rs', required: true)
 subproject('foreign-0.3-rs', required: true)
 subproject('libc-0.2-rs', required: true)
+subproject('vm-memory-0.16-rs', required: true)
 
 anyhow_rs = dependency('anyhow-1-rs')
 bilge_rs = dependency('bilge-0.2-rs')
 bilge_impl_rs = dependency('bilge-impl-0.2-rs')
 foreign_rs = dependency('foreign-0.3-rs')
 libc_rs = dependency('libc-0.2-rs')
+vm_memory_rs = dependency('vm-memory-0.16-rs')
 
 subproject('proc-macro2-1-rs', required: true)
 subproject('quote-1-rs', required: true)
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index a090297c458b..a362d44ed396 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -79,8 +79,8 @@ _qemu_api_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
-  dependencies: [anyhow_rs, foreign_rs, libc_rs, qemu_api_macros, qemuutil_rs,
-                 qom, hwcore, chardev, migration],
+  dependencies: [anyhow_rs, foreign_rs, libc_rs, vm_memory_rs, qemu_api_macros,
+                 qemuutil_rs, qom, hwcore, chardev, migration],
 )
 
 rust.test('rust-qemu-api-tests', _qemu_api_rs,
-- 
2.34.1



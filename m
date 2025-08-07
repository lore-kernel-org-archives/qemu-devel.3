Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8F4C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzS9-0003B7-Vc; Thu, 07 Aug 2025 08:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzRH-000860-2B; Thu, 07 Aug 2025 08:09:44 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzRD-00059l-HN; Thu, 07 Aug 2025 08:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568579; x=1786104579;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+2PPqAmGP2afLZuYwnnBLPtIfko7sfve40L5NTEpw5c=;
 b=UbG1DQR+04lNsiVHiiD4OqmtRO3BXYCD+iCW4d9HZujDj3AnmdAl6yYn
 U18Axp+1OJ9TbScb9OrPTtksuqN+sIMsdtYvhP6S8I0QllyxLq95aav11
 BRGE1gFsdCzli0dEMPVnYFRWPpH7f2NVx2MaFh3qojkWtF/yVhiESwVKy
 bU8VsHzxs+VN7e3A0N15QwF6z/eG51UMP7edU7cpYdoCuAOSRokM3va+x
 n3/aDTV4zNSRXg1C5SFaRl6vWUdt5mer3UHjbPakaoce6Dlou9cPA9n0X
 779UZ0QZPtuTOnJIph3dJzZ7d2/S6ekd9udT3cKwHyo0LsVLfG4GL6P4+ g==;
X-CSE-ConnectionGUID: gvJvcOGmQ1e0tv9Leoeblg==
X-CSE-MsgGUID: yZHVuPUgR+y642yn3bVE1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036790"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036790"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:09:37 -0700
X-CSE-ConnectionGUID: PIMXtGVjQdGLyEtidg3p6Q==
X-CSE-MsgGUID: sYn8Zyr0S9mIya0bZk6/yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701125"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:09:35 -0700
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
Subject: [RFC 11/26] rust/cargo: Specify the patched vm-memory crate
Date: Thu,  7 Aug 2025 20:30:12 +0800
Message-Id: <20250807123027.2910950-12-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807123027.2910950-1-zhao1.liu@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 rust/Cargo.lock | 1 -
 rust/Cargo.toml | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 7aedae239f66..f1bb2457e133 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -200,7 +200,6 @@ checksum = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
 [[package]]
 name = "vm-memory"
 version = "0.16.1"
-source = "git+https://github.com/rust-vmm/vm-memory.git?rev=5eb996a060d7ca3844cbd2f10b1d048c0c91942f#5eb996a060d7ca3844cbd2f10b1d048c0c91942f"
 dependencies = [
  "thiserror",
  "winapi",
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 0868e1b42680..ecb31647f93b 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -15,6 +15,9 @@ license = "GPL-2.0-or-later"
 repository = "https://gitlab.com/qemu-project/qemu/"
 rust-version = "1.77.0"
 
+[patch."https://github.com/rust-vmm/vm-memory.git"]
+vm-memory = { path = "./../subprojects/vm-memory-0.16" }
+
 [workspace.lints.rust]
 unexpected_cfgs = { level = "deny", check-cfg = [
     'cfg(MESON)', 'cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)',
-- 
2.34.1



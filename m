Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A692EC25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 08:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBVJC-0007cf-VC; Mon, 27 May 2024 04:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBVGb-0004jf-Cb
 for qemu-devel@nongnu.org; Mon, 27 May 2024 03:59:37 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBVGL-0004Xs-Uc
 for qemu-devel@nongnu.org; Mon, 27 May 2024 03:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716796762; x=1748332762;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WeM/edYd9mSl+ORqUJfueVLUMLCrkQ8sggeY8fdRPiE=;
 b=MjlBMPo+izQKCzR4fg1P2PX1DNvyIHdRJlw++JX38Fw2vGQMGF7oL1Fj
 KrHZL4pJ+8JuPivlb951vi6e5tx7n/69oqPmAOHvSHHEsvQKhxCddj/BO
 6S1cPTer0n8JkDKGn+y2i8PCvKjbTEAB2XTNOlI5Blk3wGHdg8pbGx9Xh
 pkPRSWYDE11PM8MT5uDyDejB9C+NwXV1N5/kghntCM/6d5okurEz5V0IR
 OgLcUQGg14AKqD2J6dG9eZz1wZuBN9P+t4DtrUQivqWBGrxmS6lWe29nR
 LijIo1ISJwUZadyTTaPrY2jjFtCKyEc0D55yakPnrYaCXJvAcGosoFyh0 g==;
X-CSE-ConnectionGUID: d4KGOxdjQwyWH+t0i+Hpcw==
X-CSE-MsgGUID: gg8WceUUR3+VOjTD+B7/6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="12967754"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; d="scan'208";a="12967754"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 00:59:21 -0700
X-CSE-ConnectionGUID: atWCFp4JQ9uMGfR422ZL9g==
X-CSE-MsgGUID: Bqrf2WGoQxm3+u/O1eB1fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; d="scan'208";a="39085018"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 27 May 2024 00:59:18 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 6/6] docs/tracing: Add simpletrace-rust section
Date: Mon, 27 May 2024 16:14:21 +0800
Message-Id: <20240527081421.2258624-7-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527081421.2258624-1-zhao1.liu@intel.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Describe how to compile and use this Rust version program.

And also define the Rust code contribution requirements.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 docs/devel/tracing.rst | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/docs/devel/tracing.rst b/docs/devel/tracing.rst
index 043bed7fd0fc..9f31fa38f9bc 100644
--- a/docs/devel/tracing.rst
+++ b/docs/devel/tracing.rst
@@ -273,6 +273,41 @@ You must ensure that the same "trace-events-all" file was used to build QEMU,
 otherwise trace event declarations may have changed and output will not be
 consistent.
 
+Simpletrace-rust
+----------------
+
+Simpletrace-rust (scripts/Simpletrace-rust) is a Rust implementation of
+simpletrace.py, with the same command line arguments as the Python script.
+
+Simpletrace-rust has faster trace parsing compared to the Python version.
+
+The script is compiled by::
+
+    cargo build --manifest-path ./scripts/simpletrace-rust/Cargo.toml --release
+
+Or under scripts/simpletrace-rust, just use::
+
+    cargo build --release
+
+The script also takes the "trace-events-all" file and the binary trace::
+
+    ./scripts/simpletrace-rust/target/release/simpletrace-rust trace-events-all \
+                                                               trace-12345
+
+Any contribution to Simpletrace-rust needs to do the following checks:
+
+Compilation check::
+
+    cargo build
+
+Clippy check::
+
+    cargo clippy
+
+Code style check::
+
+    cargo +nightly fmt --check
+
 Ftrace
 ------
 
-- 
2.34.1



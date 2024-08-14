Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2B8C531DC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 00:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se1w4-000476-QW; Tue, 13 Aug 2024 20:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1se1w1-00042z-To
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 20:32:18 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1se1vz-0000Vg-Na
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 20:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723595536; x=1755131536;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fgPq3h73yNiD8ho0c/JGZLhZi3ISiF7r56nmaDy7kOQ=;
 b=hMalRzeBpiW00ibcSzVUJkTN8gSq/AUYSRGy4nup0JLgMi+pQtrXEqlS
 CBb0ES+OMEjp1WWuJIrshEXCaZsMhUxRme4HQkiaDRBM/j37GgFs0jfno
 mJs1Vd52pRU2RWKRJdPUZqErpJ5X3mmgzcnFeDnrNkViyxY8yzNTxiRh9
 Fi3rI8lCrMbQV/t7QhsFlmQN6Zcv7oxYFVDmo7Er/+voL62whUdXvat0d
 0+xzzW+MJxafU5RH9zoBDOFwxZWEgCqdZCqgNJwlmnI5epbdURA4lRU8b
 usBRyZjxClKIouCCPsxZkhrGGG7aku7aM0uDMsc/D6xY6iZbDaXccvBDA A==;
X-CSE-ConnectionGUID: awrwGoZORNWczbfWFrFh3w==
X-CSE-MsgGUID: 7CLKFmPXTg2SEcMgPU4rpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21346387"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; d="scan'208";a="21346387"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 17:32:10 -0700
X-CSE-ConnectionGUID: WPVf1yB6Qry1b8taGrLdkQ==
X-CSE-MsgGUID: QoevMzA7TlCicX50SSR6sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; d="scan'208";a="58472723"
Received: from junjie-optiplex-7080.sh.intel.com (HELO localhost.localdomain)
 ([10.239.48.46])
 by fmviesa006.fm.intel.com with ESMTP; 13 Aug 2024 17:32:06 -0700
From: Junjie Mao <junjie.mao@intel.com>
To: manos.pitsidianakis@linaro.org,
	pbonzini@redhat.com
Cc: alex.bennee@linaro.org, armbru@redhat.com, berrange@redhat.com,
 gustavo.romero@linaro.org, mads@ynddal.dk, marcandre.lureau@redhat.com,
 peter.maydell@linaro.org, philmd@linaro.org, pierrick.bouvier@linaro.org,
 qemu-devel@nongnu.org, richard.henderson@linaro.org, rowan.hart@intel.com,
 stefanha@redhat.com, thuth@redhat.com, zhao1.liu@intel.com
Subject: [RFC PATCH 0/2] meson: Specify Rust edition by rust_std=20XX
Date: Wed, 14 Aug 2024 17:08:18 +0800
Message-Id: <20240814090820.1251026-1-junjie.mao@intel.com>
X-Mailer: git-send-email 2.30.2
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

The official way to specify Rust edition in meson is the rust_std build option
[1]. It is used for generating --edition rustc options and filling
rust-project.json which provides project layout information to
rust-analyzer. Specifying Rust edition by rust_args instead causes meson to
generate "edition": "--edition" in rust-project.json, which is invalid.

Replace "--edition" rust_args with overriding of rust_std and build.rust_std to
fix the generated rust-project.json.

The rust_std option is part of the build environment and has two forms: rust_std
for the host machine and build.rust_std for the build machine. Specify both in
meson.build for completeness.

The default_options argument of project() is not used because it does not work
for rust_std in subprojects in meson 1.5.1.

This series is based on Paolo's refinement [2] to Manos's rust-pl011-rfc-v6
[3]. Feel free to squash these changes into that series.

[1] https://github.com/mesonbuild/meson/pull/7934
[2] https://gitlab.com/bonzini/qemu/-/tree/rust-for-manos
[3] https://lore.kernel.org/qemu-devel/rust-pl011-rfc-v6.git.manos.pitsidianakis@linaro.org

Junjie Mao (2):
  meson: subprojects: Specify Rust edition by rust_std=20XX
  rust: Specify Rust edition by rust_std=20XX

 rust/hw/char/pl011/meson.build                                | 4 +---
 rust/meson.build                                              | 4 +---
 rust/qemu-api/meson.build                                     | 2 +-
 subprojects/packagefiles/arbitrary-int-1-rs/meson.build       | 4 +---
 subprojects/packagefiles/bilge-impl-0.2-rs/meson.build        | 2 +-
 subprojects/packagefiles/either-1-rs/meson.build              | 2 +-
 subprojects/packagefiles/itertools-0.11-rs/meson.build        | 2 +-
 subprojects/packagefiles/proc-macro-error-1-rs/meson.build    | 2 +-
 .../packagefiles/proc-macro-error-attr-1-rs/meson.build       | 2 +-
 subprojects/packagefiles/proc-macro2-1-rs/meson.build         | 2 +-
 subprojects/packagefiles/quote-1-rs/meson.build               | 2 +-
 subprojects/packagefiles/syn-2-rs/meson.build                 | 2 +-
 subprojects/packagefiles/unicode-ident-1-rs/meson.build       | 4 +---
 13 files changed, 13 insertions(+), 21 deletions(-)

--
2.30.2


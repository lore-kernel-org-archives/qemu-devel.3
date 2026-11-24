Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63DB606A334
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RdW8ogKE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnId-0003SH-6L; Tue, 24 Nov 2026 04:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xVnIa-0003RL-S0; Tue, 24 Nov 2026 04:58:53 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xVnIX-0003Jp-Un; Tue, 24 Nov 2026 04:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795514330; x=1827050330;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RVkiBoVvSOoXwqJfQ+Lt7OYY8hilo7s21vw5yY3QFuA=;
 b=RdW8ogKEg6jvCbfPjAo8TaCzu1lrolRMF2LBwgWFNEUG+3uVqiib9PUy
 u7F6iingGHi3jtCdlh6+06IlsmZ+wByO3li15q8qTSvGyi59eDZ9INArl
 TwU4ApF6APglUlvaL38LZENDGk/hOl1C7LIs3o8f7RPvqZrBLx/n4UVtj
 4mzSXJwsLBB+DQYXRC/aylSJmkKIgqBN7VobIWi9i7CQ3uiHBa/JB7Jpr
 69At5ekR2ipUcSfUPjT4pi23bdJXDptzc/4FFmDRA7pgtRxrgNEE1SmDG
 qEnIqSOaCYsBXnUQLKcvbQPwlJFHt37ZhigOpAArrCHnWo85f1zJM4oX8 Q==;
X-CSE-ConnectionGUID: Q1gzxq/BShe7erp/ysSCsA==
X-CSE-MsgGUID: TD9QQsn8TlukTvD+kM6/fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4397992"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4397992"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 01:58:31 -0800
X-CSE-ConnectionGUID: M6An0f1jTVO0/O/EQ5bm5g==
X-CSE-MsgGUID: 2qMXlEw1TxqnnUBrS+F1YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="13206386"
Received: from zhaoliu1-desk.sh.intel.com ([10.112.226.173])
 by fmviesa012.fm.intel.com with ESMTP; 24 Nov 2026 01:58:29 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/3] rust/migration: Remove vmstate_validate!() and
 VMS_MUST_EXIST
Date: Tue, 24 Nov 2026 17:58:11 +0800
Message-Id: <20261124095814.437738-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This simple series is based on Peter Xu's series [*] and mainly refines
patch 5 — removing `vmstate_validate!()` from Rust HPET (while
maintaining consistency logic with C HPET as much as possible).

I originally planned to use a single patch, but breaking it up this way
makes it easier to review. I suppose these three small patches could
also replace Peter's patch 5 :-).

There is also some cleanup work left (e.g., support post_load_errp() in
Rust); I will address this in some separate patch later (without
blocking the current effort to remove `vmstate_validate!()`).

[*]: https://lore.kernel.org/qemu-devel/20261120124923.1656220-6-peterx@redhat.com/

Thanks and Best Regards,
Zhao
---
Zhao Liu (3):
  rust/migration: Allow usize as the length of a varray
  rust/hpet: Move vmstate_validate!() check into post_load
  rust/migration: Remove vmstate_validate!() macro and test

 rust/hw/timer/hpet/src/device.rs  | 45 +++++++++----------
 rust/migration/src/prelude.rs     |  1 -
 rust/migration/src/vmstate.rs     | 33 ++++++--------
 rust/tests/tests/vmstate_tests.rs | 72 ++++++++++---------------------
 4 files changed, 59 insertions(+), 92 deletions(-)

-- 
2.34.1



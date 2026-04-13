Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAE4F34C4E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 13:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCHcB-0004zD-90; Mon, 13 Apr 2026 09:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wCHc8-0004z3-Sy
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:46:09 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wCHc5-0002B8-SN
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776087966; x=1807623966;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mpOpWUR/JKUYvWYU/9UWkn+4s8966MonAVVkxOp9oYY=;
 b=b4F/+Tdz0l1D3mth3RcM0YohuuNYO89C6ku0O8IZTSh7hMGr5KIF0jtH
 cvXuAG+mWCLesA05PrQmNqjIo1MAh2QjmiTBmP3o6EkC7sGVl9s2nACbX
 /sGNGUEGH2zyiRM7vZIq5SVq5O5vxOm30s4swW6nU7xHaBMWMWqclbkDF
 8SrtgPfmF7ZbVsXHJWKy4Set/0j2XIfn+Pvn9cWSaL8qOgrmRq+8EHJ7q
 AU6rY4x993TeQ8fRT28SXzJNF3U66edoMMmZjgvZsrFSlXq9iid2mtX3b
 BNNOVrfU+BHAHAfCi4q0g+xvr9goTwbt2YRYZlYeDmQsGG3Tke/XwTmAO A==;
X-CSE-ConnectionGUID: YRBEiu0uS92BBGnv6yDvgQ==
X-CSE-MsgGUID: oqN0KBkxRiG5I/+FMnAByg==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="80885616"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; d="scan'208";a="80885616"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2026 06:46:02 -0700
X-CSE-ConnectionGUID: 8HtHr6SPSzC1oMXkFltT3Q==
X-CSE-MsgGUID: +mD5IXYsT1CddvlEahYlHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; d="scan'208";a="234770323"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by orviesa005-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 06:46:01 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, peterx@redhat.com, farosas@suse.de,
 junjie.cao@intel.com
Subject: [PATCH v3 0/4] io/channel: complete pread/pwrite_all API and fix
 multifd_file_recv_data
Date: Tue, 14 Apr 2026 05:45:45 +0800
Message-ID: <20260413214549.926435-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.54, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series fixes two bugs in multifd_file_recv_data() and completes
the positioned read/write "all" API set for QIO channels.

Bug summary:
  - size_t variable storing ssize_t return: -1 wraps to SIZE_MAX
  - error_prepend() called without ERRP_GUARD(): NULL deref on short read

Changes since v2:
  - Added qio_channel_pread_all_eof() to complete the API set (Daniel)
  - Added pwrite_all / pwritev_all variants (Daniel)
  - Reworked doc comments to match existing API style (Daniel)
  - Added Fixes tag, expanded _eof test coverage, added CONFIG_PREADV guard

Changes since v1:
  - Used approach (b): add pread_all API instead of local retry loop
    (Daniel, Peter)

v2: https://lore.kernel.org/qemu-devel/20260318140113.434-1-junjie.cao@intel.com/
v1: https://lore.kernel.org/qemu-devel/20260316084618.52-1-junjie.cao@intel.com/

Junjie Cao (4):
  io/channel: introduce qio_channel_pread{v,}_all{,_eof}()
  io/channel: introduce qio_channel_pwrite{v,}_all()
  migration/file: fix type mismatch and NULL deref in
    multifd_file_recv_data
  tests/unit: add pread/pwrite _all tests for io channel file

 include/io/channel.h              | 133 +++++++++++++++++++
 io/channel.c                      | 139 ++++++++++++++++++++
 migration/file.c                  |  13 +-
 tests/unit/test-io-channel-file.c | 207 ++++++++++++++++++++++++++++++
 4 files changed, 486 insertions(+), 6 deletions(-)

-- 
2.43.0



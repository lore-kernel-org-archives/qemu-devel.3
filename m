Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE1E103E187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 14:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2rSs-0002pz-99; Wed, 18 Mar 2026 10:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1w2rSm-0002my-HA
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 10:01:34 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1w2rSj-0005n7-V2
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 10:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773842490; x=1805378490;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=yzJTSu+HLBddDI9SaMfklqPhMNyHA0U9nAhZTnYM7vM=;
 b=geNPttlEpzu35IoNLX5pP/k6HNR6CIAeL7qAQmNxETnYsAlpufUfSLiT
 XPj0fLoUs9NswlFuxcIA5k1rEV0oFvTJdmbdG58OXPNIokqa8GsHOb1wj
 Z18KmoSZS5DHq2/ulJrQNCXFCT7Cz8uGRyszjAis/ekdv91gJ0Xr8zRFC
 w7GlA7tqy5gYwiET7ZLWUwRrjcAQ61GHSTxHjjZSGje0+0PQ3NVKyX1Vd
 eZPu0lohz2wecY0Ayq//g3Q+TiCBhydhtx7MBE55aGuxnGEKTmCMxCAaK
 2ksKgpjqJygqbls0VsCmF7nBZuiYNZefSLZbvc7QVNGuy8GcCpRRdyVkF w==;
X-CSE-ConnectionGUID: vORcdLXNTk6dUs/YxhEGPA==
X-CSE-MsgGUID: mz8k6B6QRGGsnp7PHzFf/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74925769"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="74925769"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 07:01:26 -0700
X-CSE-ConnectionGUID: DT3+9Rd1Sm6mqqejEYApmQ==
X-CSE-MsgGUID: 3obRIv5aQjift3D2aGO72w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="218205212"
Received: from junjieca-mobl.ccr.corp.intel.com ([10.124.242.111])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 07:01:24 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 junjie.cao@intel.com
Subject: [PATCH v2 0/3] migration/file: fix type mismatch and NULL deref in
 multifd_file_recv_data
Date: Wed, 18 Mar 2026 22:01:10 +0800
Message-ID: <20260318140113.434-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.53.0.windows.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

multifd_file_recv_data() has two bugs: a size_t/ssize_t type mismatch
that garbles error messages, and a NULL pointer dereference when a
short read occurs on a truncated migration file.

v1 fixed the symptoms by splitting the error handling.  Peter and
Daniel pointed out that short reads should be retried rather than
just reported, so v2 introduces qio_channel_pread{v,}_all() and
preadv_all_eof() (following the existing read_all pattern), uses them
in the migration code, and adds unit tests covering the key semantics.

Note: qemu_get_buffer_at() in migration/qemu-file.c has a similar
type mismatch and does not retry on short reads either.  That will
be addressed in a follow-up series.

v1: https://lore.kernel.org/qemu-devel/20260316084618.52-1-junjie.cao@intel.com/

v1 -> v2:
  - [NEW] Patch 1/3: introduce qio_channel_pread{v,}_all() and
    preadv_all_eof() helpers in io/channel that retry on short reads,
    advancing the file offset automatically (suggested by Peter Xu).
    All three are marked coroutine_mixed_fn, consistent with
    existing _all helpers.
  - Patch 2/3: switch multifd_file_recv_data() from qio_channel_pread()
    to qio_channel_pread_all(), eliminating the manual byte-count check
    and fixing both the type mismatch and the NULL deref.
  - [NEW] Patch 3/3: add five unit tests for the new pread_all
    helpers covering success, clean EOF, partial EOF, and the
    strict-wrapper EOF-as-error semantics.

Junjie Cao (3):
  io/channel: introduce qio_channel_pread{v,}_all() and preadv_all_eof()
  migration/file: fix type mismatch and NULL deref in
    multifd_file_recv_data
  tests/unit: add pread_all and preadv_all tests for io channel file

 include/io/channel.h              |  63 ++++++++++++++
 io/channel.c                      |  85 ++++++++++++++++++
 migration/file.c                  |  17 ++--
 tests/unit/test-io-channel-file.c | 137 ++++++++++++++++++++++++++++++
 4 files changed, 293 insertions(+), 9 deletions(-)

-- 
2.43.0



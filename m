Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FDEF36C58
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEnSO-00069E-Dr; Mon, 20 Apr 2026 08:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wEnSI-00065y-VU
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 08:10:25 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wEnSE-0004LS-Te
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 08:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776687020; x=1808223020;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OlZhT4d147Vz4VQf3AFDJQdeb9CjW8ehhGdcHA16rqc=;
 b=c6nI2WYeFhZnwIyONLEDNFrfk51YviIYeC4OvwD9LMQmDOx+nhqMBpWB
 1Ssp7n8PcO1vFELyu1w5BxSR0OFwJfnZzv3WGaxsoWwGV2U3WjsWlhamK
 rD91POnmUVEGAI78YEprRkaJXd/C/z5e2LdkHys/0EX3XW8PX2rEXURI4
 AuPtu7XagA0MbM8hymSPuLp21fD3UzNk/20hC1z/m5wtp80YzVAR2gRcc
 7C8qUuCXH/YfKXxPO8VvwKujlV6YW/Ww/tHYf08hCyKwa7AYXfH4ePxZp
 MpYwb+ngTT0VaQJyDFo8o7WzPxs5gD5nVJNzyrASTJkmjxTOKl6HIajb2 w==;
X-CSE-ConnectionGUID: iNo+yxsFQ+mc0ZxPuIaZ0Q==
X-CSE-MsgGUID: bmSWiZsnTlyjaClLLcRhfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88674191"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; d="scan'208";a="88674191"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 05:10:15 -0700
X-CSE-ConnectionGUID: T0bXxbg+RRuzQabSVoHaIw==
X-CSE-MsgGUID: sMOfYHiNShiDo1s1hzrnJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; d="scan'208";a="235708250"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by ORVIESA003-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 05:10:13 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de,
	junjie.cao@intel.com
Subject: [PATCH 0/3] migration: switch remaining positioned I/O to _all helpers
Date: Tue, 21 Apr 2026 04:13:14 +0800
Message-ID: <20260420201317.30199-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Follow-up to the pread/pwrite_all API series [1].

qemu_put_buffer_at(), qemu_get_buffer_at(), and file_write_ramblock_iov()
all use single-shot positioned I/O without retry.  They share the same
pattern as the bug fixed in multifd_file_recv_data() where a short
transfer would be mishandled.

Convert them to the _all helpers and clean up a pre-existing
const-correctness issue in qemu_get_buffer_at() along the way.

After this series no positioned I/O call site in migration/ uses raw
single-shot channel operations.

Depends-on: <20260413214549.926435-1-junjie.cao@intel.com>
("io/channel: complete pread/pwrite_all API and fix
multifd_file_recv_data")

[1] https://lore.kernel.org/qemu-devel/20260413214549.926435-1-junjie.cao@intel.com/

Junjie Cao (3):
  migration/qemu-file: switch buffer_at functions to positioned I/O _all
    helpers
  migration/file: switch file_write_ramblock_iov to pwritev_all
  migration/qemu-file: drop incorrect const from qemu_get_buffer_at buf

 migration/file.c      |  8 ++++----
 migration/qemu-file.c | 37 ++++---------------------------------
 migration/qemu-file.h |  2 +-
 3 files changed, 9 insertions(+), 38 deletions(-)

-- 
2.43.0



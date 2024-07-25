Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9648C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 07:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWsof-0006xP-2w; Thu, 25 Jul 2024 03:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1sWsoZ-0006h0-SF
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:23:05 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1sWsoY-0001Pi-AN
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721892182; x=1753428182;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hEJIsWDYfFTtEa1W706+mMe0OCLnShBTQaakw4gSz8Q=;
 b=VGIRqV922stGTL+3/UdR3MDzOrvey08sZR7BbIiRt1NYAhIhJC1tD9ip
 p58iLeyRXBc6FRmnkz/3o2HmN/J3pQK9B9Z3CqTjWw1wEazIiw8KJkQv0
 B3nPIHAY1Wd4JWh4cnOZhkG143N1WsIZ9mmukHs9BwzNUB6Q+u4VfEPlH
 yH434buJKnKAW8jIFRHozSqq5XVzZQvNAZkZbhn165tWe37HwF/r/3DaA
 IeErZRSzk5/dlrDcMCWovsVMzMaFTep/uDXF+J8iXYYGqMFutVw1v86so
 cxzDXQjTPTxwC/LY5QJZ8W5ZAf1rh8niPFAADQ8rkFK5Rupa3qCYPZHjn A==;
X-CSE-ConnectionGUID: PUsSsObqSbmLQSKKLdBcNQ==
X-CSE-MsgGUID: GdTVBAagRXGd0HEViIBHTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="30754016"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; d="scan'208";a="30754016"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2024 00:23:01 -0700
X-CSE-ConnectionGUID: /vvKROvzSbqAL9fMxU/uyw==
X-CSE-MsgGUID: hWGUxWa3R/yK5BGhLtSg/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; d="scan'208";a="52858206"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2024 00:22:58 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Edgecombe Rick P <rick.p.edgecombe@intel.com>,
 Wang Wei W <wei.w.wang@intel.com>, Peng Chao P <chao.p.peng@intel.com>,
 Gao Chao <chao.gao@intel.com>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: [RFC PATCH 6/6] RAMBlock: make guest_memfd require coordinate discard
Date: Thu, 25 Jul 2024 03:21:15 -0400
Message-ID: <20240725072118.358923-7-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240725072118.358923-1-chenyi.qiang@intel.com>
References: <20240725072118.358923-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

As guest_memfd is now managed by guest_memfd_manager with
RamDiscardManager, only block uncoordinated discard.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 system/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 98072ae246..ffd68debf0 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1849,7 +1849,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         assert(kvm_enabled());
         assert(new_block->guest_memfd < 0);
 
-        if (ram_block_discard_require(true) < 0) {
+        if (ram_block_coordinated_discard_require(true) < 0) {
             error_setg_errno(errp, errno,
                              "cannot set up private guest memory: discard currently blocked");
             error_append_hint(errp, "Are you using assigned devices?\n");
-- 
2.43.5



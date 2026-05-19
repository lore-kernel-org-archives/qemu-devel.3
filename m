Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206E2CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 02:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPATH-0002Kp-QZ; Mon, 18 May 2026 22:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wPAT6-0002J1-Al; Mon, 18 May 2026 22:46:05 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wPAT3-0000Vr-BL; Mon, 18 May 2026 22:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779158761; x=1810694761;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=35EGuKaQjwDSwlM1QwxtIljDM26p2iqkf2VD11+8db4=;
 b=IvUH8EABqukmYPc8B9225g0sWSANxzZYX8F/TS//EWyF7QCd8MA/zMRi
 xmWQoeoRmnYZV7neuD6MOpb5STKTEmU9reFmV4KUlkruZe/wh0Ue4asM/
 lO3QNAnODh4cMicXic1E6II6YaPdq9vA/gbARKSErsUCdcQ/sLhJNGuMF
 Fy5WB3Xnap9YTra9DvvapFvlgqCQDuAyhg0DfEkw3aDWTJ6G3NY4KFPh5
 KGP2RrfzOgNzRGryyzPjUAVVCR+nCe7x2bMwOGrYJ9/+e4xxELM5HLVYO
 pvxa9pVZrqt9UP0ITMaRVGlwBtUaA8H1ql5fAP4noI2Xo1YTXENvsftb6 A==;
X-CSE-ConnectionGUID: bURq3UUMSvyz1Etfl6ShvQ==
X-CSE-MsgGUID: 0bDAleulQ8GysUJwtz2Q0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="79878340"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="79878340"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 19:45:51 -0700
X-CSE-ConnectionGUID: f+lnKwyRRICVXJqsXTy/Kg==
X-CSE-MsgGUID: dLX6v0e5RCy5jqTqNpltVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="239879535"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 19:45:49 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, chad@jablonski.xyz, philmd@linaro.org, bea1e@proton.me,
 qemu-stable@nongnu.org, junjie.cao@intel.com
Subject: [PATCH v2 0/2] hw/display/ati: fix HOST_DATA accumulator overflow and
 bpp==0 crashes
Date: Tue, 19 May 2026 10:39:35 +0800
Message-ID: <20260519023937.439077-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=junjie.cao@intel.com;
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

Two guest-triggerable crashes in the ati-vga HOST_DATA blit path,
independently found via fuzzing (generic-fuzz with ASan/UBSan).

Patch 1 fixes the heap-buffer-overflow: when ati_host_data_flush()
returns early, host_data.next was not reset, causing subsequent
HOST_DATA writes to index past acc[3]. The fix moves the reset into
the write handler as suggested by Chad Jablonski in the v1 discussion.

Patch 2 fixes division-by-zero (SIGFPE) and g_assert_not_reached()
when ati_bpp_from_datatype() returns 0 for invalid dp_datatype values.

Based on Feifan Qian's v1 report and the subsequent design discussion
between BALATON Zoltan and Chad Jablonski.

v1: https://lore.kernel.org/qemu-devel/Czyl6yVfL6sHl_o1kRk8N_LpwXMMRVhO9vgz1qCVJFagn9D4nHSKuiux39iOLty0Q3acxQq_FeovPhTQvSKus2htwjI9lTajLZmqovr0Wxs=@proton.me/

Junjie Cao (2):
  hw/display/ati: reset host_data.next in write handler after flush
  hw/display/ati: guard against zero bpp in ati_host_data_flush

 hw/display/ati.c    | 2 ++
 hw/display/ati_2d.c | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.43.0



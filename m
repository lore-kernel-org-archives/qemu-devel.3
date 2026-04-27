Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CF5FF8850
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 01:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHAii-0008GB-Lw; Sun, 26 Apr 2026 21:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wHAih-0008DF-0z
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 21:25:07 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wHAiW-0003Wx-8V
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 21:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777253096; x=1808789096;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PQsA6eSPSgWtHbMurUkqB0eLV+z1ONndpEM1Oab0cvs=;
 b=l8CPUrJ95eVuWW2cU0DFd5U5SwN7uibzwofWkob8l64UGcZoisqmjhoV
 YQg3h7Jft14yoxetAhcfmKk2puPkFi+gaZePbhPioRcIeI/UAkaB7+2va
 ETMlbAn4vS0KpRuB5ViWLDg1kiHRmiQOD+19ZL0ST7yg6FL4kxBj3FMty
 FqLNLefR19R0GfcbDjRXDee7V66gF1tTNh+3vUw8cqE+lvvq7/mXztNnI
 HnDMZwZDMMxB+QFCJWQCynTGUn5FLxJ7kN9RcEBeflFJsVWi0+0a7P7Lv
 QLXfWl3a+WyUwNv2fEHPMBrB2HtQfaEGBiNfIEe1nLH7oOape6Dn5792q w==;
X-CSE-ConnectionGUID: VysE/9tITH+WHPIH0fqjjw==
X-CSE-MsgGUID: 5tTNw8uOS9qJK/E5hmXkYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="78249170"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="78249170"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2026 18:24:51 -0700
X-CSE-ConnectionGUID: /D7I4B+gTGu4S4xBUB9ySA==
X-CSE-MsgGUID: BEPGQSMFQRC1OylkoHUKLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="257012724"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2026 18:24:49 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: junjie.cao@intel.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@bull.com,
 zhenzhong.duan@intel.com
Subject: Re: [PATCH v2 1/2] intel_iommu: widen impl.min_access_size to 8 to
 fix MMIO abort
Date: Mon, 27 Apr 2026 09:24:19 +0800
Message-ID: <20260427012419.323362-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e7022bd7-7fcc-4ba5-99be-35a032c41c52@linaro.org>
References: <20260424201842.176953-1-junjie.cao@intel.com>
 <20260424201842.176953-2-junjie.cao@intel.com>
 <e7022bd7-7fcc-4ba5-99be-35a032c41c52@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Philippe,

Thanks for the review and the good question.

Looking at access_with_adjusted_size(), the _HI offsets (0x24, 0x2c, ...)
and standalone 32-bit registers like DMAR_PEUADDR_REG (0xec) are
4-byte-aligned but not 8-byte-aligned.  An 8-byte guest access to them
is indeed rejected by memory_region_access_valid (0xec & 7 != 0).  But a
4-byte access passes (0xec & 3 == 0), and the framework then widens size
to 8 while keeping the original addr -- so the handler is still reached
at these offsets.

For example, a guest 4-byte write to DMAR_PEUADDR_REG (0xec):

  1. memory_region_access_valid: size=4, 0xec & 3 == 0 -> pass
  2. access_with_adjusted_size: access_size = MAX(MIN(4,8),8) = 8
  3. write_accessor calls vtd_mem_write(opaque, 0xec, val_zext, 8)
  4. switch(addr) -> case DMAR_PEUADDR_REG -> vtd_set_long(s, addr, val)

So I believe these branches are still needed.  Please let me know if
I've missed something, or if you'd like any changes for v3.

Many thanks,
Junjie


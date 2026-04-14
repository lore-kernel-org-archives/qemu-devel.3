Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824F1F9D0CD
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCdST-0004HE-G7; Tue, 14 Apr 2026 09:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wCdSQ-0004Go-Hm; Tue, 14 Apr 2026 09:05:34 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wCdSN-0004JY-S4; Tue, 14 Apr 2026 09:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776171931; x=1807707931;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rwkmF3emdRnrK2XRjdLI3LCe0dEgU+D1Ab7DnNqUVLQ=;
 b=eyy0salJElnT2XoqD8NohfQD1/wRdCQeYpDB3FhIo6FdSRfQdeWvhLLr
 83TM8eDag9Ge2LkgmXv0zdmjQqjJF7dtXvUrNRLjgC3+XIw65lajR1R4e
 Ogsl6Zpkw6KH+lk3IX4QbTTEDgkAb8pSP6Px1SxWT9kKO3yDkNqBkunLw
 9wA1YFwfkWIFSU389uDyyPM/FP/jX8h0squ2yrXLExBPjRUUSlwC7LnkU
 M+aafM9VJEWj1kHV0FYmkWVSjsVBknFPkr1/xmeiuoQv+vSU8h68zT+mR
 EarWBfKMnrlyplFPeZycCJGLzlZPR18fAyauLVRak7MtboOmIYdq95tAp A==;
X-CSE-ConnectionGUID: evrgAEINQw2eNq0jAIIwZw==
X-CSE-MsgGUID: vJekZdI1SN+kIewy2Lj0zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="87432992"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="87432992"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2026 06:05:27 -0700
X-CSE-ConnectionGUID: tOV9RmzMSvecvsDtQ8XWpQ==
X-CSE-MsgGUID: c9GhDTwoRUSFfHCCcEHQQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="235048642"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by orviesa005-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 06:05:25 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chad Jablonski <chad@jablonski.xyz>, qemu-stable@nongnu.org,
 junjie.cao@intel.com
Subject: Re: [PATCH] ati-vga: fix unsigned integer overflow in cursor bounds
 checks
Date: Wed, 15 Apr 2026 05:08:21 +0800
Message-ID: <20260414210821.1122197-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <da61bc75-3c2e-a5d1-1448-2386b12c84a6@eik.bme.hu>
References: <20260414141458.1076014-1-junjie.cao@intel.com>
 <da61bc75-3c2e-a5d1-1448-2386b12c84a6@eik.bme.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=junjie.cao@intel.com;
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

Thanks for the quick review and the suggestion.

I'll send a v2 series quickly, also collecting the Reviewed-by along
the way (there was a semicolon in the tag, which might have kept it
from being automatically collected). Sorry for the churn, Philippe.


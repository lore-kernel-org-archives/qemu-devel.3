Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E1BC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFdw-0002R7-5T; Tue, 21 Jan 2025 09:54:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taFdu-0002Pk-GY
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:54:14 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taFdr-0000FI-OF
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737471252; x=1769007252;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+HY3s4K5fW9a+wxj7uYXTAtRThpIycByNTGJoi/JO9A=;
 b=nNTVtXQC7eAqwlF36damKUOSO6E6I3MvOxHZ5QNMnCzOBYLWXb+Nyxjs
 m/7fWXnh1yYueucB6sj6YMNstVmbjup71nGI1PJYIXAeDRgroLqxXBE94
 r8lTSHYs9uvxd6ia8/dexIvzKhfKTE9VRG8RJVK0RUTDkAtaDQWQQFOTK
 S5hSVqQIU8MlnMI0UVw6n/t9+dN29fcCxVxLyIyN02znmSxmPTqIUuZXG
 kjDW5HPvktg14B9fXLj3wJpjCEyl+MDWK/tCUeHfPcRe4qYJmrARL0rtq
 FCngaZe7BEVTOtscKgIc/JJtcFAteU2O2z1BsU4EVcsrkOi6GfJxpOzGa A==;
X-CSE-ConnectionGUID: S2v72d9dR8+pqOwWKDaKyA==
X-CSE-MsgGUID: WXBkykicQmOIUGySVnskjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37763506"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="37763506"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 06:54:09 -0800
X-CSE-ConnectionGUID: boaGdfB0TheJJ6UM67NBGQ==
X-CSE-MsgGUID: nmFDPnXZScSVvuLOIsazRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="106639882"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 21 Jan 2025 06:54:06 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=83?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 0/2] memattrs: miscellaneous cleanup to support memattrs
 binding
Date: Tue, 21 Jan 2025 23:13:20 +0800
Message-Id: <20250121151322.171832-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi,

This is my v2. The link to v1 seems to be partially missing [1], and I've
also double-checked previous comments from Peter, CLEMENT and Paolo to
make sure I haven't lost everyone's feedback :-) (and because of
yesterday's little mix-up, I also realized in time that I almost missed
Paolo's feedback...).

Introduction
============

This series tries to address the previous comments for memattrs
binding [2].

Since bindgen has many limitations on bit fields conversion and it is
unable to generate an equivalent macro definition for MEMTXATTRS_UNSPECIFIED,
so that memattrs binding requires the external crate to solve many
annoyances caused by bit fields.

The easiest way, therefore, is to remove bit fields from memattrs. And
that's what this series does.

[1]: https://lore.kernel.org/qemu-devel/Z4+P3eHXqcU4Dqdx@intel.com/T/#m8481b68ec3c38f6281dc96ed77fa376b0bdd1e7e
[2]: https://lore.kernel.org/qemu-devel/20241205060714.256270-7-zhao1.liu@intel.com/

Thanks and Best Regards,
Zhao

---
Zhao Liu (2):
  memattrs: Convert unspecified member to bool
  memattrs: Check the size of MemTxAttrs

 include/exec/memattrs.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

-- 
2.34.1



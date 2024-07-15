Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DF6C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTGjN-00023K-8V; Mon, 15 Jul 2024 04:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTGjI-0001xC-FN; Mon, 15 Jul 2024 04:06:41 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTGjD-00043v-5P; Mon, 15 Jul 2024 04:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721030795; x=1752566795;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Lp4v3L+AkbHFxgebhesrGiQlCdljWIVdS1biLiIzptI=;
 b=OFIP4Og2llrWLZJptuApdXAnQQ0Ch+3bNlYs500QBZ9g0Yx9sziw8Eft
 rYgPH+ExK43zxGDDeIZarDtw7TgvpWUdOdghOBxmmZSl7d6Wz1bdpinpy
 n6aZw68YM4doQ5W4uM1OltrIgfn5R0LV26VSQyc6gta5vXpVAQLINTwYY
 bMaLiQJiY99vLwEY7/hKvgL/OjC8uULNOpSZJc0ijs9xHP1d0j3NOaA4z
 IzpFQ12zZpw/vQEEc5+Vs2+NcpGBlaieOt7nNasAxqyjagGc1h8YcKobl
 ZFIFP6aB2inc/NCBJT4MMP/CSkEdf/xElqXS8zk028BxPcB3e2/AYVxqR g==;
X-CSE-ConnectionGUID: A+MMKsr9RKOomODTLBYgvw==
X-CSE-MsgGUID: EHSbiq/URxKTJ7NgNr4Gaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="35935615"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="35935615"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 01:06:30 -0700
X-CSE-ConnectionGUID: fDkr1dItSteGpLOwmzo+yA==
X-CSE-MsgGUID: rDPg4alCSpmbPOpBnDmxAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="49512569"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 15 Jul 2024 01:06:28 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/7] trivial: Replace some qemu_open_old() with qemu_open()
Date: Mon, 15 Jul 2024 16:21:48 +0800
Message-Id: <20240715082155.28771-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi list,

After Daniel's renaming (448058aa99aa "util: rename qemu_open() to
qemu_open_old()"), I find some qemu_open_old() can be directly replaced
by the new qemu_open().

This series considers the case where @errp exists, for which @errp can
be passed directly to qemu_open().

There would be more cleanup to help qemu_open_old() retire as early as
possible.

Thanks and Best Regards,
Zhao
---
Zhao Liu (7):
  hw/i386/sgx: Get rid of qemu_open_old()
  hw/usb/host-libusb: Get rid of qemu_open_old()
  hw/usb/u2f-passthru: Get rid of qemu_open_old()
  hw/vfio/container: Get rid of qemu_open_old()
  backends/hostmem-epc: Get rid of qemu_open_old()
  backends/iommufd: Get rid of qemu_open_old()
  backends/rng-random: Get rid of qemu_open_old()

 backends/hostmem-epc.c | 4 +---
 backends/iommufd.c     | 3 +--
 backends/rng-random.c  | 9 +++++----
 hw/i386/sgx.c          | 6 ++++--
 hw/usb/host-libusb.c   | 3 +--
 hw/usb/u2f-passthru.c  | 4 +---
 hw/vfio/container.c    | 6 ++----
 7 files changed, 15 insertions(+), 20 deletions(-)

-- 
2.34.1



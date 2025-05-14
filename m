Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4004BC3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 08:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF7U8-0006c3-PM; Wed, 14 May 2025 04:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uF7U5-0006V4-BK; Wed, 14 May 2025 04:29:01 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uF7U2-0006Fg-Ov; Wed, 14 May 2025 04:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747211339; x=1778747339;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=egObq7r+bAUf06a07tyz1db9wNYsBeBm+FIL2c4bTpk=;
 b=ApB1ofOmwYVtXN4COedsSVOwFVuBaNiXRCvTHBUkLsXWgeB3ZiGTkTCL
 phaLd9peE7F1BcpvyNRrbFcwlLmRXcBssHRq/G8BP+z0B7JNOspubOjll
 ghL0rEvh7we86SurWCa5XRQn5ABj/ZVFmsG0o1txVK4Qg21TeTz7dFEMl
 tikOJrDQDhXRpCK0Nq8Nc7u8nC7EmUsgVkQq1zt5M8qcnt0eAw//GXopA
 yY6JAKYwRwJL4GrNCKqbq6CiUnZep4ghCNlCBUn15Fz0MCHQgzxkpLiVI
 kuNXgoSntpImcQQ2N7v1nox320i/YSFpuhvHxgB2Hh4C0BVbFXnH8pzOO w==;
X-CSE-ConnectionGUID: RZGOl9klT2is/Sg2gjqEoQ==
X-CSE-MsgGUID: G5acNfiSRRCsluhR75KhbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="66505563"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="66505563"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 01:28:55 -0700
X-CSE-ConnectionGUID: /ajFYO2HT1CTKSRzKHxO9A==
X-CSE-MsgGUID: zTsZLN5wSDO/sn1lXmS3EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="169065802"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 14 May 2025 01:28:52 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/9] qom: Consolidate OBJECT_{DEFINE|DECLARE}_SIMPLE_TYPE*
Date: Wed, 14 May 2025 16:49:48 +0800
Message-Id: <20250514084957.2221975-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
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

When I read the qom doc (qom.rst) about OBJECT_DECLARE_SIMPLE_TYPE, I
found there's the wrong example. So I tried to fix the doc and cleaned
up the relevant code case to correctly show that for simple type, the
class definition is not needed.

This series tries to:

 * fix & improve the documentation of OBJECT_{DEFINE|DECLARE}_SIMPLE_TYPE*,

 * and clean up several cases that could have used simple type macros
   (mainly by dropping unneeded class definitions).

Thanks and Best Regards,
Zhao
---
Zhao Liu (9):
  qom/object: Improve the doc of macros related with simple type
  docs/devel/qom: Fix the doc about OBJECT_DECLARE_SIMPLE_TYPE
  hw/acpi/pci: Consolidate OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
  hw/char/sh_serial: Consolidate
    OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
  hw/hyperv/hv-balloon: Consolidate
    OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
  hw/ppc/pef: Consolidate OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
  hw/core/resetcontainer: Consolidate OBJECT_DECLARE_SIMPLE_TYPE
  target/s390x/kvm/pv: Consolidate
    OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
  ui/console-vc: Consolidate OBJECT_DEFINE_SIMPLE_TYPE

 docs/devel/qom.rst               | 11 +----------
 hw/acpi/pci.c                    | 24 ++++++++----------------
 hw/char/sh_serial.c              |  4 +---
 hw/hyperv/hv-balloon.c           |  8 ++------
 hw/ppc/pef.c                     | 17 ++++++-----------
 include/hw/core/resetcontainer.h |  2 +-
 include/qom/object.h             |  5 +++--
 target/s390x/kvm/pv.c            | 18 ++++++------------
 ui/console-vc.c                  | 14 ++++++++------
 9 files changed, 36 insertions(+), 67 deletions(-)

-- 
2.34.1



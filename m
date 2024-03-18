Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AF7C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 03:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm3lp-0002xS-U6; Sun, 17 Mar 2024 23:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rm3lo-0002xA-SS
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 23:34:40 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rm3ln-0002tL-C6
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 23:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710732880; x=1742268880;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=PMFCPitR/WD3kQbQJWWLb3P+n6ItfpnwbpiGcHk4/28=;
 b=AdgXPol9WuPp5JEAjuRcAzZjcgaIkKNa6np/dUY7XoFgFAMUT1r8xAfn
 a4Zq8fDnfELoCessRsA6SpoclvG/y/Lvl7+8bUC5rvBq6zLYnnR95BXpU
 S/nZLB8L7SAzDL+dRkh6Y3zv7IFYx4zZQ/fIWBpYIZt8n7IIBR826MCJM
 fe0i+ml3NYXlK4HTOi4AFs2L7Ble+MSfgzVtv+GakQLwV+5cF/ReRwnlk
 +AFAXFuT5nWxEpvmiFudjtHpwzRYa62F6+W1Luj9Ub1mQZI59RMdoyEWp
 GZYWfyGIk3MA2tJf6LG0eQkqnQDCMBa5JJS74E8vRi72r0dwn5wP7N1c/ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="5403670"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5403670"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2024 20:34:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; d="scan'208";a="13275348"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2024 20:34:28 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 zhao1.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 0/3] Simplify user_creatable_add_type error path
Date: Mon, 18 Mar 2024 11:32:07 +0800
Message-Id: <20240318033211.459006-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is a simplification to user_creatable_add_type error path.
Removed local_err and its check in error path, check return value
instead.

Tested with make check and guest bootup.

Thanks
Zhenzhong

Changelog:
v2:
- Use err label to replace out label (Zhao Liu)
- Refine patch description (Zhao Liu)
- Make object_set_properties_from_qdict return bool (Zhao Liu)
- Check return value of object_property_try_add_child (Zhao Liu)
- Add R-B

Zhenzhong Duan (3):
  qom/object_interfaces: Remove unnecessary local error check
  qom/object_interfaces: Make object_set_properties_from_qdict return
    bool
  qom/object_interfaces: Remove local_err in user_creatable_add_type

 qom/object_interfaces.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

-- 
2.34.1



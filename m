Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B77FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 14:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHN1f-0006FS-KY; Mon, 27 Apr 2026 10:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wHN1e-0006F7-L9; Mon, 27 Apr 2026 10:33:30 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wHN1b-0002wt-PK; Mon, 27 Apr 2026 10:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777300407; x=1808836407;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WTujXG87fbk3fXF5SF2GO2sYAihOlR9qY20zSoClWJc=;
 b=Bqf32RVgNdW5G4Z7cRZOvL3b/rGEsNWhd1Dz9Nlpos/3alfA/3Ihv4UK
 qyX+rXkAzUFR4Nw9LGgkdObeelYYmZ7az02MgmFhy08AOwwFo+UO5qqvX
 q6tStc/OJrLh8dcdlhbQvMbedpvDjKOPIrDuQoBj+h9oTake9CC5sz/QO
 vpJ/mZnvk2Txq22xpxHO+SjK11cOQb1vlg6eeG9XsxBssv5MqjgqRvpgL
 NOKf4jrFYP2jldl+piFJJgQbMCgf+z+ygBhBoVFxyOMhOrfRBLXbvyJJ/
 j9SCPZ1vsKEqPAgWI2DDHzncEx1Po4NSzrs0675BfTRoV4Kg5ljvnQPZj g==;
X-CSE-ConnectionGUID: lzGUMYC0RUm/7JKbN2DnFg==
X-CSE-MsgGUID: 9iuZZ4+UTHuC5VrhKj1jlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77216796"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; d="scan'208";a="77216796"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 07:33:24 -0700
X-CSE-ConnectionGUID: xIBT8zIsTyyAos9xmmia1A==
X-CSE-MsgGUID: dhoZDE3gQ1aXQwgHl8uSfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; d="scan'208";a="229321563"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by fmviesa010-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:33:22 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: peterx@redhat.com,
	mjt@tls.msk.ru
Cc: junjie.cao@intel.com, qemu-devel@nongnu.org, farosas@suse.de,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 0/3] migration: switch remaining positioned I/O to _all
 helpers
Date: Tue, 28 Apr 2026 06:36:06 +0800
Message-ID: <20260427223606.1433629-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ae9hnhsSivO_RfVf@x1.local>
References: <ae9hnhsSivO_RfVf@x1.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=junjie.cao@intel.com;
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

Hi Peter and Michael,

No, I don't have a real reproducer.  Triggering partial I/O on regular
files in practice requires unusual conditions, the window is narrow.
Agree with skipping stable for both sets.

Many thanks,
Junjie


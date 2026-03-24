Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A15F532DD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 06:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4usr-0007Gy-FL; Tue, 24 Mar 2026 02:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1w4uso-0007GY-Tl
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 02:04:54 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1w4usm-0005hj-BE
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 02:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774332292; x=1805868292;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RbpvYKmApSlLkI1gWUQF2cQ+NUOtLE4LPxuOcZ4JHpk=;
 b=k0T8rcu2PbBuNCG9BHrcYz4biJCf1xVryRNuo74wE/yQ8C3D7nAdNWMx
 b00TuagPc8frrf/xwjofx/5ajzsahKKyiG3eBTEI4/BkbPbnKaUdUDjR+
 4obzmIzSyipXOEXg6r4lCNBTWfR49m8V/WQezKdVs8eRe4V3bytwtNbXW
 W8XQqAEXGHdTCYXRfllDc4hugXVkhM8Md7ow2jhgeWen6ZfvHfBRa9SdB
 e2Bo/eIzm4DHOMp367FiO3MVKUlaVhoIA5dW57YjD4a4yCgwjV26CmpL1
 yBG1S6vntjVWf2f8rqtu1dDCjSGPIZWy8Miftzc7lnLtYhtNCp1uTPZ1R A==;
X-CSE-ConnectionGUID: 2nCeogNvQ8ORvusdhoTWxQ==
X-CSE-MsgGUID: Sht2K0LaT+uxZEzlbQ7aqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="79249594"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="79249594"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 23:04:49 -0700
X-CSE-ConnectionGUID: Q9gyt0TgRl6KkAr336tvdQ==
X-CSE-MsgGUID: Q+4/Y6P8R+uIiWo4ekxEUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="228326378"
Received: from junjieca-mobl.ccr.corp.intel.com ([10.124.242.111])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 23:04:47 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, berrange@redhat.com, peter.maydell@linaro.org,
 jasowang@redhat.com, junjie.cao@intel.com
Subject: Re: [PATCH] virtio-net: validate RSS indirections_len in post_load
Date: Tue, 24 Mar 2026 14:04:41 +0800
Message-ID: <20260324060441.771-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20260323131531.1976-1-junjie.cao@intel.com>
References: <20260323131531.1976-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Thanks everyone for the discussion, very rewarding for me.

I've sent v2, addressing Michael's review.  I also tightened the
commit message to scope the trigger explicitly to corrupted save
files and crafted migration streams.

Thanks,
Junjie


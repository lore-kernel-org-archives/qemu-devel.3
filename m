Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EE0C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 04:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wemAj-0006nZ-JJ; Wed, 01 Jul 2026 00:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wemAK-0006hA-Ar; Wed, 01 Jul 2026 00:03:13 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wemAI-00048I-LQ; Wed, 01 Jul 2026 00:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782878591; x=1814414591;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JJAzKuf83RemFpKgBornTru8yy2wgL5wNdzf5fOOBVk=;
 b=Y5sQQgztbOQt8KqvE+hktIg3GXDD8nCD10GABhxwJ6UQUgLMl5OYTHSd
 +KALLOme/UQDLEexUwhmqlpvy8jOr9HlT6fT2i9Ii7eP789UqIWThi0Xp
 RN7y8pbFOislhmQC8wBpr5OPYbgWUXHO6UEVZ9HlDRxVsFTT2rMzH+XoF
 lDiS7xJToO1eBkMaMMJrO3/OfsHa91ilAgf47AUu+Bg+tzgJJCPewgyfS
 KTyB7SeSejojOjYMKC5Kg6NWpkA4NHvb2UNE4bOLRsLCD/eIFfypLxG/2
 yqDXKxpiYjS6GYjAbw/tqEKL7usngEM810l2fUD7SckEiCNTH0Fc3uZVe w==;
X-CSE-ConnectionGUID: DM1aUTg6Tayrk5SVWxC1Ug==
X-CSE-MsgGUID: krO9bYAqSZGQF35mNq9clA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="82589146"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="82589146"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 21:03:05 -0700
X-CSE-ConnectionGUID: Wu+Ccg56QlaYWgRwWxYX8g==
X-CSE-MsgGUID: Yf4NgkZVTBOxIwgze0Ym/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="253093913"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 21:03:03 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org, junjie.cao@intel.com
Subject: Re: [PATCH v2] virtio-net: validate RSS indirections_len in post_load
Date: Wed,  1 Jul 2026 11:25:24 +0800
Message-ID: <20260701032524.2076295-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513055917-mutt-send-email-mst@kernel.org>
References: <20260324060100.1997-1-junjie.cao@intel.com>
 <20260513055917-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=junjie.cao@intel.com;
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

Hi Michael,

Gentle ping on this patch.  It didn't appear in your recent
"pci, vhost, virtio, iommu" pull request (June 14).
Was it intentionally deferred, or did it slip through the cracks?

It still applies cleanly to current master.

Thanks,
Junjie


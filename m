Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF55CCF9F6
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 06:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEMBW-0005L5-OH; Thu, 30 Oct 2025 02:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vEMBT-0005KY-6g; Thu, 30 Oct 2025 02:30:55 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vEMBO-0005ZO-Pp; Thu, 30 Oct 2025 02:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761805851; x=1793341851;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=1xiPN3Ld3VgcDORrgDm/di4kBqD2EegfjsGS7n9RBiQ=;
 b=We8vL3K7lXk6CdxmyBh+Ce3AWJr8YHW5GsMU9ENsafeGCPkYK0/DDAOg
 Nx4pl6qJ09iZ5xhR8kExdIPVVLEyIs9VVNI0PgBP42TrsZS1+q74gpPkA
 kNaWXhUHjzy9vH0wf0j7ndZd4uIkGrdAhLHNfL6R1CgwG+ug36fUSt4DM
 38KKNjEsL07/utZRBBkqEaMx9FPXB0nwAvNfcRUQJhNUecD8qV2jAo1aq
 0SCmWNlAk8qglADxbTgrZegsKGzfnVxt0x0y2IX7NWAi4gdbggArSX2uT
 RU6vwtEgfMU8RB+kSqCnDH9dH49zJrvG1stomPpRt2UtEeXzJZoytWnHk Q==;
X-CSE-ConnectionGUID: +lZnJIRkSZeqiScHX6lc2A==
X-CSE-MsgGUID: mcBqadAsQUSExTqcfTfpfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="67799499"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; d="scan'208";a="67799499"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 23:30:33 -0700
X-CSE-ConnectionGUID: lZM0/iL7RUyGYb4IMYCGdw==
X-CSE-MsgGUID: 40U0vIinRoSBP+yQs1YEBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; d="scan'208";a="185126550"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 29 Oct 2025 23:30:30 -0700
Date: Thu, 30 Oct 2025 14:52:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 17/25] hw/timer/hpet: Use memory_region_get_address()
Message-ID: <aQMLOUsPavo8YqeD@intel.com>
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-18-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028181300.41475-18-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
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

On Tue, Oct 28, 2025 at 07:12:51PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Tue, 28 Oct 2025 19:12:51 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 17/25] hw/timer/hpet: Use memory_region_get_address()
> X-Mailer: git-send-email 2.51.0
> 
> MemoryRegion::addr is private data of MemoryRegion, use
> memory_region_get_address() to access it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/timer/hpet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



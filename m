Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9933FC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 06:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfw9X-0007vj-2Q; Fri, 01 Mar 2024 01:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfw9U-0007vH-IC
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 01:13:48 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfw9S-0002y7-34
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 01:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709273627; x=1740809627;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ABzgXBkkjDlPMcqWgp0yAfaZ1RTYJeUZYbJyt6Q83cs=;
 b=fHOYyUiKctDEmLoHt39oWyBvxLGMEqQJyVMnhdTE9Ws+4sGdUpafHWoN
 GLzBi6uVQpfNP2KHgpihmqYWQP5pboEon9kAbi5VFuLeeycT7FyymU6My
 6VNr8qvbIJr7VlLVHBlQ7mG8gmL9s+t8TxYxmZA6CEoHsXYGHoXTPtGa7
 cmiJvM/wcZAZIjPeJfogLKVYhCJH5m2uc6PhFL3fZQwB9qu8Qm9wVsYeL
 weYmFDu7z+L9eXrVcS2jdI1W/TyngE8B+xnW00xncwR1/fw2OpBrQbS11
 Ss8PMgREdbqgU9Q5AdkAprR07+nuoJnF1m+LR4+P5vo3WKsHwgkJAe8f8 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="14363532"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; d="scan'208";a="14363532"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Feb 2024 22:13:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; d="scan'208";a="12770279"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 29 Feb 2024 22:13:37 -0800
Date: Fri, 1 Mar 2024 14:27:21 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v9 18/21] hw/i386/pc: Support smp.modules for x86 PC
 machine
Message-ID: <ZeF1SR55ellwNyji@intel.com>
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
 <20240227103231.1556302-19-zhao1.liu@linux.intel.com>
 <3ab53ea9-be77-4ee7-9247-d89c0ec62346@amd.com>
 <ZeAzB/ISM+g/XGa3@intel.com>
 <a67f6856-e5d5-4fb4-a94d-7748979bbbe9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a67f6856-e5d5-4fb4-a94d-7748979bbbe9@amd.com>
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

> >> You have added drawers, books here. Were they missing before?
> >>
> > 
> > ...so yes, I think those 2 parameters are missed at this place.
> 
> ok. If there is another revision then add a line about this change in the
> commit message. Otherwise it is fine.
> 
> Reviewed-by: Babu Moger <babu.moger@amd.com>
>

Sure! Thank you.

-Zhao



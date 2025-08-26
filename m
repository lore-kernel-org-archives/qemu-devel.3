Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A425CA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 12:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqsVf-00083I-65; Tue, 26 Aug 2025 08:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqsVQ-00081u-Qw
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:10:29 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqsVH-0006PA-09
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756210219; x=1787746219;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=iz/41luIKL60w0eEgIYe/CZhBoM70ZIQpYu84ZFvfdo=;
 b=ficaASuPhutWpcnF3fWmX6GJHxu94OQEdH5qMR+euujbl5t2idRj6MJg
 0+oSW6536K3cq5QCn2yljziD0n/+e1Gwh3MPOajUWSrFJIp8lqGIPosoc
 seChJkX2M62sfTg8gGDelTaFVGFc/8fuyCn7wiwlrGgpgw/2V3WYMMEga
 Rl1pmXjnNEFlqpKDOJALgl0HknLUy4mWOm+CEclHv0jfeZlBwvNg/aKh9
 UBaU6GgyhIxodk5Elhm93Dj7QP3DkW9+vixyxTNZrNBl7sAkHNqdrGgik
 xj/cf6+87TaIHXUVDXBPRMUOmybqR5KbFeuiAnUIaBlw+KJGv7l33ffjS g==;
X-CSE-ConnectionGUID: UeL18FS6QzuZO2CDSzFK4A==
X-CSE-MsgGUID: SKwQku1aSS29S5ihrgUm5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62274680"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="62274680"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 05:10:09 -0700
X-CSE-ConnectionGUID: 3URCPploRSe92Korzc/j5A==
X-CSE-MsgGUID: 99WH8TB0QGu/ffR1QKC2eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="173731201"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 05:10:06 -0700
Message-ID: <bcd6522e-7037-4422-9555-44d67a119b97@intel.com>
Date: Tue, 26 Aug 2025 20:10:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 16/19] hw/i386: move isapc machine to separate isapc.c
 file
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-17-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250822121342.894223-17-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.751, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/22/2025 8:12 PM, Mark Cave-Ayland wrote:
> Now that pc_init_isa() is independent of any PCI initialisation, move it into a
> separate isapc.c file. This enables us to finally fix the dependency of ISAPC on
> I440FX in hw/i386/Kconfig.
> 
> Note that as part of the move to a separate file we can see that the licence text
> is a verbatim copy of the MIT licence. The text originates from commit 1df912cf9e
> ("VL license of the day is MIT/BSD") so we can be sure that this was the original
> intent. As a consequence we can update the file header to use a SPDX tag as per
> the current project contribution guidelines.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD8FC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 16:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfMpA-0000p5-PG; Wed, 28 Feb 2024 11:30:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rfMp7-0000o4-Hj
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 11:30:25 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rfMp5-0002Gq-MP
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 11:30:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709137823; x=1740673823;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XWF3+dBBS9EOok61+0ZKnd1zVf0L8+4O443jR/wQhMk=;
 b=NGYJskWLN6KELQthFTeDkKaV/QhvY9qQKIppwcEdPpuGPesUW7hMGdcx
 rvKccOpUBmhrAOvs6ZIAYNWHNNfh6wQsniVY5xYDD+iZ1+sM1UbhsKkJ3
 Xe/l22l1+h6ADnzqQr+CL6IcMsQcJNa70oDKwzUn42r7NRvotjOv1hH4X
 99vACqY6xsnQCfzBcTP0po9LJx/1Ts5b4opAxqp8+CssGMLcmG8yPO0xI
 7bFakb887I/GhZb3LnfsCFInBd6XyNyqv4qQ26Qh7oqPBmjzi+UyTD3H5
 /f8ZqchkE4Mi5UnIz53SDRC5jzSXwUn0r+aTIrQJoiK4gov7NVgh6WOO3 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3712517"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3712517"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 08:30:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; d="scan'208";a="38328629"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 28 Feb 2024 08:30:16 -0800
Date: Thu, 29 Feb 2024 00:43:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Subject: Re: [RFC PATCH 4/5] hw/i386/q35: Wire virtual SMI# lines to ICH9
 chipset
Message-ID: <Zd9iz9aIwM3cOqwt@intel.com>
References: <20240226164913.94077-1-philmd@linaro.org>
 <20240226164913.94077-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226164913.94077-5-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Philippe,

> +/*
> + * Real ICH9 contains a single SMI output line and doesn't broadcast CPUs.
> + * Virtualized ICH9 allows broadcasting upon negatiation with guest, see
> + * commit 5ce45c7a2b.
> + */
> +enum {
> +    ICH9_VIRT_SMI_BROADCAST,
> +    ICH9_VIRT_SMI_CURRENT,
> +#define ICH9_VIRT_SMI_COUNT 2
> +};
> +

Just quick look here. Shouldn't ICH9_VIRT_SMI_COUNT be defined outside of
enum {}?

-Zhao



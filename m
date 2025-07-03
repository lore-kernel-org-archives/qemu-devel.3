Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D60C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 07:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXED0-0007O7-2Z; Thu, 03 Jul 2025 03:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXECt-0007Mp-UQ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:18:09 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXECp-0007GF-Pv
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751527083; x=1783063083;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=gVSmDn6dadFMZFYmEeJHA7ecHxg6HSPxUgwGHWgIW4Y=;
 b=iNwX0XCNTRxdH1cdKX8becnhWZJMiUGZhjpAlz8Osi9d2DNAHA+WqB4P
 6dnBm/x/prWkknrxEUW9bhHZU1C35IPzegPFWU7wjFxSWUhx+F7+Qh6JP
 Z+InYQbkFcxIuxrdUClbbtgrKSTtRbT2lzdhLxbP98yd/ClsmXeEgAHYT
 jFRzMbCQTZ4XYESQs3XfprZSXvbSvHc9LnMMpEcI47+l6knDJa0WqFDxv
 nIohgX6oehUXooBBPxg9RAuD/1SP5N8boBbfjgZN3N3e72iF/dAojz28X
 n4P/L3pEyv26AJwFqrmNq/wcG3c7+r1rBOBjSLExxlkujtHi0S36JB6r+ w==;
X-CSE-ConnectionGUID: tdvqT2d1Ryyn+psI/VcaGA==
X-CSE-MsgGUID: CZx8UKvBRMiUBgvz3QvDKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="65188065"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="65188065"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 00:18:00 -0700
X-CSE-ConnectionGUID: FAI4D8/oQSOLWFQ72zhtSw==
X-CSE-MsgGUID: JxEFckacSomB8SdkLRZXiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="185229199"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 03 Jul 2025 00:17:56 -0700
Date: Thu, 3 Jul 2025 15:39:22 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Pu Wen <puwen@hygon.cn>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH 02/16] i386/cpu: Add descriptor 0x49 for CPUID 0x2 encoding
Message-ID: <aGYzqrKldFwlbPoZ@intel.com>
References: <20250620092734.1576677-1-zhao1.liu@intel.com>
 <20250620092734.1576677-3-zhao1.liu@intel.com>
 <0b2a6fbe-6232-4e6a-8423-ab09f6d312b7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b2a6fbe-6232-4e6a-8423-ab09f6d312b7@linux.intel.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> > -    /* Descriptor 0x49 depends on CPU family/model, so it is not included */
> > +    /*
> > +     * Descriptor 0x49 has 2 cases:
> > +     *  - 2nd-level cache: 4 MByte, 16-way set associative, 64 byte line size.
> > +     *  - 3rd-level cache: 4MB, 16-way set associative, 64-byte line size
> > +     *    (Intel Xeon processor MP, Family 0FH, Model 06H).
> > +     *
> > +     * When it represents l3, then it depends on CPU family/model. Fortunately,
> > +     * the legacy cache/CPU models don't have such special l3. So, just add it
> > +     * to represent the general l2 case.
> 
> For comments and commit message, we'd better use the capital character
> "L2/L3" to represent the 2nd/3rd level cache which is more conventional. 

Sure.

> Others look good to me.
> 
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Thanks!



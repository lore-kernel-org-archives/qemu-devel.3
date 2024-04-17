Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA33C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 15:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx6lQ-0003bM-Bh; Wed, 17 Apr 2024 10:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rx6lP-0003bD-2s
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 10:59:55 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rx6lM-00061E-UE
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 10:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713365993; x=1744901993;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=hFxoYz8OFTAduk1qJEadGSlqTNmbCwLMPN3rP4CIP5o=;
 b=NlL/E5C80KacKdpxJOWORmXnosppldaR69X7g9suhuoKWKUimI6ah5uo
 TxCB08xRoQcAzpf7uJ/j+X2FwD40inTOaW5yUEYUfh1/0E34QReDc9TUf
 UdAf8EcsLburMGbK6MTMgnMrtH5iLZ3k9YlI52cRg3FrIOdYhvzBDpq1Q
 Afy0ZIFZBOZfy1E2x01rFermD0LspNb/GFhjsLmD+wNhayRkeSzrd92IN
 Ky+vyAXqnmSKtYrMV4/qa4vzJ6LWh2uBISUhs9fdQzJNwWkmd49hPUrCY
 kbZpxh03Akb1Q8ZbTWT4fwImFsPSBeFOmnoqzcI9fnXLvibaCCTFczQ7A Q==;
X-CSE-ConnectionGUID: b8bD35rIQbSihiMNAKYbMg==
X-CSE-MsgGUID: VOU7+BaMQQi0GSNtpxYckw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9032428"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="9032428"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2024 07:59:49 -0700
X-CSE-ConnectionGUID: B14wT2GaSUWREF7EScVLeQ==
X-CSE-MsgGUID: TKzeaDAlTtmRZfY7S3vkXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; d="scan'208";a="27084276"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 17 Apr 2024 07:59:48 -0700
Date: Wed, 17 Apr 2024 23:13:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Anthony Harivel <aharivel@redhat.com>, pbonzini@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, vchundur@redhat.com,
 rjarry@redhat.com
Subject: Re: [PATCH v5 3/3] Add support for RAPL MSRs in KVM/Qemu
Message-ID: <Zh/nMFpfKIORYW97@intel.com>
References: <20240411121434.253353-1-aharivel@redhat.com>
 <20240411121434.253353-4-aharivel@redhat.com>
 <Zh+fRliUJ8sPcOpD@intel.com> <Zh_AF3YfiZeIAkCU@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zh_AF3YfiZeIAkCU@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Hi Daniel,

On Wed, Apr 17, 2024 at 01:27:03PM +0100, Daniel P. Berrangé wrote:
> Date: Wed, 17 Apr 2024 13:27:03 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: Re: [PATCH v5 3/3] Add support for RAPL MSRs in KVM/Qemu
> 
> On Wed, Apr 17, 2024 at 06:07:02PM +0800, Zhao Liu wrote:
> > Hi Anthony,
> > 
> > May I ask what your usage scenario is? Is it to measure Guest's energy
> > consumption and to charged per watt consumed? ;-)
> > 
> > On Thu, Apr 11, 2024 at 02:14:34PM +0200, Anthony Harivel wrote:
> > > Date: Thu, 11 Apr 2024 14:14:34 +0200
> > > From: Anthony Harivel <aharivel@redhat.com>
> > > Subject: [PATCH v5 3/3] Add support for RAPL MSRs in KVM/Qemu
> > > 
> > > Starting with the "Sandy Bridge" generation, Intel CPUs provide a RAPL
> > > interface (Running Average Power Limit) for advertising the accumulated
> > > energy consumption of various power domains (e.g. CPU packages, DRAM,
> > > etc.).
> > >
> > > The consumption is reported via MSRs (model specific registers) like
> > > MSR_PKG_ENERGY_STATUS for the CPU package power domain. These MSRs are
> > > 64 bits registers that represent the accumulated energy consumption in
> > > micro Joules. They are updated by microcode every ~1ms.
> > 
> > What is your current target platform?
> 
> I think we can assume /all/ future CPUs are conceptially in scope
> for this.
> 
> The use case is to allow guest owners to monitor the power consumption
> of their workloads, so they can take steps to optimize their guest VM
> workloads to reduce power consumed.

Thanks for the explanation! 

> > On future Xeon platforms (EMR and beyond) RAPL will support TPMI (an MMIO
> > interface) and the TPMI based RAPL will be preferred in the future as
> > well:
> 
> Is the MSR based interface likely to be removed in future silicon,
> or it will be remain for back compat ?

For Xeon, GNR will have both TMPI & MSR RAPL, but eventually MSR RAPL
will be removed. Therefore, if RAPL support is desired for all future
Xeons, then it's necessary to consider TMPI as the next plan.

Alternatively, the whole RAPL scope can be split into rapl-msr and
rapl-tpmi features.

> > * TPMI doc: https://github.com/intel/tpmi_power_management
> > * TPMI based RAPL driver: drivers/powercap/intel_rapl_tpmi.c
> >

Regards,
Zhao



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC16C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 15:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7yHz-0005lg-8G; Thu, 24 Apr 2025 11:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7yHw-0005l1-B6; Thu, 24 Apr 2025 11:14:56 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7yHu-0008KM-Mm; Thu, 24 Apr 2025 11:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745507695; x=1777043695;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=NnaqS19Vj5IEgZGuniBgVWHY2Bm3xNzNuM4PHOb+jI0=;
 b=hxtCHNM/OVNfBu01oGiMwaXALP0qgywyd/UKla4TwN4Go7F0VePM53pJ
 iU1VrlwT5JbNMYAEivzg36iQxgrI8+wQRtzzQw0oFp1PqY/rdGwxAG7NS
 ODrOb6/JTCREuoynRkV6pTrcsmRMS+mwX4xbfTJ21gKiAH9drAyYQ69Na
 saU+rrOm+tBxyeTKVhyAG+2YunNbT9OqMzJa6qeHKGuiP3SK4KHJzQGWC
 xza+0TPbgI2D2di1hXmepkKDKTlEOZgCnv3feda2jXUOX/tIOXYSTRqTx
 bOPaOY9f/grWblZ6p61KZV/EsMATXc2FQ3eeIR8Qf66KmjDdWwRHxBf2b g==;
X-CSE-ConnectionGUID: rPp2TIKnRRGubvFwvBbs8w==
X-CSE-MsgGUID: gKdtoUftRMCyzMSTjQZLhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47035261"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; d="scan'208";a="47035261"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2025 08:14:52 -0700
X-CSE-ConnectionGUID: gU9yJX50QmeV2dpOjNeazQ==
X-CSE-MsgGUID: Oy1pJe+FTEGiowulyfquZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; d="scan'208";a="132637484"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 24 Apr 2025 08:14:47 -0700
Date: Thu, 24 Apr 2025 23:35:43 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>
Subject: Re: [PATCH 5/5] i386/kvm: Support fixed counter in KVM PMU filter
Message-ID: <aApaT9Tj4ycdtNLH@intel.com>
References: <20250409082649.14733-1-zhao1.liu@intel.com>
 <20250409082649.14733-6-zhao1.liu@intel.com>
 <c800f523-2b1e-4f0a-b553-eb5a717e617b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c800f523-2b1e-4f0a-b553-eb5a717e617b@linux.intel.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

> >  /**
> >   * KVMPMUFilter:
> > - * @action: action that KVM PMU filter will take for selected PMU events.
> > + * @action: action that KVM PMU filter will take for selected PMU events
> > + *    and counters.
> 
> Maybe more accurate "fixed counters".

Yes, will fix.

Thanks,
Zhao



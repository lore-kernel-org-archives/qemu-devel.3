Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD7ACCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 07:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8CiW-0005p7-OL; Mon, 13 Oct 2025 03:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8CiP-0005iN-Rk
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 03:11:31 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8CiM-0003bs-Bg
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 03:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760339486; x=1791875486;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=M2Q7qIm8s1tX8Cfy27fSVfpbtAGIBwPTsmRQVLTKYgs=;
 b=mMfRG9fPJuIYX+SZY1z3+b1M/gBWZvUFvjbspzHpXlY1Dk6ExODZfLHz
 HLybOfQr3NcVDamOB0MMOJBFCL6Hf4SyFEruPpppeYkcppvtavwUxJenI
 zfmLV2iGZfQ2uIPvwLpw8+yAjauE7s9bTobV9da+vHJSWfwmxcMi1KLuc
 hjmSm5LF0o5cbxe4QlZ+HDIx1gVYSF/f1ugCZnQeKMJCFq4b+NTKLQecC
 Zei/VZkrmfYZOIWATAkzh+k39CPcg1E1QHK0uLlISj6owLYT+Mjndrt3i
 uZ3cmpGVWZHXtTyfK4TbUSLLJJI7UYOulN17nhu83TEZNHvf+Q4WFblqp w==;
X-CSE-ConnectionGUID: Y59IcQpsS26IpFPab/dh9Q==
X-CSE-MsgGUID: mj3ZivS6RiC7So2BX2jCgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="66326742"
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="66326742"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 00:11:21 -0700
X-CSE-ConnectionGUID: ZKVcirKKShuVpruUzj+HVg==
X-CSE-MsgGUID: mjOFIC6rSm+e4ojnOa/P2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="181951775"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 13 Oct 2025 00:11:17 -0700
Date: Mon, 13 Oct 2025 15:33:22 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH v9 02/21] hw/core/machine: Support modules in -smp
Message-ID: <aOyrQl4WqqU0wVc4@intel.com>
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
 <20240227103231.1556302-3-zhao1.liu@linux.intel.com>
 <87plwgzzc4.fsf@pond.sub.org> <87jz14qp57.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jz14qp57.fsf@pond.sub.org>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Oct 09, 2025 at 01:40:36PM +0200, Markus Armbruster wrote:
> Date: Thu, 09 Oct 2025 13:40:36 +0200
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [PATCH v9 02/21] hw/core/machine: Support modules in -smp
> 
> Markus Armbruster <armbru@redhat.com> writes:
> 
> > Zhao Liu <zhao1.liu@linux.intel.com> writes:
> >
> >> From: Zhao Liu <zhao1.liu@intel.com>
> >>
> >> Add "modules" parameter parsing support in -smp.
> >>
> >> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> >> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> >> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> >
> > QAPI schema
> > Acked-by: Markus Armbruster <armbru@redhat.com>
> 
> I missed something.  The patch added @modules without updating "The
> ordering from ...":
> 
>     ##
>     # @SMPConfiguration:
>     #
>     # Schema for CPU topology configuration.  A missing value lets QEMU
>     # figure out a suitable value based on the ones that are provided.
>     #
>     # The members other than @cpus and @maxcpus define a topology of
>     # containers.
>     #
> --> # The ordering from highest/coarsest to lowest/finest is: @drawers,
> --> # @books, @sockets, @dies, @clusters, @cores, @threads.
> 
> Where does it go in this list?
> 
> The order below suggests between @clusters and @modules.

Thanks Markus! I missed this case... sorry for that.

And you're right, @module is between @clusters and @modules.

I'll submit a patch to fix this doc!

Regards,
Zhao



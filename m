Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75246E67493
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 02:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6hZU-0004tK-R4; Thu, 31 Oct 2024 22:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6hZT-0004su-9d
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 22:39:31 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6hZN-0006aF-LV
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 22:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730428765; x=1761964765;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=BN5PTXd3QQtHaueKoRPQp6OLDirBsWc8JpwO1ja9xvA=;
 b=DINjNvUWTcHL3aGxeu12Ckg4HA6qTq0zkUxfrqdfnVpRG/cwIEEBVAKi
 RxC3+DFEE4oRWbFFDgYTCIQfOTx6ZhIs85Nr7IQhBE7ZEzGQT+MGf6qLP
 BprOEQicyjWU8K2mqdnRouOz3/QUNurXe+lAx2MoOhXgXvZRM6KaER9W5
 KZYDkbt6I2gbG821slCB0NYMeU5NH1yO8yN3y0gGnQ9DrEgFEhxnaaICV
 kprhc4vOHJg8drsdvSodT12+YQ2ndyPp+TJ7ZJefO68HN8qsaFladQGBY
 HRecAeLF67Cw3/+/tZixk0q+OHi+qn6iZHtaW2SaBzXDK39ILnrH4V524 Q==;
X-CSE-ConnectionGUID: GFSdhlk+SGOs6I1ylxguTw==
X-CSE-MsgGUID: 9bHL7LXrSaSaTVnk8vlGLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="33025812"
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; d="scan'208";a="33025812"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 19:39:24 -0700
X-CSE-ConnectionGUID: EysHHiLeRhS6iMHWIuJd1Q==
X-CSE-MsgGUID: dpIGOigrQsqt63/yrQPwyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; d="scan'208";a="82937913"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 31 Oct 2024 19:39:22 -0700
Date: Fri, 1 Nov 2024 10:57:12 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 xiaoyao.li@intel.com, xuelian.guo@intel.com
Subject: Re: [PATCH v3 4/8] target/i386: add AVX10 feature and AVX10 version
 property
Message-ID: <ZyRDiGrEt5q2LIsC@intel.com>
References: <20241031085233.425388-1-tao1.su@linux.intel.com>
 <20241031085233.425388-5-tao1.su@linux.intel.com>
 <ZyO1vL0o0SxgcW8q@intel.com> <ZyQ4RzWX4oJB3vP0@linux.bj.intel.com>
 <ZyRAhxjaeizc+FWm@intel.com> <ZyQ9cNUgUMyekQu7@linux.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyQ9cNUgUMyekQu7@linux.bj.intel.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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

On Fri, Nov 01, 2024 at 10:31:12AM +0800, Tao Su wrote:
> Date: Fri, 1 Nov 2024 10:31:12 +0800
> From: Tao Su <tao1.su@linux.intel.com>
> Subject: Re: [PATCH v3 4/8] target/i386: add AVX10 feature and AVX10
>  version property
> 
> On Fri, Nov 01, 2024 at 10:44:23AM +0800, Zhao Liu wrote:
> > > > prefix is just used to print warning. So here we should check prefix
> > > > for warn_report.
> > > > 
> > > > +    } else if (env->avx10_version) {
> > > > +        if (prefix) {
> > > > +            warn_report("%s: avx10.%d.", prefix, env->avx10_version);
> > > > +        }
> > > > +        have_filtered_features = true;
> > > > +    }
> > > > 
> > > 
> > > Yes, thanks for pointing out! But I see this patch set is already pulled,
> > > not sure whether it is easy to change...
> > 
> > I will soon have another clean-up series, and I can include this part.
> > You can send me your patch, or I can help you with it.
> 
> Please help me do that, thanks! :-)

Sure, you're welcome.



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462F9E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 07:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR4qf-0001VM-GB; Fri, 27 Dec 2024 02:33:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tR4qY-0001SN-Hn
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 02:33:22 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tR4qT-0007W4-Cg
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 02:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735284798; x=1766820798;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=yLtoRpF3QQSBZfUkBIn1B8vhrsXk6+XDEgdVErVZt+4=;
 b=hbrafGZmQLUUOnIT3Ii6x7nuyG2uPgzTZA0dKfd1rcHgM2M9SMeIuwsa
 Lh6dCg2NwPkuHSGRvqRWovYrK/Gi2X1JzgJBnpU+agc9s0aDLbtsZYRKL
 4O5rIR4x8M37v4p8yefjO5gSIgC4Zk3Xl/MuTyTwEYOLoF3zFNTR4VKiE
 aC/PB6Yh7uYBV4pO55RIzsgEyLk/e9GrCV9WpbHJK+y5YhMObzIvwdOQ7
 bxNhkC2An9+1tIldfts5tpwDz3Bw36mFSPoLvUHZMplGAkFgKraMHZsy6
 KD5xNHnkEhM5Bk7UjbQKGuD1moT/hQAZ07KjOjAEdz1Urzil+9w1fdMfX A==;
X-CSE-ConnectionGUID: 9x6doJ8zTgCCDLBq9AhK3Q==
X-CSE-MsgGUID: npkdznOlRACQcokkhQyELg==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46688270"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; d="scan'208";a="46688270"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Dec 2024 23:33:15 -0800
X-CSE-ConnectionGUID: YksTyw47REmNzQZvvJeP7A==
X-CSE-MsgGUID: IFEriWCmSk+d2xKPZaLYaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="123370959"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 26 Dec 2024 23:33:12 -0800
Date: Fri, 27 Dec 2024 15:51:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v2 05/10] i386/topology: Introduce helpers for various
 topology info of different level
Message-ID: <Z25cmxkmzQ9cXash@intel.com>
References: <20241219110125.1266461-1-xiaoyao.li@intel.com>
 <20241219110125.1266461-6-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219110125.1266461-6-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

> +static inline unsigned x86_module_per_pkg(X86CPUTopoInfo *topo_info)
> +{
> +    return topo_info->modules_per_die * topo_info->dies_per_pkg;
> +}
> +
> +static inline unsigned x86_cores_per_pkg(X86CPUTopoInfo *topo_info)
> +{
> +    return topo_info->cores_per_module * x86_module_per_pkg(topo_info);
> +}

The above helpers can be ignored this time until someone wants them...

> +static inline unsigned x86_threads_per_pkg(X86CPUTopoInfo *topo_info)
> +{
> +    return topo_info->threads_per_core * x86_cores_per_pkg(topo_info);
> +}

...then this can be x86_threads_per_die(topo_info) * topo_info->dies_per_package

> +static inline unsigned x86_threads_per_module(X86CPUTopoInfo *topo_info)
> +{
> +    return topo_info->threads_per_core * topo_info->cores_per_module;
> +}
> +
> +static inline unsigned x86_threads_per_die(X86CPUTopoInfo *topo_info)
> +{
> +    return x86_threads_per_module(topo_info) * topo_info->modules_per_die;
> +}
> +
> 


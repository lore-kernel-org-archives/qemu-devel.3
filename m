Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF203CA101C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2024 11:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skLzV-00087n-9T; Sat, 31 Aug 2024 07:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1skLzS-00085q-Fc; Sat, 31 Aug 2024 07:09:58 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1skLzQ-0006ho-M7; Sat, 31 Aug 2024 07:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1725102597; x=1756638597;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GeFmjRo6ovAqbJc/4sXjpF8sL+OE9yB0GSRNK7fT034=;
 b=fnYv/l4XT6kFFgM+XeCsqCiZ5WLySF3S+e/TCAKEUR2nZOHjEs7cVu4b
 mbOoxGfKxj5M2B951z7UtBCG/YfrFiSxeWfzQt+TXe3khnFcftsUEbs5X
 AgBb/yTNGGnGhdZH1JFnuWaMz5M+skgGCWWVuYRVaf9dUnYGc7TklGG6B
 zT64gw+DoE8YqNYrZ9GgAAs6/mUUB1RtdAfzdy/jwG0ky43CJCd3/Cdgh
 yyElL1rNByXxIfw1yu9Mn+5d1wZEON/S5B5ba2C5boDLstwi4KSRVQ6TU
 YbkZcbYtq1KO43LPJQI3FOEOKimsfOO37E4LXJjcVop63PcRWSh3dkyKK Q==;
X-CSE-ConnectionGUID: ySK9ROQGRf+pZTmyci+9Pw==
X-CSE-MsgGUID: fffcSp++SmymVMWJAfaRTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23624051"
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; d="scan'208";a="23624051"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2024 04:09:54 -0700
X-CSE-ConnectionGUID: GbTpwj/KQdmbDxdAcfokXg==
X-CSE-MsgGUID: AgG4nL6BTOK2AA8QNW9Kow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; d="scan'208";a="64191183"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 31 Aug 2024 04:09:49 -0700
Date: Sat, 31 Aug 2024 19:25:47 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, zhenyu.z.wang@intel.com,
 dapeng1.mi@linux.intel.com, yongwei.ma@intel.com, armbru@redhat.com,
 farman@linux.ibm.com, peter.maydell@linaro.org, mst@redhat.com,
 anisinha@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com,
 mtosatti@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, linuxarm@huwei.com,
 shameerali.kolothum.thodi@huawei.com, Jonathan.Cameron@huawei.com,
 jiangkunkun@huawei.com, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC PATCH 0/2] Specifying cache topology on ARM
Message-ID: <ZtL9u9kQcx0GtEKq@intel.com>
References: <20240823125446.721-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823125446.721-1-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Alireza,

Great to see your Arm side implementation!

On Fri, Aug 23, 2024 at 01:54:44PM +0100, Alireza Sanaee wrote:
> Date: Fri, 23 Aug 2024 13:54:44 +0100
> From: Alireza Sanaee <alireza.sanaee@huawei.com>
> Subject: [RFC PATCH 0/2] Specifying cache topology on ARM
> X-Mailer: git-send-email 2.34.1
> 

[snip]

> 
> The following command will represent the system.
> 
> ./qemu-system-aarch64 \
>  -machine virt,**smp-cache=cache0** \
>  -cpu max \
>  -m 2048 \
>  -smp sockets=2,clusters=1,cores=2,threads=2 \
>  -kernel ./Image.gz \
>  -append "console=ttyAMA0 root=/dev/ram rdinit=/init acpi=force" \
>  -initrd rootfs.cpio.gz \
>  -bios ./edk2-aarch64-code.fd \
>  **-object '{"qom-type":"smp-cache","id":"cache0","caches":[{"name":"l1d","topo":"core"},{"name":"l1i","topo":"core"},{"name":"l2","topo":"cluster"},{"name":"l3","topo":"socket"}]}'** \
>  -nographic

I plan to refresh a new version soon, in which the smp-cache array will
be integrated into -machine totally. And I'cc you then.

Regards,
Zhao



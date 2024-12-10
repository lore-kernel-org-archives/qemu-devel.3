Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11315E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2h5-00008i-Tk; Tue, 10 Dec 2024 11:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tL2h3-00008I-L5
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:02:38 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tL2h1-0003zn-Dd
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733846556; x=1765382556;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=sstZsmT0WfDiNXZ6P9Im73TSWOcO+CICCOPeDhjlfeM=;
 b=UCTYiBdll0RlNRqV0jjaL81eucT96JQQAErQi3fiZxRBMt1laGpVXO22
 30OsV4kCV51r1QpbM4wp+T1lFf8iqWj/jSb4ZVTofTuYB7AbPLeuPVO2t
 4D2EsOkX2rOXQDicFyBjfXAQmX1uiq3pE4kH7KqQxpQqspZTxWsDQF89v
 FILVOCQw57zIWSA+7UzIQGVyM0HAiPAwD29s7pD61oBQY0E3kdJm608Kt
 L+yTXmbqoPEKVPjsPf18dGeYKJbWQ9DjU+M9hMdGtJgPgnjCbTQ1xFU6W
 TVMCNntzNQ37+g6qZHbzzcQpJfyIqmDFhr+HYcv0i2yJYL0prb24QTM5J w==;
X-CSE-ConnectionGUID: bzRVSh6qTiKhUHWV4beX6Q==
X-CSE-MsgGUID: 5jsUCU1FSfWdepKPXG8Y0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="44805495"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; d="scan'208";a="44805495"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2024 08:02:33 -0800
X-CSE-ConnectionGUID: A9seGaktQomJm4WhPfFJMw==
X-CSE-MsgGUID: KEucCcVkRoOmpzgzbRriLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; d="scan'208";a="95154509"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 10 Dec 2024 08:02:31 -0800
Date: Wed, 11 Dec 2024 00:20:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 00/16] qom/object: Deprecate type_register()
Message-ID: <Z1hqXesuVF93B36S@intel.com>
References: <20241029085934.2799066-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029085934.2799066-1-zhao1.liu@intel.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
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

Hi Paolo and Dainel,

Kindly ping. Do you agree with this idea?

Thanks,
Zhao

On Tue, Oct 29, 2024 at 04:59:18PM +0800, Zhao Liu wrote:
> Date: Tue, 29 Oct 2024 16:59:18 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: [PATCH 00/16] qom/object: Deprecate type_register()
> X-Mailer: git-send-email 2.34.1
> 
> Hi maintainers,
> 
> This series is trying to deprecate type_register() and just keep
> type_register_static() to register QOM type.
> 
> This series chosen to deprecate type_register() since changes required
> to deprecate type_register() are smaller. (type_register_static() needs
> 1000+ LOC changes.)
> 
> The two main changes are patch 15 and 16, while the others are trivial
> replacements.
> 
> This series is based on commit fdf250e5a37830 ("Merge tag
> 'pull-maintainer-oct-misc-241024-1' of https://gitlab.com/stsquad/qemu
> into staging").
> 
> 
> Introduction
> ============
> 
> The type_register() and type_register_static() have existed since the
> birth of QOM (commit 2f28d2ff9dce ("qom: add the base Object class
> (v2)")).
> 
> In the code implementation, type_register_static() has always been just
> a wrapper around type_register(), and they are essentially the same.
> 
> The only difference between them is described in the documentation 
> (include/qom/object.h):
> 
> * type_register_static()
> 
> > @info and all of the strings it points to should exist for the life time
> > that the type is registered.
> 
> * type_register()
> 
> > Unlike type_register_static(), this call does not require @info or its
> > string members to continue to exist after the call returns.
> 
> From the documentation, the difference between these two interfaces
> arises from the lifetime of 2 cases:
> 
> 1. the strings contained in the TypeInfo parameter.
> 
> The *_static variant requires the strings to have a long lifetime
> (static).
> 
> I reviewed the discussions on the mailing list about the QOM v1 patch
> [1], and I understand that the consideration for static is due to
> Anthony's idea that in certain cases, the string field could be "const
> char *", allowing the address to be directly copied to the created
> Type/TypeImpl.
> 
> However, this consideration seems unnecessary in the merged v2 version,
> as Anthony followed Paolo's suggestion to pass all string fields by
> copying them via g_strdup() to the created TypeImple. This remains true
> to this day.
> 
> [1]: https://lore.kernel.org/qemu-devel/4EF1EEA4.40209@us.ibm.com/
> 
> 
> 2. the function pointer and a special item called "class_data" in
> TypeInfo
> 
> I suppose that there are currently no lifetime issues about these items
> in QEMU, as neither type_register() nor type_register_static()
> explicitly checks whether the parameters are static. If there were any
> issues, they would likely be easily detected.
> 
> Furthermore, I haven't seen any preference for these items in the usage
> of type_register() and type_register_static().
> 
> 
> Based on points 1 and 2, I think it is sufficient to explain that
> type_register() and type_register_static() are redundant in usage and do
> not require distinction. Additionally, since they are consistent in the
> code, it is safe to deprecate either one.
> 
> Since the changes required to deprecate type_register() are smaller,
> choose to deprecate type_register() and delete the requirement about
> string lifetime from the documentation.
> 
> 
> Thanks and Best Regards,
> Zhao
> ---
> Zhao Liu (16):
>   arm: Replace type_register() with type_register_static()
>   hw/block: Replace type_register() with type_register_static()
>   hw/net: Replace type_register() with type_register_static()
>   ppc: Replace type_register() with type_register_static()
>   hw/rtc: Replace type_register() with type_register_static()
>   hw/scsi: Replace type_register() with type_register_static()
>   hw/sensor: Replace type_register() with type_register_static()
>   hw/usb: Replace type_register() with type_register_static()
>   hw/virtio: Replace type_register() with type_register_static()
>   i386: Replace type_register() with type_register_static()
>   target/mips: Replace type_register() with type_register_static()
>   target/sparc: Replace type_register() with type_register_static()
>   target/xtensa: Replace type_register() with type_register_static()
>   ui: Replace type_register() with type_register_static()
>   script/codeconverter/qom_type_info: Deprecate MakeTypeRegisterStatic
>     and MakeTypeRegisterNotStatic
>   qom/object: Deprecate type_register()
> 
>  hw/arm/armsse.c                               |  2 +-
>  hw/arm/smmuv3.c                               |  4 ++--
>  hw/block/m25p80.c                             |  2 +-
>  hw/net/e1000.c                                |  2 +-
>  hw/net/eepro100.c                             |  2 +-
>  hw/ppc/spapr.c                                |  2 +-
>  hw/rtc/m48t59-isa.c                           |  2 +-
>  hw/rtc/m48t59.c                               |  2 +-
>  hw/scsi/megasas.c                             |  2 +-
>  hw/scsi/mptsas.c                              |  2 +-
>  hw/sensor/tmp421.c                            |  2 +-
>  hw/usb/hcd-ehci-pci.c                         |  2 +-
>  hw/usb/hcd-uhci.c                             |  2 +-
>  hw/virtio/virtio-pci.c                        |  8 ++++----
>  include/hw/i386/pc.h                          |  4 ++--
>  include/qom/object.h                          | 14 -------------
>  qom/object.c                                  |  7 +------
>  .../codeconverter/qom_type_info.py            | 20 -------------------
>  target/arm/cpu.c                              |  2 +-
>  target/arm/cpu64.c                            |  2 +-
>  target/i386/cpu.c                             |  2 +-
>  target/mips/cpu.c                             |  2 +-
>  target/ppc/kvm.c                              |  2 +-
>  target/sparc/cpu.c                            |  2 +-
>  target/xtensa/helper.c                        |  2 +-
>  ui/console-vc.c                               |  2 +-
>  ui/dbus.c                                     |  2 +-
>  ui/gtk.c                                      |  2 +-
>  ui/spice-app.c                                |  2 +-
>  29 files changed, 32 insertions(+), 71 deletions(-)
> 
> -- 
> 2.34.1
> 


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B3AD2595A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 08:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkeEP-00066A-3v; Tue, 27 Jan 2026 03:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vkeEN-00065g-Rd; Tue, 27 Jan 2026 03:15:23 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vkeEL-0006Ph-Ao; Tue, 27 Jan 2026 03:15:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769501721; x=1801037721;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=s9p19Gep8pJ9I3Pc8+moCbbXkXu8Op5D08Qgdj0PsKc=;
 b=Sfd0u4YNfhYGgRINsgzxgHm+6RWV+2dHiNivxn44anNHbiiXXZjzUX7F
 MxSPFP9Dn3hb2n9fZ9nd6O7vqDcy8s6Kbh4lJhImqyxLSbo7tO/Jhrl5N
 J+x+5Fo3jTG/geafNqlFBPoZN62e6uom5TyAGyP23fgljUxlpuSL7+nm8
 Rix6DHC3sedzGHUOcI6KvRBSdSK2U4N7bA3+7cwuwulazkvtc9vxidNgN
 JG+CZQ+bPdPTPicamSHLvxJhy1YfsmA9CivYptOX4C9vzladmaIU7kqMc
 EzFKzoV8FITOwC1JsDFL+MjdkWQOd54ISXqk5yBBuQX12O/voXhdtVYz9 g==;
X-CSE-ConnectionGUID: Rvgc0/gaSRCgZYd3TvuOVg==
X-CSE-MsgGUID: K/eXZvbPQouX9MVhO8mykw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70593384"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; d="scan'208";a="70593384"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2026 00:15:16 -0800
X-CSE-ConnectionGUID: +3W+5fAaQeOgy+508u6iSg==
X-CSE-MsgGUID: lOTUmowPRuqT8PHes5LUjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; d="scan'208";a="239180328"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 27 Jan 2026 00:15:13 -0800
Date: Tue, 27 Jan 2026 16:40:48 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, Paolo Bonzini <pbonzini@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 18/27] hw/core/machine: add '-hw-dtb' option for machine
Message-ID: <aXh6EHwejpTVoYXY@intel.com>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
 <20260126174313.1418150-19-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126174313.1418150-19-ruslichenko.r@gmail.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

>  static char *machine_get_dumpdtb(Object *obj, Error **errp)
>  {
>      MachineState *ms = MACHINE(obj);
> @@ -1287,6 +1301,11 @@ static void machine_initfn(Object *obj)
>      ms->ram_size = mc->default_ram_size;
>      ms->maxram_size = mc->default_ram_size;
>  
> +    object_property_add_str(obj, "hw-dtb",
> +                            machine_get_hw_dtb, machine_set_hw_dtb);

What about object_class_property_add_str()? It seems this property
doesn't depend on any other state, so I think it could be at class
level, just like "dtb" did.

> +    object_property_set_description(obj, "hw-dtb",
> +                    "A device tree used to describe the hardware to QEMU.");

maybe "A device tree binary used to describe the hardware to QEMU"?

and none of the other machine property descriptions have 'periods'.

> +
>      if (mc->nvdimm_supported) {
>          ms->nvdimms_state = g_new0(NVDIMMState, 1);
>          object_property_add_bool(obj, "nvdimm",


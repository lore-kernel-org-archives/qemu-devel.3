Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B180FD68BCB
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 07:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW8N2-0005cd-Io; Thu, 18 Dec 2025 02:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vW8N0-0005bt-Hm; Thu, 18 Dec 2025 02:24:18 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vW8My-0002Ec-PG; Thu, 18 Dec 2025 02:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766042657; x=1797578657;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7DwI0Qs8ZZROCxgks932LOqBfATLVNdCypOv4og2tA4=;
 b=LM2DOk0UNm7pkuByOF6hohpXy4V/D18Cgi5FA2DvLDVji1xwEsmVwl9V
 MozKuJ60R0YIENc9/y/KZJ6+fRc79wCp1wE86LcI1q1WK4kDJYQMiqZNj
 QNyegzmueElo8A1WuF7cyu2aPtqCbafm7fSFDAmq3ilQPpuwFjMD2zP7y
 Tgw+pWYd8yAJZaRdAjeCYV7zP3PiL7Li6VCAn0qzXdbO7jXB0qTSbfUY7
 oYnzR6SqeTK9b3fMGW0tXxsexzCKBfVq5Oums1OJEPdJA7cDIBz7szt3S
 H6vP+ytWComBVuIg+kEsc63bOU0I7Dqa/HmvG4hr9c1jKV0Kgtygo/FWr Q==;
X-CSE-ConnectionGUID: NbO/Ua8YS5aUt+bL2g+g0A==
X-CSE-MsgGUID: FJ3spxspQsGfmtNTmfU2jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="67960035"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="67960035"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 23:24:14 -0800
X-CSE-ConnectionGUID: sxbUkqeGSCCx2CAtSkrTbQ==
X-CSE-MsgGUID: oV8BMOWXTn2tBLC3VqwuDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="202898882"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 17 Dec 2025 23:24:06 -0800
Date: Thu, 18 Dec 2025 15:48:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?iso-8859-1?Q?Cl=E9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Peter Krempa <pkrempa@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>
Subject: Re: [PATCH v5 07/28] tests/acpi: Update DSDT tables for pc machine
Message-ID: <aUOx5wor+ysd2lNo@intel.com>
References: <20251202162835.3227894-1-zhao1.liu@intel.com>
 <20251202162835.3227894-8-zhao1.liu@intel.com>
 <20251217151627.3ee7bf07@imammedo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217151627.3ee7bf07@imammedo>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
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

On Wed, Dec 17, 2025 at 03:16:27PM +0100, Igor Mammedov wrote:
> Date: Wed, 17 Dec 2025 15:16:27 +0100
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH v5 07/28] tests/acpi: Update DSDT tables for pc machine
> X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
> 
> On Wed,  3 Dec 2025 00:28:14 +0800
> Zhao Liu <zhao1.liu@intel.com> wrote:
> 
> > Now the legacy cpu hotplug way has gone away, and there's no _INIT
> > method in DSDT table for modern cpu hotplug support.
> > 
> > Update DSDT tables for pc machine.
> > 
> > The following diff changes show only _INIT methods are removed from DSDT
> > tables.
> > 
> 
> below diff in commit message confuses git am,
> I'd suggests to point out only what's deleted  
> and skip the rest, aka.
> removed section in x86 DSDTs:
>   -
>   -            Method (_INI, 0, Serialized)  // _INI: Initialize
>   -            {
>   -                CSEL = Zero
>   -            }
> 
> ditto for blurb in the next patch

Yes, good idea. Indeed, this nearly duplicated information makes the
commit message quite lengthy, so I had to split it into two patches.

Will merge these 2 patches (this patch and next patch).

Thanks,
Zhao


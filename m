Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3237AD68BE6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 07:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW8Qt-0007NS-6a; Thu, 18 Dec 2025 02:28:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vW8Ql-0007Md-Gm; Thu, 18 Dec 2025 02:28:11 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vW8Qh-00032K-G0; Thu, 18 Dec 2025 02:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766042888; x=1797578888;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=hWNeVMjmF8yETmL2iScc7y+Xsno1MZFc4t4eczNLXrY=;
 b=QsdMLGBdBHXysHo0X1nqIlHeNF1yV3Cx0e4xAnlXcy2MlohTRm/baMGj
 k/CrxK2538yEOsYDHMSiVfzyaGQ8o5rWYLjtniQ4GRAaaPcYckHX65ni5
 JxQKXELvh5JRUv3OstzVGMikuTcO6c9vyxxHNIP4pNfja/LxpTA7HhZB6
 bQ2PpmdlBX+UQpsAys2EQ5D4g7TkUuXSeJ6m7G3GLvvxzXOf4JthBtYSC
 lGBqBLwzm1O0zS4wWzI5Qn/3mWOvyjjC7PlSLbkjPm/y8OACBYF0cFfEt
 B7Id0h+5rYSJlMZ3+XtS+ScIxZUpD6LIOhUfSJtSfDdD/h6cNk4hkVoWx w==;
X-CSE-ConnectionGUID: 3C8WZCnUSsOjbEVI02Vetw==
X-CSE-MsgGUID: zpVkJJ+BT5iVY/WPpUxDyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="71622090"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="71622090"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 23:28:04 -0800
X-CSE-ConnectionGUID: v88tZuomTSO56nWrPX/fYg==
X-CSE-MsgGUID: ulShamx1RQqj9xlNDkLIiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="229575059"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 17 Dec 2025 23:27:55 -0800
Date: Thu, 18 Dec 2025 15:52:45 +0800
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
Subject: Re: [PATCH v5 03/28] pc: Start with modern CPU hotplug interface by
 default
Message-ID: <aUOyzVHm+mt1pCfL@intel.com>
References: <20251202162835.3227894-1-zhao1.liu@intel.com>
 <20251202162835.3227894-4-zhao1.liu@intel.com>
 <20251217143237.7829af2e@imammedo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217143237.7829af2e@imammedo>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
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

On Wed, Dec 17, 2025 at 02:32:37PM +0100, Igor Mammedov wrote:
> Date: Wed, 17 Dec 2025 14:32:37 +0100
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH v5 03/28] pc: Start with modern CPU hotplug interface
>  by default
> X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
> 
> On Wed,  3 Dec 2025 00:28:10 +0800
> Zhao Liu <zhao1.liu@intel.com> wrote:
> 
> > From: Igor Mammedov <imammedo@redhat.com>
> ^^^
> given you resplit original patch, it's better to replace this with you,
> keeping my SoB is sufficient

Thank you! Will re-organize these signatures

> > For compatibility reasons PC/Q35 will start with legacy CPU hotplug
> > interface by default but with new CPU hotplug AML code since 2.7
> > machine type (in commit 679dd1a957df ("pc: use new CPU hotplug interface
> > since 2.7 machine type")). In that way, legacy firmware that doesn't use
> > QEMU generated ACPI tables was able to continue using legacy CPU hotplug
> > interface.
> > 
> > While later machine types, with firmware supporting QEMU provided ACPI
> > tables, generate new CPU hotplug AML, which will switch to new CPU
> > hotplug interface when guest OS executes its _INI method on ACPI tables
> > loading.
> > 
> > Since 2.6 machine type is now gone, and consider that the legacy BIOS
> > (based on QEMU ACPI prior to v2.7) should be no longer in use, previous
> > compatibility requirements are no longer necessary. So initialize
> > 'modern' hotplug directly from the very beginning for PC/Q35 machines
> > with cpu_hotplug_hw_init(), and drop _INIT method.
> > 
> > Additionally, remove the checks and settings around cpu_hotplug_legacy
> > in cpuhp VMState (for piix4 & ich9), to eliminate the risk of
> > segmentation faults, as gpe_cpu no longer has the opportunity to be
> > initialized. This is safe because all hotplug now start with the modern
> > way, and it's impossible to switch to legacy way at runtime (even the
> > "cpu-hotplug-legacy" properties does not allow it either).
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> tested ping pong cross version (master vs master+this patch) migration
> with 10.1 machine type, nothing is broken, hence
> 
> Acked-by: Igor Mammedov <imammedo@redhat.com>

Thanks for your test and review!

Regards,
Zhao



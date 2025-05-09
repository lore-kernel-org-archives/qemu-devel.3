Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A8EC3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 10:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDKhK-0007YY-86; Fri, 09 May 2025 06:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uDKhH-0007Wo-El; Fri, 09 May 2025 06:11:15 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uDKhF-0001b8-N2; Fri, 09 May 2025 06:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746785474; x=1778321474;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=DYzgfmr2nHUFnRtfKx2VUV7W2FkMFo4CpLIHKoL2k0I=;
 b=LCwinC2BbEhFPn4fpJFHI11N/cD/mejWq6aKk6qeb6xHU9iikF/Qd/Dl
 pXLKtmWQd/of8Q9sWphsv5MAsd19gVhozzGws2XScj5dYhzbyCqCRdy8/
 BZ67/zy6snE1wfGMJYvuW8usFIGh4RHz+TxgvoSPVDkTyvUgqNM/hQWWG
 HXWx7EJUd3EDUjwzCflmrHsu5foDMUGAyE0acC13wFTfvpCSOZQlDyuzm
 cYxmjMm34WtOltdbGzhuIz0HwLALIepVAKuZz6xbRjm33SF/NDvr3e583
 Qz0bVaOKnhxbwdbEdpKnVC89y0CCYSskcoLaG9CRsvZtTjhefx5M4/bF0 g==;
X-CSE-ConnectionGUID: Xpb41upyQ1yAvxMVCkmF9g==
X-CSE-MsgGUID: 0AaCUsluRaWIG7TKWM0XeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="66013414"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="66013414"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 03:11:10 -0700
X-CSE-ConnectionGUID: HKEkuJfoTV22rXlvJht/zw==
X-CSE-MsgGUID: 34wmXNVFQ0SpQaxijdq0mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="137577882"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 09 May 2025 03:11:02 -0700
Date: Fri, 9 May 2025 18:32:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Sergio Lopez <slp@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu <yi.l.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Yanan Wang <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?iso-8859-1?Q?Cl=E9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v4 24/27] hw/intc/ioapic: Remove
 IOAPICCommonState::version field
Message-ID: <aB3Zpc45+/OZ7hq2@intel.com>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-25-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250508133550.81391-25-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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

On Thu, May 08, 2025 at 03:35:47PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  8 May 2025 15:35:47 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v4 24/27] hw/intc/ioapic: Remove IOAPICCommonState::version
>  field
> X-Mailer: git-send-email 2.47.1
> 
> The IOAPICCommonState::version integer was only set
> in the hw_compat_2_7[] array, via the 'version=0x11'
> property. We removed all machines using that array,
> lets remove that property, simplify by only using the
> default version (defined as IOAPIC_VER_DEF).
> 
> For the record, this field was introduced in commit
> 20fd4b7b6d9 ("x86: ioapic: add support for explicit EOI"):
> 
>  >   Some old Linux kernels (upstream before v4.0), or any released RHEL
>  >   kernels has problem in sending APIC EOI when IR is enabled.
>  >   Meanwhile, many of them only support explicit EOI for IOAPIC, which
>  >   is only introduced in IOAPIC version 0x20. This patch provide a way
>  >   to boost QEMU IOAPIC to version 0x20, in order for QEMU to correctly
>  >   receive EOI messages.
>  >
>  >   Without boosting IOAPIC version to 0x20, kernels before commit
>  >   d32932d ("x86/irq: Convert IOAPIC to use hierarchical irqdomain
>  >   interfaces") will have trouble enabling both IR and level-triggered
>  >   interrupt devices (like e1000).
>  >
>  >   To upgrade IOAPIC to version 0x20, we need to specify:
>  >
>  >     -global ioapic.version=0x20
>  >
>  >   To be compatible with old systems, 0x11 will still be the default
>  >   IOAPIC version. Here 0x11 and 0x20 are the only versions to be
>  >   supported.
>  >
>  >   One thing to mention: this patch only applies to emulated IOAPIC. It
>  >   does not affect kernel IOAPIC behavior.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/intc/ioapic_internal.h |  3 +--
>  hw/intc/ioapic.c          | 18 ++----------------
>  hw/intc/ioapic_common.c   |  2 +-
>  3 files changed, 4 insertions(+), 19 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



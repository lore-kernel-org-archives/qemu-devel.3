Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113CBCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 06:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEMLs-0002MS-TM; Thu, 30 Oct 2025 02:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vEMLr-0002MA-KW; Thu, 30 Oct 2025 02:41:39 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vEMLh-0007To-H0; Thu, 30 Oct 2025 02:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761806490; x=1793342490;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=5wfmeGEMZMkCwMJvTLM6jIBJR+Synl+xkK26rajBms8=;
 b=adrFGYXNTmzv5sCTYCLAmw74uolrIRtbUk1kkApZnjTOF117RDWk2/oa
 DsGPh7XX7IBIzrmKnkyNoKD93ItCs+lVxxDVA6Q/MxTBJ5m2JpyygKQmU
 k794xwFXR2tmKSt/aLrDDo2Byd7dkrJxVA4h9PjYYnKcLf+Tw0fx6yMgB
 uWf+5+F4owxR9YVwQ3U2q6iz+59dcw+Zt3jUx612cLWm1iMyM393gf68j
 0uOGjBkLusovW698AQ33Qz57JsWCFPkIFJFBoWLyB3/TXDNTMhazXVyNt
 bQHoWMzy0K9GrA/BEoSMGc32xMp3ZBgAnn4A82mfuBTxDha27ZyikaXp6 A==;
X-CSE-ConnectionGUID: XKrh2cYHTpOjjdhtp8Lx8A==
X-CSE-MsgGUID: 0Ald+AkMTcOtIXyFAirxUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67773306"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="67773306"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 23:41:17 -0700
X-CSE-ConnectionGUID: JGoOYJHdRmapw3gZBsOsVQ==
X-CSE-MsgGUID: IHwRATa4SKO2eGEud1fWDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; d="scan'208";a="190206245"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 29 Oct 2025 23:41:14 -0700
Date: Thu, 30 Oct 2025 15:03:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3 02/25] hw/i386/ioapic: Use proper SysBus accessors
Message-ID: <aQMNvc+k14B7e3nA@intel.com>
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028181300.41475-3-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Oct 28, 2025 at 07:12:36PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Tue, 28 Oct 2025 19:12:36 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 02/25] hw/i386/ioapic: Use proper SysBus accessors
> X-Mailer: git-send-email 2.51.0
> 
> SysBusDevice::mmio[] is private data of SysBusDevice, use
> sysbus_mmio_get_region() to access it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/i386/kvm/ioapic.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

BTW, it seems ioapic & microvm could also use memory_region_get_address(mr)
as the follow up cleanup, just like hpet did.

Regards,
Zhao



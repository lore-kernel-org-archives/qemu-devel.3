Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260A9CCF9FA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 06:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEMGm-0007r9-4u; Thu, 30 Oct 2025 02:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vEMGi-0007qZ-OM; Thu, 30 Oct 2025 02:36:22 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vEMGc-0006Zp-D0; Thu, 30 Oct 2025 02:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761806175; x=1793342175;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=8m9glvprmxK2opTp4T5AeCsI3JismBTW5juQJExcRik=;
 b=bgpbOusfmRrgHtcPo8wHYft6EsyD7bv1XQSiXbt1fjaj+zP2FeAL4myb
 4ZIW/xt2B9nIsLVqmMs0b7e0fe0WGar6R6cKNYblaU5a8v5n0VbWqhA8M
 bLpOQqR9Gh1w7xA6a7ERIFLL3LkjmvPwFdmutMkEDZYmEXENlYsybcOSP
 7YcYUJWG4wThGssHEiT+3KaqyPozGeuYa4rpnMaK6Dn4pwsZ+CZAKhITg
 jh8EdrhktdFlJYowCqLY9eFfonaFbInSFV0AnUdmgnXFmVZmHA0bn3rdQ
 5qbkLc3dVEoRUmU+IJGht/DvyX1O/uYM/hFH1kblHbvtNOCAZy0fOpJiB g==;
X-CSE-ConnectionGUID: K9LyzieORHaUuTW3KG/zrg==
X-CSE-MsgGUID: VO6NKp6/RqSTz/itIs7ItQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="86565385"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; d="scan'208";a="86565385"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 23:36:02 -0700
X-CSE-ConnectionGUID: QsQJcdfoSbO5Wwgifs6c4g==
X-CSE-MsgGUID: xkXqc11cTvuQOxuOmxdyPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; d="scan'208";a="185567464"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 29 Oct 2025 23:35:58 -0700
Date: Thu, 30 Oct 2025 14:58:09 +0800
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
Message-ID: <aQMMgT8XA0sjv3Ax@intel.com>
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028181300.41475-3-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



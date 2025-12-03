Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A182BD15D86
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 15:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQoan-0001cw-3t; Wed, 03 Dec 2025 10:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQoa4-0001PO-EX; Wed, 03 Dec 2025 10:15:49 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQoa1-0003V8-Gb; Wed, 03 Dec 2025 10:15:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764774946; x=1796310946;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=WQOWhwRL136h6ZsPPRIY+m8YTi1lKm5TBJURMU4w5hI=;
 b=PQsJTOM0jPR1LCbQsL1ybSQDHq1q+pRLPR/iP6955U5SLg27LVWmneBj
 t4e9v2TlY/S1104qBnNdLWC/3LC+zlckJalsJ/kD7/d0RCgRQyzTkGxdf
 A4y4wW1aQruxqUA1cJePyuJeYd4hmbxmc75LDrsqslOAUL8NKq5/4bP4b
 2tRo0CrmRuMxSyxg1cfMPenFi58ha2YXPLLGdJtnDHVuQQabks9FdiwWk
 NnkTjLrNWxLmCMJuQJ9cWturLDP3B0DvvPZ777fS65HygFdTbrbBRa0Go
 DQLbXhph392q+CXKVH1rgUjkPxs1PA2h+jIwCpIruopd1r2mvIvH8dfsF Q==;
X-CSE-ConnectionGUID: 7hR9HnKGSaK5GJmXcfhIqw==
X-CSE-MsgGUID: dP7xivzLScKjaNFfBm/ryg==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="69367189"
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; d="scan'208";a="69367189"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2025 07:15:41 -0800
X-CSE-ConnectionGUID: yAeNoq6RR/C/Bckz6aLEZg==
X-CSE-MsgGUID: /X/Jug+rQPatLK0F7HbQQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; d="scan'208";a="194618228"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 03 Dec 2025 07:15:39 -0800
Date: Wed, 3 Dec 2025 23:40:22 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH-for-11.0 v6 06/13] hw/nvram/fw_cfg: Factor
 fw_cfg_init_io_internal() out
Message-ID: <aTBZ5rRcECvdV0jQ@intel.com>
References: <20251203060942.57851-1-philmd@linaro.org>
 <20251203060942.57851-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251203060942.57851-7-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

On Wed, Dec 03, 2025 at 07:09:34AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed,  3 Dec 2025 07:09:34 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-11.0 v6 06/13] hw/nvram/fw_cfg: Factor
>  fw_cfg_init_io_internal() out
> X-Mailer: git-send-email 2.51.0
> 
> Factor fw_cfg_init_io_internal() out of fw_cfg_init_io_dma().
> In fw_cfg_init_io_dma(), assert DMA arguments are provided.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/nvram/fw_cfg.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



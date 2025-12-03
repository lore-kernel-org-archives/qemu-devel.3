Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85025D15D86
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 15:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQob4-00022z-5f; Wed, 03 Dec 2025 10:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQoaq-0001kq-KC; Wed, 03 Dec 2025 10:16:36 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQoao-0003dV-Rf; Wed, 03 Dec 2025 10:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764774995; x=1796310995;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=SV+7cJnZfyPCFei+UvmZyJYzp0yyvWKRj3X5eyW248I=;
 b=Agx1sYa/YRoa+pbouk95gwuJY8SEGWdnP8VCnJFJUo8HKKlYjz2o6EM+
 /UQiiNMJOCcDhAn1SDgEJ8LHDaZosOPEBxJRlhtxfRcMWQ0Ul3UJ0P5oc
 2r6/gyK6iXo/h9x0FeazBYMXRNJOjIUYu+RCEn+wauhZ05gsgJ9gHmuUi
 U7Xfb1B1ABnil1lvk8b5h7U9s/ZC4ffF+UtQNGibBZehKEw6BjA5bqjZ8
 cmS3t/2BPdubMB8B2JCyIxazyOnPvkm4hy9SB8bOK462vt5NELdakC5MX
 Gd88LfDNqzTaSCbG7BTAiXOhOSyt4zo2njd0/6qtVBtxmRmTW+h/wpaN3 A==;
X-CSE-ConnectionGUID: ohle9OI8TMG2xGK9gHOSyg==
X-CSE-MsgGUID: oBzHJ7bwTh+drzZPjtED/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="54321541"
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; d="scan'208";a="54321541"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2025 07:16:32 -0800
X-CSE-ConnectionGUID: VTIYK3vZS/aUapzDN8Ls9A==
X-CSE-MsgGUID: ThYiVZf4SjaD695duVZQyg==
X-ExtLoop1: 1
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 03 Dec 2025 07:16:29 -0800
Date: Wed, 3 Dec 2025 23:41:12 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH-for-11.0 v6 07/13] hw/nvram/fw_cfg: Add
 fw_cfg_init_io_nodma() helper
Message-ID: <aTBaGKyE+8Xqa4qC@intel.com>
References: <20251203060942.57851-1-philmd@linaro.org>
 <20251203060942.57851-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251203060942.57851-8-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
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

On Wed, Dec 03, 2025 at 07:09:35AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed,  3 Dec 2025 07:09:35 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-11.0 v6 07/13] hw/nvram/fw_cfg: Add
>  fw_cfg_init_io_nodma() helper
> X-Mailer: git-send-email 2.51.0
> 
> Calling fw_cfg_init_io_nodma(...) is more explicit
> than fw_cfg_init_io_dma(..., 0, NULL).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/nvram/fw_cfg.h | 1 +
>  hw/nvram/fw_cfg.c         | 5 +++++
>  2 files changed, 6 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



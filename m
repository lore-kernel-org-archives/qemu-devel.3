Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23504C83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXbhE-0000fU-Bx; Fri, 04 Jul 2025 04:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXbhA-0000WS-BK
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:22:57 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXbh7-0004kF-2o
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751617373; x=1783153373;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ov3O7tN6DVYC4ytU2cHkbdsDS17LhYpZYAnjqYcbkaQ=;
 b=hnz5mefMGIW2CnwLoet6qfqBdzOXUl9lztGaHcF0fIt/NnX9IW687b8R
 LOqY+0fTxc/v+IHrgJLeLJICDfTuyvWh7tUcERIrMAdKlXP4LlKL5qTA/
 E16cn2SWRR1k7fwu21XaEqyYEBIcMoHHMpFHO/AVtQFueYWBYAltnB0LQ
 +czHh3dOb3rF8GUA0ELWuqfRWLEV8Dy4WkhJiAZrPTUDtqXEfdEVZEbda
 JykiAZuc8VbgOO5Qb88sFuibU+GpkD6hJjewFfyCIu2QTzEtOwZ/rvCuW
 MCV9YxUFxzSIM4f2wS+jSvAyApk72bjj59G35kewXcLEtcLgDu4X92XA5 A==;
X-CSE-ConnectionGUID: aiNv6hXAS5Wh623iURWk5A==
X-CSE-MsgGUID: UGQE/rorTxGvcgAE/KcrAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53874921"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="53874921"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 01:22:50 -0700
X-CSE-ConnectionGUID: I/Pg+eXzQ1KrpZRUhv6cNQ==
X-CSE-MsgGUID: t903/aCuQY6esIG55TJgYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="155162950"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 04 Jul 2025 01:22:48 -0700
Date: Fri, 4 Jul 2025 16:44:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v6 11/39] accel/tcg: Extract statistic related code to
 tcg-stats.c
Message-ID: <aGeUXqeAISaPCECH@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-12-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-12-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Jul 03, 2025 at 07:32:17PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:17 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 11/39] accel/tcg: Extract statistic related code to
>  tcg-stats.c
> X-Mailer: git-send-email 2.49.0
> 
> Statistic code is not specific to system emulation (except
> cross-page checks) and can be used to analyze user-mode binaries.
> Extract statistic related code to its own file: tcg-stats.c,
> keeping the original LGPL-2.1-or-later license tag.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  accel/tcg/monitor.c   | 193 ---------------------------------------
>  accel/tcg/tcg-stats.c | 206 ++++++++++++++++++++++++++++++++++++++++++
>  accel/tcg/meson.build |   1 +
>  3 files changed, 207 insertions(+), 193 deletions(-)
>  create mode 100644 accel/tcg/tcg-stats.c

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



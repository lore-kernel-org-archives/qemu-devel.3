Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044ACC25B74
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2024 10:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDiWc-0004PI-Vt; Sun, 02 Jun 2024 06:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sDiWb-0004PA-DT
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 06:33:17 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sDiWZ-0006TS-7j
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 06:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717324395; x=1748860395;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=47PIGI9DXjJxsBu2u7X9iABYmNgocuZ3wJ52ymeaw9w=;
 b=FL2yCFeZECxfgl7nvek89iF3U+c8tMghAzi+ilbuMIEdIsy57CrcdPgn
 tj0SmDMvJHcqOLzhxrU9ED3LKNak/xp/irJVb5OaGjuZFuiR4ucq/ig5o
 MGtFOm4QVOn65V9Sucf5OUFRFNwWGdzinHxyVBXWDwbzV+RLodGTt8CeT
 RssfXpfSGysgNxplWNo2DXuyjvVG/gkC3AuURCtyx85PFT1DSEIroBLR7
 zxO6KhHjvwtAZKWlfZp5Xb199MFpBME/cu7ueECdhQLN+kzL+pQJQxtqg
 XGhkcGp1t1nRX6oikiPE/kOJZPv/IzvjDWpGcK0msN3bq62H/cLmJ5GZw w==;
X-CSE-ConnectionGUID: /oO8Ja06QJW48HhsP5qjEw==
X-CSE-MsgGUID: J1q5CcQXRAujcY06+xh7lw==
X-IronPort-AV: E=McAfee;i="6600,9927,11090"; a="13673272"
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; d="scan'208";a="13673272"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 03:33:12 -0700
X-CSE-ConnectionGUID: 7z/NwWwlQkeMlBKTqnSeXg==
X-CSE-MsgGUID: ERqxLraAQW6d0wCDGEJKAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; d="scan'208";a="36705421"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 02 Jun 2024 03:33:10 -0700
Date: Sun, 2 Jun 2024 18:48:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: lixinyu20s@ict.ac.cn
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 Xinyu Li <lixinyu@loongson.cn>
Subject: Re: [PATCH] target/i386: fix SSE and SSE2 featue check
Message-ID: <ZlxOA5t/1l/Cmfcs@intel.com>
References: <20240602100904.2137939-1-lixinyu20s@ict.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602100904.2137939-1-lixinyu20s@ict.ac.cn>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.041,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, Jun 02, 2024 at 06:09:04PM +0800, lixinyu20s@ict.ac.cn wrote:
> Date: Sun,  2 Jun 2024 18:09:04 +0800
> From: lixinyu20s@ict.ac.cn
> Subject: [PATCH] target/i386: fix SSE and SSE2 featue check
> X-Mailer: git-send-email 2.34.1
> 
> From: Xinyu Li <lixinyu@loongson.cn>
> 
> Featues check of CPUID_SSE and CPUID_SSE2 shoule use cpuid_features,
> rather than cpuid_ext_features

It's better to add a Fixes tag,

Fixes: caa01fadbef1 ("target/i386: add CPUID feature checks to new decoder")

> Signed-off-by: Xinyu Li <lixinyu20s@ict.ac.cn>
> ---
>  target/i386/tcg/decode-new.c.inc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



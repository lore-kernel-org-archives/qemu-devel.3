Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB0DE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 13:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjXX-0001Hp-06; Thu, 12 Dec 2024 08:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLjXS-0001H8-EG
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:47:36 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLjXO-0003lG-Ul
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734011251; x=1765547251;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=hs9T44JhyRfs29SpkAwD3BjTGPUJVD3Mnkntj/Jfus8=;
 b=eSlmXovb7stLdhf4uulIDSzwpZ0ZYD0+bJqS5oCtrL7/wM8fmAskhQNK
 c0EYTHItRq7GSH2O7RH/dJnDchkzYPux+bifTNS/O+ZIZcj5VIbLt8FfY
 TKf/Luw3+JKX0LZm5r8rR3mzsuuAQhcPwrJ521ZgaCgwIgKY7seCDPV6c
 5iBLI7N7cR07i7ezNPevxJmecsdppMkj1TsabiOF5pqph9vEBOvs4UA0/
 XDIU6Glc07TXURGMOpyozHpYKfKH5NKepYk8eUC+Yug5NpqOArPtzv92Z
 A5Yw2A7C/X4WloNr38fZ4v380PzcO1hOkQNyDHWJQb+fHTuD2MPDe2vlS g==;
X-CSE-ConnectionGUID: jARFK9VLTvKEwbZqNJw8CQ==
X-CSE-MsgGUID: ej0hjxpGSGy+r4AJulAOAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34560716"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; d="scan'208";a="34560716"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 05:47:26 -0800
X-CSE-ConnectionGUID: yEX+uZrgQqWgtaay0SYwsw==
X-CSE-MsgGUID: V6KOUGRxTomfncA41aSQtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; d="scan'208";a="96306788"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 12 Dec 2024 05:47:24 -0800
Date: Thu, 12 Dec 2024 22:05:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Tsirkin <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Daniel Berrange <berrange@redhat.com>
Subject: Re: [PATCH] hw/i386/cpu: remove default_cpu_version and simplify
Message-ID: <Z1rts37J6H8f02iT@intel.com>
References: <20241208064810.893451-1-anisinha@redhat.com>
 <Z1cIY357gcsE1IgJ@intel.com>
 <8FE9B724-4233-4D94-AC17-5D6B90F55D7C@redhat.com>
 <891266A0-3863-48FA-9440-64EB9364E665@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <891266A0-3863-48FA-9440-64EB9364E665@redhat.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
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

> Had a conversation with Igor offline. CPU_VERSION_LATEST does not work since it¡¯s a moving target. Therefore for a specific machine, what version of cpu model will be chosen will depend on what is latest and this will change with time. It can break guests that stick to a single cpu model.
> 
> One way to fix this would be to keep a fixed mapping between cpu model and machine versions. However, it will be a nightmare to maintain such mappings.

Thanks Ani!

The commit ad18392 also mentioned the plan to move to CPU_VERSION_LATEST.

Because previsou commits have repeatedly mentioned the plan to move to
CPU_VERSION_LATEST (not only the commit dcafd1ef0af227 you referred, but
also the commit ad18392), I think it's necessary to include the
termination of this plan (i.e., your explanation of why you are no longer
attempting to move to CPU_VERSION_LATEST) in the commit message.

This way, the history regarding default_cpu_version will be easier to
search, and it effectively puts an end to the previous plan.

Thanks,
Zhao



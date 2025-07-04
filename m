Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0962C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 04:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXXxy-0008U9-6C; Fri, 04 Jul 2025 00:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXXxv-0008Ty-4p
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 00:23:59 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXXxs-0005fp-OM
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 00:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751603037; x=1783139037;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=o1Ti4ap9IX3EpjQTCi/FIBX132ZaaBPsZIHR2n5peio=;
 b=B+J6CuWu42arkJ+qZLimLn2BkJofJU2YvwwLm9ch1Djp1+gGRxIFKsXj
 jwMmaaKwUTEfEBEUa8NIH3dkVgiia2oBB7XtxlH2qxuQvRVmJ8K1mBR4m
 IE6FOF1mjtx28NhW9/SYnfd+wF5Fd+GNgRElFgQpubJ6kYpbUrJna/ro1
 p3Rm5A74JnAZSHvVQ6kGLEkiYUxLwj+Fu9jDuQt6zA4Es/u1bY4VwYqP0
 2iNSKYEMxPYHKoKg446BUNZ5k5zPiYJ4RhMuacySCm4VAohzZO1y9gzin
 /GvYX3mWokJQeI8eiryLffVoxxdEFGOoFcc3sCUCJOpb+3RnCHJPR03FT g==;
X-CSE-ConnectionGUID: jyKWuwMzRVioMCDT3kPEOw==
X-CSE-MsgGUID: 0dpdSzEpTw+CH/1pqyrA3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53066346"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="53066346"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 21:23:54 -0700
X-CSE-ConnectionGUID: 8s4KpUnBSb+YZkRT201d+g==
X-CSE-MsgGUID: SW8gJGz2RiWixFRXhEOu1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="154192718"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 21:23:50 -0700
Message-ID: <421a0117-c885-4003-94eb-54267a311c7c@intel.com>
Date: Fri, 4 Jul 2025 12:23:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/39] accel/tcg: Remove 'info opcount' and
 @x-query-opcount
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-8-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250703173248.44995-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/4/2025 1:32 AM, Philippe Mathieu-Daudé wrote:
> Since commit 1b65b4f54c7 ("accel/tcg: remove CONFIG_PROFILER",
> released with QEMU v8.1.0) we get pointless output:
> 
>    (qemu) info opcount
>    [TCG profiler not compiled]
> 
> Remove that unstable and unuseful command.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>


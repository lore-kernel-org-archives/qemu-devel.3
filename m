Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B231EC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7EsL-0003hl-4c; Tue, 22 Apr 2025 10:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7EsA-0003eX-CL
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:45:21 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7Es7-0003yx-H8
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745333115; x=1776869115;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Fo4yXmneWa2F5Bc3abyMLQRGNTP7MT1K77ozM3ipEm8=;
 b=Be03HxWwEywgYCNUxYgkiauyrX4mX7LQs3LHl/faddDHDbNg66GN1hCe
 CX2M3YhRyVg70hrpI77fVl5yvJ/ud0eU6FSg3UHkYzx4a4QA9Z/OaJEXa
 KM121zMdwckzrpHGgah0vOT+pX9E09tQdNHn0zASux9zFd9n5D1tZ8kkY
 pcVbsoT77vW4muGqGxY1cPszpijAyI/3gV0UTJKFV8mUGV2GI5TFR1w2w
 94ol3AGsZG3sUgvpzWFkpZsIfWHBjPu6c9ZBIKkesJe3qp94zDu78ZSFd
 eYHrqPkpyNhF1P6QlLK96TDTlIWHU6AIovxhFjP6HZdfzfzlhDEPyGA1b g==;
X-CSE-ConnectionGUID: U2RFCH4eT2ebwUJpZS9G+Q==
X-CSE-MsgGUID: YqFUdIwlThamZH7dW/VuuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46599654"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="46599654"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2025 07:45:13 -0700
X-CSE-ConnectionGUID: dF5Ii7DXSfe3iGIMFEvE2A==
X-CSE-MsgGUID: Fu7/GjOBSEWfPW3ueD5GDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="131877097"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 22 Apr 2025 07:45:11 -0700
Date: Tue, 22 Apr 2025 23:06:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 11/55] i386/tdx: Wire CPU features up with attributes
 of TD guest
Message-ID: <aAewXWH9o8ShaCP/@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-12-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-12-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On Tue, Apr 01, 2025 at 09:01:21AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:21 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 11/55] i386/tdx: Wire CPU features up with attributes of
>  TD guest
> X-Mailer: git-send-email 2.34.1
> 
> For QEMU VMs,
>   - PKS is configured via CPUID_7_0_ECX_PKS, e.g., -cpu xxx,+pks  and
>   - PMU is configured by x86cpu->enable_pmu, e.g., -cpu xxx,pmu=on
> 
> While the bit 30 (PKS) and bit 63 (PERFMON) of TD's attributes are also
> used to configure the PKS and PERFMON/PMU of TD, reuse the existing
> configuration interfaces of 'cpu' for TD's attributes.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  target/i386/kvm/tdx.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



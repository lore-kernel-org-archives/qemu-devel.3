Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE75C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGG5-0005XP-Pq; Thu, 03 Jul 2025 05:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXGFx-0005Wa-8s
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:29:26 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXGFv-0000Aa-0g
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751534963; x=1783070963;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ijzOyRlzRuGT8K9zduFWb5GhLsh+3pquTSXdSyo3KXA=;
 b=GDuh3bQVlCERvXKM4g/L61ias8AJpIpx4TElLcNuRpTIDQAVw+jYOm8U
 QtkwuSlG/5YPr2yctu1ddggOZRDJvj2zMU07CcZP6XYsk9q73rNGjVh49
 wDpJamaSaZOvwwv+3p5RMnO5fZocOAg9A+qlMuHxwhHzQpJ5QymvxD/7U
 eUTHORcb/BuCRKAUJ3IJMiAZT/0u1wtiEB8MwYfB6A4NsiHvnA5yk+Pd7
 M9inOF9EHIGNBT9JK9RQhGmb81D4o425Ifr49LnYrrdvS6CBbv/kf2T1Y
 Bx0fG6GzhVJE60H8Aw7cjvXVXNvifQ5XBlZWnxN5O+TpDJFJB/visQAkk Q==;
X-CSE-ConnectionGUID: vkzsBx4pTHingQgDniA+MQ==
X-CSE-MsgGUID: qBE3kZF4S/qeUgI9Kx08PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="52971886"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="52971886"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 02:29:18 -0700
X-CSE-ConnectionGUID: GAmz6M2bQWqgqR73+kMVsg==
X-CSE-MsgGUID: fxxOalVvTEq6W1ob+TuUzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="153748766"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 03 Jul 2025 02:29:14 -0700
Date: Thu, 3 Jul 2025 17:50:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Pu Wen <puwen@hygon.cn>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH 16/16] i386/cpu: Use a unified cache_info in X86CPUState
Message-ID: <aGZSb+OM1b7k46gy@intel.com>
References: <20250620092734.1576677-1-zhao1.liu@intel.com>
 <20250620092734.1576677-17-zhao1.liu@intel.com>
 <3d1f5698-1936-4fc0-af04-db900f0d1b9e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d1f5698-1936-4fc0-af04-db900f0d1b9e@linux.intel.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
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

> Nice clean-up patch series. Thanks.
> 
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 

Thanks for your review and effort!

Regards,
Zhao



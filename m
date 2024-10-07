Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD8DCFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxlbQ-0001XX-3H; Mon, 07 Oct 2024 07:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sxlbN-0001Wn-P8; Mon, 07 Oct 2024 07:08:34 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sxlbL-0007Bn-4M; Mon, 07 Oct 2024 07:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728299311; x=1759835311;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=hpwrGxuedAeKuZjTNzgbaWYzvlowhimdFInbSjmkp9g=;
 b=d8uHpSd7VqE+IOBbTYYgEqYxHitjEPuxJmKvf2nYCy8XdR6JoK7YT6DV
 ovKnoW9J7Ddg4PhRhrMsJSd+mHZGCaHS7f4Of34RBZRkFGxgwIAX59MmZ
 n1ZSaRB4qDBTj6pyUd1xohtGXmHbvNoOkJvSEv5/FybChG9WW4vrWLQzp
 zGsqDpJLn4xyy3bAc608yVI8JVcC6ddslbHYKcyCK2Eh7/bc0za5y2UKd
 6kwynbE+L+13R9id77L1za0l1nn3R67L5fRuOELvE4o/0ZZg98iirN6VX
 e41XodDciEOsn8rP1cgUsqbzMsOWrDt5+v/1CbUr81k6nusq5n5Oqwrfk Q==;
X-CSE-ConnectionGUID: LwG4B1seS9adT4dB/XjpfA==
X-CSE-MsgGUID: vGyqoNywSIKrksKb+ID0Iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="31233863"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; d="scan'208";a="31233863"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2024 04:08:27 -0700
X-CSE-ConnectionGUID: AQYZDfABQIaxfDs9ei+I9g==
X-CSE-MsgGUID: h8O7y00TS2SmBdz6F04s3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; d="scan'208";a="75875239"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 07 Oct 2024 04:08:22 -0700
Date: Mon, 7 Oct 2024 19:24:33 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S.Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 5/7] i386/cpu: Support thread and module level cache
 topology
Message-ID: <ZwPE8foi2qviMQSB@intel.com>
References: <20240908125920.1160236-1-zhao1.liu@intel.com>
 <20240908125920.1160236-6-zhao1.liu@intel.com>
 <20240917100508.00001907@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917100508.00001907@Huawei.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

On Tue, Sep 17, 2024 at 10:05:08AM +0100, Jonathan Cameron wrote:
> Date: Tue, 17 Sep 2024 10:05:08 +0100
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Subject: Re: [PATCH v2 5/7] i386/cpu: Support thread and module level cache
>  topology
> X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
> 
> On Sun,  8 Sep 2024 20:59:18 +0800
> Zhao Liu <zhao1.liu@intel.com> wrote:
> 
> > Allow cache to be defined at the thread and module level. This
> > increases flexibility for x86 users to customize their cache topology.
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > Tested-by: Yongwei Ma <yongwei.ma@intel.com>
>
> Will be interesting to see if anyone uses the thread level, but
> no harm in supporting it.

x86 CPU has a legacy property "x-l1-cache-per-thread". This is the old
QEMU cache topology behavior, kept for compatibility. Now add thread
level and I can refactor the code for this thread level.

> I guess this would be a case of RDT
> / MPAM etc as I'm not sure I've seen an SMT processor with
> private caches. Some old papers seems to suggest that it might
> make sense for smt 8 and above.

Thanks for the hint, I'll think about whether some of the RDT / MPAM
cases can be applied here.

> Anyhow, patch is fine
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks!

-Zhao



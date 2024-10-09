Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA21CED606
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 06:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syQ0P-0005sI-2I; Wed, 09 Oct 2024 02:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1syQ0E-0005pE-Ga; Wed, 09 Oct 2024 02:16:54 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1syQ0B-0007vn-4L; Wed, 09 Oct 2024 02:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728454611; x=1759990611;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Lt669vuESF+NLlyNvW3nMfB5lZgQCn13KNvjj5g2nMs=;
 b=DdQzNPVJgeXIE7CWeig9kHBVROBiQPi0M3+OVdzjz3z6uoky9QLDmDdu
 4CdaGpGzVlRq/aAuT/2kmbNVIbZxFkT06EehkHNyoEeUI3zHBOs3AZCqT
 +tV54mPLaiRStXDHsU3zRuPTz70pQNE8M1tINpsZl+8/l1/f+DxTFZ6Fw
 e0Au0l/+j794MI03EwJwo6DgBYYe+c8Z9lW3OYWeEPH3morC3rpcOX4eg
 jlOyOd5flkC6X0tD6w6EVgyE+zS7GSbrbQCN/Ng3riBK0OgSjPuJU+Ans
 T0NeWwpJn69MhuJ+FSkKQpGsfaW0MyXC0mgOz6/nBG78IYyf1P86aWIez Q==;
X-CSE-ConnectionGUID: V+wZ9EyLSAmOQ7IE0iHauw==
X-CSE-MsgGUID: KonyTcI/RSm0DLu8l//VLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="31513105"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; d="scan'208";a="31513105"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2024 23:15:25 -0700
X-CSE-ConnectionGUID: UnMqb4StSIaCs9/73yv3Vw==
X-CSE-MsgGUID: kiLaGcXURCyU7A1OBQ9Q7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; d="scan'208";a="106901495"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 23:15:20 -0700
Date: Wed, 9 Oct 2024 14:31:31 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC v2 03/12] system/vl: Create CPU topology devices from CLI
 early
Message-ID: <ZwYjQ2mEa2OP5r//@intel.com>
References: <20240919061128.769139-1-zhao1.liu@intel.com>
 <20240919061128.769139-4-zhao1.liu@intel.com>
 <20241008105053.000059ee@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008105053.000059ee@Huawei.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

On Tue, Oct 08, 2024 at 10:50:53AM +0100, Jonathan Cameron wrote:
> Date: Tue, 8 Oct 2024 10:50:53 +0100
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Subject: Re: [RFC v2 03/12] system/vl: Create CPU topology devices from CLI
>  early
> X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
> 
> On Thu, 19 Sep 2024 14:11:19 +0800
> Zhao Liu <zhao1.liu@intel.com> wrote:
> 
> > Custom topology will allow user to build CPU topology from CLI totally,
> > and this replaces machine's default CPU creation process (*_init_cpus()
> > in MachineClass.init()).
> > 
> > For the machine's initialization, there may be CPU dependencies in the
> > remaining initialization after the CPU creation.
> > 
> > To address such dependencies, create the CPU topology device (including
> > CPU devices) from the CLI earlier, so that the latter part of machine
> > initialization can be separated after qemu_add_cli_devices_early().
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Other than question of type of category from previous patch this looks
> fine to me.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> However, needs review from others more familiar with this code!

Thanks!

-Zhao



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB02CED606
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 05:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syPgG-0007u6-8i; Wed, 09 Oct 2024 01:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1syPgE-0007tb-26; Wed, 09 Oct 2024 01:56:14 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1syPgC-0005hl-Im; Wed, 09 Oct 2024 01:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728453373; x=1759989373;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=wMTrGWrNqEJ/3vJS5OVwKl/YUiB1j9er0HSj6wg9YsY=;
 b=Im4+wQaIYH7ip9BTyRfyhZHAf+xyuRmSySilpoUrkV2JdI1Q2jQcTaTs
 /a4hcrJJaifGSoW9+KuSYmxsuheMIXPAOnjhagetRLpWgYphCwD7VpX+5
 bZqWNYRDXUcfIjMF1WLsfRiuZXWeihCuLvPw3VUW0fuq84I5q1p/rfKZg
 8ugpuXdn8maxWkwPD7kVlzyEx0ALCB8YMQ/oxUbJp8C3CyA1bT+eJTbco
 jo5EFum2z7M3l0RaottR2c68Wc+wtOflhCnXqNUmqagOPzTpLluIdnZ1P
 weLuQ1SQ3Y4fLHlB7YO5F0SVBDPNwpZaNhb15CIPtE5ugG2KSn2ZPK74J Q==;
X-CSE-ConnectionGUID: Gt5WaDHUTWiVprxUKbGGnw==
X-CSE-MsgGUID: MCKDr+PwSYCtffGoqFnN3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27623663"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; d="scan'208";a="27623663"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2024 22:55:01 -0700
X-CSE-ConnectionGUID: tj+D1EMQTfGPh480WuhJkQ==
X-CSE-MsgGUID: jqH4fZ4+RSaVVwxcKVhkAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; d="scan'208";a="81154308"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 08 Oct 2024 22:54:55 -0700
Date: Wed, 9 Oct 2024 14:11:06 +0800
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
Message-ID: <ZwYeek8iaoE2fu+C@intel.com>
References: <20240919061128.769139-1-zhao1.liu@intel.com>
 <20240919061128.769139-4-zhao1.liu@intel.com>
 <20241008105545.000013e0@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008105545.000013e0@Huawei.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
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

On Tue, Oct 08, 2024 at 10:55:45AM +0100, Jonathan Cameron wrote:
> Date: Tue, 8 Oct 2024 10:55:45 +0100
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Subject: Re: [RFC v2 03/12] system/vl: Create CPU topology devices from CLI
>  early
> X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
> 
> 
> > +
> > +static void qemu_add_cli_devices_early(void)
> > +{
> > +    long category = DEVICE_CATEGORY_CPU_DEF;
> > +
> > +    qemu_add_devices(&category);
> > +}
> > +
> >  static void qemu_init_board(void)
> >  {
> >      /* process plugin before CPUs are created, but once -smp has been parsed */
> > @@ -2631,6 +2662,9 @@ static void qemu_init_board(void)
> >      /* From here on we enter MACHINE_PHASE_INITIALIZED.  */
> >      machine_run_board_init(current_machine, mem_path, &error_fatal);
> >  
> > +    /* Create CPU topology device if any. */
> > +    qemu_add_cli_devices_early();
> I wonder if this is too generic a name?
> 
> There are various other things we might want to do early.
> Maybe qemu_add_cli_cpu_def()

Sure, it makes sense.



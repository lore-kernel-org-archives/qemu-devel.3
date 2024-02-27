Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935C5C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 10:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reub9-0006fg-Nw; Tue, 27 Feb 2024 05:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1reub7-0006Y8-C9; Tue, 27 Feb 2024 05:22:05 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1reub5-00045c-MN; Tue, 27 Feb 2024 05:22:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709029324; x=1740565324;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=F6+NTEf+OvKxItgO+SSdOalGV2SCEFkd9K7C26e6mKo=;
 b=YsO4KLvww1yJO0pshM34ImiOaZPQIofemnG0FrT+iqMwbzxg2HoVnsSn
 rc73hWPzHrqOtG7nXRUocV5IEAqk37VyWHv8mwDlhgEnJrgzlTnp9yNAR
 bWX4cuC6jxcc5JXjOgrLrJ4+xibICvk/0zHvGbxRQhf663DdK/xhL3sCO
 X3o4wbG32ex2vLG/b6QfxxJFDwcTyRgwZG3O1yNK7fE7h8iYoRRY+Nb/5
 qRYNcDkwVz1Vk+2EKM81hO3/o1//nIuasoFTNeQkYS0/dQQ4BVRYJ+c50
 RZoVqXB/kLxoRMlot8dGh56pBWuFSSR4tiBPDfnqgH8LHUFDtLolPrE5J Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14071188"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; d="scan'208";a="14071188"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 02:21:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; d="scan'208";a="11587755"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 27 Feb 2024 02:21:53 -0800
Date: Tue, 27 Feb 2024 18:35:36 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC 4/8] hw/core: Add cache topology options in -smp
Message-ID: <Zd26+BpXQID95lqm@intel.com>
References: <20240220092504.726064-1-zhao1.liu@linux.intel.com>
 <20240220092504.726064-5-zhao1.liu@linux.intel.com>
 <20240226153947.00006fd6@Huawei.com> <Zd2pWVH4/eo3HM8j@intel.com>
 <Zd2ndJghXbmMHzBn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd2ndJghXbmMHzBn@redhat.com>
Received-SPF: none client-ip=192.198.163.9;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> > > > +        if (smp_cache_string_to_topology(ms, config->l1d_cache,
> > > > +            &ms->smp_cache.l1d, errp)) {
> > > 
> > > Indent is to wrong opening bracket.
> > > Same for other cases.
> > 
> > Could you please educate me about the correct style here?
> > I'm unsure if it should be indented by 4 spaces.
> 
> It needs to look like this:
> 
>         if (smp_cache_string_to_topology(ms, config->l1d_cache,
>                                          &ms->smp_cache.l1d, errp)) {
> 
> so func parameters are aligned to the function calls' opening bracket,
> not the 'if' statement's opening bracket.
>

Thanks for your explaination!

Regards,
Zhao



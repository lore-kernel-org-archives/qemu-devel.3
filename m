Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B48C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 07:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ40p-0002ap-U8; Wed, 31 Jul 2024 03:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sZ40o-0002Zp-ER; Wed, 31 Jul 2024 03:44:42 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sZ40k-0000lp-0s; Wed, 31 Jul 2024 03:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722411878; x=1753947878;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=uI8ued3A1y+KABwhLnnHrEksiCAWTyppjF8eLSYsOcw=;
 b=aN1NjO6aDY24WMgDo1IBnDXZfD8UHWAfTwFPQAAOAV56l2DMMHgtYmDl
 MbpE59ql/7KdQPwMMbO50fxAUX1fkWlvm8BGiRtI3y9ARRLGgRBghsmli
 IfEyUTObWRV0WIQ2Lwf/aBwMrUqpC7Yp4SrxTQMDdgL4gvfB9+wN7fZJ3
 2y9lyNki1VAX33CDCdhDMbUeokA0q+wyAh3CLjtU9JSbBPdF+4bscHTb1
 +aF/HYGY3Ukugj1r0hYe9QUyLrbU0UdzDAnv9e71YvHncy9lq2d8s2ABd
 9d8KZPOdk3JdsGa//pjsq8jKsKg/+EpgIJplFKHN7c6iN4eTdkiS6T2Fj g==;
X-CSE-ConnectionGUID: BQghL7dNSbegZ1RKApO8Lg==
X-CSE-MsgGUID: rmNRPLwfSlyohsvIqU8tgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="31423134"
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; d="scan'208";a="31423134"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2024 00:44:33 -0700
X-CSE-ConnectionGUID: AU/vUc6qTpOrr5lhfWTkQg==
X-CSE-MsgGUID: cu7MWQ00QVmLseBL9zTmcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; d="scan'208";a="59455163"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 31 Jul 2024 00:44:28 -0700
Date: Wed, 31 Jul 2024 16:00:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/6] arm/virt: Wire up GPIO error source for ACPI / GHES
Message-ID: <ZqnvD8o+Fa4o/+Db@intel.com>
References: <cover.1722259246.git.mchehab+huawei@kernel.org>
 <e994c3944d31775d62bbd017dec3adff50ddf269.1722259246.git.mchehab+huawei@kernel.org>
 <ZqigPgTl7quJ553J@intel.com> <20240731072158.3aaf85ac@foz.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240731072158.3aaf85ac@foz.lan>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Wed, Jul 31, 2024 at 07:21:58AM +0200, Mauro Carvalho Chehab wrote:

[snip]

> > The name looks inconsistent with the style of other MachineClass virtual
> > methods. What about the name like "notify_xxx"? And pls add the comment
> > about this new method.
> > 
> > BTW, I found this method is called in generic_error_device_notify() of
> > Patch 6. And the mc->generic_error_device_notify() - as the virtual
> > metchod of MachineClass looks just to implement a hook, and it doesn't
> > seem to have anything to do with MachineClass/MachineState, so my
> > question is why do we need to add this method to MachineClass?
> > 
> > Could we maintain a notifier list in ghes.c and expose an interface
> > to allow arm code register a notifier? This eliminates the need to add
> > the ¡°notify¡± method to MachineClass.
> 
> Makes sense. I'll change the logic to use this notifier list code inside
> ghes.c, and drop generic_error_device_notify():
> 
> 	NotifierList generic_error_notifiers =
> 	    NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
> 
> 	/* Notify BIOS about an error via Generic Error Device - GED */
> 	static void generic_error_device_notify(void)
> 	{
> 	    notifier_list_notify(&generic_error_notifiers, NULL);
> 	}

Fine for me.

Regards,
Zhao




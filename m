Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C4BC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 14:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWGHt-0007u6-2Z; Tue, 23 Jul 2024 10:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWGHr-0007n5-45
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:14:43 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWGHn-0006mB-CP
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721744079; x=1753280079;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=88/ZD+HzKHSRWovuOAAXbLcof1+XgIRS2ZMH1oJpst0=;
 b=MlNalZaIa22z9TtCeOl/ODN5dZuu9R4DKZka0Hhk8kd063KhkEYBlvAO
 bQ/KJzupYnYlCoDxdpcAWt8cfhBn1EMNaxvPsRbjuLUJNGsHZd+yr+VeS
 P9seaOFueKNHG14hWiTek2wxOYyzWUnMP1Sf8PJ+3Xv1qwwGmbeCS9Zd7
 jQschqx9xGDdVzrkxA0qFxWJx81WeUghOwzhzplJfSfCCFbUxP63g26Kh
 Ip+dKu0iIazdy0UrAiIErDSoA5XksGgZHlS02Zut6y/MJrD3iaEQd8S9o
 YSh/Qh2mOX24jCem/dIl5cRVacNqbatqCxW+PSZcb/cmGZVcBGjQvpIHi g==;
X-CSE-ConnectionGUID: miE9RNduRPGAtSJMQk+VOg==
X-CSE-MsgGUID: dRMIeNxxRharcD5EtHXf4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19555156"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="19555156"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2024 07:14:27 -0700
X-CSE-ConnectionGUID: arDldOIsSRGrOt3VcX9dCw==
X-CSE-MsgGUID: hsd3Aqi6T3mvWggOqjIPXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="52267500"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 23 Jul 2024 07:14:25 -0700
Date: Tue, 23 Jul 2024 22:30:09 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH] hw/nubus/nubus-virtio-mmio: Fix missing ERRP_GUARD() in
 nubus_virtio_mmio_realize()
Message-ID: <Zp++cQBjGobX+Ty3@intel.com>
References: <20240715095939.72492-1-zhao1.liu@intel.com>
 <878qxswgrm.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878qxswgrm.fsf@pond.sub.org>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

Hi Markus,

On Tue, Jul 23, 2024 at 12:21:17PM +0200, Markus Armbruster wrote:
> Date: Tue, 23 Jul 2024 12:21:17 +0200
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [PATCH] hw/nubus/nubus-virtio-mmio: Fix missing ERRP_GUARD()
>  in nubus_virtio_mmio_realize()
> 
> Zhao Liu <zhao1.liu@intel.com> writes:
> 
> > As the comment in qapi/error, dereferencing @errp requires
> 
> Suggest "According to the comment in qapi/error.h".
 
Thanks! Good words.

> > ERRP_GUARD():
> >
> > * = Why, when and how to use ERRP_GUARD() =
> > *
> > * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> > * - It must not be dereferenced, because it may be null.
> > ...
> > * ERRP_GUARD() lifts these restrictions.
> > *
> > * To use ERRP_GUARD(), add it right at the beginning of the function.
> > * @errp can then be used without worrying about the argument being
> > * NULL or &error_fatal.
> > *
> > * Using it when it's not needed is safe, but please avoid cluttering
> > * the source with useless code.
> >
> > But in nubus_virtio_mmio_realize(), @errp is dereferenced without
> > ERRP_GUARD().
> 
> Suggest to scratch "But".

No problem, will do.

> > Although nubus_virtio_mmio_realize() - as a DeviceClass.realize()
> > method - doesn't get the NULL @errp parameter, it hasn't triggered the
> > bug that dereferencing the NULL @errp. It's still necessary to follow
> > the requirement of @errp, so add missing ERRP_GUARD() in
> > nubus_virtio_mmio_realize().
> 
> Suggest
> 
>   Although nubus_virtio_mmio_realize() - as a DeviceClass.realize()
>   method - is never passed a null @errp argument, it should follow the
>   rules on @errp usage.  Add the ERRP_GUARD() there.

Thanks for the text! It sounds much more authentic!

> > Cc: Laurent Vivier <laurent@vivier.eu>
> > Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >  hw/nubus/nubus-virtio-mmio.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/nubus/nubus-virtio-mmio.c b/hw/nubus/nubus-virtio-mmio.c
> > index 58a63c84d0be..a5558d3ec28b 100644
> > --- a/hw/nubus/nubus-virtio-mmio.c
> > +++ b/hw/nubus/nubus-virtio-mmio.c
> > @@ -23,6 +23,7 @@ static void nubus_virtio_mmio_set_input_irq(void *opaque, int n, int level)
> >  
> >  static void nubus_virtio_mmio_realize(DeviceState *dev, Error **errp)
> >  {
> > +    ERRP_GUARD();
> >      NubusVirtioMMIODeviceClass *nvmdc = NUBUS_VIRTIO_MMIO_GET_CLASS(dev);
> >      NubusVirtioMMIO *s = NUBUS_VIRTIO_MMIO(dev);
> >      NubusDevice *nd = NUBUS_DEVICE(dev);
>        SysBusDevice *sbd;
>        int i, offset;
> 
>        nvmdc->parent_realize(dev, errp);
> 
> Here's the dereference:
> 
>        if (*errp) {
>            return;
>        }
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 

Thanks! Will refresh a v2 soon.

Regards,
Zhao



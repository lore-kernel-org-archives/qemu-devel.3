Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CE8C48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoRP-0001kv-16; Wed, 21 Feb 2024 10:23:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rcoKz-0000nB-7G; Wed, 21 Feb 2024 10:16:46 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rcnwv-0006r8-V3; Wed, 21 Feb 2024 09:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708527114; x=1740063114;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4ak9kaacz/hdfQkekQ6mF744vrtw9wcS9x6gihIV+eE=;
 b=gjdx9/qC4J6PUSkGs7xJLsANmqsjO2md3l/xkYgmvSBBV3CqkX2KrYPp
 nnPKhJSXgQ3VC5OwDI/nbrC83KP6ISCVMrj1XrNFr3QOi3U5CeyX8183F
 kpA85/hbqWIzCecowZtWm7A4KOtaBZoVeFhxW3JmUnmtegcIXIfTyTZ1Y
 qkhzvrUC3YPBhD1UP6S1U+uTVuRFtsI8eGqnJK0F6dy51tS1kd7dX6+ds
 w+gR3bQiiHu6cZU1yh+ja5MEP3JPldBct7caOCBiI9MLNCmmZMb8koD99
 6vTD76fyC6/SWBcGK9HwdLYAxoijBlHte0PMx31P3cxnbU4SM6fdVtThu w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2827374"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2827374"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2024 06:51:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="936655259"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; d="scan'208";a="936655259"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2024 06:51:47 -0800
Date: Wed, 21 Feb 2024 23:05:27 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 2/6] hw/display/macfb: Fix missing ERRP_GUARD() in
 macfb_nubus_realize()
Message-ID: <ZdYRN+BchbdY1xm4@intel.com>
References: <20240221094317.994454-1-zhao1.liu@linux.intel.com>
 <20240221094317.994454-3-zhao1.liu@linux.intel.com>
 <874je2vyqs.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874je2vyqs.fsf@pond.sub.org>
Received-SPF: none client-ip=192.198.163.15;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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

On Wed, Feb 21, 2024 at 12:32:43PM +0100, Markus Armbruster wrote:
> Date: Wed, 21 Feb 2024 12:32:43 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [PATCH 2/6] hw/display/macfb: Fix missing ERRP_GUARD() in
>  macfb_nubus_realize()
> 
> Zhao Liu <zhao1.liu@linux.intel.com> writes:
> 
> > From: Zhao Liu <zhao1.liu@intel.com>
> >
> > As the comment in qapi/error, dereferencing @errp requires
> > ERRP_GUARD():
> >
> > * = Why, when and how to use ERRP_GUARD() =
> > *
> > * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> > * - It must not be dereferenced, because it may be null.
> > * - It should not be passed to error_prepend() or
> > *   error_append_hint(), because that doesn't work with &error_fatal.
> > * ERRP_GUARD() lifts these restrictions.
> > *
> > * To use ERRP_GUARD(), add it right at the beginning of the function.
> > * @errp can then be used without worrying about the argument being
> > * NULL or &error_fatal.
> > *
> > * Using it when it's not needed is safe, but please avoid cluttering
> > * the source with useless code.
> >
> > Currently, since macfb_nubus_realize() - as a DeviceClass.realize()
> > method - doesn't get the NULL errp parameter, it doesn't trigger the
> > dereference issue.
> >
> > To follow the requirement of errp, add missing ERRP_GUARD() in
> > macfb_nubus_realize().
> >
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> > Suggested by credit:
> >  Markus: Referred his explanation about ERRP_GUARD().
> > ---
> >  hw/display/macfb.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/display/macfb.c b/hw/display/macfb.c
> > index 418e99c8e18e..1ace341a0ff4 100644
> > --- a/hw/display/macfb.c
> > +++ b/hw/display/macfb.c
> > @@ -714,6 +714,7 @@ static void macfb_nubus_set_irq(void *opaque, int n, int level)
> >  
> >  static void macfb_nubus_realize(DeviceState *dev, Error **errp)
> >  {
> > +    ERRP_GUARD();
> >      NubusDevice *nd = NUBUS_DEVICE(dev);
> >      MacfbNubusState *s = NUBUS_MACFB(dev);
> >      MacfbNubusDeviceClass *ndc = NUBUS_MACFB_GET_CLASS(dev);
> 
> The dereference is
> 
>        ndc->parent_realize(dev, errp);
>        if (*errp) {
>            return;
>        }
> 
> We check *errp, because neither the callback returns void.
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks! Will add more description in commit message as you suggested.

Regards,
Zhao




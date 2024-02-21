Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671F4C48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoRb-0002GK-Dc; Wed, 21 Feb 2024 10:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rcoL4-0001hh-KD; Wed, 21 Feb 2024 10:16:52 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rco2Z-0007Tg-3P; Wed, 21 Feb 2024 09:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708527463; x=1740063463;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=N/Rh861QxK57N9KeQmommhQkchtjVhc8QkT0maRgZQo=;
 b=K9kdT/ZlExtJEnpjVVA61JAaJbV7ZjBqIkaAz2X63vrWuqzWEMQ0GBr8
 aTCaZm28kBFB34ehyf3I3SeMFhoX3uUsMmLYWG2Wu6Rb5IfSHIYHBw8Sv
 +Kp9vZ4RAh7IF237XrlkiUmSz/J+yKdS2TFixyBLneuNXd7REOp+ihWkW
 /0+vnUIr5cOqjaI9wPGaMOE7HgjD3ueKziR9daN0e95W60Dd8E4WRSgqG
 Y0PIJM9hycS8pdZziNjeh19qu7LUVo/mYZURHCAGVooJqgc3BygXXn+6E
 9GcQTpJnNrGarBrsvokSUys6kbUqy4JgqzrTYwOV2iNHT5GSkKcMyDqJx Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="3173218"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="3173218"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2024 06:57:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="9752563"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 21 Feb 2024 06:57:33 -0800
Date: Wed, 21 Feb 2024 23:11:12 +0800
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
Subject: Re: [PATCH 3/6] hw/mem/cxl_type3: Fix missing ERRP_GUARD() in
 ct3_realize()
Message-ID: <ZdYSkNRkZBsfHJea@intel.com>
References: <20240221094317.994454-1-zhao1.liu@linux.intel.com>
 <20240221094317.994454-4-zhao1.liu@linux.intel.com>
 <87zfvuuk18.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfvuuk18.fsf@pond.sub.org>
Received-SPF: none client-ip=192.198.163.16;
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

On Wed, Feb 21, 2024 at 12:35:47PM +0100, Markus Armbruster wrote:
> Date: Wed, 21 Feb 2024 12:35:47 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [PATCH 3/6] hw/mem/cxl_type3: Fix missing ERRP_GUARD() in
>  ct3_realize()
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
> > Currently, since ct3_realize() - as a PCIDeviceClass.realize() method -
> > doesn't get the NULL errp parameter, it doesn't trigger the dereference
> > issue.
> >
> > To follow the requirement of errp, add missing ERRP_GUARD() in
> > ct3_realize().
> >
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> > Suggested by credit:
> >  Markus: Referred his explanation about ERRP_GUARD().
> > ---
> >  hw/mem/cxl_type3.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index e8801805b90f..a3b0761f843b 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -645,6 +645,7 @@ static DOEProtocol doe_cdat_prot[] = {
> >  
> >  static void ct3_realize(PCIDevice *pci_dev, Error **errp)
> >  {
> > +    ERRP_GUARD();
> >      CXLType3Dev *ct3d = CXL_TYPE3(pci_dev);
> >      CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
> >      ComponentRegisters *regs = &cxl_cstate->crb;
> 
> The dereference is
> 
>        cxl_doe_cdat_init(cxl_cstate, errp);
>        if (*errp) {
>            goto err_free_special_ops;
>        }
> 
> We check *errp, because cxl_doe_cdat_init() returns void.  Could be
> improved to return bool, along with its callees ct3_load_cdat() and
> ct3_build_cdat(), but that's a slightly more ambitious cleanup, so
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>

Thanks! I can continue to consider such the cleanup in the follow up.

Will also add the dereference description in commit message to make
review easier.

Regards,
Zhao




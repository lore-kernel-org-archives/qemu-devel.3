Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9EEC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoYF-0005T8-C1; Wed, 21 Feb 2024 10:30:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rcoM9-0001hh-4F; Wed, 21 Feb 2024 10:17:57 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rco1B-0007ME-4u; Wed, 21 Feb 2024 09:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708527377; x=1740063377;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GkDRFpSgEw4Jc9eQg/w5fzMP57UNmwkGjsPiSjtncj0=;
 b=ctcChPA3oBeHTYSiHnl5bvKZFvKnF0D5fgaHihfmnae8Fra7benpp9ND
 fVSxhro6WvWFwacqeDLbGVZCtlehEJMQdcm6q6q6WdER0E84PoArzKHJE
 V+o9xuZxtLDnNvfIP1F8mPRP4Q4p33Ohrx4r4zt+acxTrL2Wy61b8VVd6
 qQCnVB4W+/1bVs4W0mlhIoO1sUULLA7sp+kkC/7b2jcIEftBaK4LgafoI
 OED7J7D83SU/EceoNqR/wAmxU6PTWWgfQ9e6rqNfaTxRL8Rhd8dTbI2kT
 NF9cNFyrpV1UjGqf3CFwVTFEec03P3CpBEKI5NnDM9C68Gxa5yv/pVNl9 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="3173102"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="3173102"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2024 06:56:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="9782187"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 21 Feb 2024 06:56:11 -0800
Date: Wed, 21 Feb 2024 23:09:49 +0800
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
Subject: Re: [PATCH 5/6] hw/pci-bridge/cxl_upstream: Fix missing ERRP_GUARD()
 in cxl_usp_realize()
Message-ID: <ZdYSPYlZEL6jUobe@intel.com>
References: <20240221094317.994454-1-zhao1.liu@linux.intel.com>
 <20240221094317.994454-6-zhao1.liu@linux.intel.com>
 <87le7eujdx.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87le7eujdx.fsf@pond.sub.org>
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

On Wed, Feb 21, 2024 at 12:49:46PM +0100, Markus Armbruster wrote:
> Date: Wed, 21 Feb 2024 12:49:46 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [PATCH 5/6] hw/pci-bridge/cxl_upstream: Fix missing
>  ERRP_GUARD() in cxl_usp_realize()
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
> > Currently, since cxl_usp_realize() - as a PCIDeviceClass.realize()
> > method - doesn't get the NULL errp parameter, it doesn't trigger the
> > dereference issue.
> >
> > To follow the requirement of errp, add missing ERRP_GUARD() in
> > cxl_usp_realize()().
> >
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> > Suggested by credit:
> >  Markus: Referred his explanation about ERRP_GUARD().
> > ---
> >  hw/pci-bridge/cxl_upstream.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> > index e87eb4017713..03d123cca0ef 100644
> > --- a/hw/pci-bridge/cxl_upstream.c
> > +++ b/hw/pci-bridge/cxl_upstream.c
> > @@ -289,6 +289,7 @@ static void free_default_cdat_table(CDATSubHeader **cdat_table, int num,
> >  
> >  static void cxl_usp_realize(PCIDevice *d, Error **errp)
> >  {
> > +    ERRP_GUARD();
> >      PCIEPort *p = PCIE_PORT(d);
> >      CXLUpstreamPort *usp = CXL_USP(d);
> >      CXLComponentState *cxl_cstate = &usp->cxl_cstate;
> 
> The dereference is
> 
>        cxl_doe_cdat_init(cxl_cstate, errp);
>        if (*errp) {
>            goto err_cap;
>        }
> 
> As noted in review of PATCH 3, we check *errp, because
> cxl_doe_cdat_init() returns void.  Could be improved to return bool,
> along with its callees ct3_load_cdat() and ct3_build_cdat(), but that's
> a slightly more ambitious cleanup, so
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>

Thanks! It's a good idea and I can continue to consider such the cleanup
in the follow up.

Will also add the dereference description in commit message to make
review easier.

Regards,
Zhao



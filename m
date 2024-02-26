Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643AEC5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 15:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1redJX-0001ZO-F7; Mon, 26 Feb 2024 10:54:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1redJW-0001X2-IT; Mon, 26 Feb 2024 10:54:46 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1redJU-0003iu-RC; Mon, 26 Feb 2024 10:54:46 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk4nq4RQcz6897v;
 Mon, 26 Feb 2024 23:50:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 9543F140A78;
 Mon, 26 Feb 2024 23:54:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 15:54:42 +0000
Date: Mon, 26 Feb 2024 15:54:40 +0000
To: Zhao Liu <zhao1.liu@linux.intel.com>
CC: Markus Armbruster <armbru@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 Laurent Vivier <laurent@vivier.eu>, Alistair Francis
 <alistair@alistair23.me>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Alex
 Williamson" <alex.williamson@redhat.com>, "=?ISO-8859-1?Q?C=E9dric?= Le
 Goater" <clg@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 <qemu-trivial@nongnu.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 5/6] hw/pci-bridge/cxl_upstream: Fix missing
 ERRP_GUARD() in cxl_usp_realize()
Message-ID: <20240226155440.0000183f@Huawei.com>
In-Reply-To: <ZdYSPYlZEL6jUobe@intel.com>
References: <20240221094317.994454-1-zhao1.liu@linux.intel.com>
 <20240221094317.994454-6-zhao1.liu@linux.intel.com>
 <87le7eujdx.fsf@pond.sub.org> <ZdYSPYlZEL6jUobe@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 21 Feb 2024 23:09:49 +0800
Zhao Liu <zhao1.liu@linux.intel.com> wrote:

> On Wed, Feb 21, 2024 at 12:49:46PM +0100, Markus Armbruster wrote:
> > Date: Wed, 21 Feb 2024 12:49:46 +0100
> > From: Markus Armbruster <armbru@redhat.com>
> > Subject: Re: [PATCH 5/6] hw/pci-bridge/cxl_upstream: Fix missing
> >  ERRP_GUARD() in cxl_usp_realize()
> > 
> > Zhao Liu <zhao1.liu@linux.intel.com> writes:
> >   
> > > From: Zhao Liu <zhao1.liu@intel.com>
> > >
> > > As the comment in qapi/error, dereferencing @errp requires
> > > ERRP_GUARD():
> > >
> > > * = Why, when and how to use ERRP_GUARD() =
> > > *
> > > * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> > > * - It must not be dereferenced, because it may be null.
> > > * - It should not be passed to error_prepend() or
> > > *   error_append_hint(), because that doesn't work with &error_fatal.
> > > * ERRP_GUARD() lifts these restrictions.
> > > *
> > > * To use ERRP_GUARD(), add it right at the beginning of the function.
> > > * @errp can then be used without worrying about the argument being
> > > * NULL or &error_fatal.
> > > *
> > > * Using it when it's not needed is safe, but please avoid cluttering
> > > * the source with useless code.
> > >
> > > Currently, since cxl_usp_realize() - as a PCIDeviceClass.realize()
> > > method - doesn't get the NULL errp parameter, it doesn't trigger the
> > > dereference issue.
> > >
> > > To follow the requirement of errp, add missing ERRP_GUARD() in
> > > cxl_usp_realize()().
> > >
> > > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > > ---
> > > Suggested by credit:
> > >  Markus: Referred his explanation about ERRP_GUARD().
> > > ---
> > >  hw/pci-bridge/cxl_upstream.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> > > index e87eb4017713..03d123cca0ef 100644
> > > --- a/hw/pci-bridge/cxl_upstream.c
> > > +++ b/hw/pci-bridge/cxl_upstream.c
> > > @@ -289,6 +289,7 @@ static void free_default_cdat_table(CDATSubHeader **cdat_table, int num,
> > >  
> > >  static void cxl_usp_realize(PCIDevice *d, Error **errp)
> > >  {
> > > +    ERRP_GUARD();
> > >      PCIEPort *p = PCIE_PORT(d);
> > >      CXLUpstreamPort *usp = CXL_USP(d);
> > >      CXLComponentState *cxl_cstate = &usp->cxl_cstate;  
> > 
> > The dereference is
> > 
> >        cxl_doe_cdat_init(cxl_cstate, errp);
> >        if (*errp) {
> >            goto err_cap;
> >        }
> > 
> > As noted in review of PATCH 3, we check *errp, because
> > cxl_doe_cdat_init() returns void.  Could be improved to return bool,
> > along with its callees ct3_load_cdat() and ct3_build_cdat(), but that's
> > a slightly more ambitious cleanup, so
> > 
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> >  
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> 
> Thanks! It's a good idea and I can continue to consider such the cleanup
> in the follow up.
> 
> Will also add the dereference description in commit message to make
> review easier.
> 
> Regards,
> Zhao
> 



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3A1C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 15:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1redHn-0008QP-Rs; Mon, 26 Feb 2024 10:52:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1redHk-0008Pe-Th; Mon, 26 Feb 2024 10:52:56 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1redHi-0003ao-Kr; Mon, 26 Feb 2024 10:52:56 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk4lJ73chz6JBTb;
 Mon, 26 Feb 2024 23:48:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 046D0140A9C;
 Mon, 26 Feb 2024 23:52:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 15:52:46 +0000
Date: Mon, 26 Feb 2024 15:52:45 +0000
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
Subject: Re: [PATCH 1/6] hw/cxl/cxl-host: Fix missing ERRP_GUARD() in
 cxl_fixed_memory_window_config()
Message-ID: <20240226155245.00004a88@Huawei.com>
In-Reply-To: <ZdYQ99m6BXzxb+nf@intel.com>
References: <20240221094317.994454-1-zhao1.liu@linux.intel.com>
 <20240221094317.994454-2-zhao1.liu@linux.intel.com>
 <878r3evyth.fsf@pond.sub.org> <ZdYQ99m6BXzxb+nf@intel.com>
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

On Wed, 21 Feb 2024 23:04:23 +0800
Zhao Liu <zhao1.liu@linux.intel.com> wrote:

> On Wed, Feb 21, 2024 at 12:31:06PM +0100, Markus Armbruster wrote:
> > Date: Wed, 21 Feb 2024 12:31:06 +0100
> > From: Markus Armbruster <armbru@redhat.com>
> > Subject: Re: [PATCH 1/6] hw/cxl/cxl-host: Fix missing ERRP_GUARD() in
> >  cxl_fixed_memory_window_config()
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
> > > Currently, since machine_set_cfmw() - the caller of
> > > cxl_fixed_memory_window_config() - doesn't get the NULL errp parameter
> > > as the "set" method of object property, cxl_fixed_memory_window_config()
> > > doesn't trigger the dereference issue.
> > >
> > > To follow the requirement of errp, add missing ERRP_GUARD() in
> > > cxl_fixed_memory_window_config().
> > >
> > > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > > ---
> > > Suggested by credit:
> > >  Markus: Referred his explanation about ERRP_GUARD().
> > > ---
> > >  hw/cxl/cxl-host.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> > > index 2aa776c79c74..c5f5fcfd64d0 100644
> > > --- a/hw/cxl/cxl-host.c
> > > +++ b/hw/cxl/cxl-host.c
> > > @@ -26,6 +26,7 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
> > >                                             CXLFixedMemoryWindowOptions *object,
> > >                                             Error **errp)
> > >  {
> > > +    ERRP_GUARD();
> > >      g_autofree CXLFixedWindow *fw = g_malloc0(sizeof(*fw));
> > >      strList *target;
> > >      int i;  
> > 
> > The dereferences are
> > 
> >        fw->enc_int_ways = cxl_interleave_ways_enc(fw->num_targets, errp);
> >        if (*errp) {
> >            return;
> >        }
> > 
> > and
> > 
> >            fw->enc_int_gran =
> >                cxl_interleave_granularity_enc(object->interleave_granularity,
> >                                               errp);
> >            if (*errp) {
> >                return;
> >            }
> > 
> > We check *errp, because neither function returns a suitable error code.
> > 
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> >  
> 
> Thanks! I'll attach your description to the commit message.
Thanks for the explanation in the commit message and to Markus for
the cases it affected.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> Regards,
> Zhao
> 



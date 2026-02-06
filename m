Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13007EE209E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 12:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voLJM-0001MH-6s; Fri, 06 Feb 2026 07:51:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1voLJK-0001M9-V8
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:51:46 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1voLJH-0000Re-Q7
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:51:46 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6v8L0Qv7zJ46j1;
 Fri,  6 Feb 2026 20:50:42 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 5BE8940539;
 Fri,  6 Feb 2026 20:51:34 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Feb
 2026 12:51:33 +0000
Date: Fri, 6 Feb 2026 12:51:31 +0000
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, <linuxarm@huawei.com>
CC: Alireza Sanaee <alireza.sanaee@huawei.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
 "anisa.su887@gmail.com" <anisa.su887@gmail.com>, "mst@redhat.com"
 <mst@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "ppbonzini@redhat.com" <ppbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "david@kernel.org" <david@kernel.org>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "xiaoguangrong.eric@gmail.com"
 <xiaoguangrong.eric@gmail.com>, "venkataravis@micron.com"
 <venkataravis@micron.com>, "gourry@gourry.net" <gourry@gourry.net>
Subject: Re: [PATCH v2 1/2] hw/cxl: Use HPA in cxl_cfmws_find_device()
 rather than offset in window.
Message-ID: <20260206125131.00003c9d@huawei.com>
In-Reply-To: <0829feee-2bae-4557-8c0f-9ec329a17b2d@fujitsu.com>
References: <20260204150002.669-1-alireza.sanaee@huawei.com>
 <20260204150002.669-2-alireza.sanaee@huawei.com>
 <0829feee-2bae-4557-8c0f-9ec329a17b2d@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 6 Feb 2026 09:57:15 +0000
"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> wrote:

> On 04/02/2026 23:00, Alireza Sanaee wrote:
> > This function will shortly be used to help find if there is a route to a
> > device, serving an HPA, under a particular fixed memory window. Rather
> > than having that new use case subtract the base address in the caller,
> > only to add it again in cxl_cfmws_find_device(), push the responsibility
> > for calculating the HPA to the caller.
> > 
> > This also reduces the inconsistency in the meaning of the hwaddr
> > addr parameter between this function and the calls made within it
> > that access the HDM decoders that operating on HPA.
> > 
> > Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> > ---
> >   hw/cxl/cxl-host.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> > index f3479b1991..9633b01abf 100644
> > --- a/hw/cxl/cxl-host.c
> > +++ b/hw/cxl/cxl-host.c
> > @@ -168,8 +168,6 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
> >       bool target_found;
> >       PCIDevice *rp, *d;
> >   
> > -    /* Address is relative to memory region. Convert to HPA */
> > -    addr += fw->base;
> >   
> >       rb_index = (addr / cxl_decode_ig(fw->enc_int_gran)) % fw->num_targets;
> >       hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
> > @@ -254,7 +252,7 @@ static MemTxResult cxl_read_cfmws(void *opaque, hwaddr addr, uint64_t *data,
> >       CXLFixedWindow *fw = opaque;
> >       PCIDevice *d;
> >   
> > -    d = cxl_cfmws_find_device(fw, addr);
> > +    d = cxl_cfmws_find_device(fw, addr + fw->base, true);  
> 
> 
> It seems you've added an extra parameter to the calls to cxl_cfmws_find_device(), but its function signature wasn't updated.

Good spot. The extra parameter should be in the next patch.

Jonathan

> 
> 
> 
> Thanks
> Zhijian
> 
> 
> 
> >       if (d == NULL) {
> >           *data = 0;
> >           /* Reads to invalid address return poison */
> > @@ -271,7 +269,7 @@ static MemTxResult cxl_write_cfmws(void *opaque, hwaddr addr,
> >       CXLFixedWindow *fw = opaque;
> >       PCIDevice *d;
> >   
> > -    d = cxl_cfmws_find_device(fw, addr);
> > +    d = cxl_cfmws_find_device(fw, addr + fw->base, true);
> >       if (d == NULL) {
> >           /* Writes to invalid address are silent */
> >           return MEMTX_OK;  



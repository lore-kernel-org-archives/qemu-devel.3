Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86883E81BC3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 13:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpRcK-00084A-UO; Mon, 09 Feb 2026 08:47:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vpRcI-00083s-1q
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 08:47:55 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vpRcF-0001IP-7Y
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 08:47:53 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f8mFb0m9vzJ46d5;
 Mon,  9 Feb 2026 21:46:43 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 64C2040569;
 Mon,  9 Feb 2026 21:47:40 +0800 (CST)
Received: from localhost (10.203.177.99) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Feb
 2026 13:47:39 +0000
Date: Mon, 9 Feb 2026 13:47:34 +0000
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linuxarm@huawei.com"
 <linuxarm@huawei.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
 "anisa.su887@gmail.com" <anisa.su887@gmail.com>, "mst@redhat.com"
 <mst@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "ppbonzini@redhat.com" <ppbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "david@kernel.org" <david@kernel.org>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "xiaoguangrong.eric@gmail.com"
 <xiaoguangrong.eric@gmail.com>, "venkataravis@micron.com"
 <venkataravis@micron.com>, "gourry@gourry.net" <gourry@gourry.net>
Subject: Re: [PATCH v2 2/2] hw/cxl: Add a performant (and correct) path for
 the non interleaved cases
Message-ID: <20260209134734.00003598.alireza.sanaee@huawei.com>
In-Reply-To: <ae9d737c-6c2d-4ad1-b40e-62ea0e466696@fujitsu.com>
References: <20260204150002.669-1-alireza.sanaee@huawei.com>
 <20260204150002.669-3-alireza.sanaee@huawei.com>
 <ae9d737c-6c2d-4ad1-b40e-62ea0e466696@fujitsu.com>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.99]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 9 Feb 2026 03:06:00 +0000
"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> wrote:

> On 04/02/2026 23:00, Alireza Sanaee wrote:
> > The CXL address to device decoding logic is complex because of the need
> > to correctly decode fine grained interleave. The current implementation
> > prevents use with KVM where executed instructions may reside in that
> > memory and gives very slow performance even in TCG.  
> 
> 
> Do you mean KVM will work after this patch in 1-way case

Yes

> 
> 
> > 
> > In many real cases non interleaved memory configurations are useful and
> > for those we can use a more conventional memory region alias allowing
> > similar performance to other memory in the system.  
> 
> 
> Do you have any benchmark data to demonstrate the performance improvement?

Yes, if you setup a simple devdax application which sweeps through the region with reads and writes, it is easy to see the performance difference, in KVM/TCG. I can share more if you will.

> 
> 
> 
> > 
> > Co-developed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> > ---
> >   hw/cxl/cxl-component-utils.c |   8 ++
> >   hw/cxl/cxl-host.c            | 197 ++++++++++++++++++++++++++++++++++-
> >   hw/mem/cxl_type3.c           |   4 +
> >   include/hw/cxl/cxl.h         |   1 +
> >   include/hw/cxl/cxl_device.h  |   1 +
> >   5 files changed, 206 insertions(+), 5 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> > index d36162e91b..d459d04b6d 100644
> > --- a/hw/cxl/cxl-component-utils.c
> > +++ b/hw/cxl/cxl-component-utils.c
> > @@ -142,6 +142,14 @@ static void dumb_hdm_handler(CXLComponentState *cxl_cstate, hwaddr offset,
> >           value = FIELD_DP32(value, CXL_HDM_DECODER0_CTRL, COMMITTED, 0);
> >       }
> >       stl_le_p((uint8_t *)cache_mem + offset, value);
> > +
> > +    if (should_commit) {
> > +        cfmws_update_non_interleaved(true);
> > +    }
> > +
> > +    if (should_uncommit) {
> > +        cfmws_update_non_interleaved(false);
> > +    }  
> 
> 
> This might be slightly better as an if-else block, since should_commit and should_uncommit are mutually exclusive:
> 
> 
> if (should_commit) {
> 	cfmws_update_non_interleaved(true);;
> } else if (should_uncommit) {
> 	cfmws_update_non_interleaved(false);
> }
> 
> 
> >   }
> >   
> >   static void bi_handler(CXLComponentState *cxl_cstate, hwaddr offset,
> > diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> > index 9633b01abf..1fcfe01164 100644
> > --- a/hw/cxl/cxl-host.c
> > +++ b/hw/cxl/cxl-host.c
> > @@ -104,7 +104,7 @@ void cxl_fmws_link_targets(Error **errp)
> >   }
> >   
> >   static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
> > -                                uint8_t *target)
> > +                                uint8_t *target, bool *interleaved)
> >   {
> >       int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
> >       unsigned int hdm_count;
> > @@ -138,6 +138,11 @@ static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
> >           found = true;
> >           ig_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IG);
> >           iw_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IW);
> > +
> > +        if (interleaved) {
> > +            *interleaved = iw_enc != 0;
> > +        }
> > +
> >           target_idx = (addr / cxl_decode_ig(ig_enc)) % (1 << iw_enc);
> >   
> >           if (target_idx < 4) {
> > @@ -157,7 +162,8 @@ static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
> >       return found;  
> 
> [...]
> 
> > +
> > +static int update_non_interleaved(Object *obj, void *opaque)
> > +{
> > +    const int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
> > +    bool commit = *(bool *)opaque;
> > +    CXLType3Dev *ct3d;
> > +    uint32_t *cache_mem;
> > +    unsigned int hdm_count, i;
> > +    uint32_t cap;
> > +    uint64_t dpa_base = 0;
> > +
> > +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> > +        return 0;
> > +    }
> > +
> > +    ct3d = CXL_TYPE3(obj);
> > +    cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
> > +    cap = ldl_le_p(cache_mem + R_CXL_HDM_DECODER_CAPABILITY);
> > +    hdm_count = cxl_decoder_count_dec(FIELD_EX32(cap,
> > +                                                 CXL_HDM_DECODER_CAPABILITY,
> > +                                                 DECODER_COUNT));
> > +    /*
> > +     * Walk the decoders and find any committed with iw set to 0
> > +     * (non interleaved).
> > +     */
> > +    for (i = 0; i < hdm_count; i++) {
> > +        uint64_t decoder_base, decoder_size, skip;
> > +        uint32_t hdm_ctrl, low, high;
> > +        int iw, committed;
> > +
> > +        hdm_ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + i * hdm_inc);
> > +        committed = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED);
> > +        if (commit ^ committed) {  
> 
> 
> Is there any specific reason for using ^ here instead of '==' ?
> 
> 
> 
> Thanks
> Zhijian


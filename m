Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C14CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 14:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3bK5-0003wc-CJ; Tue, 30 Sep 2025 10:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3bJs-0003rz-I2
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:27:08 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3bJk-0003sL-8b
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:27:08 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cbgNW37N7z6L5Mb;
 Tue, 30 Sep 2025 22:26:35 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id A145D1402F5;
 Tue, 30 Sep 2025 22:26:49 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 30 Sep
 2025 15:26:48 +0100
Date: Tue, 30 Sep 2025 15:26:47 +0100
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
 <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <vishak.g@samsung.com>,
 <krish.reddy@samsung.com>, <a.manzanares@samsung.com>,
 <alok.rathore@samsung.com>, <arpit.sysdev@gmail.com>, <cpgs@samsung.com>
Subject: Re: [PATCH v4 1/2] hw/cxl: Refactored Identify Switch Device & Get
 Physical Port State
Message-ID: <20250930152647.00000e84@huawei.com>
In-Reply-To: <20250919110312.naudjnvhsjmxaxjk@test-PowerEdge-R740xd>
References: <20250916080736.1266083-1-arpit1.kumar@samsung.com>
 <CGME20250916080803epcas5p1cd11689108b259f21908d9779993cc0f@epcas5p1.samsung.com>
 <20250916080736.1266083-2-arpit1.kumar@samsung.com>
 <20250917165535.000021b1@huawei.com>
 <20250919110312.naudjnvhsjmxaxjk@test-PowerEdge-R740xd>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 19 Sep 2025 16:33:12 +0530
Arpit Kumar <arpit1.kumar@samsung.com> wrote:

> On 17/09/25 04:55PM, Jonathan Cameron wrote:
> >On Tue, 16 Sep 2025 13:37:35 +0530
> >Arpit Kumar <arpit1.kumar@samsung.com> wrote:
> >  
> >> -Storing physical ports info during enumeration.
> >> -Refactored changes using physical ports info for
> >>  Identify Switch Device (Opcode 5100h) & Get Physical Port State
> >>  (Opcode 5101h) physical switch FM-API command set.
> >>
> >> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>  
> >
> >Hi Arpit.  One question inline, and one comment on code I've moved
> >around whilst queue this up.  I'll push out a tree to gitlab
> >(probably tomorrow) and when I do please check I didn't mess that up!
> >
> >Jonathan
> >  
> 
> Hi Jonathan,
> Thank you for the swift response and review comments.
> Sure, will look into gitlab tree once up.

Oops. Got rather delayed on that - getting back to tree mangling this week.

> 
> Thanks,
> Arpit
> >  
> >> +static CXLRetCode cxl_set_port_type(CXLUpstreamPort *ports, int pnum,
> >> +                                    CXLCCI *cci)
> >> +{
> >> +    uint8_t current_port_config_state;
> >> +    uint8_t connected_device_type;
> >> +    uint8_t supported_ld_count;
> >> +    uint16_t lnkcap, lnkcap2, lnksta;
> >> +    PCIBus *bus;
> >> +    PCIDevice *port_dev;
> >> +    PCIEPort *usp = PCIE_PORT(cci->d);
> >> +
> >> +    if (usp->port == pnum) {
> >> +        port_dev = PCI_DEVICE(usp);
> >> +        current_port_config_state = CXL_PORT_CONFIG_STATE_USP;
> >> +        connected_device_type = CXL_PORT_CONNECTED_DEV_TYPE_NONE;
> >> +        supported_ld_count = 0;
> >> +    } else {
> >> +        bus = &PCI_BRIDGE(cci->d)->sec_bus;
> >> +        port_dev = pcie_find_port_by_pn(bus, pnum);
> >> +        if (port_dev) { /* DSP */
> >> +            PCIDevice *ds_dev = pci_bridge_get_sec_bus(PCI_BRIDGE(port_dev))
> >> +                ->devices[0];
> >> +            current_port_config_state = CXL_PORT_CONFIG_STATE_DSP;
> >> +            if (ds_dev) {
> >> +                if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
> >> +                    /* To-do: controllable */  
> >
> >In what sense controllable?  It should always match what the downstream device
> >is presenting as.  Do you ultimately mean if we mess with the alternate modes
> >and reset the port to have it come up as a PCI only device?
> >This will need to be more complex as we add different CXL type 3 device support
> >of course, but I'd still expect to auto detect it rather that control it directly.
> >  
> 
> This is with respect to your review comment from v1 patch:
> https://lore.kernel.org/qemu-devel/20250602135942.2773823-1-arpit1.kumar@samsung.com/T/
> As per my understanding, controllable was identification of the specific type of 
> CXL type 3 device and accordingly initializing connected_device_type. Since you 
> mention auto-detect, does it mean using object_get_typename() to identify the type
> of device and initiliaze it directly to connected_device_type rather than specifying
> it explicitly. If yes, then this anyways rules out controllable part, hence the comment
> can be removed.

Hmm. I thought I'd replied here, but seems not!

I meant indeed that we can query the downstream device to find out what it is and
assume that we have trained up to match that.

So agreed just dropping the comment is the easy way forward.

J



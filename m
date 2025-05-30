Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27983C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 15:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1E0-0000GR-L4; Fri, 30 May 2025 11:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uL1Dp-0000E8-1Q; Fri, 30 May 2025 11:00:39 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uL1Dl-0000o2-SQ; Fri, 30 May 2025 11:00:36 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b85wl0mC0z6K9FG;
 Fri, 30 May 2025 22:59:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id B752A1402FC;
 Fri, 30 May 2025 23:00:21 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 May
 2025 17:00:21 +0200
Date: Fri, 30 May 2025 16:00:19 +0100
To: Igor Mammedov <imammedo@redhat.com>
CC: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>,
 <gustavo.romero@linaro.org>, <anisinha@redhat.com>, <mst@redhat.com>,
 <shannon.zhaosl@gmail.com>, <pbonzini@redhat.com>, <philmd@linaro.org>,
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 05/25] hw/pci-host/gpex-acpi: Split host bridge OSC
 and DSM generation
Message-ID: <20250530160019.000061d1@huawei.com>
In-Reply-To: <20250530140516.35db4d52@imammedo.users.ipa.redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-6-eric.auger@redhat.com>
 <20250530110227.00003341@huawei.com>
 <20250530140516.35db4d52@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 30 May 2025 14:05:16 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Fri, 30 May 2025 11:02:27 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Tue, 27 May 2025 09:40:07 +0200
> > Eric Auger <eric.auger@redhat.com> wrote:
> >   
> > > acpi_dsdt_add_pci_osc() name is confusing as it gives the impression
> > > it appends the _OSC method but in fact it also appends the _DSM method
> > > for the host bridge. Let's split the function into two separate ones
> > > and let them return the method Aml pointer instead. This matches the
> > > way it is done on x86 (build_q35_osc_method). In a subsequent patch
> > > we will replace the gpex method by the q35 implementation that will
> > > become shared between ARM and x86.
> > > 
> > > acpi_dsdt_add_host_bridge_methods is a new top helper that generates
> > > both the _OSC and _DSM methods.
> > > 
> > > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>    
> > 
> > Makes complete sense. I've had local equivalent of this on the CXL
> > tree for a while as without it we don't register the _DSM for the
> > CXL path (and we should).  However, can you modify it a little to
> > make that easier for me?  Basically make sure the _DSM is registered
> > for the CXL path as well.
> >   
> [...]
> unless CXL is root host bridge, current _DSM shouldn't be added to it.
> read on comment below.

I'm not clear how this is different from pxb-pcie where we do have
the _DSM. Both are pretending to be real host bridges.

> 
> > > @@ -124,7 +125,17 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
> > >      byte_list[0] = 0;
> > >      buf = aml_buffer(1, byte_list);
> > >      aml_append(method, aml_return(buf));
> > > -    aml_append(dev, method);
> > > +    return method;
> > > +}
> > > +
> > > +static void acpi_dsdt_add_host_bridge_methods(Aml *dev,
> > > +                                              bool enable_native_pcie_hotplug)
> > > +{
> > > +    aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
> > > +    aml_append(dev, aml_name_decl("CTRL", aml_int(0)));    
> > 
> > These two declarations seem to be very much part of the _OSC build though not
> > within the the method.  I 'think' you get left with them later with no users.
> > So move them into the osc build here and they will naturally go away when
> > you move to the generic code.
> > 
> > They end up unused in the DSDT at the end of the series.
> > 
> > I ran a quick GPEX + pxb-pcie test and we do get the odd mix that the OSC for
> > the GPEX say no native hotplug but the OSC for the PXB allows it.  
> 
> It's fine for each PXB to have it's own _OSC.
> Also current incarnation of ACPI pcihp doesn't support PXBs at all,
> it would be wrong to enable the on PXBs.
> 
> Thus I'd avoid touching CXL related code paths from this series.
> 
> I'm working on extending ACPI pcihp to PXBs
> (for the same reason as Eric does for arm/virt, i.e. enable acpi-index support there).
> I can add CXL bits then if there is a need/demand for that in CXL land.

Ok.  My original motivation for _DSM on CXL was function 5 to stop Linux messing up
the reenumeration which I know has been rejected upstream for a bunch of
compatibility reasons.  Anyhow, that's a future problem.

Thanks,

Jonathan

> 
> [...]
> 
> 



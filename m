Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5AAC54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 10:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfdZ0-0005tL-3i; Thu, 29 Feb 2024 05:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rfdYy-0005t3-Pc; Thu, 29 Feb 2024 05:22:52 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rfdYw-0003kS-92; Thu, 29 Feb 2024 05:22:52 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TlnH11gCjz6K65v;
 Thu, 29 Feb 2024 18:18:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id EC0DC140A35;
 Thu, 29 Feb 2024 18:22:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Feb
 2024 10:22:31 +0000
Date: Thu, 29 Feb 2024 10:22:30 +0000
To: Ankit Agrawal <ankita@nvidia.com>
CC: Markus Armbruster <armbru@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, Zhi Wang <zhiw@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Aniket
 Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, "Andy Currid" <acurrid@nvidia.com>, Dheeraj Nigam
 <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 1/2] qom: new object to associate device to numa node
Message-ID: <20240229102230.00004277@Huawei.com>
In-Reply-To: <SA1PR12MB7199F868F1C300B1E795CD39B0582@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20240223124223.800078-1-ankita@nvidia.com>
 <20240223124223.800078-2-ankita@nvidia.com>
 <8734td3uty.fsf@pond.sub.org> <20240228135504.00005d12@Huawei.com>
 <87bk80vaft.fsf@pond.sub.org>
 <SA1PR12MB7199F868F1C300B1E795CD39B0582@SA1PR12MB7199.namprd12.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

On Wed, 28 Feb 2024 16:50:30 +0000
Ankit Agrawal <ankita@nvidia.com> wrote:

> >>> Jonathan, you pointed out interface design issues in your review of v2.>  
> >> Are you fully satisfied with the interface in v3?
> >>
> >> Yes. I'm fine with the interface in this version (though it's v7, so I'm lost
> >> on v2 vs v3!)  
> >
> > Looks like I can't count to 7!
> >
> > With NUMA capitalized in the doc comment, QAPI schema
> > Acked-by: Markus Armbruster <armbru@redhat.com>
> >
> > Thanks!  
> 
> Thanks! Will fix that in the next version.

The following is really me arguing with myself, so can probably be
ignored, but maybe it will spark an idea from someone else!

One trivial tweak that might make our life easier if anyone adds
support in the future for the other device handle type might be to go
with simply dev rather than pci-dev.

There is a sticky corner though if a device is a PCI device
and in ACPI DSDT so maybe we are better off adding acpi-dev
to take either pci-dev or acpi-dev?

Annoyingly for generic ports, (I'm reusing this infrastructure here)
the kernel code currently only deals with the ACPI form (for CXL host
bridges).  Given I point that at the bus of a PXB_CXL it is both
a PCI device, and the only handle we have for getting to the
Root Bridge ACPI handle.

So I think I've argued myself around to thinking we need to extend
the interface with another optional parameter if we ever do support
the ACPI handle for generic initiators :(

Jonathan


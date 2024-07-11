Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB3BC3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 15:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRvtA-0003du-DU; Thu, 11 Jul 2024 11:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sRvt7-0003c9-Ri
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 11:39:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sRvsz-0004yp-D9
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 11:39:17 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WKf3M3f8Dz67y8R;
 Thu, 11 Jul 2024 23:36:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 0D2C91400D3;
 Thu, 11 Jul 2024 23:38:53 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 11 Jul
 2024 16:38:52 +0100
Date: Thu, 11 Jul 2024 16:38:51 +0100
To: Igor Mammedov <imammedo@redhat.com>
CC: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v4 06/13] acpi/pci: Move Generic Initiator object
 handling into acpi/pci.*
Message-ID: <20240711163851.00002f93@Huawei.com>
In-Reply-To: <20240711141240.0ec77fd2@imammedo.users.ipa.redhat.com>
References: <20240702131428.664859-1-Jonathan.Cameron@huawei.com>
 <20240702131428.664859-7-Jonathan.Cameron@huawei.com>
 <20240711141240.0ec77fd2@imammedo.users.ipa.redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


> > diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
> > index 20b70dcd81..174b490e5f 100644
> > --- a/hw/acpi/pci.c
> > +++ b/hw/acpi/pci.c
> > @@ -24,8 +24,12 @@
> >   */
> >  
> >  #include "qemu/osdep.h"
> > +#include "qemu/error-report.h"  
> 
> > +#include "qapi/error.h"  
> is this necessary? 
> it seems to be compiling just fine without it.
The error_fatal extern is in there.

I guess there is a non obvious path via which that's getting included
anyway. is in there and it's not obvious how it is included I'd rather
keep it as an explicit include to reduce fragility if the chain of
includes involved gets changed.


> 
> > +#include "hw/boards.h"
> >  #include "hw/acpi/aml-build.h"
> >  #include "hw/acpi/pci.h"
> > +#include "hw/pci/pci_device.h"
> >  #include "hw/pci/pcie_host.h"
> >  


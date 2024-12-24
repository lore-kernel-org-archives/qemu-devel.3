Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1F4E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6b7-00052Q-0A; Tue, 24 Dec 2024 10:13:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tQ6b5-00052E-4v
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:13:23 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tQ6b2-0003aV-OA
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:13:22 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHdfD0kkvz6LCrH;
 Tue, 24 Dec 2024 23:12:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 8A8A5140B73;
 Tue, 24 Dec 2024 23:13:17 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 16:13:17 +0100
Date: Tue, 24 Dec 2024 15:13:15 +0000
To: Gregory Price <gourry@gourry.net>
CC: Hongjian Fan <hongjian.fan@seagate.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "fan.ni@samsung.com" <fan.ni@samsung.com>
Subject: Re: [PATCH] hw/mem: support zero memory size CXL device
Message-ID: <20241224151315.0000068e@huawei.com>
In-Reply-To: <Z1iS2SeYSOQqdLVU@PC2K9PVX.TheFacebook.com>
References: <20241202230310.1531219-1-hongjian.fan@seagate.com>
 <20241203172328.00001a00@huawei.com>
 <CH0PR20MB42505D4F82D534A85EEA4C2A90362@CH0PR20MB4250.namprd20.prod.outlook.com>
 <Z1iS2SeYSOQqdLVU@PC2K9PVX.TheFacebook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.156.150]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, 10 Dec 2024 14:13:29 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Tue, Dec 03, 2024 at 09:15:51PM +0000, Hongjian Fan wrote:
> > Hi Jonathan,
> > 
> > I'm trying to emulate our memory appliance which is similar to a MH-SLD. The memory device is connected to the host server while the size of the memory could be changed by the out-of-band fabric manager. If there is no memory assigned to the host, the CXL device will be booted as zero memory size.  
> 
> This should not be how this is done.
Agreed, but...

It sounds like a pre DCD boot time only pooling solution?

What is the path to adding memory?

> 
> The ACPI tables should report the maximum possible size, and the DCD
> infrastructure should enable physical regions that have been added to the host.
> 
> Changing ACPI tables to report 0 memory size will basically result
> in the host memory map not reserving physical memory regions for that
> device.
This isn't the ACPI bit, it's just the device reporting.  Can have a huge
CFMWS and tiny devices.

> 
> See this emulation example of an MHSLD - which can be used for DCD.
> 
> https://lore.kernel.org/linux-cxl/20241018161252.8896-1-gourry@gourry.net/
> 
> > Recently we got some interest on trying our fabric manager software without having the real hardware. Supporting zero memory size in QEMU will be needed in this scenario.
> > Some detail about our memory appliance could be found from our OCP presentation: https://drive.google.com/file/d/1i8kBsBfRGjNqnTQqJ9upC-Xm9o56Y2Y5/view?usp=drive_link

That doesn't really give me any indication of how the addition of memory happens.

Jonathan

> > 
> > Thanks,
> > Hongjian Fan
> > 
> > 
> > Seagate Internal  



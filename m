Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26745C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 11:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYkLH-0003pT-Ql; Fri, 17 Jan 2025 06:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tYkLG-0003pB-8T; Fri, 17 Jan 2025 06:16:46 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tYkLD-0002iO-Sw; Fri, 17 Jan 2025 06:16:46 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YZHFP5HLnz6M4QF;
 Fri, 17 Jan 2025 19:14:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id AF77F140CB9;
 Fri, 17 Jan 2025 19:16:37 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 17 Jan
 2025 12:16:37 +0100
Date: Fri, 17 Jan 2025 11:16:35 +0000
To: Michael Tokarev <mjt@tls.msk.ru>
CC: Li Zhijian <lizhijian@fujitsu.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>, Fan Ni <fan.ni@samsung.com>, qemu-stable
 <qemu-stable@nongnu.org>
Subject: Re: [PATCH v3] hw/cxl: Fix msix_notify: Assertion `vector <
 dev->msix_entries_nr`
Message-ID: <20250117111635.00004e94@huawei.com>
In-Reply-To: <9c06632b-751b-4a2f-aa87-e07691bebfba@tls.msk.ru>
References: <20250115075834.167504-1-lizhijian@fujitsu.com>
 <9c06632b-751b-4a2f-aa87-e07691bebfba@tls.msk.ru>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-1.797, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, 17 Jan 2025 10:20:44 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> 15.01.2025 10:58, Li Zhijian via wrote:
> > This assertion always happens when we sanitize the CXL memory device.
> > $ echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize
> > 
> > It is incorrect to register an MSIX number beyond the device's capability.
> > 
> > Increase the device's MSIX number to cover the mailbox msix number(9).  
> 
> This seems to be like a qemu-stable material (8.2+), is it not?

It is.
Thanks


> 
> Thanks,
> 
> /mjt
> 
> > Fixes: 43efb0bfad2b ("hw/cxl/mbox: Wire up interrupts for background completion")
> > Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> > ---
> > V3:
> >    Just increate the device's msix number, A new enumeration will be introduced in later patch. # Jonathan
> > 
> > V2:
> >    Just increase msix number and add enum to maintainer their values # Jonathan
> > ---
> >   hw/mem/cxl_type3.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index bd7652740f4b..0ae1704a345c 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -843,7 +843,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
> >       ComponentRegisters *regs = &cxl_cstate->crb;
> >       MemoryRegion *mr = &regs->component_registers;
> >       uint8_t *pci_conf = pci_dev->config;
> > -    unsigned short msix_num = 6;
> > +    unsigned short msix_num = 10;
> >       int i, rc;
> >       uint16_t count;
> >     
> 



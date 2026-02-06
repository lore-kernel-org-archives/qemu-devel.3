Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6104EB28FE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 09:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voIMX-0008VH-0q; Fri, 06 Feb 2026 04:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1voIMV-0008Ut-9U; Fri, 06 Feb 2026 04:42:51 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1voIMS-000670-Cy; Fri, 06 Feb 2026 04:42:51 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6pyP0YLSzJ46jG;
 Fri,  6 Feb 2026 17:41:49 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 2D58F40565;
 Fri,  6 Feb 2026 17:42:41 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Feb
 2026 09:42:40 +0000
Date: Fri, 6 Feb 2026 09:42:39 +0000
To: Michael Tokarev <mjt@tls.msk.ru>
CC: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>, "Vinayak
 Holikatti" <vinayak.kh@samsung.com>, <linuxarm@huawei.com>,
 <linux-cxl@vger.kernel.org>, Ravi Shankar <venkataravis@micron.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH qemu 0/2] hw/cxl: Two media operations related fixes.
Message-ID: <20260206094239.000065c4@huawei.com>
In-Reply-To: <3e767269-b39c-42e2-8283-598e16aa7b71@tls.msk.ru>
References: <20260102154731.474859-1-Jonathan.Cameron@huawei.com>
 <3e767269-b39c-42e2-8283-598e16aa7b71@tls.msk.ru>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
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

On Fri, 6 Feb 2026 01:11:55 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> On 1/2/26 18:47, Jonathan Cameron via wrote:
> > Peter reported both of these last cycle.  Both are related to sanity
> > checking parameters.
> > 
> > Jonathan Cameron (2):
> >    hw/cxl: Check for overflow on santize media as both base and offset
> >      64bit.
> >    hw/cxl: Take into account how many media operations are requested for
> >      param check
> > 
> >   hw/cxl/cxl-mailbox-utils.c | 11 ++++++++---
> >   1 file changed, 8 insertions(+), 3 deletions(-)  
> 
> Is this one worth picking up for qemu-stable (10.1.x & 10.2.x)?
> 
They are fairly obscure features but if it applies cleanly it seems
sensible to backport.

Thanks

Jonathan

> Thanks,
> 
> /mjt



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1BDC5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 16:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sizD7-0005Pv-JH; Tue, 27 Aug 2024 12:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sizD3-0005ON-MW
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 12:38:21 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sizD1-00022x-4r
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 12:38:21 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtY6q5Srwz6L6sV;
 Wed, 28 Aug 2024 00:34:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id B3CEC140A35;
 Wed, 28 Aug 2024 00:38:14 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 17:38:14 +0100
Date: Tue, 27 Aug 2024 17:38:13 +0100
To: ajay.opensrc <ajay.opensrc@micron.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "john@jagalactic.com" <john@jagalactic.com>, Eishan Mirakhur
 <emirakhur@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, "Srinivasulu
 Thanneeru" <sthanneeru@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
 Aravind Ramesh <arramesh@micron.com>, "Davidlohr Bueso" <dave@stgolabs.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S. Tsirkin"
 <mst@redhat.com>
Subject: Re: [EXT] Re: [PATCH] hw/cxl: Fix background completion percentage
 calculation
Message-ID: <20240827173813.00001cab@Huawei.com>
In-Reply-To: <ad56f019ee6e43f4b209a814f5494af0@micron.com>
References: <20240729102338.22337-1-ajay.opensrc@micron.com>
 <svy4snogtc2k5423b4vtmzaoaryetmxzatjfiqfeiywepkr7us@dcslpmazfuw5>
 <ad56f019ee6e43f4b209a814f5494af0@micron.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 27 Aug 2024 16:01:54 +0000
ajay.opensrc <ajay.opensrc@micron.com> wrote:

> > From: Davidlohr Bueso <dave@stgolabs.net>
> > 
> > On Mon, 29 Jul 2024, ajay.opensrc@micron.com wrote:\n  
> > >From: Ajay Joshi <ajayjoshi@micron.com>
> > >
> > >The current completion percentage calculation does not account for the
> > >relative time since the start of the background activity, this leads to
> > >showing incorrect start percentage vs what has actually been completed.
> > >
> > >This patch calculates the percentage based on the actual elapsed time
> > >since the start of the operation.
> > >
> > >Fixes: 221d2cfbdb ("hw/cxl/mbox: Add support for background
> > >operations")
> > >
> > >Signed-off-by: Ajay Joshi <ajay.opensrc@micron.com>  
> > 
> > Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>  
> 
> Ping.
> Jonathan, this patch was reviewed by Dave already.
> Do you have any comments on this patch?

Sorry bit behind. Seems fine to me.   I'll queue it up, but not sure
when I'll get a fixes series out (hopefully soon!)

+CC Michael in meantime.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
in case Michael wants to pick it up directly.

Thanks,

Jonathan

> 
> Ajay


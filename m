Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC42C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 17:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfj8c-0001Sx-Px; Wed, 05 Feb 2025 12:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tfj8Z-0001Qw-Vs
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 12:24:32 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tfj8X-0007ZG-3N
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 12:24:31 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yp6Wr3rCVz6J9St;
 Thu,  6 Feb 2025 01:23:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 7CBA8140593;
 Thu,  6 Feb 2025 01:24:16 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Feb
 2025 18:24:15 +0100
Date: Wed, 5 Feb 2025 17:24:14 +0000
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <ajay.opensrc@micron.com>, <fan.ni@samsung.com>, <john@jagalactic.com>,
 <emirakhur@micron.com>, <ajayjoshi@micron.com>, <sthanneeru@micron.com>,
 <ravis.opensrc@micron.com>, <arramesh@micron.com>, <tmmulgund@micron.com>,
 <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH] hw/cxl: Support aborting background commands
Message-ID: <20250205172414.00007486@huawei.com>
In-Reply-To: <20250205044749.xoo73gewwjahxj6k@offworld>
References: <20240813221255.179200-1-dave@stgolabs.net>
 <20240827163357.0000228e@Huawei.com>
 <jdipjanthgt6atlksngodxjevfb5d43d5rshtxqxxwruszqa3e@vctljs77lg4e>
 <20241022180030.00004f68@Huawei.com>
 <20250203150706.00000e23@huawei.com>
 <20250205044749.xoo73gewwjahxj6k@offworld>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 4 Feb 2025 20:47:49 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Mon, 03 Feb 2025, Jonathan Cameron wrote:
> 
> >On Tue, 22 Oct 2024 18:00:30 +0100
> >Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >  
> >> On Mon, 21 Oct 2024 20:23:46 -0700
> >> Davidlohr Bueso <dave@stgolabs.net> wrote:
> >>  
> >> > On Tue, 27 Aug 2024, Jonathan Cameron wrote:\n  
> >> > >No comments inline and LGTM. I'll queue it on my tree and push
> >> > >that out on gitlab sometime soonish.  
> >> >
> >> > I don't see this picked up, which is a good thing atm. While testing
> >> > the kernel side, I noticed the following is needed, will send a v2
> >> > with it folded in.  
> >>
> >> Currently just on my cxl-2024-10-15 branch of gitlab.com/jic23/qemu.
> >> I'll pick up your v2 and replace that.  
> >
> >Hi Davidlohr,
> >
> >Did I miss v2, or still to send?  
> 
> Ah, thanks for the reminder, I had forgotten to send it out.
> 
> Actually, considering you have been carrying v1 for a while now,
> would it not be cleaner/better just rebasing the diff and sending you
> that instead of a whole new v2? Otherwise, I'm not sure what to do
> when working on your latest 2025-01-24 branch.

Pick point where I'm carrying it and post a patch based on the
next commit up.  Just let me know you've done that and all
should be good.

Jonathan


> 
> Thanks,
> Davidlohr



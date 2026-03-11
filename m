Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600221125859
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0NX6-0001TA-T4; Wed, 11 Mar 2026 13:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0NWz-0001PZ-EJ; Wed, 11 Mar 2026 13:39:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0NWr-0003R2-4b; Wed, 11 Mar 2026 13:39:33 -0400
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWHzK61NXzJ46FB;
 Thu, 12 Mar 2026 01:38:37 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 64FD340584;
 Thu, 12 Mar 2026 01:39:24 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 11 Mar
 2026 17:39:23 +0000
Date: Wed, 11 Mar 2026 17:39:22 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 41/65] target/arm: GICv5 cpuif: Calculate the highest
 priority PPI
Message-ID: <20260311173922.0000794e@huawei.com>
In-Reply-To: <CAFEAcA9UOGk3WZG3Dx5NmEAd4DUY0o+hnPo0+F5MGeMTcAyS1w@mail.gmail.com>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-42-peter.maydell@linaro.org>
 <20260311165151.00004669@huawei.com>
 <CAFEAcA9UOGk3WZG3Dx5NmEAd4DUY0o+hnPo0+F5MGeMTcAyS1w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Wed, 11 Mar 2026 17:08:11 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Wed, 11 Mar 2026 at 16:51, Jonathan Cameron
> <jonathan.cameron@huawei.com> wrote:
> >
> > On Mon, 23 Feb 2026 17:01:48 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >  
> > > When the state of PPIs changes, recalculate the highest priority PPI.
> > > In subsequent commits we will use this cached value to provide the
> > > HPPI info to the guest, decide whether to signal IRQ or FIQ, handle
> > > interrupt acknowldge from the guest, and so on.
> > >
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>  
> >
> > Other than struggling with the reference, LGTM
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> >  
> > > +/*
> > > + * We keep track of candidate highest possible pending interrupts
> > > + * using this struct.
> > > + *
> > > + * Unlike GICv3, we don't need a separate NMI bool, because for
> > > + * GICv5 superpriority is signaled by @prio == 0.
> > > + *
> > > + * In this struct the intid includes the interrupt type in bits [31:29]
> > > + * (i.e. it is in the form defined by R_TJPHS).  
> > Not sure it matters, but the particular GIC v5 spec I'm looking doesn't
> > seem to have a R_TJPHS (I happen to have EAC0)  
> 
> Hmm. It's in the EAC0 download from
> https://developer.arm.com/documentation/aes0070/latest/
> in section 2.4, on page 32, second rule from the bottom.
Yup. User error. :(  Appears I can't search in acrobat.
Sorry for waste of time!
> 
> thanks
> -- PMM
> 



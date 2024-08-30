Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2551ACA1009
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 18:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk6c2-0002z6-Hg; Fri, 30 Aug 2024 14:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1sk6bz-0002xn-UW; Fri, 30 Aug 2024 14:44:44 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1sk6bx-0001mR-67; Fri, 30 Aug 2024 14:44:43 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WwRn72ZGbz67ZDL;
 Sat, 31 Aug 2024 02:41:15 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
 by mail.maildlp.com (Postfix) with ESMTPS id E39181402C7;
 Sat, 31 Aug 2024 02:44:34 +0800 (CST)
Received: from localhost (10.47.73.222) by lhrpeml500006.china.huawei.com
 (7.191.161.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 19:44:34 +0100
Date: Fri, 30 Aug 2024 19:44:29 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <linuxarm@huawei.com>,
 <richard.henderson@linaro.org>, <shameerali.kolothum.thodi@huawei.com>,
 <Jonathan.Cameron@huawei.com>, <jiangkunkun@huawei.com>
Subject: Re: [PATCH] target/arm/tcg: refine cache descriptions with a wrapper
Message-ID: <20240830194429.00005f84@huawei.com>
In-Reply-To: <CAFEAcA8d9SfCTSk02fg3C+t0mAQkanMPeYTahn0vWOOMnoCsAA@mail.gmail.com>
References: <20240830161932.44-1-alireza.sanaee@huawei.com>
 <CAFEAcA8d9SfCTSk02fg3C+t0mAQkanMPeYTahn0vWOOMnoCsAA@mail.gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.73.222]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 30 Aug 2024 17:29:59 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 30 Aug 2024 at 17:19, Alireza Sanaee
> <alireza.sanaee@huawei.com> wrote:
> >
> > Add wrapper for different types of CPUs available in tcg to decribe
> > caches. Two functions `make_ccsidr32` and `make_ccsidr64`
> > describing descriptions. The 32 bit version receives extra
> > parameters that became unknown later in 64 bit.
> >
> > For CCSIDR register, 32 bit version follows specification [1].
> > Conversely, 64 bit version follows specification [2].
> >
> > [1] B4.1.19, ARM Architecture Reference Manual ARMv7-A and ARMv7-R
> > edition, https://developer.arm.com/documentation/ddi0406
> > [2] D23.2.29, ARM Architecture Reference Manual for A-profile
> > Architecture, https://developer.arm.com/documentation/ddi0487/latest/  
> 
> Could you explain in the commit message the reason for
> making this change, please?
> 
> thanks
> -- PMM

Sure. Just to clarify here, the patch allows for
easier manipulation of cache register description which can be handy for
testing in particular, and it cleans up existing descriptions of course.

Thanks,
Alireza


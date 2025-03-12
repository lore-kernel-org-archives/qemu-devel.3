Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D43C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 18:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsQT3-0003J1-J7; Wed, 12 Mar 2025 14:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tsQSt-0003HU-Gx
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 14:06:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tsQSq-0000Rr-TO
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 14:05:59 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZCdld42Pjz6J9mG;
 Thu, 13 Mar 2025 02:03:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 73CDB1400D3;
 Thu, 13 Mar 2025 02:05:45 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Mar
 2025 19:05:44 +0100
Date: Wed, 12 Mar 2025 18:05:43 +0000
To: Junjie Fu <fujunjie1@qq.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <viacheslav.dubeyko@bytedance.com>, <zhitingz@cs.utexas.edu>, Gregory Price
 <gourry@gourry.net>, <svetly.todorov@memverge.com>
Subject: Re: CXL memory pooling emulation inqury
Message-ID: <20250312180543.00002132@huawei.com>
In-Reply-To: <tencent_E9F3F01E0D2303378E16505CE4CF208AA908@qq.com>
References: <20230215151854.00003e34@Huawei.com>
 <tencent_E9F3F01E0D2303378E16505CE4CF208AA908@qq.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On Mon, 10 Mar 2025 16:02:45 +0800
Junjie Fu <fujunjie1@qq.com> wrote:

> > Note though that there is a long way to go before we can do what you
> > want.  The steps I'd expect to see along the way:
> >
> > 1) Emulate an Multi Headed Device.
> >    Initially connect two heads to different host bridges on a single QEMU
> >    machine.  That lets us test most of the code flows without needing
> >    to handle tests that involve multiple machines.
> >    Later, we could add a means to connect between two instances of QEMU.
> > 2) Add DCD support (we'll need the kernel side of that as well)
> > 3) Wire it all up.
> > 4) Do the same for a Switch with MLDs behind it so we can poke the fun
> >    corners.  
> 
> 
> Hi,Jonathan
> 
> Given your previous exploration, I would like to ask the following questions:
> 1.Does QEMU currently support simulating the above CXL memory pooling scenario?

Not in upstream yet but Gregory posted emulation support last year.
https://lore.kernel.org/qemu-devel/20241018161252.8896-1-gourry@gourry.net/
I'm carrying the patches on my staging tree.

https://gitlab.com/jic23/qemu/-/commits/cxl-2025-02-20?ref_type=heads

Longer term I remain a little unconvinced by whether this is the best approach
because I also want a single management path (so fake CCI etc) and that may
need to be exposed to one of the hosts for tests purposes.  In the current
approach commands are issued to each host directly to surface memory.

> 
> 2.If not fully supported yet, are there any available development branches 
> or patches that implement this functionality?
> 
> 3.Are there any guidelines or considerations for configuring and testing CXL memory pooling in QEMU?

There is some information in that patch series cover letter.

+CC Gregory and Svelty.
> 
> I sincerely appreciate your time and guidance on this topic!
> 
No problem.

Jonathan




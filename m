Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B89EC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKi43-0005k2-PX; Fri, 21 Jun 2024 13:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sKi40-0005fy-Bg
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:28:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sKi3y-0007Pl-LN
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:28:40 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W5PRl6GLPz6K99X;
 Sat, 22 Jun 2024 01:26:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id E1346140CB9;
 Sat, 22 Jun 2024 01:28:34 +0800 (CST)
Received: from localhost (10.122.19.247) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Jun
 2024 18:28:34 +0100
Date: Fri, 21 Jun 2024 18:28:33 +0100
To: Svetly Todorov <svetly.todorov@memverge.com>
CC: <qemu-devel@nongnu.org>, Gregory Price <gregory.price@memverge.com>,
 <linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>
Subject: Re: [PATCH RFC v2 0/3] cxl: Multi-headed Single Logical Device (MHSLD)
Message-ID: <20240621182833.000029c9@huawei.com>
In-Reply-To: <20240424-cxl-2024-04-22-pullahead-v2-0-a87fc4597795@memverge.com>
References: <20240424-cxl-2024-04-22-pullahead-v2-0-a87fc4597795@memverge.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Wed, 24 Apr 2024 13:04:05 -0700
Svetly Todorov <svetly.todorov@memverge.com> wrote:

> MHSLDs allow multiple hosts to access dynamic capacity on a single
> backing device. This complicates DC management because adds,
> removals, and accesses need to be vetted such that hosts don't
> stomp on each other's data.
> 
> This patchset proposes a set of hooks to be called in cxl_type3.c
> when each of the above events happens. The results of the hooks
> can be used to prevent illegal DC operations in the corresponding
> cxl_* functions. 

Hi,

I had a quick go at applying this to my gitlab tree cxl staging tree
to make it more generally available.  It unfortunately needs some updates
for the change to Extent Groups in the most recent DCD code.

Whilst I can probably sort that, it's going to happen particularly soon.

I'll be pushing a new tree shortly if you have time to rebase.

Jonathan


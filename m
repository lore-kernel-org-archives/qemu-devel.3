Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF21AC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 15:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1radV9-0006MH-P1; Thu, 15 Feb 2024 10:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1radV5-0006JU-Us; Thu, 15 Feb 2024 10:18:12 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1radV3-0005qY-EY; Thu, 15 Feb 2024 10:18:11 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbJWd0DZXz6K8xR;
 Thu, 15 Feb 2024 23:14:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id D0D2F140DAF;
 Thu, 15 Feb 2024 23:18:04 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 15:18:04 +0000
To: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Gregory
 Price <gregory.price@memverge.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
 <alex.bennee@linaro.org>, <richard.henderson@linaro.org>
CC: <linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>, <linuxarm@huawei.com>
Subject: [RFC PATCH 0/1] target/arm: Fix FEAT_HADFS when page tables are in
 MMIO (cxl)
Date: Thu, 15 Feb 2024 15:18:03 +0000
Message-ID: <20240215151804.2426-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

https://lore.kernel.org/qemu-devel/20240215150133.2088-1-Jonathan.Cameron@huawei.com/
gives more details of the reason the CXL emulation uses MMIO space
(short answer is it has very fine grained address routing).

Obviously this one is lower priority for me to upstream as the ARM support in
general is only in my CXL staging tree (I'll get back to that soonish).

The equivalent tests with CXL memory and forcing applications to run from it
on ARM64 TCG ran into an additional issue.  We need to be able to do
atomic compare and swap to update the access and dirty flags as part of
a page walk if we have the ARM 8.1 FEAT_HADFS (note you can disable this in
the kernel then this problem isn't hit but that's not a viable long term
solution though it did help me diagnose the problem)

As the patch says I'm far from confident on this fix. Whilst it 'works'
for little endian at least I'm hoping someone more familiar with the locking
requirements etc can let me know if the BQL is the right option here and
people can give a general opinion on whether such a hack is the right
solution.

Jonathan Cameron (1):
  arm/ptw: Handle atomic updates of page tables entries in MMIO during
    PTW.

 target/arm/ptw.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

-- 
2.39.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D04DC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 15:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI7nj-0000zp-E6; Thu, 22 May 2025 11:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uI7ne-0000zT-Oo
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:25:39 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uI7na-0000Wt-6F
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:25:37 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b3Bq51Cmqz6L5MP;
 Thu, 22 May 2025 23:22:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 156AC1402FC;
 Thu, 22 May 2025 23:25:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 22 May
 2025 17:25:23 +0200
Date: Thu, 22 May 2025 16:25:21 +0100
To: <qemu-devel@nongnu.org>, Mattias Nissler <mnissler@rivosinc.com>, "Peter
 Xu" <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "David
 Hildenbrand" <david@redhat.com>, "Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= "
 <philmd@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter
 Maydell <peter.maydell@linaro.org>, <linuxarm@huawei.com>
Subject: RFC: How to make max_bounce_buffer_size configurable for
 address_space_memory
Message-ID: <20250522162521.000077d9@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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

Hi All,

This closely related to Mattias' work to resolve bounce buffer limitations for
PCI memory spaces.
https://lore.kernel.org/qemu-devel/20240819135455.2957406-1-mnissler@rivosinc.com/

For CXL memory, due to the way interleave memory is emulated we end
up with the same problem with concurrent virtio mappings into IOMEM but
in this case they are in the address_space_memory.  In my tests
virtio-blk tends to fail as a result.  Note whilst QEMU sees this as
IOMEM, in the host it's just 'normal RAM' (be it with terrible performance :)

Currently I'm carrying the hack (obviously I never checked how much
space I actually needed as it's unlikely to be that much :)

diff --git a/system/physmem.c b/system/physmem.c
index e97de3ef65cf8105b030a44e7a481b1679f86b53..fd0848c1d5b982c3255a7c6c8c1f22b32c86b85a 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2787,6 +2787,7 @@ static void memory_map_init(void)
     memory_region_init(system_memory, NULL, "system", UINT64_MAX);
     address_space_init(&address_space_memory, system_memory, "memory");
 
+    address_space_memory.max_bounce_buffer_size = 1024 * 1024 * 1024;
     system_io = g_malloc(sizeof(*system_io));
     memory_region_init_io(system_io, NULL, &unassigned_io_ops, NULL, "io",
                           65536);


Assuming people are amenable to making this configurable with a parameter
like x-max-bounce-buffer-size (from Mattias' set) how would people like
that to be configured?  The address_space_init() call is
fairly early but I think we can modify the max_bounce_buffer_size later
potentially directly from machine_set_mem() if the parameter is set.

I'm also interested if anyone has another suggestion for how to solve this
problem more generally.

Thanks,

Jonathan


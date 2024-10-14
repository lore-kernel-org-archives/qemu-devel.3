Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAC5D16251
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 12:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0K41-000561-4P; Mon, 14 Oct 2024 08:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t0K40-00055G-6f
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 08:20:40 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t0K3y-0001iP-IT
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 08:20:39 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRx9L4mVMz6GC3y;
 Mon, 14 Oct 2024 20:19:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 196DA140C98;
 Mon, 14 Oct 2024 20:20:37 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 14:20:36 +0200
To: <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Dmitry Frolov <frolov@swemel.ru>, Ajay Joshi <ajay.opensrc@micron.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Fan Ni <fan.ni@samsung.com>, Shiju Jose
 <shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu 3/7] mem/cxl_type3: Fix overlapping region validation
 error
Date: Mon, 14 Oct 2024 13:18:58 +0100
Message-ID: <20241014121902.2146424-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014121902.2146424-1-Jonathan.Cameron@huawei.com>
References: <20241014121902.2146424-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Yao Xingtao <yaoxt.fnst@fujitsu.com>

When injecting a new poisoned region through qmp_cxl_inject_poison(),
the newly injected region should not overlap with existing poisoned
regions.

The current validation method does not consider the following
overlapping region:
┌───┬───────┬───┐
│a  │  b(a) │a  │
└───┴───────┴───┘
(a is a newly added region, b is an existing region, and b is a
 subregion of a)

Fixes: 9547754f40ee ("hw/cxl: QMP based poison injection support")
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 44d491d8f6..16c60b9b0d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1381,9 +1381,7 @@ void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
     ct3d = CXL_TYPE3(obj);
 
     QLIST_FOREACH(p, &ct3d->poison_list, node) {
-        if (((start >= p->start) && (start < p->start + p->length)) ||
-            ((start + length > p->start) &&
-             (start + length <= p->start + p->length))) {
+        if ((start < p->start + p->length) && (start + length > p->start)) {
             error_setg(errp,
                        "Overlap with existing poisoned region not supported");
             return;
-- 
2.43.0



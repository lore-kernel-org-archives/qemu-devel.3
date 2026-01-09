Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5A6D1A63D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 14:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veDm3-0006Oz-Mu; Fri, 09 Jan 2026 09:47:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1veDlo-0006A0-5U
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 09:47:26 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1veDlm-00018H-OZ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 09:47:19 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dnl3f6R5XzJ46ck;
 Fri,  9 Jan 2026 22:47:10 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 824C140584;
 Fri,  9 Jan 2026 22:47:17 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml100005.china.huawei.com (7.214.146.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 9 Jan 2026 14:47:16 +0000
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>, Davidlohr Bueso
 <dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
 <venkataravis@micron.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [PATCH qemu v5 4/7] hw/cxl: Update CXL Fixed Memory Window ACPI
 description to include Back Invalidate support.
Date: Fri, 9 Jan 2026 14:45:08 +0000
Message-ID: <20260109144511.557781-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260109144511.557781-1-Jonathan.Cameron@huawei.com>
References: <20260109144511.557781-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)
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

Defaults for these windows has always been to enable anything QEMU supports.
With the addition of back invalidate support it is necessary to specify that
host windows support this.

CXL emulation is currently only suitable for software stack verification.
The relaxation of the restrictions on this window to include BI have no
affect on the OS until BI capable devices are added and until now these
have not existed. As such no backwards compatibility impacts are expected
from this change.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v5: Equivalent of the default change in the window restrictions patch.
    That patch isn't ready for upstream just yet, so for now just
    change the value for everyone.
---
 hw/acpi/cxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index 75edb2c0a652..f92f7fa3d558 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -172,7 +172,7 @@ static void cedt_build_cfmws(CXLFixedWindow *fw, Aml *cedt)
     build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
 
     /* Window Restrictions */
-    build_append_int_noprefix(table_data, 0x0f, 2);
+    build_append_int_noprefix(table_data, 0x2f, 2);
 
     /* QTG ID */
     build_append_int_noprefix(table_data, 0, 2);
-- 
2.48.1



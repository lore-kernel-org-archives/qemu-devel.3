Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9021ECD37BD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 02:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slfNv-0000rW-A0; Tue, 03 Sep 2024 22:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lihongbo22@huawei.com>)
 id 1slenz-0005p0-4h
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 21:27:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lihongbo22@huawei.com>)
 id 1slenw-0004Av-JW
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 21:27:30 -0400
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wz46w531sz1HJ2v;
 Wed,  4 Sep 2024 09:05:44 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
 by mail.maildlp.com (Postfix) with ESMTPS id BA57A1A0188;
 Wed,  4 Sep 2024 09:09:11 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 4 Sep
 2024 09:09:11 +0800
To: <somlo@cmu.edu>, <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next] fw_cfg: Constify struct kobj_type
Date: Wed, 4 Sep 2024 09:17:43 +0800
Message-ID: <20240904011743.2010319-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=lihongbo22@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 03 Sep 2024 22:04:37 -0400
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
Reply-to:  Hongbo Li <lihongbo22@huawei.com>
From:  Hongbo Li via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This 'struct kobj_type' is not modified. It is only used in
kobject_init_and_add() which takes a 'const struct kobj_type *ktype'
parameter.

Constifying this structure and moving it to a read-only section,
and this can increase over all security.

```
[Before]
   text   data    bss    dec    hex    filename
   5974   1008     96   7078   1ba6    drivers/firmware/qemu_fw_cfg.o

[After]
   text   data    bss    dec    hex    filename
   6038    944     96   7078   1ba6    drivers/firmware/qemu_fw_cfg.o
```

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/firmware/qemu_fw_cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 5f43dfa22f79..85c525745b31 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -452,7 +452,7 @@ static void fw_cfg_sysfs_release_entry(struct kobject *kobj)
 }
 
 /* kobj_type: ties together all properties required to register an entry */
-static struct kobj_type fw_cfg_sysfs_entry_ktype = {
+static const struct kobj_type fw_cfg_sysfs_entry_ktype = {
 	.default_groups = fw_cfg_sysfs_entry_groups,
 	.sysfs_ops = &fw_cfg_sysfs_attr_ops,
 	.release = fw_cfg_sysfs_release_entry,
-- 
2.34.1



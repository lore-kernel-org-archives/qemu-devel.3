Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB46C54E60
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 08:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlm1d-00070w-3M; Sun, 17 Mar 2024 04:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhukeqian1@huawei.com>)
 id 1rlm1b-00070W-5i
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 04:37:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhukeqian1@huawei.com>)
 id 1rlm1Y-00086e-9y
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 04:37:46 -0400
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TyBBJ2HG5z1QBFP;
 Sun, 17 Mar 2024 16:35:04 +0800 (CST)
Received: from kwepemi500026.china.huawei.com (unknown [7.221.188.247])
 by mail.maildlp.com (Postfix) with ESMTPS id 57B2E1402C6;
 Sun, 17 Mar 2024 16:37:35 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 kwepemi500026.china.huawei.com (7.221.188.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 17 Mar 2024 16:37:34 +0800
To: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Igor
 Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, Stefan
 Hajnoczi <stefanha@redhat.com>
CC: <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>,
 <jiangkunkun@huawei.com>, <salil.mehta@huawei.com>
Subject: [PATCH v1 2/2] system/cpus: Fix resume_all_vcpus() under vCPU hotplug
 condition
Date: Sun, 17 Mar 2024 16:37:04 +0800
Message-ID: <20240317083704.23244-3-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20240317083704.23244-1-zhukeqian1@huawei.com>
References: <20240317083704.23244-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.224]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500026.china.huawei.com (7.221.188.247)
Received-SPF: pass client-ip=45.249.212.35; envelope-from=zhukeqian1@huawei.com;
 helo=szxga07-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Keqian Zhu <zhukeqian1@huawei.com>
From:  Keqian Zhu via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

For vCPU being hotplugged, qemu_init_vcpu() is called. In this
function, we set vcpu state as stopped, and then wait vcpu thread
to be created.

As the vcpu state is stopped, it will inform us it has been created
and then wait on halt_cond. After we has realized vcpu object, we
will resume the vcpu thread.

However, during we wait vcpu thread to be created, the bql is
unlocked, and other thread is allowed to call resume_all_vcpus(),
which will resume the un-realized vcpu.

This fixes the issue by filter out un-realized vcpu during
resume_all_vcpus().

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
---
 system/cpus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/system/cpus.c b/system/cpus.c
index 4e41abe23e..8871f5dfa9 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -638,6 +638,9 @@ void resume_all_vcpus(void)
 
     qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
     CPU_FOREACH(cpu) {
+        if (!object_property_get_bool(OBJECT(cpu), "realized", &error_abort)) {
+            continue;
+        }
         cpu_resume(cpu);
     }
 }
-- 
2.33.0



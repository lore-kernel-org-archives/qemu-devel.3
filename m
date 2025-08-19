Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53344CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 14:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoNoF-00084m-P1; Tue, 19 Aug 2025 10:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangxinxin.wang@huawei.com>)
 id 1uoNnj-0007wn-Ml
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:59:07 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangxinxin.wang@huawei.com>)
 id 1uoNnd-0002Lb-4m
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:59:03 -0400
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c5t4s4W7mz14MfP;
 Tue, 19 Aug 2025 22:58:37 +0800 (CST)
Received: from dggpemf200011.china.huawei.com (unknown [7.185.36.152])
 by mail.maildlp.com (Postfix) with ESMTPS id 19204180B66;
 Tue, 19 Aug 2025 22:58:41 +0800 (CST)
Received: from localhost (10.173.124.206) by dggpemf200011.china.huawei.com
 (7.185.36.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 22:58:40 +0800
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <weidong.huang@huawei.com>, 
 WangXin <wangxinxin.wang@huawei.com>, Tuo Xie <xietuo@huawei.com>
Subject: [PATCH] target/i386: Add support save/load exception error_code
Date: Tue, 19 Aug 2025 22:58:34 +0800
Message-ID: <20250819145834.3998-1-wangxinxin.wang@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.173.124.206]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf200011.china.huawei.com (7.185.36.152)
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=wangxinxin.wang@huawei.com; helo=szxga01-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Wang Xin <wangxinxin.wang@huawei.com>
From:  Wang Xin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: WangXin <wangxinxin.wang@huawei.com>

For now, qemu save/load CPU exception info(such as exception_nr and
has_error_code), while the exception error_code is ignored. This will
cause the dest hypervisor reinject a vCPU exception with error_code(0),
potentially causing a guest kernel panic.

For instance, if src VM stopped with an user-mode write #PF (error_code 6),
the dest hypervisor will reinject an #PF with error_code(0) when vCPU resume,
then guest kernel panic as:
  BUG: unable to handle page fault for address: 00007f80319cb010
  #PF: supervisor read access in user mode
  #PF: error_code(0x0000) - not-present page
  RIP: 0033:0x40115d

To fix it, support save/load exception error_code.

Signed-off-by: Xin Wang <wangxinxin.wang@huawei.com>
Signed-off-by: Tuo Xie <xietuo@huawei.com>

diff --git a/target/i386/machine.c b/target/i386/machine.c
index dd2dac1d44..45b7cea80a 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -462,6 +462,24 @@ static const VMStateDescription vmstate_exception_info = {
     }
 };
 
+static bool cpu_errcode_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+
+    return cpu->env.has_error_code != 0;
+}
+
+static const VMStateDescription vmstate_error_code = {
+    .name = "cpu/error_code",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = cpu_errcode_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT32(env.error_code, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 /* Poll control MSR enabled by default */
 static bool poll_control_msr_needed(void *opaque)
 {
@@ -1746,6 +1764,7 @@ const VMStateDescription vmstate_x86_cpu = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_exception_info,
+        &vmstate_error_code,
         &vmstate_async_pf_msr,
         &vmstate_async_pf_int_msr,
         &vmstate_pv_eoi_msr,
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BE6C52D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 14:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seEg2-0007aD-41; Wed, 14 Aug 2024 10:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <engguopeng@buaa.edu.cn>)
 id 1seEA8-0005nT-Ub
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 09:35:41 -0400
Received: from azure-sdnproxy.icoremail.net ([52.237.72.81])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <engguopeng@buaa.edu.cn>) id 1seEA5-0003s1-As
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 09:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:Content-Transfer-Encoding; bh=emLaVKASAR
 pJE/jzq2vtaV8x0Qsgu6jmAqCVcMc0hAM=; b=lpyHEmGxw8lLf0K3RxKWrkUvYI
 93pXhJ61Ztr6Kv4bV8sV5df+VuLKdjG05Om7KdRabqw9OBjET893Q9BLHYSl4++7
 cYf8ItcNq+SdmJoFebAVpZ9aI+MSqwwTZjqkKLO8OLmBU5QkbzwuMHpordfWO8qK
 11RFxAHhY9CAJYWu4=
Received: from gp-VMware-Virtual-Platform.localdomain (unknown
 [139.227.253.190])
 by coremail-app1 (Coremail) with SMTP id OCz+CgBXv7uZsrxmjP5bAA--.5830S2;
 Wed, 14 Aug 2024 21:35:23 +0800 (CST)
From: peng guo <engguopeng@buaa.edu.cn>
To: jonathan.cameron@huawei.com,
	fan.ni@samsung.com
Cc: qemu-devel@nongnu.org,
	peng guo <engguopeng@buaa.edu.cn>
Subject: [PATCH] hw/cxl: fixed the determination of illegal physical addresses
Date: Wed, 14 Aug 2024 21:35:18 +0800
Message-ID: <20240814133518.23393-1-engguopeng@buaa.edu.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: OCz+CgBXv7uZsrxmjP5bAA--.5830S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4fCFyDJr45Ary8Zw1rXrb_yoW8Wry7pr
 s3Kr4Svw1rKay7ZFs7t3ykXw4UCrWxKFZIkrWDuwn5Gryqgr45ZF13KayIv3s8J34xJa4r
 Zr4jqr4DCa1jyF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUk21xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
 w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
 IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
 z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
 Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
 6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
 vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v
 1sIEY20_Aw1UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
 4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
 rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
 CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
 z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: d2isijirrujqpexdthxhgxhubq/
Received-SPF: pass client-ip=52.237.72.81; envelope-from=engguopeng@buaa.edu.cn;
 helo=azure-sdnproxy.icoremail.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 Aug 2024 10:08:34 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When physical address range in the input payload of scan media command
exceeds static_mem_size but does not exceed the sum of static and dynamic
memory, the scan media mailbox command unexpectedly returns an invalid input.

It is handled differently depending on whether dynamic memory is present
or not.If dynamic memory exists, check whether the address range of the 
request exceeds the range of static memory and dynamic memory.If dynamic 
memory does not exist, then check whether the address range of the request 
exceeds the static memory size.

Fixes: d61cc5b6a8d3 ("hw/cxl: Add get scan media capabilities cmd support")
Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
---
 hw/cxl/cxl-mailbox-utils.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 3ebbd32e10..b23c6b9b0b 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1943,11 +1943,12 @@ static CXLRetCode cmd_media_scan_media(const struct cxl_cmd *cmd,
     }
     query_length = ldq_le_p(&in->length) * CXL_CACHE_LINE_SIZE;
 
-    if (query_start + query_length > cxl_dstate->static_mem_size) {
-        return CXL_MBOX_INVALID_PA;
-    }
-    if (ct3d->dc.num_regions && query_start + query_length >=
+    if (ct3d->dc.num_regions) {
+        if (query_start + query_length >=
             cxl_dstate->static_mem_size + ct3d->dc.total_capacity) {
+                return CXL_MBOX_INVALID_PA;
+            }
+    } else if (query_start + query_length > cxl_dstate->static_mem_size) {
         return CXL_MBOX_INVALID_PA;
     }
 
-- 
2.43.0



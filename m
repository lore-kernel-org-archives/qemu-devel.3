Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1638C5320E
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2024 10:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siAOH-00009I-E4; Sun, 25 Aug 2024 06:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <engguopeng@buaa.edu.cn>)
 id 1siAOD-00007w-01
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 06:22:29 -0400
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net ([162.243.161.220])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <engguopeng@buaa.edu.cn>) id 1siAO9-0008B0-VL
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 06:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:Content-Transfer-Encoding; bh=Ughe4HkEcC
 tqRyRZ7fpO9i+fyOFkw7Jk4xY6EMQZZdo=; b=GDWBQRny6pY+74Kl6wNQvDoVN9
 vniPzxtXWAWNEcPn9irm0Griswry4jq3uSVCtv2E9wtwizyi11M73t/2HMQtGFOk
 9fgw/QxhWsxoA/pFFBK3j8TjZ+HQFVZj5HwBZDCZLqp+SrwbuE+pW56CUv/uG0BM
 GRBcYb9OT4d7hDZd8=
Received: from gp-VMware-Virtual-Platform.localdomain (unknown
 [139.227.253.185])
 by coremail-app2 (Coremail) with SMTP id Nyz+CgCnmibVBctmh4yDAQ--.6641S2;
 Sun, 25 Aug 2024 18:22:15 +0800 (CST)
From: peng guo <engguopeng@buaa.edu.cn>
To: jonathan.cameron@huawei.com,
	fan.ni@samsung.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 peng guo <engguopeng@buaa.edu.cn>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3] hw/cxl: fix physical address field in get scan media
 results output
Date: Sun, 25 Aug 2024 18:22:12 +0800
Message-ID: <20240825102212.3871-1-engguopeng@buaa.edu.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Nyz+CgCnmibVBctmh4yDAQ--.6641S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF48AFWDCw48WFW5WrW7Jwb_yoW8XrWDpr
 4DKrnIvayrA347XrsrXa40ga4UWrZxWry3u39xu34jvr97ZFWUXFy5Ka1F9r45X3s5tay8
 ArnY9ryUKan8Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
 w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
 IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
 jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
 x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
 GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
 8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv
 6cx26F1DJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
 8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
 IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
 AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
 jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: d2isijirrujqpexdthxhgxhubq/
Received-SPF: pass client-ip=162.243.161.220;
 envelope-from=engguopeng@buaa.edu.cn;
 helo=zg8tmtyylji0my4xnjeumjiw.icoremail.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_BL=0.001, RCVD_IN_MSPIKE_L4=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When using the mailbox command get scan media results, the scan media 
restart physical address field in the ouput palyload is not 64-byte 
aligned.

This patch removed the error source of the restart physical address. 

The Scan Media Restart Physical Address is the location from which the 
host should restart the Scan Media operation. [5:0] bits are reserved.
Refer to CXL spec r3.1 Table 8-146

Fixes: 89b5cfcc31e6 ("hw/cxl: Add get scan media results cmd support")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://lore.kernel.org/linux-cxl/20240819154206.16456-1-engguopeng@buaa.edu.cn/
Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
---
v2 -> v3: 
-- Resend +CC qemu-devel list and Michael Tsirkin.

v1 -> v2: 
-- Add module name to title.
---
 hw/cxl/cxl-mailbox-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 3ebbd32e1028..9258e48f95ee 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2076,7 +2076,7 @@ static CXLRetCode cmd_media_get_scan_media_results(const struct cxl_cmd *cmd,
 
         start = ROUND_DOWN(ent->start, 64ull);
         stop = ROUND_DOWN(ent->start, 64ull) + ent->length;
-        stq_le_p(&out->records[i].addr, start | (ent->type & 0x7));
+        stq_le_p(&out->records[i].addr, start);
         stl_le_p(&out->records[i].length, (stop - start) / CXL_CACHE_LINE_SIZE);
         i++;
 
-- 
2.43.0



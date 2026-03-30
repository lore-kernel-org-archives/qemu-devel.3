Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCC010D14A8
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7B7X-0002MI-UT; Mon, 30 Mar 2026 07:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w7B7J-0002Ke-MR
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:49:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w7B7G-0005by-M6
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774871341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KqY1BVTm6BQJn+AOMdZdl0mYqUF4UwJ578C3nCdZE5M=;
 b=Ju6LjkAIH9YG8drqpe3ADnQlkFCzLZwt/laTVMHK8BVZB0OrCr7SG3+ikzXYckeXPbwHBx
 O3rZJRGLxr9gPF7SIHSbzzhZgOzxVo73K8GFaSIeG6Ui5zERCrWy1cWpKJND4ojMdCMl8L
 OU1nSGAeBfprnGe7nJGl29q0qZ6TAek=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-9JJoGNZbNd69j6G8-km4yQ-1; Mon,
 30 Mar 2026 07:49:00 -0400
X-MC-Unique: 9JJoGNZbNd69j6G8-km4yQ-1
X-Mimecast-MFC-AGG-ID: 9JJoGNZbNd69j6G8-km4yQ_1774871339
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 617961956094; Mon, 30 Mar 2026 11:48:59 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.47])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 62B4F1800351; Mon, 30 Mar 2026 11:48:57 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: GuoHan Zhao <zhaoguohan@kylinos.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Subject: [PULL 1/2] hw/i2c/aspeed_i2c: reset and migrate pending_intr_sts
Date: Mon, 30 Mar 2026 13:48:52 +0200
Message-ID: <20260330114853.638753-2-clg@redhat.com>
In-Reply-To: <20260330114853.638753-1-clg@redhat.com>
References: <20260330114853.638753-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

Commit 7e82393ed058 ("hw/i2c/aspeed: fix lost interrupts on
back-to-back commands") introduced pending_intr_sts to preserve
interrupt bits that collide with already pending status bits.

That deferred interrupt state is consumed later when the guest clears
INTR_STS, but it is not reset in aspeed_i2c_bus_reset() and it is not
part of the bus migration state. A reset can therefore leave stale
deferred bits behind, and migration can silently drop them.

Clear pending_intr_sts on reset and include it in VMState while keeping
compatibility with older migration streams.

Fixes: 7e82393ed058 ("hw/i2c/aspeed: fix lost interrupts on back-to-back commands")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Link: https://lore.kernel.org/qemu-devel/20260325085450.126595-1-zhaoguohan@kylinos.cn
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i2c/aspeed_i2c.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 5d18f8d49ea4..90f83a03fd4f 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -1134,10 +1134,11 @@ static const MemoryRegionOps aspeed_i2c_bus_pool_ops = {
 
 static const VMStateDescription aspeed_i2c_bus_vmstate = {
     .name = TYPE_ASPEED_I2C,
-    .version_id = 6,
+    .version_id = 7,
     .minimum_version_id = 6,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedI2CBus, ASPEED_I2C_NEW_NUM_REG),
+        VMSTATE_UINT32_V(pending_intr_sts, AspeedI2CBus, 7),
         VMSTATE_UINT8_ARRAY(pool, AspeedI2CBus, ASPEED_I2C_BUS_POOL_SIZE),
         VMSTATE_UINT64(dma_dram_offset, AspeedI2CBus),
         VMSTATE_END_OF_LIST()
@@ -1510,6 +1511,7 @@ static void aspeed_i2c_bus_reset(DeviceState *dev)
     AspeedI2CBus *s = ASPEED_I2C_BUS(dev);
 
     memset(s->regs, 0, sizeof(s->regs));
+    s->pending_intr_sts = 0;
     i2c_end_transfer(s->bus);
 }
 
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BB5C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjgg-00049O-Ds; Fri, 22 Mar 2024 14:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rnjgZ-00048B-01
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:32:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rnjgW-0003ve-QF
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711132324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sLGalgY5t/gt4o5h6PjzJhOOljlrIDNBuY8bQcdGuLA=;
 b=JVLQPwb4Z4CTpvEDqxBPPFWvsQ6GYNHxAz0KzrF3sibjFqBtxaYC0Ff5BDYe3W8FiSkiQ0
 Tszbbs1FqzylRX8aofGIt5ucS5az6/d0GKvnw9IGv1Ozi1tDaoory6cWm0vxk9oLTpxMQD
 YdbrpU72IsVraMlKq4mL1NZlnXvlbxg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-8P3MZXtcPv-dn8TGqCo2CQ-1; Fri, 22 Mar 2024 14:32:00 -0400
X-MC-Unique: 8P3MZXtcPv-dn8TGqCo2CQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D6C2185A781;
 Fri, 22 Mar 2024 18:32:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0614D8173;
 Fri, 22 Mar 2024 18:31:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/microblaze: Do not allow xlnx-zynqmp-pmu-soc to be created
 by the user
Date: Fri, 22 Mar 2024 19:31:53 +0100
Message-ID: <20240322183153.1023359-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Using xlnx-zynqmp-pmu-soc on the command line causes QEMU to crash:

 ./qemu-system-microblazeel -M petalogix-ml605 -device xlnx-zynqmp-pmu-soc
 **
 ERROR:tcg/tcg.c:813:tcg_register_thread: assertion failed: (n < tcg_max_ctxs)
 Bail out!
 Aborted (core dumped)

Mark the device with "user_creatable = false" to avoid that this can happen.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2229
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/microblaze/xlnx-zynqmp-pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 5a2016672a..1bfc9641d2 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -125,6 +125,8 @@ static void xlnx_zynqmp_pmu_soc_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
+    /* xlnx-zynqmp-pmu-soc causes crashes when cold-plugged twice */
+    dc->user_creatable = false;
     dc->realize = xlnx_zynqmp_pmu_soc_realize;
 }
 
-- 
2.44.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C610EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjJ9f-0004Wi-17; Mon, 13 Jul 2026 12:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wjJ9a-0004Rs-8a
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wjJ9Y-0005pf-6B
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783958706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IPwmvNgzpvqEs2n7dYPiWnQDbwjka8OPTrkMOq5/BEY=;
 b=PNsTYl/JzwnmqkbtAl+cCZMYD8IR2YxAIFcpuRGa/4WCj+rMMiv2+7N5c7B8AEpXsx33cM
 bitaBCyvWTcU14PqSGCOVij2Zs8jgqdvIrb6Cx+gWAq9Kragt1gPoakQxiT2TRxKs+uUAa
 H65RL2GsPJigvr5Q6KxuUhICRpmGkT4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-aZgzCPb5NMKcvswGzF-Flw-1; Mon,
 13 Jul 2026 12:05:05 -0400
X-MC-Unique: aZgzCPb5NMKcvswGzF-Flw-1
X-Mimecast-MFC-AGG-ID: aZgzCPb5NMKcvswGzF-Flw_1783958704
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC6E21955DDE; Mon, 13 Jul 2026 16:05:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7CB2B3000B52; Mon, 13 Jul 2026 16:04:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH] hw/usb/hcd-ohci: Make sure that ohci_service_ed_list() cannot
 loop forever
Date: Mon, 13 Jul 2026 18:04:58 +0200
Message-ID: <20260713160458.343323-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The inner while loop in ohci_service_ed_list() could theoretically
loop forever if a malicious guest prepares a set of bad descriptors.
Add a check to the loop to avoid this situation.

Reported-by: Feifan Qian <bea1e@proton.me>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3781
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/hcd-ohci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 40ebafb4dd9..c4a9741bd42 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "qapi/error.h"
+#include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/usb/usb.h"
@@ -1129,6 +1130,8 @@ static int ohci_service_ed_list(OHCIState *ohci, uint32_t head)
         return 0;
     }
     for (cur = head; cur && link_cnt++ < ED_LINK_LIMIT; cur = next_ed) {
+        unsigned int ed_cnt = 0;
+
         if (ohci_read_ed(ohci, cur, &ed)) {
             trace_usb_ohci_ed_read_error(cur);
             ohci_die(ohci);
@@ -1172,6 +1175,13 @@ static int ohci_service_ed_list(OHCIState *ohci, uint32_t head)
                     break;
                 }
             }
+
+            if (ed_cnt++ > ED_LINK_LIMIT) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "ohci: Too many endpoint descriptors in loop\n");
+                ohci_die(ohci);
+                return 0;
+            }
         }
 
         if (ohci_put_ed(ohci, cur, &ed)) {
-- 
2.55.0



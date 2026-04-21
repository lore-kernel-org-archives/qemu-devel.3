Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8DAF327B0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF6UM-000440-WD; Tue, 21 Apr 2026 04:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wF6UL-00043c-Oo
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 04:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wF6UK-0008Ll-CO
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 04:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776760183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QaaiJUC2YBK4ZQi2KQoDSjX+y0kVGZ2x+704p/2Lf5c=;
 b=WkGIh14ILNaQeLrcjFYEFx7XZualB/NcO8VS4egLOqNXWH0aEWq+QBJLW9xVASAOFdHGI9
 c4PnGsbVkEyYsilKiy5aj41YfjYlHJBENw0HTtmDvSDibepvToj22L07Np6oXeeD34o5nC
 IVAvMsS+LjFe5DVmkdGNyyFiOrZq/fg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-6b2oZwZQOa27zC8lbWiIUg-1; Tue,
 21 Apr 2026 04:29:41 -0400
X-MC-Unique: 6b2oZwZQOa27zC8lbWiIUg-1
X-Mimecast-MFC-AGG-ID: 6b2oZwZQOa27zC8lbWiIUg_1776760180
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD5AC19560B2; Tue, 21 Apr 2026 08:29:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.49.140])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E9BC1800906; Tue, 21 Apr 2026 08:29:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Michael Rolnik <mrolnik@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-trivial@nongnu.org
Subject: [PATCH] hw/misc: Fix the valid access size to the avr-power device
Date: Tue, 21 Apr 2026 10:29:35 +0200
Message-ID: <20260421082935.85995-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Accessing the device with in non-single byte mode currently causes
QEMU to abort:

 $ echo "writew 0x800064 0x4142" | \
   ./qemu-system-avr -M mega2560 -display none -qtest stdio -accel qtest
 [I 0.000000] OPENED
 [R +0.001784] writew 0x800064 0x4142
 qemu-system-avr: ../../devel/qemu/hw/misc/avr_power.c:58: avr_mask_write:
  Assertion `offset == 0' failed.
 Aborted                    (core dumped)

Set the valid max access size to 1 to fix the problem.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3393
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/misc/avr_power.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/misc/avr_power.c b/hw/misc/avr_power.c
index f42cf4fd906..42be2656911 100644
--- a/hw/misc/avr_power.c
+++ b/hw/misc/avr_power.c
@@ -73,6 +73,9 @@ static const MemoryRegionOps avr_mask_ops = {
     .impl = {
         .max_access_size = 1,
     },
+    .valid = {
+        .max_access_size = 1,
+    },
 };
 
 static void avr_mask_init(Object *dev)
-- 
2.53.0



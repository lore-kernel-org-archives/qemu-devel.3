Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49E3C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 07:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wju1n-0002Ra-U7; Wed, 15 Jul 2026 03:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wju1m-0002RM-Kr
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 03:27:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wju1k-0000JN-Ea
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 03:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784100450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tyjuwjAxSkO1LIa98tG/BtwMCm/Bmc92Ql28vbDp5yI=;
 b=gQRTA/ufpxC90rCkSI843uHL9M1kfalwRQWTr1GYUclOd42xhNb27LwBEgwXwsSldW50IQ
 dQq5V3suJkFky8O0O3+KU3SnR6+jeXndBIvB1CZw/W/K3F8wZFXeBneXrlS8Auo7Cm6Bxu
 BkQDijEcMPbJlsQWgj/2Hj2xotPHK54=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-DyIRPWt4P4i9J7vc0MY8sA-1; Wed,
 15 Jul 2026 03:27:28 -0400
X-MC-Unique: DyIRPWt4P4i9J7vc0MY8sA-1
X-Mimecast-MFC-AGG-ID: DyIRPWt4P4i9J7vc0MY8sA_1784100447
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44B911955F04
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 07:27:27 +0000 (UTC)
Received: from localhost (unknown [10.44.24.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E403180044F; Wed, 15 Jul 2026 07:27:25 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] hw/display/qxl: validate monitors_config heads[] in phys2virt
Date: Wed, 15 Jul 2026 11:27:22 +0400
Message-ID: <20260715072722.1643289-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The qxl_phys2virt() call for guest_monitors_config only validates
sizeof(QXLMonitorsConfig), which covers the fixed header (count and
max_allowed) since commit 8efec0ef8bbc ("hw/display/qxl: Pass requested
buffer size to qxl_phys2virt()"), but not the flexible array member
heads[]. When count == 1, heads[0] is accessed without its memory being
validated, allowing a guest to cause an out-of-bounds read.

Include sizeof(QXLHead) in the size passed to qxl_phys2virt() so that
the first head entry is validated within the guest memory slot, preventing
guest-visible memory reading.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4027
Reported-by: Tristan @TristanInSec
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 hw/display/qxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 74258afa582..3df796175c2 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -270,7 +270,7 @@ static void qxl_spice_monitors_config_async(PCIQXLDevice *qxl, int replay)
     }
 
     cfg = qxl_phys2virt(qxl, qxl->guest_monitors_config, MEMSLOT_GROUP_GUEST,
-                        sizeof(QXLMonitorsConfig));
+                        sizeof(QXLMonitorsConfig) + sizeof(QXLHead));
     if (cfg != NULL && cfg->count == 1) {
         qxl->guest_primary.resized = 1;
         qxl->guest_head0_width  = cfg->heads[0].width;
-- 
2.55.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0123EB7ED5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 11:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxkaj-0005ZX-LJ; Wed, 04 Mar 2026 06:40:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxkad-0005Yt-7n
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 06:40:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxkab-0006IM-09
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 06:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772624425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yPSQDN3KvlxnagSPRWpeVNniP6Qs5HrMA5xsp/bdl3A=;
 b=V/3n1AwL1n/EgCb9K69CRuH/bbSnzm8NWSARndgZz26LgYTJkk72SXnD5eBFpTyibFauRX
 qGpFX54RcLmUTM6OkNy2JtVzlztPOm0373x2vGxJYmNbXAmjIM7QhPYb2VsSSwvOrqpKL4
 vHCcWDHDVuPaBq6GY/jA0H7GCXk0jH0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-99nrVU98Ngu1X4_RASwRkg-1; Wed,
 04 Mar 2026 06:40:24 -0500
X-MC-Unique: 99nrVU98Ngu1X4_RASwRkg-1
X-Mimecast-MFC-AGG-ID: 99nrVU98Ngu1X4_RASwRkg_1772624423
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 692D918005B2
 for <qemu-devel@nongnu.org>; Wed,  4 Mar 2026 11:40:23 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 554F4180075F; Wed,  4 Mar 2026 11:40:21 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com
Subject: [PATCH] q35: mch: cleanup MCH_HOST_BRIDGE_F_SMBASE_LCK usage in
 mch_update_smbase_smram()
Date: Wed,  4 Mar 2026 12:40:19 +0100
Message-ID: <20260304114019.2470384-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

evaluate *reg & MCH_HOST_BRIDGE_F_SMBASE_LCK once into lck
and then use lck afterwards.

Suggested-by: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/pci-host/q35.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index e85e4227b3..8c0404f3c5 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -444,13 +444,13 @@ static void mch_update_smbase_smram(MCHPCIState *mch)
         pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] = MCH_HOST_BRIDGE_F_SMBASE_LCK;
         return;
     }
-    if (*reg & MCH_HOST_BRIDGE_F_SMBASE_LCK) {
+    lck = *reg & MCH_HOST_BRIDGE_F_SMBASE_LCK;
+    if (lck) {
         /* lock register at 0x2 and disable all writes */
         pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] = 0;
         *reg = MCH_HOST_BRIDGE_F_SMBASE_LCK;
     }
 
-    lck = *reg & MCH_HOST_BRIDGE_F_SMBASE_LCK;
     memory_region_transaction_begin();
     memory_region_set_enabled(&mch->smbase_blackhole, lck);
     memory_region_set_enabled(&mch->smbase_window, lck);
-- 
2.47.3



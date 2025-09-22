Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CC1CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gYe-0006RX-Cl; Mon, 22 Sep 2025 09:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v0gYd-0006QK-AC
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:26:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v0gYX-0005xI-Mz
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758547570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yes9Jnc3LJqUJbfXApPLRKCAd68306n62YCHewm4POc=;
 b=VyREYt9sv6j/IDRyvX97cCGZWKK3H9QB8fc46bpx7EeZIGXQeHa2HJ8DmljhpiD5nmgDCs
 KDQT0PMJ78la7nMl+hb/70iRYhC3Q0hVsXIDZijrxSjC/K+gk/7EoJ5CBJXNVBtOwJSwjJ
 vGaL/ydhPmwNERS6cnI9Ffep30dNt1k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-rA8jh1lHMeuJiEE8AEte7g-1; Mon,
 22 Sep 2025 09:26:05 -0400
X-MC-Unique: rA8jh1lHMeuJiEE8AEte7g-1
X-Mimecast-MFC-AGG-ID: rA8jh1lHMeuJiEE8AEte7g_1758547564
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8B46180029D
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 13:26:04 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A1D31800447; Mon, 22 Sep 2025 13:26:03 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	imammedo@redhat.com
Subject: [PATCH] x86: ich9: fix default value of 'No Reboot' bit in GCS
Date: Mon, 22 Sep 2025 15:26:00 +0200
Message-ID: <20250922132600.562193-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

[2] initialized 'No Reboot' bit to 1 by default. And due to quirk it happened
to work with linux iTCO_wdt driver (which clears it on module load).

However spec [1] states:
"
R/W. This bit is set when the “No Reboot” strap (SPKR pin on
ICH9) is sampled high on PWROK.
"

So it should be set only when  '-global ICH9-LPC.noreboot=true' and cleared
when it's false (which should be default).

Fix it to behave according to spec and set 'No Reboot' bit only when
'-global ICH9-LPC.noreboot=true'.

1)
Intel I/O Controller Hub 9 (ICH9) Family Datasheet (rev: 004)
2)
Fixes: 920557971b6 (ich9: add TCO interface emulation)
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/southbridge/ich9.h | 2 +-
 hw/isa/lpc_ich9.c             | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
index 1e231e89c9..2c35dd0484 100644
--- a/include/hw/southbridge/ich9.h
+++ b/include/hw/southbridge/ich9.h
@@ -95,7 +95,7 @@ struct ICH9LPCState {
 #define ICH9_CC_OIC                             0x31FF
 #define ICH9_CC_OIC_AEN                         0x1
 #define ICH9_CC_GCS                             0x3410
-#define ICH9_CC_GCS_DEFAULT                     0x00000020
+#define ICH9_CC_GCS_DEFAULT                     0x00000000
 #define ICH9_CC_GCS_NO_REBOOT                   (1 << 5)
 
 /* D28:F[0-5] */
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 304dffac32..c9cb8f7779 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -132,6 +132,11 @@ static void ich9_cc_init(ICH9LPCState *lpc)
 static void ich9_cc_reset(ICH9LPCState *lpc)
 {
     uint8_t *c = lpc->chip_config;
+    uint32_t gcs = ICH9_CC_GCS_DEFAULT;
+
+    if (lpc->pin_strap.spkr_hi) {
+        gcs |= ICH9_CC_GCS_NO_REBOOT;
+    }
 
     memset(lpc->chip_config, 0, sizeof(lpc->chip_config));
 
@@ -142,7 +147,7 @@ static void ich9_cc_reset(ICH9LPCState *lpc)
     pci_set_long(c + ICH9_CC_D27IR, ICH9_CC_DIR_DEFAULT);
     pci_set_long(c + ICH9_CC_D26IR, ICH9_CC_DIR_DEFAULT);
     pci_set_long(c + ICH9_CC_D25IR, ICH9_CC_DIR_DEFAULT);
-    pci_set_long(c + ICH9_CC_GCS, ICH9_CC_GCS_DEFAULT);
+    pci_set_long(c + ICH9_CC_GCS, gcs);
 
     ich9_cc_update(lpc);
 }
-- 
2.47.3



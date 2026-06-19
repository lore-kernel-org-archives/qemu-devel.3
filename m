Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2E1CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waXIT-0002Jy-FF; Fri, 19 Jun 2026 07:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1waXIR-0002JC-Uw; Fri, 19 Jun 2026 07:22:03 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1waXIQ-0005yO-FJ; Fri, 19 Jun 2026 07:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=xzoMkOQugJtIBBm141jQ93a33yS86uwbmWxeZ2JxrdY=; b=lkWvIFE217DZ
 OmHkjqZL0ZjHdGyvaF8+2Kh94C89kQOEpErLxrAC61mDazD0P6rn613MAVrgkksqSzvkkH70bt2IY
 DF6z1RTckCWKZ33/li8jW82Zb1VJAiZ9TxrNAt5SOb4WQ1E8cCkdo0akfEo5nIL1E/+GpT08tDTlt
 I8jhFlKWLR3Wpe3tFEonFaJdr2JYheh068RoBM483mXMLXt2HGI3GZuXPvMCtK29jx5a3vaKMPM2J
 iErw6p8zW5lKpWvtJygYPAU+Vd9C1/HiwTVTu7YmA7oQ4w83QYtoOmzdaRnwpk333M6Fc6so9eVMO
 T7boTXPv0/rDzLZrsFjAMw==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=athena.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1waXHp-0089QU-1R;
 Fri, 19 Jun 2026 13:21:57 +0200
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 6/9] tests/qtest/libqos/ahci: support raw (2352-byte) READ CD
Date: Fri, 19 Jun 2026 13:21:54 +0200
Message-ID: <20260619112158.304782-7-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619112158.304782-1-den@openvz.org>
References: <20260619112158.304782-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

ahci_exec() always builds ATAPI commands with a 2048-byte logical
sector size, so it cannot drive a READ CD that returns full 2352-byte
raw sectors. Add an atapi_raw option that sets the READ CD
field-selector to 0xf8 and the command's sector size to 2352 before
the transfer is sized, so the derived block count stays correct while
the buffer and byte counts cover the raw sectors.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/libqos/ahci.c | 5 +++++
 tests/qtest/libqos/ahci.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index 0621a6c477..e3019a1eca 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -707,6 +707,11 @@ void ahci_exec(AHCIQState *ahci, uint8_t port,
     if (opts->atapi) {
         uint16_t bcl = opts->set_bcl ? opts->bcl : ATAPI_SECTOR_SIZE;
         cmd = ahci_atapi_command_create(op, bcl, opts->atapi_dma);
+        if (opts->atapi_raw) {
+            /* request full 2352-byte raw sectors; sector_size must match */
+            cmd->atapi_cmd[9] = 0xf8;
+            cmd->sector_size = ATAPI_RAW_SECTOR_SIZE;
+        }
     } else {
         cmd = ahci_command_create(op);
     }
diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index a0487a1557..2a48a7523d 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -242,6 +242,7 @@
 
 #define AHCI_SECTOR_SIZE                (512)
 #define ATAPI_SECTOR_SIZE              (2048)
+#define ATAPI_RAW_SECTOR_SIZE          (2352)
 
 #define AHCI_SIGNATURE_CDROM     (0xeb140101)
 #define AHCI_SIGNATURE_DISK      (0x00000101)
@@ -485,6 +486,7 @@ typedef struct AHCIOpts {
     uint64_t buffer;    /* Pointer to source or destination guest buffer */
     bool atapi;         /* ATAPI command? */
     bool atapi_dma;     /* Use DMA for ATAPI? */
+    bool atapi_raw;     /* READ CD returning 2352-byte raw sectors */
     bool error;
     int (*pre_cb)(AHCIQState*, AHCICommand*, const struct AHCIOpts *);
     int (*mid_cb)(AHCIQState*, AHCICommand*, const struct AHCIOpts *);
-- 
2.53.0



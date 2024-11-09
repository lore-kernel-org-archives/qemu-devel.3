Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F33D5E369
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kTQ-0005By-Dv; Sat, 09 Nov 2024 07:21:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kR3-0001uw-LS; Sat, 09 Nov 2024 07:19:26 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kR1-0005Vv-SU; Sat, 09 Nov 2024 07:19:25 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6A922A1655;
 Sat,  9 Nov 2024 15:08:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 324B3167FDB;
 Sat,  9 Nov 2024 15:09:04 +0300 (MSK)
Received: (nullmailer pid 3296260 invoked by uid 1000);
 Sat, 09 Nov 2024 12:09:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 43/58] ppc/pnv: ADU fix possible buffer overrun with
 invalid size
Date: Sat,  9 Nov 2024 15:08:44 +0300
Message-Id: <20241109120901.3295995-43-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

The ADU LPC transfer-size field is 7 bits, but the supported sizes for
LPC access via ADU appear to be 1, 2, 4, 8. The data buffer could
overrun if firmware set an invalid size field, so add checks to reject
them with a message.

Cc: qemu-stable@nongnu.org
Reported-by: Cédric Le Goater <clg@redhat.com>
Resolves: Coverity CID 1558830
Fixes: 24bd283bccb33 ("ppc/pnv: Implement ADU access to LPC space")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
(cherry picked from commit ddd2a060a0da41000ddca31e329ab1d54e37fedb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/pnv_adu.c b/hw/ppc/pnv_adu.c
index 81b7d6e526..f636dedf79 100644
--- a/hw/ppc/pnv_adu.c
+++ b/hw/ppc/pnv_adu.c
@@ -116,6 +116,12 @@ static void pnv_adu_xscom_write(void *opaque, hwaddr addr, uint64_t val,
             uint32_t lpc_size = lpc_cmd_size(adu);
             uint64_t data = 0;
 
+            if (!is_power_of_2(lpc_size) || lpc_size > sizeof(data)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "ADU: Unsupported LPC access "
+                                               "size:%" PRId32 "\n", lpc_size);
+                break;
+            }
+
             pnv_lpc_opb_read(adu->lpc, lpc_addr, (void *)&data, lpc_size);
 
             /*
@@ -135,6 +141,12 @@ static void pnv_adu_xscom_write(void *opaque, hwaddr addr, uint64_t val,
             uint32_t lpc_size = lpc_cmd_size(adu);
             uint64_t data;
 
+            if (!is_power_of_2(lpc_size) || lpc_size > sizeof(data)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "ADU: Unsupported LPC access "
+                                               "size:%" PRId32 "\n", lpc_size);
+                break;
+            }
+
             data = cpu_to_be64(val) >> ((lpc_addr & 7) * 8); /* See above */
             pnv_lpc_opb_write(adu->lpc, lpc_addr, (void *)&data, lpc_size);
         }
-- 
2.39.5



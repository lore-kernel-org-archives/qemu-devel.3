Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD34CDE003
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNl3-000294-JY; Wed, 24 Jun 2026 09:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNku-0001Xs-E2; Wed, 24 Jun 2026 09:35:06 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNks-0000aZ-C2; Wed, 24 Jun 2026 09:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782307996; bh=iBMovGSeLWV0hOg/lRXOTm8xcdar8YmPiwUV+GGbnlA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QNFs0VyjVJQm4m13E62dPM0giP0tuU2fVLrBEDQXYcS/R1HPH/UBUukMkFICKqpvH
 sJiJecgB1/B+16tKQmFevRSCygZ99GoQjvssyFx3tihrr7P6+Lm4lpY2kBNootu8JO
 wPBcs2vNhiNlRQ7Tt/qYS91F8LrRKMiTQlASqZujwB6DtO/BJkR0BhHcDDSBbfYF+d
 96l84SFpgYLRFgksnfHJ/FD+d9qenG7aIrxPEaIaigskkLaJky8MKDXNc05M6Ie89K
 FLcY9Qj/2PEt642XNDtYNfb9qbFYyKySyVtK86lp0MnyywRE+wJvls5Ec70Tl9RZKw
 Ci6Edb/GacfIQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B3A851BA9C9;
 Wed, 24 Jun 2026 16:33:16 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 523C13DEA18;
 Wed, 24 Jun 2026 16:33:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 023/107] lsi53c895a: clear tag byte when processing
 messages
Date: Wed, 24 Jun 2026 16:30:28 +0300
Message-ID: <20260624133301.403266-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

Instead of simply ORing the message byte, clear what
was there before.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 4494dec8c2bfd8a5d9b1eabe4a26ab850a4f6700)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 0843d325ab..1b7f02fc7c 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1041,16 +1041,19 @@ static void lsi_do_msgout(LSIState *s)
             }
             break;
         case 0x20: /* SIMPLE queue */
+            s->select_tag &= ~0xff;
             s->select_tag |= lsi_get_msgbyte(s) | LSI_TAG_VALID;
             trace_lsi_do_msgout_simplequeue(s->select_tag & 0xff);
             break;
         case 0x21: /* HEAD of queue */
             qemu_log_mask(LOG_UNIMP, "lsi_scsi: HEAD queue not implemented\n");
+            s->select_tag &= ~0xff;
             s->select_tag |= lsi_get_msgbyte(s) | LSI_TAG_VALID;
             break;
         case 0x22: /* ORDERED queue */
             qemu_log_mask(LOG_UNIMP,
                           "lsi_scsi: ORDERED queue not implemented\n");
+            s->select_tag &= ~0xff;
             s->select_tag |= lsi_get_msgbyte(s) | LSI_TAG_VALID;
             break;
         case 0x0d:
-- 
2.47.3



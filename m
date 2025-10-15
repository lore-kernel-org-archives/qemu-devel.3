Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5878CCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 04:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8t5B-00005H-4z; Wed, 15 Oct 2025 00:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t59-000055-74; Wed, 15 Oct 2025 00:25:47 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t52-0002jD-VX; Wed, 15 Oct 2025 00:25:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D6F9615D9C7;
 Wed, 15 Oct 2025 07:24:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 720D529FE70;
 Wed, 15 Oct 2025 07:25:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, ShengYi Hung <aokblast@FreeBSD.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.2 02/11] hid: fix incorrect return value for hid
Date: Wed, 15 Oct 2025 07:25:06 +0300
Message-ID: <20251015042520.68556-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.2-20251014173635@cover.tls.msk.ru>
References: <qemu-stable-10.1.2-20251014173635@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: ShengYi Hung <aokblast@FreeBSD.org>

The return value of hid_keyboard_write is used to set the packet's actual_length
and pass to xhci directly to allow guest know how many byte actually processed.
Therefore, return 1 to indicate a successful transfer or it will be
considered as a wrong xfer.

Signed-off-by: ShengYi Hung <aokblast@FreeBSD.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit 1c0f5142d921525f1023152eac63d2ff3d33e3b2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/input/hid.c b/hw/input/hid.c
index 76bedc1844..de24cd0ef0 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -478,6 +478,7 @@ int hid_keyboard_write(HIDState *hs, uint8_t *buf, int len)
             ledstate |= QEMU_CAPS_LOCK_LED;
         }
         kbd_put_ledstate(ledstate);
+        return 1;
     }
     return 0;
 }
-- 
2.47.3



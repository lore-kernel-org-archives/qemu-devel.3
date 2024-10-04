Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8E6CF884E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swkn7-000228-K7; Fri, 04 Oct 2024 12:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1swkn1-0001x5-6r; Fri, 04 Oct 2024 12:04:23 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1swkmy-0001Zy-Q1; Fri, 04 Oct 2024 12:04:22 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 46A369556E;
 Fri,  4 Oct 2024 19:03:30 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8175214D97C;
 Fri,  4 Oct 2024 19:03:32 +0300 (MSK)
Received: (nullmailer pid 1282530 invoked by uid 1000);
 Fri, 04 Oct 2024 16:03:32 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 09/23] hw/char: Remove unused serial_set_frequency
Date: Fri,  4 Oct 2024 19:03:17 +0300
Message-Id: <20241004160331.1282441-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004160331.1282441-1-mjt@tls.msk.ru>
References: <20241004160331.1282441-1-mjt@tls.msk.ru>
MIME-Version: 1.0
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

serial_set_frequnecy has been unused since it was added in 2009:
  038eaf82c8 ("serial: Add interface to set reference oscillator frequency")

It looks like the 'baudbase' is now a property anyway so the wrapper
isn't needed.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/char/serial.c         | 7 -------
 include/hw/char/serial.h | 2 --
 2 files changed, 9 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index d8b2db5082..6c5c4a23c7 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -951,13 +951,6 @@ static void serial_unrealize(DeviceState *dev)
     qemu_unregister_reset(serial_reset, s);
 }
 
-/* Change the main reference oscillator frequency. */
-void serial_set_frequency(SerialState *s, uint32_t frequency)
-{
-    s->baudbase = frequency;
-    serial_update_parameters(s);
-}
-
 const MemoryRegionOps serial_io_ops = {
     .read = serial_ioport_read,
     .write = serial_ioport_write,
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 6e14099ee7..40aad21df3 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -93,8 +93,6 @@ struct SerialMM {
 extern const VMStateDescription vmstate_serial;
 extern const MemoryRegionOps serial_io_ops;
 
-void serial_set_frequency(SerialState *s, uint32_t frequency);
-
 #define TYPE_SERIAL "serial"
 OBJECT_DECLARE_SIMPLE_TYPE(SerialState, SERIAL)
 
-- 
2.39.5



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BBECCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDstj-00033I-U4; Tue, 28 Oct 2025 19:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstf-00031v-7V
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:35 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstO-000181-CC
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:33 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 9283781770;
 Wed, 29 Oct 2025 02:14:02 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oDnXpg2bCW20-W0bfPDEB; Wed, 29 Oct 2025 02:14:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761693242;
 bh=Fqa9PzaB2NaxsEUcFr/1/+bAl7RDY45zxrOOs/iPfxI=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=f8+CtqryyizCzQFk1xdEJKVZwE0XbAz7Sb9Q+iyKFeNztPKQUuaRmszvfo3L7r1Y5
 g45sP7h0Ic6ZG+bEK5tCO1aVsc2MG/N3aSXlKJXzG/gzWDIXvWhDp4HXl9EhALD2F9
 E/r3IBi7TWbyMQ4H+2bMdUesxoB1K88bU8eUygzs=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: armbru@redhat.com,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [RFC 15/22] hw/nvram/eeprom93xx.c: use new migration APIs
Date: Wed, 29 Oct 2025 02:13:39 +0300
Message-ID: <20251028231347.194844-16-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251028231347.194844-1-vsementsov@yandex-team.ru>
References: <20251028231347.194844-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/nvram/eeprom93xx.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/nvram/eeprom93xx.c b/hw/nvram/eeprom93xx.c
index a8fd60a8fb..32dab854fa 100644
--- a/hw/nvram/eeprom93xx.c
+++ b/hw/nvram/eeprom93xx.c
@@ -39,6 +39,7 @@
 #include "hw/nvram/eeprom93xx.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
+#include "qapi/error.h"
 
 /* Debug EEPROM emulation. */
 //~ #define DEBUG_EEPROM
@@ -95,28 +96,28 @@ struct _eeprom_t {
    This is a Big hack, but it is how the old state did it.
  */
 
-static int get_uint16_from_uint8(QEMUFile *f, void *pv, size_t size,
-                                 const VMStateField *field)
+static bool get_uint16_from_uint8(QEMUFile *f, void *pv, size_t size,
+                                  const VMStateField *field, Error **errp)
 {
     uint16_t *v = pv;
     *v = qemu_get_ubyte(f);
-    return 0;
+    return true;
 }
 
-static int put_unused(QEMUFile *f, void *pv, size_t size,
-                      const VMStateField *field, JSONWriter *vmdesc)
+static bool put_unused(QEMUFile *f, void *pv, size_t size,
+                       const VMStateField *field, JSONWriter *vmdesc,
+                       Error **errp)
 {
-    fprintf(stderr, "uint16_from_uint8 is used only for backwards compatibility.\n");
-    fprintf(stderr, "Never should be used to write a new state.\n");
-    exit(0);
-
-    return 0;
+    error_setg(errp,
+               "uint16_from_uint8 is used only for backwards compatibility. "
+               "Never should be used to write a new state.");
+    return false;
 }
 
 static const VMStateInfo vmstate_hack_uint16_from_uint8 = {
     .name = "uint16_from_uint8",
-    .get  = get_uint16_from_uint8,
-    .put  = put_unused,
+    .load = get_uint16_from_uint8,
+    .save = put_unused,
 };
 
 #define VMSTATE_UINT16_HACK_TEST(_f, _s, _t)                           \
-- 
2.48.1



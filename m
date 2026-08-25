Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4E4C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyr4-0005r2-Ks; Tue, 25 Aug 2026 17:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyr3-0005qT-JJ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:49 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyr2-00054W-2Q
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id CCC3C80DEA;
 Wed, 26 Aug 2026 00:38:46 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-eEPKqYsL; Wed, 26 Aug 2026 00:38:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693926;
 bh=776MHaLpzpLJ2Q79VM9JksJjKGqEEXxmSC5DyTv3s1k=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=CWpaBuch9WzurdxvSTs5Dw4mnHADrSue5ptUUk6CBglDVjtmrT+pFFhkBH4arN9hA
 KO+oEASarSq/SDfsBharVT1D3AmnyGTwRSrO6DHurMiTcSiE5LHw8ESJXB4qN0tKQf
 zymA01CeXdzQdXHXh1bqgNab9PC7I/+Us0xEWoGc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Stefan Weil <sw@weilnetz.de>
Subject: [PATCH 16/30] hw/nvram/eeprom93xx.c: use new migration APIs
Date: Wed, 26 Aug 2026 00:37:56 +0300
Message-ID: <20260825213811.3725682-17-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/nvram/eeprom93xx.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/nvram/eeprom93xx.c b/hw/nvram/eeprom93xx.c
index 73b3d248d44..de689322567 100644
--- a/hw/nvram/eeprom93xx.c
+++ b/hw/nvram/eeprom93xx.c
@@ -95,28 +95,29 @@ struct _eeprom_t {
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
     fprintf(stderr, "uint16_from_uint8 is used only for backwards compatibility.\n");
     fprintf(stderr, "Never should be used to write a new state.\n");
     exit(0);
 
-    return 0;
+    return true;
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
2.43.0



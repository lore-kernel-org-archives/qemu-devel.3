Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E01C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyrG-0005xC-9n; Tue, 25 Aug 2026 17:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyrE-0005w9-Rt
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:39:00 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyrD-000587-9O
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:39:00 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id EA66A80C0A;
 Wed, 26 Aug 2026 00:38:57 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-CexrEYaz; Wed, 26 Aug 2026 00:38:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693937;
 bh=oTo7kLabaWc9A3aXerLw9RgSBQRSeMgoPIKXRyndO00=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=j3+X4qKrWbdvTVJRXIMoNdI90L53BPc3Zp0mL/4F1YRAy9OvCy2ac4UgJ3eAAka4z
 l9kjfB9Yy1tJa5vpjK4+29xAQfPQ3EK+i9JXdsytwv7YhuN4eLypZ1Ekb7dm3N5JTU
 JfCPutbe28N5xw1gEHkab50fMKsnUwl5LsXOf+ck=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de,
	qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 28/30] migration/vmstate-types: convert
 vmstate_info_g_byte_array to new APIs
Date: Wed, 26 Aug 2026 00:38:08 +0300
Message-ID: <20260825213811.3725682-29-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
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
 migration/vmstate-types.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 8c01215c251..c2d4645f317 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -925,30 +925,31 @@ const VMStateInfo vmstate_info_qlist = {
     .save = save_qlist,
 };
 
-static int get_g_byte_array(QEMUFile *f, void *pv, size_t size,
-                            const VMStateField *field)
+static bool load_g_byte_array(QEMUFile *f, void *pv, size_t size,
+                              const VMStateField *field, Error **errp)
 {
     GByteArray *byte_array = *(GByteArray **)pv;
     uint32_t len = qemu_get_be32(f);
 
     g_byte_array_set_size(byte_array, len);
     qemu_get_buffer(f, byte_array->data, len);
-    return 0;
+    return true;
 }
 
-static int put_g_byte_array(QEMUFile *f, void *pv, size_t size,
-                            const VMStateField *field, JSONWriter *vmdesc)
+static bool save_g_byte_array(QEMUFile *f, void *pv, size_t size,
+                              const VMStateField *field, JSONWriter *vmdesc,
+                              Error **errp)
 {
     GByteArray *byte_array = *(GByteArray **)pv;
 
     qemu_put_be32(f, byte_array->len);
     qemu_put_buffer(f, byte_array->data, byte_array->len);
 
-    return 0;
+    return true;
 }
 
 const VMStateInfo vmstate_info_g_byte_array = {
     .name = "GByteArray",
-    .get  = get_g_byte_array,
-    .put  = put_g_byte_array,
+    .load = load_g_byte_array,
+    .save = save_g_byte_array,
 };
-- 
2.43.0



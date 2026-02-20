Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB0BC5B56A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 21:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtXdt-0000C2-M1; Fri, 20 Feb 2026 16:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXdr-0000Ao-Hq
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:02:27 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXdp-0002lz-Gy
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:02:27 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id DF5F4C023C;
 Sat, 21 Feb 2026 00:02:22 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:87::1:2c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id G2kijG5A6qM0-b2wUajiP; Sat, 21 Feb 2026 00:02:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771621342;
 bh=K9X8twpFl4uRTfRXKZNsWhPiuYHOu4f5+6bxOjBGczU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=IV0E1GPkCRUl+dlWyVgcDdQhzPpb2tVnjtE27JiL2FA4q4UA+vnWcRyeiTKpxmKDG
 PfpRdM2pPBfaR6Tii/R5RZUc8vUqzxIeLEspYGJmjmcQLVC9hM1wLSPPSM04ShoABa
 pKG7b+gZmacSZLec+/U0KhD9a7aDuGMrWR81ir1w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v2 12/16] migration: VMStateInfo: introduce new handlers with
 errp
Date: Sat, 21 Feb 2026 00:02:10 +0300
Message-ID: <20260220210214.800050-13-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220210214.800050-1-vsementsov@yandex-team.ru>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Add new APIs with errp, to allow handlers report good
error messages. We'll convert existing handlers soon.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/migration/vmstate.h | 17 ++++++++++++++---
 migration/vmstate.c         |  4 ++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 15578b3e28..167b1aa9cf 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -32,12 +32,16 @@
 typedef struct VMStateInfo VMStateInfo;
 typedef struct VMStateField VMStateField;
 
-/* VMStateInfo allows customized migration of objects that don't fit in
+/*
+ * VMStateInfo allows customized migration of objects that don't fit in
  * any category in VMStateFlags. Additional information is always passed
- * into get and put in terms of field and vmdesc parameters. However
+ * into load and save in terms of field and vmdesc parameters. However
  * these two parameters should only be used in cases when customized
  * handling is needed, such as QTAILQ. For primitive data types such as
- * integer, field and vmdesc parameters should be ignored inside get/put.
+ * integer, field and vmdesc parameters should be ignored inside load/save.
+ *
+ * @get and @put are deprecated copies of @load and @save. For new interfaces
+ * use @load and @save.
  */
 struct VMStateInfo {
     const char *name;
@@ -46,6 +50,13 @@ struct VMStateInfo {
     int coroutine_mixed_fn (*put)(QEMUFile *f, void *pv, size_t size,
                                   const VMStateField *field,
                                   JSONWriter *vmdesc);
+    bool coroutine_mixed_fn (*load)(QEMUFile *f, void *pv, size_t size,
+                                    const VMStateField *field,
+                                    Error **errp);
+    bool coroutine_mixed_fn (*save)(QEMUFile *f, void *pv, size_t size,
+                                    const VMStateField *field,
+                                    JSONWriter *vmdesc,
+                                    Error **errp);
 };
 
 enum VMStateFlags {
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 69340036f0..efef4d0433 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -170,6 +170,8 @@ static bool vmstate_load_field(QEMUFile *f, void *pv, size_t size,
     } else if (field->flags & VMS_VSTRUCT) {
         return vmstate_load_state(f, field->vmsd, pv, field->struct_version_id,
                                   errp) >= 0;
+    } else if (field->info->load) {
+        return field->info->load(f, pv, size, field, errp);
     }
 
     if (field->info->get(f, pv, size, field) < 0) {
@@ -491,6 +493,8 @@ static bool vmstate_save_field(QEMUFile *f, void *pv, size_t size,
         return vmstate_save_state_v(f, field->vmsd, pv, vmdesc,
                                     field->struct_version_id,
                                     errp) >= 0;
+    } else if (field->info->save) {
+        return field->info->save(f, pv, size, field, vmdesc, errp);
     }
 
     if (field->info->put(f, pv, size, field, vmdesc) < 0) {
-- 
2.52.0



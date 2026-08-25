Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0C4C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyrH-0005yA-BE; Tue, 25 Aug 2026 17:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyrF-0005wc-OF
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:39:01 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyrD-00058N-UT
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:39:01 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id B037B80DC3;
 Wed, 26 Aug 2026 00:38:58 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-oYco2QXt; Wed, 26 Aug 2026 00:38:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693938;
 bh=KdUUDcSC8JIFLpggCgXalv656q2CP4nJM77/pWea93I=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ssAjUo/mugYzp6BkS26RsAuEl52Sf5FmfELNBPxOiGrRfHd06Nq+yDaPEmemNIALx
 XqWFXzXq4pNobzYka22ZjIwqmW5GnVZQ5c9BVtn5dqT3JDVTPRapRzbRpFlZRsufKQ
 TzOOmNaIMYIi0MIH45ncuVu123DUH1pcqN1n5+1E=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de,
	qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 29/30] migration: VMStateInfo: remove old .get / .set handlers
Date: Wed, 26 Aug 2026 00:38:09 +0300
Message-ID: <20260825213811.3725682-30-vsementsov@yandex-team.ru>
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

They are unused now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/migration/vmstate.h |  8 --------
 migration/vmstate.c         | 20 ++------------------
 2 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1b7f295417e..5e53440115e 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -39,17 +39,9 @@ typedef struct VMStateField VMStateField;
  * these two parameters should only be used in cases when customized
  * handling is needed, such as QTAILQ. For primitive data types such as
  * integer, field and vmdesc parameters should be ignored inside load/save.
- *
- * @get and @put are deprecated copies of @load and @save. For new interfaces
- * use @load and @save.
  */
 struct VMStateInfo {
     const char *name;
-    int coroutine_mixed_fn (*get)(QEMUFile *f, void *pv, size_t size,
-                                  const VMStateField *field);
-    int coroutine_mixed_fn (*put)(QEMUFile *f, void *pv, size_t size,
-                                  const VMStateField *field,
-                                  JSONWriter *vmdesc);
     bool coroutine_mixed_fn (*load)(QEMUFile *f, void *pv, size_t size,
                                     const VMStateField *field,
                                     Error **errp);
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 50ebe378452..a4cf9214d54 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -189,18 +189,9 @@ static bool vmstate_load_field(QEMUFile *f, void *pv, size_t size,
     } else if (field->flags & VMS_VSTRUCT) {
         return vmstate_load_vmsd(f, field->vmsd, pv, field->struct_version_id,
                                  errp);
-    } else if (field->info->load) {
-        return field->info->load(f, pv, size, field, errp);
     }
 
-    if (field->info->get(f, pv, size, field) < 0) {
-        error_setg(errp,
-                   "Failed to load element of type %s for %s",
-                   field->info->name, field->name);
-        return false;
-    }
-
-    return true;
+    return field->info->load(f, pv, size, field, errp);
 }
 
 static bool vmstate_post_load(const VMStateDescription *vmsd,
@@ -583,16 +574,9 @@ static bool vmstate_save_field(QEMUFile *f, void *pv, size_t size,
     } else if (field->flags & VMS_VSTRUCT) {
         return vmstate_save_vmsd_v(f, field->vmsd, pv, vmdesc,
                                    field->struct_version_id, errp);
-    } else if (field->info->save) {
-        return field->info->save(f, pv, size, field, vmdesc, errp);
     }
 
-    if (field->info->put(f, pv, size, field, vmdesc) < 0) {
-        error_setg(errp, "put failed");
-        return false;
-    }
-
-    return true;
+    return field->info->save(f, pv, size, field, vmdesc, errp);
 }
 
 /*
-- 
2.43.0



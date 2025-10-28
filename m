Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDDECCF9F1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDstO-0002vS-Ry; Tue, 28 Oct 2025 19:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstM-0002te-ER
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:16 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDst8-000148-Th
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:15 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id B64BA8174D;
 Wed, 29 Oct 2025 02:13:53 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oDnXpg2bCW20-YA4SyPGP; Wed, 29 Oct 2025 02:13:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761693233;
 bh=lLdUY3HJY+EAhmA9vc28UfAQF17pyF94N7tH58szokw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=KE8KAaPPRO0JStcAlDnkeM00eRvQFXYOB7519g407aSVWOynYglEJbM4/Ycow0J2v
 VMjzRIqhSbjaO/XGGP26Nz9fewnOsQj0x2wXy6gVGlBzb+XAdCxE48nomkvClK7U2k
 ke/CXp07Nt64Q0vlTtCaxhrOfvsOKaJ85wmDiMG8=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: armbru@redhat.com,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [RFC 02/22] migration: VMStateInfo: introduce new handlers with errp
Date: Wed, 29 Oct 2025 02:13:26 +0300
Message-ID: <20251028231347.194844-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251028231347.194844-1-vsementsov@yandex-team.ru>
References: <20251028231347.194844-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add new APIs with errp, to allow handlers report good
error messages. We'll convert existing handlers soon.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/migration/vmstate.h |  7 +++++++
 migration/vmstate.c         | 37 +++++++++++++++++++++++++++----------
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 0aac3b7a66..f0ffd8f9c5 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -46,6 +46,13 @@ struct VMStateInfo {
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
index 4d28364f7b..1d291ff556 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -212,13 +212,22 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                                              inner_field->struct_version_id,
                                              errp);
                 } else {
-                    ret = inner_field->info->get(f, curr_elem, size,
-                                                 inner_field);
-                    if (ret < 0) {
-                        error_setg(errp,
-                                   "Failed to load element of type %s for %s: "
-                                   "%d", inner_field->info->name,
-                                   inner_field->name, ret);
+                    if (inner_field->info->get) {
+                        ret = inner_field->info->get(f, curr_elem, size,
+                                                     inner_field);
+                        if (ret < 0) {
+                            error_setg(errp,
+                                       "Failed to load element of type %s for %s: "
+                                       "%d", inner_field->info->name,
+                                       inner_field->name, ret);
+                        }
+                    } else if (!inner_field->info->load(
+                        f, curr_elem, size, inner_field, errp)) {
+                            error_prepend(
+                                errp,
+                                "Failed to load element of type %s for %s: ",
+                                inner_field->info->name, inner_field->name);
+                            ret = -EINVAL;
                     }
                 }
 
@@ -536,9 +545,12 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                                                curr_elem, vmdesc_loop,
                                                inner_field->struct_version_id,
                                                errp);
-                } else {
+                } else if (inner_field->info->put) {
                     ret = inner_field->info->put(f, curr_elem, size,
                                                  inner_field, vmdesc_loop);
+                } else if (!inner_field->info->save(
+                    f, curr_elem, size, inner_field, vmdesc_loop, errp)) {
+                    ret = -EINVAL;
                 }
 
                 written_bytes = qemu_file_transferred(f) - old_offset;
@@ -551,8 +563,13 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 }
 
                 if (ret) {
-                    error_setg(errp, "Save of field %s/%s failed",
-                                vmsd->name, field->name);
+                    if (*errp) {
+                        error_prepend(errp, "Save of field %s/%s failed: ",
+                                      vmsd->name, field->name);
+                    } else {
+                        error_setg(errp, "Save of field %s/%s failed",
+                                   vmsd->name, field->name);
+                    }
                     if (vmsd->post_save) {
                         vmsd->post_save(opaque);
                     }
-- 
2.48.1



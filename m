Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF05CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDstm-00036I-Fk; Tue, 28 Oct 2025 19:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstk-00034E-7V
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:40 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstN-00018o-Bk
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:38 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 4DE3E80B07;
 Wed, 29 Oct 2025 02:14:06 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oDnXpg2bCW20-smsptzub; Wed, 29 Oct 2025 02:14:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761693246;
 bh=Iu2lVLUbhIwJwSvngB6hkTGCW10jNX6YLSQzs7iFrgo=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=nh+7xsqXQNRcTJ9Gu2RLn7qlwrINjgQJmMgvAwCWCaZyTWRthBfAM0roRuv83dkre
 8Pxg1AiJvedBXpXhGci+YGWPyqHt9VOJAr7IWZM79J2ZyZ4/AV3l3i7ybBawLFCCs8
 HUC43UcDMvkQzs9KVnmxT3ZSl5kb6jsDRZtJi+iY=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: armbru@redhat.com,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [RFC 20/22] migration: VMStateInfo: remove old .get / .set handlers
Date: Wed, 29 Oct 2025 02:13:44 +0300
Message-ID: <20251028231347.194844-21-vsementsov@yandex-team.ru>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

They are unused now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/migration/vmstate.h |  5 -----
 migration/vmstate.c         | 14 +-------------
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index f0ffd8f9c5..aaeb33045e 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -41,11 +41,6 @@ typedef struct VMStateField VMStateField;
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
index 1d291ff556..6f1e878f36 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -212,16 +212,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                                              inner_field->struct_version_id,
                                              errp);
                 } else {
-                    if (inner_field->info->get) {
-                        ret = inner_field->info->get(f, curr_elem, size,
-                                                     inner_field);
-                        if (ret < 0) {
-                            error_setg(errp,
-                                       "Failed to load element of type %s for %s: "
-                                       "%d", inner_field->info->name,
-                                       inner_field->name, ret);
-                        }
-                    } else if (!inner_field->info->load(
+                    if (!inner_field->info->load(
                         f, curr_elem, size, inner_field, errp)) {
                             error_prepend(
                                 errp,
@@ -545,9 +536,6 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                                                curr_elem, vmdesc_loop,
                                                inner_field->struct_version_id,
                                                errp);
-                } else if (inner_field->info->put) {
-                    ret = inner_field->info->put(f, curr_elem, size,
-                                                 inner_field, vmdesc_loop);
                 } else if (!inner_field->info->save(
                     f, curr_elem, size, inner_field, vmdesc_loop, errp)) {
                     ret = -EINVAL;
-- 
2.48.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A420BCCF9E9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 20:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCkqu-0004tl-7p; Sat, 25 Oct 2025 16:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vCkqs-0004qv-7M
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 16:27:02 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vCkqp-0004XH-9V
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 16:27:01 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 2681C808BD;
 Sat, 25 Oct 2025 23:26:56 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:538::1:38])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id pQh1fa1bDqM0-BRBh3c6X; Sat, 25 Oct 2025 23:26:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761424015;
 bh=Io+fqMa5HQiuYJALzzF8n6n+ARXY+Y+vMVtMhxwdCww=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=uyRaA8PtMS9Vil7EeVx0omqr4rMxpEuoHPT3Q2JeYVqSoK3sVHyUGQNJ79eJSZ6Z/
 z/OXQ2NYmrhETUGGBjgMx2C1zf/rMOyJ9WiZustJO1scIsQkk5Tm9ovJltqT2+cbVP
 OmBfHUnjYK7aI0R3IaDA4cE93j6UYShpty9Rj4ng=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: stefanb@linux.vnet.ibm.com, farosas@suse.de, qemu-devel@nongnu.org,
 armbru@redhat.com, berrange@redhat.com, vsementsov@yandex-team.ru
Subject: [PATCH v3 3/4] migration/vmstate: stop reporting error number for new
 _errp APIs
Date: Sat, 25 Oct 2025 23:26:48 +0300
Message-ID: <20251025202649.1122420-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251025202649.1122420-1-vsementsov@yandex-team.ru>
References: <20251025202649.1122420-1-vsementsov@yandex-team.ru>
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

First, the handlers should put all needed information into errp,
we should not append error number here.

Second, the only realization of new _errp API is
tpm_emulator_post_load(), which on some failure paths returns
-errno, but on the others simply -1. So printing this additional
number may be misleading. tpm_emulator.c needs a lot more work
to report good error message on all error paths.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/vmstate.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index fd066f910e..677e56c84a 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -157,9 +157,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         ret = vmsd->pre_load_errp(opaque, errp);
         if (ret < 0) {
             error_prepend(errp, "pre load hook failed for: '%s', "
-                          "version_id: %d, minimum version_id: %d, "
-                          "ret: %d: ", vmsd->name, vmsd->version_id,
-                          vmsd->minimum_version_id, ret);
+                          "version_id: %d, minimum version_id: %d: ",
+                          vmsd->name, vmsd->version_id,
+                          vmsd->minimum_version_id);
             return ret;
         }
     } else if (vmsd->pre_load) {
@@ -259,8 +259,8 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         ret = vmsd->post_load_errp(opaque, version_id, errp);
         if (ret < 0) {
             error_prepend(errp, "post load hook failed for: %s, version_id: "
-                          "%d, minimum_version: %d, ret: %d: ", vmsd->name,
-                          vmsd->version_id, vmsd->minimum_version_id, ret);
+                          "%d, minimum_version: %d: ", vmsd->name,
+                          vmsd->version_id, vmsd->minimum_version_id);
         }
     } else if (vmsd->post_load) {
         ret = vmsd->post_load(opaque, version_id);
@@ -441,8 +441,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
         ret = vmsd->pre_save_errp(opaque, errp);
         trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
         if (ret < 0) {
-            error_prepend(errp, "pre-save for %s failed, ret: %d: ",
-                          vmsd->name, ret);
+            error_prepend(errp, "pre-save for %s failed: ", vmsd->name);
             return ret;
         }
     } else if (vmsd->pre_save) {
-- 
2.48.1



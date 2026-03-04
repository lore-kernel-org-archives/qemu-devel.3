Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E878CEFCE47
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 21:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxtgy-0004o5-DB; Wed, 04 Mar 2026 16:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxtgf-0004lz-1c
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 16:23:24 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxtgc-0003TB-Gt
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 16:23:20 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id ED04680BCD;
 Thu, 05 Mar 2026 00:23:15 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:921::1:1b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5NwBA90AmW20-NtvCHoHd; Thu, 05 Mar 2026 00:23:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772659395;
 bh=B73nPWJcUAv3T4zGXNwZqG1+gDtERH9N2aYgr3lGjlQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=eE3YxCj8iT+MdPZOvPGtAv9i+m3EZnjaH34/4ekqWHOC8w9IxpjLbpx1t1FFk0Ft0
 lvnE5wyi/ZrvCq2vkSv9DM8V+erpXTLP9yCYOlPm7GEQOiUf/1sfV9KbUVmgAz5eW4
 hsggm1dyEqJE/3qlcJnZoH5pJ1wpDB3LeQoMnwkw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, vsementsov@yandex-team.ru, qemu-devel@nongnu.org,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>
Subject: [PATCH v3 14/18] migration/cpr: move to new migration APIs
Date: Thu,  5 Mar 2026 00:22:58 +0300
Message-ID: <20260304212303.667141-15-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260304212303.667141-1-vsementsov@yandex-team.ru>
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
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
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/migration/cpr.h |  2 +-
 migration/cpr.c         | 22 +++++++++-------------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 5850fd1788b..96ce26e7117 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -43,7 +43,7 @@ void cpr_set_incoming_mode(MigMode mode);
 bool cpr_is_incoming(void);
 
 bool cpr_state_save(MigrationChannel *channel, Error **errp);
-int cpr_state_load(MigrationChannel *channel, Error **errp);
+bool cpr_state_load(MigrationChannel *channel, Error **errp);
 void cpr_state_close(void);
 struct QIOChannel *cpr_state_ioc(void);
 
diff --git a/migration/cpr.c b/migration/cpr.c
index a0b37007f55..05266dfcfd3 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -178,7 +178,6 @@ bool cpr_is_incoming(void)
 
 bool cpr_state_save(MigrationChannel *channel, Error **errp)
 {
-    int ret;
     QEMUFile *f;
     MigMode mode = migrate_mode();
 
@@ -199,8 +198,7 @@ bool cpr_state_save(MigrationChannel *channel, Error **errp)
     qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
     qemu_put_be32(f, QEMU_CPR_FILE_VERSION);
 
-    ret = vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0, errp);
-    if (ret) {
+    if (!vmstate_save_vmsd(f, &vmstate_cpr_state, &cpr_state, 0, errp)) {
         qemu_fclose(f);
         return false;
     }
@@ -223,9 +221,8 @@ bool cpr_state_save(MigrationChannel *channel, Error **errp)
     return true;
 }
 
-int cpr_state_load(MigrationChannel *channel, Error **errp)
+bool cpr_state_load(MigrationChannel *channel, Error **errp)
 {
-    int ret;
     uint32_t v;
     QEMUFile *f;
     MigMode mode = 0;
@@ -241,10 +238,10 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
         cpr_set_incoming_mode(mode);
         f = cpr_transfer_input(channel, errp);
     } else {
-        return 0;
+        return true;
     }
     if (!f) {
-        return -1;
+        return false;
     }
 
     trace_cpr_state_load(MigMode_str(mode));
@@ -254,19 +251,18 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
     if (v != QEMU_CPR_FILE_MAGIC) {
         error_setg(errp, "Not a migration stream (bad magic %x)", v);
         qemu_fclose(f);
-        return -EINVAL;
+        return false;
     }
     v = qemu_get_be32(f);
     if (v != QEMU_CPR_FILE_VERSION) {
         error_setg(errp, "Unsupported migration stream version %d", v);
         qemu_fclose(f);
-        return -ENOTSUP;
+        return false;
     }
 
-    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1, errp);
-    if (ret) {
+    if (!vmstate_load_vmsd(f, &vmstate_cpr_state, &cpr_state, 1, errp)) {
         qemu_fclose(f);
-        return ret;
+        return false;
     }
 
     if (migrate_mode() == MIG_MODE_CPR_EXEC) {
@@ -280,7 +276,7 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
      */
     cpr_state_file = f;
 
-    return ret;
+    return true;
 }
 
 void cpr_state_close(void)
-- 
2.52.0



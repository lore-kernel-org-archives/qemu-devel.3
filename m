Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D50C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyrH-0005yM-Pp; Tue, 25 Aug 2026 17:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyrG-0005xD-AQ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:39:02 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyrE-00058a-M7
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:39:01 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 5C94980DCD;
 Wed, 26 Aug 2026 00:38:59 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-V7JlZctG; Wed, 26 Aug 2026 00:38:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693938;
 bh=L4emkHPai025VaufLnGb/EFBYJ7znQppa2IZ825pCZM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ddd/bIEwFLey4ZRt6E2QXETodDyotI32WUmy/1k0emHgzar3uQNNXxfcDcElC6kL+
 NeoyseoihWw3XxAL5/Nt3QvULPe+OdkRWBJ0pWikXglo9HK8DFBQ+YV4rkCIUT51hc
 8S8c+/6Q1QEGfEnT83S0t6D5uAcHA8L6kpgJCmBg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de,
	qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 30/30] migration: finally drop vmstate_save/load_state()
 functions
Date: Wed, 26 Aug 2026 00:38:10 +0300
Message-ID: <20260825213811.3725682-31-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
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

Now they are unused.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/migration/vmstate.h |  9 ---------
 migration/vmstate.c         | 12 ------------
 2 files changed, 21 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 5e53440115e..b86386f14a9 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1307,15 +1307,6 @@ extern const VMStateInfo vmstate_info_g_byte_array;
         .flags = VMS_END, \
     }
 
-/*
- * vmstate_load_state() and vmstate_save_state() are
- * depreacated, use vmstate_load_vmsd() and vmstate_save_vmsd()
- * instead.
- */
-int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
-                       void *opaque, int version_id, Error **errp);
-int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
-                       void *opaque, JSONWriter *vmdesc, Error **errp);
 bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id, Error **errp);
 bool vmstate_save_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
diff --git a/migration/vmstate.c b/migration/vmstate.c
index a4cf9214d54..f8424234118 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -880,15 +880,3 @@ static bool vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
 
     return true;
 }
-
-int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
-                       void *opaque, JSONWriter *vmdesc_id, Error **errp)
-{
-    return vmstate_save_vmsd(f, vmsd, opaque, vmdesc_id, errp) ? 0 : -EINVAL;
-}
-
-int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
-                        void *opaque, int version_id, Error **errp)
-{
-    return vmstate_load_vmsd(f, vmsd, opaque, version_id, errp) ? 0 : -EINVAL;
-}
-- 
2.43.0



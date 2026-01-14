Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55318D31A11
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 06:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfufD-0001sJ-NX; Wed, 14 Jan 2026 01:47:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vfuf2-0001pm-Uf
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 01:47:21 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vfuf0-0004A0-Q4
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 01:47:20 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 7FD2C807B9;
 Wed, 14 Jan 2026 09:47:14 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:c88::1:7])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ClNQD90AqW20-3AvZsROj; Wed, 14 Jan 2026 09:47:14 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768373234;
 bh=A8aHx7NDG7I0eOLZpPn11ukQ0g9iIT0KmhKkmcwKQQA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=nWOJWikNpKQQ0UqfdnWhaDDn0NLiJgcDD2r9vRt0yMjsBmDjsaOYyCqhU8Y1jP2er
 fUtl7lYX15v3SPyedtsgW7DmdBK06mFPqOfINRjXw+HB/W0ejIAkcd4Gi5blxMOiFy
 yAYgKmBg+1NRj6vB0QepyF6uiTwOCj8Ukxt/7zSc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, dtalexundeer@yandex-team.ru,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH 1/5] vmstate-types: get_fd(): handle qemu_file_get_fd() failure
Date: Wed, 14 Jan 2026 09:47:06 +0300
Message-ID: <20260114064710.176268-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260114064710.176268-1-vsementsov@yandex-team.ru>
References: <20260114064710.176268-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

qemu_file_get_fd() may fail, and return -1 in this case.
We don't support passing "invalid" file descriptors (like -1),
so we should not interpret error here like invalid descriptor.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/vmstate-types.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 4b01dc19c2..e34bf4486e 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -321,12 +321,21 @@ const VMStateInfo vmstate_info_uint64 = {
 static int get_fd(QEMUFile *f, void *pv, size_t size,
                   const VMStateField *field)
 {
+    int fd;
     int32_t *v = pv;
+
     if (migrate_mode() == MIG_MODE_CPR_EXEC) {
         qemu_get_sbe32s(f, v);
         return 0;
     }
-    *v = qemu_file_get_fd(f);
+
+    fd = qemu_file_get_fd(f);
+    if (fd < 0) {
+        return -1;
+    }
+
+    *v = fd;
+
     return 0;
 }
 
-- 
2.48.1



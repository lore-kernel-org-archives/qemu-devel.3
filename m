Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8933BCCF9F1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDstT-0002wd-QG; Tue, 28 Oct 2025 19:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstQ-0002vl-JT
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:20 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDst7-000146-1A
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:20 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1EA128171D;
 Wed, 29 Oct 2025 02:13:53 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oDnXpg2bCW20-2Fr0JDOO; Wed, 29 Oct 2025 02:13:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761693232;
 bh=H2NIorVqRNjHxH8pDqqhipiNE/AFKe2aszIwI7b1Er8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=XEBXyqOFYG9GyFOuQWqZNZh8vcpp45JXIw4BYsuTgbiJ6EdLomR5yJfWHHEc1foXc
 b3mGMyzbBYivJ1Y3AjsMxQzfcqzioyEnWPkpBP117jqsCmLjkuG3Ccdj2dKa7aAygO
 CsCttTrjrGXHPlGtL6MC5iY+zkDW+kVaLVcIqfJU=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: armbru@redhat.com,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [RFC 01/22] migration: introduce vmstate_load_vmsd() and
 vmstate_save_vmsd()
Date: Wed, 29 Oct 2025 02:13:25 +0300
Message-ID: <20251028231347.194844-2-vsementsov@yandex-team.ru>
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

Introduce new APIs, returning bool.
The analysis
https://lore.kernel.org/qemu-devel/aQDdRn8t0B8oE3gf@x1.local/
shows, that vmstate_load_state() return value actually only
used to check for success, specific errno values doesn't make
sense.

With this commit we introduce new functions with modern bool
interface, and in following commits we'll update the whole
code base to use them, and finally remove old vmstate_load_state()
and vmstate_save_state().

During this update, we'll see, that return values of both
functions is not significantly used, other then to check for
success.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/migration/vmstate.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index dbe330dd5f..0aac3b7a66 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1228,6 +1228,20 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                          void *opaque, JSONWriter *vmdesc,
                          int version_id, Error **errp);
 
+static inline bool vmstate_load_vmsd(
+    QEMUFile *f, const VMStateDescription *vmsd,
+    void *opaque, int version_id, Error **errp)
+{
+    return vmstate_load_state(f, vmsd, opaque, version_id, errp) >= 0;
+}
+
+static inline bool vmstate_save_vmsd(
+    QEMUFile *f, const VMStateDescription *vmsd,
+    void *opaque, JSONWriter *vmdesc, Error **errp)
+{
+    return vmstate_save_state(f, vmsd, opaque, vmdesc, errp) >= 0;
+}
+
 bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque);
 
 #define  VMSTATE_INSTANCE_ID_ANY  -1
-- 
2.48.1



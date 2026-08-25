Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D85C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyr9-0005tC-Ky; Tue, 25 Aug 2026 17:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyr7-0005s6-6w
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:53 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyr5-00055Q-LQ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id B872B80DC3;
 Wed, 26 Aug 2026 00:38:49 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-9pKViNX4; Wed, 26 Aug 2026 00:38:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693929;
 bh=eV9tuSWhOA7Hhsja1+94VnoCGQnJ4gnI785K//EcWfo=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=l0ItoXpeF8YzsuIoQWXePS+Hj1n8iuFsZLgg1PZAQUvC1pyFxVxzyzW5B0X8KZoOB
 WUia61VAiJGio+cJp+503Hl1nIJj+zAZtEF3lnbFWmJ5AwW3ofjUAABkhs34aQbWvq
 NWsBD9G5JiEfAdohZ4jG8Dbn5/B9I1EgDj0lNNCM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 19/30] alpha/machine: move to new migration APIs
Date: Wed, 26 Aug 2026 00:37:59 +0300
Message-ID: <20260825213811.3725682-20-vsementsov@yandex-team.ru>
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 target/alpha/machine.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/alpha/machine.c b/target/alpha/machine.c
index dcba5d441be..a3f67dd7b81 100644
--- a/target/alpha/machine.c
+++ b/target/alpha/machine.c
@@ -3,26 +3,27 @@
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 
-static int get_fpcr(QEMUFile *f, void *opaque, size_t size,
-                    const VMStateField *field)
+static bool load_fpcr(QEMUFile *f, void *opaque, size_t size,
+                     const VMStateField *field, Error **errp)
 {
     CPUAlphaState *env = opaque;
     cpu_alpha_store_fpcr(env, qemu_get_be64(f));
-    return 0;
+    return true;
 }
 
-static int put_fpcr(QEMUFile *f, void *opaque, size_t size,
-                    const VMStateField *field, JSONWriter *vmdesc)
+static bool save_fpcr(QEMUFile *f, void *opaque, size_t size,
+                     const VMStateField *field, JSONWriter *vmdesc,
+                     Error **errp)
 {
     CPUAlphaState *env = opaque;
     qemu_put_be64(f, cpu_alpha_load_fpcr(env));
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_fpcr = {
     .name = "fpcr",
-    .get = get_fpcr,
-    .put = put_fpcr,
+    .load = load_fpcr,
+    .save = save_fpcr,
 };
 
 static const VMStateField vmstate_env_fields[] = {
-- 
2.43.0



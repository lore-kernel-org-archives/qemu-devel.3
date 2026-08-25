Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42ACEC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyrA-0005tE-1D; Tue, 25 Aug 2026 17:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyr8-0005sr-JX
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:54 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyr6-00056Y-WE
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:54 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 5FCFC80E01;
 Wed, 26 Aug 2026 00:38:51 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-ZJb4AV9O; Wed, 26 Aug 2026 00:38:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693930;
 bh=+C74xckgz2/W3c3AsfiOhFihXBLX5vMOUtCgkhiVF4I=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=YAqk7pocGAKDxXOD7JON8NhDCI3NQvS3ftKtIEmAVlB1E+0UvI/UD8irYA3oPK7CE
 sShyrdOWoX4DYjvdOBHpmAhOu4DTqldllgAD4AZZq9HPum0sMk8hlybh69b78q4tOw
 JtK4fzehGIGBxmxD+itOFJfJSw2NdOU87FuLcVOo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Stafford Horne <shorne@gmail.com>
Subject: [PATCH 21/30] or1k/machine: move to new migration APIs
Date: Wed, 26 Aug 2026 00:38:01 +0300
Message-ID: <20260825213811.3725682-22-vsementsov@yandex-team.ru>
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 target/or1k/machine.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/or1k/machine.c b/target/or1k/machine.c
index 2d5ca16c511..800dc4c21cc 100644
--- a/target/or1k/machine.c
+++ b/target/or1k/machine.c
@@ -46,26 +46,27 @@ static const VMStateDescription vmstate_cpu_tlb = {
     }
 };
 
-static int get_sr(QEMUFile *f, void *opaque, size_t size,
-                  const VMStateField *field)
+static bool load_sr(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field, Error **errp)
 {
     CPUOpenRISCState *env = opaque;
     cpu_set_sr(env, qemu_get_be32(f));
-    return 0;
+    return true;
 }
 
-static int put_sr(QEMUFile *f, void *opaque, size_t size,
-                  const VMStateField *field, JSONWriter *vmdesc)
+static bool save_sr(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field, JSONWriter *vmdesc,
+                   Error **errp)
 {
     CPUOpenRISCState *env = opaque;
     qemu_put_be32(f, cpu_get_sr(env));
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_sr = {
     .name = "sr",
-    .get = get_sr,
-    .put = put_sr,
+    .load = load_sr,
+    .save = save_sr,
 };
 
 static const VMStateDescription vmstate_env = {
-- 
2.43.0



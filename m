Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6419C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyrC-0005uJ-19; Tue, 25 Aug 2026 17:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyrA-0005tZ-If
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:56 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyr8-000578-UE
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:56 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 1D217C0982;
 Wed, 26 Aug 2026 00:38:53 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-HTWBtSot; Wed, 26 Aug 2026 00:38:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693932;
 bh=X64fYLDKD3T4bXZSRBjzJvcDWKp+ym1oc6Miyq8M/dY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Z5ieMYlQfCnBOXgq30rJe0MdKzsHOxf5wWQ08VjygAiNLFvNW2xaMAfGlBN58sTta
 TuYy1B7HtgblwJExg1taSmOqsEr/oQNptUJr9O5+qqt42iMQv4H6hnwgNGj31GMwVK
 22VlhIKPXTUcCpKDMVAUzyZMOh2xNaK1NPl/vyyQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 23/30] hppa/machine: move to new migration APIs
Date: Wed, 26 Aug 2026 00:38:03 +0300
Message-ID: <20260825213811.3725682-24-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
 target/hppa/machine.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index 6a143cf8df2..ddd9f27b772 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -23,30 +23,31 @@
 #include "migration/vmstate.h"
 
 
-static int get_psw(QEMUFile *f, void *opaque, size_t size,
-                   const VMStateField *field)
+static bool load_psw(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field, Error **errp)
 {
     CPUHPPAState *env = opaque;
     cpu_hppa_put_psw(env, qemu_get_be64(f));
-    return 0;
+    return true;
 }
 
-static int put_psw(QEMUFile *f, void *opaque, size_t size,
-                   const VMStateField *field, JSONWriter *vmdesc)
+static bool save_psw(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field, JSONWriter *vmdesc,
+                   Error **errp)
 {
     CPUHPPAState *env = opaque;
     qemu_put_be64(f, cpu_hppa_get_psw(env));
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_psw = {
     .name = "psw",
-    .get = get_psw,
-    .put = put_psw,
+    .load = load_psw,
+    .save = save_psw,
 };
 
-static int get_tlb(QEMUFile *f, void *opaque, size_t size,
-                   const VMStateField *field)
+static bool load_tlb(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field, Error **errp)
 {
     HPPATLBEntry *ent = opaque;
     uint64_t val;
@@ -69,11 +70,12 @@ static int get_tlb(QEMUFile *f, void *opaque, size_t size,
         ent->access_id = extract64(val, 1, 31);
         ent->entry_valid = 1;
     }
-    return 0;
+    return true;
 }
 
-static int put_tlb(QEMUFile *f, void *opaque, size_t size,
-                   const VMStateField *field, JSONWriter *vmdesc)
+static bool save_tlb(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field, JSONWriter *vmdesc,
+                   Error **errp)
 {
     HPPATLBEntry *ent = opaque;
     uint64_t val = 0;
@@ -96,13 +98,13 @@ static int put_tlb(QEMUFile *f, void *opaque, size_t size,
     qemu_put_be64(f, ent->itree.last);
     qemu_put_be64(f, ent->pa);
     qemu_put_be64(f, val);
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_tlb_entry = {
     .name = "tlb entry",
-    .get = get_tlb,
-    .put = put_tlb,
+    .load = load_tlb,
+    .save = save_tlb,
 };
 
 static int tlb_pre_load(void *opaque)
-- 
2.43.0



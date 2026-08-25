Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD5EC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyrD-0005vG-FE; Tue, 25 Aug 2026 17:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyrB-0005tn-8f
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:57 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyr9-00057K-CL
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:56 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 1022EC0987;
 Wed, 26 Aug 2026 00:38:54 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-t9AgGQzW; Wed, 26 Aug 2026 00:38:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693933;
 bh=2LgR3mjJmAq9UcoaMLt22xPe3+X5Q+8dE7i5ipFji8I=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=I1xIcc7nIHc3hv93Zz7mH0upM+zhwx8cu0cOAVNUjyUbgN9il7XtegvcbTanB5hkP
 JXUF+nQP10I5zDEq8s8fyfvGOsarHPpE8l5w7BUqXceKktW5lKeSNgtKWqfhzkMWb0
 2D0Lj39PUkgzRCSSvqLrWUIUpd7lAnLSvSA4O8/Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 24/30] sparc/machine: move to new migration APIs
Date: Wed, 26 Aug 2026 00:38:04 +0300
Message-ID: <20260825213811.3725682-25-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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
 target/sparc/machine.c | 68 ++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 0d5d79b5e7b..46f1e12344c 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -51,8 +51,8 @@ static const VMStateDescription vmstate_tlb_entry = {
 };
 #endif
 
-static int get_psr(QEMUFile *f, void *opaque, size_t size,
-                   const VMStateField *field)
+static bool load_psr(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field, Error **errp)
 {
     SPARCCPU *cpu = opaque;
     CPUSPARCState *env = &cpu->env;
@@ -62,11 +62,12 @@ static int get_psr(QEMUFile *f, void *opaque, size_t size,
     env->cwp = 0;
     cpu_put_psr_raw(env, val);
 
-    return 0;
+    return true;
 }
 
-static int put_psr(QEMUFile *f, void *opaque, size_t size,
-                   const VMStateField *field, JSONWriter *vmdesc)
+static bool save_psr(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field, JSONWriter *vmdesc,
+                   Error **errp)
 {
     SPARCCPU *cpu = opaque;
     CPUSPARCState *env = &cpu->env;
@@ -75,17 +76,17 @@ static int put_psr(QEMUFile *f, void *opaque, size_t size,
     val = cpu_get_psr(env);
 
     qemu_put_be32(f, val);
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_psr = {
     .name = "psr",
-    .get = get_psr,
-    .put = put_psr,
+    .load = load_psr,
+    .save = save_psr,
 };
 
-static int get_fsr(QEMUFile *f, void *opaque, size_t size,
-                   const VMStateField *field)
+static bool load_fsr(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field, Error **errp)
 {
     SPARCCPU *cpu = opaque;
 
@@ -95,11 +96,12 @@ static int get_fsr(QEMUFile *f, void *opaque, size_t size,
         cpu_put_fsr(&cpu->env, qemu_get_be32(f));
     }
 
-    return 0;
+    return true;
 }
 
-static int put_fsr(QEMUFile *f, void *opaque, size_t size,
-                   const VMStateField *field, JSONWriter *vmdesc)
+static bool save_fsr(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field, JSONWriter *vmdesc,
+                   Error **errp)
 {
     SPARCCPU *cpu = opaque;
 
@@ -108,18 +110,18 @@ static int put_fsr(QEMUFile *f, void *opaque, size_t size,
     } else {
         qemu_put_be32(f, cpu_get_fsr(&cpu->env));
     }
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_fsr = {
     .name = "fsr",
-    .get = get_fsr,
-    .put = put_fsr,
+    .load = load_fsr,
+    .save = save_fsr,
 };
 
 #ifdef TARGET_SPARC64
-static int get_xcc(QEMUFile *f, void *opaque, size_t size,
-                   const VMStateField *field)
+static bool load_xcc(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field, Error **errp)
 {
     SPARCCPU *cpu = opaque;
     CPUSPARCState *env = &cpu->env;
@@ -131,11 +133,12 @@ static int get_xcc(QEMUFile *f, void *opaque, size_t size,
     env->xcc_Z = ~val & PSR_ZERO;
     env->xcc_C = (val >> PSR_CARRY_SHIFT) & 1;
 
-    return 0;
+    return true;
 }
 
-static int put_xcc(QEMUFile *f, void *opaque, size_t size,
-                   const VMStateField *field, JSONWriter *vmdesc)
+static bool save_xcc(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field, JSONWriter *vmdesc,
+                   Error **errp)
 {
     SPARCCPU *cpu = opaque;
     CPUSPARCState *env = &cpu->env;
@@ -143,17 +146,17 @@ static int put_xcc(QEMUFile *f, void *opaque, size_t size,
 
     /* Extract just xcc out of ccr and shift into legacy position. */
     qemu_put_be32(f, (val & 0xf0) << (20 - 4));
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_xcc = {
     .name = "xcc",
-    .get = get_xcc,
-    .put = put_xcc,
+    .load = load_xcc,
+    .save = save_xcc,
 };
 
-static int get_cwp(QEMUFile *f, void *opaque, size_t size,
-                   const VMStateField *field)
+static bool load_cwp(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field, Error **errp)
 {
     SPARCCPU *cpu = opaque;
     CPUSPARCState *env = &cpu->env;
@@ -163,24 +166,25 @@ static int get_cwp(QEMUFile *f, void *opaque, size_t size,
     env->cwp = 0;
     cpu_set_cwp(env, val);
 
-    return 0;
+    return true;
 }
 
-static int put_cwp(QEMUFile *f, void *opaque, size_t size,
-                   const VMStateField *field, JSONWriter *vmdesc)
+static bool save_cwp(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field, JSONWriter *vmdesc,
+                   Error **errp)
 {
     SPARCCPU *cpu = opaque;
     CPUSPARCState *env = &cpu->env;
     uint32_t val = env->cwp;
 
     qemu_put_be32(f, val);
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_cwp = {
     .name = "uint32",
-    .get = get_cwp,
-    .put = put_cwp,
+    .load = load_cwp,
+    .save = save_cwp,
 };
 #else
 static bool fq_needed(void *opaque)
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134CFC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyrD-0005vP-UI; Tue, 25 Aug 2026 17:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyrC-0005uO-Jf; Tue, 25 Aug 2026 17:38:58 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyrA-00057c-Ky; Tue, 25 Aug 2026 17:38:58 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 0C70B80DF6;
 Wed, 26 Aug 2026 00:38:55 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-xFsvWXu9; Wed, 26 Aug 2026 00:38:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693934;
 bh=ZAjRQ7+ZcxdP4rti3FBRDE5ZLsq5+OnsKkCcaL7Cqo0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=dFf4i+xprma/WWGm8Th6yV8pAhksPdZyjJdSCuHG3kcX3CbuXfgZ3XDLUSscsK3Qw
 eLIMEpymzQaSjfsk7II8tOZW6r+vEbd4Ehg/wsaqudg9cK1YUXDt+wUlCWpUg8JaQt
 Q6qSvoaUxRLMwkvg58RfYlYX6mbjR9J3jn/Dc7m4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [PATCH 25/30] ppc/machine: move to new migration APIs
Date: Wed, 26 Aug 2026 00:38:05 +0300
Message-ID: <20260825213811.3725682-26-vsementsov@yandex-team.ru>
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
 target/ppc/machine.c | 80 ++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 569536bd02d..f188bb9f5ea 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -23,31 +23,31 @@ static void post_load_update_msr(CPUPPCState *env)
     ppc_store_msr(env, msr);
 }
 
-static int get_avr(QEMUFile *f, void *pv, size_t size,
-                   const VMStateField *field)
+static bool load_avr(QEMUFile *f, void *pv, size_t size,
+                   const VMStateField *field, Error **errp)
 {
     ppc_avr_t *v = pv;
 
     v->u64[0] = qemu_get_be64(f);
     v->u64[1] = qemu_get_be64(f);
 
-    return 0;
+    return true;
 }
 
-static int put_avr(QEMUFile *f, void *pv, size_t size,
-                   const VMStateField *field, JSONWriter *vmdesc)
+static bool save_avr(QEMUFile *f, void *pv, size_t size,
+                   const VMStateField *field, JSONWriter *vmdesc, Error **errp)
 {
     ppc_avr_t *v = pv;
 
     qemu_put_be64(f, v->u64[0]);
     qemu_put_be64(f, v->u64[1]);
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_info_avr = {
     .name = "avr",
-    .get  = get_avr,
-    .put  = put_avr,
+    .load = load_avr,
+    .save = save_avr,
 };
 
 #define VMSTATE_AVR_ARRAY_V(_f, _s, _n, _v)                       \
@@ -56,29 +56,29 @@ static const VMStateInfo vmstate_info_avr = {
 #define VMSTATE_AVR_ARRAY(_f, _s, _n)                             \
     VMSTATE_AVR_ARRAY_V(_f, _s, _n, 0)
 
-static int get_fpr(QEMUFile *f, void *pv, size_t size,
-                   const VMStateField *field)
+static bool load_fpr(QEMUFile *f, void *pv, size_t size,
+                   const VMStateField *field, Error **errp)
 {
     ppc_vsr_t *v = pv;
 
     v->VsrD(0) = qemu_get_be64(f);
 
-    return 0;
+    return true;
 }
 
-static int put_fpr(QEMUFile *f, void *pv, size_t size,
-                   const VMStateField *field, JSONWriter *vmdesc)
+static bool save_fpr(QEMUFile *f, void *pv, size_t size,
+                   const VMStateField *field, JSONWriter *vmdesc, Error **errp)
 {
     ppc_vsr_t *v = pv;
 
     qemu_put_be64(f, v->VsrD(0));
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_info_fpr = {
     .name = "fpr",
-    .get  = get_fpr,
-    .put  = put_fpr,
+    .load = load_fpr,
+    .save = save_fpr,
 };
 
 #define VMSTATE_FPR_ARRAY_V(_f, _s, _n, _v)                       \
@@ -87,29 +87,29 @@ static const VMStateInfo vmstate_info_fpr = {
 #define VMSTATE_FPR_ARRAY(_f, _s, _n)                             \
     VMSTATE_FPR_ARRAY_V(_f, _s, _n, 0)
 
-static int get_vsr(QEMUFile *f, void *pv, size_t size,
-                   const VMStateField *field)
+static bool load_vsr(QEMUFile *f, void *pv, size_t size,
+                   const VMStateField *field, Error **errp)
 {
     ppc_vsr_t *v = pv;
 
     v->VsrD(1) = qemu_get_be64(f);
 
-    return 0;
+    return true;
 }
 
-static int put_vsr(QEMUFile *f, void *pv, size_t size,
-                   const VMStateField *field, JSONWriter *vmdesc)
+static bool save_vsr(QEMUFile *f, void *pv, size_t size,
+                   const VMStateField *field, JSONWriter *vmdesc, Error **errp)
 {
     ppc_vsr_t *v = pv;
 
     qemu_put_be64(f, v->VsrD(1));
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_info_vsr = {
     .name = "vsr",
-    .get  = get_vsr,
-    .put  = put_vsr,
+    .load = load_vsr,
+    .save = save_vsr,
 };
 
 #define VMSTATE_VSR_ARRAY_V(_f, _s, _n, _v)                       \
@@ -344,26 +344,26 @@ static bool altivec_needed(void *opaque)
     return cpu->env.insns_flags & PPC_ALTIVEC;
 }
 
-static int get_vscr(QEMUFile *f, void *opaque, size_t size,
-                    const VMStateField *field)
+static bool load_vscr(QEMUFile *f, void *opaque, size_t size,
+                    const VMStateField *field, Error **errp)
 {
     PowerPCCPU *cpu = opaque;
     ppc_store_vscr(&cpu->env, qemu_get_be32(f));
-    return 0;
+    return true;
 }
 
-static int put_vscr(QEMUFile *f, void *opaque, size_t size,
-                    const VMStateField *field, JSONWriter *vmdesc)
+static bool save_vscr(QEMUFile *f, void *opaque, size_t size,
+                    const VMStateField *field, JSONWriter *vmdesc, Error **errp)
 {
     PowerPCCPU *cpu = opaque;
     qemu_put_be32(f, ppc_get_vscr(&cpu->env));
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_vscr = {
     .name = "cpu/altivec/vscr",
-    .get = get_vscr,
-    .put = put_vscr,
+    .load = load_vscr,
+    .save = save_vscr,
 };
 
 static const VMStateDescription vmstate_altivec = {
@@ -465,31 +465,31 @@ static const VMStateDescription vmstate_sr = {
 };
 
 #ifdef TARGET_PPC64
-static int get_slbe(QEMUFile *f, void *pv, size_t size,
-                    const VMStateField *field)
+static bool load_slbe(QEMUFile *f, void *pv, size_t size,
+                    const VMStateField *field, Error **errp)
 {
     ppc_slb_t *v = pv;
 
     v->esid = qemu_get_be64(f);
     v->vsid = qemu_get_be64(f);
 
-    return 0;
+    return true;
 }
 
-static int put_slbe(QEMUFile *f, void *pv, size_t size,
-                    const VMStateField *field, JSONWriter *vmdesc)
+static bool save_slbe(QEMUFile *f, void *pv, size_t size,
+                    const VMStateField *field, JSONWriter *vmdesc, Error **errp)
 {
     ppc_slb_t *v = pv;
 
     qemu_put_be64(f, v->esid);
     qemu_put_be64(f, v->vsid);
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_info_slbe = {
     .name = "slbe",
-    .get  = get_slbe,
-    .put  = put_slbe,
+    .load = load_slbe,
+    .save = save_slbe,
 };
 
 #define VMSTATE_SLB_ARRAY_V(_f, _s, _n, _v)                       \
-- 
2.43.0



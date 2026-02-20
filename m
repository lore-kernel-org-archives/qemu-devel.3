Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173C0C5B55D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 21:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtXdt-0000CI-Tb; Fri, 20 Feb 2026 16:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXdr-0000AS-2T; Fri, 20 Feb 2026 16:02:27 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXdm-0002kL-JX; Fri, 20 Feb 2026 16:02:26 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id D2F66C0233;
 Sat, 21 Feb 2026 00:02:18 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:87::1:2c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id G2kijG5A6qM0-xwuesJSX; Sat, 21 Feb 2026 00:02:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771621338;
 bh=aiWFyMFZPmil/42GhvjcOCUh0Q4uNh/lcF2UOR13U8Y=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=eyYC3yF4I4dukIpfx/JL17Fdqp6PD5Lj60woWyU3zoEGAYhdMylyvq/9BT7Ixz7hf
 AT/n60bUodrjrPtmaJHG4e26FJnz6R+6Pzkk21JWXueifs/R0N68PCfD1BxLULuC71
 ryCrMiKGJe4LBZXp0Xa3jLs6kKr62dXLtC3hS1UI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, vsementsov@yandex-team.ru,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org (open list:All patches CC here),
 qemu-ppc@nongnu.org (open list:sPAPR (pseries)),
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH v2 03/16] migration: make .post_save() a void function
Date: Sat, 21 Feb 2026 00:02:01 +0300
Message-ID: <20260220210214.800050-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220210214.800050-1-vsementsov@yandex-team.ru>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

All other handlers now have _errp() variants. Should we go this way
for .post_save()? Actually it's rather strange, when the vmstate do
successful preparations in .pre_save(), then successfully save all
sections and subsections, end then fail when all the state is
successfully transferred to the target.

Happily, we have only three .post_save() realizations, all always
successful. Let's make this a rule.

Also note, that we call .post_save() in two places, and handle
its (theoretical) failure inconsistently. Fix that too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 docs/devel/migration/main.rst |  2 +-
 hw/ppc/spapr_pci.c            |  3 +--
 include/migration/vmstate.h   | 10 +++++++++-
 migration/savevm.c            |  3 +--
 migration/vmstate.c           | 12 +++---------
 target/arm/machine.c          |  4 +---
 6 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 234d280249..2de7050764 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -439,7 +439,7 @@ The functions to do that are inside a vmstate definition, and are called:
 
   This function is called before we save the state of one device.
 
-- ``int (*post_save)(void *opaque);``
+- ``void (*post_save)(void *opaque);``
 
   This function is called after we save the state of one device
   (even upon failure, unless the call to pre_save returned an error).
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index ea998bdff1..1dc3b02659 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2093,14 +2093,13 @@ static int spapr_pci_pre_save(void *opaque)
     return 0;
 }
 
-static int spapr_pci_post_save(void *opaque)
+static void spapr_pci_post_save(void *opaque)
 {
     SpaprPhbState *sphb = opaque;
 
     g_free(sphb->msi_devs);
     sphb->msi_devs = NULL;
     sphb->msi_devs_num = 0;
-    return 0;
 }
 
 static int spapr_pci_post_load(void *opaque, int version_id)
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 3695afd483..15578b3e28 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -223,7 +223,15 @@ struct VMStateDescription {
     bool (*post_load_errp)(void *opaque, int version_id, Error **errp);
     int (*pre_save)(void *opaque);
     bool (*pre_save_errp)(void *opaque, Error **errp);
-    int (*post_save)(void *opaque);
+
+    /*
+     * post_save() rarely used to free some temporary resources.
+     * It's is called if .pre_save[_errp]() call was successful
+     * (or .pre_save[_errp] handler absent), regardless success
+     * or failure during fields and subsections save. If
+     * .pre_save[_errp]() fails, .post_save() is not called.
+     */
+    void (*post_save)(void *opaque);
     bool (*needed)(void *opaque);
     bool (*dev_unplug_pending)(void *opaque);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 3a16c467b2..c5236e71ba 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -321,14 +321,13 @@ static int configuration_pre_save(void *opaque)
     return 0;
 }
 
-static int configuration_post_save(void *opaque)
+static void configuration_post_save(void *opaque)
 {
     SaveState *state = opaque;
 
     g_free(state->capabilities);
     state->capabilities = NULL;
     state->caps_count = 0;
-    return 0;
 }
 
 static int configuration_pre_load(void *opaque)
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 651c3fe011..5111e7a141 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -550,10 +550,7 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 if (ret) {
                     error_prepend(errp, "Save of field %s/%s failed: ",
                                   vmsd->name, field->name);
-                    if (vmsd->post_save) {
-                        vmsd->post_save(opaque);
-                    }
-                    return ret;
+                    goto out;
                 }
 
                 /* Compressed arrays only care about the first element */
@@ -578,12 +575,9 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
 
     ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
 
+out:
     if (vmsd->post_save) {
-        int ps_ret = vmsd->post_save(opaque);
-        if (!ret && ps_ret) {
-            ret = ps_ret;
-            error_setg(errp, "post-save failed: %s", vmsd->name);
-        }
+        vmsd->post_save(opaque);
     }
     return ret;
 }
diff --git a/target/arm/machine.c b/target/arm/machine.c
index bbaae34449..de810220e2 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -993,15 +993,13 @@ static int cpu_pre_save(void *opaque)
     return 0;
 }
 
-static int cpu_post_save(void *opaque)
+static void cpu_post_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
 
     if (!kvm_enabled()) {
         pmu_op_finish(&cpu->env);
     }
-
-    return 0;
 }
 
 static int cpu_pre_load(void *opaque)
-- 
2.52.0



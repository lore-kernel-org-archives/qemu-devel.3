Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFF4CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 22:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoUzS-00088c-T0; Tue, 19 Aug 2025 18:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uoUzR-00088M-ID
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 18:39:37 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uoUzP-00085d-Az
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 18:39:37 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 42F541F785;
 Tue, 19 Aug 2025 22:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755643170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p8kEHn7XP+NAUtU/aFlLtbSkRyq65oqBZT43awiHQvc=;
 b=G2TlwxzPPIB6H7v8zi8GvCjgcXQ/LL5bhC5xlNwRzh8LScJUGE8snYKBMR5Q5mDo4gg93l
 Q3rGjeJhV+TnahnqknRNKrGSuZNx9quLXHyQQPjiVNe+P+K1i0vnyho2c9OWWuPLIwLelr
 3uaaVCiTKqN3JMTPbSjiI7HGIOngWfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755643170;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p8kEHn7XP+NAUtU/aFlLtbSkRyq65oqBZT43awiHQvc=;
 b=psqrAPN1XAOQgKhMxQAwcxYz6IE4e63/cZZH87jE3hkFZSilzIexDm9fM1AIsVBIKEiofS
 w5vOB6/Zj/wxN5Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755643170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p8kEHn7XP+NAUtU/aFlLtbSkRyq65oqBZT43awiHQvc=;
 b=G2TlwxzPPIB6H7v8zi8GvCjgcXQ/LL5bhC5xlNwRzh8LScJUGE8snYKBMR5Q5mDo4gg93l
 Q3rGjeJhV+TnahnqknRNKrGSuZNx9quLXHyQQPjiVNe+P+K1i0vnyho2c9OWWuPLIwLelr
 3uaaVCiTKqN3JMTPbSjiI7HGIOngWfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755643170;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p8kEHn7XP+NAUtU/aFlLtbSkRyq65oqBZT43awiHQvc=;
 b=psqrAPN1XAOQgKhMxQAwcxYz6IE4e63/cZZH87jE3hkFZSilzIexDm9fM1AIsVBIKEiofS
 w5vOB6/Zj/wxN5Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2493E139B3;
 Tue, 19 Aug 2025 22:39:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8CwxNBz9pGh+TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 19 Aug 2025 22:39:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Fabian Vogt <fvogt@suse.de>, Peter Xu <peterx@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH 4/4] target/ppc: Fix env->quiesced migration
Date: Tue, 19 Aug 2025 19:39:05 -0300
Message-Id: <20250819223905.2247-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250819223905.2247-1-farosas@suse.de>
References: <20250819223905.2247-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[11];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com,suse.de,habkost.net,linaro.org,huawei.com,intel.com,linux.ibm.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The commit referenced (from QEMU 10.0) has changed the way the pseries
machine marks a cpu as quiesced. Previously, the cpu->halted value
from QEMU common cpu code was (incorrectly) used. With the fix, the
env->quiesced variable starts being used, which improves on the
original situation, but also causes a side effect after migration:

The env->quiesced is set at reset and never migrated, which causes the
destination QEMU to stop delivering interrupts and hang the machine.

To fix the issue from this point on, start migrating the env->quiesced
value.

For QEMU versions < 10.0, sending the new element on the stream would
cause migration to be aborted, so add the appropriate compatibility
property to omit the new subsection.

Independently of this patch, all migrations from QEMU versions < 10.0
will result in a hang since the older QEMU never migrates
env->quiesced. This is bad because it leaves machines already running
on the old QEMU without a migration path into newer versions.

As a workaround, clear env->quiesced in the new QEMU whenever
cpu->halted is also clear. This assumes rtas_stop_self() always sets
both flags at the same time. Migrations during secondaries bringup
(i.e. before rtas-start-cpu) will still cause a hang, but those are
early enough that requiring reboot would not be unreasonable.

Note that this was tested with -cpu power9 and -machine ic-mode=xive
due to another bug affecting migration of XICS guests. Tested both
forward and backward migration and savevm/loadvm from 9.2 and 10.0.

Reported-by: Fabian Vogt <fvogt@suse.de>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3079
Fixes: fb802acdc8b ("ppc/spapr: Fix RTAS stopped state")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
The choice of PowerPCCPU to hold the compat property is dubious. This
only affects pseries, but it seems like a layering violation to access
SpaprMachine from target/ppc/, suggestions welcome.
---
 hw/core/machine.c     |  1 +
 target/ppc/cpu.h      |  1 +
 target/ppc/cpu_init.c |  7 +++++++
 target/ppc/machine.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 49 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index bd47527479..ea83c0876b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -42,6 +42,7 @@ GlobalProperty hw_compat_10_0[] = {
     { "vfio-pci", "x-migration-load-config-after-iter", "off" },
     { "ramfb", "use-legacy-x86-rom", "true"},
     { "vfio-pci-nohotplug", "use-legacy-x86-rom", "true" },
+    { "powerpc64-cpu", "rtas-stopped-state", "false" },
 };
 const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 6b90543811..8ff453024b 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1470,6 +1470,7 @@ struct ArchCPU {
     void *machine_data;
     int32_t node_id; /* NUMA node this CPU belongs to */
     PPCHash64Options *hash64_opts;
+    bool rtas_stopped_state;
 
     /* Those resources are used only during code translation */
     /* opcode handlers */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index a0e77f2673..4380c6eb14 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -55,6 +55,11 @@
 /* #define PPC_DEBUG_SPR */
 /* #define USE_APPLE_GDB */
 
+static const Property powerpc_cpu_properties[] = {
+    DEFINE_PROP_BOOL("rtas-stopped-state", PowerPCCPU,
+                      rtas_stopped_state, true),
+};
+
 static inline void vscr_init(CPUPPCState *env, uint32_t val)
 {
     /* Altivec always uses round-to-nearest */
@@ -7525,6 +7530,8 @@ static void ppc_cpu_class_init(ObjectClass *oc, const void *data)
                                       &pcc->parent_unrealize);
     pcc->pvr_match = ppc_pvr_match_default;
 
+    device_class_set_props(dc, powerpc_cpu_properties);
+
     resettable_class_set_parent_phases(rc, NULL, ppc_cpu_reset_hold, NULL,
                                        &pcc->parent_phases);
 
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index d72e5ecb94..8797233ebe 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -257,6 +257,23 @@ static int cpu_post_load(void *opaque, int version_id)
         ppc_store_sdr1(env, env->spr[SPR_SDR1]);
     }
 
+    if (!cpu->rtas_stopped_state) {
+        /*
+         * The source QEMU doesn't have fb802acdc8 and still uses halt
+         * + PM bits in LPCR to implement RTAS stopped state. The new
+         * QEMU will have put the newly created vcpus in that state,
+         * waiting for the start-cpu RTAS call. Clear the quiesced
+         * flag if possible, otherwise the newly-loaded machine will
+         * hang indefinitely due to quiesced state ignoring
+         * interrupts.
+         */
+
+        if (!CPU(cpu)->halted) {
+            /* not halted, so definitely not in RTAS stopped state */
+            env->quiesced = 0;
+        }
+    }
+
     post_load_update_msr(env);
 
     if (tcg_enabled()) {
@@ -649,6 +666,28 @@ static const VMStateDescription vmstate_reservation = {
     }
 };
 
+static bool rtas_stopped_needed(void *opaque)
+{
+    PowerPCCPU *cpu = opaque;
+
+    return cpu->rtas_stopped_state && !cpu->env.quiesced;
+}
+
+static const VMStateDescription vmstate_rtas_stopped = {
+    .name = "cpu/rtas_stopped",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = rtas_stopped_needed,
+    .fields = (const VMStateField[]) {
+        /*
+         * "RTAS stopped" state, independent of halted state. For QEMU
+         * < 10.0, this is taken from cpu->halted at cpu_post_load()
+         */
+        VMSTATE_BOOL(env.quiesced, PowerPCCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 #ifdef TARGET_PPC64
 static bool bhrb_needed(void *opaque)
 {
@@ -715,6 +754,7 @@ const VMStateDescription vmstate_ppc_cpu = {
         &vmstate_tlbmas,
         &vmstate_compat,
         &vmstate_reservation,
+        &vmstate_rtas_stopped,
         NULL
     }
 };
-- 
2.35.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AF4C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reynZ-00072I-UO; Tue, 27 Feb 2024 09:51:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1reynS-0006bs-7L
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:51:06 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1reynO-0004VK-Vi
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:51:05 -0500
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8922D22752;
 Tue, 27 Feb 2024 14:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1709045461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ftp80TfHVnvTcKFSKl+/tb9W0BxDNEh6+U0qPgQvLm8=;
 b=XoYvT5FcEbQCaEsJKhuUn1Hlzz6yffRvS6L6Ox5dHxiIDKRlQZkUnZz1G17eBHe+T7wP4L
 xYSF5AUYCm1YQzMnW9Ce2TjL1L4Xh9ZtG/MXrRIgtF78eHwFfhuz0I8LHoJ2CA/NYNFUv5
 NtVWDKq2qv0F3Wa0eRhmj25xkwaUgDA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1709045461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ftp80TfHVnvTcKFSKl+/tb9W0BxDNEh6+U0qPgQvLm8=;
 b=XoYvT5FcEbQCaEsJKhuUn1Hlzz6yffRvS6L6Ox5dHxiIDKRlQZkUnZz1G17eBHe+T7wP4L
 xYSF5AUYCm1YQzMnW9Ce2TjL1L4Xh9ZtG/MXrRIgtF78eHwFfhuz0I8LHoJ2CA/NYNFUv5
 NtVWDKq2qv0F3Wa0eRhmj25xkwaUgDA=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BFAF713ABC;
 Tue, 27 Feb 2024 14:51:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id mHqOLNT23WXMAQAAn2gu4w
 (envelope-from <roy.hopkins@suse.com>); Tue, 27 Feb 2024 14:51:00 +0000
From: Roy Hopkins <roy.hopkins@suse.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?J=C3=B6rg=20Roedel?= <jroedel@suse.com>
Subject: [PATCH 7/9] i386/sev: Refactor setting of reset vector and initial
 CPU state
Date: Tue, 27 Feb 2024 14:50:13 +0000
Message-ID: <bf045e3364a0575d9680832dec5acba7aa441895.1709044754.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709044754.git.roy.hopkins@suse.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=XoYvT5Fc
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[];
 R_RATELIMIT(0.00)[to_ip_from(RL1cdfboiju7js16zrknyuzw5d)];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.com:+];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1]; FROM_HAS_DN(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_HI(-3.50)[suse.com:dkim];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 RCPT_COUNT_TWELVE(0.00)[16]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 RCVD_TLS_ALL(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Queue-Id: 8922D22752
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When an SEV guest is started, the reset vector and state are
extracted from metadata that is contained in the firmware volume.

In preparation for using IGVM to setup the initial CPU state,
the code has been refactored to populate vmcb_save_area for each
CPU which is then applied during guest startup and CPU reset.

Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
---
 target/i386/sev.c | 288 +++++++++++++++++++++++++++++++++++++++++-----
 target/i386/sev.h | 110 ++++++++++++++++++
 2 files changed, 369 insertions(+), 29 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 173de91afe..d6902432fd 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -74,9 +74,7 @@ struct SevGuestState {
     SevState state;
     gchar *measurement;
 
-    uint32_t reset_cs;
-    uint32_t reset_ip;
-    bool reset_data_valid;
+    QTAILQ_HEAD(, SevLaunchVmsa) launch_vmsa;
 };
 
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
@@ -99,6 +97,12 @@ typedef struct QEMU_PACKED SevHashTableDescriptor {
 /* hard code sha256 digest size */
 #define HASH_SIZE 32
 
+/* Convert between SEV-ES VMSA and SegmentCache flags/attributes */
+#define FLAGS_VMSA_TO_SEGCACHE(flags) \
+    ((((flags) & 0xff00) << 12) | (((flags) & 0xff) << 8))
+#define FLAGS_SEGCACHE_TO_VMSA(flags) \
+    ((((flags) & 0xff00) >> 8) | (((flags) & 0xf00000) >> 12))
+
 typedef struct QEMU_PACKED SevHashTableEntry {
     QemuUUID guid;
     uint16_t len;
@@ -125,6 +129,15 @@ typedef struct QEMU_PACKED PaddedSevHashTable {
 QEMU_BUILD_BUG_ON(sizeof(PaddedSevHashTable) % 16 != 0);
 
 static SevGuestState *sev_guest;
+
+typedef struct SevLaunchVmsa {
+    QTAILQ_ENTRY(SevLaunchVmsa) next;
+
+    uint16_t cpu_index;
+    uint64_t gpa;
+    struct sev_es_save_area vmsa;
+} SevLaunchVmsa;
+
 static Error *sev_mig_blocker;
 
 static const char *const sev_fw_errlist[] = {
@@ -291,6 +304,149 @@ sev_guest_finalize(Object *obj)
 {
 }
 
+static void sev_apply_cpu_context(CPUState *cpu)
+{
+    SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
+    X86CPU *x86;
+    CPUX86State *env;
+    struct SevLaunchVmsa *launch_vmsa;
+
+    /* See if an initial VMSA has been provided for this CPU */
+    QTAILQ_FOREACH(launch_vmsa, &sev_guest->launch_vmsa, next)
+    {
+        if (cpu->cpu_index == launch_vmsa->cpu_index) {
+            x86 = X86_CPU(cpu);
+            env = &x86->env;
+
+            /*
+             * Ideally we would provide the VMSA directly to kvm which would
+             * ensure that the resulting initial VMSA measurement which is
+             * calculated during KVM_SEV_LAUNCH_UPDATE_VMSA is calculated from
+             * exactly what we provide here. Currently this is not possible so
+             * we need to copy the parts of the VMSA structure that we currently
+             * support into the CPU state.
+             */
+            cpu_load_efer(env, launch_vmsa->vmsa.efer);
+            cpu_x86_update_cr4(env, launch_vmsa->vmsa.cr4);
+            cpu_x86_update_cr0(env, launch_vmsa->vmsa.cr0);
+            cpu_x86_update_cr3(env, launch_vmsa->vmsa.cr3);
+
+            cpu_x86_load_seg_cache(
+                env, R_CS, launch_vmsa->vmsa.cs.selector,
+                launch_vmsa->vmsa.cs.base, launch_vmsa->vmsa.cs.limit,
+                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.cs.attrib));
+            cpu_x86_load_seg_cache(
+                env, R_DS, launch_vmsa->vmsa.ds.selector,
+                launch_vmsa->vmsa.ds.base, launch_vmsa->vmsa.ds.limit,
+                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.ds.attrib));
+            cpu_x86_load_seg_cache(
+                env, R_ES, launch_vmsa->vmsa.es.selector,
+                launch_vmsa->vmsa.es.base, launch_vmsa->vmsa.es.limit,
+                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.es.attrib));
+            cpu_x86_load_seg_cache(
+                env, R_FS, launch_vmsa->vmsa.fs.selector,
+                launch_vmsa->vmsa.fs.base, launch_vmsa->vmsa.fs.limit,
+                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.fs.attrib));
+            cpu_x86_load_seg_cache(
+                env, R_GS, launch_vmsa->vmsa.gs.selector,
+                launch_vmsa->vmsa.gs.base, launch_vmsa->vmsa.gs.limit,
+                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.gs.attrib));
+            cpu_x86_load_seg_cache(
+                env, R_SS, launch_vmsa->vmsa.ss.selector,
+                launch_vmsa->vmsa.ss.base, launch_vmsa->vmsa.ss.limit,
+                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.ss.attrib));
+
+            env->gdt.base = launch_vmsa->vmsa.gdtr.base;
+            env->gdt.limit = launch_vmsa->vmsa.gdtr.limit;
+            env->idt.base = launch_vmsa->vmsa.idtr.base;
+            env->idt.limit = launch_vmsa->vmsa.idtr.limit;
+
+            env->regs[R_EAX] = launch_vmsa->vmsa.rax;
+            env->regs[R_ECX] = launch_vmsa->vmsa.rcx;
+            env->regs[R_EDX] = launch_vmsa->vmsa.rdx;
+            env->regs[R_EBX] = launch_vmsa->vmsa.rbx;
+            env->regs[R_ESP] = launch_vmsa->vmsa.rsp;
+            env->regs[R_EBP] = launch_vmsa->vmsa.rbp;
+            env->regs[R_ESI] = launch_vmsa->vmsa.rsi;
+            env->regs[R_EDI] = launch_vmsa->vmsa.rdi;
+#ifdef TARGET_X86_64
+            env->regs[R_R8] = launch_vmsa->vmsa.r8;
+            env->regs[R_R9] = launch_vmsa->vmsa.r9;
+            env->regs[R_R10] = launch_vmsa->vmsa.r10;
+            env->regs[R_R11] = launch_vmsa->vmsa.r11;
+            env->regs[R_R12] = launch_vmsa->vmsa.r12;
+            env->regs[R_R13] = launch_vmsa->vmsa.r13;
+            env->regs[R_R14] = launch_vmsa->vmsa.r14;
+            env->regs[R_R15] = launch_vmsa->vmsa.r15;
+#endif
+            env->eip = launch_vmsa->vmsa.rip;
+            break;
+        }
+    }
+}
+
+static int sev_set_cpu_context(uint16_t cpu_index, const void *ctx,
+                               uint32_t ctx_len, hwaddr gpa)
+{
+    SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
+    SevLaunchVmsa *launch_vmsa;
+    CPUState *cpu;
+    bool exists = false;
+
+    /*
+     * Setting the CPU context is only supported for SEV-ES. The context buffer
+     * will contain a sev_es_save_area from the Linux kernel which is defined by
+     * "Table B-4. VMSA Layout, State Save Area for SEV-ES" in the AMD64 APM,
+     * Volume 2.
+     */
+
+    if (!sev_es_enabled()) {
+        error_report("SEV: unable to set CPU context: Not supported");
+        return 1;
+    }
+
+    if (ctx_len < sizeof(struct sev_es_save_area)) {
+        error_report("SEV: unable to set CPU context: "
+                     "Invalid context provided");
+        return 1;
+    }
+
+    cpu = qemu_get_cpu(cpu_index);
+    if (!cpu) {
+        error_report("SEV: unable to set CPU context for out of bounds "
+                     "CPU index %d", cpu_index);
+        return 1;
+    }
+
+    /*
+     * If the context of this VP has already been set then replace it with the
+     * new context.
+     */
+    QTAILQ_FOREACH(launch_vmsa, &sev_guest->launch_vmsa, next)
+    {
+        if (cpu_index == launch_vmsa->cpu_index) {
+            launch_vmsa->gpa = gpa;
+            memcpy(&launch_vmsa->vmsa, ctx, sizeof(launch_vmsa->vmsa));
+            exists = true;
+            break;
+        }
+    }
+
+    if (!exists) {
+        /* New VP context */
+        launch_vmsa = g_new0(SevLaunchVmsa, 1);
+        memcpy(&launch_vmsa->vmsa, ctx, sizeof(launch_vmsa->vmsa));
+        launch_vmsa->cpu_index = cpu_index;
+        launch_vmsa->gpa = gpa;
+        QTAILQ_INSERT_TAIL(&sev_guest->launch_vmsa, launch_vmsa, next);
+    }
+
+    /* Synchronise the VMSA with the current CPU state */
+    sev_apply_cpu_context(cpu);
+
+    return 0;
+}
+
 static char *
 sev_guest_get_session_file(Object *obj, Error **errp)
 {
@@ -394,6 +550,7 @@ sev_guest_instance_init(Object *obj)
     object_property_add_uint32_ptr(obj, "reduced-phys-bits",
                                    &sev->reduced_phys_bits,
                                    OBJ_PROP_FLAG_READWRITE);
+    QTAILQ_INIT(&sev->launch_vmsa);
 }
 
 /* sev guest info */
@@ -784,6 +941,16 @@ static int
 sev_launch_update_vmsa(SevGuestState *sev)
 {
     int ret, fw_error;
+    CPUState *cpu;
+
+    /*
+     * The initial CPU state is measured as part of KVM_SEV_LAUNCH_UPDATE_VMSA.
+     * Synchronise the CPU state to any provided launch VMSA structures.
+     */
+    CPU_FOREACH(cpu) {
+        sev_apply_cpu_context(cpu);
+    }
+
 
     ret = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL, &fw_error);
     if (ret) {
@@ -1196,34 +1363,99 @@ sev_es_find_reset_vector(void *flash_ptr, uint64_t flash_size,
     return sev_es_parse_reset_block(info, addr);
 }
 
-void sev_es_set_reset_vector(CPUState *cpu)
-{
-    X86CPU *x86;
-    CPUX86State *env;
 
-    /* Only update if we have valid reset information */
-    if (!sev_guest || !sev_guest->reset_data_valid) {
-        return;
-    }
+static void seg_to_vmsa(const SegmentCache *cpu_seg, struct vmcb_seg *vmsa_seg)
+{
+    vmsa_seg->selector = cpu_seg->selector;
+    vmsa_seg->base = cpu_seg->base;
+    vmsa_seg->limit = cpu_seg->limit;
+    vmsa_seg->attrib = FLAGS_SEGCACHE_TO_VMSA(cpu_seg->flags);
+}
 
-    /* Do not update the BSP reset state */
-    if (cpu->cpu_index == 0) {
-        return;
-    }
+static void initialize_vmsa(const CPUState *cpu, struct sev_es_save_area *vmsa)
+{
+    const X86CPU *x86 = X86_CPU(cpu);
+    const CPUX86State *env = &x86->env;
 
-    x86 = X86_CPU(cpu);
-    env = &x86->env;
+    /*
+     * Initialize the SEV-ES save area from the current state of
+     * the CPU. The entire state does not need to be copied, only the state
+     * that is copied back to the CPUState in sev_apply_cpu_context.
+     */
+    memset(vmsa, 0, sizeof(struct sev_es_save_area));
+    vmsa->efer = env->efer;
+    vmsa->cr0 = env->cr[0];
+    vmsa->cr3 = env->cr[3];
+    vmsa->cr4 = env->cr[4];
+
+    seg_to_vmsa(&env->segs[R_CS], &vmsa->cs);
+    seg_to_vmsa(&env->segs[R_DS], &vmsa->ds);
+    seg_to_vmsa(&env->segs[R_ES], &vmsa->es);
+    seg_to_vmsa(&env->segs[R_FS], &vmsa->fs);
+    seg_to_vmsa(&env->segs[R_GS], &vmsa->gs);
+    seg_to_vmsa(&env->segs[R_SS], &vmsa->ss);
+
+    seg_to_vmsa(&env->gdt, &vmsa->gdtr);
+    seg_to_vmsa(&env->idt, &vmsa->idtr);
+
+    vmsa->rax = env->regs[R_EAX];
+    vmsa->rcx = env->regs[R_ECX];
+    vmsa->rdx = env->regs[R_EDX];
+    vmsa->rbx = env->regs[R_EBX];
+    vmsa->rsp = env->regs[R_ESP];
+    vmsa->rbp = env->regs[R_EBP];
+    vmsa->rsi = env->regs[R_ESI];
+    vmsa->rdi = env->regs[R_EDI];
+
+#ifdef TARGET_X86_64
+    vmsa->r8 = env->regs[R_R8];
+    vmsa->r9 = env->regs[R_R9];
+    vmsa->r10 = env->regs[R_R10];
+    vmsa->r11 = env->regs[R_R11];
+    vmsa->r12 = env->regs[R_R12];
+    vmsa->r13 = env->regs[R_R13];
+    vmsa->r14 = env->regs[R_R14];
+    vmsa->r15 = env->regs[R_R15];
+#endif
+
+    vmsa->rip = env->eip;
+}
 
-    cpu_x86_load_seg_cache(env, R_CS, 0xf000, sev_guest->reset_cs, 0xffff,
-                           DESC_P_MASK | DESC_S_MASK | DESC_CS_MASK |
-                           DESC_R_MASK | DESC_A_MASK);
+static void sev_es_set_ap_context(uint32_t reset_addr)
+{
+    CPUState *cpu;
+    struct sev_es_save_area vmsa;
+    SegmentCache cs;
+
+    cs.selector = 0xf000;
+    cs.base = reset_addr & 0xffff0000;
+    cs.limit = 0xffff;
+    cs.flags = DESC_P_MASK | DESC_S_MASK | DESC_CS_MASK | DESC_R_MASK |
+               DESC_A_MASK;
+
+    CPU_FOREACH(cpu) {
+        if (cpu->cpu_index == 0) {
+            /* Do not update the BSP reset state */
+            continue;
+        }
+        initialize_vmsa(cpu, &vmsa);
+        seg_to_vmsa(&cs, &vmsa.cs);
+        vmsa.rip = reset_addr & 0x0000ffff;
+        sev_set_cpu_context(cpu->cpu_index, &vmsa,
+                            sizeof(struct sev_es_save_area), 0);
+        sev_apply_cpu_context(cpu);
+    }
+}
 
-    env->eip = sev_guest->reset_ip;
+void sev_es_set_reset_vector(CPUState *cpu)
+{
+    if (sev_enabled()) {
+        sev_apply_cpu_context(cpu);
+    }
 }
 
 int sev_es_save_reset_vector(void *flash_ptr, uint64_t flash_size)
 {
-    CPUState *cpu;
     uint32_t addr;
     int ret;
 
@@ -1238,14 +1470,12 @@ int sev_es_save_reset_vector(void *flash_ptr, uint64_t flash_size)
         return ret;
     }
 
+    /*
+     * The reset vector is saved into a CPU context for each AP but not for
+     * the BSP. This is applied during guest startup or when the CPU is reset.
+     */
     if (addr) {
-        sev_guest->reset_cs = addr & 0xffff0000;
-        sev_guest->reset_ip = addr & 0x0000ffff;
-        sev_guest->reset_data_valid = true;
-
-        CPU_FOREACH(cpu) {
-            sev_es_set_reset_vector(cpu);
-        }
+        sev_es_set_ap_context(addr);
     }
 
     return 0;
diff --git a/target/i386/sev.h b/target/i386/sev.h
index e7499c95b1..1fd896d896 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -38,6 +38,116 @@ typedef struct SevKernelLoaderContext {
     size_t cmdline_size;
 } SevKernelLoaderContext;
 
+/* Save area definition for SEV-ES and SEV-SNP guests */
+struct QEMU_PACKED sev_es_save_area {
+    struct vmcb_seg es;
+    struct vmcb_seg cs;
+    struct vmcb_seg ss;
+    struct vmcb_seg ds;
+    struct vmcb_seg fs;
+    struct vmcb_seg gs;
+    struct vmcb_seg gdtr;
+    struct vmcb_seg ldtr;
+    struct vmcb_seg idtr;
+    struct vmcb_seg tr;
+    uint64_t vmpl0_ssp;
+    uint64_t vmpl1_ssp;
+    uint64_t vmpl2_ssp;
+    uint64_t vmpl3_ssp;
+    uint64_t u_cet;
+    uint8_t reserved_0xc8[2];
+    uint8_t vmpl;
+    uint8_t cpl;
+    uint8_t reserved_0xcc[4];
+    uint64_t efer;
+    uint8_t reserved_0xd8[104];
+    uint64_t xss;
+    uint64_t cr4;
+    uint64_t cr3;
+    uint64_t cr0;
+    uint64_t dr7;
+    uint64_t dr6;
+    uint64_t rflags;
+    uint64_t rip;
+    uint64_t dr0;
+    uint64_t dr1;
+    uint64_t dr2;
+    uint64_t dr3;
+    uint64_t dr0_addr_mask;
+    uint64_t dr1_addr_mask;
+    uint64_t dr2_addr_mask;
+    uint64_t dr3_addr_mask;
+    uint8_t reserved_0x1c0[24];
+    uint64_t rsp;
+    uint64_t s_cet;
+    uint64_t ssp;
+    uint64_t isst_addr;
+    uint64_t rax;
+    uint64_t star;
+    uint64_t lstar;
+    uint64_t cstar;
+    uint64_t sfmask;
+    uint64_t kernel_gs_base;
+    uint64_t sysenter_cs;
+    uint64_t sysenter_esp;
+    uint64_t sysenter_eip;
+    uint64_t cr2;
+    uint8_t reserved_0x248[32];
+    uint64_t g_pat;
+    uint64_t dbgctl;
+    uint64_t br_from;
+    uint64_t br_to;
+    uint64_t last_excp_from;
+    uint64_t last_excp_to;
+    uint8_t reserved_0x298[80];
+    uint32_t pkru;
+    uint32_t tsc_aux;
+    uint8_t reserved_0x2f0[24];
+    uint64_t rcx;
+    uint64_t rdx;
+    uint64_t rbx;
+    uint64_t reserved_0x320; /* rsp already available at 0x01d8 */
+    uint64_t rbp;
+    uint64_t rsi;
+    uint64_t rdi;
+    uint64_t r8;
+    uint64_t r9;
+    uint64_t r10;
+    uint64_t r11;
+    uint64_t r12;
+    uint64_t r13;
+    uint64_t r14;
+    uint64_t r15;
+    uint8_t reserved_0x380[16];
+    uint64_t guest_exit_info_1;
+    uint64_t guest_exit_info_2;
+    uint64_t guest_exit_int_info;
+    uint64_t guest_nrip;
+    uint64_t sev_features;
+    uint64_t vintr_ctrl;
+    uint64_t guest_exit_code;
+    uint64_t virtual_tom;
+    uint64_t tlb_id;
+    uint64_t pcpu_id;
+    uint64_t event_inj;
+    uint64_t xcr0;
+    uint8_t reserved_0x3f0[16];
+
+    /* Floating point area */
+    uint64_t x87_dp;
+    uint32_t mxcsr;
+    uint16_t x87_ftw;
+    uint16_t x87_fsw;
+    uint16_t x87_fcw;
+    uint16_t x87_fop;
+    uint16_t x87_ds;
+    uint16_t x87_cs;
+    uint64_t x87_rip;
+    uint8_t fpreg_x87[80];
+    uint8_t fpreg_xmm[256];
+    uint8_t fpreg_ymm[256];
+};
+
 #ifdef CONFIG_SEV
 bool sev_enabled(void);
 bool sev_es_enabled(void);
-- 
2.43.0



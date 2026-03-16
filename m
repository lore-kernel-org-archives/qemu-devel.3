Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFAFF506D9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 14:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w28pA-0003Pr-Gu; Mon, 16 Mar 2026 10:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w28p9-0003Pi-Fy
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 10:21:39 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w28p7-0000VT-Eu
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 10:21:39 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1DAA05BD4F;
 Mon, 16 Mar 2026 14:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773670894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2HHKQ4XD/RnD73FiylGQFN7KrZXksOvdOWVX6T6dd8=;
 b=QTj+bdoRcYiMYSJ31BqU7NN5Ryn1XTEN2NQCcbnEE2vQLVbgp23tNwaGyZsVuiPsA39LYA
 qEgqranUn/VvxamGxm5VJANhJUlMt6gHWdkFPfAiqK6VdtqCydwAVO3VRmety9wH1vz6Yu
 uyCFlic/zn0MMmLl/T5rZpOw00x7Ef0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773670894;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2HHKQ4XD/RnD73FiylGQFN7KrZXksOvdOWVX6T6dd8=;
 b=dfGz/wG7VpokVoE/tKV7tVAdwKa7XvqBRPOr9RQapVqJLg1acIj9wVWA4q4+zv9NqImAPj
 xhCQCJicvXkeWJAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QTj+bdoR;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="dfGz/wG7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773670894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2HHKQ4XD/RnD73FiylGQFN7KrZXksOvdOWVX6T6dd8=;
 b=QTj+bdoRcYiMYSJ31BqU7NN5Ryn1XTEN2NQCcbnEE2vQLVbgp23tNwaGyZsVuiPsA39LYA
 qEgqranUn/VvxamGxm5VJANhJUlMt6gHWdkFPfAiqK6VdtqCydwAVO3VRmety9wH1vz6Yu
 uyCFlic/zn0MMmLl/T5rZpOw00x7Ef0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773670894;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2HHKQ4XD/RnD73FiylGQFN7KrZXksOvdOWVX6T6dd8=;
 b=dfGz/wG7VpokVoE/tKV7tVAdwKa7XvqBRPOr9RQapVqJLg1acIj9wVWA4q4+zv9NqImAPj
 xhCQCJicvXkeWJAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C3554273B;
 Mon, 16 Mar 2026 14:21:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id moi6GO0RuGn2FAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 16 Mar 2026 14:21:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Roman Kiryanov <rkir@google.com>, peterx@redhat.com
Cc: qemu-devel@nongnu.org, whollins@google.com, jansene@google.com,
 jpcottin@google.com, Roman Kiryanov <rkir@google.com>
Subject: Re: [PATCH v3] vmstate: validate VMStateDescription::fields upon
 registration
In-Reply-To: <20260313233538.1519319-1-rkir@google.com>
References: <20260313233538.1519319-1-rkir@google.com>
Date: Mon, 16 Mar 2026 11:21:31 -0300
Message-ID: <87341zsvmc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MISSING_XM_UA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[7];
 ASN(0.00)[asn:32098, ipnet:2800::/6, country:US];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 1DAA05BD4F
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

Roman Kiryanov <rkir@google.com> writes:

> The vmstate_save_state_v() function does not support
> NULL in VMStateDescription::fields and will crash if
> one is provided.
>
> This change prevents this situation from happening
> by explicitly crashing earlier.
>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
> v3:
>  - Also added assert to virtio.c to validate
>    VirtioDeviceClass instances which bypass
>    vmstate_register_with_alias_id.
>  - Updated the commit message to "Reviewed-by".
> v2:
>  - Moved the assert from vmstate_save_state_v to the registration
>    path (vmstate_register_with_alias_id) and the qtest validation path
>    (vmstate_check) to catch missing fields earlier.
> ---
>  hw/virtio/virtio.c | 6 ++++++
>  migration/savevm.c | 5 +++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 0ba734d0bc..e4543de335 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -4054,6 +4054,12 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
>      /* Devices should either use vmsd or the load/save methods */
>      assert(!vdc->vmsd || !vdc->load);
>  
> +    /*
> +     * If a device has vmsd, it either MUST have valid fields
> +     * or marked unmigratable.
> +     */
> +    assert(!vdc->vmsd || (vdc->vmsd->unmigratable || vdc->vmsd->fields));
> +
>      if (vdc->realize != NULL) {
>          vdc->realize(dev, &err);
>          if (err != NULL) {
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 197c89e0e6..20c2b99231 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -861,6 +861,8 @@ static void vmstate_check(const VMStateDescription *vmsd)
>      const VMStateField *field = vmsd->fields;
>      const VMStateDescription * const *subsection = vmsd->subsections;
>  
> +    assert(field || vmsd->unmigratable);
> +
>      if (field) {
>          while (field->name) {
>              if (field->flags & (VMS_STRUCT | VMS_VSTRUCT)) {
> @@ -900,6 +902,9 @@ int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
>      /* If this triggers, alias support can be dropped for the vmsd. */
>      assert(alias_id == -1 || required_for_version >= vmsd->minimum_version_id);
>  
> +    /* If vmsd is migratable it MUST have valid fields. */
> +    assert(vmsd->fields || vmsd->unmigratable);
> +
>      se = g_new0(SaveStateEntry, 1);
>      se->version_id = vmsd->version_id;
>      se->section_id = savevm_state.global_section_id++;

Looks like we'll also need to fix some stubs that define empty vmsds:

qemu-system-mips64: ../migration/savevm.c:864: void vmstate_check(const
VMStateDescription *): Assertion `field || vmsd->unmigratable' failed.

Maybe something like the following. Peter, what do you think?

-- >8 --
From 9bd63109e970ff231eb321e627f622910f9977ca Mon Sep 17 00:00:00 2001
From: Fabiano Rosas <farosas@suse.de>
Date: Mon, 16 Mar 2026 11:16:22 -0300
Subject: [PATCH] fixup! vmstate: validate VMStateDescription::fields upon
 registration

---
 hw/acpi/acpi-cpu-hotplug-stub.c | 4 +++-
 hw/acpi/acpi-mem-hotplug-stub.c | 4 +++-
 hw/acpi/acpi-pci-hotplug-stub.c | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-stub.c
index 72c5f05f5c..4332f3fb7d 100644
--- a/hw/acpi/acpi-cpu-hotplug-stub.c
+++ b/hw/acpi/acpi-cpu-hotplug-stub.c
@@ -3,7 +3,9 @@
 #include "hw/acpi/cpu.h"
 
 /* Following stubs are all related to ACPI cpu hotplug */
-const VMStateDescription vmstate_cpu_hotplug;
+const VMStateDescription vmstate_cpu_hotplug = {
+    .fields = (const VMStateField[]) { VMSTATE_END_OF_LIST() },
+};
 
 void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
                          CPUHotplugState *state, hwaddr base_addr)
diff --git a/hw/acpi/acpi-mem-hotplug-stub.c b/hw/acpi/acpi-mem-hotplug-stub.c
index 7ad0fdcdf2..36c12a4e5f 100644
--- a/hw/acpi/acpi-mem-hotplug-stub.c
+++ b/hw/acpi/acpi-mem-hotplug-stub.c
@@ -2,7 +2,9 @@
 #include "hw/acpi/memory_hotplug.h"
 #include "migration/vmstate.h"
 
-const VMStateDescription vmstate_memory_hotplug;
+const VMStateDescription vmstate_memory_hotplug = {
+    .fields = (const VMStateField[]) { VMSTATE_END_OF_LIST() },
+};
 
 void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
                               MemHotplugState *state, hwaddr io_base)
diff --git a/hw/acpi/acpi-pci-hotplug-stub.c b/hw/acpi/acpi-pci-hotplug-stub.c
index d58ea726a8..3e3a484d3e 100644
--- a/hw/acpi/acpi-pci-hotplug-stub.c
+++ b/hw/acpi/acpi-pci-hotplug-stub.c
@@ -2,7 +2,9 @@
 #include "hw/acpi/pcihp.h"
 #include "migration/vmstate.h"
 
-const VMStateDescription vmstate_acpi_pcihp_pci_status;
+const VMStateDescription vmstate_acpi_pcihp_pci_status = {
+    .fields = (const VMStateField[]) { VMSTATE_END_OF_LIST() },
+};
 
 void acpi_pcihp_init(Object *owner, AcpiPciHpState *s,
                      MemoryRegion *address_space_io, uint16_t io_base)
-- 
2.51.0



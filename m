Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A238C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAVx-0003Pz-M2; Wed, 29 Jan 2025 11:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVK-0003FE-2x
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:26 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVI-0005Et-70
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:25 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D86AA1F38D;
 Wed, 29 Jan 2025 16:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UhBWuoYyaNh7Eohj+j3R9Cz8Jl/GGRBfjxi2Go5tOvg=;
 b=Eftq8nFQZ4rF6jZvmXGs4AFfp1FvYI/x2plDMI09BvwcIIWxRKtnTjYTqCA6xvA6J9t66H
 lmoOyUMQG6KFg80Q9mxvsWuECFRxNj8nH0vHDE0dPeNSacQ6P/OBufEzOx3fVgBVkopIsS
 VGBVkfusmfPi2363w+jsxa9uMwKE+Ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166482;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UhBWuoYyaNh7Eohj+j3R9Cz8Jl/GGRBfjxi2Go5tOvg=;
 b=hzTHoNqW8IdP2QepxVyBEcezL916eLLir4Bg9ao8na0Cf2yTj8CTS5MrnSM2DXJpNRC3SC
 fAk2dPTENGW+ERBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Eftq8nFQ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hzTHoNqW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UhBWuoYyaNh7Eohj+j3R9Cz8Jl/GGRBfjxi2Go5tOvg=;
 b=Eftq8nFQZ4rF6jZvmXGs4AFfp1FvYI/x2plDMI09BvwcIIWxRKtnTjYTqCA6xvA6J9t66H
 lmoOyUMQG6KFg80Q9mxvsWuECFRxNj8nH0vHDE0dPeNSacQ6P/OBufEzOx3fVgBVkopIsS
 VGBVkfusmfPi2363w+jsxa9uMwKE+Ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166482;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UhBWuoYyaNh7Eohj+j3R9Cz8Jl/GGRBfjxi2Go5tOvg=;
 b=hzTHoNqW8IdP2QepxVyBEcezL916eLLir4Bg9ao8na0Cf2yTj8CTS5MrnSM2DXJpNRC3SC
 fAk2dPTENGW+ERBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 951E6137DB;
 Wed, 29 Jan 2025 16:01:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eJiJFdFQmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:01:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 07/42] machine: aux-ram-share option
Date: Wed, 29 Jan 2025 13:00:24 -0300
Message-Id: <20250129160059.6987-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.01 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; BAYES_SPAM(0.00)[13.29%];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,oracle.com:email];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: D86AA1F38D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Allocate auxilliary guest RAM as an anonymous file that is shareable
with an external process.  This option applies to memory allocated as
a side effect of creating various devices. It does not apply to
memory-backend-objects, whether explicitly specified on the command
line, or implicitly created by the -m command line option.

This option is intended to support new migration modes, in which the
memory region can be transferred in place to a new QEMU process, by sending
the memfd file descriptor to the process.  Memory contents are preserved,
and if the mode also transfers device descriptors, then pages that are
locked in memory for DMA remain locked.  This behavior is a pre-requisite
for supporting vfio, vdpa, and iommufd devices with the new modes.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1736967650-129648-7-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 hw/core/machine.c   | 22 ++++++++++++++++++++++
 include/hw/boards.h |  1 +
 qemu-options.hx     | 11 +++++++++++
 system/physmem.c    |  3 +++
 4 files changed, 37 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index c23b399496..2b11bc4f66 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -457,6 +457,22 @@ static void machine_set_mem_merge(Object *obj, bool value, Error **errp)
     ms->mem_merge = value;
 }
 
+#ifdef CONFIG_POSIX
+static bool machine_get_aux_ram_share(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return ms->aux_ram_share;
+}
+
+static void machine_set_aux_ram_share(Object *obj, bool value, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    ms->aux_ram_share = value;
+}
+#endif
+
 static bool machine_get_usb(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -1162,6 +1178,12 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "mem-merge",
         "Enable/disable memory merge support");
 
+#ifdef CONFIG_POSIX
+    object_class_property_add_bool(oc, "aux-ram-share",
+                                   machine_get_aux_ram_share,
+                                   machine_set_aux_ram_share);
+#endif
+
     object_class_property_add_bool(oc, "usb",
         machine_get_usb, machine_set_usb);
     object_class_property_set_description(oc, "usb",
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 2ad711e56d..e1f41b2a53 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -410,6 +410,7 @@ struct MachineState {
     bool enable_graphics;
     ConfidentialGuestSupport *cgs;
     HostMemoryBackend *memdev;
+    bool aux_ram_share;
     /*
      * convenience alias to ram_memdev_id backend memory region
      * or to numa container memory region
diff --git a/qemu-options.hx b/qemu-options.hx
index 7090d59f6f..90fad31590 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -38,6 +38,9 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                nvdimm=on|off controls NVDIMM support (default=off)\n"
     "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
     "                hmat=on|off controls ACPI HMAT support (default=off)\n"
+#ifdef CONFIG_POSIX
+    "                aux-ram-share=on|off allocate auxiliary guest RAM as shared (default: off)\n"
+#endif
     "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
     "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n",
     QEMU_ARCH_ALL)
@@ -101,6 +104,14 @@ SRST
         Enables or disables ACPI Heterogeneous Memory Attribute Table
         (HMAT) support. The default is off.
 
+    ``aux-ram-share=on|off``
+        Allocate auxiliary guest RAM as an anonymous file that is
+        shareable with an external process.  This option applies to
+        memory allocated as a side effect of creating various devices.
+        It does not apply to memory-backend-objects, whether explicitly
+        specified on the command line, or implicitly created by the -m
+        command line option.  The default is off.
+
     ``memory-backend='id'``
         An alternative to legacy ``-mem-path`` and ``mem-prealloc`` options.
         Allows to use a memory backend as main RAM.
diff --git a/system/physmem.c b/system/physmem.c
index 03fac0a64f..cb80ce3091 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2114,6 +2114,9 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
 
 #ifdef CONFIG_POSIX         /* ignore RAM_SHARED for Windows */
     if (!host) {
+        if (!share_flags && current_machine->aux_ram_share) {
+            ram_flags |= RAM_SHARED;
+        }
         if (ram_flags & RAM_SHARED) {
             const char *name = memory_region_name(mr);
             int fd = qemu_ram_get_shared_fd(name, errp);
-- 
2.35.3



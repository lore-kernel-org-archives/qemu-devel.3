Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD2ECCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXgm-0006hM-3b; Wed, 22 Oct 2025 08:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vBXgY-0006fe-Us
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:11:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vBXgV-0006FO-Fm
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761135078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SZoPCTibKsXFGSpdbRs0ENuEKqZfpK9mg/7h/xYqpds=;
 b=Gy6/tj7SWfkjqQWPm/yK8uDThq4HBZpqsm/KCeiD1yFs/B03DpDIWL0WblUvM8dk4IBg48
 pUvx1346vDhHbtbRwqg5lUO2pt+sv7IvEsPiGiWCvLldMWmk31JvrPAh+3sPQkAJsG3MdP
 LU0G/iSZFhXKUMUFfM7v9g/5Eztl7iE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-Jb1W9YpFP-uNGL-RYZsGqw-1; Wed, 22 Oct 2025 08:11:16 -0400
X-MC-Unique: Jb1W9YpFP-uNGL-RYZsGqw-1
X-Mimecast-MFC-AGG-ID: Jb1W9YpFP-uNGL-RYZsGqw_1761135076
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4e89265668fso28261361cf.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 05:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761135076; x=1761739876;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZoPCTibKsXFGSpdbRs0ENuEKqZfpK9mg/7h/xYqpds=;
 b=wiJQu6Pk+aNZ5Z+8h6YDzZQUbIyCLGGW4XhSspZjlxMO+re2elM75Gh94ojBpY6d5o
 si2SzBNXAPcSeqUXfSocmHG+uMeHhxBBRUqoFnVWKJPQY1al8S4OH/D8m6V3OILYEvEB
 dXMQtr3NsBy/luzMObO4z/mQmxhGt1feq4Er+lkpSPMwuASJpvEDr8ml7C8GYmaaAiZT
 0Q+aoeLTvLzFAI0HYPHTJ3pVL3oDVmw+E7z/aiKbNxizB4S/YuFbTbcnL1bnH3++D5mG
 1Pdy/D787jy0VHxFdjimq7M/3V4xpObdGbB5lsOmFywdAatpxr0ppVUjUcLd9jpQ7Ty6
 tjQQ==
X-Gm-Message-State: AOJu0YyKelIMTBJDBhWk0/4PnaRoFdXU6282FZ4ehg5q++G/t4aDZCsK
 XvfRdRbl1L6C+IgtduBlriQIWn984pZjJtfn2eaoWzDomaqWI3KB8Y/lgKdRbt+8pI0Tz3OONrw
 uwEiBm0y6KBnqpg//4qaYEIIlpT3/xX2NWm4suRPVvnKFEZ8+/+phxwxq
X-Gm-Gg: ASbGncu6ti89WbjpkgDWAxWhiNjgrW2LGDDxjYtwhBG3cqZdcFkr961Ao1FkfWUVi0s
 ptgMp2QsdblVz7Rv1QfgGjAG/LcS5wg+W+CNilzP4q4fTMQsJK4f4F/FiCgjUZZNmdbsz1dja0I
 mPq6gTXOz65/3JOXZMT/Ndr2aWGAMmWGcIw2yoVVVTt9iE7PX/Eiw1n3kqK0AuzIH2ja//50tS6
 Yv31YbD6WUMCB3YGP1kZJrjhKQtOEmIHCC6h27LHYg10q+FHXl+qlM19cRbaKuhdeib5c49OqQc
 v3bp0fLQBXPAOu2xzc2M5Ks+0/gDru0q5iPnZLQ4761vSo402Sge4Oj0DQs/oxjIsnU5JeYOVeA
 q7W8=
X-Received: by 2002:ac8:598b:0:b0:4e8:912a:bdc5 with SMTP id
 d75a77b69052e-4e89d2760camr232736501cf.27.1761135076311; 
 Wed, 22 Oct 2025 05:11:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXkkKJPLBB2t6hn2BhD58d/pJYKEXVpUGhiLQTw+UyeG+FtokbvfHNDfNj2dxL/c++DeY81A==
X-Received: by 2002:ac8:598b:0:b0:4e8:912a:bdc5 with SMTP id
 d75a77b69052e-4e89d2760camr232736131cf.27.1761135075882; 
 Wed, 22 Oct 2025 05:11:15 -0700 (PDT)
Received: from leonardi-redhat ([151.29.47.252])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-891cd57c825sm960601585a.28.2025.10.22.05.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 05:11:15 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:11:10 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roy Hopkins <roy.hopkins@randomman.co.uk>
Subject: Re: [PATCH v4 3/5] igvm: add support for igvm memory map parameter
 in native mode
Message-ID: <wube2wvgsjtl4upcbnkucppfkczdscxpgx3ugwh47twvfoucxf@tuny57lf7ywj>
References: <20251022084439.242476-1-kraxel@redhat.com>
 <20251022084439.242476-4-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251022084439.242476-4-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 22, 2025 at 10:44:37AM +0200, Gerd Hoffmann wrote:
>Add and wire up qigvm_x86_get_mem_map_entry function which converts the
>e820 table into an igvm memory map parameter.  This makes igvm files for
>the native (non-confidential) platform with memory map parameter work.
>
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> include/system/igvm.h   |  5 +++++
> backends/igvm.c         | 16 ++++++++++----
> stubs/igvm.c            | 21 +++++++++++++++++++
> target/i386/igvm.c      | 46 +++++++++++++++++++++++++++++++++++++++++
> stubs/meson.build       |  1 +
> target/i386/meson.build |  3 +++
> 6 files changed, 88 insertions(+), 4 deletions(-)
> create mode 100644 stubs/igvm.c
> create mode 100644 target/i386/igvm.c
>
>diff --git a/include/system/igvm.h b/include/system/igvm.h
>index a4abab043a1f..3f72a40b8897 100644
>--- a/include/system/igvm.h
>+++ b/include/system/igvm.h
>@@ -19,4 +19,9 @@
> int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
>                       bool onlyVpContext, Error **errp);
>
>+/* x86 native */
>+int qigvm_x86_get_mem_map_entry(int index,
>+                                ConfidentialGuestMemoryMapEntry *entry,
>+                                Error **errp);
>+
> #endif
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 055bbba745ad..2ab7a9d96565 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -12,6 +12,7 @@
> #include "qemu/osdep.h"
>
> #include "qapi/error.h"
>+#include "qemu/target-info-qapi.h"
> #include "system/igvm.h"
> #include "system/memory.h"
> #include "system/address-spaces.h"
>@@ -543,6 +544,8 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
>                                       Error **errp)
> {
>     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>+    int (*get_mem_map_entry)(int index, ConfidentialGuestMemoryMapEntry *entry,
>+                             Error **errp) = NULL;
>     QIgvmParameterData *param_entry;
>     int max_entry_count;
>     int entry = 0;
>@@ -550,7 +553,13 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
>     ConfidentialGuestMemoryMapEntry cgmm_entry;
>     int retval = 0;
>
>-    if (!ctx->cgs) {
>+    if (ctx->cgs && ctx->cgsc->get_mem_map_entry) {
>+        get_mem_map_entry = ctx->cgsc->get_mem_map_entry;
>+
>+    } else if (target_arch() == SYS_EMU_TARGET_X86_64) {
>+        get_mem_map_entry = qigvm_x86_get_mem_map_entry;
>+
>+    } else {
>         error_setg(errp,
>                    "IGVM file contains a memory map but this is not supported "
>                    "by the current system.");
>@@ -565,7 +574,7 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
>                 param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
>             mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
>
>-            retval = ctx->cgsc->get_mem_map_entry(entry, &cgmm_entry, errp);
>+            retval = get_mem_map_entry(entry, &cgmm_entry, errp);
>             while (retval == 0) {
>                 if (entry >= max_entry_count) {
>                     error_setg(
>@@ -598,8 +607,7 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
>                         IGVM_MEMORY_MAP_ENTRY_TYPE_PLATFORM_RESERVED;
>                     break;
>                 }
>-                retval =
>-                    ctx->cgsc->get_mem_map_entry(++entry, &cgmm_entry, errp);
>+                retval = get_mem_map_entry(++entry, &cgmm_entry, errp);
>             }
>             if (retval < 0) {
>                 return retval;
>diff --git a/stubs/igvm.c b/stubs/igvm.c
>new file mode 100644
>index 000000000000..c32058eb2a6e
>--- /dev/null
>+++ b/stubs/igvm.c
>@@ -0,0 +1,21 @@
>+/*
>+ * QEMU IGVM, stubs
>+ *
>+ * Copyright (C) 2026 Red Hat
>+ *
>+ * Authors:
>+ *  Gerd Hoffmann <kraxel@redhat.com>
>+ *
>+ * SPDX-License-Identifier: GPL-2.0-or-later
>+ */
>+
>+#include "qemu/osdep.h"
>+
>+#include "system/igvm.h"
>+
>+int qigvm_x86_get_mem_map_entry(int index,
>+                                ConfidentialGuestMemoryMapEntry *entry,
>+                                Error **errp)
>+{
>+    return -1;
>+}
>diff --git a/target/i386/igvm.c b/target/i386/igvm.c
>new file mode 100644
>index 000000000000..2ed6cd052c79
>--- /dev/null
>+++ b/target/i386/igvm.c
>@@ -0,0 +1,46 @@
>+/*
>+ * QEMU IGVM, support for native x86 guests
>+ *
>+ * Copyright (C) 2026 Red Hat
>+ *
>+ * Authors:
>+ *  Gerd Hoffmann <kraxel@redhat.com>
>+ *
>+ * SPDX-License-Identifier: GPL-2.0-or-later
>+ */
>+
>+#include "qemu/osdep.h"
>+
>+#include "hw/i386/e820_memory_layout.h"
>+#include "system/igvm.h"
>+
>+/*
>+ * convert e820 table into igvm memory map
>+ */
>+int qigvm_x86_get_mem_map_entry(int index,
>+                                ConfidentialGuestMemoryMapEntry *entry,
>+                                Error **errp)
>+{
>+    struct e820_entry *table;
>+    int num_entries;
>+
>+    num_entries = e820_get_table(&table);
>+    if ((index < 0) || (index >= num_entries)) {
>+        return 1;
>+    }
>+    entry->gpa = table[index].address;
>+    entry->size = table[index].length;
>+    switch (table[index].type) {
>+    case E820_RAM:
>+        entry->type = CGS_MEM_RAM;
>+        break;
>+    case E820_RESERVED:
>+        entry->type = CGS_MEM_RESERVED;
>+        break;
>+    default:
>+        /* should not happen */
>+        error_setg(errp, "unknown e820 type");
>+        return -1;
>+    }
>+    return 0;
>+}
>diff --git a/stubs/meson.build b/stubs/meson.build
>index 5d577467bfdd..27be2dec9f9e 100644
>--- a/stubs/meson.build
>+++ b/stubs/meson.build
>@@ -74,6 +74,7 @@ if have_system
>   stub_ss.add(files('dump.c'))
>   stub_ss.add(files('cmos.c'))
>   stub_ss.add(files('fw_cfg.c'))
>+  stub_ss.add(files('igvm.c'))
>   stub_ss.add(files('target-get-monitor-def.c'))
>   stub_ss.add(files('target-monitor-defs.c'))
>   stub_ss.add(files('win32-kbd-hook.c'))
>diff --git a/target/i386/meson.build b/target/i386/meson.build
>index 89ba4912aaeb..d385eafdf7e1 100644
>--- a/target/i386/meson.build
>+++ b/target/i386/meson.build
>@@ -26,6 +26,9 @@ i386_system_ss.add(files(
> ))
> i386_system_ss.add(when: 'CONFIG_SEV', if_true: files('sev.c'),
>                                        if_false: files('sev-system-stub.c'))
>+if igvm.found()
>+  i386_system_ss.add(files('igvm.c'))
>+endif
>
> i386_user_ss = ss.source_set()
>
>-- 
>2.51.0
>

LGTM!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>



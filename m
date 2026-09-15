Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76869C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 09:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6PTB-0002u8-Hm; Tue, 15 Sep 2026 05:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x6PTA-0002tc-9s
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 05:28:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x6PT7-0000p5-Od
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 05:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789464528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4W55r3fXq7eFTJq27Sg6nFHn+nfShtn+W1qtjGIBT1k=;
 b=XicWwHGJ4/hsRJrLty89AuvunGx9KpfYDZsRuX+M4ManEsX9Vr13lfGFIYHdGopq45MlbT
 TeOne9REwQBNXK/D1sWHWWILKquF1RSV8UqWEGQY33mzfncGirmk8Sndpx8mihaSoECXqo
 DPBBqMSDHZEvnd4qpgPWiRpdC50jeyY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-LggsC1KVPNKT4Xb3fIl6DQ-1; Tue, 15 Sep 2026 05:28:47 -0400
X-MC-Unique: LggsC1KVPNKT4Xb3fIl6DQ-1
X-Mimecast-MFC-AGG-ID: LggsC1KVPNKT4Xb3fIl6DQ_1789464525
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49e64b80b94so24270165e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 02:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789464525; x=1790069325; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4W55r3fXq7eFTJq27Sg6nFHn+nfShtn+W1qtjGIBT1k=;
 b=szJ3tCvxOHseHwEhjEbTnOy0DV44zMMJfgNGJAduzTH1em/CFJ77Kv4dmMDjPFqEbV
 P0Cyk6MYei/t77UwbRH/BVkHXG0ACRp6EzyZFhiKIMdsRuR8lmE7K5j7LgcOdDBCADT5
 z1QYwFitR9MWR+pBjpH9dJiE0NSFvJEGeCNJaqvvfj7EwrG7O/2CgR6KEIIijjuDAW8h
 sibyFMus1rVrk1PWIIdW54MSUMHYiMQoMTVuEdU8Jlvwp1zsdUfm3kZw5fVD//zw0HjV
 dh2wIgXNkHr6g8Z19yGh5n8v8i91ieZWC2EJ5BnC0l25sFmvW2+aVgkN+k5VBK+zdJed
 Nhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789464525; x=1790069325;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4W55r3fXq7eFTJq27Sg6nFHn+nfShtn+W1qtjGIBT1k=;
 b=b5EQYhcXfvX6wl3lHU7hTvmlIpYM1oOMEt+xhm200yNd6X+rcaHuy5H3FQhOT1Ghx1
 fcU1uugyrRqMp7QtdZ9VjE1kSe1f//tRqzyNQPzAjnaeEe48HOh9sYnxRWe4YE+hQHwm
 w9yciNF4fcc+Ki9UoAAT2bZYdZkav+1IbOG8sDpbH31C8lDr1XCvxcomVPtDcBKX9DVO
 ebySArtJKXN5CBppVvgUR2+qRYJg5fDaCMf442SIwZ+7GVcRsBzo0MdjwC7q8D3mkJxb
 8ay3FiVavGJaPElvD8eLZK/QUQnQITE48QAEDgXDT6zVI+p0k8v4K06B7B0RsLorBI4P
 N83w==
X-Gm-Message-State: AFuF++kwX3HsUOSes3N3bhY/yyVdPqqFsfZR8VC8Rw6xpjfUJFR+qpLn
 JyvnDofDJ7N9kAMwnzJAXbqeHab4QyWYuhgn5ZhNTs5L1lSia1UuuQV4ATFaUJtvOKT6NcOE8Rf
 HV26hCsNUZE1qanvjdebhy2jgVkfy+XIHuIodNxHpk0sv7RJZ9O1m3YW4
X-Gm-Gg: AYBFou1/0dSERL6OenxyQoZRgUDspr78FFeuG+x1B/YZ5PDYyLdlOQLl0cVQORFIyir
 6Omwg+4+PZf7aNlmij5a8tXeeSXWBD7AXr4TjSVhuGx4zAn4hFiEw+M6sihdvBZw01h0mrHUuXO
 2y7UV3HpD1PQ9Cwttalb9r3alwGB3e4eFDJf9nr4JFNgNPdjbFv1Me+KgfNt2/d+EQ0NLppMW31
 mpbdWlquUo/gKwfn9AX0EZrDWLN1VYKy6kRpxHlvsq8YyWVhWx9+5eiUuCBXYy2hAkW2eR3htOf
 lEMg6pj5k8/NAO5s456nywuQaLiLULmlQ6gIN6Q04LOpg9i71yA/p8uQfwP8xxTpwGsDUKEL04n
 gsSRs1xGxBiOjwvS1HbfymUeOjGn3X8TLesO/yXFyX76cgg==
X-Received: by 2002:a05:6000:2403:b0:485:943c:886d with SMTP id
 ffacd0b85a97d-48702ad29bemr14174750f8f.7.1789464524555; 
 Tue, 15 Sep 2026 02:28:44 -0700 (PDT)
X-Received: by 2002:a05:6000:2403:b0:485:943c:886d with SMTP id
 ffacd0b85a97d-48702ad29bemr14174658f8f.7.1789464523955; 
 Tue, 15 Sep 2026 02:28:43 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb2ecf2esm32574552f8f.2.2026.09.15.02.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 02:28:43 -0700 (PDT)
Date: Tue, 15 Sep 2026 11:28:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH v4] igvm: validate and honor byte_offset in parameter
 directives
Message-ID: <aqkH5Qi-mrV84ZDt@sgarzare-redhat>
References: <20260914-fix_offset-v4-1-39d74497c6b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260914-fix_offset-v4-1-39d74497c6b5@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Mon, Sep 14, 2026 at 01:02:43PM +0200, Luigi Leonardi wrote:
>None of the directive handlers that place data within a parameter area
>validated that param->byte_offset actually falls within the parameter
>area's size. A malformed IGVM file with byte_offset > size would
>underflow the "size - byte_offset" computation used to determine

I'm a bit confused about this commit description. Before this patch, 
where we did "size - byte_offset" computation ?

>remaining space, wrapping to a huge value and defeating the size

IIUC the size check was completely missing, no?

>check, then write out of bounds through param_entry->data +
>byte_offset.

>
>Separately, qigvm_directive_memory_map(), qigvm_directive_madt() and
>qigvm_directive_device_tree() ignored param->byte_offset entirely and
>always wrote at the start of the parameter area's buffer. This is
>harmless when a directive's offset happens to be 0, but breaks for
>IGVM files that pack multiple parameters into a single shared
>parameter area at different offsets: a later directive would
>overwrite the data written by an earlier one, corrupting it.
>
>Add qigvm_get_param_data(), which looks up the parameter area, checks
>byte_offset against its size, and returns the offset-adjusted data
>pointer directly (NULL on failure), with the remaining space returned
>via an output parameter, instead of the raw QIgvmParameterData entry.
>This keeps the byte_offset arithmetic and bounds check in one place
>instead of repeating it at every call site.
>
>Switch every directive handler that reads or writes parameter data
>to use it, adding explicit checks that each fixed-size read/write fits in
>the remaining space.

IMO this descriptipn is unnecessarily lengthy, so here's a concise 
version (IIUC the issue and what this patch does):

   igvm: validate and honor byte_offset in parameter directives

   Parameter directive handlers either ignore param->byte_offset,
   overwriting each other when several parameters share one area, or use
   it without validating it, letting a malformed IGVM file corrupt QEMU's
   memory.

   Add qigvm_get_param_data(), which validates byte_offset against the
   parameter area size and returns the offset-adjusted pointer together
   with the space left after it. Convert all parameter directive handlers
   to use it and to check their writes against that remaining space, so
   that no parameter can be written past the end of its area.


This is just an idea, and I'm not sure I've fully understood it. Feel 
free to expand on it, change it, etc.

>
>Fixes: c1d466d267 ("backends/igvm: Add IGVM loader and configuration")
>Fixes: dea1f68a5c ("igvm: Fill MADT IGVM parameter field on x86_64")
>Fixes: 1c4bd8f13c ("igvm: add device tree parameter support")
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
>Several IGVM directives (memory map, vp-count, environment info, MADT,
>device tree) _can_ place their data at a byte_offset within a shared
>parameter area, letting multiple parameters be packed into one area.

This maybe can be introduced in the commit description.

>
>Introduce qigvm_get_param_data(), which looks up a
>parameter area and validates that byte_offset falls within it in one
>step, and uses it in the vp-count and environment-info handlers, which
>already relied on byte_offset.
>
>Also fixes the memory map, MADT and device tree handlers, which
>ignored byte_offset entirely and always wrote at the start of the
>buffer, potentially corrupting earlier data when several parameters
>share an area.
>---
>Changes in v4:
>- Squashed two commits in one.
>- Removed one parameter from `qigvm_get_param_data` [Stefano]
>- Removed some useless variables [Stefano]
>- Rebased to latest upstream
>- Link to v3: https://lore.kernel.org/qemu-devel/20260907-fix_offset-v3-0-bcffcefc0985@redhat.com
>
>Changes in v3:
>- Renamed the function to `qigvm_get_param_data`. [Stefano]
>- `qigvm_get_param_data` now returns the data pointer directly [Stefano]
>- Added fixes tags. [Stefano]
>- Renamed variables to param_data and param_size [Stefano]
>- Link to v2: https://lore.kernel.org/qemu-devel/20260904-fix_offset-v2-0-f5bb4cf6d4b0@redhat.com
>
>Changes in v2:
>- Inverted commit order: first I introduce the helper and use it where
>  necessary, then in commit 2 I handle the `offset`. [Stefano]
>- The helper now returns data and size, that already consider the byte
>  offset [Stefano]
>- Link to v1: https://lore.kernel.org/qemu-devel/20260902-fix_offset-v1-0-04b18f7595b2@redhat.com
>---
> backends/igvm.c                | 89 +++++++++++++++++++++++++++++++-----------
> include/system/igvm-internal.h |  5 +++
> target/i386/igvm.c             | 12 +++---
> 3 files changed, 77 insertions(+), 29 deletions(-)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 7b7bdc72b7..9a2bafc0ca 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -101,6 +101,38 @@ qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
>     return NULL;
> }
>
>+/*
>+ * Get parameter area data at byte_offset with bounds validation.
>+ * On success, returns offset-adjusted data pointer and sets param_size
>+ * to remaining space.
>+ * Returns NULL on failure.
>+ */
>+uint8_t *
>+qigvm_get_param_data(QIgvm *igvm, const IGVM_VHS_PARAMETER *param,
>+                     uint32_t *param_size,
>+                     Error **errp)
>+{
>+    QIgvmParameterData *param_entry;
>+
>+    assert(param_size);
>+
>+    param_entry = qigvm_find_param_entry(igvm, param->parameter_area_index,
>+                                         errp);
>+    if (!param_entry) {
>+        return NULL;
>+    }
>+
>+    if (param->byte_offset > param_entry->size) {
>+        error_setg(errp,
>+                   "IGVM: byte_offset 0x%x exceeds parameter area size 0x%x",
>+                   param->byte_offset, param_entry->size);
>+        return NULL;
>+    }
>+
>+    *param_size = param_entry->size - param->byte_offset;
>+    return param_entry->data + param->byte_offset;
>+}
>+
> static int qigvm_directive_page_data(QIgvm *ctx, const uint8_t *header_data,
>                                      Error **errp);
> static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
>@@ -605,7 +637,7 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
>     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>     int (*get_mem_map_entry)(int index, ConfidentialGuestMemoryMapEntry *entry,
>                              Error **errp) = NULL;
>-    QIgvmParameterData *param_entry;
>+    uint32_t param_size;
>     int max_entry_count;
>     int entry = 0;
>     IGVM_VHS_MEMORY_MAP_ENTRY *mm_entry;
>@@ -626,14 +658,14 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
>     }
>
>     /* Find the parameter area that should hold the memory map */
>-    param_entry = qigvm_find_param_entry(ctx,
>-                                         param->parameter_area_index, errp);
>-    if (param_entry == NULL) {
>+    mm_entry =
>+        (IGVM_VHS_MEMORY_MAP_ENTRY *)qigvm_get_param_data(ctx, param,
>+                                                          &param_size, errp);
>+    if (!mm_entry) {
>         return -1;
>     }
>
>-    max_entry_count = param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
>-    mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
>+    max_entry_count = param_size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
>
>     retval = get_mem_map_entry(entry, &cgmm_entry, errp);
>     while (retval == 0) {
>@@ -682,17 +714,22 @@ static int qigvm_directive_vp_count(QIgvm *ctx, const uint8_t *header_data,
>                                     Error **errp)
> {
>     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>-    QIgvmParameterData *param_entry;
>+    uint32_t param_size;
>     uint32_t *vp_count;
>     CPUState *cpu;
>
>-    param_entry = qigvm_find_param_entry(ctx,
>-                                         param->parameter_area_index, errp);
>-    if (param_entry == NULL) {
>+    vp_count = (uint32_t *)qigvm_get_param_data(ctx, param, &param_size, errp);
>+    if (!vp_count) {
>+        return -1;
>+    }
>+
>+    if (sizeof(*vp_count) > param_size) {
>+        error_setg(errp,
>+                   "IGVM: vp-count parameter exceeds parameter area "
>+                   "defined in IGVM file");
>         return -1;
>     }
>
>-    vp_count = (uint32_t *)(param_entry->data + param->byte_offset);
>     *vp_count = 0;
>     CPU_FOREACH(cpu)
>     {
>@@ -707,17 +744,23 @@ static int qigvm_directive_environment_info(QIgvm *ctx,
>                                             Error **errp)
> {
>     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>-    QIgvmParameterData *param_entry;
>+    uint32_t param_size;
>     IgvmEnvironmentInfo *environmental_state;
>
>-    param_entry = qigvm_find_param_entry(ctx,
>-                                         param->parameter_area_index, errp);
>-    if (param_entry == NULL) {
>+    environmental_state =
>+        (IgvmEnvironmentInfo *)qigvm_get_param_data(ctx, param, &param_size,
>+                                                    errp);
>+    if (!environmental_state) {
>+        return -1;
>+    }
>+
>+    if (sizeof(*environmental_state) > param_size) {
>+        error_setg(errp,
>+                   "IGVM: environment-info parameter exceeds parameter area "
>+                   "defined in IGVM file");
>         return -1;
>     }
>
>-    environmental_state =
>-        (IgvmEnvironmentInfo *)(param_entry->data + param->byte_offset);
>     environmental_state->memory_is_shared = 1;
>
>     return 0;
>@@ -814,12 +857,12 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
> {
>     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>     g_autofree void *fdt_packed = NULL;
>-    QIgvmParameterData *param_entry;
>+    uint8_t *param_data;
>+    uint32_t param_size;
>     uint32_t fdt_size;
>
>-    param_entry = qigvm_find_param_entry(ctx,
>-                                         param->parameter_area_index, errp);
>-    if (param_entry == NULL) {
>+    param_data = qigvm_get_param_data(ctx, param, &param_size, errp);
>+    if (!param_data) {
>         return -1;
>     }
>
>@@ -837,14 +880,14 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>     }
>
>     fdt_size = fdt_totalsize(fdt_packed);
>-    if (fdt_size > param_entry->size) {
>+    if (fdt_size > param_size) {
>         error_setg(errp,
>                    "IGVM: device tree size exceeds parameter area"
>                    " defined in IGVM file");
>         return -1;
>     }
>
>-    memcpy(param_entry->data, fdt_packed, fdt_size);
>+    memcpy(param_data, fdt_packed, fdt_size);
>
>     return 0;
> }
>diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
>index 9e9fa1d9af..0467eff0ce 100644
>--- a/include/system/igvm-internal.h
>+++ b/include/system/igvm-internal.h
>@@ -81,4 +81,9 @@ QIgvmParameterData*
> qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
>                        Error **errp);

qigvm_find_param_entry() is now used only in backends/igvm.c, so I think 
we can make it static and remove from here, up to you if you prefer here 
or in a cleanup patch.

The rest LGTM.

Stefano

>
>+uint8_t *
>+qigvm_get_param_data(QIgvm *igvm, const IGVM_VHS_PARAMETER *param,
>+                     uint32_t *param_size,
>+                     Error **errp);
>+
> #endif
>diff --git a/target/i386/igvm.c b/target/i386/igvm.c
>index ad9bf87761..9c2f8d5164 100644
>--- a/target/i386/igvm.c
>+++ b/target/i386/igvm.c
>@@ -187,20 +187,20 @@ void qigvm_x86_bsp_reset(CPUX86State *env)
> int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
> {
>     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>-    QIgvmParameterData *param_entry;
>+    uint8_t *param_data;
>+    uint32_t param_size;
>     int result = 0;
>
>     /* Find the parameter area that should hold the MADT data */
>-    param_entry = qigvm_find_param_entry(ctx,
>-                                         param->parameter_area_index, errp);
>-    if (param_entry == NULL) {
>+    param_data = qigvm_get_param_data(ctx, param, &param_size, errp);
>+    if (!param_data) {
>         return -1;
>     }
>
>     GArray *madt = acpi_build_madt_standalone(ctx->machine_state);
>
>-    if (madt->len <= param_entry->size) {
>-        memcpy(param_entry->data, madt->data, madt->len);
>+    if (madt->len <= param_size) {
>+        memcpy(param_data, madt->data, madt->len);
>     } else {
>         error_setg(
>             errp,
>
>---
>base-commit: 5f664cd37aec17e8145aa117d8da68f507edc8f1
>change-id: 20260902-fix_offset-a268cb12aafc
>
>Best regards,
>-- 
>Luigi Leonardi <leonardi@redhat.com>
>



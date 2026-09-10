Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE196C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4bNp-0000oH-1m; Thu, 10 Sep 2026 05:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x4bNn-0000o7-On
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 05:47:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x4bNV-0002HE-QR
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 05:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789033648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zww92fCfMJm1fTuOl2wfKGN6o1ZFW0rWYMPvlUQmrCw=;
 b=aVi+mLLfRPXK3tfdY01WEU4AluuWo3rb6Q1s1vqiAOLsWZ5/i3aYdyQxmxMvd651gOQ6r3
 A7K1iStsCdQg45u1sTDjxaLrSxvy6FihRa96K4UOV1awuriaH+tfrj1P0GeschKHAOerqG
 U/hwIoZ6iAf2iRRjMTPQdOwDVSlo0nc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-loqJz82yN523j3ltupry9g-1; Thu, 10 Sep 2026 05:47:22 -0400
X-MC-Unique: loqJz82yN523j3ltupry9g-1
X-Mimecast-MFC-AGG-ID: loqJz82yN523j3ltupry9g_1789033641
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49d0ae342b9so36502815e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 02:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789033641; x=1789638441; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zww92fCfMJm1fTuOl2wfKGN6o1ZFW0rWYMPvlUQmrCw=;
 b=Yddb2JNtweO0KAVILarYRR4LyuziqK38NavpsmPropP3cl3XTeJMNpUOg8fdnYL+gd
 pL9lh5sQTh8RG62McXdLCH3QCMNTYqYDqdjDkrH5PrIdUgHF8Pmv1RyJSSu+31MSdFlJ
 SUJr/uSlJ0vKuNL0ciugSEGQuohbQnazQ7jZtLvlaRi+rUyLR0a2aoNUs4quQo1ytN8Y
 JwXgu1gS2ud6yolgWiCFlwY4ktHvfe3zcBkG/RPkZEDDPNEtt9gEXEfeRlR5XyiBV3u7
 tZmE6qQBCtWzeJiimnGFByJTUfV/F3+ZtXFFGNlsojBF7wUApaE702Ha5GlzIRC9jaWZ
 JVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789033641; x=1789638441;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zww92fCfMJm1fTuOl2wfKGN6o1ZFW0rWYMPvlUQmrCw=;
 b=rhz1S1BbJ+P2iNppQtJaNZRJ/6sQ3rCkxkWPZT2YqUxTpSHLuE3RtPcnInCrXOidKX
 WeC4F0NE6vcc4QIZ5SIkaBVJg5yOoOJYq/5Deo9jUOKfjyJJCsFyRL4DO7qCwvWU81ww
 SU2NhTs2Yc3yrditBBxpG1fanBRHlZ5hWQ1wBYzQULTcvSycebIY9FUFMV20vmP4OG0/
 XyLbZ62X5uacBq7d100o3f7wohb/QDiy2dZ5tQgGMJJpIV97837vCSoJxqRKIdVBqIzy
 /6B/F4lBCN/sfRdu8ceanFj5PEIzC8/6sJyIXbip3+7lLLCh3Nuo2OSCiO3Lj0ZpwTTW
 4yrA==
X-Gm-Message-State: AFuF++k08AHo8tWGUjTF5JLrJs6J7IQzBuEZRYhBzSOsTckdf9bh2Q3P
 fAHVC3CptmXWl5SSUxRRcH2yFOkgaZP5vngpHdKb8F+6TFkvTl0xsQHauwCQMG2LaPROqSAOCxK
 ZOOvDc4WUf6xoruKLcBekeIvdAheh9A7+c+7MefTedP7idnz1lu51lRAn
X-Gm-Gg: AYBFou3cZ3b82f5oHUIzb+2SSuhLcmvTEdzd8eh4Wpwv5Eb7afXl5wF9R8m7g7LwT38
 iWjoakxv52W11cFjoi9yzS3WbdRTyh4QNdn/CQjhFtF/0JXxT9m+Qd+nQVlfM5V077cH6JHscAE
 sUhA3XA52Xs/MWvtU0nrN1dT6DpZEmZhTANZv6qreKuDCReUNEeIKVRTB0YvJAvHf/dTkysBGHU
 xdtmVgHaeHN7yxO80quqfhj3mbV7hFKMg9hsajoWIoqt47R3JpyNLpXpDLQBlztukVDfRyxw6eH
 +WpDYHByfdaXUzpNC5O61twdVspEMvCdnqeMkuZ2akNPLK4EKEXcgxagZvkO8GNaKFGN9nVqwUt
 kKmvfL5urx7RmF5DkKeKf69mnHzt+tSHIAlviB9hbChDNxQ==
X-Received: by 2002:a05:600c:1f91:b0:49d:e0c:e560 with SMTP id
 5b1f17b1804b1-49d0e0ce65emr246123045e9.4.1789033641332; 
 Thu, 10 Sep 2026 02:47:21 -0700 (PDT)
X-Received: by 2002:a05:600c:1f91:b0:49d:e0c:e560 with SMTP id
 5b1f17b1804b1-49d0e0ce65emr246122325e9.4.1789033640692; 
 Thu, 10 Sep 2026 02:47:20 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26bdbb02sm55005455e9.3.2026.09.10.02.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 02:47:20 -0700 (PDT)
Date: Thu, 10 Sep 2026 11:47:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH v3 2/2] igvm: honor byte_offset when writing memory map,
 MADT and device tree
Message-ID: <aqJ617wlQByzCRcI@sgarzare-redhat>
References: <20260907-fix_offset-v3-0-bcffcefc0985@redhat.com>
 <20260907-fix_offset-v3-2-bcffcefc0985@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260907-fix_offset-v3-2-bcffcefc0985@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 07, 2026 at 04:58:56PM +0200, Luigi Leonardi wrote:
>qigvm_directive_memory_map(), qigvm_directive_madt() and
>qigvm_directive_device_tree() all wrote their data unconditionally at
>the start of the parameter area's buffer, ignoring param->byte_offset
>from the IGVM_VHS_PARAMETER header. This is harmless when a
>directive's offset happens to be 0, but breaks for IGVM files that pack
>multiple parameters into a single shared parameter area at different
>offsets: a later directive would overwrite the data written by an earlier
>one at the start of the buffer, corrupting it.
>
>Switch these handlers to qigvm_get_param_data(), introduced in
>the previous patch, and use the offset-adjusted data pointer it
>returns and the remaining size it sets instead of writing at
>param_entry->data and sizing checks against param_entry->size
>directly. This both honors byte_offset and validates it against the
>parameter area size before it is used.
>
>Fixes: c1d466d267 ("backends/igvm: Add IGVM loader and configuration")

IIUC this one should be also in the first patch, right?

That said, since that commit introduced qigvm_directive_memory_map() 
should we move changes to it in the first patch of this series?

Or just squash everything in a single patch.

>Fixes: dea1f68a5c ("igvm: Fill MADT IGVM parameter field on x86_64")
>Fixes: 1c4bd8f13c ("igvm: add device tree parameter support")
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> backends/igvm.c    | 26 ++++++++++++++------------
> target/i386/igvm.c | 13 +++++++------
> 2 files changed, 21 insertions(+), 18 deletions(-)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index a8340d7d55..b3ff6cba4a 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -638,7 +638,8 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
>     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>     int (*get_mem_map_entry)(int index, ConfidentialGuestMemoryMapEntry *entry,
>                              Error **errp) = NULL;
>-    QIgvmParameterData *param_entry;
>+    uint8_t *param_data;
>+    uint32_t param_size;
>     int max_entry_count;
>     int entry = 0;
>     IGVM_VHS_MEMORY_MAP_ENTRY *mm_entry;
>@@ -659,14 +660,14 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
>     }
>
>     /* Find the parameter area that should hold the memory map */
>-    param_entry = qigvm_find_param_entry(ctx,
>-                                         param->parameter_area_index, errp);
>-    if (param_entry == NULL) {
>+    param_data = qigvm_get_param_data(ctx, param->parameter_area_index,
>+                                       param, &param_size, errp);

Ditto, why not assigning it to mm_entry ?

The rest LGTM.

Thanks,
Stefano

>+    if (!param_data) {
>         return -1;
>     }
>
>-    max_entry_count = param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
>-    mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
>+    max_entry_count = param_size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
>+    mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_data;
>
>     retval = get_mem_map_entry(entry, &cgmm_entry, errp);
>     while (retval == 0) {
>@@ -862,12 +863,13 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
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
>+    param_data = qigvm_get_param_data(ctx, param->parameter_area_index,
>+                                       param, &param_size, errp);
>+    if (!param_data) {
>         return -1;
>     }
>
>@@ -885,14 +887,14 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
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
>diff --git a/target/i386/igvm.c b/target/i386/igvm.c
>index ad9bf87761..6ae662b033 100644
>--- a/target/i386/igvm.c
>+++ b/target/i386/igvm.c
>@@ -187,20 +187,21 @@ void qigvm_x86_bsp_reset(CPUX86State *env)
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
>+    param_data = qigvm_get_param_data(ctx, param->parameter_area_index,
>+                                       param, &param_size, errp);
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
>-- 
>2.55.0
>



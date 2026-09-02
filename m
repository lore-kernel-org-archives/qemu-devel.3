Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758E3C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1mNv-0005qV-5e; Wed, 02 Sep 2026 10:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x1mNu-0005qH-05
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:56:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x1mNs-0003fj-B9
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788360974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CeXwpn2RI/bJQ9iPJIAMhqXHcy6YSV0bg6Cwzerp270=;
 b=IzF60wxcScjFA6o5P2HBN0nHIAWgRg8H1J/ZVtY199dCv6HzT6pPoN5GO/AbjOqQEmlIaT
 mYjUUpTYGjfL/matRA0I1KAgMo2rblOjeiLvmNI+NJGK5HlNQ/a+wQiPvG+PWJb1pd+pop
 6rMHm5fItH0Z/YQOCYBnuwnciFCiyTw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-wLinoBXgMgmeIjLM07jh0w-1; Wed, 02 Sep 2026 10:56:13 -0400
X-MC-Unique: wLinoBXgMgmeIjLM07jh0w-1
X-Mimecast-MFC-AGG-ID: wLinoBXgMgmeIjLM07jh0w_1788360972
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49a1b4ea633so12667285e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 07:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788360972; x=1788965772; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CeXwpn2RI/bJQ9iPJIAMhqXHcy6YSV0bg6Cwzerp270=;
 b=f55QiK5EtG2wJ8ojMWhE6lOcHjxPkbUJ7Dq2z/zKtlRgQKZsYlgLc++8JMULyexojK
 D7H9L4cOvJ6Abht61kXmvEAGQErGxKcmfNlAixIlj90yFj1j9MQiT7WPx12hGWL0wMZH
 7efSvxnibT1rhbyIlBfHzCzVOTDAyFIc0jEWpQMzoOQHCSybyUYkFX2hb2UOaSyxsJNs
 e0QxoIJXb8vt000EHRL94hVu2T8nsxkC2G1t6wlde5ksq+9wc+hcZOzBbbvGhnm3Pnes
 uJU8xyThzzospDJlh0bOCYjb26HLHEOVpteelNYmYn+Z2qMUtUyZ+TtYqvwPAKbFtdLI
 dReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788360972; x=1788965772;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CeXwpn2RI/bJQ9iPJIAMhqXHcy6YSV0bg6Cwzerp270=;
 b=nSdjfxzeXrjP5PfjU41WnT30ywd/PX6kOMIjcnBhuHaKs8HU47i2iRspvvNU9cDa2P
 gQqeX5xvsnZ5w6V7VzscauoLs6PAqOw6qTaZXqXG6HZLLXvJsSOZdtqxjZ3l+nZP7Oft
 POq/DM7tBHnvb4Swa7N0+Mfp+IhPqsJmXwrUHpIxtYJlTcx2eKG1ugyCov/2+zd2q+KB
 YJcArML+UfWJpr1qZ4NwDtKvP0TtFMylbsDtXbRJc1X7iSzkVsx9vkh1J9LbOWjEXJcs
 kSgoReyHEXtLhEiUHffu2ikEXYjn1gSHuMpAK3x/JbAm6finPczgm2Tw8EwT1JSgXAjT
 phuA==
X-Gm-Message-State: AFuF++l4e93gUEQADpiGW4G4KgCzfuM9Xaukvl1UlH/DLrKtJGgF2Dro
 kM9pZ90O/PVTSzJS/vhQ4bhgcGQnL46Ivv07c5x0M1IP1IP4u07/npY//c3G8d6S61iAcxqM5jj
 xL88eSstkhiQmYYY3EMilW0ZuElMHYKt5ugT+gKuebSADYjpfB9tecwJx
X-Gm-Gg: AR+sD13EMmmnp/D+dcK3XdNoubLpZfq6I5cjykSrMpDlNo6QqzuP4jXOuMMbTcOmoMo
 BFKivXW8/mtB/iftLBDFdOwOgP/2QAOKBu6y89+8pDbIzaC65YwT+n7FIdEayBOK2SnulzX027p
 EYEd0CHwCRwrMLT2a0cU4L//Nf3zF1+gNBtV315DEdSnpUH2S49s3/mlysNRp+M4I1kCMLtwnGI
 7icv0Tyn6m+5U+t95TDkIafa4jkuvb29cMlEvbsNvisxN7I4AIokzD7w5yf9OaIT6CvjBiEWF9h
 4LpSnNUThdYFHG4q+uI24t6oO7AsVmAOf4CVUkcUPaXl7pe3+JwV2FRjz73xERtxSoZBS+inzbC
 LVQttIGdqIUitcapv1Ast1E7xBBRKVSxZ4TpUbImYzVjFUQ==
X-Received: by 2002:a05:600c:5306:b0:49c:c9ac:a4f3 with SMTP id
 5b1f17b1804b1-49ce5810b6amr113931045e9.1.1788360972172; 
 Wed, 02 Sep 2026 07:56:12 -0700 (PDT)
X-Received: by 2002:a05:600c:5306:b0:49c:c9ac:a4f3 with SMTP id
 5b1f17b1804b1-49ce5810b6amr113929765e9.1.1788360971553; 
 Wed, 02 Sep 2026 07:56:11 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-484492cf550sm6814839f8f.37.2026.09.02.07.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:56:10 -0700 (PDT)
Date: Wed, 2 Sep 2026 16:56:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH 2/2] igvm: validate byte_offset before using it in
 parameter directives
Message-ID: <apg2KbP4TdBZdtBj@sgarzare-redhat>
References: <20260902-fix_offset-v1-0-04b18f7595b2@redhat.com>
 <20260902-fix_offset-v1-2-04b18f7595b2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260902-fix_offset-v1-2-04b18f7595b2@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 02, 2026 at 04:21:59PM +0200, Luigi Leonardi wrote:
>None of the directive handlers that place data at a byte_offset within
>a parameter area validated that byte_offset actually falls within the
>parameter area's size. A malformed IGVM file with byte_offset > size would
>underflow the "size - byte_offset" computation used to determine
>remaining space, wrapping to a huge value and defeating the size
>check, then write out of bounds through param_entry->data +
>byte_offset.
>
>Add qigvm_param_offset_valid() to check byte_offset against the
>parameter area size, and call it from each handler before doing any
>arithmetic with byte_offset.
>
>When possible, add an explicit check that fixed-size write fits
>in the remaining space.
>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> backends/igvm.c                | 46 ++++++++++++++++++++++++++++++++++++++++++
> include/system/igvm-internal.h |  4 ++++
> target/i386/igvm.c             |  4 ++++
> 3 files changed, 54 insertions(+)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index a6e3a58022..5d2364bf70 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -101,6 +101,22 @@ qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
>     return NULL;
> }
>
>+/*
>+ * Check that byte_offset falls within the parameter area
>+ */
>+bool qigvm_param_offset_valid(const QIgvmParameterData *param_entry,
>+                              const IGVM_VHS_PARAMETER *param,
>+                              Error **errp)
>+{
>+    if (param->byte_offset > param_entry->size) {

Good, this is exaclt what I was suggesting in patch 1, but why 
introducing this check in a later commit? This will break bisectability 
IMO.

That said, I think we should move these checks in the helpers I 
suggested in patch 1, or maybe we should change qigvm_find_param_entry() 
or add wrapper around it to do everything (find, validate, return 
pointer/size).

Stefano

>+        error_setg(errp,
>+                   "IGVM: byte_offset 0x%x exceeds parameter area size 
>0x%x",
>+                   param->byte_offset, param_entry->size);
>+        return false;
>+    }
>+    return true;
>+}
>+
> static int qigvm_directive_page_data(QIgvm *ctx, const uint8_t *header_data,
>                                      Error **errp);
> static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
>@@ -632,6 +648,10 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
>         return -1;
>     }
>
>+    if (!qigvm_param_offset_valid(param_entry, param, errp)) {
>+        return -1;
>+    }
>+
>     max_entry_count = (param_entry->size - param->byte_offset) /
>                       sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
>     mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)(param_entry->data +
>@@ -694,6 +714,17 @@ static int qigvm_directive_vp_count(QIgvm *ctx, const uint8_t *header_data,
>         return -1;
>     }
>
>+    if (!qigvm_param_offset_valid(param_entry, param, errp)) {
>+        return -1;
>+    }
>+
>+    if (sizeof(*vp_count) > param_entry->size - param->byte_offset) {
>+        error_setg(errp,
>+                   "IGVM: vp-count parameter exceeds parameter area "
>+                   "defined in IGVM file");
>+        return -1;
>+    }
>+
>     vp_count = (uint32_t *)(param_entry->data + param->byte_offset);
>     *vp_count = 0;
>     CPU_FOREACH(cpu)
>@@ -718,6 +749,17 @@ static int qigvm_directive_environment_info(QIgvm *ctx,
>         return -1;
>     }
>
>+    if (!qigvm_param_offset_valid(param_entry, param, errp)) {
>+        return -1;
>+    }
>+
>+    if (sizeof(*environmental_state) > param_entry->size - param->byte_offset) {
>+        error_setg(errp,
>+                   "IGVM: environment-info parameter exceeds parameter area "
>+                   "defined in IGVM file");
>+        return -1;
>+    }
>+
>     environmental_state =
>         (IgvmEnvironmentInfo *)(param_entry->data + param->byte_offset);
>     environmental_state->memory_is_shared = 1;
>@@ -825,6 +867,10 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>         return -1;
>     }
>
>+    if (!qigvm_param_offset_valid(param_entry, param, errp)) {
>+        return -1;
>+    }
>+
>     if (ctx->machine_state->fdt == NULL) {
>         error_setg(errp, "IGVM: device tree not available");
>         return -1;
>diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
>index 9e9fa1d9af..7e0d1512ae 100644
>--- a/include/system/igvm-internal.h
>+++ b/include/system/igvm-internal.h
>@@ -81,4 +81,8 @@ QIgvmParameterData*
> qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
>                        Error **errp);
>
>+bool qigvm_param_offset_valid(const QIgvmParameterData *param_entry,
>+                              const IGVM_VHS_PARAMETER *param,
>+                              Error **errp);
>+
> #endif
>diff --git a/target/i386/igvm.c b/target/i386/igvm.c
>index 4d9d97385a..e758989d0d 100644
>--- a/target/i386/igvm.c
>+++ b/target/i386/igvm.c
>@@ -197,6 +197,10 @@ int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
>         return -1;
>     }
>
>+    if (!qigvm_param_offset_valid(param_entry, param, errp)) {
>+        return -1;
>+    }
>+
>     GArray *madt = acpi_build_madt_standalone(ctx->machine_state);
>
>     if (madt->len <= param_entry->size - param->byte_offset) {
>
>-- 
>2.55.0
>



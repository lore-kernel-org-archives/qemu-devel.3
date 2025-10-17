Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BAECCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 14:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kzE-0008Un-JA; Fri, 17 Oct 2025 09:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1v9kzB-0008TU-3m
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1v9kz4-0003mf-Di
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760709542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/bWlcLdAVfn7WncC50UFhet7A8RzOEi5GpGVfOcJZcs=;
 b=P5AXV1dAAMkqkLY/+MHDECaZkvvEv9bembv/LLc7+/PIrLMhnbPT94oO9fe0RmWml1UOm7
 st2aZjt0faRjPFesQB5aVcxpY3Sx+QmUu3VcaoykM3aWJfwMbSzlOoAThaUtr3iYrkC23J
 daCCSmUfxeWvM6zVF3D4nDCS70nxuxM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-cHpN2VcGO9yMG46TJPXfYg-1; Fri, 17 Oct 2025 09:59:00 -0400
X-MC-Unique: cHpN2VcGO9yMG46TJPXfYg-1
X-Mimecast-MFC-AGG-ID: cHpN2VcGO9yMG46TJPXfYg_1760709540
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-88ef355f7a3so737951285a.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760709540; x=1761314340;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/bWlcLdAVfn7WncC50UFhet7A8RzOEi5GpGVfOcJZcs=;
 b=LPTLWrxBUCpAQ8SQH9vvw1uXDwadS5mTVFi3VaHNeQN8wq5c/uggBMBkDEBoUvRvcB
 b9T119HdomKQxUEBMIRY3v0m0F6RciHpJVQTFgORs4kjwYkYZK0ZjL580Vq1DZaVRlHV
 0z3b8FnSuEaqq68YIt0ubdQaWqmtoeaXvUrAXq5UfUHvwV2zCxF2PYmPZtF5nAQcNs8w
 O4/YjQ4biDaQP1PqSsX7pwgp5QrYFXiG59mEzlxS1ksPdiZB+e+LSbB8KruAhXcwfd73
 HD6DeD50MATDz3PzgwtM5kHYTVRlx3v8JHssgykWpkNrBVtg1Lidbtcmc+MlMT3mmm7r
 8XjQ==
X-Gm-Message-State: AOJu0Yw3FOyRG7VwSmoBqJhtGDsY8RSHgjv7UMsOilZeyiC2W2UwE6g3
 Ka7cXdmji+t3Fvrf6QEb2zxuHKDaUt01IlQFNJ6QBVDRcXAO3L4cH6ox+SsYiqjJuMZ3MeiKM9U
 mpXWXatdX0wxzuLbX8nN8O4XK8jlIyBgC2L0kIh6itFRC7BjXQTvQd0Cj
X-Gm-Gg: ASbGncveBRJ8VCNYHvQka2mZqNkRURMxs9WbNhmRuld4hykCUPxHaeLHw3kE81W+u6J
 rwrdW6fw5le0Es1es7bUIieAXhp4tUwFk6RDmeGXkpHTSTAYphJqDWdSRHVHa42KLwewbwrfM0A
 pv5CDqqLCNZW2QPqzxUj7td2xwW02MGHRd+quqWgDO4s7qvtxaSTIR+7VxOpGBtMpGqStCCji90
 2VesFJ8let/JbgtVk1i7Gu3ZQQe06JOT2KDb6Ff/jgVGVuNfVo8eaCnKcejDTRYwnVQi+yaZtmo
 f1C6ki+FLz531RZrfY5QmTxDSxEHtmnntGy0ERas45oiBu5lrc7cRrlhSXAC0KLJZr2sGjSOlk8
 1I5akqfjsKMOyLCaGI6EBJg7tG6saE46op9kH4vSoO4amgA4QTHQ=
X-Received: by 2002:a05:620a:aa10:b0:890:87b5:453c with SMTP id
 af79cd13be357-89087b547a8mr425748185a.28.1760709540066; 
 Fri, 17 Oct 2025 06:59:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp14w4vFKEj8dG0HsmJcUwo8uZn+mPoKsduyONbmlPSj8yzDPF693TxHBmabhO8rzzRAbZVQ==
X-Received: by 2002:a05:620a:aa10:b0:890:87b5:453c with SMTP id
 af79cd13be357-89087b547a8mr425745585a.28.1760709539532; 
 Fri, 17 Oct 2025 06:58:59 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it.
 [79.46.200.153]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-88f3596896dsm428282785a.10.2025.10.17.06.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 06:58:59 -0700 (PDT)
Date: Fri, 17 Oct 2025 15:58:53 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Roy Hopkins <roy.hopkins@randomman.co.uk>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 4/5] igvm: track memory regions created
Message-ID: <jef63vhoedtg6l6l2luiyo7wpfdolewdpuzhfmxc6p2ek7u4w2@vbrhzyw67rg5>
References: <20251015112342.1672955-1-kraxel@redhat.com>
 <20251015112342.1672955-5-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251015112342.1672955-5-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Oct 15, 2025 at 01:23:41PM +0200, Gerd Hoffmann wrote:
>Keep a linked list of the memory regions created by igvm.

Sorry, my knowledge of MemoryRegions is limited, but why do we need to 
do this if we never access the list?
To keep references to regions?

Thanks,
Stefano

>
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> backends/igvm.c | 20 ++++++++++++++------
> 1 file changed, 14 insertions(+), 6 deletions(-)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index ee5ee74c7a66..1690fb334bf5 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -28,6 +28,11 @@ typedef struct QIgvmParameterData {
>     uint32_t index;
> } QIgvmParameterData;
>
>+typedef struct QIgvmMemoryRegion {
>+    QTAILQ_ENTRY(QIgvmMemoryRegion) next;
>+    MemoryRegion mr;
>+} QIgvmMemoryRegion;
>+
> /*
>  * Some directives are specific to particular confidential computing platforms.
>  * Define required types for each of those platforms here.
>@@ -73,6 +78,7 @@ typedef struct QIgvm {
>     uint32_t compatibility_mask;
>     unsigned current_header_index;
>     QTAILQ_HEAD(, QIgvmParameterData) parameter_data;
>+    QTAILQ_HEAD(, QIgvmMemoryRegion) memory_regions;
>     IgvmPlatformType platform_type;
>
>     /*
>@@ -185,7 +191,7 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
>                                   int region_identifier, Error **errp)
> {
>     ERRP_GUARD();
>-    MemoryRegion *igvm_pages = NULL;
>+    QIgvmMemoryRegion *pages = NULL;
>     Int128 gpa_region_size;
>     MemoryRegionSection mrs =
>         memory_region_find(get_system_memory(), addr, size);
>@@ -219,20 +225,21 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
>          */
>         g_autofree char *region_name =
>             g_strdup_printf("igvm.%X", region_identifier);
>-        igvm_pages = g_new0(MemoryRegion, 1);
>+        pages = g_new0(QIgvmMemoryRegion, 1);
>         if (ctx->cgs && ctx->cgs->require_guest_memfd) {
>-            if (!memory_region_init_ram_guest_memfd(igvm_pages, NULL,
>+            if (!memory_region_init_ram_guest_memfd(&pages->mr, NULL,
>                                                     region_name, size, errp)) {
>                 return NULL;
>             }
>         } else {
>-            if (!memory_region_init_ram(igvm_pages, NULL, region_name, size,
>+            if (!memory_region_init_ram(&pages->mr, NULL, region_name, size,
>                                         errp)) {
>                 return NULL;
>             }
>         }
>-        memory_region_add_subregion(get_system_memory(), addr, igvm_pages);
>-        return memory_region_get_ram_ptr(igvm_pages);
>+        memory_region_add_subregion(get_system_memory(), addr, &pages->mr);
>+        QTAILQ_INSERT_TAIL(&ctx->memory_regions, pages, next);
>+        return memory_region_get_ram_ptr(&pages->mr);
>     }
> }
>
>@@ -928,6 +935,7 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
>     }
>
>     QTAILQ_INIT(&ctx.parameter_data);
>+    QTAILQ_INIT(&ctx.memory_regions);
>
>     for (ctx.current_header_index = 0;
>          ctx.current_header_index < (unsigned)header_count;
>-- 
>2.51.0
>



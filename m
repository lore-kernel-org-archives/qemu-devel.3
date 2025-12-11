Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1BFD41C05
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 08:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTcJi-000147-5G; Thu, 11 Dec 2025 03:46:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vTcJd-00013m-Li
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 03:46:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vTcJa-0007Nu-Mg
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 03:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765442780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TPUMXRO/jw+TRLjOlgLwUQu+W4zj0DlSLRqa6k2iv2I=;
 b=EtI0g9a0wHW1WuQinutFkKbCAOGiOqkJ5ILYlt6JTYm1FZk3XQfPfMjWdpMVIMBtRyi7+i
 rnOXVoLKovJBSQM0xF5X8v+1ftQxkJzpGcgiFccu1++nq3pb11HVK/lfk5tbvWXMpNMr6u
 wFbIJlwjlC8q3quFpbcmztMSWWJFYQ8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-2nA20NPLNiWDOePR8FNQAw-1; Thu, 11 Dec 2025 03:46:19 -0500
X-MC-Unique: 2nA20NPLNiWDOePR8FNQAw-1
X-Mimecast-MFC-AGG-ID: 2nA20NPLNiWDOePR8FNQAw_1765442778
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b7a29e6f9a0so78287966b.1
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 00:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765442778; x=1766047578; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TPUMXRO/jw+TRLjOlgLwUQu+W4zj0DlSLRqa6k2iv2I=;
 b=EiYpymAWY5b5CRxRz3N9DMV4dW8PrA7lrtzbgMORZNvtwsTR0vtDVHalVJF7ugYFnE
 4VvBmDZ/8mH44Z+lq999p/2N/M191vVfHbzvg1KUU0EgL15ipPZpG2EGVbXpCi4T6ASL
 QFtsclWpwRMsEHNfUmwSy9g/2c/eu3RDyYXNJNhezmPpeFjlORSUaRUu0gQbyISohqsP
 nF6LdOOgdHzd+Bw3FOAtbq12fh1Xfn5Y+6w7geyDticDvKsqr6z+J15T6cOTUS3XB6uT
 KohUo5R1H427nD/LufgWs6SHEAOdModylEAM9W6Fa/y0Xm/RCW5O0OfOCYJswhU0YNoc
 rR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765442778; x=1766047578;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TPUMXRO/jw+TRLjOlgLwUQu+W4zj0DlSLRqa6k2iv2I=;
 b=IQ8hMRcO9nUUdSrqhPZC+TwBrWbJjvDEz2M/EdHUCc3CTio+w/7qbxDN/Lr7T0Kwge
 rjF7uzev8i8WwqAHd6DDjAc8gCZ6Nbtr5f/gJV8uf/0ec9QOg3wowQFru4h16y8p62tG
 KsrV9cCGFELI8jM28SQukZlYNGbT+W4yrYEFEFHH5FNURODNk93RfzDGujp6ILVS0bMM
 1OiWdOOaw9R8z/B7hwdf3y0kUoNlk3Ol6Pouit/D7aHeCC6CKz7a8Yf/n6CvxTM6bIVg
 UT9ULw2iZIYG6L2LQVWoi4yoSxb/XU+g1wlTDViUKi5CxlJ198B8y3B9dVqxMbqBXKgc
 EZmQ==
X-Gm-Message-State: AOJu0YzQhSTRLg5jbQLHtU1G3fHAhNnLpQGS7SudBe+wUQF/Caj7mInh
 9uQFFarBw3sn9mzi3XovhfWFQXpCbebRBMpROE3S5DpTPs+kL5W7E+hM+h8hemlcCNzKpdiYiQL
 SRLTstoOSSD5OY6JcE4Og0ggrn56qEDsGGsxnAnhIGg8Nxu/d9dSbxfB/
X-Gm-Gg: AY/fxX7AM2VwpKLz6YpV2XopfkrdJIj8r6EWkmI4jxFIi/5VmmxhGkNlV/MdPSxyETY
 INer+Ny1MsSMDjGSjUrZlt1rmIhQGwJrP9dY42gJSypxC9KJPl686UJGoRbjO9Et8z24f6CT2eK
 JOMmBEgvAIXFqd/PZMH7YElexeu7NJp4sHjLVz64Wspe1BJUAqXrnNrP1swxIEoKxhOzFGknjDL
 9w2UAS0Q/GUJY9dHJZQJnbtsjKL5Rs9QafNM9vGT4Ju0ueWU0tGzE0Wa7nO+vRBRIq5f5bjldl+
 O8nlhJZcdDkKQgRk3CkUH51hxDzzUcZNgMGc6d5dik7hVWQXRPjnGqmy7TDnLf0xHXpcf+30sXQ
 4DVfNFUu9IuIZV661Bpsk9mQU2p+2F1vwPYawmwhOcscBFbp6RN3z9lOpPRriVg==
X-Received: by 2002:a17:906:c148:b0:b6d:573d:bbc5 with SMTP id
 a640c23a62f3a-b7ce83c410cmr560153966b.37.1765442778007; 
 Thu, 11 Dec 2025 00:46:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqgLL+tnOEFfhd7vsF3bDWS7giZs3MPN6uzgFnyKJZQJYkZQCQwhm1877AgMDHElkxPd0I7w==
X-Received: by 2002:a17:906:c148:b0:b6d:573d:bbc5 with SMTP id
 a640c23a62f3a-b7ce83c410cmr560149666b.37.1765442777364; 
 Thu, 11 Dec 2025 00:46:17 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it.
 [87.12.139.91]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7cfa5c9d22sm206613966b.61.2025.12.11.00.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 00:46:16 -0800 (PST)
Date: Thu, 11 Dec 2025 09:46:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, Joerg Roedel <joerg.roedel@amd.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Leonardi <leonardi@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 3/3] igvm: Fill MADT IGVM parameter field
Message-ID: <26ptyaovy6mlbvuzri4v2ea3xhyvdc5elqsau34upvswarrbop@bhtzvxpb5aad>
References: <20251211081517.1546957-1-osteffen@redhat.com>
 <20251211081517.1546957-4-osteffen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251211081517.1546957-4-osteffen@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Dec 11, 2025 at 09:15:17AM +0100, Oliver Steffen wrote:
>Use the new acpi_build_madt_standalone() function to fill the MADT
>parameter field.

The cover letter will not usually be part of the git history, so IMO it 
is better to include also here the information that you have rightly 
written there, explaining why we are adding this change.

>
>Signed-off-by: Oliver Steffen <osteffen@redhat.com>
>---
> backends/igvm-cfg.c       |  8 +++++++-
> backends/igvm.c           | 37 ++++++++++++++++++++++++++++++++++++-
> include/system/igvm-cfg.h |  4 ++--
> include/system/igvm.h     |  2 +-
> target/i386/sev.c         |  2 +-
> 5 files changed, 47 insertions(+), 6 deletions(-)
>
>diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
>index c1b45401f4..0a77f7b7a1 100644
>--- a/backends/igvm-cfg.c
>+++ b/backends/igvm-cfg.c
>@@ -17,6 +17,7 @@
> #include "qom/object_interfaces.h"
> #include "hw/qdev-core.h"
> #include "hw/boards.h"
>+#include "hw/i386/acpi-build.h"
>
> #include "trace.h"
>
>@@ -48,10 +49,15 @@ static void igvm_reset_hold(Object *obj, ResetType type)
> {
>     MachineState *ms = MACHINE(qdev_get_machine());
>     IgvmCfg *igvm = IGVM_CFG(obj);
>+    GArray *madt = NULL;
>
>     trace_igvm_reset_hold(type);
>
>-    qigvm_process_file(igvm, ms->cgs, false, &error_fatal);
>+    madt = acpi_build_madt_standalone(ms);
>+
>+    qigvm_process_file(igvm, ms->cgs, false, madt, &error_fatal);
>+
>+    g_array_free(madt, true);
> }
>
> static void igvm_reset_exit(Object *obj, ResetType type)
>diff --git a/backends/igvm.c b/backends/igvm.c
>index a350c890cc..7e56b19b0a 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -93,6 +93,7 @@ typedef struct QIgvm {
>     unsigned region_start_index;
>     unsigned region_last_index;
>     unsigned region_page_count;
>+    GArray *madt;
> } QIgvm;
>
> static int qigvm_directive_page_data(QIgvm *ctx, const uint8_t *header_data,
>@@ -120,6 +121,8 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
> static int qigvm_initialization_guest_policy(QIgvm *ctx,
>                                        const uint8_t *header_data,
>                                        Error **errp);
>+static int qigvm_initialization_madt(QIgvm *ctx,
>+                                     const uint8_t *header_data, Error **errp);
>
> struct QIGVMHandler {
>     uint32_t type;
>@@ -148,6 +151,8 @@ static struct QIGVMHandler handlers[] = {
>       qigvm_directive_snp_id_block },
>     { IGVM_VHT_GUEST_POLICY, IGVM_HEADER_SECTION_INITIALIZATION,
>       qigvm_initialization_guest_policy },
>+    { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
>+      qigvm_initialization_madt },
> };
>
> static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
>@@ -764,6 +769,34 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
>     return 0;
> }
>
>+static int qigvm_initialization_madt(QIgvm *ctx,
>+                                     const uint8_t *header_data, Error **errp)
>+{
>+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>+    QIgvmParameterData *param_entry;
>+
>+    if (ctx->madt == NULL) {
>+        return 0;
>+    }
>+
>+    /* Find the parameter area that should hold the device tree */
>+    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
>+    {
>+        if (param_entry->index == param->parameter_area_index) {
>+
>+            if (ctx->madt->len > param_entry->size) {
>+                error_setg(
>+                    errp,
>+                    "IGVM: MADT size exceeds parameter area defined in IGVM file");
>+                return -1;
>+            }
>+            memcpy(param_entry->data, ctx->madt->data, ctx->madt->len);
>+            break;
>+        }
>+    }
>+    return 0;
>+}
>+
> static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
> {
>     int32_t header_count;
>@@ -892,7 +925,7 @@ IgvmHandle qigvm_file_init(char *filename, Error **errp)
> }
>
> int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
>-                       bool onlyVpContext, Error **errp)
>+                       bool onlyVpContext, GArray *madt, Error **errp)
> {
>     int32_t header_count;
>     QIgvmParameterData *parameter;
>@@ -915,6 +948,8 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
>     ctx.cgs = cgs;
>     ctx.cgsc = cgs ? CONFIDENTIAL_GUEST_SUPPORT_GET_CLASS(cgs) : NULL;
>
>+    ctx.madt = madt;
>+
>     /*
>      * Check that the IGVM file provides configuration for the current
>      * platform
>diff --git a/include/system/igvm-cfg.h b/include/system/igvm-cfg.h
>index 7dc48677fd..1a04302beb 100644
>--- a/include/system/igvm-cfg.h
>+++ b/include/system/igvm-cfg.h
>@@ -42,8 +42,8 @@ typedef struct IgvmCfgClass {
>      *
>      * Returns 0 for ok and -1 on error.
>      */

Should we update the documentation of this function now that we have a 
new parameter, also explaining that it's optional.

>-    int (*process)(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
>-                   bool onlyVpContext, Error **errp);
>+    int (*process)(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
>+                   bool onlyVpContext, GArray *madt, Error **errp);
>
> } IgvmCfgClass;
>
>diff --git a/include/system/igvm.h b/include/system/igvm.h
>index ec2538daa0..f2e580e4ee 100644
>--- a/include/system/igvm.h
>+++ b/include/system/igvm.h
>@@ -18,7 +18,7 @@
>
> IgvmHandle qigvm_file_init(char *filename, Error **errp);
> int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
>-                      bool onlyVpContext, Error **errp);
>+                      bool onlyVpContext, GArray *madt, Error **errp);
>
> /* x86 native */
> int qigvm_x86_get_mem_map_entry(int index,
>diff --git a/target/i386/sev.c b/target/i386/sev.c
>index fd2dada013..ffeb9f52a2 100644
>--- a/target/i386/sev.c
>+++ b/target/i386/sev.c
>@@ -1892,7 +1892,7 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>          */
>         if (x86machine->igvm) {
>             if (IGVM_CFG_GET_CLASS(x86machine->igvm)
>-                    ->process(x86machine->igvm, machine->cgs, true, errp) ==
>+                    ->process(x86machine->igvm, machine->cgs, true, NULL, errp) ==

Why here we don't need to pass it?

Thanks,
Stefano

>                 -1) {
>                 return -1;
>             }
>-- 
>2.52.0
>



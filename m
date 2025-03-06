Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19C0C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 13:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqAzP-0000vI-KZ; Thu, 06 Mar 2025 08:10:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tqAzM-0000sU-Dj
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 08:10:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tqAzK-0001tr-B8
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 08:10:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741266608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jrchpUaZXU1w5UNogp7/g8pYM+L+EWIl83Kl/TzPxq4=;
 b=KUFGGx0lWBAdVru4s+piPVRK/jCefG8/J/05d2Yxz61XTrVNwCvRuzbbgnTxYejsZId3gC
 ifQuMTLth9ZSR7NEGPwnDvSFh77/F8ojPEfvNUW0qgjznRyAMRQBjvmKmsDhr4s8ZWkgOE
 KUK59M+QIWuOk/j/CuU1qmZKMkWKL2s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-NJQm3piIO6Gf3QvahfBARw-1; Thu, 06 Mar 2025 08:09:51 -0500
X-MC-Unique: NJQm3piIO6Gf3QvahfBARw-1
X-Mimecast-MFC-AGG-ID: NJQm3piIO6Gf3QvahfBARw_1741266591
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43947979ce8so2680515e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 05:09:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741266590; x=1741871390;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jrchpUaZXU1w5UNogp7/g8pYM+L+EWIl83Kl/TzPxq4=;
 b=IADVcTLjqQnBHfQPLghq0mgsvzoM2nZSBj79ZzUuP+bveEKkRE3oC1usfVVAN1CgST
 e5DecBnFStdp9yC7LZ0i3BP5qS4EkIcBRIvMuv84l653bgjQrIjcMDSmzDHRe/ONe+XB
 +tyvMdDt6cjbNoPEtVkg0iSiAp94aCp2TiQmptd0Us0Oybgrg1MjlS+nlQJF+c1AI1L2
 QEYzIs4+dNaQPw26IYGbMiQprkcitZyNyveM8ua+bH210TiM6lN+1ubVBnVmHhxwGDHX
 udk69BzS9g0UZskmhgkr14RzurYXdqN2Vj7X2U75bklnMxLLEo/P2/jrRlP7n/u7xavl
 b9Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUINz4m33Pmbqs9TdwT8vAryOH1acLhbmOwEGj+Sivd8FMkNw5TXxDG4+Db1t0oxu1BjyqWCwx4sSr+@nongnu.org
X-Gm-Message-State: AOJu0Ywi1ozqf/fVP66IHJt+dcaKKwjN/5+52vT47b/hcUl5zpvHIp+z
 4xIPEU6Ld+yeh4Em2Wli3O+OuefrxvmthNsg423JDFotT3CTxqJpzOBmmlWiiT+h6p6d7jIZE2T
 FUuyOgwK2HqIzJ1I6jl5X9go/XuPDOU/FDg5EVEiiYbC2JdunYFz1
X-Gm-Gg: ASbGncvkvuKQTdhY2HkBZeVmYEk+nVe3/gBQBNp9ayiyv8MtvgYHEvxri8VI7jUW4iy
 XAiSPWpYTKsn25mL1sewQiRCcQiz34DcmiU7lAs8gIjARdLRIUit6ZV+qx2ZKOEk9gIEJf3xeHr
 GuC4LgDnJGlph2k9IXNwKKQb7MvfiYaEhrSZ8f8sDNc2iWndIeNwpy0b4X2qmGEqgtduxJ7RU88
 GWj1LRM4nD614/vGXEfzbuK66mszDg3CPOzJ3p8GYCHIRxB5BezrwAl91pIQ/W8Mv3gxP5D6DoD
 5+X38wY42pfMDquSIv+oD7wwklNIlqI5WLdloxRhI8zjy23DSo61pUt67/RtHA+g
X-Received: by 2002:a05:600c:3b82:b0:439:9a5b:87d4 with SMTP id
 5b1f17b1804b1-43bd296befcmr49585455e9.13.1741266590485; 
 Thu, 06 Mar 2025 05:09:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjlI7PEnXJF7oo6EDSGlJOpLi0vKwYRB+lTbrqDOnCLyDPhAYmOQhHvy6zL5qDBhJqG6tXlw==
X-Received: by 2002:a05:600c:3b82:b0:439:9a5b:87d4 with SMTP id
 5b1f17b1804b1-43bd296befcmr49585035e9.13.1741266589805; 
 Thu, 06 Mar 2025 05:09:49 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it.
 [79.46.200.29]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd93ca9fsm19266405e9.28.2025.03.06.05.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 05:09:48 -0800 (PST)
Date: Thu, 6 Mar 2025 14:09:44 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Roy Hopkins <roy.hopkins@randomman.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 "Daniel P . Berrange" <berrange@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 Joerg Roedel <jroedel@suse.com>
Subject: Re: [PATCH v7 00/16] Introduce support for IGVM files
Message-ID: <6egfshlf7x32gnz36xoi7if2mmjx6yaiuccv35byzuxlmfr3gy@7wu343fzyvr3>
References: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
 <CAGxU2F4pq3Y7QnQBCEPQ35kQ2hxrwU5nVA9FmR=J6id+EJXAtA@mail.gmail.com>
 <3bc8c923df287519b552a1b67c2f01b557adbf02.camel@randomman.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3bc8c923df287519b552a1b67c2f01b557adbf02.camel@randomman.co.uk>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Roy,

On Thu, Mar 06, 2025 at 11:48:29AM +0000, Roy Hopkins wrote:
>On Wed, 2025-03-05 at 16:47 +0100, Stefano Garzarella wrote:

[...]

>
>Thanks for testing this. The problem seems to be down to the fact that I
>had to introduce an initial parsing of the IGVM file during initialization
>to extract sev_features. I was parsing all directives in the file but it
>appears this has some unwanted side effects.
>
>Please could you try the patch below to see if it fixes the issue? If it
>does I'll incorporate it into the patch series and resubmit.

Great, it worked, so feel free to add:

Tested-by: Stefano Garzarella <sgarzare@redhat.com>

About the patch, I have some comments below:

>
>From 3590460ec3945b02a679ad79735681a642596d60 Mon Sep 17 00:00:00 2001
>From: Roy Hopkins <roy.hopkins@randomman.co.uk>
>Date: Thu, 6 Mar 2025 11:25:07 +0000
>Subject: [PATCH 1/1] backends/igvm: Add function to process only VP context
>
>When initializing kvm for SEV, the sev_features need to be
>passed to the initialization function. When using IGVM files,
>sev_features is provided in the VP context definintions in
>the file. Currently this is handled in sev.c by processing
>the entire file to extract the VP context, however this has
>unwanted side-effects. Therefore this commit adds a new
>function that allows only the VP context definitions to
>be parsed in the IGVM file.
>
>Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
>---
> backends/igvm-cfg.c       |  1 +
> backends/igvm.c           | 51 +++++++++++++++++++++++++++++++++++++++
> backends/igvm.h           |  3 +++
> include/system/igvm-cfg.h | 10 ++++++++
> target/i386/sev.c         | 10 ++++----
> 5 files changed, 70 insertions(+), 5 deletions(-)
>
>diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
>index 38f17dae44..25c4469768 100644
>--- a/backends/igvm-cfg.c
>+++ b/backends/igvm-cfg.c
>@@ -41,6 +41,7 @@ static void igvm_cfg_class_init(ObjectClass *oc, void *data)
>                                           "Set the IGVM filename to use");
>
>     igvmc->process = qigvm_process_file;
>+    igvmc->process_vp_context = qigvm_process_vp_context;
> }
>
> static void igvm_cfg_init(Object *obj)
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 7673e4a882..aae83f8a77 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -965,3 +965,54 @@ cleanup:
>
>     return retval;
> }
>+
>+int qigvm_process_vp_context(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
>+                             Error **errp)
>+{

This new function share a lot of code with qigvm_process_file(), can we 
avoid that? e.g. adding a parameter to the process callback, or just 
factoring out common code?

>+    int32_t header_count;
>+    int retval = -1;
>+    QIgvm ctx;
>+
>+    memset(&ctx, 0, sizeof(ctx));
>+    ctx.file = qigvm_file_init(cfg->filename, errp);
>+    if (ctx.file < 0) {
>+        return -1;
>+    }
>+
>+    ctx.cgs = cgs;
>+    ctx.cgsc = cgs ? CONFIDENTIAL_GUEST_SUPPORT_GET_CLASS(cgs) : NULL;
>+
>+    /*
>+     * Check that the IGVM file provides configuration for the current
>+     * platform
>+     */
>+    if (qigvm_supported_platform_compat_mask(&ctx, errp) < 0) {
>+        goto cleanup;
>+    }
>+
>+    header_count = igvm_header_count(ctx.file, IGVM_HEADER_SECTION_DIRECTIVE);
>+    if (header_count <= 0) {
>+        error_setg(
>+            errp, "Invalid directive header count in IGVM file. Error code: %X",
>+            header_count);
>+        goto cleanup;
>+    }
>+
>+    for (ctx.current_header_index = 0;
>+         ctx.current_header_index < (unsigned)header_count;
>+         ctx.current_header_index++) {
>+        IgvmVariableHeaderType type = igvm_get_header_type(
>+            ctx.file, IGVM_HEADER_SECTION_DIRECTIVE, ctx.current_header_index);
>+        if (type == IGVM_VHT_VP_CONTEXT) {
>+            if (qigvm_handler(&ctx, type, errp) < 0) {

Understanding the error I had was a bit tricky, since it didn't mention 
IGVM at all.

Can we add an error_prepend() here or ...

>+                goto cleanup;
>+            }
>+        }
>+    }
>+    retval = 0;
>+
>+cleanup:
>+    igvm_free(ctx.file);
>+
>+    return retval;
>+}
>diff --git a/backends/igvm.h b/backends/igvm.h
>index 269eb3a10e..a43b029d56 100644
>--- a/backends/igvm.h
>+++ b/backends/igvm.h
>@@ -20,4 +20,7 @@
> int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
>                       Error **errp);
>
>+int qigvm_process_vp_context(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
>+                             Error **errp);
>+
> #endif
>diff --git a/include/system/igvm-cfg.h b/include/system/igvm-cfg.h
>index 21fadfe5b7..0c1a7ef309 100644
>--- a/include/system/igvm-cfg.h
>+++ b/include/system/igvm-cfg.h
>@@ -38,6 +38,16 @@ typedef struct IgvmCfgClass {
>     int (*process)(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
>                    Error **errp);
>
>+    /*
>+     * If an IGVM filename has been specified then only process
>+     * the VMSA sections in the IGVM file.
>+     * Performs a no-op if no filename has been specified.
>+     *
>+     * Returns 0 for ok and -1 on error.
>+     */
>+    int (*process_vp_context)(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
>+        Error **errp);
>+
> } IgvmCfgClass;
>
> #define TYPE_IGVM_CFG "igvm-cfg"
>diff --git a/target/i386/sev.c b/target/i386/sev.c
>index ef25e64b14..d22e9870ea 100644
>--- a/target/i386/sev.c
>+++ b/target/i386/sev.c
>@@ -1893,14 +1893,14 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>          * each vcpu.
>          *
>          * The IGVM file is normally processed after initialization. Therefore
>-         * we need to pre-process it here to extract sev_features in order to
>-         * provide it to KVM_SEV_INIT2. Each cgs_* function that is called by
>-         * the IGVM processor detects this pre-process by observing the state
>-         * as SEV_STATE_UNINIT.
>+         * we need to pre-process it here, just looking for the vp_context to
>+         * extract sev_features in order to provide it to KVM_SEV_INIT2. Each
>+         * cgs_* function that is called by the IGVM processor detects this
>+         * pre-process by observing the state as SEV_STATE_UNINIT.
>          */
>         if (x86machine->igvm) {
>             if (IGVM_CFG_GET_CLASS(x86machine->igvm)
>-                    ->process(x86machine->igvm, machine->cgs, errp) == -1) {
>+                    ->process_vp_context(x86machine->igvm, machine->cgs, errp) == -1) {

... here?

BTW we can fix it later, but since you have to repost, I pointed it out.

Thanks,
Stefano

>                 return -1;
>             }
>             /*
>-- 
>2.43.0
>
>



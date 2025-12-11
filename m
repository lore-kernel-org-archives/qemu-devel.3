Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C142D41C12
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 09:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTcut-0001E3-BK; Thu, 11 Dec 2025 04:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vTcur-0001DQ-3d
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 04:24:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vTcuo-0000Sn-N1
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 04:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765445089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0snxFkyLEAfiYVoWaiM2k5L4Pd3JDbOzuok+0AcP2Oc=;
 b=aUfVXXKeHowps9+4WdcGQFC7cQPvD33usxcQDDs2JqDudSjwcY1CTdMFkyIBjfyP3fcI1R
 4Vc75M8r1BPHluQsgfgdPVn62EAsNBnC2t8Yk1O1/HPq47yinT93gJjqUI96KsPVQzBPFe
 zDWWUtdHl7oUHWjwYf94HhaqCkd1pXw=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-XGjz3Hk0MiCcB0UZI1fCkg-1; Thu, 11 Dec 2025 04:24:48 -0500
X-MC-Unique: XGjz3Hk0MiCcB0UZI1fCkg-1
X-Mimecast-MFC-AGG-ID: XGjz3Hk0MiCcB0UZI1fCkg_1765445087
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-78c2bce1258so11031867b3.1
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 01:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765445087; x=1766049887; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0snxFkyLEAfiYVoWaiM2k5L4Pd3JDbOzuok+0AcP2Oc=;
 b=aZIHIuR8/O9W2DDDLaFAG6X7mN1Vz6iw74xV2lQi31/3SEBk/tDJhzOeZJ4LFB7712
 u12KKVCwgd9laSRdqhMn1o74ibaMh8p4+pBBxB+Oba/oYoELwHZQXbSj83wUIYl0IteQ
 y+GDo4Ny5nlaaAv4skUil+XdvMMLjlmiaqKrVq2FI3RV6XAGJfboAu3sGFmzgCYw9DpF
 Kn9gfjLfPMUDgBSVO2N+Zbs78O4ZE2OyITtt3Fq0OPByqnSrotA0oGYlURf8u64bG3V0
 W9m/NbFFdVzBTZFdXzm1kO7SEveKYUUcubsa02D5jN35zyEdWN3E+aNRv1ntkje3YQEL
 dXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765445087; x=1766049887;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0snxFkyLEAfiYVoWaiM2k5L4Pd3JDbOzuok+0AcP2Oc=;
 b=KeiVTKCWDe7ChLWshCqbt53+Upnkp5uVm+jsDkwoyzImR6J0qBaTE+I5V2JvZiO+0f
 eZ0BlQsrgLtLtwZ3zYJFGlnmJx/sA0o9+k6yjR0uIyIMwkCVzZC6qOCqXEQhzAG7gfc7
 aTUBXhZU/wEBNeolW+t1WvWdt9dSY3CzYFMkclMC2kszXXapzbgIfcn5/vtXGM9L8nz6
 Sm2TH3ulvEH/egf6NC+quDoP/CsI0LShE+0gV+kgaH/njlEpmpn27PjiGe8www7L++ou
 QpFekWUy9Pkgzcy2sy1rLZjkaDWe/RSCWT+Aspp0yOeo/U2YXqsKMvQtQetavk3RcwMl
 P62Q==
X-Gm-Message-State: AOJu0YxmYSez7ah50YeDDs/Fwrbo8M236UU5UREIyq/soNtynsIhsnf3
 RuGh2ZTdtJbpzCWu0b5z6oBWYYeOL2FSFsiDLgGMxa9MzxvPMFsY40z+xlFnb1VW3Af742yig86
 pCT/0nLzc3OEtKyam925LIbGJzFJttkwH9Cm5tEu3ZEe3M+KcM07CJ9hEnYSZKJRH60P5+QwiFv
 nHWw5nYUhxSjgscaEklaSWmw/EP9uTXU0=
X-Gm-Gg: AY/fxX6nneZZK1Z5YvmntGmCQ7mwYLx9RbtkU7C+uSmI/xC2ilLcNjgl9zg8Kl3Zlia
 czinNLh6UOSF9i3ZDwYutO+lf/DqH9iEhKpQdVaqaH9cZqJEK59FHo1mxkJqFFJgocp90MU8MhX
 WO13KWZQBO9iysOIVMEuG4zAAE6n2RRA7gx4ms39RWaXXHtM9K6sWcGa6DOKBsim/7nmIOGuKAv
 YRtwpgnAJhQRHoEWqcmivi1zg==
X-Received: by 2002:a05:690e:169c:b0:644:4b86:e7d1 with SMTP id
 956f58d0204a3-6446e9112cdmr4390112d50.10.1765445087550; 
 Thu, 11 Dec 2025 01:24:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuU+tJU4RQI4z4yFpZ1UYeqalsybBdqY89RuI7I4f/urGG/hT/MLALuw19mg01Z/CyuoXg5Nl/u6DdbBEpUwM=
X-Received: by 2002:a05:690e:169c:b0:644:4b86:e7d1 with SMTP id
 956f58d0204a3-6446e9112cdmr4390087d50.10.1765445087159; Thu, 11 Dec 2025
 01:24:47 -0800 (PST)
MIME-Version: 1.0
References: <20251211081517.1546957-1-osteffen@redhat.com>
 <20251211081517.1546957-4-osteffen@redhat.com>
 <26ptyaovy6mlbvuzri4v2ea3xhyvdc5elqsau34upvswarrbop@bhtzvxpb5aad>
In-Reply-To: <26ptyaovy6mlbvuzri4v2ea3xhyvdc5elqsau34upvswarrbop@bhtzvxpb5aad>
From: Oliver Steffen <osteffen@redhat.com>
Date: Thu, 11 Dec 2025 10:24:35 +0100
X-Gm-Features: AQt7F2o4BrxakdvFlwlUEfCcnANEG9Lzb5oq3NPgqEav-Whxr7VdFlfL-f-2z9w
Message-ID: <CA+bRGFqnT=Es1GE6w4U2edaJXpDaSV1bhZ89vcaP5TDfFU8a+Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] igvm: Fill MADT IGVM parameter field
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Joerg Roedel <joerg.roedel@amd.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Leonardi <leonardi@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=osteffen@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Dec 11, 2025 at 9:46=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Thu, Dec 11, 2025 at 09:15:17AM +0100, Oliver Steffen wrote:
> >Use the new acpi_build_madt_standalone() function to fill the MADT
> >parameter field.
>
> The cover letter will not usually be part of the git history, so IMO it
> is better to include also here the information that you have rightly
> written there, explaining why we are adding this change.

Will do.

> >
> >Signed-off-by: Oliver Steffen <osteffen@redhat.com>
> >---
> > backends/igvm-cfg.c       |  8 +++++++-
> > backends/igvm.c           | 37 ++++++++++++++++++++++++++++++++++++-
> > include/system/igvm-cfg.h |  4 ++--
> > include/system/igvm.h     |  2 +-
> > target/i386/sev.c         |  2 +-
> > 5 files changed, 47 insertions(+), 6 deletions(-)
> >
> >diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
> >index c1b45401f4..0a77f7b7a1 100644
> >--- a/backends/igvm-cfg.c
> >+++ b/backends/igvm-cfg.c
> >@@ -17,6 +17,7 @@
> > #include "qom/object_interfaces.h"
> > #include "hw/qdev-core.h"
> > #include "hw/boards.h"
> >+#include "hw/i386/acpi-build.h"
> >
> > #include "trace.h"
> >
> >@@ -48,10 +49,15 @@ static void igvm_reset_hold(Object *obj, ResetType t=
ype)
> > {
> >     MachineState *ms =3D MACHINE(qdev_get_machine());
> >     IgvmCfg *igvm =3D IGVM_CFG(obj);
> >+    GArray *madt =3D NULL;
> >
> >     trace_igvm_reset_hold(type);
> >
> >-    qigvm_process_file(igvm, ms->cgs, false, &error_fatal);
> >+    madt =3D acpi_build_madt_standalone(ms);
> >+
> >+    qigvm_process_file(igvm, ms->cgs, false, madt, &error_fatal);
> >+
> >+    g_array_free(madt, true);
> > }
> >
> > static void igvm_reset_exit(Object *obj, ResetType type)
> >diff --git a/backends/igvm.c b/backends/igvm.c
> >index a350c890cc..7e56b19b0a 100644
> >--- a/backends/igvm.c
> >+++ b/backends/igvm.c
> >@@ -93,6 +93,7 @@ typedef struct QIgvm {
> >     unsigned region_start_index;
> >     unsigned region_last_index;
> >     unsigned region_page_count;
> >+    GArray *madt;
> > } QIgvm;
> >
> > static int qigvm_directive_page_data(QIgvm *ctx, const uint8_t *header_=
data,
> >@@ -120,6 +121,8 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, =
const uint8_t *header_data,
> > static int qigvm_initialization_guest_policy(QIgvm *ctx,
> >                                        const uint8_t *header_data,
> >                                        Error **errp);
> >+static int qigvm_initialization_madt(QIgvm *ctx,
> >+                                     const uint8_t *header_data, Error =
**errp);
> >
> > struct QIGVMHandler {
> >     uint32_t type;
> >@@ -148,6 +151,8 @@ static struct QIGVMHandler handlers[] =3D {
> >       qigvm_directive_snp_id_block },
> >     { IGVM_VHT_GUEST_POLICY, IGVM_HEADER_SECTION_INITIALIZATION,
> >       qigvm_initialization_guest_policy },
> >+    { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
> >+      qigvm_initialization_madt },
> > };
> >
> > static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
> >@@ -764,6 +769,34 @@ static int qigvm_initialization_guest_policy(QIgvm =
*ctx,
> >     return 0;
> > }
> >
> >+static int qigvm_initialization_madt(QIgvm *ctx,
> >+                                     const uint8_t *header_data, Error =
**errp)
> >+{
> >+    const IGVM_VHS_PARAMETER *param =3D (const IGVM_VHS_PARAMETER *)hea=
der_data;
> >+    QIgvmParameterData *param_entry;
> >+
> >+    if (ctx->madt =3D=3D NULL) {
> >+        return 0;
> >+    }
> >+
> >+    /* Find the parameter area that should hold the device tree */
> >+    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
> >+    {
> >+        if (param_entry->index =3D=3D param->parameter_area_index) {
> >+
> >+            if (ctx->madt->len > param_entry->size) {
> >+                error_setg(
> >+                    errp,
> >+                    "IGVM: MADT size exceeds parameter area defined in =
IGVM file");
> >+                return -1;
> >+            }
> >+            memcpy(param_entry->data, ctx->madt->data, ctx->madt->len);
> >+            break;
> >+        }
> >+    }
> >+    return 0;
> >+}
> >+
> > static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **err=
p)
> > {
> >     int32_t header_count;
> >@@ -892,7 +925,7 @@ IgvmHandle qigvm_file_init(char *filename, Error **e=
rrp)
> > }
> >
> > int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
> >-                       bool onlyVpContext, Error **errp)
> >+                       bool onlyVpContext, GArray *madt, Error **errp)
> > {
> >     int32_t header_count;
> >     QIgvmParameterData *parameter;
> >@@ -915,6 +948,8 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGue=
stSupport *cgs,
> >     ctx.cgs =3D cgs;
> >     ctx.cgsc =3D cgs ? CONFIDENTIAL_GUEST_SUPPORT_GET_CLASS(cgs) : NULL=
;
> >
> >+    ctx.madt =3D madt;
> >+
> >     /*
> >      * Check that the IGVM file provides configuration for the current
> >      * platform
> >diff --git a/include/system/igvm-cfg.h b/include/system/igvm-cfg.h
> >index 7dc48677fd..1a04302beb 100644
> >--- a/include/system/igvm-cfg.h
> >+++ b/include/system/igvm-cfg.h
> >@@ -42,8 +42,8 @@ typedef struct IgvmCfgClass {
> >      *
> >      * Returns 0 for ok and -1 on error.
> >      */
>
> Should we update the documentation of this function now that we have a
> new parameter, also explaining that it's optional.
>
Will do.

> >-    int (*process)(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
> >-                   bool onlyVpContext, Error **errp);
> >+    int (*process)(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
> >+                   bool onlyVpContext, GArray *madt, Error **errp);
> >
> > } IgvmCfgClass;
> >
> >diff --git a/include/system/igvm.h b/include/system/igvm.h
> >index ec2538daa0..f2e580e4ee 100644
> >--- a/include/system/igvm.h
> >+++ b/include/system/igvm.h
> >@@ -18,7 +18,7 @@
> >
> > IgvmHandle qigvm_file_init(char *filename, Error **errp);
> > int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
> >-                      bool onlyVpContext, Error **errp);
> >+                      bool onlyVpContext, GArray *madt, Error **errp);
> >
> > /* x86 native */
> > int qigvm_x86_get_mem_map_entry(int index,
> >diff --git a/target/i386/sev.c b/target/i386/sev.c
> >index fd2dada013..ffeb9f52a2 100644
> >--- a/target/i386/sev.c
> >+++ b/target/i386/sev.c
> >@@ -1892,7 +1892,7 @@ static int sev_common_kvm_init(ConfidentialGuestSu=
pport *cgs, Error **errp)
> >          */
> >         if (x86machine->igvm) {
> >             if (IGVM_CFG_GET_CLASS(x86machine->igvm)
> >-                    ->process(x86machine->igvm, machine->cgs, true, err=
p) =3D=3D
> >+                    ->process(x86machine->igvm, machine->cgs, true, NUL=
L, errp) =3D=3D
>
> Why here we don't need to pass it?

Here we only read the IGVM to figure out the initial vcpu configuration
(the `onlyVpContext` parameter is true) to initialize kvm,
The actual IGVM processing is done later.
Should I mention in the comment above why madt is NULL here ?

>
> Thanks,
> Stefano
>
> >                 -1) {
> >                 return -1;
> >             }
> >--
> >2.52.0
> >
>



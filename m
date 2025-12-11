Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A1AD41C26
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 11:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTf22-0003Rg-0I; Thu, 11 Dec 2025 06:40:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vTf1u-0003Qa-Tk
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 06:40:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vTf1s-0000NA-N9
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 06:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765453215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rnkncwa8jTXSkU5zEmaeKdAaLHjWbaPFnbxrlXu/ODE=;
 b=AWt07ew43KkMVsRyfhJuy+WENypATJgbxS/v2UqhxWXjbB1RP463NZ1YTAUNWnN9sdCvQt
 CtgBZoelvkRDgsQZM8zxhuYqMghsDqD90Xotwgw+jQFGHDA03RwWTVet1dip+ni4SjwCTR
 hmet+xSRG50hiCTV9lY9Ux6F0ZgEzdY=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-GU6bWa2nOR2EUPlp5DLXqA-1; Thu, 11 Dec 2025 06:40:13 -0500
X-MC-Unique: GU6bWa2nOR2EUPlp5DLXqA-1
X-Mimecast-MFC-AGG-ID: GU6bWa2nOR2EUPlp5DLXqA_1765453213
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7b9c91b814cso2072994b3a.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 03:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765453213; x=1766058013; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rnkncwa8jTXSkU5zEmaeKdAaLHjWbaPFnbxrlXu/ODE=;
 b=akhnUUW1SaWc5lvH1WK8grdrTXh1GMbJroUX1HpXD+jcDamNKS2P5VJ8d1qgXWrEDK
 xI+4WrknUrMgLGBmZe2nsbtIxE232bqclrYG/WAjn0b/QuKIXWFIXOdD979R6P5YevNe
 iTw639EoPyQst2UcFGT5P58loJWtPSoNoLkUtrZROKnQLZeWXrRgiXcbALl4ClPEqYxd
 EPsdjuJFvVOd7C/dqqW4I5K72FltIOeahP1Fi1cOMlZZywxqQ2mtpmamKZr+yvcgdf0L
 KCS/ajZBzZFAWmPyyf7bhj1ZBEB0aPG9uRo+jyxKMryjEeioS2bUrQen7VW2KLtpKv0w
 RAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765453213; x=1766058013;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rnkncwa8jTXSkU5zEmaeKdAaLHjWbaPFnbxrlXu/ODE=;
 b=oqA1E0pOI2omq5TWfG6AgO1wJH1P70cNN+ntO32Sx3pwMwLldxK3K8hfS37X37adVc
 ok5Xqo/1lUZCDAw1+tJkUHGuLMiSgoV76jSk7bDdQPB5oriHMQKJNpMIpa/2RpxeAb3L
 SBuSdzJEXwoP5QXswuJPmIehkGio7mvROLVt4hDGc7IWho5D1/ByfnlezMp+UWVG/oTg
 iC+7LdwQ+wcDMOs+43YCLwS1w+5JVviHEt46BQ8FJpstkbK43WfyOc0BVQ93K53KqYjV
 lJMA1h9W3qkUJ0DcuGSz4KzV9OPQ1QtYpb5w9UL7SL9ujvXOsUqxV2ou3neUoN3nKyFw
 jg1w==
X-Gm-Message-State: AOJu0YzrrfnKuNQuOt/d0gabmlljEL250nnWdrsWjoxTeFpk2mLfo7zp
 /D/VyPiMgtdkDJ7+pqRq3iTiUynSuKxZ30QE6E7NcjGGxoNmCWegdJTS1OQzMoRUMq7LFv8BXY6
 nH0Uk0oNiBhloesTT7U59GBzxIc6wVqSc0MTdzzLJYZ64WmaoKoYGbMzh
X-Gm-Gg: AY/fxX7Llpuf1UbrPOTSP5O+Z9Xbi1HLLYQoMyvZb3F+emaFzDZN7ukpuHwIP1oc9Ny
 znbBN9/kd1A67RAhLWLJ/4xpzYPv/GnKufIWT0vMd+LZzfptLfW0fJ2VQH7MG1hc6e5NKFGhrEt
 mYYj+vwfYt7kgkuZM65u6a6Tsj8vU3H67Ful9F5KvhI27QmqSkCwJ9ERxZUFlZGe/6+VXOvgi6n
 nKOndS2vVQ7nwNXQVdFmR9wnc/+jbFbt6KT/7eJ/AKMinRN33h6UEB9QNy/qRwOm4VL5PfuX4/n
 OuRko1PPLtRiNP93iGpqtuuw/JMrnOcAKUINzFZujXvg5bMJhSdfmB3XqQXE+XGd3jnjPJuBfVb
 SD0x0QyfHfvuXcj2PIKILc/0Bmd1d9PS2jMfKeGppbVXL6vKma+vH2Kk=
X-Received: by 2002:a05:6a00:2e90:b0:7e8:450c:61a1 with SMTP id
 d2e1a72fcca58-7f22ea71947mr5488918b3a.56.1765453212757; 
 Thu, 11 Dec 2025 03:40:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb3LlcI5ZTI/WNDVeuuXiCPyISAB8g6eCdqO/WuMn0TcpRCuJPOhYmVac5g2ll0P58O2SxxQ==
X-Received: by 2002:a05:6a00:2e90:b0:7e8:450c:61a1 with SMTP id
 d2e1a72fcca58-7f22ea71947mr5488898b3a.56.1765453212356; 
 Thu, 11 Dec 2025 03:40:12 -0800 (PST)
Received: from smtpclient.apple ([110.225.4.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7f4c27771b3sm2330911b3a.27.2025.12.11.03.40.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Dec 2025 03:40:11 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.3\))
Subject: Re: [PATCH v2 3/5] igvm: move file load to complete callback
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20251211105419.3573449-4-kraxel@redhat.com>
Date: Thu, 11 Dec 2025 17:09:56 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Tsirkin <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Oliver Steffen <osteffen@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Luigi Leonardi <leonardi@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <15A0701C-9973-473F-8804-812CF6B5F909@redhat.com>
References: <20251211105419.3573449-1-kraxel@redhat.com>
 <20251211105419.3573449-4-kraxel@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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



> On 11 Dec 2025, at 4:24=E2=80=AFPM, Gerd Hoffmann <kraxel@redhat.com> =
wrote:
>=20
> Add UserCreatableClass->complete callback function for igvm-cfg =
object.
>=20
> Move file loading and parsing of the igvm file from the process =
function
> to the new complete() callback function.  Keep the igvm file loaded
> after processing, release it in finalize() instead, so we parse it =
only
> once.

LGTM.

>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> include/system/igvm-internal.h |  5 +++++
> backends/igvm-cfg.c            | 18 ++++++++++++++++++
> backends/igvm.c                |  9 ++++-----
> 3 files changed, 27 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/system/igvm-internal.h =
b/include/system/igvm-internal.h
> index e0452080b127..d378d682b0fb 100644
> --- a/include/system/igvm-internal.h
> +++ b/include/system/igvm-internal.h
> @@ -12,6 +12,8 @@
> #include "qemu/typedefs.h"
> #include "qom/object.h"
>=20
> +#include <igvm/igvm.h>
> +
> struct IgvmCfg {
>     ObjectClass parent_class;
>=20
> @@ -21,7 +23,10 @@ struct IgvmCfg {
>      *           format.
>      */
>     char *filename;
> +    IgvmHandle file;
>     ResettableState reset_state;
> };
>=20
> +IgvmHandle qigvm_file_init(char *filename, Error **errp);
> +
> #endif
> diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
> index e0df3eaa8efd..4014062e0f22 100644
> --- a/backends/igvm-cfg.c
> +++ b/backends/igvm-cfg.c
> @@ -53,6 +53,13 @@ static void igvm_reset_exit(Object *obj, ResetType =
type)
>     trace_igvm_reset_exit(type);
> }
>=20
> +static void igvm_complete(UserCreatable *uc, Error **errp)
> +{
> +    IgvmCfg *igvm =3D IGVM_CFG(uc);
> +
> +    igvm->file =3D qigvm_file_init(igvm->filename, errp);
> +}
> +
> OBJECT_DEFINE_TYPE_WITH_INTERFACES(IgvmCfg, igvm_cfg, IGVM_CFG, =
OBJECT,
>                                    { TYPE_USER_CREATABLE },
>                                    { TYPE_RESETTABLE_INTERFACE },
> @@ -62,6 +69,7 @@ static void igvm_cfg_class_init(ObjectClass *oc, =
const void *data)
> {
>     IgvmCfgClass *igvmc =3D IGVM_CFG_CLASS(oc);
>     ResettableClass *rc =3D RESETTABLE_CLASS(oc);
> +    UserCreatableClass *uc =3D USER_CREATABLE_CLASS(oc);
>=20
>     object_class_property_add_str(oc, "file", get_igvm, set_igvm);
>     object_class_property_set_description(oc, "file",
> @@ -73,14 +81,24 @@ static void igvm_cfg_class_init(ObjectClass *oc, =
const void *data)
>     rc->phases.enter =3D igvm_reset_enter;
>     rc->phases.hold =3D igvm_reset_hold;
>     rc->phases.exit =3D igvm_reset_exit;
> +
> +    uc->complete =3D igvm_complete;
> }
>=20
> static void igvm_cfg_init(Object *obj)
> {
> +    IgvmCfg *igvm =3D IGVM_CFG(obj);
> +
> +    igvm->file =3D -1;
>     qemu_register_resettable(obj);
> }
>=20
> static void igvm_cfg_finalize(Object *obj)
> {
> +    IgvmCfg *igvm =3D IGVM_CFG(obj);
> +
>     qemu_unregister_resettable(obj);
> +    if (igvm->file >=3D 0) {
> +        igvm_free(igvm->file);
> +    }
> }
> diff --git a/backends/igvm.c b/backends/igvm.c
> index fbb8300b6d01..a01e01a12a60 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -869,7 +869,7 @@ static int qigvm_handle_policy(QIgvm *ctx, Error =
**errp)
>     return 0;
> }
>=20
> -static IgvmHandle qigvm_file_init(char *filename, Error **errp)
> +IgvmHandle qigvm_file_init(char *filename, Error **errp)
> {
>     IgvmHandle igvm;
>     g_autofree uint8_t *buf =3D NULL;
> @@ -898,10 +898,11 @@ int qigvm_process_file(IgvmCfg *cfg, =
ConfidentialGuestSupport *cgs,
>     QIgvm ctx;
>=20
>     memset(&ctx, 0, sizeof(ctx));
> -    ctx.file =3D qigvm_file_init(cfg->filename, errp);
> -    if (ctx.file < 0) {
> +    if (cfg->file < 0) {
> +        error_setg(errp, "No IGVM file loaded.");
>         return -1;
>     }
> +    ctx.file =3D cfg->file;
>=20
>     /*
>      * The ConfidentialGuestSupport object is optional and allows a =
confidential
> @@ -992,7 +993,5 @@ cleanup_parameters:
>     g_free(ctx.id_auth);
>=20
> cleanup:
> -    igvm_free(ctx.file);
> -
>     return retval;
> }
> --=20
> 2.52.0
>=20



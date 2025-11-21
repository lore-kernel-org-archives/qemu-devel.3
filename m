Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF005CFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcoS-0004YL-V8; Fri, 21 Nov 2025 20:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vMbcF-0003UT-4X
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:36:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vMbc3-0005uq-DX
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763771772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ka/LwZACBj7+iB/mKpac26m4PyzjtvU3xnZwHxw/o2Y=;
 b=AAFcUvCV0N+UuwW2NqJ80jLmuKCc8W8myk83AGKMNt5RfwX80HeUWhgzzTc2xU+TIp9Pio
 tcAnjmpqm0ezCKZwMrA42vHK1T/wyoNk7058kgtuqioqRrJpKGdytCdJewO9yhK4LUXI/w
 UxCUONTSBgcaNHQSnK69rcdF1a0Hyfc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-V2IGyd9jMrmoQwTkyXgP8Q-1; Fri, 21 Nov 2025 07:17:11 -0500
X-MC-Unique: V2IGyd9jMrmoQwTkyXgP8Q-1
X-Mimecast-MFC-AGG-ID: V2IGyd9jMrmoQwTkyXgP8Q_1763727431
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-340bc4ef67fso2488423a91.3
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 04:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763727431; x=1764332231; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ka/LwZACBj7+iB/mKpac26m4PyzjtvU3xnZwHxw/o2Y=;
 b=IBAKuaWfiJjEm5i2Ff6O/JB57V9eA8Uw3NnFhO+nPoYbyeyR1P6EVxh2/8WzfJzCwd
 Ane8XWAovPYWyuQnJ7ZKknlZLZe3bN7ypqqRE3DLRVt2GPmDvmbN2E441G3JmZiaAYG1
 yCOX744IjBH8YntXLh3aM+2FGj9QwMzPE0pBHfD17Wkrr5eVnS7PYp3Ll1IrcCDA1g1r
 893ng+XH97oqlIFLtSkYK1Ro07QFxmudN81cCshouplMBlYw/lJ/jxENjsBoVr0LwrHw
 1AO7B3p33fX2DNXTaMFWfvdbV+x0ZJtQzHjhEU0NB5APrZQBRYP6JvwU2PzRaAXRB/V6
 U8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763727431; x=1764332231;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ka/LwZACBj7+iB/mKpac26m4PyzjtvU3xnZwHxw/o2Y=;
 b=GwckpbuwQS52Me6Q9Jzuk89n9dgm6i8YjZa3fj1qfRq1lminWnsoGiDtIEpjrY5g/o
 tHBjyLMrOcbdEVnzXG2kdjZAcZd3S+9U8kMV4e/3q9gSqtL8py4+aQ7aU69eqesWsYSX
 lcjzPKrfK7j3NMz3A0Zx7jOhfRvcBB9xZDUOHe4zQikVT9S6+4kjfUxfahEzOqmxlnX5
 +H3bXQQYvNxCd3Szo478DS8a0SF7NV0op4kZC3E+t5bSlksozTTeOIzsMbLMzeKQNepi
 5b/2WguDPNozMHf6A1O7Ioi8Vber4YTx2nQ2daB9Zkig55YqSvrOE0eoGQaP6Jt8C2u5
 nbOw==
X-Gm-Message-State: AOJu0YxaRCUK0EubavACtP6rcVbGvfJJihWhC6JNSKQ2IR8eQE4Haga3
 8PgdiJAvD/Trh7krVFCoMVOj1XmITs8yegXrCAmsQyDf6wloUlU7eQxn4XU0RA4jjdtQ3CBzuRZ
 Zj+cVvIAWb+MYakcsDTyEBr7MW90AjZ2pI+WM3DXKjdpXtbWXaAbNl4RA
X-Gm-Gg: ASbGncvIXKjDN+SBfJyAPP2+Qn6GStfPe3GERPZxHQxjqsH8d6Xa7zEJaH4fSMEa5tm
 fCEllTm3UW3ocuS5n5D9rZiPjd89lmo2hfcgeIjwhbS72hs4aVAnUN6oBv+JOovsAXzOzuCDk7z
 8A+bW1KkBbXyh+TXFKjWMEwfBHN9fccqC2MLQdPulHrZHHEh3+HC2m013Y9y8snuBhFYOahGnWB
 fIEQ8zDDibk0M7isqCTTk9CYSG99La+s3SI4mb9GGLiykWEZB948vgUKFSoIMX0581NDE6ntrJN
 sibggN95jGrxzUIy9DyLNLSvzUbFe6jJlyyQWi+m3M7JRGRcKzJFBsEVADRG9qLpdSA7knfLAZo
 JYBuOtdm3YxNwenMDxQj3ofXShD89xhIazvE3MRBYOKt3oqHXgL31ehUh
X-Received: by 2002:a17:90b:4e8d:b0:340:ad5e:cd with SMTP id
 98e67ed59e1d1-34733e4a359mr2276525a91.5.1763727430769; 
 Fri, 21 Nov 2025 04:17:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYo3UIS+Xk1AQWXXJzIlOgywUNh3uyMp+jPNLa30cdjAzJgIygKaOQA/bOes2pqvStzrgSAQ==
X-Received: by 2002:a17:90b:4e8d:b0:340:ad5e:cd with SMTP id
 98e67ed59e1d1-34733e4a359mr2276495a91.5.1763727430313; 
 Fri, 21 Nov 2025 04:17:10 -0800 (PST)
Received: from smtpclient.apple ([106.212.87.16])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34726696cd4sm5577760a91.4.2025.11.21.04.17.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Nov 2025 04:17:10 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.7\))
Subject: Re: [PATCH 1/4] igvm: make igvm-cfg object resetable
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20251118122133.1695767-2-kraxel@redhat.com>
Date: Fri, 21 Nov 2025 17:46:55 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Oliver Steffen <osteffen@redhat.com>,
 Michael Tsirkin <mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4FB46312-EECB-46E1-A70B-A26BA4DE14B3@redhat.com>
References: <20251118122133.1695767-1-kraxel@redhat.com>
 <20251118122133.1695767-2-kraxel@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51.11.7)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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



> On 18 Nov 2025, at 5:51=E2=80=AFPM, Gerd Hoffmann <kraxel@redhat.com> =
wrote:
>=20
> Add TYPE_RESETTABLE_INTERFACE to interfaces.  Register callbacks for =
the
> reset phases.  Add trace points for logging and debugging.  No
> functional change, that will come in followup patches.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> include/system/igvm-cfg.h |  2 ++
> backends/igvm-cfg.c       | 36 +++++++++++++++++++++++++++++++++++-
> backends/trace-events     |  5 +++++
> 3 files changed, 42 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/system/igvm-cfg.h b/include/system/igvm-cfg.h
> index 944f23a814dd..312f77c092b0 100644
> --- a/include/system/igvm-cfg.h
> +++ b/include/system/igvm-cfg.h
> @@ -13,6 +13,7 @@
> #define QEMU_IGVM_CFG_H
>=20
> #include "qom/object.h"
> +#include "hw/resettable.h"
>=20
> typedef struct IgvmCfg {
>     ObjectClass parent_class;
> @@ -23,6 +24,7 @@ typedef struct IgvmCfg {
>      *           format.
>      */
>     char *filename;
> +    ResettableState reset_state;
> } IgvmCfg;
>=20
> typedef struct IgvmCfgClass {
> diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
> index d00acf351249..4e3ef88ffc27 100644
> --- a/backends/igvm-cfg.c
> +++ b/backends/igvm-cfg.c
> @@ -13,8 +13,11 @@
>=20
> #include "system/igvm-cfg.h"
> #include "system/igvm.h"
> +#include "system/reset.h"
> #include "qom/object_interfaces.h"
>=20
> +#include "trace.h"
> +
> static char *get_igvm(Object *obj, Error **errp)
> {
>     IgvmCfg *igvm =3D IGVM_CFG(obj);
> @@ -28,24 +31,55 @@ static void set_igvm(Object *obj, const char =
*value, Error **errp)
>     igvm->filename =3D g_strdup(value);
> }
>=20
> +static ResettableState *igvm_reset_state(Object *obj)
> +{
> +    IgvmCfg *igvm =3D IGVM_CFG(obj);
> +    return &igvm->reset_state;
> +}
> +
> +static void igvm_reset_enter(Object *obj, ResetType type)
> +{
> +    trace_igvm_reset_enter(type);
> +}
> +
> +static void igvm_reset_hold(Object *obj, ResetType type)
> +{
> +    trace_igvm_reset_hold(type);
> +}
> +
> +static void igvm_reset_exit(Object *obj, ResetType type)
> +{
> +    trace_igvm_reset_exit(type);
> +}
> +
> OBJECT_DEFINE_TYPE_WITH_INTERFACES(IgvmCfg, igvm_cfg, IGVM_CFG, =
OBJECT,
> -                                   { TYPE_USER_CREATABLE }, { NULL })
> +                                   { TYPE_USER_CREATABLE },
> +                                   { TYPE_RESETTABLE_INTERFACE },
> +                                   { NULL })
>=20
> static void igvm_cfg_class_init(ObjectClass *oc, const void *data)
> {
>     IgvmCfgClass *igvmc =3D IGVM_CFG_CLASS(oc);
> +    ResettableClass *rc =3D RESETTABLE_CLASS(oc);
>=20
>     object_class_property_add_str(oc, "file", get_igvm, set_igvm);
>     object_class_property_set_description(oc, "file",
>                                           "Set the IGVM filename to =
use");
>=20
>     igvmc->process =3D qigvm_process_file;
> +
> +    rc->get_state =3D igvm_reset_state;
> +    rc->phases.enter =3D igvm_reset_enter;
> +    rc->phases.hold =3D igvm_reset_hold;
> +    rc->phases.exit =3D igvm_reset_exit;
> }
>=20
> static void igvm_cfg_init(Object *obj)
> {
> +    qemu_register_resettable(obj);
> }
>=20
> static void igvm_cfg_finalize(Object *obj)
> {
> +    qemu_unregister_resettable(obj);
> }
> diff --git a/backends/trace-events b/backends/trace-events
> index 56132d3fd22b..45ac46dc2454 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -21,3 +21,8 @@ iommufd_backend_free_id(int iommufd, uint32_t id, =
int ret) " iommufd=3D%d id=3D%d (%
> iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, =
int ret) " iommufd=3D%d hwpt=3D%u enable=3D%d (%d)"
> iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, =
uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=3D%d =
hwpt=3D%u iova=3D0x%"PRIx64" size=3D0x%"PRIx64" page_size=3D0x%"PRIx64" =
(%d)"
> iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t =
data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, =
uint64_t data_ptr, int ret) " iommufd=3D%d id=3D%u data_type=3D%u =
entry_len=3D%u entry_num=3D%u done_num=3D%u data_ptr=3D0x%"PRIx64" (%d)"
> +
> +# igvm-cfg.c
> +igvm_reset_enter(int type) "type=3D%u"
> +igvm_reset_hold(int type) "type=3D%u"
> +igvm_reset_exit(int type) "type=3D%u"
> --=20
> 2.51.1
>=20



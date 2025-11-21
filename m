Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FDFCFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd3N-0001wA-4B; Fri, 21 Nov 2025 21:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vMcMR-0004dT-6L
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:24:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vMcKO-0007cT-M3
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763774521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnIzSUUrS1swzzUC1Gql/juDpqUvSVV/2fr6WwHANWw=;
 b=cgS1TStTzQaQiQLaxoVJT3b744lbvgo9CeGQrXVRRSSOJO/OIsJ8bQL1DiRhERe0NqKtzD
 DhG9AX3VEHf+LAdMXeioI4GEWt5rS+w0d6W3g6CgYb/r8qYG9/AYmQQXoI7/69j3oUtkPd
 Lo5Ig56HYtvfN53m23vKoRuiWZSbbVs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-nHW_3suoOHqcYoF1NDmALw-1; Fri, 21 Nov 2025 08:03:59 -0500
X-MC-Unique: nHW_3suoOHqcYoF1NDmALw-1
X-Mimecast-MFC-AGG-ID: nHW_3suoOHqcYoF1NDmALw_1763730238
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-34378c914b4so7228629a91.1
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 05:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763730238; x=1764335038; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cnIzSUUrS1swzzUC1Gql/juDpqUvSVV/2fr6WwHANWw=;
 b=pb8hFaY2FTWOUAVGN5Ew9Xmr9qzoHjMgd8JgWaD+AAhb6OUqxaI2+HmxbK5Ex7Uk58
 HKC+49y2U0Ou92oOwiTDJ3se+ANPX/RsmVgwIpt6amkmW5127W5GyUnyGsAPoW5eNwiD
 PlZEQIy7FnrWWmb5aMyayp5wUjBV0YC7EQitLQ/t0Sf1mcTWQBEkR0a2lTnlVwmXHaMX
 zTYlSJshQ7Bnc222nmh3nyuF6d9RxTFLi76Ealze28Ouf+vUmy5uVk/NmOleKgUhYg3c
 KJzGQD2WbVkb0gfrOEl660ppgMv/dFbrCJs+Wi3XytrNHQ1tEKG81cPBCaGuJrnJ8vTN
 VaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763730238; x=1764335038;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cnIzSUUrS1swzzUC1Gql/juDpqUvSVV/2fr6WwHANWw=;
 b=uUoXN2qoWNXJTCOoQC2kyySKobcZiLRZX6FNLwkwysDbSq9W5v/Q43dDfAR9TR3uZZ
 wAa+ffyR5WlkF6iVTF7oW5+GILMC0RXHgM5sHAHmB/qiEJugG/bPrSQvKJjnGUqzYn+F
 /aHWPfqK+snlTj3P84GcCOvPur7kIWg3eNVDMdHxZ+EpFrsQ5EUfcfbQKCRFx2R/qMJy
 aD4O6BPFI/CEczJXUjEhGG+o+/BsVy2ghnAjSiQAPmnH1JLjev1xaYIijkpLSlwI6gp+
 Pfgb6XwsJwfB+0rBGvo83+IVuyQ29gR9Xi7jpMMEjvRnwGqtHgzz/E3f4XcTMfJ1VZrz
 I19A==
X-Gm-Message-State: AOJu0YzFSOtx1IwnZ3/0kVQuBKXl0+c0wZr/GtI4vNxkXtXt5ycRA6iS
 jS7+1rPshMAuNcHQRCbmy/1jaHs5O2hujC0JP9LZB1rHq09mKNRPZH6sGuZUYUpKxiEt5QSmWoe
 vQ7GhSGM9oRmscfLTtoLXk+e09MMbEs6GCG731zQsu6yYrftl6bloGaiA
X-Gm-Gg: ASbGncuU1fp6sJmqYwftynV+Us8KBGa0a+P2lja3cB/W8C4ZkhTyaMZIVV3uAfzuAmn
 pd93TBqmDAhnmmg5DebI5INgLl4PM37HEGK4OZ2i6o+vqhuRpjObKbXvKIQsZZH28OCQPcqLtM6
 PasfAuS4Q9LonUhMv/cDeewC8RM3ADaaD0I0HmEJCCn81zdGQjcHCn1TfYfq3xCAJ83U71YXejs
 LXc+Wst1EGzR1wKeVgW+AuDJg4Vj1LIOZQ4ReYEFsH1tXN6jNVVEwMNUjQWaiM1dVMaBmDPQhqj
 ZRjTSd2oaSFG5vumeJ6iawnV5WcpaY7fugDhN840OIev2kwh9vW39lTv4OxkLfwUhkAAApkCcru
 2dM7qfIYxGZltaJRUBW6dPgdxsbUMPihKkCwUVXwsurQsp0IH3XdAqdEf
X-Received: by 2002:a17:90b:5291:b0:32b:baaa:21b0 with SMTP id
 98e67ed59e1d1-34733e2cf72mr2736500a91.6.1763730237875; 
 Fri, 21 Nov 2025 05:03:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9z73w+xTeL8Oai95QwLGhoJSyZVulqhtwks2fXFfW287REBfLy+RqGo+iG4NY+2Niiqjnqg==
X-Received: by 2002:a17:90b:5291:b0:32b:baaa:21b0 with SMTP id
 98e67ed59e1d1-34733e2cf72mr2736458a91.6.1763730237396; 
 Fri, 21 Nov 2025 05:03:57 -0800 (PST)
Received: from smtpclient.apple ([106.212.87.16])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34726696cd4sm5701513a91.4.2025.11.21.05.03.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Nov 2025 05:03:57 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.7\))
Subject: Re: [PATCH 2/4] igvm: move file load to complete callback
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20251118122133.1695767-3-kraxel@redhat.com>
Date: Fri, 21 Nov 2025 18:33:42 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Oliver Steffen <osteffen@redhat.com>,
 Michael Tsirkin <mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <17BD5E34-2195-4F84-A96F-83A8054EF62B@redhat.com>
References: <20251118122133.1695767-1-kraxel@redhat.com>
 <20251118122133.1695767-3-kraxel@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51.11.7)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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
> Add UserCreatableClass->complete callback function for igvm-cfg =
object.
>=20
> Move file loading and parsing of the igvm file from the process =
function
> to the to the new complete callback function.  Keep the igvm file =
loaded
> instead of releasing it after processing, so we parse it only once.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> include/system/igvm-cfg.h |  3 +++
> include/system/igvm.h     |  1 +
> backends/igvm-cfg.c       | 10 ++++++++++
> backends/igvm.c           |  9 ++++-----
> 4 files changed, 18 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/system/igvm-cfg.h b/include/system/igvm-cfg.h
> index 312f77c092b0..7dc48677fd99 100644
> --- a/include/system/igvm-cfg.h
> +++ b/include/system/igvm-cfg.h
> @@ -15,6 +15,8 @@
> #include "qom/object.h"
> #include "hw/resettable.h"
>=20
> +#include <igvm/igvm.h>
> +
> typedef struct IgvmCfg {
>     ObjectClass parent_class;
>=20
> @@ -24,6 +26,7 @@ typedef struct IgvmCfg {
>      *           format.
>      */
>     char *filename;
> +    IgvmHandle file;
>     ResettableState reset_state;
> } IgvmCfg;
>=20
> diff --git a/include/system/igvm.h b/include/system/igvm.h
> index 48ce20604259..ec2538daa0e1 100644
> --- a/include/system/igvm.h
> +++ b/include/system/igvm.h
> @@ -16,6 +16,7 @@
> #include "system/igvm-cfg.h"
> #include "qapi/error.h"
>=20
> +IgvmHandle qigvm_file_init(char *filename, Error **errp);
> int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
>                       bool onlyVpContext, Error **errp);
>=20
> diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
> index 4e3ef88ffc27..08501a67e58e 100644
> --- a/backends/igvm-cfg.c
> +++ b/backends/igvm-cfg.c
> @@ -52,6 +52,13 @@ static void igvm_reset_exit(Object *obj, ResetType =
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
> @@ -61,6 +68,7 @@ static void igvm_cfg_class_init(ObjectClass *oc, =
const void *data)
> {
>     IgvmCfgClass *igvmc =3D IGVM_CFG_CLASS(oc);
>     ResettableClass *rc =3D RESETTABLE_CLASS(oc);
> +    UserCreatableClass *uc =3D USER_CREATABLE_CLASS(oc);
>=20
>     object_class_property_add_str(oc, "file", get_igvm, set_igvm);
>     object_class_property_set_description(oc, "file",
> @@ -72,6 +80,8 @@ static void igvm_cfg_class_init(ObjectClass *oc, =
const void *data)
>     rc->phases.enter =3D igvm_reset_enter;
>     rc->phases.hold =3D igvm_reset_hold;
>     rc->phases.exit =3D igvm_reset_exit;
> +
> +    uc->complete =3D igvm_complete;
> }
>=20
> static void igvm_cfg_init(Object *obj)
> diff --git a/backends/igvm.c b/backends/igvm.c
> index 905bd8d98994..05d197fdfe85 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -867,7 +867,7 @@ static int qigvm_handle_policy(QIgvm *ctx, Error =
**errp)
>     return 0;
> }
>=20
> -static IgvmHandle qigvm_file_init(char *filename, Error **errp)
> +IgvmHandle qigvm_file_init(char *filename, Error **errp)
> {
>     IgvmHandle igvm;
>     g_autofree uint8_t *buf =3D NULL;
> @@ -896,10 +896,11 @@ int qigvm_process_file(IgvmCfg *cfg, =
ConfidentialGuestSupport *cgs,
>     QIgvm ctx;
>=20
>     memset(&ctx, 0, sizeof(ctx));
> -    ctx.file =3D qigvm_file_init(cfg->filename, errp);
> -    if (ctx.file < 0) {
> +    if (!cfg->file) {

This is not right I think. qigvm_file_init() returns -1 if =
igvm_new_from_binary() fails and returns < 0. Looking at=20
https://docs.rs/igvm/latest/igvm/c_api/fn.igvm_new_from_binary.html this =
seems correct.

> +        error_setg(errp, "No IGVM file loaded.");
>         return -1;
>     }
> +    ctx.file =3D cfg->file;
>=20
>     /*
>      * The ConfidentialGuestSupport object is optional and allows a =
confidential
> @@ -990,7 +991,5 @@ cleanup_parameters:
>     g_free(ctx.id_auth);
>=20
> cleanup:
> -    igvm_free(ctx.file);
> -
>     return retval;
> }
> --=20
> 2.51.1
>=20



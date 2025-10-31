Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F466CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnFI-0003r1-3r; Fri, 31 Oct 2025 07:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEnF7-0003nJ-7M
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:24:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEnEw-0008Vx-E7
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761909848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FldiLijxMP0MxHqs0E4Y0Qpaj1NVzwOdWNNf8dDoRC4=;
 b=ANOOtXNdHDpfjwrX0xZ30m679xzIfTi7nxQ7WPcSYP19gXEbTdh+YI+holf50Phl4PjPoS
 o3Ea+e7nSdBse3WOTr4VDXF7XXgyNUC3yH2DNrII1eJw8CQXmvP86xUvBM39G/KAU5ZqwQ
 6wzgke5zPqpFpi81wGUpkNMr0GRYFWI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-I_FCTpgqOUufFtT7E2SnVg-1; Fri, 31 Oct 2025 07:24:07 -0400
X-MC-Unique: I_FCTpgqOUufFtT7E2SnVg-1
X-Mimecast-MFC-AGG-ID: I_FCTpgqOUufFtT7E2SnVg_1761909846
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-33dadf7c5c0so2417875a91.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 04:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761909845; x=1762514645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FldiLijxMP0MxHqs0E4Y0Qpaj1NVzwOdWNNf8dDoRC4=;
 b=GI0AwNyS/GrWeAj1ttm2rJrJBh3uCnik9UH2ySFdRkH9PYESqx2ypMkCV7k8/E0IHY
 kamOHPoV+hsdYsYd5UGrV7lra1LV/8iS+4MhQrFIHPii4whklMYxPgUAlRHEiLDHUB10
 cZW3jDNkEj0CZn41gY54agGLY/Wfe0VDFuqcFkZ4ogiMAAqlrDHTuR3saWN3Ddrn1dqX
 rq+u3iICpvxe7RAtapFIQVgDvvV8/r6eFjVJnljiYHpNM+GTpIwPeXOAZcujxfNXPt3Y
 /PlkdghX28PH6n+40gm4KwB5/0uGjqeAq7w10rxqHQp0adunqlO25n4FIpsm8P0cXwk8
 X92g==
X-Gm-Message-State: AOJu0YxOKRR3+PeSgayakL74hx0eHIAgHTFGfoI3mnZVbKWN0uA9AtU9
 T8SykaQk7gSGO0lTaqQsKKeKQE/GgZeb5EiY+GzF65eZ6sYguPX/cPLNQsdrqBvwnz8dnyLXPas
 tQDxBO6D6b5HBWRKrROq6jb9DaiynA9yJYQ1lzM4qi70iCQHU3Q2YRWWZZmQrsfXnrztHi8R67E
 but2ylQn2NUcZ+pVix3MqC88YbhoAoTyk=
X-Gm-Gg: ASbGncvnm/dFM9M/3C5hjAg4MwWGI08RFPlIWGGW8bVd/ebVQ338XGfyLh3aUP7k/PR
 T9AWglhrWxfZvmFx5SF0T0K1G2FWxMMH3ec6V27LukJxFFTHBKWegF7y7j5X8U3nk40nhsmMHh7
 VYVlElHr7EM4hMvTszP4EsUeJ9hir+nZPLy+wo9lBKxsDMuLEYCb89fNkp8CDTKvVZ2iYeyrO6Z
 rrhYTCdQP1w0tA=
X-Received: by 2002:a17:90b:4f48:b0:32e:8ff9:d124 with SMTP id
 98e67ed59e1d1-340815b7a67mr4415581a91.15.1761909844940; 
 Fri, 31 Oct 2025 04:24:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/HVoFQJdrQ/NXjas65THlMYHRPyCaTfzziDraqXBQejRNs9fpCsZI74W7vh1I9U5Uv3u15PcdJDmLf+KnP3s=
X-Received: by 2002:a17:90b:4f48:b0:32e:8ff9:d124 with SMTP id
 98e67ed59e1d1-340815b7a67mr4415550a91.15.1761909844543; Fri, 31 Oct 2025
 04:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20251030144927.2241109-1-berrange@redhat.com>
 <20251030144927.2241109-14-berrange@redhat.com>
In-Reply-To: <20251030144927.2241109-14-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 31 Oct 2025 15:23:51 +0400
X-Gm-Features: AWmQ_bmuNdrr6aG4R70ZPGW-tf6FQI6OYm-G5ieU39yVUWSYCH5D72oTisUS4sI
Message-ID: <CAMxuvazU6nyXUsmSATMNHz8jevDT2=7A+x=fZ7-K7fr+aVOkDQ@mail.gmail.com>
Subject: Re: [PATCH 13/21] crypto: introduce a wrapper around gnutls
 credentials
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Content-Type: multipart/alternative; boundary="00000000000069237d0642729a1f"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000069237d0642729a1f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Oct 30, 2025 at 6:49=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> The gnutls_credentials_set() method has a very suprising API contract
> that requires the caller to preserve the passed in credentials pointer
> for as long as the gnutls_session_t object is alive. QEMU is failing
> to ensure this happens.
>
> In QEMU the GNUTLS credentials object is owned by the QCryptoTLSCreds
> object instance while the GNUTLS session object is owned by the
> QCryptoTLSSession object instance. Their lifetimes are not guaranteed
> to be the same, though in most common usage the credentials will outlive
> the session. This is notably not the case, however, after the VNC server
> gained the ability to reload credentials on the fly with:
>
>   commit 1f08e3415120637cad7f540d9ceb4dba3136dbdd
>   Author: Zihao Chang <changzihao1@huawei.com>
>   Date:   Tue Mar 16 15:58:44 2021 +0800
>
>     vnc: support reload x509 certificates for vnc
>
> If that is triggered while a VNC client is in the middle of performing
> a TLS handshake, we might hit a use-after-free.
>
> It is difficult to correct this problem because there's no way to deep-
> clone a GNUTLS credentials object, nor is it reference counted. Thus we
> introduce a QCryptoTLSCredsBox object whose only purpose is to add
> reference counting around the GNUTLS credentials object.
>
> The DH parameters set against a credentials object also have to be kept
> alive for as long as the credentials exist. So the box must also hold
> the DH parameters pointer.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  crypto/meson.build   |   5 ++-
>  crypto/tlscredsbox.c | 101 +++++++++++++++++++++++++++++++++++++++++++
>  crypto/tlscredsbox.h |  46 ++++++++++++++++++++
>  3 files changed, 151 insertions(+), 1 deletion(-)
>  create mode 100644 crypto/tlscredsbox.c
>  create mode 100644 crypto/tlscredsbox.h
>
> diff --git a/crypto/meson.build b/crypto/meson.build
> index 735635de1f..1fc14b2a04 100644
> --- a/crypto/meson.build
> +++ b/crypto/meson.build
> @@ -25,7 +25,10 @@ crypto_ss.add(files(
>  ))
>
>  if gnutls.found()
> -  crypto_ss.add(files('x509-utils.c'))
> +  crypto_ss.add(files(
> +    'tlscredsbox.c',
> +    'x509-utils.c',
> +  ))
>  endif
>
>  if nettle.found()
> diff --git a/crypto/tlscredsbox.c b/crypto/tlscredsbox.c
> new file mode 100644
> index 0000000000..b8d9846af8
> --- /dev/null
> +++ b/crypto/tlscredsbox.c
> @@ -0,0 +1,101 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * QEMU crypto TLS credential support
> + *
> + * Copyright (c) 2025 Red Hat, Inc.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "crypto/tlscredsbox.h"
> +#include "qemu/atomic.h"
> +
> +
> +static QCryptoTLSCredsBox *
> +qcrypto_tls_creds_box_new_impl(int type, bool server)
> +{
> +    QCryptoTLSCredsBox *credsbox =3D g_new0(QCryptoTLSCredsBox, 1);
> +    credsbox->ref =3D 1;
> +    credsbox->server =3D server;
> +    credsbox->type =3D type;
> +    return credsbox;
> +}
> +
> +
> +QCryptoTLSCredsBox *
> +qcrypto_tls_creds_box_new_server(int type)
> +{
> +    return qcrypto_tls_creds_box_new_impl(type, true);
> +}
> +
> +
> +QCryptoTLSCredsBox *
> +qcrypto_tls_creds_box_new_client(int type)
> +{
> +    return qcrypto_tls_creds_box_new_impl(type, false);
> +}
> +
> +static void qcrypto_tls_creds_box_free(QCryptoTLSCredsBox *credsbox)
> +{
> +    switch (credsbox->type) {
> +    case GNUTLS_CRD_CERTIFICATE:
> +        if (credsbox->data.cert) {
> +            gnutls_certificate_free_credentials(credsbox->data.cert);
> +        }
> +        break;
> +    case GNUTLS_CRD_PSK:
> +        if (credsbox->server) {
> +            if (credsbox->data.pskserver) {
> +
> gnutls_psk_free_server_credentials(credsbox->data.pskserver);
> +            }
> +        } else {
> +            if (credsbox->data.pskclient) {
> +
> gnutls_psk_free_client_credentials(credsbox->data.pskclient);
> +            }
> +        }
> +        break;
> +    case GNUTLS_CRD_ANON:
> +        if (credsbox->server) {
> +            if (credsbox->data.anonserver) {
> +
> gnutls_anon_free_server_credentials(credsbox->data.anonserver);
> +            }
> +        } else {
> +            if (credsbox->data.anonclient) {
> +
> gnutls_anon_free_client_credentials(credsbox->data.anonclient);
> +            }
> +        }
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    if (credsbox->dh_params) {
> +        gnutls_dh_params_deinit(credsbox->dh_params);
> +    }
> +
> +    g_free(credsbox);
> +}
> +
> +
> +void qcrypto_tls_creds_box_ref(QCryptoTLSCredsBox *credsbox)
> +{
> +    uint32_t ref =3D qatomic_fetch_inc(&credsbox->ref);
> +    /* Assert waaay before the integer overflows */
> +    g_assert(ref < INT_MAX);
> +}
> +
> +
> +void qcrypto_tls_creds_box_unref(QCryptoTLSCredsBox *credsbox)
> +{
> +    if (!credsbox) {
> +        return;
> +    }
> +
> +    g_assert(credsbox->ref > 0);
> +
> +    if (qatomic_fetch_dec(&credsbox->ref) =3D=3D 1) {
> +        qcrypto_tls_creds_box_free(credsbox);
> +    }
> +
> +}
> +
> diff --git a/crypto/tlscredsbox.h b/crypto/tlscredsbox.h
> new file mode 100644
> index 0000000000..5d89335f46
> --- /dev/null
> +++ b/crypto/tlscredsbox.h
> @@ -0,0 +1,46 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * QEMU crypto TLS credential support
> + *
> + * Copyright (c) 2025 Red Hat, Inc.
> + */
> +
> +#ifndef QCRYPTO_TLSCREDS_BOX_H
> +#define QCRYPTO_TLSCREDS_BOX_H
> +
> +#include "qom/object.h"
> +
> +#ifdef CONFIG_GNUTLS
> +#include <gnutls/gnutls.h>
> +#endif
> +
> +typedef struct QCryptoTLSCredsBox QCryptoTLSCredsBox;
> +
> +struct QCryptoTLSCredsBox {
> +    uint32_t ref;
> +    bool server;
> +    int type;
> +    union {
> +        void *any;
>

since any is used in code to cast the variant to a void *, it may be worth
a comment to say that all fields are expected to be pointers.


> +#ifdef CONFIG_GNUTLS
> +        gnutls_anon_server_credentials_t anonserver;
> +        gnutls_anon_client_credentials_t anonclient;
> +        gnutls_psk_server_credentials_t pskserver;
> +        gnutls_psk_client_credentials_t pskclient;
> +        gnutls_certificate_credentials_t cert;
> +#endif
> +    } data;
> +#ifdef CONFIG_GNUTLS
> +    gnutls_dh_params_t dh_params;
> +#endif
> +};
> +
> +QCryptoTLSCredsBox *qcrypto_tls_creds_box_new_server(int type);
> +QCryptoTLSCredsBox *qcrypto_tls_creds_box_new_client(int type);
> +void qcrypto_tls_creds_box_ref(QCryptoTLSCredsBox *credsbox);
> +void qcrypto_tls_creds_box_unref(QCryptoTLSCredsBox *credsbox);
> +
> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoTLSCredsBox,
> qcrypto_tls_creds_box_unref);
> +
> +#endif /* QCRYPTO_TLSCREDS_BOX_H */
> --
> 2.51.1
>
>

--00000000000069237d0642729a1f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 30, 2=
025 at 6:49=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berran=
ge@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">The gnutls_credentials_set() method has a=
 very suprising API contract<br>
that requires the caller to preserve the passed in credentials pointer<br>
for as long as the gnutls_session_t object is alive. QEMU is failing<br>
to ensure this happens.<br>
<br>
In QEMU the GNUTLS credentials object is owned by the QCryptoTLSCreds<br>
object instance while the GNUTLS session object is owned by the<br>
QCryptoTLSSession object instance. Their lifetimes are not guaranteed<br>
to be the same, though in most common usage the credentials will outlive<br=
>
the session. This is notably not the case, however, after the VNC server<br=
>
gained the ability to reload credentials on the fly with:<br>
<br>
=C2=A0 commit 1f08e3415120637cad7f540d9ceb4dba3136dbdd<br>
=C2=A0 Author: Zihao Chang &lt;<a href=3D"mailto:changzihao1@huawei.com" ta=
rget=3D"_blank">changzihao1@huawei.com</a>&gt;<br>
=C2=A0 Date:=C2=A0 =C2=A0Tue Mar 16 15:58:44 2021 +0800<br>
<br>
=C2=A0 =C2=A0 vnc: support reload x509 certificates for vnc<br>
<br>
If that is triggered while a VNC client is in the middle of performing<br>
a TLS handshake, we might hit a use-after-free.<br>
<br>
It is difficult to correct this problem because there&#39;s no way to deep-=
<br>
clone a GNUTLS credentials object, nor is it reference counted. Thus we<br>
introduce a QCryptoTLSCredsBox object whose only purpose is to add<br>
reference counting around the GNUTLS credentials object.<br>
<br>
The DH parameters set against a credentials object also have to be kept<br>
alive for as long as the credentials exist. So the box must also hold<br>
the DH parameters pointer.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:mar=
candre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0crypto/meson.build=C2=A0 =C2=A0|=C2=A0 =C2=A05 ++-<br>
=C2=A0crypto/tlscredsbox.c | 101 ++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0crypto/tlscredsbox.h |=C2=A0 46 ++++++++++++++++++++<br>
=C2=A03 files changed, 151 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100644 crypto/tlscredsbox.c<br>
=C2=A0create mode 100644 crypto/tlscredsbox.h<br>
<br>
diff --git a/crypto/meson.build b/crypto/meson.build<br>
index 735635de1f..1fc14b2a04 100644<br>
--- a/crypto/meson.build<br>
+++ b/crypto/meson.build<br>
@@ -25,7 +25,10 @@ crypto_ss.add(files(<br>
=C2=A0))<br>
<br>
=C2=A0if gnutls.found()<br>
-=C2=A0 crypto_ss.add(files(&#39;x509-utils.c&#39;))<br>
+=C2=A0 crypto_ss.add(files(<br>
+=C2=A0 =C2=A0 &#39;tlscredsbox.c&#39;,<br>
+=C2=A0 =C2=A0 &#39;x509-utils.c&#39;,<br>
+=C2=A0 ))<br>
=C2=A0endif<br>
<br>
=C2=A0if nettle.found()<br>
diff --git a/crypto/tlscredsbox.c b/crypto/tlscredsbox.c<br>
new file mode 100644<br>
index 0000000000..b8d9846af8<br>
--- /dev/null<br>
+++ b/crypto/tlscredsbox.c<br>
@@ -0,0 +1,101 @@<br>
+/*<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ *<br>
+ * QEMU crypto TLS credential support<br>
+ *<br>
+ * Copyright (c) 2025 Red Hat, Inc.<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;crypto/tlscredsbox.h&quot;<br>
+#include &quot;qemu/atomic.h&quot;<br>
+<br>
+<br>
+static QCryptoTLSCredsBox *<br>
+qcrypto_tls_creds_box_new_impl(int type, bool server)<br>
+{<br>
+=C2=A0 =C2=A0 QCryptoTLSCredsBox *credsbox =3D g_new0(QCryptoTLSCredsBox, =
1);<br>
+=C2=A0 =C2=A0 credsbox-&gt;ref =3D 1;<br>
+=C2=A0 =C2=A0 credsbox-&gt;server =3D server;<br>
+=C2=A0 =C2=A0 credsbox-&gt;type =3D type;<br>
+=C2=A0 =C2=A0 return credsbox;<br>
+}<br>
+<br>
+<br>
+QCryptoTLSCredsBox *<br>
+qcrypto_tls_creds_box_new_server(int type)<br>
+{<br>
+=C2=A0 =C2=A0 return qcrypto_tls_creds_box_new_impl(type, true);<br>
+}<br>
+<br>
+<br>
+QCryptoTLSCredsBox *<br>
+qcrypto_tls_creds_box_new_client(int type)<br>
+{<br>
+=C2=A0 =C2=A0 return qcrypto_tls_creds_box_new_impl(type, false);<br>
+}<br>
+<br>
+static void qcrypto_tls_creds_box_free(QCryptoTLSCredsBox *credsbox)<br>
+{<br>
+=C2=A0 =C2=A0 switch (credsbox-&gt;type) {<br>
+=C2=A0 =C2=A0 case GNUTLS_CRD_CERTIFICATE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (credsbox-&gt;data.cert) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_certificate_free_credenti=
als(credsbox-&gt;data.cert);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case GNUTLS_CRD_PSK:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (credsbox-&gt;server) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (credsbox-&gt;data.pskserver)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_psk_free_se=
rver_credentials(credsbox-&gt;data.pskserver);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (credsbox-&gt;data.pskclient)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_psk_free_cl=
ient_credentials(credsbox-&gt;data.pskclient);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case GNUTLS_CRD_ANON:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (credsbox-&gt;server) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (credsbox-&gt;data.anonserver=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_anon_free_s=
erver_credentials(credsbox-&gt;data.anonserver);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (credsbox-&gt;data.anonclient=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_anon_free_c=
lient_credentials(credsbox-&gt;data.anonclient);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (credsbox-&gt;dh_params) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_dh_params_deinit(credsbox-&gt;dh_params=
);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 g_free(credsbox);<br>
+}<br>
+<br>
+<br>
+void qcrypto_tls_creds_box_ref(QCryptoTLSCredsBox *credsbox)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t ref =3D qatomic_fetch_inc(&amp;credsbox-&gt;ref);<b=
r>
+=C2=A0 =C2=A0 /* Assert waaay before the integer overflows */<br>
+=C2=A0 =C2=A0 g_assert(ref &lt; INT_MAX);<br>
+}<br>
+<br>
+<br>
+void qcrypto_tls_creds_box_unref(QCryptoTLSCredsBox *credsbox)<br>
+{<br>
+=C2=A0 =C2=A0 if (!credsbox) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 g_assert(credsbox-&gt;ref &gt; 0);<br>
+<br>
+=C2=A0 =C2=A0 if (qatomic_fetch_dec(&amp;credsbox-&gt;ref) =3D=3D 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qcrypto_tls_creds_box_free(credsbox);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+}<br>
+<br>
diff --git a/crypto/tlscredsbox.h b/crypto/tlscredsbox.h<br>
new file mode 100644<br>
index 0000000000..5d89335f46<br>
--- /dev/null<br>
+++ b/crypto/tlscredsbox.h<br>
@@ -0,0 +1,46 @@<br>
+/*<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ *<br>
+ * QEMU crypto TLS credential support<br>
+ *<br>
+ * Copyright (c) 2025 Red Hat, Inc.<br>
+ */<br>
+<br>
+#ifndef QCRYPTO_TLSCREDS_BOX_H<br>
+#define QCRYPTO_TLSCREDS_BOX_H<br>
+<br>
+#include &quot;qom/object.h&quot;<br>
+<br>
+#ifdef CONFIG_GNUTLS<br>
+#include &lt;gnutls/gnutls.h&gt;<br>
+#endif<br>
+<br>
+typedef struct QCryptoTLSCredsBox QCryptoTLSCredsBox;<br>
+<br>
+struct QCryptoTLSCredsBox {<br>
+=C2=A0 =C2=A0 uint32_t ref;<br>
+=C2=A0 =C2=A0 bool server;<br>
+=C2=A0 =C2=A0 int type;<br>
+=C2=A0 =C2=A0 union {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *any;<br></blockquote><div><br></div><div=
>since any is used in code to cast the variant to a void *, it may be worth=
 a comment to say that all fields are expected to be pointers.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+#ifdef CONFIG_GNUTLS<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_anon_server_credentials_t anonserver;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_anon_client_credentials_t anonclient;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_psk_server_credentials_t pskserver;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_psk_client_credentials_t pskclient;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_certificate_credentials_t cert;<br>
+#endif<br>
+=C2=A0 =C2=A0 } data;<br>
+#ifdef CONFIG_GNUTLS<br>
+=C2=A0 =C2=A0 gnutls_dh_params_t dh_params;<br>
+#endif<br>
+};<br>
+<br>
+QCryptoTLSCredsBox *qcrypto_tls_creds_box_new_server(int type);<br>
+QCryptoTLSCredsBox *qcrypto_tls_creds_box_new_client(int type);<br>
+void qcrypto_tls_creds_box_ref(QCryptoTLSCredsBox *credsbox);<br>
+void qcrypto_tls_creds_box_unref(QCryptoTLSCredsBox *credsbox);<br>
+<br>
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoTLSCredsBox, qcrypto_tls_creds_box_un=
ref);<br>
+<br>
+#endif /* QCRYPTO_TLSCREDS_BOX_H */<br>
-- <br>
2.51.1<br>
<br>
</blockquote></div></div>

--00000000000069237d0642729a1f--



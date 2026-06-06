Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2D0CD8C8E
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 09:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVmsr-0004tP-I2; Sat, 06 Jun 2026 05:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wVmso-0004pq-Ug
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 04:59:58 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wVmsn-0006kt-5q
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 04:59:58 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4600cbb06deso1447688f8f.1
 for <qemu-devel@nongnu.org>; Sat, 06 Jun 2026 01:59:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780736394; cv=none;
 d=google.com; s=arc-20240605;
 b=RiKaPmp/XRj1NynGVUUw7oukl825v/9xM3uGG14PadxRdW/hanXJCHADZVCDNFmHaN
 Sh1rnbLdZ3vGqTl4ZwHQ4aTfDucmPJ9s2A6OivfiQ9fVIuhzn2p86VrBweTl3kYoPibL
 qJUx/2rv/aTjs5NJSYQW55eRbNN9tYxXy/6mvvwhL3etkTCN7Jb/hzdyylM7n21i/l6Z
 OFQs0a5EvZeO2tPLL3VHfKLm5xvJsMmPsDgL2d23KB9ZrV6ZaUujTNlyXerE0Wocnh+6
 peMlcfNhan2hdviZmTzxB4kFu6g4gRabrdF43bbtMTcVfrXXZeWBC/VM+FpvvTEJrAyh
 o67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hAg9NEVjHIVMK26SP8XaqIZhDvxJMkEq16+yEpZ5BNw=;
 fh=yFwpxU1smeIZGGIaW0nc2v+dGP4Vy/SMhT0yTeaSpMQ=;
 b=bsOr+l053jTsXwdRDpdIJ3XMO2i4GKy4RAopHWQ3kcgtfD/l+KPHgB91qkGOnauG1F
 Y+S1Kf2oQJkvmLXn7YKK3ekrb+8Koly0QTacaF6T2Gg4no8FG5M5Txd7+PrUvxuDP0SS
 +lO0LsgiaNxAKWn58Hjz6l0CfgL6XIzMigQNnmssQMdefQlzjI+CgPvqx7MjZ+sLhYRr
 1lyx9b6mfQ4GmedIdWNVwYwiiD1uaufLpNi2NEePwf9cPrBV6bqpXaty/v71rA7x8lni
 RO0o9Aslsx3eSQEhk0FNIZ6G2iIq1ybZG60QE+Z8wGCmFGjwlaLJA2SBxNX8mG698cKv
 Z5dQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780736394; x=1781341194; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hAg9NEVjHIVMK26SP8XaqIZhDvxJMkEq16+yEpZ5BNw=;
 b=cNccXNPPfTMLeOWBXEm8lTOVsp9yYFx4MhW0hsmpHDmEm261pSA3/G0Qbg3kfafZQt
 uQwGWszpO2yBojtCP2vyGsRmj+Hq75/9hgkwwf5BUKi095Nhg2fBuS21FAkfmLrDg/J0
 rJE88v234OWNRQr5+eaP0DPKRkMXpXsK2lIJjOGCgR367adCHskJ8SxCDlgfh6FWpyjP
 RPhDwQYR/0NUY1tgA02xjnyArxxqSV0s3vLz4tN+ub7ILe5wa/0uueYG6VS0XK0Mp7nR
 tUtTjPK71gbzUKcNFhVqqpKmC0VqneBvezbnRL+u1Naf/kL9cEzKLzC4Ut6Q3DTptrRG
 UOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780736394; x=1781341194;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hAg9NEVjHIVMK26SP8XaqIZhDvxJMkEq16+yEpZ5BNw=;
 b=sxH3+cEXZ1PgjoKj3XcQgdnbBrpNUPkhHBLD/PYwOXIfOT9YyBMHW2P+tjQWYPkvzd
 ehu4zLgQcN7mIsoh/FRKuPjXIMvem5ReTCojsbs8n18njjX00NDuRklNl9o1ID+/vhz9
 Re7q/KmDlhI9bdfnJTJAUGK964f44Tw/Xg0upSoLhkrp5d1O1nacbVXDfKF6HXg+IULn
 NxFzC7278BoimrJV75L+ebQKqgNR1SJflcegMpNTc7u99XWciSfMHgdlWLH6QEdTiyqs
 6IBHyDJiCX9Rx0k99SiJRuMKScR8qyj6432vw2feM4RYtRyFVX//z2P57PN1Hla3G+6C
 dZrg==
X-Gm-Message-State: AOJu0YxvqgU9+seFETgQ6z1WgIknGSe16YHDy8lhV5r3r6rIhpC7ogNG
 Prm40INbZPWn1xN3svA65CZ2rvRl6gPgTh+4Z/9rm7GBfCFkztN+4VakKA1QeMNJyjN8GzdIZy+
 j5FwiNsevIWx5QVTWfnYM1M2HRpPRIqfdZqKJVEAEDQ==
X-Gm-Gg: Acq92OHqUoE9DDN1dzYKQ4Qd/e7ENHddTMh2wvZcCq1XCEhWfcyvPBzjcqJ3DLRWBPG
 TwxswBnVaiI94TaBs+fL/nzPAy8m6eQLcQWcK+K8eMpmtU0+EHQGMyzHvCOUufSAIEKkHB4bsSN
 wdJaR1HglZCxqRALxAtv6ex7BLxIAJtOrPkyNxAe1EHyrG7IGEmUEfr7HKwCW7Q80psvmZPBHtH
 fCdnRsj7WpGTFWRxEGxOduQnbx1nhjOa324o1GrAGve50Yxxh3qpKMLsndVDJMPM+pvA7OOcE/V
 HyM614lVzP65F3eTR5NUmA9vbet2+A9gVlHKOGlqIcgEPkVHhEra/VvRmmU3rYfrChTNqvfcb8+
 M5+agZjlw+UZFgvoC2dBR
X-Received: by 2002:a05:6000:1aca:b0:45e:9520:d729 with SMTP id
 ffacd0b85a97d-460328109c5mr8782327f8f.0.1780736394072; Sat, 06 Jun 2026
 01:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260606074756.43804-1-lhestz@163.com>
 <20260606074756.43804-2-lhestz@163.com>
In-Reply-To: <20260606074756.43804-2-lhestz@163.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Sat, 6 Jun 2026 11:59:42 +0300
X-Gm-Features: AVVi8CcDIoAIffckj2wJRi9ZSjJJFZ14C9aqw36LnC7sCq5GbWbNRmphhsYkMD4
Message-ID: <CAAjaMXadn9e-T7OtHrq05rpx2QOF4Ac=2xukMrv6UGJKcsZN5Q@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio-crypto: enforce max akcipher key length
To: helei <lhestz@163.com>
Cc: "open list:ARM SMMU <qemu-arm@nongnu.org>, " <qemu-devel@nongnu.org>,
 Gonglei <arei.gonglei@huawei.com>, zhenwei.pi@linux.dev, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000352f5506539200a1"
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000352f5506539200a1
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Jun 2026, 10:52 helei, <lhestz@163.com> wrote:

> Introduce VIRTIO_CRYPTO_MAX_AKCIPHER_KEY_LEN. We set this hard
> limit to 1MB, which mirrors the linux kernel's internal payload
> restriction for the 'add_key' syscall.
>
> Signed-off-by: helei <lhestz@163.com>
> ---
>  hw/virtio/virtio-crypto.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> index 6fceb39681..06be93a0ac 100644
> --- a/hw/virtio/virtio-crypto.c
> +++ b/hw/virtio/virtio-crypto.c
> @@ -25,6 +25,13 @@
>  #include "system/cryptodev-vhost.h"
>
>  #define VIRTIO_CRYPTO_VM_VERSION 1
> +/*
> + * The virtio-crypto spec does not limit akcipher key lengths. To prevent
> + * guest-introduced OOM attacks via excessive host memory allocation, we
> + * enforce a 1MB limit. This aligns with the linux kernel's internal max
> + * payload limit for the add_key syscall.
> + */
> +#define VIRTIO_CRYPTO_MAX_AKCIPHER_KEY_LEN ((1024 * 1024) - 1)
>
>  typedef struct VirtIOCryptoSessionReq {
>      VirtIODevice *vdev;
> @@ -216,6 +223,12 @@ virtio_crypto_create_asym_session(VirtIOCrypto
> *vcrypto,
>          return -VIRTIO_CRYPTO_NOTSUPP;
>      }
>
> +    if (keylen > VIRTIO_CRYPTO_MAX_AKCIPHER_KEY_LEN) {
> +        error_report("virtio-crypto length of akcipher key is too large:
> %u",
> +                     keylen);
> +        return -VIRTIO_CRYPTO_ERR;
> +    }
> +
>      if (keylen) {
>          asym_info->key = g_malloc(keylen);
>

Unrelated to this patch, but this g_malloc could be g_try_malloc.

         if (iov_to_buf(iov, out_num, 0, asym_info->key, keylen) != keylen)
> {
> --
> 2.43.0
>
>
>

--000000000000352f5506539200a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, 6 Jun 2026, 10:52 helei,=
 &lt;<a href=3D"mailto:lhestz@163.com">lhestz@163.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">Introduce VIRTIO_CRYPT=
O_MAX_AKCIPHER_KEY_LEN. We set this hard<br>
limit to 1MB, which mirrors the linux kernel&#39;s internal payload<br>
restriction for the &#39;add_key&#39; syscall.<br>
<br>
Signed-off-by: helei &lt;<a href=3D"mailto:lhestz@163.com" target=3D"_blank=
" rel=3D"noreferrer">lhestz@163.com</a>&gt;<br>
---<br>
=C2=A0hw/virtio/virtio-crypto.c | 13 +++++++++++++<br>
=C2=A01 file changed, 13 insertions(+)<br>
<br>
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c<br>
index 6fceb39681..06be93a0ac 100644<br>
--- a/hw/virtio/virtio-crypto.c<br>
+++ b/hw/virtio/virtio-crypto.c<br>
@@ -25,6 +25,13 @@<br>
=C2=A0#include &quot;system/cryptodev-vhost.h&quot;<br>
<br>
=C2=A0#define VIRTIO_CRYPTO_VM_VERSION 1<br>
+/*<br>
+ * The virtio-crypto spec does not limit akcipher key lengths. To prevent<=
br>
+ * guest-introduced OOM attacks via excessive host memory allocation, we<b=
r>
+ * enforce a 1MB limit. This aligns with the linux kernel&#39;s internal m=
ax<br>
+ * payload limit for the add_key syscall.<br>
+ */<br>
+#define VIRTIO_CRYPTO_MAX_AKCIPHER_KEY_LEN ((1024 * 1024) - 1)<br>
<br>
=C2=A0typedef struct VirtIOCryptoSessionReq {<br>
=C2=A0 =C2=A0 =C2=A0VirtIODevice *vdev;<br>
@@ -216,6 +223,12 @@ virtio_crypto_create_asym_session(VirtIOCrypto *vcrypt=
o,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -VIRTIO_CRYPTO_NOTSUPP;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 if (keylen &gt; VIRTIO_CRYPTO_MAX_AKCIPHER_KEY_LEN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;virtio-crypto length of akc=
ipher key is too large: %u&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0keylen);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -VIRTIO_CRYPTO_ERR;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (keylen) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0asym_info-&gt;key =3D g_malloc(keylen);<b=
r></blockquote></div></div><div dir=3D"auto"></div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Unrelated to this patch, but this g_malloc could be g=
_try_malloc.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (iov_to_buf(iov, out_num, 0, asym_info=
-&gt;key, keylen) !=3D keylen) {<br>
-- <br>
2.43.0<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000352f5506539200a1--


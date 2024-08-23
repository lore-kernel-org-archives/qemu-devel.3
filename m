Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F215C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 17:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shXrr-0007oW-N5; Fri, 23 Aug 2024 13:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tiago.pasqualini@canonical.com>)
 id 1shXro-0007ns-Pv
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 13:14:29 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tiago.pasqualini@canonical.com>)
 id 1shXrZ-0004pq-1Z
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 13:14:28 -0400
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BF78D3F283
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 17:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1724433249;
 bh=6gRVofmJfaQ5jUH8YTLDpeoluzuFXNjMkrjbxoeuleM=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=DzzEiHFvXfyJTMhBEdUNCvzVa8owddhIR9Cx7nJuJbwn5rZS+WtRU1uXTFy34vggZ
 YQeWFs/uNWBqInyFmSHrxG76k8//WtNMh8PVkAWzdwLwAy5/viOyonCM37QtK+Ewf3
 eHESLqttrdnYKYYYmfg5Q+XfnFLbJUEZjQctZe1DZy1SJ74/I4xot03IbnoACbF89g
 OX79CfdMxA51zSN0WWeOu9j24EbrQjypWGCcHuUO43YnnWayY/4kAYxy8UKWkiV8ws
 6lcTiNrUI3lON+zX8tRBGNa4t5n8ZS7j1s/u3bY0TGUx2K6TpbK3+UJtEIlcBOFAm+
 JZ0ZXgtAbjwTA==
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-2701eeb69f4so2286038fac.3
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 10:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724433248; x=1725038048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6gRVofmJfaQ5jUH8YTLDpeoluzuFXNjMkrjbxoeuleM=;
 b=dHQ8G39gVQKcIa24rums6fN9pP7witEKwP8EBdxH2XppxaLVAw6lr9/iE29NkWdM1H
 nnMWmcodMf3XHnG9NBL8BSzZeQwedvnccdL9fHLd0BSVtEY3gCnn42OXCwqlh+yCTD6o
 zjKZ29zHUdUE79TkslzXJVoKWGBTAjJaGXX+80hTaFaJFqmL+r3HyEH2xP7GNbRDFX4y
 x/BgdZ6ZZpUlAVdbROeb0IoyfsAKdZrO6pHuLLKnaJmHxH4QGA1ja2cD6MJ1fBIEEvZa
 rcgKw7mzdQqvFVzdgltKuNTniqbeb1BKyKHI3Nyl890r5COQbNgwJF1ZJZgDf91PqQOv
 lAOw==
X-Gm-Message-State: AOJu0Yw5ecbTI9BOzQsnjr+43je6MPLhzajmsJw0zjf1oJRvXCDFXuAc
 /kHu+LX77fKU6+6iTiMyEhIEl2ZLvFZo2muczTcCw/L6EjA24aumG23SuyWBvHwWGoB6aXsFnhk
 M3VXqE7kliTKzgfU6jo1R/DW3EJWJUGIHhxqj3kbEDrlBFhWpjzohoJ1MaO7VCUeuBWgoFiR6Js
 8N2v/vRk+iCGkykB+FxNtuuZ+JttgzvM9vAaFFPKFAmzbufrbrH8gY9g==
X-Received: by 2002:a05:6870:d154:b0:270:1d05:1add with SMTP id
 586e51a60fabf-273e648bc72mr3276393fac.16.1724433248535; 
 Fri, 23 Aug 2024 10:14:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZIsxw8Ue8Tpa0X9wiK7+ck4SSlyrSc3npouJZEY0dD2fBUqO+rj4/EvCG2+J83Q/p11qHdcr2Jdbp2mqJv/Q=
X-Received: by 2002:a05:6870:d154:b0:270:1d05:1add with SMTP id
 586e51a60fabf-273e648bc72mr3276368fac.16.1724433248145; Fri, 23 Aug 2024
 10:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240813131928.842265-1-tiago.pasqualini@canonical.com>
In-Reply-To: <20240813131928.842265-1-tiago.pasqualini@canonical.com>
From: Tiago Pasqualini <tiago.pasqualini@canonical.com>
Date: Fri, 23 Aug 2024 14:13:57 -0300
Message-ID: <CABCXeQ1q5GR8rz2vh7ci3GSzU9UGnRzk3o0qk3fO7LUKVFmUfA@mail.gmail.com>
Subject: Re: [PATCH] crypto: run qcrypto_pbkdf2_count_iters in a new thread
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=tiago.pasqualini@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi folks,

Sorry for the ping, but any thoughts on this? I mainly implemented
what was discussed in the upstream bug[0].

Let me know what you think or any suggestions for this.

Thank you,
Tiago

[0] https://gitlab.com/qemu-project/qemu/-/issues/2398

On Tue, Aug 13, 2024 at 10:19=E2=80=AFAM Tiago Pasqualini
<tiago.pasqualini@canonical.com> wrote:
>
> CPU time accounting in the kernel has been demonstrated to have a
> sawtooth pattern[1][2]. This can cause the getrusage system call to
> not be as accurate as we are expecting, which can cause this calculation
> to stall.
>
> The kernel discussions shows that this inaccuracy happens when CPU time
> gets big enough, so this patch changes qcrypto_pbkdf2_count_iters to run
> in a fresh thread to avoid this inaccuracy. It also adds a sanity check
> to fail the process if CPU time is not accounted.
>
> [1] https://lore.kernel.org/lkml/159231011694.16989.16351419333851309713.=
tip-bot2@tip-bot2/
> [2] https://lore.kernel.org/lkml/20221226031010.4079885-1-maxing.lan@byte=
dance.com/t/#m1c7f2fdc0ea742776a70fd1aa2a2e414c437f534
>
> Resolves: #2398
> Signed-off-by: Tiago Pasqualini <tiago.pasqualini@canonical.com>
> ---
>  crypto/pbkdf.c         | 42 +++++++++++++++++++++++++++++++++++-------
>  include/crypto/pbkdf.h | 10 ++++++++++
>  2 files changed, 45 insertions(+), 7 deletions(-)
>
> diff --git a/crypto/pbkdf.c b/crypto/pbkdf.c
> index 8d198c152c..4c4e1e3cd3 100644
> --- a/crypto/pbkdf.c
> +++ b/crypto/pbkdf.c
> @@ -19,6 +19,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/thread.h"
>  #include "qapi/error.h"
>  #include "crypto/pbkdf.h"
>  #ifndef _WIN32
> @@ -85,12 +86,17 @@ static int qcrypto_pbkdf2_get_thread_cpu(unsigned lon=
g long *val_ms,
>  #endif
>  }
>
> -uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
> -                                    const uint8_t *key, size_t nkey,
> -                                    const uint8_t *salt, size_t nsalt,
> -                                    size_t nout,
> -                                    Error **errp)
> +static void *threaded_qcrypto_pbkdf2_count_iters(void *data)
>  {
> +    CountItersData *iters_data =3D (CountItersData *) data;
> +    QCryptoHashAlgorithm hash =3D iters_data->hash;
> +    const uint8_t *key =3D iters_data->key;
> +    size_t nkey =3D iters_data->nkey;
> +    const uint8_t *salt =3D iters_data->salt;
> +    size_t nsalt =3D iters_data->nsalt;
> +    size_t nout =3D iters_data->nout;
> +    Error **errp =3D iters_data->errp;
> +
>      uint64_t ret =3D -1;
>      g_autofree uint8_t *out =3D g_new(uint8_t, nout);
>      uint64_t iterations =3D (1 << 15);
> @@ -114,7 +120,10 @@ uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgor=
ithm hash,
>
>          delta_ms =3D end_ms - start_ms;
>
> -        if (delta_ms > 500) {
> +        if (delta_ms =3D=3D 0) { /* sanity check */
> +            error_setg(errp, "Unable to get accurate CPU usage");
> +            goto cleanup;
> +        } else if (delta_ms > 500) {
>              break;
>          } else if (delta_ms < 100) {
>              iterations =3D iterations * 10;
> @@ -129,5 +138,24 @@ uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgor=
ithm hash,
>
>   cleanup:
>      memset(out, 0, nout);
> -    return ret;
> +    iters_data->iterations =3D ret;
> +    return NULL;
> +}
> +
> +uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
> +                                    const uint8_t *key, size_t nkey,
> +                                    const uint8_t *salt, size_t nsalt,
> +                                    size_t nout,
> +                                    Error **errp)
> +{
> +    CountItersData data =3D {
> +        hash, key, nkey, salt, nsalt, nout, errp
> +    };
> +    QemuThread thread;
> +
> +    qemu_thread_create(&thread, "pbkdf2", threaded_qcrypto_pbkdf2_count_=
iters,
> +                       &data, QEMU_THREAD_JOINABLE);
> +    qemu_thread_join(&thread);
> +
> +    return data.iterations;
>  }
> diff --git a/include/crypto/pbkdf.h b/include/crypto/pbkdf.h
> index 2c31a44a27..b3757003e4 100644
> --- a/include/crypto/pbkdf.h
> +++ b/include/crypto/pbkdf.h
> @@ -153,4 +153,14 @@ uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgor=
ithm hash,
>                                      size_t nout,
>                                      Error **errp);
>
> +typedef struct CountItersData {
> +    QCryptoHashAlgorithm hash;
> +    const uint8_t *key;
> +    size_t nkey;
> +    const uint8_t *salt;
> +    size_t nsalt;
> +    size_t nout;
> +    Error **errp;
> +    uint64_t iterations;
> +} CountItersData;
>  #endif /* QCRYPTO_PBKDF_H */
> --
> 2.43.0
>


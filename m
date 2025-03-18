Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F64FC28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 17:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuaKF-00010N-RO; Tue, 18 Mar 2025 13:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tuaKD-0000z6-Dq; Tue, 18 Mar 2025 13:01:57 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tuaKB-0003zB-Mt; Tue, 18 Mar 2025 13:01:57 -0400
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7c0155af484so793156185a.0; 
 Tue, 18 Mar 2025 10:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742317313; x=1742922113; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iEYQR2alxfh8aOatpsc1zDDjo+LyU5e/r56fCvXVwgM=;
 b=SniDYv0wgouPnZMguHJe/BYpG7caO6yrFBt+p7wnz7Dee+Vg/VWmF/3g1lAMBzQ9O7
 h7nhHfpH2iMMIi2+kPt3aWm0juBWtSFwsdiEQk3Lh+lXquNeBs1YzhwdZIyj+zBEADBv
 hh5F/Kl1CJXeMibnsfiFXQcdqstsUMXtcLOK1KSqW7rkxfZ29iSd7hcOF7N6Xcw8EWJc
 0Xit4KXllLQq1L6R+DGRbBVUxvrPDDRZncNS+oerDQukdeOwMfLqdqtT9181JXF5yzRR
 dVrKkoJ4Lhz29MMow8L95XbbaizAFniDdSdnbRp0NjqmDWB3MyxgpukvJOQWGihQbrQ/
 7Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742317313; x=1742922113;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iEYQR2alxfh8aOatpsc1zDDjo+LyU5e/r56fCvXVwgM=;
 b=TUXDKGiyMXestxdjQtg1YUakPMLelF5KOExiMfZuehzLcLAHMpbP1MD7GDGslKEyfk
 tm3eN6Q79cAEGBUXKndTbzumsyRDrNLapmrRWrCnV4WewFn2FjuKACLl78U+nuLnvp5O
 SzuDEw8YWJQ7AiJ7b6dV6d1DVGIvbJ6kzOOYx0sXcKpWiaUyyf1ezS8sy+uTt+LkYWHA
 ab4seTyPDp1KM4mULCsGWJ9xzVIBNy+OGKot+ItvAINxezQeDRZyzgJcjXtogZv8OcP7
 b5cQHBz79pHjEKg3C/DHgznnMhEt2QFDclozhd15TrpjI0w2DyTst7AQrXnB31wjbW8U
 DIKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVspF2dH6NK6yPs3OCZF1w+DS9ABh+mPzxXkPeL4y8B3Sj6IhyEF3VlMMYWdSaFJRSnadhnBTv0aCjGRQ==@nongnu.org,
 AJvYcCWP+wqRxcZnZNiydAlkiebkOD+xBs0PIJ5EUKhBXGtG5jEUUGrosnnQjZA0j6FZRs18lHYFfO2ZSfJJHnc=@nongnu.org,
 AJvYcCXS9mVjhj88oNN5wj8clSp6+d64KoWMcQtR7PVr53zUy8bLF3tWUCNrNYaArLRkWLNblWqY+Kgn/559@nongnu.org
X-Gm-Message-State: AOJu0YxqAGn17EmDN7NP1XIj2mrvghwwiwX8KVP5o8eQQGg7/4jf6nlx
 3IppUx+jKjg5FDnGPD5uVUUjSHa8Ehd9r2HkNhK9tGkD+2EYU33s1PNQdrzjUuaXxR1jd5z26cA
 M/sZnB5QGkzQUg7TTOQd0Xv4R4To=
X-Gm-Gg: ASbGncv8+upM/C0WJOczXrqtD3Xo5NeprTJk0UmpRuZxQwTtZtZISoWMvzYf7Tx4wte
 knZ/t2hc4Zy5Fq5ZB20XSqpzbBBaK2slHmfovXz3C2FQd/k5oazfEz7qDwPapMr4xSIn0i62Owi
 zuf9Btz2v22qATf6a0/yrdzvrk9zY=
X-Google-Smtp-Source: AGHT+IFZQudw2+iPK01zte8tKWK/sHddZHEx6/UTRWUL3IPrr3hh75eoPLto0HP3LYNW5HuSKYZsvgkJiLp4UGV2WqM=
X-Received: by 2002:a05:620a:45ac:b0:7c5:5883:8fb3 with SMTP id
 af79cd13be357-7c57c79bb70mr3145781285a.8.1742317312631; Tue, 18 Mar 2025
 10:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240909141635.1459701-1-berrange@redhat.com>
 <20240909141635.1459701-11-berrange@redhat.com>
 <CAFEAcA_xCa4NjyDt6M+n6KdXTUWRfdSkymW-AqupXRQC97DKcQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_xCa4NjyDt6M+n6KdXTUWRfdSkymW-AqupXRQC97DKcQ@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Tue, 18 Mar 2025 23:01:40 +0600
X-Gm-Features: AQ5f1JqHUDkYFqBvIfDFveYVb2zzFGsnTbc_VxJYN2URzn9W45KU4V1Dbohw9-w
Message-ID: <CAFfO_h6ANSUP_Y3UTFOf3RPGk0s5VPiqoFpy47sDrCnJgrwvfA@mail.gmail.com>
Subject: Re: [PULL 10/10] crypto: Introduce x509 utils
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Hyman Huang <yong.huang@smartx.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=dorjoychy111@gmail.com; helo=mail-qk1-x735.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Mar 18, 2025 at 10:44=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Mon, 9 Sept 2024 at 15:21, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
> >
> > From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> >
> > An utility function for getting fingerprint from X.509 certificate
> > has been introduced. Implementation only provided using gnutls.
>
> Hi; recent changes in the codebase mean that one of Coverity's
> "maybe this needs an error check" heuristics is now triggering
> for this code (CID 1593155):
>
> > +int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
> > +                                      QCryptoHashAlgorithm alg,
> > +                                      uint8_t *result,
> > +                                      size_t *resultlen,
> > +                                      Error **errp)
> > +{
> > +    int ret =3D -1;
> > +    int hlen;
> > +    gnutls_x509_crt_t crt;
> > +    gnutls_datum_t datum =3D {.data =3D cert, .size =3D size};
> > +
> > +    if (alg >=3D G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
> > +        error_setg(errp, "Unknown hash algorithm");
> > +        return -1;
> > +    }
> > +
> > +    if (result =3D=3D NULL) {
> > +        error_setg(errp, "No valid buffer given");
> > +        return -1;
> > +    }
> > +
> > +    gnutls_x509_crt_init(&crt);
>
> gnutls_x509_crt_init() can fail and return a negative value
> on error -- should we be checking for and handling this
> error case ?
>

Yes, I think so. It should be probably something like below:

if (gnutls_x509_crt_init(&crt) < 0) {
    error_setg(errp, "Failed to initialize certificate");
    return -1;
}


Regards,
Dorjoy


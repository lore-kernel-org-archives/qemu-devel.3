Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDA7CCFA05
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 09:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vF8AA-0007Ch-MF; Sat, 01 Nov 2025 05:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vF8A9-0007CX-34
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 05:44:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vF8A6-0007WD-Af
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 05:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761990279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kpOtaeIZNcJL5kmOh3wl+Ar0MA7XT8qNot8dtNuG9yQ=;
 b=cPBdsqNY9qQ/5a3qIwCupxMf2d2AddacXEz5oIh4D41GmwQy/1MdiT34HmhyxInOE5gqEy
 vCjlvhjgQHBkzaCUupixwsDb0vAOBjUNRgOEMun7dEHr+3EDBHTXJHgmllpBnoRdFwHNcG
 +qFdf2FvWJ6LbcBMXhcNZSksqhqFm3E=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-D15NtBT7M-yzLH9oiTnLRA-1; Sat, 01 Nov 2025 05:44:38 -0400
X-MC-Unique: D15NtBT7M-yzLH9oiTnLRA-1
X-Mimecast-MFC-AGG-ID: D15NtBT7M-yzLH9oiTnLRA_1761990277
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-286a252bfbfso72450395ad.3
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 02:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1761990277; x=1762595077; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kpOtaeIZNcJL5kmOh3wl+Ar0MA7XT8qNot8dtNuG9yQ=;
 b=jClKS+IM9hO5dn0OS6JIfh/13EuDOtt6IKqf5UI8wWSSjgeFGo0ClNPVxgb/B9DqZ8
 J2XLB0enfhEqulxQJXcXgNPimJm8I0r35+ksiLBZkzJ8KqjsPTK7rb9o46TbxBjkqejJ
 QlR1q+LdJMAGKidX8d/MlpP/12v1ZYFw4nXKBN+QoSebUHfSeH8yXky6P3TlmL2nUrqw
 nWW1WgsqF9JHy5EREer0BDUHDpedKIpkb+SwlyyqZaQAZ7Jq/bYfrL+CurcdU9QftOxc
 7gZ4vUPn/aJf9b7Re/LbSfpM5KjYLAv7l312yRuzKqtYh3ltlfOFJuoXmYXzW5Hdb1AV
 Ml5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761990277; x=1762595077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kpOtaeIZNcJL5kmOh3wl+Ar0MA7XT8qNot8dtNuG9yQ=;
 b=tD1rFAmEBLl1RoC1HZbXC+UCMYIV0EO3NWLm62P9T40y1gPLxQRKnKkmN34HeMkVZB
 VpzvXmpc4JgNDOX6OGZrZR4vkZFg4xmQq61+a5tdGvU9C9LAyGkEXmjV+X/4m3yEzr8t
 Kj5XQC28QzEjflv7ySwYNuWOQ/3VadHNBTzRgmMrDvBX0QxSnZ6c9+EqJ/er7c6oVomm
 /X8/WgsYuxA1KYyuaTlFYTbOVk75Q5xGDdNfhixJN9LKf3r3h1URJ4y8cHVtG5qVyoTj
 dioFUty4ljK9h3jiUnyImsy/e/0HAwo0RQK0Lmp4bfSESVN+6kqFFZojfZnfxrYcKRnm
 Wvew==
X-Gm-Message-State: AOJu0YwQkC8blu9L3k7GroNLkcvncjrBOyeFgewn3dSh8QRez/fFiAJo
 ehhwzCetGhpETbL9qsqZiHohwH+ks7OL2W/AAVXHczxCUNfwe4FhgCTFM1+Cg2r3bUBRkwSBiMM
 +oSt2Uwft0IwvLIJINRqilH3/0lmP5RgE4vtWXDVPDOWKA+AaMjSRH6uZrhNJOPZIqopZoMLUQs
 ftIe9xhXtOSBMywZo7xGLen7F6VjmPP0I=
X-Gm-Gg: ASbGncs5t5e4z6DDXMpaouPlppWx4p22w80lu11h7hlDr97e/PyGVqXiE/MjPvLZUsv
 Y+WT4VQOniVRhHE2Xf/jNBwSiLwPLBNRQAD4q0H7+bnW7rM2x2Af6CG8anKjJ9O8rzKzOzxwnsL
 eFendBia7qJAeSx/4VZndzwWZ2z8fZy9Tr1zXkoVE1WLedqUj00jXW2yUYbSWSIg==
X-Received: by 2002:a17:902:cf0e:b0:295:592f:94a3 with SMTP id
 d9443c01a7336-295592f95ddmr15866845ad.48.1761990277071; 
 Sat, 01 Nov 2025 02:44:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEgNDcrkSinbEx7vZjxd7dgAavPwmy8y7lzKIy0YMt+6AqFEtEqodKJ568sf7VmRES918M2+KVrg4OSVfQKUo=
X-Received: by 2002:a17:902:cf0e:b0:295:592f:94a3 with SMTP id
 d9443c01a7336-295592f95ddmr15866665ad.48.1761990276744; Sat, 01 Nov 2025
 02:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20251031153056.296078-1-berrange@redhat.com>
In-Reply-To: <20251031153056.296078-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 1 Nov 2025 13:44:24 +0400
X-Gm-Features: AWmQ_bm-Z_CnVD_nQ5TvSLWUUMCrYcWNbeJsrtmi139LPRh6mpDg1oudXzd3OfY
Message-ID: <CAMxuvaxZkz5Q_Bg+n4FPN-K9BLqOsH0h2zfZVXsDKvn3Z73yHQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Bump min versions of crypto libs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008b1ee606428554e7"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
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

--0000000000008b1ee606428554e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Oct 31, 2025 at 7:31=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> gnutls, libgcrypt and nettle can all have their min versions increased
> based on our platform support matrix, enabling various bits of compat
> logic to be dropped, as well as eliminating the last usage of in-tree
> XTS code.
>
> Daniel P. Berrang=C3=A9 (5):
>   crypto: bump min gnutls to 3.7.5
>   crypto: unconditionally enable gnutls XTS support
>   crypto: bump min libgcrypt to 1.9.4
>   crypto: bump min nettle to 3.7.3
>   crypto: drop in-tree XTS cipher mode impl
>

Series
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>
>  crypto/cipher-gnutls.c.inc     |   8 -
>  crypto/cipher-nettle.c.inc     |  44 ---
>  crypto/cipher.c                |   2 +-
>  crypto/meson.build             |   5 +-
>  crypto/xts.c                   | 250 ----------------
>  include/crypto/xts.h           |  82 -----
>  meson.build                    |  69 +----
>  tests/unit/meson.build         |   3 -
>  tests/unit/test-crypto-block.c |   3 +-
>  tests/unit/test-crypto-xts.c   | 529 ---------------------------------
>  10 files changed, 9 insertions(+), 986 deletions(-)
>  delete mode 100644 crypto/xts.c
>  delete mode 100644 include/crypto/xts.h
>  delete mode 100644 tests/unit/test-crypto-xts.c
>
> --
> 2.51.1
>
>

--0000000000008b1ee606428554e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 31, 2025 at 7:31=
=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.c=
om">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">gnutls, libgcrypt and nettle can all have their min =
versions increased<br>
based on our platform support matrix, enabling various bits of compat<br>
logic to be dropped, as well as eliminating the last usage of in-tree<br>
XTS code.<br>
<br>
Daniel P. Berrang=C3=A9 (5):<br>
=C2=A0 crypto: bump min gnutls to 3.7.5<br>
=C2=A0 crypto: unconditionally enable gnutls XTS support<br>
=C2=A0 crypto: bump min libgcrypt to 1.9.4<br>
=C2=A0 crypto: bump min nettle to 3.7.3<br>
=C2=A0 crypto: drop in-tree XTS cipher mode impl<br></blockquote><div><br><=
/div><div>Series</div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=
=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0crypto/cipher-gnutls.c.inc=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 -<br>
=C2=A0crypto/cipher-nettle.c.inc=C2=A0 =C2=A0 =C2=A0|=C2=A0 44 ---<br>
=C2=A0crypto/cipher.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0crypto/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A05 +-<br>
=C2=A0crypto/xts.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 250 ----------------<br>
=C2=A0include/crypto/xts.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
82 -----<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 69 +----<br>
=C2=A0tests/unit/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A03 -<br>
=C2=A0tests/unit/test-crypto-block.c |=C2=A0 =C2=A03 +-<br>
=C2=A0tests/unit/test-crypto-xts.c=C2=A0 =C2=A0| 529 ----------------------=
-----------<br>
=C2=A010 files changed, 9 insertions(+), 986 deletions(-)<br>
=C2=A0delete mode 100644 crypto/xts.c<br>
=C2=A0delete mode 100644 include/crypto/xts.h<br>
=C2=A0delete mode 100644 tests/unit/test-crypto-xts.c<br>
<br>
-- <br>
2.51.1<br>
<br>
</blockquote></div></div>

--0000000000008b1ee606428554e7--



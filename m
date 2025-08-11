Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1884CA0EC4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 20:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulZPE-0000hJ-DN; Mon, 11 Aug 2025 16:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ulZPC-0000b4-9q; Mon, 11 Aug 2025 16:46:06 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ulZP4-0007ng-Rj; Mon, 11 Aug 2025 16:46:05 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-61813e2fc73so3729610a12.0; 
 Mon, 11 Aug 2025 13:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754945149; x=1755549949; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tLfl/wDNQKUH1jBMtnf+lOEzYOlhTB6w+Ki1awZSPm4=;
 b=hjsVYZCmSNnNWG0JSZPs9g0yCX7YKLHpPlDaTp0yATnmqXGyYDV9IL2VubmlVz10nh
 KfQAi4PdtoQ8VAURljisIPxBKvjtuqcDaBq6IFOVw/pBxiEmuQZjlav+TVfm6bTUAxb4
 fkIe7VprCsjR0lQQD58IszWyw1ExeUh2xiEhBcuTDx2JXytTRQQVzfeVQCZK3u7nom5y
 ochqjcng323xqfiCjRAU8JMEC3OSt0Z5OvmY6HpamZiR6GmZ6PDm5lJf+JJ6ZBx0Jo6E
 v++0rHpH6DA+UdEFvc9DCYNatcuD3SjfosvsdcrzNsJ2Bx76IB79Hkb+61e/YHZ2Na6z
 Lc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754945149; x=1755549949;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tLfl/wDNQKUH1jBMtnf+lOEzYOlhTB6w+Ki1awZSPm4=;
 b=FhSawV+6AOoaQZ417Wzu/d4XuSygCB8eIGVo8E+x/z5H3It6kkdxDsjQRjikexGHMR
 OkCDl1NzvmepfghD09l/Rye4uV6ewWbEG0ubWNDMsL0T6vPKiYjSljkP2KQqWy00c3SL
 lO/Gw26xE3jDugyaNWd94Godj+1144zpizeK81T+qnk56CAPrFDGrWjS4ULkXXht2dF+
 Y26q6T6OYVEExOlQjk7QxQYXnFnNnnmdCaOHw/7rx8LbQ3RdkGv1GTWorF2aF57RSN6O
 n7vXhffHr/IFfpRRNMY5J76Md2Xwg9KYl8d8XP8rvoIp55+qkbtMl2+XL+57G0KkKQDq
 QWhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkHCzj8bfAopbb1EL6+e5on98hAAYU2RM4WKVx1pItbj+dgoVCdlbzgugXYQ6VaDTQz6fygG+flA==@nongnu.org
X-Gm-Message-State: AOJu0YzzsEYCrBnGgWNnKbt1R1p11V4Xt96Wq7SHvN78/Unkz+QZIk1y
 5eAn/I3ulvAqAqN38xlpZ9ceya4kfRZS32pBa7vviPvz1AbdNfcDXc/+L/pqDe9xd6PdUFvo0xC
 18VyO4Fj3iPs4sXUKA6DaZp38Sf9KV08=
X-Gm-Gg: ASbGnctcPoV3lO2pYnl6YB0o7Eiz3pw6Q9xXs21qHRQDPlFI5OfMaaTUqHKtR9InP/E
 cfGnnnzxv+SvbjT6pyCRiDHnCiUh6G4paZfEosWLtLbV3uW46Mk6aiicohlMFEAxbC8iIwFHpFa
 AW7kQqcratYpJjC2+ibRex6NIEhzwRnD67gp6A8KzLQUdxaJEQnUn4ZG1Qtd4RQ+5LRO9NA6ZSa
 kN35g==
X-Google-Smtp-Source: AGHT+IG3R/VcNlv5Ekuq1OKa3qi/RIq/2YfFZ87ucDKX5aohcviFjAmUmPyLrAhBfsHIZgq/6ut4mFLvRoX5bTNnmiM=
X-Received: by 2002:a05:6402:3489:b0:618:1554:a6bc with SMTP id
 4fb4d7f45d1cf-6184ea115e5mr561669a12.3.1754945148990; Mon, 11 Aug 2025
 13:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250811162315.59997-1-stefanha@redhat.com>
In-Reply-To: <20250811162315.59997-1-stefanha@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 11 Aug 2025 16:45:37 -0400
X-Gm-Features: Ac12FXwryuHCHbB-O7WJH1_qES1xALMDX9i37hw-nbc20S53ufvhrQGVwT7OAso
Message-ID: <CAJSP0QUYLbBuk+Kc-Y3K9sC6GmutBcQ-Rbrxd7dbO2RcCkz9TQ@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: fix URLs in PCI hotplug test for aarch64
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>,
 qemu-arm@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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

On Mon, Aug 11, 2025 at 12:24=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> Debian trixie has been released. The "stable" alias no longer refers to
> the Debian bookworm release, so URLs referring to bookworm artifacts via
> the "stable" alias no longer work.
>
> Switch to explicit release naming ("bookworm") to make a permalink so
> the test passes again.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 374a245573b8 ("tests/functional: Add PCI hotplug test for aarch64"=
)
> Resolves: #3073 ("PCI hotplug test for aarch64 fails due to broken Debian=
 installer URL")
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/functional/test_aarch64_hotplug_pci.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to master.

>
> diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functio=
nal/test_aarch64_hotplug_pci.py
> index c9bb7f1d97..0c67991b89 100755
> --- a/tests/functional/test_aarch64_hotplug_pci.py
> +++ b/tests/functional/test_aarch64_hotplug_pci.py
> @@ -15,12 +15,12 @@
>  class HotplugPCI(LinuxKernelTest):
>
>      ASSET_KERNEL =3D Asset(
> -        ('https://ftp.debian.org/debian/dists/stable/main/installer-arm6=
4/'
> +        ('https://ftp.debian.org/debian/dists/bookworm/main/installer-ar=
m64/'
>           '20230607+deb12u11/images/netboot/debian-installer/arm64/linux'=
),
>           'd92a60392ce1e379ca198a1a820899f8f0d39a62d047c41ab79492f81541a9=
d9')
>
>      ASSET_INITRD =3D Asset(
> -        ('https://ftp.debian.org/debian/dists/stable/main/installer-arm6=
4/'
> +        ('https://ftp.debian.org/debian/dists/bookworm/main/installer-ar=
m64/'
>           '20230607+deb12u11/images/netboot/debian-installer/arm64/initrd=
.gz'),
>           '9f817f76951f3237bca8216bee35267bfb826815687f4b2fcdd5e6c2a91779=
0c')
>
> --
> 2.50.1
>
>


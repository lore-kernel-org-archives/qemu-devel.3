Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B6CCCF9E5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 03:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEJkJ-0003qh-Sl; Wed, 29 Oct 2025 23:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEJkH-0003qR-UI
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 23:54:41 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEJkA-0001uH-Gl
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 23:54:41 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b6d5e04e0d3so112459166b.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 20:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761796469; x=1762401269; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ShhX2sq8w0jra+/cwSABqLGKI00lTmVW+K0qPlS9gpc=;
 b=aWpqgq37W0RWdX4zrPBDkmiTvkpsKrPqrV2ARbSkopxB80EyuyOWU/AXLVokxrOX8Z
 Xx2qLxCX/bniDjsuTpIweLeGS+MHJ47jr0aYdhStTCQAxTHawGc8WbCLf0ICJhehcjpV
 EbGnghOCah17D9WH/vJzQ0FS1o/Yxce0ZYGj8clgZcGfIZ3OzwodEDfqjW/uHpL4N/2F
 crg/7M5bNpDU1WyvyUysPK8QfAGpVb5go2Q1uefdhxqOhLcitvTrgp22++lrYZW7NdR2
 u991AenrfLedwYJKZ6N/T+iXY+yOsg0lISuVXGxq2EzLX+JZuy8pVv0FmJHu8f+7gKl8
 xhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761796469; x=1762401269;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ShhX2sq8w0jra+/cwSABqLGKI00lTmVW+K0qPlS9gpc=;
 b=t4OXOw6YNg+4okL2+eLazijIg9hDL9dGk2IdTD1DAOV+2milPoEOMBlKEpa047dyFQ
 kcNcFwpqCm6mgVfkTOhh8rE0hOccGXGM/P89du/VK3+sW/II3KzKPs6LOAJkAX6sCZQR
 EpDMBdNilktbzej2kkVbV0EK62uAy+fiFRYNTN+wNfM4dgStYKxY/w99ZJVEVHjyvi1E
 m90Twq++iz+x2AtiD+YgfxGmGJWaIsS72cWuXHnpAExwnSjZ/BRi6HGbkapAFCrXnIUb
 dUND3KAQWl9XH1dYvu8TZUHdd/9lwBQUc5gWUbCyqlZiZC20WADgs+uAu6xQ6WmTCg4f
 vYkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPi0S4XhuvtMB3jaxltzl/ekI/sW58zeW3BMJK8m9A7izzXvx8RIkJeQUD2pyaFrMSfnGeyI52mE+q@nongnu.org
X-Gm-Message-State: AOJu0YwCvnpe6o+Rxr9f6/bRIS8LgOvlecdxih3eQ6TsBfwL2AA/8WYD
 tAO+wV4EVghfpmSsnAL7LI9/W3Z++bYgSY9D5Q3hwTqy2S/tM7segEKDRkfxbs2oWjAKkgwfS1E
 Unb1rHV25+hUjCg4tOTpBWJMNg2gnvco=
X-Gm-Gg: ASbGncvQCxwNxOnnlYN6w08sixmtH3ZlngjDX86DR+3SuPEP0rREHhi6WlCjiQelFYp
 j4R81Mtq4/IYYWc1heR6UY5G0TsvaV1qcvnCrRhCt0BaAKBvqytl5m2ZJLgtZhXWWY4Eq0JSjd4
 b4i0cjEFU6K53OX3m1a1fzPuR/lD+zeG0SiRvz5zeRLMe1T8WXpoa+j3uAQKNa1sf61QxtEiuMe
 PHzCgAvFsDjeeC9OTIynJIkSIWWTykKcmTZ/pZ/CLl1e9fRkk7RBx4LumIrBbr4m4+/pfWmSnnT
 T3osHTV+5AZcrYgAmyAcwHgJJg==
X-Google-Smtp-Source: AGHT+IEVzwwuEq6W73TsIxQezOqgHTGs5u0J2r+slRqJsOBoanfs09MaPfcFA6mPRThPbfK/dpkwDF8omSUgGyzqPEk=
X-Received: by 2002:a17:907:807:b0:b40:33ec:51ea with SMTP id
 a640c23a62f3a-b703d2ccff4mr431597966b.6.1761796468464; Wed, 29 Oct 2025
 20:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20251027112803.54564-1-thuth@redhat.com>
In-Reply-To: <20251027112803.54564-1-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 30 Oct 2025 13:54:02 +1000
X-Gm-Features: AWmQ_bn3zCGMMx2DLtnwzeAGLNhss0rkRyCVm5pa2wMHZNJXz5YZEBTYC6G_DiI
Message-ID: <CAKmqyKNnUNBmGsO1x-G=fFgOOZ3bNbKV2yNO6PZ-qExfWvcR9A@mail.gmail.com>
Subject: Re: [PATCH] tests/functional/riscv64/test_sifive_u: Remove unused
 import statement
To: Thomas Huth <thuth@redhat.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Oct 27, 2025 at 9:29=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> From: Thomas Huth <thuth@redhat.com>
>
> skipIfMissingCommands is not used here, remove the import to silence
> a pylint warning for this file.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/functional/riscv64/test_sifive_u.py | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tests/functional/riscv64/test_sifive_u.py b/tests/functional=
/riscv64/test_sifive_u.py
> index 358ff0d1f60..847f709da12 100755
> --- a/tests/functional/riscv64/test_sifive_u.py
> +++ b/tests/functional/riscv64/test_sifive_u.py
> @@ -13,7 +13,6 @@
>  import os
>
>  from qemu_test import Asset, LinuxKernelTest
> -from qemu_test import skipIfMissingCommands
>
>
>  class SifiveU(LinuxKernelTest):
> --
> 2.51.0
>
>


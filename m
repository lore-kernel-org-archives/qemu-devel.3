Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B9AC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 16:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYTOR-0006pn-9h; Fri, 09 Feb 2024 11:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYTOK-0006pR-Ge
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 11:06:16 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYTOH-0007Am-M5
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 11:06:15 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5610cc8cc1aso1267258a12.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 08:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707494771; x=1708099571; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mg5RFUOUe7RalfkyKcnfi0VZ1gLs9xSMYE3MEXz1jp8=;
 b=fQMoKfNmIWHkATWmwzXq6ZTXMI+9CxGpkfurPejeVY4SdnUJZTw+lZYGIFuWj4UpM1
 zvFxafv2CAGnmZMTp4SPphJfqnPLv8BFeFCEyNSPhvVUQ7qhcJQubuh2EF3E5dZQXpT+
 cowbzcIjBKK+J79ZxHB02t1z4YI3jUhoQNvo1v7QiMWcloBeV1b+csBEg9Gfb2+1F6LJ
 PeceBIj8IzkbK0/GWUtop3418FjX0OenqXyTKPPK1gzUQgLGdP9OoWHwakoqkrHSoDVV
 6XSEHkcJeAQn6Z1jpZ7jZWSGkubgfZeqCyjZ9wj6BqtoqDVCLo/L/cdt4mb1DmiR52r4
 og1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707494771; x=1708099571;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mg5RFUOUe7RalfkyKcnfi0VZ1gLs9xSMYE3MEXz1jp8=;
 b=wjZM0QkCHhMfg9cjhVkQxsdT/NJUtjYg0XHkgspSGiyvex3sl72++dZCc1WVXef7nH
 6/X3PbgquVQ0WvvNjtdSBTKGFRbpzxaKOgV/BPCwm19OMj/v/RKKX3nKrcQqM67pjO5e
 p6vXeTFrUJtQrj7038Mm6NuVCuhhJGTUEC+hhSMreAu2JwFFwR9sCh+jrrJGnQv6M+zJ
 xSUKeEXjBHIxHpB/1ucDfMrLbvyGHBjCnhhucfur1VXrD96vmFEbFe0VgY7Jt2dLETfh
 07kl6cSrPHZwGLVSqH72tsAnkXLyitT7mXCDki+OZoMGw9q+7BYjI2z1iVG5HPEXM2IQ
 hrhg==
X-Gm-Message-State: AOJu0Yxi5xsYAWhy/M3IMQyjuSuqtjQ3Fl871bYi4UeG0Z9VNgE9Z5w6
 A557UCgvcTRimMtjGFmpSb5T7elmpDLDjSZUJNCqRkLxSTV2SFB0yPQZ0TAuompcs9euVWpOyWo
 LZS3FT5/cdUV3n0X9lFPyrna3UL4R+iXHcEJhfw==
X-Google-Smtp-Source: AGHT+IGHTe8170YhYTSF6boEZhlvI+Dnd1iLSqveqoyRCbU/AHrHT5cTXaW7wzqAedohF5BZnF2ecdQaVD4iLKHrZkI=
X-Received: by 2002:aa7:c653:0:b0:560:b488:d9bd with SMTP id
 z19-20020aa7c653000000b00560b488d9bdmr1531881edr.8.1707494771656; Fri, 09 Feb
 2024 08:06:11 -0800 (PST)
MIME-Version: 1.0
References: <20240209150039.22211-1-philmd@linaro.org>
 <20240209150039.22211-4-philmd@linaro.org>
In-Reply-To: <20240209150039.22211-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Feb 2024 16:06:00 +0000
Message-ID: <CAFEAcA9+6aK_uPa6tFV2-yh3g_2oeuvFaOs=nd=2dexm=uxN9Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] system/physmem: Assign global system I/O Memory to
 machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Peter Xu <peterx@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 9 Feb 2024 at 15:01, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> So far there is only one system I/O and one system
> memory per machine.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  system/physmem.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/system/physmem.c b/system/physmem.c
> index 5e66d9ae36..50947a374e 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2554,12 +2554,13 @@ static void memory_map_init(void)
>  {
>      system_memory =3D g_malloc(sizeof(*system_memory));
>
> -    memory_region_init(system_memory, NULL, "system", UINT64_MAX);
> +    memory_region_init(system_memory, OBJECT(current_machine),
> +                       "system", UINT64_MAX);
>      address_space_init(&address_space_memory, system_memory, "memory");
>
>      system_io =3D g_malloc(sizeof(*system_io));
> -    memory_region_init_io(system_io, NULL, &unassigned_io_ops, NULL, "io=
",
> -                          65536);
> +    memory_region_init_io(system_io, OBJECT(current_machine),
> +                          &unassigned_io_ops, NULL, "io", 65535);
>      address_space_init(&address_space_io, system_io, "I/O");
>  }

What's the intention in doing this? What does it change?

It seems to be OK to pass a non-Device owner in for
memory_region_init() (whereas it is *not* OK to do that
for memory_region_init_ram()), but this seems to be
getting a bit tricky.

thanks
-- PMM


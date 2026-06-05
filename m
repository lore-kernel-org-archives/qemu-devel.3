Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668DBCD6E6E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 00:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVIM3-0004im-6e; Thu, 04 Jun 2026 20:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wVIM1-0004ie-Mt
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 20:24:05 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wVILz-0001J0-TU
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 20:24:05 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bec405a6ea5so190800266b.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 17:24:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780619041; cv=none;
 d=google.com; s=arc-20240605;
 b=f6IXBphSiyPeuGrh6T7YdpxlkV1SfMD61yU8RgLFW9arfeROA9/ryj2vbPUef9k7wW
 kEhPXveJPA0URS0F8LJQAPTVnAnP1u9QmrALkfMl/bcovk/4s9QYLR4thM0wRcwsHNL8
 fv0L+nx+MVTkZK4UIJr3uIOR/G6AesDZeBbBmCXg+oXW6oYOO+FT3B2RVAAmsDcg0W52
 jwfXLX9OlFAsTZVtD3WgoqAiFGraeXvdYILrD5BCFuU2pNDlXnQxPhGwtPFGkTlX1zPV
 bh6r8B/Sapcg7Df91aJc9Oho5fybrTCe9Rr0vt9yx+a7xFWKIl/btL0XO9zqKmd1og8q
 r7Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DBWtkUOLhgOXeAPiN+hWNQ9OV/YAwWSA8dwzqQ8IM8Q=;
 fh=XAfMQWH7P5hICVjbl+9HMKsgnLpiHULovI3rUPS5Uyk=;
 b=XrMzeB04S1CpcIJEONcIWIaUahmJLmCzaupHkSzWvvm5tHryLKd9MQy7z51WGlWt8T
 JD2YlvGFNN3p9ivqQ5ygn6BH1n0SmqN6QCgqA5Z4w6GyK1I1orNRQ8epPI17WU+QzfFz
 vaoYzQyqVW/mMPB9HxboP9zQH4LiysgX40Hx47Ia9uJodGRbOZUoGxsnbc4qVhaLIHhb
 rHqSe0KeUjUIW1xHjT02/LDEmy7pZZ7AhAt7jOCt+fnUR0z8PjftAr+sudrkWBKMOExk
 Q6AJOGPbzT1AzKMaxf79BnCBq+AJehXtcn+Ev1P+ep9YxxSdUMM41p2cBLmHHT25GRRi
 6bzg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780619041; x=1781223841; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DBWtkUOLhgOXeAPiN+hWNQ9OV/YAwWSA8dwzqQ8IM8Q=;
 b=CGpPM6GROIaemVW7VIyUaDFjXAIwiPhUBTxrjWOKljg9JNiJSxEjRLoa5Uw71hmsp5
 Qmyc9AcaIoE6Z0G1F6s6S/nu0sX4JUkyjGKVTeFjMblYqxUdlpBS6MbgN7JzEYf0iY4r
 yHEFibHORgExF28CLkvWvNcIzqu5+ZGNfxWvQ4nXONMcHR22HbimapdA8t/vOJubIqP5
 9vHJwesK/f0h9HZ1OEYp/q1IhlIadnWoB/e7GhrEOjlWi01mpwVDwHToWIl6FlwWlJz/
 NuX7P+KAlaZuhWverMIcwUagF6tc1ixbbFMioc+r7AcBFmY+5d1u8N9szlq8YzcAGyiJ
 SOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780619041; x=1781223841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DBWtkUOLhgOXeAPiN+hWNQ9OV/YAwWSA8dwzqQ8IM8Q=;
 b=TJWhJz28dtDPGws3Wmn9tPFjTKmKpZ6FXyUB7zeF5TiJz8y/qzvblBr/CGlywBqL+/
 xKDsXyGPPi8wCzN56fQxdYfbkCggTpfEDbzVlyHcQdBChXkRq+gbjLjHb+eZoKg44/iQ
 omAGiPu+d4Z45HDJxqWfa4n9rI3b8kwV1zvWzOlHf2aBQK9uw5IFBAlk+STQUK+6n9xf
 HZTH3kY04KmqXzUf8b3iwK5SowdOF7kt0hSN0+uDr8gS4esZrWpq3CqfiyjCZ7lZIyqB
 dVjoFnsLo70ZDWDj9hkgJl3xGyGwIPY9FHTRve0iuIM4bxdzCO0Od12v2GfX/DWU/V3r
 9Vxw==
X-Gm-Message-State: AOJu0YwBxBDfxA7McmuSMap+78x0lvWWvhz6VldZT7ktHwhgkjIthdxI
 d54OQgUFNL58qJIafG2b6n0V0RtGfsahO6eb1WCTIaR8SANP01l743aWsY5tGCu/9VcpqnihDT2
 iYYI/A0M+HBIlKNXTsA5CTYpOGWiZ5QA=
X-Gm-Gg: Acq92OGxs23DyY4fi0ZgIUH7JO9bJI9ReR4VTftwC5ri5D3NVixLVIwI+z57Dnp30KC
 y9MDn52EwBOSzt45Bu/MtNn/eiy3x6NqSBDp2jfDy0Iv6oqoX+0SL5lL154aZY3pZh3HuksZwD3
 jJhvDtcxU3PLUO3d9ZOIt4ZqjWpPJr61Zv34h5Qxwt8ugoVBNHfEPFPf0Qzr8kUTudBLLlzpXUx
 hzGIGLFCWsDPX8xEzGV1OiqJNycLhES+r5N8c/lWUHrimpC5no4B3W0UTkGDWiZTDcMBHUP0+kC
 ogs4llTiK1uwpMGwJc5t4UbFrY0wfqZGszd4xkxSorpNa6BEibUvIfzBD+8=
X-Received: by 2002:a17:906:d552:b0:bec:fa92:d377 with SMTP id
 a640c23a62f3a-bf370673d8fmr42874366b.16.1780619041044; Thu, 04 Jun 2026
 17:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260603064032.3733394-1-armbru@redhat.com>
 <20260603064032.3733394-20-armbru@redhat.com>
In-Reply-To: <20260603064032.3733394-20-armbru@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 5 Jun 2026 10:23:34 +1000
X-Gm-Features: AVVi8CcwQA-FuEFa2BuNp5E-KwzlyqPNb0GZhaVdD1yx3yOe0A9XnU8HYtWBAVM
Message-ID: <CAKmqyKMAg4L_GbN0Wp=_2m=UuSqNvBEwK_jqgnvyojzLXVotEA@mail.gmail.com>
Subject: Re: [PATCH v2 19/38] MAINTAINERS: Fix F: in "SSI"
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@mailo.com, pierrick.bouvier@oss.qualcomm.com,
 Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
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

On Wed, Jun 3, 2026 at 4:42=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> We neglected to update MAINTAINERS when we renamed
> tests/qtest/m25p80-test.c to tests/qtest/aspeed_smc-test.c.  Update it no=
w.
>
> Fixes: 5fde7f10c0 (tests/qtest: Rename m25p80 test in aspeed_smc test, 20=
21-05-01)
> Cc: Alistair Francis <alistair@alistair23.me>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 815ec48686..0c952b710b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2295,7 +2295,7 @@ F: hw/ssi/*
>  F: hw/block/m25p80*
>  F: include/hw/ssi/ssi.h
>  X: hw/ssi/xilinx_*
> -F: tests/qtest/m25p80-test.c
> +F: tests/qtest/aspeed_smc-test.c
>
>  Xilinx SPI
>  M: Alistair Francis <alistair@alistair23.me>
> --
> 2.54.0
>
>


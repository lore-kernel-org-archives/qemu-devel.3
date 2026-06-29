Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02009C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 09:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we8Sz-0006Rg-2x; Mon, 29 Jun 2026 05:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1we8Sx-0006R7-I3
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 05:39:47 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1we8Sw-00075o-2q
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 05:39:47 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-664de279fadso707803d50.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 02:39:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782725985; cv=none;
 d=google.com; s=arc-20260327;
 b=MRPSSRiQMfZFRXTm8cJ17S0Thi4jZen/z4EVMf+N3GAAYLIuPx9VAAB/ta6lJ/EcAn
 SIdr0qGClcVaa3X3LtIJemTbQh8klaC2fp4L/ofe2mhbMBzK6HfRgySXc8W0BqoAVxGR
 2+nrDLnC6E2MuR55KSJaE5SfLglQ8HE+25akWNiPUL8kQ5WSnpzSIaXX9WJ7wpXDkq86
 Y1OOzjzBv1HtBWx6JvuG2C38IV7LBwgrBkv+yUWy8FdiD50VwUot/52k2JfWTvJudGKC
 +gUcG6jEgBLHz2aA78O+CpQt04n5UBkeacC9K5Lnn35CRy1pXLl4Moz3aRiZQxZhSzmq
 4n1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=988EzWVGBnNAodMjMyAvNDHl7YSc7IDWjyXyZk6QIKM=;
 fh=+AHfTqzMLwqakmZTEEfzrDayzLFhxaPRc9rOTKL/Wt8=;
 b=ewoGju/6Ru3Q29ualHQMd9JQ/oGPZ54wWBSXjV32qA7rNfgBKpFG7/hnWQOX1aYNM+
 AzfXQN5Q5ANX6KBNqBGfE1scjvl+d66nMrP5yTZUb0bs1prSDcSXTDYaTaruei2iV0zQ
 xvQVKeiDT+CGN5uSTV4mSQ8hlwz38wKCRp2hL+Abu/d+4GzG5HH535DETa5zqRxOdj7M
 WPX12wDSA8mSr7hxRLLTgmkEORc4jss7oOtc2OQJ7pFXuOl20LUerP9AB6lWn1wmXy0h
 eqwDyaZDINsd9TYHuLK83n9tiGZdqOB/j12tk0PA+pVC7hsnkFslSjvgQOBlbozSSndV
 HmGQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782725985; x=1783330785; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=988EzWVGBnNAodMjMyAvNDHl7YSc7IDWjyXyZk6QIKM=;
 b=um9/w5xB1s4+b8u4lkgif+pfjnMpSwFBRGn8BGz8P2uo/3vie45dNwRKV7TUHqCaQH
 ajbvqJWR7ctMcmxy8/UnmHzEYBEhvLU5u9XjdBk1ecQi5uDj7wrRbdnpmKZO0XJaE4bD
 Ykqhy8U02rC4ph/e66t1mcJ8wImc2zzzFDmjNsFpIpvYETVljlc+tgvz8R23S3i/LnkA
 5onlfb3ieSzOroOFyHshVz3/TG6TMa3zbO9siw3OSYv9WAVHFTklS2qZTjooJr24R4vs
 zWE76IxF83gHq2Ve65h8c6VQnO0q1v/hFGzVNZix6zXgH4sI7Mhq9h5JAJY/babvCovC
 MG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782725985; x=1783330785;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=988EzWVGBnNAodMjMyAvNDHl7YSc7IDWjyXyZk6QIKM=;
 b=cLq9xCeYjyjK0oRQ9Rw2fHU5mERa6WWV5uFCLF/99f1XaFrlYlkQTShCyJ/L5BThH3
 9SODNJfN+yYgJFb+2artRww4U2aSosX50P4/DaD60vKAxysCXgJrgukOaScMotZbHywU
 t4YO2T6zWFB3mCGWzHjrmkGXrdYE3PB8/lEBpp29eU3om5XMdoW/uJ9Vy1MtS3We4sLS
 tiFKL+qmcU0Y1398O7IKftSgAKryL7JdoVMx7o5A2etWbJpwYopBSHDjFiyjhJ8UGhA6
 OtNqgTF5JNZFzMGbpw5qd2MYIDwxA8ZoRbWF9G0CDubnK0hKX6+9N+zB3geY+HF2m8zK
 5EfQ==
X-Gm-Message-State: AOJu0YzKtXpmDT8L2QiD7MRUyMUoIWsFxkNdDchw2foF/E+ivMOA7LyL
 pRecpllWB9c+mWC7AXAVBdrqPo3NIJYQVJdikecX6qGzHmAg5qwrjaudiFVmnrw11SCWiGPG5hD
 sA/1tsZxUDHKr7JohSDt2wg6td+qUx3ZZ9JZ2OU6lxA==
X-Gm-Gg: AfdE7cl2/FTCFzhXlggnHp4N1xWbV2X+PRrTgnmNlPHOJh7nmYujZHEMiyQqvtUnPk0
 seG2MENtX+iUYtkQ36KqoA6uJIfUMewE6dljcIMzDH7798QwDJm9vw1EjOXr8kPTmnceM2uq1Yi
 vPhvlEeY2wXZbc8FKi0pYhvjd78Jwd0tO9Hc2nrcwLR7NFlACMlBX7Npas/ZU64dMHQD134IakO
 gS3nab6oU6yTkQhN8qM8v5/2vbeCFVX2GHP7n1wre8KRyakN98LjyV4WkGYH87+QTQzzAXBMHjg
 IM/bLALHyXNVDk1VJNqxYAeFpRwpsCa9FXqHB4tLoHkpqxmKqwkTQ6H6
X-Received: by 2002:a53:ac93:0:b0:664:d7c2:43d2 with SMTP id
 956f58d0204a3-664d7c24762mr2541166d50.80.1782725984781; Mon, 29 Jun 2026
 02:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260628190358.634435-1-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260628190358.634435-1-brian.cain@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jun 2026 10:39:32 +0100
X-Gm-Features: AVVi8CevpQwJkD4erd_5GVBWn4S3XbHIifqTbsWIZ_5YubfQBpKdDCAukYvVNNo
Message-ID: <CAFEAcA8zD4ifpmdTxoMe4jCUGE=jQd6uwbnx5WL92GL9nWsHnw@mail.gmail.com>
Subject: Re: [PATCH] configs/meson: disable hexagon idef-parser for emscripten
 builds
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Kohei Tokunaga <ktokunaga.mail@gmail.com>, 
 pierrick.bouvier@oss.qualcomm.com, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sun, 28 Jun 2026 at 20:05, Brian Cain <brian.cain@oss.qualcomm.com> wrot=
e:
>
> The idef-parser is a native build tool that requires glib-2.0 on the
> build machine. In emscripten cross builds, emconfigure sets
> PKG_CONFIG_LIBDIR to emscripten's sysroot which prevents native
> pkg-config from finding system-installed packages.

This sounds like a bug in their cross build setup.

 Disable idef-parser
> by default for emscripten since the wasm target does not need it.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  configs/meson/emscripten.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/configs/meson/emscripten.txt b/configs/meson/emscripten.txt
> index 4230e88005f..c5c57e392a9 100644
> --- a/configs/meson/emscripten.txt
> +++ b/configs/meson/emscripten.txt
> @@ -6,3 +6,6 @@ objc_args =3D ['-pthread']
>  # configuration so explicitly add the flag here.
>  c_link_args =3D ['-pthread','-sASYNCIFY=3D1','-sPROXY_TO_PTHREAD=3D1','-=
sFORCE_FILESYSTEM','-sALLOW_TABLE_GROWTH','-sTOTAL_MEMORY=3D2GB','-sWASM_BI=
GINT','-sEXPORT_ES6=3D1','-sASYNCIFY_IMPORTS=3Dffi_call_js','-sEXPORTED_RUN=
TIME_METHODS=3DaddFunction,removeFunction,TTY,FS']
>  cpp_link_args =3D ['-pthread','-sASYNCIFY=3D1','-sPROXY_TO_PTHREAD=3D1',=
'-sFORCE_FILESYSTEM','-sALLOW_TABLE_GROWTH','-sTOTAL_MEMORY=3D2GB','-sWASM_=
BIGINT','-sEXPORT_ES6=3D1','-sASYNCIFY_IMPORTS=3Dffi_call_js','-sEXPORTED_R=
UNTIME_METHODS=3DaddFunction,removeFunction,TTY,FS']
> +
> +[project options]
> +hexagon_idef_parser =3D false

We should have a comment here that briefly explains that we're doing
this to work around a bug in the cross build setup we use.

-- PMM


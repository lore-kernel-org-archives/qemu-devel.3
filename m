Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8A5D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaAz4-0004mW-Hb; Mon, 29 Dec 2025 06:00:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaAyj-0004bj-NZ
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:00:05 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaAyi-0002ZL-5u
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 05:59:57 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-64e48264e56so3033478a12.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 02:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767005995; x=1767610795; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3++AK+/D2k4Ir6eMImmVeWYHi2A6CAe5d/WqaHCVqE=;
 b=WBugU8qrR+Q2CuWieiGqWVt0CQdo8WWfYtZlGVFZ5lzGne8FWXOGjHoZsa00ELNtBw
 bxk5ZfGJ4SV1Pg4MZbkAFeNlS7gi2MlmJvk8iZDEIQm7xDWZWzUeyhO1zq9hl9D74vWO
 zehUrPXVniSj8RFUskbqS8KSwqYcFB+E8tjMjBw0JzVSLydhTyuEsBza1uxc64Eh2eyk
 uIaOgrgGq0+gOEXfnzR5LztoXW8QbcmDErUHtzP3E5lEe58ZvIozpPyp3gsZsCctGEAl
 KJd5SmOI6OuZQB9pqyt4yTbiIry8ameWvVRQL3je01UfxBi3aOBYqzuKqkgJrMviYfZP
 M+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767005995; x=1767610795;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j3++AK+/D2k4Ir6eMImmVeWYHi2A6CAe5d/WqaHCVqE=;
 b=WqHZ/3MoMKAPyytGVAksPLwj9axPcIoIAO0FKKuDWXJ/Nr65OhdVA/yrFBsrz62XQy
 cVQboKgQcpydLjJKtKS7QiRbqAhP3nOSwcfX17Bd3HBJ/MOEwawfl8cEfyHs90LipSHB
 vAHi9W+JgKBWDxYN8HdDClwvHvUaHlCj/jTa91+32zu2WIQKrrdeBTfdeIm8TudTbU99
 OkNMnHVyKcEAZQQRMwBaqK7ClevOHeN4zpiYoE2awQYSlG8Ilwu8LFZbnXffthsF5iGJ
 /u8uR4vlP2zmssI4PBRu3PHwGxjV21Vs9EOKtIyfX/J4QmBQExauIMEmgGouMPDA+8TB
 hHvA==
X-Gm-Message-State: AOJu0Yzk89AHJ9oFRDxnjRkTCNltCgAyC+s0NnXNKnFNrc1mFTvrfxKJ
 4hEAHQr4wiiyipKXLjGOLTZLJuD6VN4d+zFu1SejsYFbQN3V7GpDbPXu5FUcs3O4KDSX9x7RCCp
 /47//IVfAg1VBjJKjKDi7SAqQgPWd36bnASIQbV93ZA==
X-Gm-Gg: AY/fxX5n+22xEwKVqpH8M8UusZv9mMEEyxuvrPdgF1a4TpaG9SB3vYU3/5XbYKGDHGx
 9dwMjAjptLzdIpeHjhLAv+UMjDhDgPmB2edlS34b8rBS1gy2vdk5meZL7j8y4lJJAt1xtBw/mK5
 n8O8+B6wkNOvmnfkl0IR05s5UsCynGIVSLO3AziqXY+DbjlqwRRpKJJN8N9VhmSCxT+ZOFkQvCt
 qXTMVRK3hRPEUZ2yIpBTFyZlJLHcr7tFVE8IP5DYdtsgxhkJFIB5W9bttPsvnUSftw2OTbjYPUv
 uUjBjWeEyxTaJ3/29EqGLInjDuPrUcRV8Wxk8BM=
X-Google-Smtp-Source: AGHT+IFcarMJX/5LI6rMw90DdPeRWnNQrz3XuS9FDpJEDUw9N9HHoYQRBol/p4bx2Ar9VOs7mE9WAYO9CyvabmNSxvI=
X-Received: by 2002:a17:907:984:b0:b72:3765:eda9 with SMTP id
 a640c23a62f3a-b8037256c76mr3092517466b.60.1767005994621; Mon, 29 Dec 2025
 02:59:54 -0800 (PST)
MIME-Version: 1.0
References: <20251224161804.90064-1-philmd@linaro.org>
 <20251224161804.90064-2-philmd@linaro.org>
In-Reply-To: <20251224161804.90064-2-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 12:59:28 +0200
X-Gm-Features: AQt7F2oSBqNpbXT5-U1YaKLbMabe5ZFWCx6GtxOmMyGpHkAWKn80AaApKstkULo
Message-ID: <CAAjaMXbby7PVZy-Au2F3m+0cgLVaEL5jA9SunxibtAqOWpYf3Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] hw/intc: Mark OpenRISC-specific peripheral as
 big-endian
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jia Liu <proljc@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>, 
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x531.google.com
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

On Wed, Dec 24, 2025 at 6:18=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The Open Multi-Processor Interrupt Controller (ompic) is only
> used by the OpenRISC target, which is only built as big-endian.
> Therefore the DEVICE_NATIVE_ENDIAN definition expand to
> DEVICE_BIG_ENDIAN (besides, the DEVICE_LITTLE_ENDIAN case isn't
> tested). Simplify directly using DEVICE_BIG_ENDIAN.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  hw/intc/ompic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/ompic.c b/hw/intc/ompic.c
> index 047c367478d..ee34501f675 100644
> --- a/hw/intc/ompic.c
> +++ b/hw/intc/ompic.c
> @@ -96,7 +96,7 @@ static void ompic_write(void *opaque, hwaddr addr, uint=
64_t data, unsigned size)
>  static const MemoryRegionOps ompic_ops =3D {
>      .read =3D ompic_read,
>      .write =3D ompic_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>      .impl =3D {
>          .max_access_size =3D 8,
>      },
> --
> 2.52.0
>


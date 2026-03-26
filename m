Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FD5109E52B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 02:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5aFx-00012s-QW; Wed, 25 Mar 2026 22:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5aFv-00012C-SS
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:15:31 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5aFt-0000Mq-IW
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:15:31 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9825ba7e8dso63744166b.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 19:15:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774491328; cv=none;
 d=google.com; s=arc-20240605;
 b=c59B3Ba4HJ1CQLu8K6ZP7wL6145KlZN6eE2IA9yhg4UmF3XPCg7K+OjLW8l/sUTMRj
 eOHDxv78mXq1DAm1MGV3PyW1sUBhb/UOi7EjN35qEqNONaEFy+iPVROc+PIC2UDc5iRV
 WlRZelAFYX1WW8wiWE3HDGcGpNYb6Z7dD4K93WXANRHsa3OJ5hqtfCpTAuQNHsbS4teQ
 lr3/ON0IzJmEcNF4iI7+f9qCB3i+kdaJ8IJH0bi3/Z1PQFCRpF/rnObiA1Px2KxJ98Ky
 J3AEdltyL0QUZGaIVzQEpNIXAXj++AQ57gMcNCfpx9m45zHijofTeFymkOzXDqm1lAt8
 x8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LWBXvcT8HTKeX/5fn5oWP2n08N8JYOVphEbatOOf5Yc=;
 fh=0bIOm+75pw/QTN9FDs8ZhfYo0XBcsOIKWWC6mti+rTw=;
 b=G/kYZy2Z89G3BQznf++uPtnWA8VQvEFEA/CRUnuriBh5Iic/dCRBQ4dV+ArlUvihHY
 nGpe41JNYQ//iX9q5G2qSYnsU6fBi7yVu4/JGUgb1grghzPXZ4Q7iVlGmnv+lbZfwxsW
 TzIIqOUWJJfJiGkONDpOc4hJD8Hz/ng5kltJR0wS3ohaxSfCBu+cbrRQr7AgBGojQwQa
 Bbc78btEE+LVNhHE1zm2GaCXM0jG0xvR2dob5tWP5HXb6FQ0a2AWqlOuDhxZ30xQBXWi
 7eP/Q0Mtw4wYeZqfhI62MGJREkbYmUW8fiIgscnwrWcY38CYqGyhb/zSUXfPoEPmn8TE
 Tk0Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774491328; x=1775096128; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWBXvcT8HTKeX/5fn5oWP2n08N8JYOVphEbatOOf5Yc=;
 b=jcr3skNOCAWzmB1EprkUwlOKyZiTk88n4w+qiHuqzZZcjgcHU3CHiGp5c0QJPwV6wx
 DdUPIBcnlokHLrC23y7sqOsqqUX8NBLqdaNy6AtC2yuVIzo3GGDJXmUYZxBIj6J3n7F5
 2X7d/LZRpbg6gOJreQ5mOn4BHQStWVoq4AEjswwp9s3GJ9oXgoKzwj+k2oGYEFTePll1
 BVzUnEHsISJYdHX7u5Xu6gZ+LatQ6agLBWBwyih1WGXBd5FsXIRCA1rQxpePm3XQNQdt
 glL6TKL4veIN6761aSKGDXbjpuh/19TSz9vFTRpUMh5SYy3zaLC/R/rWcNFa+aMDM8Nz
 kD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774491328; x=1775096128;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LWBXvcT8HTKeX/5fn5oWP2n08N8JYOVphEbatOOf5Yc=;
 b=hS356ouSKJPF24yioY74pR96ut8x0bCpGOy3Gc6TV3EURj5tFrJTco3qroNfyWdmTB
 ByvpWaZ0ODMJgjzrVxrkE45kPM5DSfOHyPEB5bp8fzfNpYzmkOqAbX+GKZXMdnjH6qzX
 VkB3lE8BHpa8oGjhW1g+GMu/+bwz8IMcOT4wvU2Sj/ouYYK7re+8MGdWcg5g0dIvwVkR
 0j3dLfF3itiXeeOgZlSY4vxpsCJmydKZDgflUuQ+QwpPIrZdoZslj5scbtLvrd71pko7
 59z7zCZ+l0P2r3Qg/Aw7nzhu/cwH6N55bX+uS8yI1cc0a9bvSJFVQvZVuCkSKJ8wpSov
 fvgg==
X-Gm-Message-State: AOJu0YwviGbOaX7sz8/vviNEvGgGvm+rfb8O0QSiUS7vTDYwSRlEmL42
 VPD6GAEm8AHy/dzsU7BR4dMJGs5BVHtnDlpoRPiFLAunEctw9xCp+p/nQXd81O9QwpvwZuQYNdC
 RC2HBDqL0wO4qxpnjZ0Cz56aq77ZVJsU=
X-Gm-Gg: ATEYQzwOCqRTPLxVpLotn5ZJ/8nrQ3bzrUBRUXcKg/L819Ly6qOjdjJbrcV+bOGMXOo
 vSqgNBf+IU08pdXaDEO+IDScVAw3m//52eNp+5F8QFsqXHuJyvEz8dCCRXRm79olY94XKyDEAES
 B1agRQh/CY8r7bjxlXu5ZxtKX7Q/7Se8azYIglbYNvbDdjdfsLNZbnifOVVoMgcqLSH1ynEwE4b
 4vTH/n+32tsWRL2gGXhuYDgNlNahdpCWdA2ZKZIP3tthaCNCpxQkX2Y0p0bJuGCOsbIy1B9rcNb
 UR4Ph2J4fDUElJprM0pjJFThjxo98tIi0lJEEA==
X-Received: by 2002:a17:907:7286:b0:b98:155e:609 with SMTP id
 a640c23a62f3a-b9a54221611mr367086566b.36.1774491327746; Wed, 25 Mar 2026
 19:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260318103122.97244-1-philmd@linaro.org>
 <20260318103122.97244-11-philmd@linaro.org>
In-Reply-To: <20260318103122.97244-11-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Mar 2026 12:15:01 +1000
X-Gm-Features: AQROBzDiQBRG4w8lSewUiJJdLMK9nOQXncyNTNIIGlCQ6nJPg5InVKv1BWI-7uc
Message-ID: <CAKmqyKNX4T61eYLm8RjTfQt40LKK+wWypYB7HHjv1-RBgORiHA@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 10/16] target/riscv: Have gdbstub consider CPU
 endianness
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?= <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x634.google.com
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

On Wed, Mar 18, 2026 at 8:34=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Consider CPU endianness when accessing registers.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/gdbstub.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index a5c12638782..2c6ccd4761c 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -20,6 +20,7 @@
>  #include "exec/gdbstub.h"
>  #include "gdbstub/helpers.h"
>  #include "cpu.h"
> +#include "internals.h"
>
>  struct TypeSize {
>      const char *gdb_type;
> @@ -49,7 +50,7 @@ static const struct TypeSize vec_lanes[] =3D {
>
>  static uint64_t ldn(CPURISCVState *env, uint8_t *mem_buf, size_t regsz)
>  {
> -    return ldn_p(mem_buf, regsz);
> +    return (mo_endian_env(env) =3D=3D MO_LE ? ldn_le_p : ldn_be_p)(mem_b=
uf, regsz);
>  }
>
>  int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n=
)
> --
> 2.53.0
>
>


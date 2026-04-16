Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E12DF433D4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBWS-0003LC-PP; Wed, 15 Apr 2026 21:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDBWQ-0003Kv-QM
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 21:27:58 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDBWN-0001Ft-Vp
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 21:27:58 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6714f678bdaso7147950a12.3
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 18:27:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776302873; cv=none;
 d=google.com; s=arc-20240605;
 b=grAaP6C6T4E++R1KIVjba9djJ87U9QFppbBYo6a5L37s/ljNqnUUObdu74WVMLhrOi
 ixYrfzHtdJHLO1hPpdO0yLfY6ycri/GGvHRedVI+kvxg3J7CPTM86Upsd4YA5qQeB/uw
 jJOiHksDjH/UXXcuKs7ybzbwqFxM922tBwgA6JafpImCzY/MfHV+fW1HAelP62lls9Dq
 5PygEwyjjIcrLeROmHeCc9PdjbhOux3LxHG8+eTRS9b+0oIo0ailfkpavddwWB1DvUU8
 EdithTSmNqvUn3jsURpmTfxDwpJIsOv/PyxgLYabcCLEpjyBuSd6m+AKC82SllMYH3Ns
 +ciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GeZWIzkTISc/FfJjoYIphRDrwqk22IxTdwxueeuvlG4=;
 fh=R3foNG4HqOslSD+CWvsJe7q9oAuWpN6q0mgBXcmuYRM=;
 b=dfoAF+Q4wWqS2kk4EJ5w5Qh7cxOy2h37K/aEyW8Z7c6Bd3mu11GFems2fMqbeb4gfy
 bTJ+4wpTO6rgpGvV8Ru+KGlIl5+/PEgF8OzHSqEUeRH/DVMFIKKzDA4HZStvCMjRkjCR
 sKHdWC7Qd1KCQxzfr1cGeOdLxOeeILx5iCWDYWYFpOpYYFO1kXQsQGqg4xxYWUb3S9q/
 XB/s5Aq6XlS1f0XaRj3OXPI4d6HustPy1Rwnm9Mo5U7fqwV7u8ppVfRLfceBskk94C0G
 Tm5ERR/fs/rnYl87IjrnBbw9jL0AHrTHrFOUnZTE8mYVjp42KTeDH+0ONtMWXFcvjZsA
 6QXQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776302873; x=1776907673; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GeZWIzkTISc/FfJjoYIphRDrwqk22IxTdwxueeuvlG4=;
 b=S/KD7lUsFJcI6OWEkW6uCHv41Y/qmrXkISmwfO0us4yUboVWeTxUmH6g6lFHtD/iKb
 MueQ7KcAgfmianVD5WZYSAHYNoteiPi6HShi3SiCGZiI5pn6+NISE70JPJO86Q1elXee
 xKtLmjr+eJsKJJFo0ZH57Rv68tpxzFB/Iy1YhcHiJrnilEVaL3zAwiRDPBvQo7zazBME
 xy791aNEZodC+Ej/owc8MUJ0kKejr+aimy2z4f0MFRpCOYd5bhTbqY19dlnUjgoTWGas
 PuxORkHDTD8iYUG/XDAooPnAGf8zcAFqzcllDm+wUnH7QEHdWcCre8Vk7nH4mHX47cvc
 74fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776302873; x=1776907673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GeZWIzkTISc/FfJjoYIphRDrwqk22IxTdwxueeuvlG4=;
 b=UYZccbl1/5ZjVBlrIlO8Eq8YEla0htGeGfILbt54EdhuTFt5zp/nOM5ih5L6xI8Fu7
 qmJTMkV7P0GiyQ3RpVgABdIm8Hky9X0MFypJ9Wj8L1eHSb/qpaqof6D2Q+t5a1I/VmUZ
 kNkSiMyh574RUNS0MICwHTYU5PQtvIJkyo+yEsVU94QDoUFGKZPFBeasfeKfMZjoHS5l
 tUgAOtRqPgda20ajYVBsAvp0MI40TJndBle3lYt+E7jn2XSYDxJ/IQE1O6EMErJXmARA
 0rKHGlRHdLStcbgu6vpYIeSDZC9vCASUXFHQcuWLah5jk4LLEsRn5kRaQq74cnpBzgir
 Favg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QYRzNwgk7OAljlT3sVwIxjdj0XNauhETREUg79jUTuiq0A5NpzX09D3rRZ3d677F51wAMmgK1cm3f@nongnu.org
X-Gm-Message-State: AOJu0YwDE/DkuNdZDWcFUyoRfu6Mr3tF9H2agXTR9yUpMQkjfGIf2CtS
 KQvBG7n3sIIngqH3A634VjPutW6Fc0h5Bi80usVEvjjP7jF9LCQEVOllAdgWLlbMPG02m9tXCN2
 lnTA8SYeALMMryeeoF0H/ujmMeaJOV0c=
X-Gm-Gg: AeBDies7bui74a1QRzaB9bYor6UzjKOGrRxWshgRKHv2eGu7XDw97vZKqOAQYPZZbaO
 U327W0NHYKyViT54FLr6WIM3yXUBr58keLrQT1lbjDAHSGrQuNzM2xjb0nBN8Lutjyxhp28iyOz
 C/ldnx365k6D3L7BR/SIB0NI4wk7ze0YXcH5K0hQwmxtW2luwNcxNA5Qi/pLaHxT4dgDRDNaoZE
 7ogqt6kCEmH2IG8ChuYJTv6OtmIC9sX+ujoa7o1f7uV4yalL543PiAXqDy7hXeFGvu48leTr8BE
 jW9rZp/67ZEN8WN5TYRrrJYUgq6qhlrQ2UtaLn2BHbE5Q89b
X-Received: by 2002:a17:907:619e:b0:ba2:5aeb:8675 with SMTP id
 a640c23a62f3a-ba25aeb92ebmr79416866b.3.1776302872586; Wed, 15 Apr 2026
 18:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260415134826.1742308-1-chao.liu.zevorn@gmail.com>
In-Reply-To: <20260415134826.1742308-1-chao.liu.zevorn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Apr 2026 11:27:26 +1000
X-Gm-Features: AQROBzAVVNYg5J1p_hJy41LNyrUD6AOEW2WGEx0rlUJSYsZUJqqj9ApZRhPXNdM
Message-ID: <CAKmqyKN=0=HiVbRCWTzdDA-68Wwj4-biRJpovpYV6b4q2p3GeQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/char/riscv_htif: Fix format specifier for uint64_t
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 tangtao1634@phytium.com.cn, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
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

On Wed, Apr 15, 2026 at 11:51=E2=80=AFPM Chao Liu <chao.liu.zevorn@gmail.co=
m> wrote:
>
> Use PRIx64 instead of %llx for uint64_t arguments to avoid
> -Werror=3Dformat warnings on platforms where uint64_t is not
> long long.
>
> This fixes the cross-riscv64-system CI failure:
>
>   ../hw/char/riscv_htif.c: In function 'htif_handle_tohost_write':
>   ../hw/char/riscv_htif.c:175:38: error: format '%llx' expects argument
>   of type 'long long unsigned int', but argument 2 has type 'uint64_t'
>   {aka 'long unsigned int'} [-Werror=3Dformat=3D]
>
> Fixes: d98f7a541c2c ("riscv_htif: reject invalid signature ranges (end <=
=3D begin)")
> Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/char/riscv_htif.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
> index 65ddea3fc8..a53d2ace02 100644
> --- a/hw/char/riscv_htif.c
> +++ b/hw/char/riscv_htif.c
> @@ -172,8 +172,9 @@ static void htif_handle_tohost_write(HTIFState *s, ui=
nt64_t val_written)
>                   */
>                  if (sig_file && begin_sig_addr && end_sig_addr) {
>                      if (end_sig_addr <=3D begin_sig_addr) {
> -                        error_report("Invalid HTIF signature range: begi=
n=3D0x%llx end=3D0x%llx",
> -                                    begin_sig_addr, end_sig_addr);
> +                        error_report("Invalid HTIF signature range:"
> +                                     " begin=3D0x%" PRIx64 " end=3D0x%" =
PRIx64,
> +                                     begin_sig_addr, end_sig_addr);
>                          return;
>                      }
>                      uint64_t sig_len =3D end_sig_addr - begin_sig_addr;
> --
> 2.53.0
>
>


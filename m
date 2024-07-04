Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC0CC3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 09:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPIpd-0006am-1r; Thu, 04 Jul 2024 05:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sPIpa-0006Xp-9K
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:32:46 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sPIpY-000240-JW
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:32:45 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-58bac81f40bso609879a12.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720085561; x=1720690361; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wg5r9sYSQsAvjhQ+CRVIQveWls8q4Cp7ZuTqAA6lFzA=;
 b=qDw9DZlPPlu8o0cFuH9Of8+aeCMdVYNsYNNsHUqpEBWmZKqfMLVKlSGT5qEEXjXsRB
 f1WEc6AU+wS8Vl41uZwJ+z2liX/aWtlhDsopuJ8tZupvvWEuaHFd5Pp4C8V3se2d124K
 tG/eSZITlAfPQjNWi5Kv1CjRz5p1Q7hUWSp+sf5cgKwtcUz08Eaz2OKDgPXgxOBIeupN
 3WQJf7HxiVfgerVer7diSHQfU2o0qYXUEJ8GfplnUhf3fHJUz4UOmM3v+VqpFNAh68gr
 jsVGm2EDw4ErGEt3/ZrxsswL+6FXppGNW6j2Sodp9rVJGer41Z3etAsiC+V+s5psR5nq
 29/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720085561; x=1720690361;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wg5r9sYSQsAvjhQ+CRVIQveWls8q4Cp7ZuTqAA6lFzA=;
 b=l+/7/UO4Kjayqm2Yc5FF27E5K0JHjb5e+19Lssc0AfOv4MWC8vMmQvRbuaVpj4Mu+v
 eac5fGiGAgmTHW5+zbjRj1QNnJ079rzSlapQDFu7IVW9rFmbw0n8QNC8tSSXCSDQ14P/
 huIdt8XQHxN8V2cYfXOam3ru/dM+AzmjZMcGShx/Y89uSr9uX0SaVCyuwA3R3m4xFsZN
 UtuH8rjDM3fgTRlIj15/zWCUloNPRyuOuHs1Y+hqpYtWjDz5Tl/6bs+kp6I7fcxEnSyc
 8NGnxLFnpJALl87WnVgjWDO7j/N34uHX5bSslR0Pr7xD1hDT8EEBdvtgdPG88fnWyknb
 F4MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsNsBNSMmY2Kk7uR6vIrlRJVCb3frtGcKaFcNP6lXkG57l9Ttm1CFur1D5jw7AfMEgsQkXCzRMC+9vLEAsIAB7SLwiVAo=
X-Gm-Message-State: AOJu0YyPB2JbNSelbzA1huiv7Itgp6kj+kMdEnUdKRgR8eQZUTj1B0Db
 XLm2W9wwNwQXHJmW0k1/t1nsidbA+WXTo2mjBAySMgF/0iI0392gacQ/bO3Vq1eF+Sz/GChPlR7
 pMA7wt4I7+IgSAuufc8p2JQfwetblwwTOywH1ZQ==
X-Google-Smtp-Source: AGHT+IE7qXHKBYmBeRGY9jO1i6pr9B2inR+WbVBPpgVsf7Cvbh+WgpRKmtihOw20IuEFvTewixVo7sDHvFXPMqFBQk0=
X-Received: by 2002:a05:6402:34c1:b0:587:2fa6:496a with SMTP id
 4fb4d7f45d1cf-58e5abdc863mr784969a12.15.1720085560867; Thu, 04 Jul 2024
 02:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240703213102.254927-1-zheyuma97@gmail.com>
In-Reply-To: <20240703213102.254927-1-zheyuma97@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2024 10:32:29 +0100
Message-ID: <CAFEAcA_9_fymBmp4Ei+ZxP3PB6u3JckTxufLcJn6JKuf4Yjkaw@mail.gmail.com>
Subject: Re: [PATCH] hw/intc: sifive_plic: Fix heap-buffer-overflow in SiFive
 PLIC read operation
To: Zheyu Ma <zheyuma97@gmail.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 3 Jul 2024 at 22:32, Zheyu Ma <zheyuma97@gmail.com> wrote:
>
> The sifive_plic_read function in hw/intc/sifive_plic.c had a potential
> heap-buffer-overflow issue when reading from the pending_base region.
> This occurred because the code did not check if the calculated word index
> was within valid bounds before accessing the pending array.
>
> This fix prevents out-of-bounds memory access, ensuring safer and more
> robust handling of PLIC reads.
>
> ASAN log:
> ==78800==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x602000038a14 at pc 0x5baf49d0d6cb bp 0x7ffc2ea4e180 sp 0x7ffc2ea4e178
> READ of size 4 at 0x602000038a14 thread T0
>     #0 0x5baf49d0d6ca in sifive_plic_read hw/intc/sifive_plic.c:151:16
>     #1 0x5baf49f7f3bb in memory_region_read_accessor system/memory.c:445:11
>
> Reproducer:
> cat << EOF | qemu-system-riscv64  -display \
> none -machine accel=qtest, -m 512M -machine shakti_c -m 2G -qtest stdio
> readl 0xc001004
> EOF
>
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  hw/intc/sifive_plic.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
> index e559f11805..d2a90dfd3a 100644
> --- a/hw/intc/sifive_plic.c
> +++ b/hw/intc/sifive_plic.c
> @@ -147,7 +147,14 @@ static uint64_t sifive_plic_read(void *opaque, hwaddr addr, unsigned size)
>                              (plic->num_sources + 31) >> 3)) {
>          uint32_t word = (addr - plic->pending_base) >> 2;
>
> -        return plic->pending[word];
> +        if (word < plic->bitfield_words) {
> +            return plic->pending[word];
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "sifive_plic_read: Word out of bounds for pending_base read: word=%u\n",
> +                          word);
> +            return 0;
> +        }

This seems a bit odd. This part of the code is guarded by

    } else if (addr_between(addr, plic->pending_base,
                            (plic->num_sources + 31) >> 3)) {

and we calculate plic->bitfield_words in realize based on
plic->num_sources:
    s->bitfield_words = (s->num_sources + 31) >> 5;

so presumably the intention was that we put enough words
in the bitfield for the number of sources we have, so that
the array access wouldn't overrun. Maybe we got the
calculation wrong?

thanks
-- PMM


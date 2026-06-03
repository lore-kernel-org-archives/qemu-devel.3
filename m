Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B650CD6E5D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUa1N-0006js-AT; Tue, 02 Jun 2026 21:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUa1M-0006jJ-0A
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 21:03:48 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUa1K-0000Jn-IS
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 21:03:47 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-befee9e5ef7so124071766b.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 18:03:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780448625; cv=none;
 d=google.com; s=arc-20240605;
 b=CmICJlfDDKnawb5sz3yydbMyRHjVenrM6WskEgtzHdi90SUUamastcJIkAYazy3g+r
 jKcbJZNZvmhACN+XSOKNMSNsKgSntoPUiyGTfMIMulj5+RaDFlhwPvEmjKckNXoa2J8w
 MH+PjHOct3qUtElsBv2CcESjbb3yVVpfC5G3125rvuY+ZruJdzlV0eRPSnSmTAAW3fEz
 MizmM4lrB6OZ86O992L6jVLyL8yr1vz5s9YtNAZu1q6gT6xAUJhTmdDraxW4EA0XPMr8
 rN9BIGUwKcDJ4tvICYUjOovV8Cy6CuzFFVUGzUtW1gMVNtr8U9pI9RvgtR/i9EcyVhgO
 lG3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AGKgT1ADvc73GkcOLam8AhKgJtIO4uzN1w6zJXvZOAU=;
 fh=fx/r/twi0lR0VsLAVqPkirIE7VN6h63K7UWTunhhuts=;
 b=Sg+bhw/++tvEVphzwZ5Jw+aGn1XMyEibwaYHOhqE9jTlNZuJow95zi1SBUKCYwCo4z
 MnY+cbnGI7UPiDmpR9vIz+G4c+95FKdeGxOUXvcUHPNmaDfDsiZztmv1uyLm3ZGNUPUY
 u70eInwsKOqx1/ChGNTZWlLGcf2gwzkL7xv62b3ylSKNOIpxfEb/Kmbw9OGT2ZAyjPDx
 HvT9Z7ZHmEL9qbW7Epxf6QbP8KTVUwAmU2+SnO16FANdjJJtj+xMW4Ark9Y3AH3e+kCR
 +zetOwmXABr98vRzn14aCvcqI7kCSdBg+z38Mc/6eQzQGcWq5ENG0UzxvPFe7CcAwk0T
 2Wnw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780448625; x=1781053425; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AGKgT1ADvc73GkcOLam8AhKgJtIO4uzN1w6zJXvZOAU=;
 b=HjclmfKixGUSu0q2+7h6aRClq+RvyaqOqG82NDpcx+wWDGWbT62fJS13AGtIS6Beuo
 OdXHGqAlRXi7CF+NbmVQUHUjnSeH4R0TaGcpjQgEUYQ1bvOkCKsYLtcRhtx3kiedq0W6
 K+q1ORsccHlWgFVAvpCDJOpJ516w/s3dtF5VHAvScgKTGwko4009HlKZ8xo7Vxt8NnUp
 KQbuW4UTUSarPQk0hoZ8vsvguRf5OyBl7ZI83lFN1Oq5AmOYtaTt9WW3NzU9KbqxCM1l
 QFwm5Dw520S1iKzdFkK1q65++AhZHE1OmqI+DY1SJMJX6dv24bpTUdmnWh0sweWG82ud
 Jqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780448625; x=1781053425;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AGKgT1ADvc73GkcOLam8AhKgJtIO4uzN1w6zJXvZOAU=;
 b=mDTednmEzJ1vgi4VvGrtaaFA0+BeNzIJ/okxBGtBuzomd/88eLhobEQXPA6sdhLNkB
 /7CNsWoF+Vtvy75uu+G32uSBSfo+IfHcsA5URGBjL0NretgtIQqRj50c65YWzS14epzk
 T6vg/WSTasmiWmDwlkYGEKHZ8JF/dES+XUulo+Sh1MdakZAKn6byEfuYa+KXtGI5aru+
 8UErJIdKhVNn4oPg5oiGx0CNUbkwNGBcAVZKKJa8Q12FKeqH65rvjc2E29HAgUrbm+Y5
 9qJxR5FggmGao8l0cwrmIjrmT7a0nrJ5/QccPRDr1FNy2ReFyTw70HrQgPcdLA+pTQG0
 VWZQ==
X-Gm-Message-State: AOJu0Yw3bq1uHKG2zcXozzMM0I7OqYvhNTSLgz9kjQv5eSJ/lYIXXJkb
 JCypFa3GZmeI43vjRQBt/6o7N8hnj4reTdOs80iJZmXCn5AMQSbpMQZAQpTFFGRf7nResUQ/D1I
 7Zgnm9vmV/JGW1YI0OVF443bBjdZ+6Lc=
X-Gm-Gg: Acq92OGvmPTTsNc+6zd3Hv/49lQaaFiVsQiqb2yxeXBEqZYvIUYSO6yOHtZDDcKk60D
 q19zRr3Z0cnFUL/Z0sSnQlAoTBBbFnmKz/v0LlUpygIepPzlsHIM+wgCBIrSITLa29vOA6NomjK
 hi0ncLMvPBoH+3jBYhlEvD2Ym2wuHredkrb972G0ShYVQKx/s40ovdslEgHnfy+iMEEBWe7nI/8
 JQvyTCgqhs1vo2XiNSHl2fzwkkyUgY0cgAy8Z3FZV6GEW3ODkaV1DYb7YlExhvqt2zg3Y3rlwkw
 aQe7UCndOSKOV2sepgXgU9Xb1YP6tDJxF6BfAEv7TViDlXy3
X-Received: by 2002:a17:907:c499:b0:bed:afd6:9e07 with SMTP id
 a640c23a62f3a-bf0a883b8e4mr39586866b.14.1780448624638; Tue, 02 Jun 2026
 18:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260528060007.717307-1-frank.chang@sifive.com>
In-Reply-To: <20260528060007.717307-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jun 2026 11:03:17 +1000
X-Gm-Features: AVHnY4Istv7XTsP9Es_L2fLY6aEnr5LBncXIUD7-12KrDuE-vZgm8LRyJcw7aRs
Message-ID: <CAKmqyKMaodduh8Ea4AM92tZFaA_h6hyJzBi6Ge1mueydN+TR+Q@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Reorder Smrnmi CPU fields above CPU reset
 line
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x633.google.com
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

On Thu, May 28, 2026 at 4:01=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> Smrnmi CPU fields introduced by commit: #5db557f should be reset when
> the CPU resets, so move these fields above the CPU reset line.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index d9c1e000cb2..682c6e752cc 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -491,6 +491,15 @@ struct CPUArchState {
>      uint64_t hstateen[SMSTATEEN_MAX_COUNT];
>      uint64_t sstateen[SMSTATEEN_MAX_COUNT];
>      uint64_t henvcfg;
> +
> +    /* RNMI */
> +    uint64_t mnscratch;
> +    uint64_t mnepc;
> +    uint64_t mncause; /* mncause without bit XLEN-1 set to 1 */
> +    uint64_t mnstatus;
> +    uint64_t rnmip;
> +    uint64_t rnmi_irqvec;
> +    uint64_t rnmi_excpvec;
>  #endif
>
>      /* Fields from here on are preserved across CPU reset. */
> @@ -509,15 +518,6 @@ struct CPUArchState {
>      uint64_t kvm_timer_state;
>      uint64_t kvm_timer_frequency;
>  #endif /* CONFIG_KVM */
> -
> -    /* RNMI */
> -    uint64_t mnscratch;
> -    uint64_t mnepc;
> -    uint64_t mncause; /* mncause without bit XLEN-1 set to 1 */
> -    uint64_t mnstatus;
> -    uint64_t rnmip;
> -    uint64_t rnmi_irqvec;
> -    uint64_t rnmi_excpvec;
>  };
>
>  /*
> --
> 2.43.0
>
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B48FB44CA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBjr-0008CB-Br; Fri, 24 Apr 2026 04:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGBjn-00087u-1d
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 04:18:11 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGBjl-0005iU-Ef
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 04:18:10 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-65318dafbcbso7828829d50.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 01:18:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777018688; cv=none;
 d=google.com; s=arc-20240605;
 b=M6IVYpHLl8heYGRktJS5arOyERnc6PGAqarxVXb4hWdXAV8J8X8/fBVOmgpQtcjz8M
 hcsJCdsBXwWU904JblZ8VdFX4iRWPSIarKQ9dvRUBkTLYmshSgST76X1mHOKXHNRJY4e
 FYjcfwRcoESAX0K5f+MSEQ791cf5wT+oLc+aBCcWHHiZz9EBGpBTRG+4XLMkMqiAtxdr
 GcoeWrTrOeM7YpXaRr6jkzFc5zqAZTIY0c6xthIdpOvRQUq+AhFF4ceupksXxWehd514
 +bVsaGL63XuotAuJdr9+sEVjc/zCUoeS3cd8nZgkwLPAEiMjXCW6DOcGGmxjZ2twCIAJ
 F2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+es8v43XAkTjdJFBH4kZ7UW5H2eHRKa+XKh1NneiOgE=;
 fh=fx/r/twi0lR0VsLAVqPkirIE7VN6h63K7UWTunhhuts=;
 b=PdS1AIl06kcljwXJ5Kj9iCvSjKNVIKm3Vt4NZdNmDbeYO7xhvhZ+lQbkF4PUmEwTXO
 n/xJBnuTDQdUagN3XQBsjcZaC/EkOIYPz9dRpZ7DblYhTwAugSrCSTcI5owfS62fgGqs
 KcfTE9gAAmaHZGYRluft37AciXTjttyYTVirXrCccTrIHf1TQdpnR/20hrciWhn5UaDy
 2Wz9ROLZVWpKuS30BCbZTkdLxkyDME2Za80NbP4wscVmOS1PR0L8tToAMyoYAz7wgszH
 utiVaNwmx3zculfs6OaNptwKIsYvGbtnjOVb+JcPWr9yThaXK+I3UhWJmjSYfq4iB6La
 txEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777018688; x=1777623488; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+es8v43XAkTjdJFBH4kZ7UW5H2eHRKa+XKh1NneiOgE=;
 b=ZMHWiFvxmuKyHrlsqsAfmhw3iCBwRfuS8VNugaWpeHy4RqSN2pS1RDLU6Y1reJMpnS
 DEY+JVg5a/cGBC19s0a75rg70vFVPZN01ZxaHgSAQOIaCSohBpc3jSpSRj5Tk+q7hkdn
 tLZxxUNWS2Oz9F/t2u3KLY4FMX6wcvAMX6bxafuDbK8mec3ISTbktoN5nIACuxHMaK1l
 VhhipqymHqEnsyCZHjJL25j/ceWD6Vbo+SqSORFwfHt2V0D+Zt8IpsDnKbPGe/QXmeoG
 BgJ7bbH5piw3JhZqCiYacNUNcdIzmNwjhuKhxjDOXBQzR9TE85mQ99XO+YX1haupFuWL
 qFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777018688; x=1777623488;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+es8v43XAkTjdJFBH4kZ7UW5H2eHRKa+XKh1NneiOgE=;
 b=k91fLXmLzH/Xb60TtKxCjm7E8xmpkwOKokWxU9pIYKq8XdsaVclchXyqp1bM4Tq39p
 uGYTxQ7pQE8Kobpwi7tuO1uDFFjE/hh2y7JhMOgwbM8XdTsjdB5mzMD4YGZEMU29810i
 Ef0NwpCiOV9h4GMsq0Lb1IUmDGz01EWU+sG9Wnr1mMQdPRw5ZK+MoG/g8sSboJMHXPsg
 FVspHJZjuZcPMxzXJt13F+epbZYdHaNT8IGO2nPSj0QiPcrcSYVBoJg4BcSnOoKtTItv
 hx4BsG/UdwFz09udeQWHvzZSJv9PXosX/Ub4VnO++tO/+nGXMQR09VyVUu+0UDfnBW9u
 WZsw==
X-Gm-Message-State: AOJu0YzzhvDWxSEC8S2X2nvkiJzvW9awdLmwvCiUQW5MrBmBANPsyVkM
 n2fOtt+8f0BiuH+7erPvAEzaBsFTtrbHkNN7zRWNeitMPKKbU21aPQ5Pm4Tqog+v2o6UuN01LY8
 XDGqI+7BblU4o5c3f72IFyUsl1i//Elm3wjzWf2mlJw==
X-Gm-Gg: AeBDieuAXiK3qis1sv1Tjhn8uWdIO7J84MgBlo2w3sKzn0Yl0INxjZagvD/ipvNWbsM
 REHxug+xS2JZYcciX4LKmJE+koW8lUAkpPiRSWmgNHqWRXuQdaZM4hnWP5nA+SkVMrmOqJvBt9Y
 zFrVan3NNLCZIAM+SA5TrgiVNxCVQkWwz4KE2i2bEttKoIQktQL+aXgNd/I0xmGgK9YP3d+EqGf
 2Q7AM7icVArDYuLxL4UY36/nrtAn9YtEpetFF25rdARRXQwOpQr3N1HsE0k8TOVSluL+GBdX34g
 Ij0IEmY7+nxyBHZPHBouGRU83dBoWMYYc25wifs+/F2i4uDZX1EX8rl+5VLeiTPqT9P0F6GqJX+
 PM8yJiFuTdWck
X-Received: by 2002:a05:690e:1697:b0:650:36e6:2aba with SMTP id
 956f58d0204a3-65310a4d6d4mr28463955d50.47.1777018688031; Fri, 24 Apr 2026
 01:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260424042946.3875690-1-frank.chang@sifive.com>
In-Reply-To: <20260424042946.3875690-1-frank.chang@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Apr 2026 09:17:56 +0100
X-Gm-Features: AQROBzBJnrlHU784cm6TY5vEcP9yBHmuAKv2OkUoLPuES4k237xenbR_U--3jwA
Message-ID: <CAFEAcA-5EdfWd2qZ5kjmHkMxSNWXveOUmEOGyYLQmFtHwS0-Qw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add the implied rules for G and B extensions
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Fri, 24 Apr 2026 at 05:30, <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> Add the implied rules for G and B extensions to enable the implied
> extensions.
>
> Changelog:
>   v3: Keep riscv_cpu_validate_g() and riscv_cpu_validate_b() but remove
>       the auto-enables as the implied extensions can be enabled by the
>       implied rules.
>
>   v2: Remove riscv_cpu_validate_g() and riscv_cpu_validate_b() as the
>       implied extensions can be enabled by the implied rules.
>
> Frank Chang (1):
>   target/riscv: Add standard B extension implied rule
>
> Jim Shu (1):
>   target/riscv: Add the implied rule for G extension

Reminder to riscv folks -- please put "target/riscv" or
similar in the subject of your cover letter, so that people
who aren't interested in riscv patches can skip over it
rather than wondering which of the many possible areas
of QEMU "G and B extensions" might be talking about...

thanks
-- PMM


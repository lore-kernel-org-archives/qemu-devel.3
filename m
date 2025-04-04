Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F22DC3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 03:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Xhg-0007fK-0Q; Thu, 03 Apr 2025 23:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0Xhc-0007eb-8f; Thu, 03 Apr 2025 23:26:44 -0400
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0XhY-0003Ko-El; Thu, 03 Apr 2025 23:26:43 -0400
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-5240764f7c1so717646e0c.2; 
 Thu, 03 Apr 2025 20:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743737198; x=1744341998; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5jjrTxghcQq2uJDWSvxXb3m1Wu9m74hQjWTjWNOzuV8=;
 b=YBJ0R22TYMmRC1Zdtec6An1A505n8GsyJyTkwTDhnwoLeOeu3HB3TxXz4B8FlhgSaK
 eWe8LVOXIeIlzKj2tAmq351REIFPx4enjuNIbskkmuAPZ1eZE5eAq9d9nMDMc2AIZfSv
 QmOitcpXqvgpaAFsNaQyczQIzSpTg8/NgOtt0+1qu82rvizdDkJ3hyEbeBC1xFdMNNxO
 ob3OkaC6rj+bnjztzi+7O7xyIaYX33X3zENSxOsR4bDwp1HvdxDvLYmLEI11FZYODKts
 FF3Gq4haItWHY139mhNpnXgLnm7iYI2u+SRA5ZZy9LE8GqAC7OV79/YscbvoZZbGxCfb
 yEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743737198; x=1744341998;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5jjrTxghcQq2uJDWSvxXb3m1Wu9m74hQjWTjWNOzuV8=;
 b=vHH3PT5iLU7NpWfwKYKa4lnm/k1JpOEUMfvfhMFwiiRLAR9vB3mA5pn8vtyajqpeB1
 8Md3EkHzPI+d+vKBjsXdUy9qplEyyo4sqm5ycolHqDuQOvWS/hwURUTTo/bE689F1W5W
 7J4ko0s1D6AJJH9m4pZkbZwgdxE1CHnEbHqSy3mOTAEs2TF9VXLKuYDtvJFKes+SKc39
 m8XUdXspH72hR1XGjwCNfy6aTjeE21ei+zRKDd+9Bb0+0IHIrtCclilOLUphpNKkFQLp
 RZImmzoY1Jq5McAvr4n9dsIUd06cLKFqqaathKp0kzwhXTUJ8ky+NG204lAl90O4LZcB
 nELw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZjZa2zaandTEgDBYjqe+rbZa+mFlsL0GYKnQ9kIxDNkjDuKhfr7zUfP3GdTqIymnPaNHF6uIqbLBxOg==@nongnu.org,
 AJvYcCXmQ0u5Nw8/U7+Pd7c6qcoLc385KiUzRPwPHHTmJYcE3w4bTv8+aYP5dSaROjjczK2UGJ9YnNE4Djg8@nongnu.org
X-Gm-Message-State: AOJu0YwHRBdZEd+xPDJdhZE09Q5fEsJx8y2xF5OdDrwV9ik/wRCcYmF8
 Z5SYcmy3DXcMphro6QWjnhIWNf4jOoutX36qAOQTqgcNTcHdedUNuqkC+JY/scMr7YeXbKyhJq3
 npznfNE52nwuuFAisS8I2M6mj4mc=
X-Gm-Gg: ASbGncsdPOIDyDt1r1tyYPAA1eAs+UamsCQuKaQf0jXiw75H+ftQQ7XXs5IqTmJUd/B
 pr/QCxXALOdNOLBl5FzDnT7B2Sb6eBP0O2krICz+FtMQBktw0+OxCIuxV0uvdc5edcsqggfwMlL
 A+iG3Q1iohfGkniFiwZh1Gys6kIQacSsplZkrh3nB2BLJRRnzI6tF/Ghwb
X-Google-Smtp-Source: AGHT+IF/lbf5MR8zhDsBwppFIKoI8y+wJ9MvSkHgMxkJWyiw62OEUAk7CdwN8HgQKI3NW6ySNtwwQfzS/6m+rufSJfc=
X-Received: by 2002:a05:6122:130b:b0:520:af9c:c058 with SMTP id
 71dfb90a1353d-5276447946cmr1693387e0c.5.1743737198168; Thu, 03 Apr 2025
 20:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220106210108.138226-1-frederic.petrot@univ-grenoble-alpes.fr>
 <c5c8566a-fd0d-48d1-8ed1-e52f0bb4f210@linaro.org>
In-Reply-To: <c5c8566a-fd0d-48d1-8ed1-e52f0bb4f210@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 13:26:12 +1000
X-Gm-Features: ATxdqUFi_s08qpPjeDa2HqRslWhZjGXAdyGYozjZWl5By3Wn4lbaITwTiifLhoU
Message-ID: <CAKmqyKN51+jriKkSL8V5EFc9hBSFoEHYKp-70uP6RvO_K6a=pg@mail.gmail.com>
Subject: Re: [PATCH v8 00/18] Adding partial support for 128-bit riscv target
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, bin.meng@windriver.com, 
 richard.henderson@linaro.org, palmer@dabbelt.com, 
 fabien.portas@grenoble-inp.org, alistair.francis@wdc.com, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
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

On Sat, Mar 22, 2025 at 1:09=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi,
>
> On 6/1/22 22:00, Fr=C3=A9d=C3=A9ric P=C3=A9trot wrote:
> > This series of patches provides partial 128-bit support for the riscv
> > target architecture, namely RVI and RVM, with minimal csr support.
>
>
> > Fr=C3=A9d=C3=A9ric P=C3=A9trot (18):
> >    exec/memop: Adding signedness to quad definitions
> >    exec/memop: Adding signed quad and octo defines
> >    qemu/int128: addition of div/rem 128-bit operations
> >    target/riscv: additional macros to check instruction support
> >    target/riscv: separation of bitwise logic and arithmetic helpers
> >    target/riscv: array for the 64 upper bits of 128-bit registers
> >    target/riscv: setup everything for rv64 to support rv128 execution
>
>
> I see this series has been merged as commit afe33262585, with
> 332dab68785b describing:
>
>      This patch adds the support of the '-cpu rv128' option to
>      qemu-system-riscv64 so that we can indicate that we want to
>      run rv128 executables.
>
>      Still, there is no support for 128-bit insns at that stage
>      so qemu fails miserably (as expected) if launched with this
>      option.
>
> Is this code tested? 3 years passed so I wonder about possible
> code bitrot here.

From memory at the time there was some momentum for RV128. So this was
merged with the expectation that it would continue to improve.

That doesn't seem to have happened, either software or spec wise though.

>
> (I reached this code by looking at targets not supporting MTTCG).

I'm happy to remove the CPU if it's blocking you, it's experimental so
it doesn't need to be deprecated or anything fancy.

Alistair

>
> >    target/riscv: moving some insns close to similar insns
> >    target/riscv: accessors to registers upper part and 128-bit load/sto=
re
> >    target/riscv: support for 128-bit bitwise instructions
> >    target/riscv: support for 128-bit U-type instructions
> >    target/riscv: support for 128-bit shift instructions
> >    target/riscv: support for 128-bit arithmetic instructions
> >    target/riscv: support for 128-bit M extension
> >    target/riscv: adding high part of some csrs
> >    target/riscv: helper functions to wrap calls to 128-bit csr insns
> >    target/riscv: modification of the trans_csrxx for 128-bit support
> >    target/riscv: actual functions to realize crs 128-bit insns
>
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34CCC47DD9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 01:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rePpg-0004Eo-26; Sun, 25 Feb 2024 20:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rePpc-00042f-1M; Sun, 25 Feb 2024 20:31:02 -0500
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rePpa-0005qo-9c; Sun, 25 Feb 2024 20:30:59 -0500
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-470455b5352so214185137.2; 
 Sun, 25 Feb 2024 17:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708911056; x=1709515856; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aw6ECpiZ/6pa5Zm4d20dhxdHqh31U2O8+oXwDb52nLw=;
 b=TppUJFe/9gTaMbN+7AhfO26ZptnnmS1nh/9BQNXKtsiSSSkt+4Z147FqA3HONa6pId
 uXvbjvMW7XkPcrPruOtTvAsaPqR1nMWSN7xwYfGvnlXjK5Rqj3Z8OPcaay2ebBmiiLOZ
 9t95+i6rZeSA2xSJGcgdW3KYQ5K4+S69RTxhi9lJHrUSlIIs2jLZXvBq8pz1xv/m3Ieq
 RrsMLzSm6HqMT1L3DA7UJmkeFupt/24VdHk0b1G7wm4LWxBksyMvXlfBepE5KDaLP340
 02eGFkccja8S17rOOi830w9k2AMyEmw/KziHjL4kEOdnVK392mF9WrXO13a7nLMk84mp
 INCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708911056; x=1709515856;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aw6ECpiZ/6pa5Zm4d20dhxdHqh31U2O8+oXwDb52nLw=;
 b=dz1Z4my9w1jQPySb0lPredEpEXBUBu93eoX364kfY1QDS3hXkOLhmkhLRkylBd7w01
 P7oaf71+uRGCO/xSUMlSa1rExGjmVJmR+fPXtXvjPWG10vohlt88v5Wmt7fZapoCx+Eq
 7ceIeOog3h2vkvvlmrvSa92Ru2jPjj0PwUkiJvQ+4sZl7JfMYtctfsUsVryaLGOrM/ZM
 eLlANsYBQXvyi3Unf0X4ZPjsN0TyCkqtOOfaLkQcOcluPbx8Qx+YnBPXnbl1hoopvMZ3
 +iVa0u9C3I1F3XXqIq8vdNlZjJ6W7rhodC8qlSXZjTP56iNGU3O7u0e2uFttsbVjcHi7
 YeFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1ISAdkhHyDQ1eXt6WcpWjkhbivsquMyRookD6rEncpdsQT6Q/1IKaZc5IjcYq1IRTVivRCCiJHNSmVJv56DXZCoKDuNg=
X-Gm-Message-State: AOJu0Yzku0uIfGKtSGmyna/nkenUlyV+Qw+rz9m+iTGXOK/Mt+PpSBCQ
 Yt7CdhU/j3jO5xUoeDtp02aVz/W5nY/h9BDy+W7bbX6jTynXdygV6zYgs1Sezb8/bq4LYWm5e+e
 upcdeKnX0Saq5uFbMpraZL+p4wcQ=
X-Google-Smtp-Source: AGHT+IGLe1t9cX7Xp/D4t5A62wyEMI9wSmqfdpkhsIWeStY52g+oPTF4+8HXJrnafNVcgNXL6RiVWKa/0DSctmCkvr4=
X-Received: by 2002:a05:6102:117c:b0:470:390d:41d8 with SMTP id
 k28-20020a056102117c00b00470390d41d8mr3829723vsg.27.1708911056463; Sun, 25
 Feb 2024 17:30:56 -0800 (PST)
MIME-Version: 1.0
References: <20240207122256.902627-1-christoph.muellner@vrull.eu>
 <20240207122256.902627-3-christoph.muellner@vrull.eu>
In-Reply-To: <20240207122256.902627-3-christoph.muellner@vrull.eu>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Feb 2024 11:30:30 +1000
Message-ID: <CAKmqyKNYYTZia-mSgWbbEse0dHr69JMCVN6U-u8B_8+zmF9PWg@mail.gmail.com>
Subject: Re: [PATCH 2/2] linux-user/riscv: Add Ztso extension to hwprobe
To: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 7, 2024 at 10:25=E2=80=AFPM Christoph M=C3=BCllner
<christoph.muellner@vrull.eu> wrote:
>
> This patch exposes Ztso via hwprobe in QEMU's user space emulator.
>
> Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  linux-user/syscall.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 3ba20f99ad..24fa11d946 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8826,6 +8826,7 @@ static int do_getdents64(abi_long dirfd, abi_long a=
rg2, abi_long count)
>  #define                RISCV_HWPROBE_EXT_ZVFH          (1 << 30)
>  #define                RISCV_HWPROBE_EXT_ZVFHMIN       (1 << 31)
>  #define                RISCV_HWPROBE_EXT_ZFA           (1ULL << 32)
> +#define                RISCV_HWPROBE_EXT_ZTSO          (1ULL << 33)
>  #define                RISCV_HWPROBE_EXT_ZACAS         (1ULL << 34)
>  #define                RISCV_HWPROBE_EXT_ZICOND        (1ULL << 35)
>
> @@ -8940,6 +8941,8 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *=
env,
>                       RISCV_HWPROBE_EXT_ZVFHMIN : 0;
>              value |=3D cfg->ext_zfa ?
>                       RISCV_HWPROBE_EXT_ZFA : 0;
> +            value |=3D cfg->ext_ztso ?
> +                     RISCV_HWPROBE_EXT_ZTSO : 0;
>              value |=3D cfg->ext_zacas ?
>                       RISCV_HWPROBE_EXT_ZACAS : 0;
>              value |=3D cfg->ext_zicond ?
> --
> 2.43.0
>
>


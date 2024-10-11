Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E1FD24468
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 03:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz6mC-0002yt-SX; Thu, 10 Oct 2024 23:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz6mB-0002yc-I8; Thu, 10 Oct 2024 23:57:15 -0400
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz6mA-0006Lv-7R; Thu, 10 Oct 2024 23:57:15 -0400
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-4a3a62bfda2so449614137.2; 
 Thu, 10 Oct 2024 20:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728619032; x=1729223832; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lbd6mEllPcq9O99SItDKq5tKxesjji4CK9XXhQ8borc=;
 b=WuBDdyK6cZrJfDg0uPe5r0StO2F5RmiHS4YdfgWvvLlWy8z4rulxDkDpANpVVJDp5f
 GKOaNkWgewHlynZOCYZ1jGBy/xRMkhIT/uxunf+Q1pPzRZFKcxpHxgogwFm3CKJFOQ36
 9uU6sZrwFSFgqGJtq0gSWTuKr4uDlhv/+mrzaqyhh4I4sr1Xz0jWVGH8wXW2RPyyq42q
 S+hUsLUt+p3NCqft8hNWiOj+CMYI99vf8OEbTMlcbkE3uxI/GNorZfXuHkC03h0QCfO8
 O6l+xqQS5WNKfxtUWMsb7Gic5chmGvyopsws7xgvNWkAlqvNu4MxzDx/JlKCYxw3WfbU
 N24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728619032; x=1729223832;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lbd6mEllPcq9O99SItDKq5tKxesjji4CK9XXhQ8borc=;
 b=vBDBjJqFdk2uzna+6whadgb04bZWXxCrwcrjvBa49kCblja1IS4Je62jS0Tl0422w6
 gLgCs0ma1DL0NCZpX7ciQp+rxk5VUnY5lc357fcCepglXWBbjPoDnPoVt5MiRwVGVCj7
 mMVUZhIITVg+yxyjk0Wwfuu1evNO+rqS9SpdDISMjm6UMwhYX84aZQQ+FHy59PTiyq5r
 f+wYn2FHEL/RooRvpnhIMLo4oQzQqpd17xbel7wzyAF6DnW1fpDCDQ6YdvUTGQbPkmxF
 jPdrKUn5YemxlrtvwbZBpLoeODKY/l0MtrtqLlU4NFD3329doCQC3cCkz2y3GCjQHvQw
 mHug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR6InUBQNPHfw2Vk2mQNx2o3JPO4vCVdn/2AGVxfTV4Bn1dC8tkIrGCNXrUzYulFEsqme/sxKLiCUG@nongnu.org
X-Gm-Message-State: AOJu0YyVDIzrtip0pGIbEOA9mVuGkmfWzwcHvBO6ewZDDRvtvuQe1Mi0
 DuqbvViFhZHKINRY9B0LbtDZ4sgRL8MWYe+QLKL1PvOBxAh3hCRn0qtnj5mnh2YrxWZ49cOVgF0
 C55zBPxHsCzLq0pzyq3gxuuxHNlA=
X-Google-Smtp-Source: AGHT+IFSnO/W8K4C610B8GR2U+h9N7q9IKwcGpYWUb8Gpd2PssifXenaTsnbCpyREbqnN1f+reYte0j/5ALynkYwupk=
X-Received: by 2002:a05:6102:d92:b0:4a3:adc4:1f31 with SMTP id
 ada2fe7eead31-4a4659727bdmr922647137.11.1728619032668; Thu, 10 Oct 2024
 20:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241007033400.50163-1-zhiwei_liu@linux.alibaba.com>
 <20241007033400.50163-8-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20241007033400.50163-8-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 11 Oct 2024 13:56:46 +1000
Message-ID: <CAKmqyKO4iyAmyNcEgiD2358D-xHhg7DMJ1gQY0MZ7M_0HXkOUg@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] target/riscv: Expose sxl32 configuration in RISC-V
 CPU
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2a.google.com
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

On Mon, Oct 7, 2024 at 2:19=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibaba=
.com> wrote:
>
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>
> Enable with "-cpu rv64,sxl32=3Don".
> When sxl32 is enabled, RV64 can boot 32-bit Linux with
> 64-bit Opensbi while requiring to make minor modifications
> to the Linux kernel source code.
>
> How to patch linux:
> https://git
>
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 9dbbb1ca77..86984b7f8f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2665,6 +2665,7 @@ static Property riscv_cpu_properties[] =3D {
>
>  #ifndef CONFIG_USER_ONLY
>      DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVE=
C),
> +    DEFINE_PROP_BOOL("sxl32", RISCVCPU, cfg.sxl32, false),

I don't think we should add this (see the cover letter), but if we did
it would need documentation

Alistair

>  #endif
>
>      DEFINE_PROP_BOOL("short-isa-string", RISCVCPU, cfg.short_isa_string,=
 false),
> --
> 2.43.0
>
>


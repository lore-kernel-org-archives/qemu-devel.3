Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4FFD24468
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 03:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz6Gd-0005ea-SZ; Thu, 10 Oct 2024 23:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz6Gb-0005eE-Tt; Thu, 10 Oct 2024 23:24:37 -0400
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz6Ga-00034A-5o; Thu, 10 Oct 2024 23:24:37 -0400
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-4a3cb61d179so557946137.3; 
 Thu, 10 Oct 2024 20:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728617075; x=1729221875; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ro3F7f0munhdiKT4/ccPGJGATl4umMaU/vAAlJk9tLQ=;
 b=FPUUVKxIUDFZUbIItbvzVGNWByZtkbXS5D1Hl3Y4UCleab5lBJ8nJy1JAM8VxaxiMF
 5PhNGPT3+ev2WBk/Soc71aMktxtxF0TTQ+ZohwdHqBfRPiCBFvlyQRMP/bNHDzXJ10vx
 2UziS3oYM7vMA3HY7SV89lqgQzVB06qB2XhNi2yl7zKqkwG8E0PU5ktJwXPTj/yM8D3u
 q4kf0ovWDD5+G2ooElGa8VMtyl23cbAiDANRivpbmI06CwkZZkthhgN1TA7qC/clEG+Y
 ARraUBKa2HwJfPC1SR4E9OG+W/zqk1M4fg6iKp8BU7lJeUgC9QMFQba7dZ8uLBsZjcvf
 YvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728617075; x=1729221875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ro3F7f0munhdiKT4/ccPGJGATl4umMaU/vAAlJk9tLQ=;
 b=XbsaEOFKspzYifyAOcvMqMU+rQ0uzuvlwUfhOUWue+vLj/nU4e9ydtHUiPq+PCyL5P
 Lx4CAkoQWvES6VzkIZKFxToGCKon5qE35VgWFPo51Qx3mSGylhY+EbKS2fu2FYx11jEC
 AvL/A40IpfluqhWyZ6EaJQpzcCoCTB1eS0Sr+lmxryAo4+pdJdrV4QVbqHNJ1pd0zCaC
 jn55nzAkNzVEcdVtsk3hCD7DaR8Kg0jtBoaGehDBpMsfVQH2BHywv2CC2w6UxGmQBsPt
 PaAjs/wVCoDYXa6PP7+UkUfT6gupRnCgH5aCd5vgW2LA2+6647c9aUzJb0WW3vAK2TI2
 KjWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1cnX79/fnJrG6pj3e7DZA0MSIvUwt2esbQjlWZaKW2ZaX/vK5AL8ZGaQ9/Qk0TK4Xu8TThZBcGtV8@nongnu.org
X-Gm-Message-State: AOJu0YxSduKS/1EdhmgH1KUqpHKl1X+kP6L26rSIm8Lyo3eVfwHFolE4
 B3aNWKgI43Uvlpx7P+t8iZQz1i8thdes8sMe+QNUpgfHAPFC4gqVE5UHB8uMxrIqPVn0UnCIk9B
 Up3KUgtB0t/Z4/Zb7TU5wu5PrwmA=
X-Google-Smtp-Source: AGHT+IFZ9RwuBemGfXft469YqpU9c8M3c4227CezgLOhNid/jnxVQ+m5tNi3xnpji0yl9OJaNZCDlQg0EbrUY9Mvkls=
X-Received: by 2002:a05:6102:3e83:b0:4a3:a671:9f2e with SMTP id
 ada2fe7eead31-4a465992eb0mr928888137.14.1728617074769; Thu, 10 Oct 2024
 20:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240925115808.77874-1-cleger@rivosinc.com>
 <20240925115808.77874-5-cleger@rivosinc.com>
In-Reply-To: <20240925115808.77874-5-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 11 Oct 2024 13:24:08 +1000
Message-ID: <CAKmqyKP9-WQLvMqf_kfb3tSH55qP9hw+swGjsg3uVWD1QhFVDA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] target/riscv: Add Ssdbltrp ISA extension enable
 switch
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe36.google.com
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

On Wed, Sep 25, 2024 at 9:59=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> Add the switch to enable the Ssdbltrp ISA extension.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
>  target/riscv/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 65347ccd5a..4f52cf7ac0 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -190,6 +190,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
>      ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12)=
,
> +    ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_12_0, ext_ssdbltrp),

Shouldn't this be PRIV_VERSION_1_13_0?

Alistair

>      ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
>      ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
> @@ -1492,6 +1493,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
>      MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
>      MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
> +    MULTI_EXT_CFG_BOOL("ssdbltrp", ext_ssdbltrp, false),
>      MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
>      MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
>      MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
> --
> 2.45.2
>
>


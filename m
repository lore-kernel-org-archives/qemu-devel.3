Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F47FC54744
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 00:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj692-00025B-LL; Tue, 27 Aug 2024 20:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sj690-0001yL-Rg; Tue, 27 Aug 2024 20:02:38 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sj68z-0005ix-EJ; Tue, 27 Aug 2024 20:02:38 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-84686812614so57414241.0; 
 Tue, 27 Aug 2024 17:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724803356; x=1725408156; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6FRhm64ZgjE90bXGo6bITeypzsK9GStW2fuuovzPrLs=;
 b=N7seZTFr3vTynB6GfDj9F4YIwUfiu3vI/B7CexvQ1hrWN3zVVuEEcKJKv1lR4ILzur
 CFUyHZFDc3gWdgJROfQ80l7G/F2xaxnuStYte62+YRSBTKSmUdY4bAyoyf/ocjDvT6TN
 pF1ACZih8v5ttDuEzosgRxTQKmsv/tafJCdRXKo7qGO1UgHI1BINH4yt65+nsZD6JJSb
 HjVGKQBxaSab2JABSdaLcj7z5gvyiWLEYrM4qNPG4z5L4VS5gtfO20c6dhtHevwjEEFW
 sUl4CVhHtCZIFiEbvC2F5GmECjMi9PXNVzJ5xwx5apQYmTSSM2kztQudfDzVlYc0vFXC
 pzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724803356; x=1725408156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6FRhm64ZgjE90bXGo6bITeypzsK9GStW2fuuovzPrLs=;
 b=JaXUsWX9zTCgYAPnzYW21iA/n/j703lOb6z4c6d6DQ//I5svINBSUZgYyaIJ+sFQFT
 zZHMzpxH1X084QQczDCO0fruaXD4GPuiDRqxEuuxjxPbnXI063hwbioFT4tkarz492bw
 Sk6j05mY83DqL5XwCaAVk/9PtYZ0G412zAUho3nZQ/tPEwZTm0YSl50/PvrYK17DvqL1
 5Wqqret9Jmb5raCXSThbafaClfhojKRSh3xjnqO9hxtdVd4NlZh28KlUIAbSlgaD3LC+
 KZkufsL0k/IJ/7GxM1YkXy5oeLL5WQSL4PZuzxa1ZvsunY3O9dQePJTUlAuYwO2cpP95
 Uaug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO4kAn2HUmGVDQ7wKrt2s79JGQWeuIzJjVGdocoYsos/m4mPH7P/f4F0+DCEYLtDfbl5MUjTAqunHF@nongnu.org
X-Gm-Message-State: AOJu0YxtfZUKVAhN51rWgRI+2J7ugx9780KAUvYOAPsWP8jrLQV7tvJY
 1i9244UjR00cyzOpAPW/pwoLFmEwzGomjLWnKSsJXimQlmbaiK94k8N3zaKV2ZfPb6edc+oCtPJ
 F4XH5bE9McZWx69rAoZQDQIeAH3M=
X-Google-Smtp-Source: AGHT+IFF/y1VD1R5Sk6IxJYv2OA9W7KfDCpUGah7boe0WPIuqb30O3Z0olSSOI5ATdKDP1rmv6iMHFTs6TJJ2woRg60=
X-Received: by 2002:a05:6102:26cf:b0:48d:a44a:aa00 with SMTP id
 ada2fe7eead31-49a4e44c4c0mr296246137.14.1724803355949; Tue, 27 Aug 2024
 17:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240827231906.553327-1-debug@rivosinc.com>
 <20240827231906.553327-11-debug@rivosinc.com>
In-Reply-To: <20240827231906.553327-11-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 28 Aug 2024 10:02:10 +1000
Message-ID: <CAKmqyKMR8CoP3V994LuurZMcLfC0zaLUvtdP9oepFOwvTnMUPA@mail.gmail.com>
Subject: Re: [PATCH v10 10/21] target/riscv: Expose zicfilp extension as a cpu
 property
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
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

On Wed, Aug 28, 2024 at 9:23=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 2d031e3e74..8e1f05e5b1 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1476,6 +1476,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      /* Defaults for standard extensions */
>      MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
>      MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
> +    MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
>      MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
>      MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
>      MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
> --
> 2.44.0
>
>


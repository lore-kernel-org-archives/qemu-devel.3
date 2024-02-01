Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AAEC47DB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 00:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVL0f-0006ag-0I; Wed, 31 Jan 2024 19:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rVL0c-0006Zt-Mn; Wed, 31 Jan 2024 19:32:50 -0500
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rVL0a-0008FP-Uw; Wed, 31 Jan 2024 19:32:50 -0500
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-46b3e293834so161590137.2; 
 Wed, 31 Jan 2024 16:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706747567; x=1707352367; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g6NPI/lokbfePtwXRpPdEVsHHmFxVLKrYEpREnm5lAg=;
 b=c6pffra3QCygSPtZdvVDQOseLvTFSZ8jehPRQ+2sHxKuvooqkR16F9yftLQKRAOpB9
 BqGI1XOW/HRm/eDvOZt3Z9QUIDANb1jkQUg6U7b1OurayosAvO/ILRD/68bw7iSBSkjH
 Ij87Gr81pqRPnqI/Hp+GJWO3WEzKAdtSgk5X2Zc5yh4eRZq9cKThE86VZDgEtzsmFkfm
 v0A5MRrVZ3n4O9s6HIhsgx1GYJeY9BCys+k3Zz7zK7u3B0uM9JY//o1Ko1ZESxdlGild
 Uj57WEwffgOpuF6IVsWWvAq26DZ0OjHkdsKNV++QAh0mCm0Ivy5sQPZY04zsNvi+xT56
 OjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706747567; x=1707352367;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g6NPI/lokbfePtwXRpPdEVsHHmFxVLKrYEpREnm5lAg=;
 b=Nb6tQ6T8GGVj2ApLTAWCw4IT91VZqgCXBNysAGqnQQ4kNOHPSnc+ecwPFd8yrH+nR+
 fZXdVpQ58sDUN6Dyun/u9QassxGbVvQg+39EBkGD4hWSmJ02qHk18f9v1yOypfF0zEd2
 o6vPy9hFkSuSGP7pOGyV8EQjDYWnnDbgCQ0qvF6PI98sGO4Qy+NUn4u97uqOyYEXgPjr
 0J7Z9le6fNT2XrVpdTOPg1EiXS2Y1yiEd02TxKlh2GrbeTFyjt4SvRvvCY2rlwNA6Dq8
 VMqAGVai/qs+DxiNAmwmdoR90PoDMa3HPYQLNwLbQcrFefX5sMGQl42u0K25Om5pB3X/
 MC7A==
X-Gm-Message-State: AOJu0Yw9z4hmRpBslkrRG67c693BEByeg+tj9fFkkIolsBiWS7rpl1Hz
 cL0eLWh8ygN8NfrtCeynRf+lv0jy/UCmulrM8sjRTDHWQnhel09lua+s5PawWgU+jyPWrRea4nU
 QorL1jQBZhLxh0wCF9+UBOGZMiimeq1vH
X-Google-Smtp-Source: AGHT+IHqHO2PvnhENj8FY0l+ZVLGt/oAMBgbkWIT8B7vV5thd9q9HNTJIR/blZkqEpozNSC/Gzlk+Z5NLYOdCUVZ+Po=
X-Received: by 2002:a05:6102:242a:b0:46b:460:bee8 with SMTP id
 l10-20020a056102242a00b0046b0460bee8mr2853324vsi.27.1706747567400; Wed, 31
 Jan 2024 16:32:47 -0800 (PST)
MIME-Version: 1.0
References: <20240129192207.2946870-1-me@deliversmonkey.space>
 <20240129192207.2946870-7-me@deliversmonkey.space>
In-Reply-To: <20240129192207.2946870-7-me@deliversmonkey.space>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 Feb 2024 10:32:21 +1000
Message-ID: <CAKmqyKOOCY+vZ1uFKkEUudAfPtAAp5rsOgjM0tSXXMFBcoP9EQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] target/riscv: Enable updates for pointer masking
 variables and thus enable pointer masking extension
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2b.google.com
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

On Tue, Jan 30, 2024 at 5:24=E2=80=AFAM Alexey Baturo <baturo.alexey@gmail.=
com> wrote:
>
> From: Alexey Baturo <baturo.alexey@gmail.com>
>
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d8de1f1890..bf431ab728 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -153,6 +153,9 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
>      ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
>      ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
> +    ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_12_0, ext_ssnpm),
> +    ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_12_0, ext_smnpm),
> +    ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_12_0, ext_smmpm),
>      ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
>      ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
>      ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
> @@ -1395,6 +1398,12 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimenta=
l_exts[] =3D {
>      MULTI_EXT_CFG_BOOL("x-zvfbfmin", ext_zvfbfmin, false),
>      MULTI_EXT_CFG_BOOL("x-zvfbfwma", ext_zvfbfwma, false),
>
> +    /* Zjpm v0.8 extensions */
> +    MULTI_EXT_CFG_BOOL("x-ssnpm", ext_ssnpm, false),
> +    MULTI_EXT_CFG_BOOL("x-smnpm", ext_smnpm, false),
> +    MULTI_EXT_CFG_BOOL("x-smmpm", ext_smmpm, false),
> +
> +
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> --
> 2.34.1
>
>


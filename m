Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D7DFD9E1E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 23:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvkrh-0001zQ-N8; Thu, 26 Feb 2026 18:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vvkrd-0001xo-74
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 18:33:49 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vvkrb-000892-PU
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 18:33:48 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-65c4152313fso2060114a12.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 15:33:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772148826; cv=none;
 d=google.com; s=arc-20240605;
 b=hseHx5jqx63J4Eq6miR5tyhZmiI/GU5jsyG3JamgHxdkgYJsPGWglNeBd2gutKLNDO
 OYwsML9f17KHiS3UFImyNV6CO/4Lcay7Hcxc/gn+sp+lCuD7Ugl/kUEHpdgmrMaSujDS
 qEvc/oA7RlmewEHAzFyOMFjcIz1O4m+v9/LsL5Z+dN2HtyedIUO6Fo3IhHmF9dkIuefv
 O8QwRhLGubVvEiiudotHRBNx8z7Kad63lAhHBwmY83WfuJ13LyaAy6/Kje0dXixTJ24P
 wN70uzxFdXFQph36tY5Dfklq14/tVEq/otcU3ZT7bxrB3W33PhtEMOnKw46ytd4DnsfG
 f9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JMf2ZRkTSLHI5o4DU1I+pHxJgLMlTHOF/aTsRAwy9LM=;
 fh=02yfZO3MCi97EyXeoLg1BYIgpUdGEMk3Yh61+offrCA=;
 b=fuI7gTzG5n/WoYaeHvNQ4o5QhIoow+njj15QslajPCMNh489FuWbnBxJs4fh3wvJh7
 gvKpA/8jNLU4obG1AbirpvPtp8aT9PratoIY7LyXHXbrHYxwxJ/cWxTGQxJh7ZILxCpu
 Bm7/vcS3CVlk6Ng2oQMX3+2rzDUSu01CPz/U/liQ1kyGqkXwCNiJ3DcEGkD2xUhBdyB+
 6tkRpFoeXAgG16aQQKXCkdp8jDck2d8jNxMNXzMWR/c95+haMNA4I85vQl2Nr/f8V77r
 nG+/LVZRpyapZVtVFNUEw1stUWF6AzZbaTkI8jrtCblRT42hSWXtMY9IhXCaCc5Icn02
 OyCQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772148826; x=1772753626; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JMf2ZRkTSLHI5o4DU1I+pHxJgLMlTHOF/aTsRAwy9LM=;
 b=gSuBgdr4B1QgOPGH/2N4hbhtLoVDU2alDsZIPZVU1l1GQCuYm/Y3u/I+mSKqwVm9lu
 6uCFL2Y35Wspiq9DXCJE3nvrgvzcBHZBl4B9dHPnNsbSOYPuhcouHb9bynXAmq7w8qhb
 2Kb9vnh581Y5dy1LsQo8JJ4Dg6qswXzGvT9LAgaSowyAwFMrcS1tCvPKe6XtCMflVDqu
 0mh18d0BvgPO7MS2ijbmawEFd9E/EcUe716hSaTMqZkLCpCh4UyZLsNgU0YgX0WUMG/2
 uFvHf4m9BguTD0c9qx0jQqWTbEmIuVC7DzLS6NOBzYnhTnvoqEScojlKTaGIJ5P/h//j
 f1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772148826; x=1772753626;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JMf2ZRkTSLHI5o4DU1I+pHxJgLMlTHOF/aTsRAwy9LM=;
 b=EH9dMUQpTHMZ9CPrHnjV6F1jEblUqBDQnLu1RodviWGeodjCghWjqXIERxLZ/NQuDQ
 b3hiByiRpG2gBUzmmCJ3MHKPNFihrm0RYv7mNq2jqrM4KCJQ9uXu4y46025NhLOsUADT
 VZYB2c8008qV555ieSrflhPYsXxKeq7LK+47X+GBpnO/ZVVS9G6rQ94VPgkDITf6asex
 dsINWsbliGPn+b2eSRMsTDzvMRVjoTQqxIiHB/i7OWspaX+sQzFEevqpMjW7SG6jf6Rs
 VO92czojtJCFCy3siXq/eBo3LYeWP1CXpYgX7QB+ZMt4/2yImc42u7KnfXFUktVK+67E
 XblA==
X-Gm-Message-State: AOJu0YyFO/NcXi9r6Pfk0zrjvoFFZX1eHjtsvHoWxPeh3+NNcpiNEltd
 OMAN+DMbnLK7QoQEApNapd0HtuwN/HgEAMIE9VbiuIx1tKPFCSEPqEJLcVa+MJhXaorhVBHX8ze
 GWFoa1FSYHBD2JEnvSl+yl3gyE2QdZDI=
X-Gm-Gg: ATEYQzzOOo2nH+uc+0jF0EUJYAvD434swhoucgjTzS1kr7d8rPGU8pzoMui2EvDkaD+
 YDhkmx2q0/9FEcXAEubxP2f91vbzn7Xi/UbdBtwl4fd+pmehs3uXJFKZyeS5jOAVKjm1Xqpm3xo
 HkzBZV49PdZdeFRkzNP/wqLpt000SfSL0pn0V6hu21XyXyJ27ia8/nRRWRBXl4geSdX9YSeQYs0
 0bKFb7BMbchRV5OCbK9KRqmKkBejD7k//4eo0ARBVSO5yFJY7+aOaHhBQipee7+V3Ai6xXxNPCi
 to60h9WHPAT9MWG72+Fv50MPMsBhLLJgKWyATA==
X-Received: by 2002:a05:6402:f11:b0:658:bf8d:c92b with SMTP id
 4fb4d7f45d1cf-65fde4cdcfdmr393771a12.31.1772148826274; Thu, 26 Feb 2026
 15:33:46 -0800 (PST)
MIME-Version: 1.0
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
 <20260225102016.200654-12-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260225102016.200654-12-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 27 Feb 2026 09:33:19 +1000
X-Gm-Features: AaiRm52gPpMG35iEd5M1HUdmYsPhtJpel7r8Nsvzry4UWY8RGOy34Ke551-OVEs
Message-ID: <CAKmqyKO=aQUWZG_DqvCgKYnME6UGVWn6Cyr6z8v1OJ=d84f6ig@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] linux-user/riscv: Disable vDSO for big-endian
 targets
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "thuth@redhat.com" <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52b.google.com
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

On Wed, Feb 25, 2026 at 8:20=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>

Why?

Alistair

> From: djtodoro <djordje.todorovic@htecgroup.com>
>
> ---
>  linux-user/riscv/target_elf.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/linux-user/riscv/target_elf.h b/linux-user/riscv/target_elf.=
h
> index dbbfdf54d3..6f416ac3e2 100644
> --- a/linux-user/riscv/target_elf.h
> +++ b/linux-user/riscv/target_elf.h
> @@ -12,10 +12,16 @@
>
>  #ifdef TARGET_RISCV32
>  #define ELF_CLASS               ELFCLASS32
> -#define VDSO_HEADER             "vdso-32.c.inc"
>  #else
>  #define ELF_CLASS               ELFCLASS64
> -#define VDSO_HEADER             "vdso-64.c.inc"
> +#endif
> +
> +#if !TARGET_BIG_ENDIAN
> +# ifdef TARGET_RISCV32
> +#  define VDSO_HEADER            "vdso-32.c.inc"
> +# else
> +#  define VDSO_HEADER            "vdso-64.c.inc"
> +# endif
>  #endif
>
>  #define HAVE_ELF_HWCAP          1
> --
> 2.34.1


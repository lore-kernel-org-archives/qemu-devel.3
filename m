Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21B1C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 03:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugagF-00033d-5N; Mon, 28 Jul 2025 23:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugaex-0002Yr-5A; Mon, 28 Jul 2025 23:05:50 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugaev-0003ll-Dz; Mon, 28 Jul 2025 23:05:46 -0400
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-8815049d0a8so1375159241.2; 
 Mon, 28 Jul 2025 20:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753758340; x=1754363140; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mdtrf94nHFev7ks8GxZiX7q/CXnpYARSwvuwIpPObFU=;
 b=jcbt1L2vFTnFr03hQvttdKcsiVAVbooMjQ1kP95VGEwit5uPUALrQDwXJPwEyOGr+C
 OMs/qyY/77O6gLNwe5L44MEHlQ/dztChzBmhlDC46gc53euHyVuZGMLBMBV7svFfl2d8
 eb04D66s5cVd09XPXQu63KIqVsYr19yL4y6Lrp2lAw+halAVM96R/qbRqqpDXARXYOiI
 y8CCIhzyKfTG8/QPcxmytCT/2LJiirDPhbwye3BisKW8AyjRFvhT90Nha7jBewf8UjcO
 C+OfmjuCJKFEb8GcMPvMs0u3PAEk6v2BaPtUhfe2rDz2lczwjtIlVYZjgr78YX7iJnmf
 XHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753758340; x=1754363140;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mdtrf94nHFev7ks8GxZiX7q/CXnpYARSwvuwIpPObFU=;
 b=Y0k3ck3xpzkmOMbrlwva7hqgpMhsP3DUbso92ztpzns5ndqwSI+Wd5/rMvL8QpPc6y
 TQvUYGqnheRbp+x4GGKiYOOuhyBg28UA+VOkoc5YKtRJTX4NjTgALfMvy/cGu0YAqwp+
 MVCaArCgik3/zttBj7hzALewhimsjxy7Dl30NKdFcqJp9tY1aWLLGZxgIWRQU5aCkFuB
 IbYR+EcWeYANFtSMFuYv0g8o/oEpgXzKhgR27EV1ZCbV2+eRGz9H3txCUpXKltRkvjwx
 TQZ+/2Tp//3OC/9Jv9cJIG/Bww63Zzv3LxvgdY/jxZ3AnEfikNcTxCPf/OHfncHUDXts
 Zl4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkMh0ZIC4o2lq0WVZJIPDUuntQVqfEIGznKIZZrCxvEQnWHNAgiCNEAj/xclrCVDCcDcgsCnzeuNmb/w==@nongnu.org,
 AJvYcCXFYmbtyySTTk9LlF1uapUc0isW5wqGVIYL4wna+k9npQExN8TVbjt+OYV0bI5DykGFjRVejIRIGxuw@nongnu.org
X-Gm-Message-State: AOJu0YxmYGRlfeDPQFfdRgRXFB/yvR2H3x8FmPdOn06BUWpFn1GtR39g
 igRcL4D1mAEEncGRARATMUexNvjUHttTjoSrj9kCCZ39Kk0/Z6dXv/EYFJLN4tvVPQ4UDvF7EuR
 eubgRTt8oDFzNemt60e9h57F1YaDENbE=
X-Gm-Gg: ASbGncuiP2qJa2iM7uDV9e0uTwrt5pFaZOwCvBunANZv0IqaZW5+QfkgqxiXq3pv7wN
 RLuZrd3YUcaIF8hJP4vXUTdn8ufGLt9MbO68SbJJObOvZawdhTinAWpFCPEEK1bqR/XEL9xfQVE
 26Lgsmh7x7gus7w+qNT7X4A95tRw7qUZUcScx11r7rrUP9XLlUXZMfHvfwYLUVYaT0TlKCEe8rY
 QGsbbBQomKw470NOltHcEG2/CWYcIsJbZzyLsrUp2ESDU8+
X-Google-Smtp-Source: AGHT+IF+YbmZcro/Sx/FfrWR6LSedURZBZE2f3OajTfdZlLsHtFkpd40KpSaNEzTKByB1OLZC08k4WpBdwpdAh65oak=
X-Received: by 2002:a05:6102:955:b0:4fb:dcde:3fa0 with SMTP id
 ada2fe7eead31-4fbdcde419fmr244383137.9.1753758340301; Mon, 28 Jul 2025
 20:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250728055114.252024-1-z_bajeer@yeah.net>
In-Reply-To: <20250728055114.252024-1-z_bajeer@yeah.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 Jul 2025 13:05:14 +1000
X-Gm-Features: Ac12FXwI-4QK-r4ivnmZezg14roEMS54waB0VBDbppGam0oUx4cBQ5sACXn0Fe8
Message-ID: <CAKmqyKMjcO3aCmJrXO+stPMiGW=55QGFSMOvj7vby-Dwp7ut2Q@mail.gmail.com>
Subject: Re: [PATCH v2] intc/riscv_aplic: Fix target register read when source
 is inactive
To: Yang Jialong <z_bajeer@yeah.net>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, yangjialong@rvcore.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
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

On Mon, Jul 28, 2025 at 4:10=E2=80=AFPM Yang Jialong <z_bajeer@yeah.net> wr=
ote:
>
> The RISC-V Advanced interrupt Architecture:
> 4.5.16. Interrupt targets:
> If interrupt source i is inactive in this domain, register target[i] is
> read-only zero.
>
> Signed-off-by: Yang Jialong <z_bajeer@yeah.net>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/intc/riscv_aplic.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> v1 --> v2:
> - Use '&' replace the error '*'.
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 4fa5f7597b..a1d9fa5085 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -628,7 +628,7 @@ static void riscv_aplic_request(void *opaque, int irq=
, int level)
>
>  static uint64_t riscv_aplic_read(void *opaque, hwaddr addr, unsigned siz=
e)
>  {
> -    uint32_t irq, word, idc;
> +    uint32_t irq, word, idc, sm;
>      RISCVAPLICState *aplic =3D opaque;
>
>      /* Reads must be 4 byte words */
> @@ -696,6 +696,10 @@ static uint64_t riscv_aplic_read(void *opaque, hwadd=
r addr, unsigned size)
>      } else if ((APLIC_TARGET_BASE <=3D addr) &&
>              (addr < (APLIC_TARGET_BASE + (aplic->num_irqs - 1) * 4))) {
>          irq =3D ((addr - APLIC_TARGET_BASE) >> 2) + 1;
> +        sm =3D aplic->sourcecfg[irq] & APLIC_SOURCECFG_SM_MASK;
> +        if (sm =3D=3D APLIC_SOURCECFG_SM_INACTIVE) {
> +            return 0;
> +        }
>          return aplic->target[irq];
>      } else if (!aplic->msimode && (APLIC_IDC_BASE <=3D addr) &&
>              (addr < (APLIC_IDC_BASE + aplic->num_harts * APLIC_IDC_SIZE)=
)) {
> --
> 2.34.1
>
>


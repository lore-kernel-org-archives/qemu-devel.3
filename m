Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CDBCD6E5D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUa5o-0007kX-J3; Tue, 02 Jun 2026 21:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUa5g-0007jc-0a
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 21:08:17 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUa5d-0001ON-3i
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 21:08:14 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-beb8a08a6c8so536690466b.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 18:08:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780448891; cv=none;
 d=google.com; s=arc-20240605;
 b=IQgj/aTUoCePTkEdEXX3rD3hnRAqEI3jItHxAq1IAouyLEWsGs+6/tmOUudKZWRG2h
 2yZdNKXF7s2yV9KPWV4wWffXNtzMoOgLHYdv/tM7Ty9+ekiPvgQ8H1AaN2UcsK1VJt7v
 TdPD9is++Er2NCSPDId4qGHa9dVV4bcwn9bXIScdenl1WsjXTkO4Q9kgIdjf70BuhkU4
 7tHw6JXw1n07BiA0P3dlp6zP09jzHdB+daDOLY6otTxPLsyg4ceamDT8A6SxQMMR+pME
 aUGUBfVIN+vh3wcKtLFzo+Vrxr4+/Rqjn40XWDVWm8CrlL4yz6wr/MwSoVMmbYW/Zsg3
 I9Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/A0gDiDTrxy+ELN91nEDe4UfA59Q+zNnrMTKM/ccYRE=;
 fh=fx/r/twi0lR0VsLAVqPkirIE7VN6h63K7UWTunhhuts=;
 b=Nx6JROWlagbFUVz6GLgCeA5iROq9Z716Dsy71o3H5bnDrIuTReC98HgpgzUHtEmjoK
 SK4BkOnYPB7J4i3U7guUCqOI/UvajMQW7WwUL14L+bSGIlPCIL3fF8UHYjmTZ2Nu5GuN
 4XOT0JspRnkjjNgcHG1agcOxzVryHAlAS2GsMfeABsGkVMiRRra+ttMOxuuQ7NC0mQRE
 kmC2cbyWZklGfBqhmnhfh04nO5pkWC3I4JFg4LjmOtz+w9rk29YGjY2a1ntP9ab7MvKB
 S5HEGSph6v8NNKd2goNL1rQmVkljt6f1EqBzRPAKXDWB0GDdjcDQ9/L2RQdafabeHWmE
 tr5Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780448891; x=1781053691; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/A0gDiDTrxy+ELN91nEDe4UfA59Q+zNnrMTKM/ccYRE=;
 b=eLqIU8Rm/hIpK9ebW//4LbI0BfJmmpETmh9k0x3HFAnAOG7r7zpOLxoCwEWHybeJ8D
 uarnM7uE+LuNDcT93iYEOM0TgO/TswcAso+rWB7SPutJWqeaySjWja8Z+BLpuDyZY9Cx
 09RqEZdbHmkHA6vwOTFBXNnkKa61P2DhjFll6GKzSHgyGVoVs72ExhvnBpcg2eLxxjnd
 Atwt1sLLNyMKTsovDnekvxIKpu/dHoJhGw3Cgn8A6RnBU43gnVI/ktzPZCVoxl79nktA
 FjmpxVcdlKIopF6EOIlHfYcL3ZoRkirIfePc8bpL+n+DiXyBOnbprvW89JasodLdrYIA
 do4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780448891; x=1781053691;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/A0gDiDTrxy+ELN91nEDe4UfA59Q+zNnrMTKM/ccYRE=;
 b=sBy7L38QP0LjG/+EkDv2KrOTk8eecYQHNPFeQo2u7CKDr+ACXRFJEkasJx+QZD/nmn
 vdIIqEU00M6adezjKzE+bHBWvFc5k5WDCsGtDcQkDPEpH2LP3uX2u3BSJtuQ4SW99S75
 jN+lV+/B19KavWXGS8dVKUIc8ywF24lOhOqTRgYjrYnWTfY6e63dew0RgFQjQs1EqLEu
 j89FQj+Nv1RJrWTmUL03Ko+G5zTFWFN2r2VKFibHesweMOS5/6FlQp5Db4DxxUwYuYWS
 PDrh5mx1OzHRx6YY5bLmWm6YtJxaaui3ilWd+eW1TYGtHdAT45C33+fHf1Y8L6Q8PZ9C
 8vlA==
X-Gm-Message-State: AOJu0YxY9be0jK4jg+K2+akzPBaq8YBvV/nE7XZYd+GKNG96QTQC32Y0
 G48QXsk4YoNZ4wdpWVxBuH/2/TG5TuZQsAi3c9UiMSHURpYdhF58Y6SXgvPkXzZXrN+uz2vzBtr
 4eXXkpTXXsdxP/M9wUxf60O+01ncpzkM=
X-Gm-Gg: Acq92OH5eYfjb3/Npi7Xb6HYHzM/GGaRgtBv34rKC/2pNKiguPgUrX1O/4GusN5iAlz
 jUh6sjlGfe+To8xOv3hWrdGf7c1h9IkTxDchYyk+fTv+dufmJAzfW9VVJ4pmsV3zNxZ3eSXWK00
 Nh29cCWcjS3dHs5HQnzyu979oOYi6zQHlF5ZYMRWr6pZV/k2LRDscnCO9PY4AJZw2WIzUN2uKpm
 AmVESNia9y/kmEM/rkF5nYdqCOiQQBfepiYstZ/nHsgEte9NeglDj9a/sdkm8u6Mv60/kV6rrzJ
 bABJrY4R3QGVz8yh4R2UjW3S55SVhtZ+NhB/Fhb/VcOrym0JbdoCMIEdKeA=
X-Received: by 2002:a17:907:c817:b0:bdd:45d9:8e15 with SMTP id
 a640c23a62f3a-bf0b11db134mr39472166b.15.1780448891164; Tue, 02 Jun 2026
 18:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260528060007.717307-1-frank.chang@sifive.com>
In-Reply-To: <20260528060007.717307-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jun 2026 11:07:44 +1000
X-Gm-Features: AVHnY4Id9ajuVJ-Y1HF3dLhkuxHo0F6t0WT71060Br0CTNOIVDd8frotZI-PIHo
Message-ID: <CAKmqyKMuG69C_nT2euOc4rWp85pbgzyxjwEh+c1DRmYBgSvgJQ@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fixes: 5db557f82bff ("target/riscv: Add Smrnmi CSRs")

Thanks!

Applied to riscv-to-apply.next

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


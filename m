Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04CCFD9E1E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 23:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvky7-0003bi-QS; Thu, 26 Feb 2026 18:40:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vvky6-0003bF-9b
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 18:40:30 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vvky4-0000Z4-3y
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 18:40:30 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-65f812e0d93so2240916a12.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 15:40:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772149226; cv=none;
 d=google.com; s=arc-20240605;
 b=Rtitm5s5DBIeIQaO0AyceNW452qaLfpImn6TsbaL8hb5+WfiM0f8f4y7kHSxSw11kl
 GT7AnMbzDornIPQ+f7jvJHTYLbxz+COUcPM2FhyZZrK5BGOevEwz3kfu5uJMBeOJhXL0
 3aX2joFvn2JKV5eqATF0pj+KsMdASeLiyGy2dgR5G/ieWv0bqKD41mWc2klAr+xEczDX
 5SbnmeA2jKt3d3ozwf/+bG5CitbRpZyXxpo8aGI4E1VWRXS4WFdNTXu5pTZp0z1IVpBH
 eJEFG5ksnX6cpqcQusjiEK2GNUXWZf+AqaDHWLeGsaY3JF7kpr6FEs1BhHdcRlCvdRNb
 kLmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AIEZP1cNrg+7vMVGVLT8HzEf5kVuY5Ua6EHdBlYpUK0=;
 fh=+lkhgrzZfpaaUf562P69yjGYvvSbup7JpxI6sDFJR2I=;
 b=ljUQn2aXjoxZtPjJgnCVei//1HO2DFZhx982puW1nx8uxpwnm/E0L2hfjL7v+Ibfjo
 ODTftOzIFXzobuHCL1TV1mUg9NqlXPfZRyXUIe0l0nBEzWj+FsGVKmxfftQPTfJcYWkx
 XteGbjMfbTSIIAjgaMXVbMQx9N6ur+R31J5CFDixShsBwR7WpGrTxcqFRKq3Ng/PjQmg
 9g5ltKwfRBiz3M2FR3H36Cw0LJuXUjf6QwNjILDbFjhJn9xImhWJnh8FNfW/64B1J7N7
 8ScW4znjOjkIAGiDkagcLXBykzS+JDwImejyy/ZqHx3b4zMyrth/dboXIIfon2rgpqlW
 P4hg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772149226; x=1772754026; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AIEZP1cNrg+7vMVGVLT8HzEf5kVuY5Ua6EHdBlYpUK0=;
 b=SHNqYim827X+6MetG8Vu5ehRC+kJBEA2ubtiZ+xQO6forqeZ645LMZD5ml22LpJ5DZ
 VmbfJw6bAybt4nnYsMoS9RWz2SSgDs1xvVTT5uyowZBy+GLqXUstpiD8GF6qUIcw/seO
 DRIKwyeWEA9Y8lAEzjEnHSb7b07USzhibLIfah18KkT4+2ZBob3fwIqwcfbFp8+ggS/W
 uIxj7R2Zu5JBlITswLJWpVVdSwyoEasdn3+DnFOUykjzGpeBBfsW3VwNEUyQ9EwRxSpF
 LpvlGpGPk7we8apP26YX2TpFWjHGm7zOKty3CjtKy0YsCyI+bIaAV3a2Z6aswDKMKl2o
 9veA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772149226; x=1772754026;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AIEZP1cNrg+7vMVGVLT8HzEf5kVuY5Ua6EHdBlYpUK0=;
 b=FDCyj5FW1l1RuUJG2jY83krghl0l/+bL7j+EDByAbkiOaJAd9foM1VXm/ZaySGlIjM
 n0Ir3Gont/MueEKm4NxBZrCN5EvsNEWkQqxXF7klX/rR9B7uCVWypt+ooPMfv187i4sv
 Y6+wu75J1UScNQXqzNP9Qm/oKGwCAXAxN/RadCH7WvqpH0ze2iYa1fcO1E3d+bYQCpvm
 DFw0VeoKB50Z3ht0ET9alyodKSIag4BL9Wkwhmkb73Fd2Ut8igRZiCdKUhaJ38JuMC+F
 DfFtblsMnY+MM1ufa1Vi/qeClzchE+Vchw6RvureV3jUHsSku0Z8f5QiIiX854hiH3To
 Gbaw==
X-Gm-Message-State: AOJu0YzTUHrPpq558xahSfOGxlOSYE4T5wuh4p46n7Fr+SMcwSFxOmwg
 HhfwaNQoJVvlPJ2k6m0uBMIGn4KjfivZTN9X+vRXmJN3LdNLkyCxuRPtjYQYGJIBG30JPWzt5jF
 cN8BRBSFqrMDERSZ2LPG9koX6a74WzJY=
X-Gm-Gg: ATEYQzzZmCZBv0mPN3xpStyPxv3mKszHnVx9pDkHl5aZScpHq8PsRU2scwBMR9poCd8
 ZoIEyoPFX9blKXJbiO8oVG7rdV2oN+BBmKZuhJMZtp2MSNLLtGimq0olPXmL63uxp5FSH3lV/0v
 /VnM2nnNL1grEwOGYDHQN6EjqIORZwZAMKWLY1/X5V0v+cngCzEWU3gAexYmgjCscvi3UQRGnbA
 DAXqSjlq8z5SQvXfngiZy2dt+ODL4Ko40gqL8Q+jGjqRw8o3of6A4caO3r8sRJ70ygAs2+44Wxr
 lTnBnY8T+ZzuDXtT22DOr3fmDoEpoUtl6feX5w==
X-Received: by 2002:a05:6402:3988:b0:65f:7498:389d with SMTP id
 4fb4d7f45d1cf-65fdd6c0e35mr486403a12.10.1772149226473; Thu, 26 Feb 2026
 15:40:26 -0800 (PST)
MIME-Version: 1.0
References: <20260226102008.146928-1-chao.liu.zevorn@gmail.com>
In-Reply-To: <20260226102008.146928-1-chao.liu.zevorn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 27 Feb 2026 09:40:00 +1000
X-Gm-Features: AaiRm53jczusftw6IdWpSA25vzN_YyJqOaLMe8kTQmdqBqSRx9e9_8EG_ZGDO0M
Message-ID: <CAKmqyKOixw96mfNP=5UPUmbPWntyxzrAU3T2JjPu=sNa4RCqDA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer for RISC-V TCG CPUs
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
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

On Thu, Feb 26, 2026 at 8:20=E2=80=AFPM Chao Liu <chao.liu.zevorn@gmail.com=
> wrote:
>
> Add myself as a reviewer for RISC-V TCG CPU related code to better
> participate in patch review.
>
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 233d2a5e71..4923715c9c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -333,6 +333,7 @@ M: Alistair Francis <alistair.francis@wdc.com>
>  R: Weiwei Li <liwei1518@gmail.com>
>  R: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>  R: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> +R: Chao Liu <chao.liu.zevorn@gmail.com>
>  L: qemu-riscv@nongnu.org
>  S: Supported
>  F: configs/targets/riscv*
> --
> 2.53.0
>
>


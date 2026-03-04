Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F57EF9008
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpW3-0005ll-Uv; Wed, 04 Mar 2026 11:56:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxpW2-0005lB-BF
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:56:06 -0500
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxpVz-0003q4-Ts
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:56:06 -0500
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2bdecd00ebdso2790302eec.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772643362; x=1773248162; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jBt2OZCqmhbsCaq9spV7ZYFNN525fo1cmf4cuE/cWkk=;
 b=Rec/IfCRGqv01P0qQ2D36eojo7EMbJ2vm/C1V4UY4KYExIrtGt+jnp9KYWM0GEzX2z
 CFh6DBXdTeoL2rkutpmBkyxIOj9MOuYlNZ8wZWTx8VAGABfzs9xOljJU+93zXm3gEPaA
 rwPuw+iZPegdE991u0s27OGzwdnrs1v/mVep+wvHnx0q40z/wLmdyW9aJNUOikwv7HJ8
 6t1YttFjxhnQrCkuw7NVs480LcGqYpaaB7fY5vM68jrC/FL/dJDDcDqhDNoLeKoG+SHw
 2EYgl8TR8aWQSUUrNwdbPObT5OgyxOVPZuO1s2S+mkE8B3sZu3LGBBC0lGbveORRBzus
 wTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772643362; x=1773248162;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jBt2OZCqmhbsCaq9spV7ZYFNN525fo1cmf4cuE/cWkk=;
 b=YptwuKuFgf+bd+ZL7/AVLpFgsAO7iDw+hwL6IucumHgQzn9TL1zDvLpsA/s1ug4qqU
 Qegsx1Yd0jm6RQgIuUVFf3pPZbwi+jYImFu7aUawrCRFP2ZOr5Dxu3YO2qUZ7mKyaDJb
 O5LOEMUHHoTer3+511hIuVRTuYreN8Y0tjOJ+U9XNFh6NWWRJH12yTJHBEIhfRtVRSeT
 c1KEaNBx/nZ5owRuUyuGv7GU/2mT1j1MGOQM3XgYdAMryEa/qBF4Mu29HjGNhAl//lGY
 82JT+03ay91CJ9DB+0zrK5mav3xJ0FH8Ws+R80NgULLNnrC71EHp7uol6iZmmbPZiHQx
 Grhw==
X-Gm-Message-State: AOJu0Yzyn3/QCGTSJI1zYCmeEKrGosXJxelFSy2MQDb+L0Sh3PjAAaO7
 1WahOr7q9fFqyQam/VEHgeXrAmxbx/HMZ9FQfOGZm6jFX6Z3kFNZzI4I
X-Gm-Gg: ATEYQzyoMQk0RuhY2+xqK9X91OFaPwP4JxYZV/iS8i9uftE3FGjreA65KxupKyabJ++
 vBwzgIaQ4KIo91svFUJdh6Sh9d65k9x5WAWoaXey/geyjGugN6W0gyYcTr5t5zU0s+JeNZDpQiR
 ojU+Du/pXziERwluEXXpwb4kGg414UGMpTDZpjHubjjTKgk1Cddb8jK5x0TMddZDmPuQK5xWDj0
 MvFdYMwuSCEweXfrKsqNzsYsXnN5ilUh/cNrLL7hG5Co8yM6Wq4JGGyu/8L0PIl/Le8w9i+cT3Q
 6+4WVet/4vhtT32HvDn3VtwyQMSq+8GhuTuP73/16bYHNnOAdWMwPUCPwHM7NeI1WY/sQ7SaTBk
 I6VhZKiVe3elDGl45jbLaOHJd1vFNLgK/hbN5OpGVLwUUt/mvZLrcXUh+RZfci+OHqbqVwyP9TO
 i4onM9dQexT/JKi9jdUQShztuKt63WrHJd0SSDE8ZNSpNtrflDbN9OVjNPPWu9z1enzt8lYj2m4
 90ueCp7wZyXUeZoSb53V+NwtawLqCg=
X-Received: by 2002:a05:7300:e61a:b0:2a4:3593:645b with SMTP id
 5a478bee46e88-2be30ff3b4amr1111433eec.11.1772643362018; 
 Wed, 04 Mar 2026 08:56:02 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be2800c89asm2859024eec.31.2026.03.04.08.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:56:01 -0800 (PST)
Date: Thu, 5 Mar 2026 00:55:37 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 9/9] target/riscv: Expose Zvfbfa extension as an
 experimental cpu property
Message-ID: <aahkALNY52AD1LKS@ZEVORN-PC.localdomain>
References: <20260304132514.2889449-1-max.chou@sifive.com>
 <20260304132514.2889449-10-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304132514.2889449-10-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Mar 04, 2026 at 09:25:13PM +0800, Max Chou wrote:
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Best regards,
Chao Liu
> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 376517755e..73cfcbdf6f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1379,6 +1379,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
>  /* These are experimental so mark with 'x-' */
>  const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
>      MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
> +    MULTI_EXT_CFG_BOOL("x-zvfbfa", ext_zvfbfa, false),
>  
>      { },
>  };
> -- 
> 2.52.0
> 


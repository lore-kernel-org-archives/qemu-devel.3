Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5139EC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 10:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCyKx-0005sO-B5; Thu, 08 May 2025 06:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCyKw-0005s5-2V
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:18:42 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCyKu-00044H-DE
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:18:41 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e6dd991a0e6so716225276.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 03:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746699519; x=1747304319; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=73i+0d3Wl2gShoZApYcx1Yf5nkVre6dyVWblG7yrRj8=;
 b=Q8zHDwwbC+1kd9rsMZewkGjl2KCiBzrNf7LZxADDenIpUFqBz1OPSN/ppwp26za+5Q
 MvGJAvk8tiUU5t6f97N9qkIeuXQa9xb8fmWDKA+sats8tETYQTL0S1pvq2P1YFdcMvhy
 yUXEu5iMW/sxp0WwZ3wk1uBxOtMcL26FHfXHvKytFjCGbX6j84qrC6yxkx5ERaRQLSQA
 CiQGJsGj14tix/mT8mblSmtYO7UAZ3jG32fGZ+S7iCSsVTFujBA9+siZ8C/yhsCK8mib
 Qw/TwngoMUeXeHiZdJlsX+dTEgeWiws1xK175TCN92CHmiE+qkh7djKVErIZ5zTR/LzI
 aaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746699519; x=1747304319;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=73i+0d3Wl2gShoZApYcx1Yf5nkVre6dyVWblG7yrRj8=;
 b=UB9VThZ/vc4805bsKYlqMX0dt1NXRrqVi9dT9Cb84VyeJhltUIXUosnoG+Xo7H4mwF
 ph5KTqj9dXduwR6PB7Xl/zzoPMmMNOBhROhRJuONFTUK9bPGiHo6nIIuCkipIc56Jclb
 lwNZUO1ddSutpZ1YJBSVAhY3EOV8LgCG7EADFiBCr7RGtPgqfJeD1Lon5GPlIttclupU
 zM8GM788kcIVMyq5TlCVKtq/+IUUujUfbfBonTk0Sq4vHnCFx7GzFjxkBi5RbJpCOOgp
 j1Ic+avWNQP0+XB/W3Ld0d9uE/vDT1vpyzuWvKHlUcxdnPk+jxKgSPJTGu2eOqRz1pMq
 M+9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9syXftaLuLIxumhg68AQaY74KZj66g5n6gfZMeEowND2grNpzQjmVynSEy33cTNV6OS6BXMwRicxM@nongnu.org
X-Gm-Message-State: AOJu0Yz3j7K5ECISIRk8p0y9lPXVxgkVQQDX0XzQ+Jbp2No+Td+8Lnx5
 nigpox3GQoSveT5llhsG3EnTOuHo5oYzYdtKoSxBff35xQmHVBIhsKqgQzthPYgcmA4Qpmk5fbI
 n/QD3y7xqwft6S2bc5+Rk51dzUNictsq3vxwVTAtp1+Cfha7U
X-Gm-Gg: ASbGncvV7FvLlx3QHx5COTviBvr7Afi84Se5Ft12h+lMnmhj4pgYp01vBmM1ZYE/l8z
 VvmmV5VFXl1+NlyGMPv/ZRlZI3GQEGjNKLE2f+DUL+Dmcx5zieDOuxDSXVHQdzt929DmzugW2TL
 aVFoMLtf0ChKAsMjP3C3x61ME=
X-Google-Smtp-Source: AGHT+IEjnG3a96G2RwkuhpBxEJbx8VAEnJq5YSTyNF2IbY98AdBIim1DWgSegiCw9mM4TDyCztdfZM8cdElLVoMd4Ug=
X-Received: by 2002:a05:6902:c13:b0:e78:f2a8:a69b with SMTP id
 3f1490d57ef6-e78f2a8a88amr1417917276.17.1746699518973; Thu, 08 May 2025
 03:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250501125544.727038-1-peter.maydell@linaro.org>
 <f337d662-9eea-4f8b-b2a4-38a46e64732e@tls.msk.ru>
In-Reply-To: <f337d662-9eea-4f8b-b2a4-38a46e64732e@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 May 2025 11:18:27 +0100
X-Gm-Features: ATxdqUELS1jBLqbLlVlU_NsUm5Ifg6vQuDtUd_zZP8gaRa3-yLRmTBxVLntKKaQ
Message-ID: <CAFEAcA9eVO5PCpi8CmmrMwZrQexPOKWE-RpW3k2jwHv26NLjLw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Don't assert() for ISB/SB inside IT block
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 8 May 2025 at 08:31, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> On 01.05.2025 15:55, Peter Maydell wrote:
> > If the guest code has an ISB or SB insn inside an IT block, we
> > generate incorrect code which trips a TCG assertion:

> Is this change applicable for older stable releases, besides 10.0
> (currently 9.2 and 7.2)?  It applies cleanly but I wonder if it is
> actually needed..

I think any branch with commit 73fce314dbbf2d ("target/arm: Use
DISAS_TOO_MANY for ISB and SB") needs the fix. That would
include both 9.2 and 7.2, unless I got my git rune wrong.

thanks
-- PMM


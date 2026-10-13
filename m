Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67229CC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGWUD-0001LE-0Y; Tue, 13 Oct 2026 02:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaminlin1207@gmail.com>)
 id 1xGWU5-0001K3-VE
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 02:59:38 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jaminlin1207@gmail.com>)
 id 1xGWU4-0005x3-5f
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 02:59:37 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c2e6df2742cso385010766b.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 23:59:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791874774; cv=none;
 d=google.com; s=arc-20260327;
 b=B5pCNBlapW5uaEYaDaYo3PbnbEffs6f3qxrjkGjDoIi6bjR6Bb29zanMWKhKGmKSA0
 gkY0CgujVqbu+0IHPoiboh0Tvlxdo6JflopynjvXShFktBWga+/YalDgG09y04UN2FlT
 VNnOeeThWNIeWGbaLEMdkd/meigjJmYBIhrbSkyJpxV0NIpy1tpT6juNC3OQHjPFnxQs
 3cBGIIiqKwpwi9In2u8MbDaA5LNhqWX7PYWxFiyoYrhB2EsIkwq6doRJquZNm14GxgQ8
 S7RHxRo8gX7Y59K8ReasEKWo7RvHzQpk3VGinJA2i/YDE0aBNUshhmr0Yzh78+yjRHET
 GP9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FsavGuJI7lEm09dh/9TGEx9R8ziC15kKprEg0eqdWvU=;
 fh=GM/I2I6fEf5qvJbdhgjZMuNCECIEwt8XqdRDAWXnLqc=;
 b=YGLd54RR8eousteKl0UquFKaOMXJsc3l9tto+xO8UFWlvKnz6p9R1gIE56kJgR/nKY
 hRvihQJp6Ugusj0u0A9Axa980ilZDaXMhhXnsqdZty2WcPVYp+COVfqO90NZiNXESvaw
 mQL3I+XgUx9W5Uxcz7usEi+mzuHIqJxiogPYlMQynzaR/+KQH4IqLRLtYn7uYApFIqZ8
 NYTkoAYkA0TonCN8n1Kp0ZnhWmaAu9lOEzlAkeqJyNaHbdWk9RSBSqck/mwqSjEvWanI
 9k3Ax10kjDLzTB64cSwAx1E23RgyOodDky9Zs8JDjSdyBYVQ5TxkcP01Dy6NvIivR0yG
 sz1w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791874774; x=1792479574; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FsavGuJI7lEm09dh/9TGEx9R8ziC15kKprEg0eqdWvU=;
 b=I1HEwjMlLR86XGkPd3gKD38S36h86gJ3rwrqZWoJpt2BsH8DHKcxkiidOr6lvVWUdf
 EEVp1fra0sf+xtvqVshdwT++YcK96NGHanNbFtjsyUArrWYcoCOPYWeof8ZQucf4KxFo
 OxCsUGchzZOVornCOXi8Aakoej3mXKvLHmSBNP/bAuvKy2Nx+5AqsenCMUqKfmCjusPt
 Q1Ggrl2aEZqmH11rHWx24plnF8r7RHvk68uGi6bqYf7bzq02BAUviiof6w5Dz0gbAoOJ
 HZu4nFmh4WYL2+L11IJL6Tp2JwlAPgiVRdqQMXvbHlC1/d4V68hBn/ytGUPrftCzG7FC
 gzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791874774; x=1792479574;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FsavGuJI7lEm09dh/9TGEx9R8ziC15kKprEg0eqdWvU=;
 b=e6PZJxuBag34qoOe3nf8eISrpmq1pNraQq7QP5yqkGdebT8lyWy1qwrk2Ta1gAIRcU
 Mf202KTGcLe4YNAnVj0zFhHxr3lLIuvLPYZXgJHWsffkJviK3Oav2usNJftZTAfVWwUb
 psnOhuBKpDzw7IBpMdCudKFZOKtDcPgDPifRVeAxrTliLt4uiaS4rvneMi89lxZ1eyXf
 dkKz27BKysfR02XB4yGeLpkH4S1Sm5DXC1N6h4Gf2vDE5pDmrMDJD7LuQmpYI1h183I8
 iqYoJMfJcNFxAuv2ZqgMbkGeO9JmcullYsFmqDNoLxiref+9UnoGGhO6z7ShsK718DGX
 kNZQ==
X-Gm-Message-State: AFq9FYJ77RmkuW1jFehAItdX5ft7gjRSle7q2xYw/xGxinHmYOHaQkD3
 BSpe4S4L3mv3bB6fzorEzdfTljEmlMvg/Uybz4bgFzkT4ZXOJR5j2unPr9KDxnjcqRjCdwyJi8b
 TOXLr0b2w1Me2WziqQdxoUDXkc24K9Gc=
X-Gm-Gg: AYBFou2U5IO0uzHOck/OnbmmajVbUGkvZneCHB87fvXruHnaJIJDmIZPEBu9z5MeRq5
 jYxpatxH9lJOCiRsWXJ7mg1Z/0p9Jn6Z5S8BXukapgoHcLXKV+CHtXD9zlBwist0czrbs703NzB
 W1UZ8kSDDinato+fNrVa/mPNjIvVTZDOQKmRmsFRN5owjxE4uRfOcj9jJt4zIwG418Pmnb8DZtP
 9jqTOWMTEduq9HsXPK/BKwoppeujzjhvko5wGKSw6hNanJ0l9l+JNUU+ThxtZEtRsQpQ3ky2ROZ
 cfffaibzdRWcUOXLUInsZQVrqYgHxN78nWReJYCYzy9lHfh7XANYVmPW
X-Received: by 2002:a17:907:6e8d:b0:c2d:c247:5400 with SMTP id
 a640c23a62f3a-c31aa036554mr1179168266b.27.1791874774515; Mon, 12 Oct 2026
 23:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-2-4c3dff084ec9@free.fr>
In-Reply-To: <20261012-bmc-minerva-v2-2-4c3dff084ec9@free.fr>
From: =?UTF-8?B?5p6X5bu65piO?= <jaminlin1207@gmail.com>
Date: Tue, 13 Oct 2026 14:59:23 +0800
X-Gm-Features: AclHuK-Juu4jyCWFSBvsTqcpvyHmJJV5uRXR2I5GXQDuFjYa8LFy17LiuHfWeQk
Message-ID: <CA+8rw5xDogAem_bbfoYrS2JFLPc90DTngJ_vgvWgn1L0gtvJTg@mail.gmail.com>
Subject: Re: [PATCH v2 02/50] docs/system/arm/aspeed: add the sanmiguel-bmc
 machine
To: Emmanuel Blot <emmanuel.blot@free.fr>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=jaminlin1207@gmail.com; helo=mail-ej1-x630.google.com
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

Emmanuel Blot via qemu development <qemu-devel@nongnu.org>=EF=BC=9A
>
> The Facebook SanMiguel BMC machine is supported by hw/arm but has never
> been listed in the Aspeed documentation. Add it to the AST2600 machine
> table.
>
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  docs/system/arm/aspeed.rst | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
> index 933df41f96..f38f33cbe1 100644
> --- a/docs/system/arm/aspeed.rst
> +++ b/docs/system/arm/aspeed.rst
> @@ -34,6 +34,7 @@ AST2600 SoC based machines :
>  - ``bletchley-bmc``        Facebook Bletchley BMC
>  - ``fby35-bmc``            Facebook fby35 BMC
>  - ``catalina-bmc``         Facebook Catalina BMC
> +- ``sanmiguel-bmc``        Facebook SanMiguel BMC
>  - ``anacapa-bmc``          Facebook Anacapa BMC
>  - ``gb200nvl-bmc``         Nvidia GB200nvl BMC
>
>
> --
> 2.50.1
>
>

Reviewed-by: Jamin Lin <jaminlin1207@gmail.com>


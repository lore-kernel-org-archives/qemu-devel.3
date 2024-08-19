Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41566C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 09:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfyXL-0006Tr-Ba; Mon, 19 Aug 2024 05:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sfyXJ-0006Sx-IX; Mon, 19 Aug 2024 05:18:49 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sfyXH-00042B-TT; Mon, 19 Aug 2024 05:18:49 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52efc60a6e6so5982341e87.1; 
 Mon, 19 Aug 2024 02:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724059125; x=1724663925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fo+zRAirlR/3/CCYJXinTtsL4vvwe5GcCC5LM+JDNl0=;
 b=NjAzgI1usbPcA8QEWyr4HidNKDTjMTFttjQFeHPfckiC3R0FwlfU0s/FdXGjW8CZbr
 HxQ2dcSkAOr5fIXE1sS10O8lkKWcST4IkgIUkCckFLrSNVXRuGyrH47dQW1qNHOsgyjH
 qU96Q160VzLXflqWtX2Hny+aTjQCVhaO6TgkcY9UihXEUSMqeHo4tOcacgCA6QFSEAOI
 ABkueYghxbZ7hqBnUMnY45rhZ8556R1aYxgH+3lxk/fZbqQsl+qZSAmGB8jFlY3Ei2zN
 rAEc2r7KMDC0rzXIT4aa4H+yRFW3EYNeBz/PrgjTK2HS3O9d4zf4VXwzDrkWMvgzUpdX
 fyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724059125; x=1724663925;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fo+zRAirlR/3/CCYJXinTtsL4vvwe5GcCC5LM+JDNl0=;
 b=eLVQp6mMeZOJHdqm2UVKqoFqQM2e3/ojMYlKaEywacWo4zyH5pVBz4dtb3f98NHbfj
 sbxScjgN9h13FjSaW4DiKv12Tb8RAWIFvYnXumqkEOthSAtXory5T89NKMcBIA8lmaGM
 ZWXEV30Tbg+hX3/VK28r8tBgfrD8YVosBeisI9ra3jkRXQHCJO6lZaFZIyrX7VYdLNyP
 D7oBFGD6Uf8XHRv62gAvHWHV1mPPrjgznbSA9Ag45rnU3485so+8jeWLmVRpOgT/pRGQ
 bhRj/9QrVFtRl6tX4kv0Q4MkA0xMeeIq5ni1NflJjUbJqQt5Eh5DobnKAzwPR1KjsIFB
 tIFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIxYNy7hfx4Aem+gI1cQT+YJ7TdKieH9k3Rgxrlfqct4dQRLgh68DJBrHYg2FQo7kWyKc1TiJKi1iknRl7+b+766qvxyY=
X-Gm-Message-State: AOJu0YxmOz6cxIzBWFyRq/4O47zrmanInr2/K1JBTgkoasvIN1o3JVEv
 ONUxDDKfV3g1hJzIzihywJM3mAmXpFX9Ujvq9lDlaGm7rMBj7ud8
X-Google-Smtp-Source: AGHT+IF4ICcXTcHQYqKPZFthIwFwFNG7PPijwSl1YBeB3rUtc+aWDW2k7f+Vnn0z2ntl6xP+r+V7rg==
X-Received: by 2002:a05:6512:6d6:b0:532:fdba:e7c9 with SMTP id
 2adb3069b0e04-5331c6e3e9bmr5892084e87.56.1724059124633; 
 Mon, 19 Aug 2024 02:18:44 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8383946a7dsm611968566b.181.2024.08.19.02.18.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 02:18:44 -0700 (PDT)
Date: Mon, 19 Aug 2024 08:22:24 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?UTF-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Joelle van Dyne <j@getutm.app>
Subject: Re: [PATCH-for-9.1 v3 0/2] hw/i386/pc: Fix vmport option handling
In-Reply-To: <IrhtgC0oPtusYG_0cOwVYOuOr0UpK0YLNYNtxDQ2_lqgtcVBzVr-gYNUzggvmO9tHdmf65aO8Zoab-ERkyQbtjx9u2VuHEYZ_3r0Wb25huw=@szczek.dev>
References: <IrhtgC0oPtusYG_0cOwVYOuOr0UpK0YLNYNtxDQ2_lqgtcVBzVr-gYNUzggvmO9tHdmf65aO8Zoab-ERkyQbtjx9u2VuHEYZ_3r0Wb25huw=@szczek.dev>
Message-ID: <C0801D58-5A75-4F8B-B0F1-765B9B3FE1A2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 17=2E August 2024 15:24:31 UTC schrieb "Kamil Szcz=C4=99k" <kamil@szcze=
k=2Edev>:
>Some time ago a new option to disable the built-in i8042 controller was
>introduced (commit 4ccd5fe22feb95137d325f422016a6473541fe9f)=2E This
>however introduced a side-effect - disabling this controller resulted
>in vmport's creation being omitted, regardless if it was enabled
>implicitly or explicitly=2E This patch series aims to clean up vmport
>option handling and introduces additional validation for these options=2E
>
>Changelog:
>
>v2 -> v3:
>  - Move vmport=3Dauto -> vmport=3Don/off conversion to a shared code pat=
h
>  - Reword documentation for the vmport option, "and/or" =3D> "or"

The vmport handling is now confined to pc=2Ec=2E Excellent!

Series:
Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>
>v1 -> v2:
>  - Exit with a useful error message instead of issuing a warning
>
>Kamil Szcz=C4=99k (2):
>  hw/i386/pc: Unify vmport=3Dauto handling
>  hw/i386/pc: Ensure vmport prerequisites are fulfilled
>
> hw/i386/pc=2Ec      | 14 ++++++++++++--
> hw/i386/pc_piix=2Ec |  5 -----
> hw/i386/pc_q35=2Ec  |  5 -----
> qemu-options=2Ehx   |  4 ++--
> 4 files changed, 14 insertions(+), 14 deletions(-)
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79729C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 18:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKhsP-0000ad-T3; Thu, 29 May 2025 14:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uKhsO-0000aL-8l; Thu, 29 May 2025 14:21:12 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uKhsM-0001o7-P4; Thu, 29 May 2025 14:21:12 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a363d15c64so814092f8f.3; 
 Thu, 29 May 2025 11:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748542869; x=1749147669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/mq9+wWCDAiV1riKshTFQcSClgNfPQw5FVQUtbaFvc=;
 b=J1HSZlKMPlgXtIIUN88AFZs+zB+UD5zMCmpZbmeOewUz7bEjjrJ+eaWdcSG0ZksVcB
 yGzyHpYEvPm5KJHcTzBYZu0cSPrNyCbx0HIEvfcg6wDux8MhFKEteO7la5Od4IWzAMn1
 Hlfn2Z7ThiEZ32d1Xb9/Mp3DR7YdQ1Dcy1ne/Xm+OUZw9EgV2bHnoZpo6V7g0toMu/Lx
 xrKXUjAViSWEE0+4j0wXZhQp18+aQwoMzVY8V8tb5DzIBGjMFyIOtDodCjN8kH/vG4hL
 zs8dggAfx/OGWxPIHXJAFSRPGMEjkIs502r26mfqNWxsf+NNVSviQUm58Mwtt6N3f6dV
 X31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748542869; x=1749147669;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D/mq9+wWCDAiV1riKshTFQcSClgNfPQw5FVQUtbaFvc=;
 b=URukl0qVGNVqBjhSXuO7kkwsOOTGM/7hqmA9BcPJxHbF4ektLGfGe0qC1qfPCDSal0
 5kq38NJCeUwbgZy6Zf2bx5EBPjpJAY9BtqPfMFRmS2w3RRivmtVKjKQgPR/9v7kFfGB1
 aYfBrrJiUdcconTyuvYdkl0VxT0Y2JO5Aw8L0rnV8RxOknyEw8wqxHbemGqZZ2JCeYSU
 jSYFQPMX4s/EttUyXuxLTbzw2pQvLa0NuN7LXZXFIbHtTfE3NdeBnrEDvsBeGE4m1nZZ
 5RZo78V48Gjb+twoZqbr4JHmKIWmom9mj2O3q5bVEQ8wsfi1sdmEheEMUKO9MOC8rCjP
 Rovg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6vzfniyTqoYmlvbX/ZaQY7I1quvImyEJdgl1HoE28Kr3nCrKlEog6InYj6oOWEUTlkIbHk2qBqy6g@nongnu.org,
 AJvYcCWXSuOiIcqhnWAPwaMKsGqcNMvWTll7xr/PEEIzk900UpXmUl/nja554znqtOZSA5vrmXrrifjAqzY=@nongnu.org
X-Gm-Message-State: AOJu0Yxa34PFkuoBYYAOJty7nQsKDWjEfSnJkB68kbuVef0gv8wWQQk2
 ZU7AR3fy5u5qLKnxaaqsHaOXz8oGSNedSNDSE/lYRXB5VNeSeesgewZj
X-Gm-Gg: ASbGncsLQjzgASPxE0RGvaYRd+1tOlLO7ikuToXx41g09FfaLHXTnh3WISWfXHHN2mq
 DrOcR5LuutIFx8XgPbf2cAJgPwAX1i5cXVL3dMfPtQjN8WxM+yfLn5B/m81g5mQySzdCAW+Oa3/
 luiRfvT/YpUNVVgs+ySw1cErD8nmh+ArEv5IJ5if5P2fgJSkTWPwtvU5k7O9yBBcG0nN1gG7U8s
 1cFtGTgW467ZZcbhhItoWt3Rdis+H2u3nRl3okLnl8dFL3XFibAu4d4pAedxp8lq/pzAdVc3z1F
 MJbYoN5PZmBM6ivjPaqYprUsD5DoOckUry9QjrSi5nNDfjd2+N3xQHVb87hFTG+Bgn/1G9uQFMP
 nV5FgoG+AywgwloOgoLBz
X-Google-Smtp-Source: AGHT+IF2J8DTdqZuPltrC9Dsu+GUD/yWj+JYT6v8SnwVLFqlLACmnU/coIWo8px+GJScpTwQLPzNJw==
X-Received: by 2002:adf:b311:0:b0:3a4:eecf:b8cb with SMTP id
 ffacd0b85a97d-3a4f7a36500mr227797f8f.28.1748542868673; 
 Thu, 29 May 2025 11:21:08 -0700 (PDT)
Received: from [127.0.0.1] (ip-185-104-138-110.ptr.icomera.net.
 [185.104.138.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b7bbsm2667204f8f.4.2025.05.29.11.21.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 11:21:08 -0700 (PDT)
Date: Thu, 29 May 2025 18:21:01 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
CC: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 0/3] Misc ppc/e500 patches
In-Reply-To: <cover.1748012109.git.balaton@eik.bme.hu>
References: <cover.1748012109.git.balaton@eik.bme.hu>
Message-ID: <676B619F-618D-4E4E-8C3C-1B7924F842F0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 23=2E Mai 2025 15:02:10 UTC schrieb BALATON Zoltan <balaton@eik=2Ebme=
=2Ehu>:
>Some small patches to e500 related parts=2E Also includes a patch from
>Bernhard that is rebased on current version=2E
>
>Regards,
>BALATON Zoltan
>
>BALATON Zoltan (2):
>  hw/ppc/e500: Move clock and TB frequency to machine class
>  hw/net/fsl_etsec: Set default MAC address
>
>Bernhard Beschow (1):
>  hw/ppc/e500: Use SysBusDevice API to access TYPE_CCSR's internal
>    resources
>
> hw/net/fsl_etsec/etsec=2Ec |  1 +
> hw/pci-host/ppce500=2Ec    |  8 ++++----
> hw/ppc/e500=2Ec            | 26 +++++++++++++-------------
> hw/ppc/e500=2Eh            |  4 ++++
> hw/ppc/e500plat=2Ec        |  2 ++
> hw/ppc/mpc8544ds=2Ec       |  2 ++
> 6 files changed, 26 insertions(+), 17 deletions(-)
>

Series:
Acked-by: Bernhard Beschow <shentey@gmail=2Ecom>



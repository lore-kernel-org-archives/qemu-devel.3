Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7B1C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 15:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNDHM-0000ji-72; Fri, 28 Jun 2024 11:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNDHL-0000jM-8T
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:12:47 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNDHH-0004It-Uc
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:12:46 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57d106e69a2so57066a12.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 08:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719587561; x=1720192361; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QnvPowgGiAWWtSA4bzF0jcFz38pdgKphlufuxWJN+d0=;
 b=j6G40K2wrY0UeCqEclJTCWl3Xvjxy1qqOxfUquhAd903M6TiHKlCJmf0GzAUBf9u/6
 BBKIX+wzlTXyHyx1sEYMG0kyJYY0bPZcPzqGaz4AFNGvvqhv7RXKDvaTBKBnbO52JSoD
 mypEjeKe0K5YSAr9BXUOfzE5R4Q/QqFNvaAOv8Hx84Mi8HhktwD9APfKbARC3NB1ZRx7
 xjSrV67PfiKfZCbFjYfBtosKjj5U2taGnYoG/RhzQ2YvcQoeTb+NwUi/3C03puYn5+nT
 RQjHvzE4D+XqhuNcJG/Z/c4sPKZ3f9yEcYEVMymS3WDTK60otSuSoCdRu78oosNCrtaN
 uxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719587561; x=1720192361;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QnvPowgGiAWWtSA4bzF0jcFz38pdgKphlufuxWJN+d0=;
 b=YyI5odwer4zz5IzMj4XndOgZ6PH3Knoz1G7jVNP4ioyb1qCywvXSy3Eou1sVobq/9r
 i5HUncoSE7AbbhMgyYyICvTxORfqA9dcnp7IFVAoOqS/LTvQB7n9eLgwLzDFcD94IwGH
 eMV8r1NEZh3oon6eGyoBg4dA9yGpNmtP2DUv/gyZofXFxlSN9WFcsTTPPom1qcE+sJNm
 QHH0qJS2/WUtbVMCgkDzcarub/au8tEmZHmIlWvKTbYXbp2KwhlIDAtLnrgHN7uj1ZRl
 edOQN/XcIIrRawoWyvv3maZbJ74HUpQwj6TSP+OkRa6mb5RRlOO4rmCoUT6HwHtclyya
 L/Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUePRCGuy4+61cUKvCe3pJUchn0hm0vMguPw5YDZfdMad1VfLpehFTvXGlmdE0xD44EzfAxjGT9o2WKlf3OT8l5TO+Z+d0=
X-Gm-Message-State: AOJu0YxdDTStJ0JIWgIBbJWyWIP6nUo4nhhLewmkTLKs/q9uHXCIikjq
 N3O384rKD7UVgGxMbIhwYTUpO4nAPcF0LmRFWzyYW45w+GNanDsbLnmZBKp9RiFEqsP79o8wsuk
 /JoYBneG5Eg0PwzD3wcD25/TXPT66RA2zWJlYhA==
X-Google-Smtp-Source: AGHT+IFzbNTKlgI/HWMd4tfPx/D2j96WFcO3eAA1kmmMVw8e1EwrKEOBQdJD395ozGQGtM9cuJRMre32JvnQgE7ThHc=
X-Received: by 2002:a05:6402:c99:b0:57d:4b12:71de with SMTP id
 4fb4d7f45d1cf-5865c1f6e42mr1443988a12.10.1719587561271; Fri, 28 Jun 2024
 08:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-1-750bb0946dbd@daynix.com>
In-Reply-To: <20240627-san-v2-1-750bb0946dbd@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jun 2024 16:12:29 +0100
Message-ID: <CAFEAcA-m6iQL4gGE4jSdz1O4P-BA+KC1uXO+kqV5y5oXJKE31Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] cpu: Free cpu_ases
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Thu, 27 Jun 2024 at 14:39, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> This fixes LeakSanitizer warnings.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/core/cpu-common.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index f131cde2c038..a3073c17d098 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -289,6 +289,7 @@ static void cpu_common_finalize(Object *obj)
>      qemu_cond_destroy(cpu->halt_cond);
>      g_free(cpu->halt_cond);
>      g_free(cpu->thread);
> +    g_free(cpu->cpu_ases);

I think this is likely not sufficient. There's a patch lurking
in the vcpu-hotplug series:

https://lore.kernel.org/qemu-devel/20240607115649.214622-7-salil.mehta@huawei.com/

which adds a cpu_address_space_destroy() function, which is
probably what we need to have happen on CPU unrealize.

NB that that patch isn't actually sufficient, though:
see discussion here on previous version of patchset
https://lore.kernel.org/qemu-devel/CAFEAcA92nCPPk0Qa6XjRqRGTq_XDyRSVVaz67WgJBEZcxoEtOQ@mail.gmail.com/
and the link from there to a different earlier patch from Philippe.

thanks
-- PMM


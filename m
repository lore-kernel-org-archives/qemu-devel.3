Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD984C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 15:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNDQ7-0004eV-4w; Fri, 28 Jun 2024 11:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNDQ5-0004e4-7C
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:21:49 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNDQ2-00080i-Vp
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:21:48 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57d1679ee83so1018842a12.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 08:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719588105; x=1720192905; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LYlv3wTfdlUST0mnaDKaK0GevMkwX19GIuiffInn6DM=;
 b=BH91cdB3XF1UWDMC84mcJh+SaffEAvFSd0Y4zlewEOgr0hs2VCWzWZOsaJ6VkXdShX
 YXVhccvXeHP5i9YHPqjsoZlEq3o32jfBo5FnfZARG166I8yKWkMZjzzaJDX0FQEWZh9R
 AtUDABQghU5uxIqD41ECIgkIlSapkux7hk89Uqs9I15ufIOKqpmV6GWaJAsKd0ejZ3Q9
 OaMLKXU9Sb4kKVeScSZpG2n89vFmRzXSNFB4oHYPp1MEq+RHYTO1ydaGlVNfFQj46wUR
 qGL/FWSQEG5JSsR+hSGDHpKOFPkLpV1Jw3EPLdHs3ivHqfdldL+eQZ8dohuLlT1itvhm
 VhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719588105; x=1720192905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LYlv3wTfdlUST0mnaDKaK0GevMkwX19GIuiffInn6DM=;
 b=nfvvdT5d5VT6kUwm3Izy3E3tS0u0fe3/iLasEEvxsLE/mL151ElNg00TUpRi+XGjhJ
 wHHABkskM+VEEDuuFPwhunS73h98oFs5/XkqnH7zhRaYXajfBSz3vChuph0/I09ufdDS
 9ke5vsecTh+QN4xkUGhguH5qrsn8J+uzyIF6QEOgk9dHf47F6UI1aOHp8NRBN5VSg7VZ
 sC8E/tVXSqmxgb9nfRcykdiXj0Wgu1J0UtdsDnaVW17aM1vCbNO7d3rD6+TNvP5G0uEx
 MZO3E51D68mffqx75i9QwacGAHdMrKl9CAFSOkKnvkz2CQlTf2r+RQTGbay/jLAU9Uul
 dZlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmCQe2jqQ0Vzd7b8iBGLpXeuJpHkPcqfKyvpOvzyJ2xXomrONjxPeWtqW6p4TM2pvig98wMjmh0BxKJKlCrXoIpfFBD6A=
X-Gm-Message-State: AOJu0Yyrt20ZjWvNIlRb0C6yD2UZv8q+Bl+WZXS5G8u7qeZ1lGi0rDWV
 UH6KKR2xt+ZTHUHgRGWVUKA5QsSQ9B7Gmf/TPShnvnYU6L9fN0+jvbvuZ/Hbb2JVXpXoaIIE4In
 7sWt7ZqqasfiprZLrqrMQJQdFgrOgzv96ObbVqw==
X-Google-Smtp-Source: AGHT+IGVu/NHDjC4zRiS5UiOlrXIPnyAQxATCJHdjgPJ/jLp85/tHGG1PCRcxRlKfvy3X4yZqTdyYKmcwiy1qtFWQbU=
X-Received: by 2002:a50:ab1b:0:b0:57d:524:8818 with SMTP id
 4fb4d7f45d1cf-57d457a1497mr12892077a12.20.1719588105470; Fri, 28 Jun 2024
 08:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-12-750bb0946dbd@daynix.com>
In-Reply-To: <20240627-san-v2-12-750bb0946dbd@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jun 2024 16:21:34 +0100
Message-ID: <CAFEAcA97w=o7rV0VuVq-NwFq_sEGBH3N+Q=wD9GeMvw4BizxZg@mail.gmail.com>
Subject: Re: [PATCH v2 12/15] tests/qtest: Free old machine variable name
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
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 27 Jun 2024 at 14:40, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> This fixes LeakSanitizer warnings.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  tests/qtest/libqtest.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index f89da7b80797..1605c0c9f615 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -1509,6 +1509,7 @@ static struct MachInfo *qtest_get_machines(const char *var)
>      int idx;
>
>      if (g_strcmp0(qemu_var, var)) {
> +        g_free(qemu_var);
>          qemu_var = g_strdup(var);
>
>          /* new qemu, clear the cache */
>
> --
> 2.45.2

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


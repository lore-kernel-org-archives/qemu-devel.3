Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AAECD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRvM-0006IB-Sp; Mon, 11 May 2026 10:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMRvC-0006HN-SP
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:47:50 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMRvA-0002DN-QA
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:47:50 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-67bc6098640so6979078a12.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:47:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778510867; cv=none;
 d=google.com; s=arc-20240605;
 b=BVrs3YM1fgQnSUbC5gCmw2ZhCTveDbxVXR4d9JB4z/KcXdUpiai37vyZFPjyI5OrAo
 uEZ3ZN7vCl8aK5SLMLdoG0+pPqP/p+2Y/7whjrNntOIJ1qr4FIMbjJE7JhTU0Uz1oibb
 nYdlOsAzxK3roO09LvdoNTcnzN6rX9dvTkVpRc8+u2HAtvOoL+QqPgpedIFHlGSIVqvr
 Qn4JcFRvyXCK99qvCjnqxr1wju1MijXB/+/zOZZIJYL764vi8c0JQiLgX83JdBUd5LH/
 Fhq/DEI0bNSAI38DMk75Bghb1QbMyz8poGEvIPc0o8qkTXOoWj0x8iNWMDwl78KwgV2P
 FPXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oTFkDzHJuo+GpEShBEwX6ShxeUJdMexZIxhn9NLWXSk=;
 fh=CIc9ClPatU7HT4jNcuo0X5f/VSfHZ44VC5rPFBqW3CA=;
 b=IVgR6tkjFr3zb9jKPRsh3Bfun0F8cE9VekpahCYu8WG7mE9jCjIAnr4fmWozbvxXzT
 6Ay+KtahvvML9dVIydVIz4kskzgXGumVlYlb3lWYP+0mA1Nzg/K4JHbImSk6gFmoVC+I
 VqoJFYZgDm/3JjIc6JMAfGOu0ZwbtNpDcAXOTm5j2zvSGxYL5DcrQRWf9rx5eOU+HnuN
 6c1Uq6PAa4Owo4cv5E4+9KsoF577sY4jB8VrEfb5qnT1ccSrwwrpEEbA72fBmy4pt20z
 9ADeBpcTqhnn+hrFhIOlRVaVGtn+ASFO5pn19Tp6P0VRtqV2LGbdY+Z2iG5TvUyXv0uo
 4QYw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778510867; x=1779115667; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oTFkDzHJuo+GpEShBEwX6ShxeUJdMexZIxhn9NLWXSk=;
 b=LEsWATv+8d8FzqOnEbyno6Jx7DorwF0n7lQwPOMvEDxY/Zr/B25DiOx1XxUFW7+ydg
 EfHaqsOfUhmipxJ3aD6C4pzsGzntwNx5fIvrkK1zPUPJuboCRy9cD4K89nnhCdu3R9JL
 HxeGkp3C3wxDZmuv/I+jrho7Hg6yu29dYP2u6G3ZVo766ZIDNvdXr0WMoOMnv3hFHFKi
 pws4SLOiy3f03ttqlZlpBlkoOmQ/uOygRIElMMEkVoIYWIXdh93gh027KY41J7dbxFg8
 mNtDrrljLwFr0VjB8Zk2RNQukANtMTx7re4eg9Q0nOTolNSZOHSpDN/PS4wSfpwRXz3E
 PzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778510867; x=1779115667;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oTFkDzHJuo+GpEShBEwX6ShxeUJdMexZIxhn9NLWXSk=;
 b=ciwkIOM5syckeLKV6JkvH9hM9ufL6BYnnmfm3j/onqZV94W1wkz/6PxpIx1l5RfT62
 hyS9X5ekxqV32V6AgOuquKukWnvgcSm0b2y9pbbSz76f6lld/Ps2rdxQWTP7PloaFLU0
 bApD3kiyPmBbonqAfg8ZHM9UM2C06nEgdeAC0wX9DF+zfsq6m7Sh3c68U0COEEBbkMFz
 hg+5gxzZcsjmhwgewzed05ub1rM8MDL3PP7S/k6NZ6+Vuh5s8GgoAeApIJCUcrYwatov
 Q4uXThYhhtqSSNi/0/IM/4DXByzupPuZOfGXcYJk8lniRKvoHFGziJcS1zNBqTHVSREC
 biLQ==
X-Gm-Message-State: AOJu0YxRjZDKLLSGwDK+TGMXsDlcwVGXoJGVZguRq+Mfoy3Qy3HxcVU6
 eG3ui6J/jwx6BRXk8fmJ52VRwKQgjg2HasDRdgqipQEKIvYUAoRyIGczzBQeUzbATmnUuGg5vQ3
 rKJDbPhCrBI6spG8XWy3aLtKwXVT6ZPTkPZc05CrGY7wc12ip6rDP
X-Gm-Gg: Acq92OFUpHvkAyG4jH1VNbrT1noKK+S6Sgjgt8iHFxwk6qk1HSdILAbE7uuuiRwqgce
 AgXzKTX8b3ErXdxm9Q3Rw0vDth/WYkky7mOIBgiP4YT/ZuyYznovMYpfP9wpOf5TZ4Z820Kclcl
 QkyCGijLTJE6W+hJmANV4VuC/UYQ5r8g6fARMvHXzZqP7SwryQF2CiYlvI0rxYS23IKgvxkwotw
 +OxER5U/QRMt61wxLu0LxQNf6y1M0MfXbkDOuEg4ey6W8Dt0cVNsPTWp1wqaCkJLjocPdnUom+a
 yAAEbgSoUZXD0Xw8wwsMGhrChffNhcIBoU2v+03S7bcufBBas0cOKaMfskh16fP0kiU=
X-Received: by 2002:a05:6402:2b95:b0:67f:a015:c6b3 with SMTP id
 4fb4d7f45d1cf-67fa015c8e3mr3304337a12.14.1778510867196; Mon, 11 May 2026
 07:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260501115506.3792110-1-peter.maydell@linaro.org>
In-Reply-To: <20260501115506.3792110-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2026 15:47:33 +0100
X-Gm-Features: AVHnY4JNiU3zl2ELIwX3NjJUC5wGuao65Of3nD7yrMnF3zWOdOiwuTK0mlSAyGs
Message-ID: <CAFEAcA8QA32mcVOU+iB7Go40h_RwEtYKyZcOQT4nv1nEY92v+w@mail.gmail.com>
Subject: Re: [PATCH] tests/functional/qemu_test/asset.py: Don't use setxattr
 when it doesn't exist
To: qemu-devel@nongnu.org
Cc: Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Fri, 1 May 2026 at 12:55, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The Python os.setxattr() API is Linux-specific, so trying to use
> it on other OSes triggers a failure:
>
>   File "/Users/pm215/src/qemu/tests/functional/qemu_test/asset.py",
> line 227, in fetch
>     os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
>     ^^^^^^^^^^^
> AttributeError: module 'os' has no attribute 'setxattr'
>
> Since we only set the attributes here for informational
> purposes, skip them when os.setxattr() isn't available.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 9903217a4ed013 ("tests/functional: add a module for handling asset download & caching")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Is anybody going to pick this up via their tree, or should
I just put it into target-arm.next ?

thanks
-- PMM


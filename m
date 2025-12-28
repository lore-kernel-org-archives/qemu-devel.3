Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1839BE784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 17:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZu7S-0002vL-Ax; Sun, 28 Dec 2025 11:59:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vZu7J-0002ug-Vt
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 11:59:42 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vZu7I-0007Nc-Iu
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 11:59:41 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64669a2ecb5so7895110d50.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 08:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766941179; x=1767545979; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KnWJV+dWscrgd3i2Qb07vc81L3vpXB/DDGbUd1Hm5fM=;
 b=yAIR94Ck0rQkEgXrVp4eE1w8zjIpg5ZaqYn3Ns2PL6rOL43rQ0Q+yyroKnJCE7S8BJ
 /FJNHcJEx7xhFB6L7hAMWN3b48LkAxlABEWaFAfsBrNJEmDcu2ppKV7XjvXJ7cvbQFRK
 svpUJkxJhaWMuNrYNznwh2jTPYM83uhivDtHwdCTn5DT4FTt0/qm25ZEuu0nC+TcknRB
 v8JasJ1V56mTZwKjYjQUxYcTeAvwXX15fKaz/NBAgmuQCXdw/Ne16jaRBF2UkSvfzg3o
 d/RA6TlpLcwNJzmcU8W/prgPqHNXrDH5531LvCK9D53NGsIkXWSygeTVdJdPYZAb3YV8
 d6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766941179; x=1767545979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KnWJV+dWscrgd3i2Qb07vc81L3vpXB/DDGbUd1Hm5fM=;
 b=LMYrFQxeAB9vlygne1VMnEqqUQPBbax2FOD3YAyzPQelxjkoPmjdl2QnKF6Btgmn2X
 0UVVipMiCccn/yi9yecedmBPwf/jNA9N+hVVCT4HSK7PS9uJBP/vXKvsLzQT4thcSlGJ
 /ehkK6O2ldHfz6f5EGCNUjZggEuIb+cUcjdF4zv/XGT2m72welXVYWm+YsE8FpT0XSvL
 y3NmvPFlp6MasZrYkxvAjHmwCruZJDmmGjbq9KYloCDxRWiETdqWa1/xwdalswmoKrmP
 0Qe3bEYTEp3/3lzMl33yv5q0tbS9NeLjgeNIWbkhkTcUeMJvLVTUEobK3/u0njlrPNhz
 yUyg==
X-Gm-Message-State: AOJu0YyPWMmaVuA2D0FkmgItN4TuHXNSo/+yDn2Q8uwrHU3nWaN2RHET
 SAP55cwfzHvzyiooLWEmaA3SUN4uWjVQDCm4HKmOwH5wPYbnlB8pBZbIVr2m/bFtKQmPa3gxqWe
 73r7lF1D8eard0k98pu+yQnRcD2yK1B3Zjxfn+53pPQ==
X-Gm-Gg: AY/fxX52wnxE3IucSre3BE1osxACgBNTZoRflBfrp7uPL3xa/wCvdTXxZILjKeW1AlZ
 QDuKhQoiNiJICusZFtA8a+wUCrVVOxRem0ZhG4uiuszvPbXNvuN33Q/+bGeWcA6Z2Ubbk2Ojig0
 qB5Tc9/9afvKbbUUU7SlurRyPPCWOndNHDQFY15gm/3J2EDrYTj2i9Bfnxo29vbouIIVmq+CUhr
 NG0eEjRojIlztsVoGgLugCdeiwj0NLiVMC+ASxzdn5kad1TQ6oryct4D4THnhNRD078KxDl4jlR
 OAWusvIC0rfC6VjEwfeHrHk=
X-Google-Smtp-Source: AGHT+IF2MWwvSv7vBR6AvWHwx97NGwbbyvsvRle1pzBZEtccT6sedEnL0xlAVYF9xr+RelRVqX3eVFJFcz2+0XBiFuQ=
X-Received: by 2002:a05:690e:13c8:b0:645:5325:3e59 with SMTP id
 956f58d0204a3-646632274f9mr25479155d50.6.1766941179022; Sun, 28 Dec 2025
 08:59:39 -0800 (PST)
MIME-Version: 1.0
References: <20251219222439.2497195-1-ruslan_ruslichenko@epam.com>
In-Reply-To: <20251219222439.2497195-1-ruslan_ruslichenko@epam.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 28 Dec 2025 16:59:27 +0000
X-Gm-Features: AQt7F2pZDNkG3o-BEggkbMRUn88zutPtRU0Js4vlVdGbRr2n6IUOHi1MLtwRn9I
Message-ID: <CAFEAcA-VYhtvXK5tyVJWfskqqKFim43DsKfWrpaMxteWueR6aQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] hw/arm/smmuv3: Add SMMUv3 sysbus support
To: ruslichenko.r@gmail.com
Cc: qemu-devel@nongnu.org, ruslan_ruslichenko@epam.com, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Fri, 19 Dec 2025 at 22:25, <ruslichenko.r@gmail.com> wrote:
>
> By SMMUv3 specification it can be attached either to PCIe Root
> Complex or regular IO bus devices. However, current
> implementation only allow to associate with PCI bus.
>
> This patch series add support to use SMMU for sysbus devices.
>
> One usage example implemented for virtio-mmio, which allow
> devices to perform DMA operations SMMUv3 with address translation
> and isolation.

If you want virtio devices behind an SMMU, why not use
the PCI virtio?

The only SMMU sysbus requirement I'm aware of is that for
RME we will want to have things like the GIC do GPT lookups,
which is most conveniently done by having them route through
the existing for-PCI SMMU, rather than by having an extra
SMMU just for them.

thanks
-- PMM


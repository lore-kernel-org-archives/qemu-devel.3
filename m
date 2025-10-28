Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7D4CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 10:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDgnL-0005LK-Sr; Tue, 28 Oct 2025 06:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDgnA-0005Kj-TJ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:19:05 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDgn7-0001tS-Um
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:19:04 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-783fa3aa35cso71125417b3.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 03:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761646736; x=1762251536; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pPXBGY/nsuMNTA/zdfPQs7Znj2i1KdprWmwqufvWZ0U=;
 b=mFd0UXKn8G4dzbRVS+RDIiifzR/hkzDnO/VsbxHaq7kFJPgQHUvqbnJ7gunKKEGa2r
 OkO4HAxAyH1PlL9/2tCmqq02ZMdiKFbgIOyrQHcVBS/6R92B8nRg7MHBw5uUTvClD/n/
 tlWgsXbAK9asV6k+3Ejl6tAf/C1M/3E7ypSfYw121hpOsswxFuqSmJuA3TK6oZN0SIeM
 ZVUPOFueHdzDIJU6DU2hc7O5k2I8LNq20+LAjx7Ycy40/CIfHBJ+Sj3PN1n+e9o34siQ
 QB++KBfo4VLFmgQ5/iqZg4duTxYOIPhW32VbfUjz1E7wGHBwYB7YxpY6/T9S3LsNIlhq
 RJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761646736; x=1762251536;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pPXBGY/nsuMNTA/zdfPQs7Znj2i1KdprWmwqufvWZ0U=;
 b=JwRrq9VUlr1ZPhK/+i/bgEjPB9Af6S385ByRF34wavJyzuGocPXYFxTfCInES8S4vl
 RlIJAOOFnXBjnZmAMvoGB6dnFpXgWwOg1XFWoa7yZwwj+wdALVCFL42WQsTNq8Frtr1x
 KVGFo9AMNwUn1LS7D9/XaH9Cp036+TgBwgNIw3KLHqL1mnEw48piXQewwaTFU4Twn86C
 s1qJ/ty1Njx2orh6b4Ag/5cBGgWKHBNAPIFKoQI9z/Zg588jpVGHvSRO+/bfuw2hP2kt
 eLxMIPOdgAUZ8AYqC/lPVFFUb3Gubpbxukjc3ruS0hr1hs8CYGVyfsLd27qO8UBHJtSg
 EDbQ==
X-Gm-Message-State: AOJu0YxDZBgb/xjlPDs6w5L64UyAzKH1EWn0gEtocVH4DIHo4LYaD0i/
 Aph6zrGwcs0LPxS1YNhWKwqhCy6nUr0+UN3uBo94I8h6JnXesjZpx62AohXISPqIgLgm/CF2BzH
 pVy3Ww4C4HfWm7Hol5a40ezR3ie1tFhBtbxDDywjRHQ==
X-Gm-Gg: ASbGnct00id1sO913h2MMzSDMzQX7RU2lizU1HGZ4dMJ/+WOO9kn92G7NlAqp8+B/D0
 oddYUU8AMjIbLetwKif+gadkjVorQoyf4VZvJ6O9i7mUwn36m5deZCjiRyGi8LceIpm9l1M7SP2
 uFLU5t4JHhptNMoe9XlQ/Im/NMpx96eYnV22wc3NcrMrta5E1Os6fQWnFYHNfv+aVzm2917RePm
 ahPMrZ6GwmHX5Hrqx6szeLoEfFcUyiSFkC30vbHPNUW2TJ0dyz5bFeCMQslHg==
X-Google-Smtp-Source: AGHT+IGo/aQ02TccOTY7s0s+Kc0g9mNurT8J1bD513Z9K4sUsAxjjkcstRCIyM0K4Tv7EKX/1714cEiH7BrRpKz3S+Q=
X-Received: by 2002:a05:690c:61c3:b0:785:5e62:f6d1 with SMTP id
 00721157ae682-7861816fc47mr26694217b3.61.1761646736080; Tue, 28 Oct 2025
 03:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20251020094022.68768-1-philmd@linaro.org>
In-Reply-To: <20251020094022.68768-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Oct 2025 10:18:44 +0000
X-Gm-Features: AWmQ_bm_TZHD6yVKf24hHJJ6Th8wAQymbucWgGTS_VkwsTu4tdOBH5ndPc2vlz8
Message-ID: <CAFEAcA8koM_7QdJHjoJG2x+7LamY8rTV0tYkUVBRyphKNALUzw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] hw/arm/virt: Remove virt-4.1 and virt-4.2 machines
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Andrew Jones <ajones@ventanamicro.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm@nongnu.org, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Mon, 20 Oct 2025 at 10:40, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Since v1:
> - Do not remove virt-6.0 -> virt-7.2 (danpb)
>
> Remove the deprecated virt-4.1 and virt-4.2 machines,
> which are older than 6 years. Remove resulting dead code.
>
> Philippe Mathieu-Daud=C3=A9 (4):
>   hw/arm/virt: Remove deprecated virt-4.1 machine
>   hw/arm/virt: Remove VirtMachineClass::no_ged field
>   hw/arm/virt: Remove deprecated virt-4.2 machine
>   hw/arm/virt: Remove VirtMachineClass::kvm_no_adjvtime field
>



Applied to target-arm.next, thanks.

-- PMM


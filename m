Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79904CA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 12:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqWfZ-0006La-S9; Mon, 25 Aug 2025 08:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uqWej-00069c-Ox
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 08:50:42 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uqWeg-0005og-NM
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 08:50:37 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e933a69651dso3644262276.1
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 05:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756126231; x=1756731031; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gTqtUTTq9GgaC3p+iimp2St44Dw0MIbEASnueVReolE=;
 b=Gg1rmEI0utV5QJKlEPiDAy0UGr9ShNETW57dWZEz2UU68tUyow9zYQLpt89R/b48F+
 snxdFPUf8BivC0vex0JIQdRQBGf3ZXXMZuHweRSP6mfRvLKu19xoEV7p7vzUmTZOzsVp
 StLV9O3ltdW+Z7Ucx0bVFGYNBa8Z5+56IoxuLCB3CMYnzWps/P5EKS/HoqKhi+CaNEml
 bsLDX+eqmMnUsWBCuTfYVib5zVcWu5SQQvRvk7lB6zlNGlSTXgvYd8XiNtgHCghQ/r41
 Anyok/JMCQjPtlpNjSfjHglgOF6Z26c7lHEORu3L0UuO8JLiBP3hKjJRQUjgixiA4141
 AWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756126231; x=1756731031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gTqtUTTq9GgaC3p+iimp2St44Dw0MIbEASnueVReolE=;
 b=E4KmOvBpJg9oZ06Dj7WlTl/skJAn0zIDp4i5jbSyvYM0eQdzN0azhzq4AGZeXAgU8g
 MH6LzvkQUDF7qKFAFfJMYcw9qYD6vdLOvg9eQgHDbi/rHQSiUUoLRXf439oAn9AIOzLe
 izKLp128HBczL41UGuM0IHfyDF3s9xFjxFcGaZj6UOhwhpXtbl+uC2OuQUKyjDB/k6Rb
 UbDpYXRHUCTHC0rn1jEPWelcm6KJSMzeWe2KPV3Orfc460k8mIQPnkNWncWnkD/k3ybM
 qjmX+GvhDUFWzk4zdUlpJaewAuzPsAoR4h45lhl8Q3UHa9/i9zyTo8nYMNkOJ625Hc1Z
 Qs/A==
X-Gm-Message-State: AOJu0Yy601Jo8yE4GGjaZMr1KsN2/xkD0P/A4CLStuB3sP/Fk5jWrdJs
 XKsi/T/mhksC0DVucD1ivY0NXeRivD8ZZjd9DCbWrOjorxZgjcpdN7sUES+Zop05D+QMS6kUMN3
 N+PfkQHoljL3VKxSvMICQwrsS8h0Ay3UTeS+Y64TGeQ==
X-Gm-Gg: ASbGncvBHAAdWMqscrHfjpItgLtlvYEpeYuEE6Ld7ijyhHdFRd5A69M3DNTULrIDBMN
 i8+ebGGREpK7XE9EZAFK+7qDhInKHL0yc8uoRWydpyQJlK/EGjrH7ZJbqHp6k+Hfz6SWXdUsf9i
 CTvQ0+Nuo2s7wAJtfdTHglIbNIortm2VajCOkn1Y1OY2zThzzdQ2XnmbsujxmrDPKq8v+Qg3CVj
 pZvNTOc
X-Google-Smtp-Source: AGHT+IHt6cGE7TUtM5RFNFgjRWqIFsrdpCPCo2LvBhM2g4r430YFAhZv3tD4u6+Cz3BTv7/YySO03xIR6z/Jm+gtCZ8=
X-Received: by 2002:a05:6902:188f:b0:e95:f5f5:60ef with SMTP id
 3f1490d57ef6-e95f5f56a67mr2894040276.8.1756126230921; Mon, 25 Aug 2025
 05:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250809211051.68824-1-chichikalyuk@gmail.com>
 <CAFEAcA-NwTDQUJAerkX2O88_3Mgprh3A7GqaEAFdM4mpN3s05Q@mail.gmail.com>
 <0B0D958D-67D8-4036-A6BD-75CBD7DC636C@gmail.com>
In-Reply-To: <0B0D958D-67D8-4036-A6BD-75CBD7DC636C@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Aug 2025 13:50:19 +0100
X-Gm-Features: Ac12FXzRHwO-yHDFIOa5BkKSrHfzm6X9nGg1kUnX4dMGzmtCIaWpz7GsjisP4QI
Message-ID: <CAFEAcA-sKRc5MXjaMDGuTAYeRo00bBTNg_SZzOU46wxE53YFfA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] hw: acpi: add UART clock freq to AArch64 SPCR
To: Vadim Chichikalyuk <chichikalyuk@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Mon, 25 Aug 2025 at 00:00, Vadim Chichikalyuk <chichikalyuk@gmail.com> w=
rote:
>
>
> > On 18 Aug 2025, at 18:26, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
> >
> > So, what's the rationale here? QEMU's UART doesn't care about
> > clocks at all. We provide a clock in the DTB because the kernel
> > refuses to boot if you don't, but if the ACPI spec didn't even
> > have a way to pass the clock frequency until rev 4 this obviously
> > isn't a problem on that side.
>
> The rationale is the same =E2=80=93 just as the (Linux?) kernel expects
> a clock frequency if a UART is present in the DTB, guests using
> ACPI may expect a valid value for the clock frequency in the
> SPCR record when one is present.

But the ACPI spec prior to rev 4 doesn't even provide a
way to specify the clock frequency, so why would a guest
expect it, and how could it do so?

thanks
-- PMM


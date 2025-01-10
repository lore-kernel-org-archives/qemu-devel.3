Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D793CE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWIJw-0008Ui-Aj; Fri, 10 Jan 2025 11:57:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWIJu-0008Tq-HA
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:57:14 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWIJs-0003Bh-RT
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:57:14 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e53a91756e5so4058977276.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 08:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736528231; x=1737133031; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HJgMoYVZSw03vmr4yFxmrqvyqQ16V6vJJHIRbydgVd8=;
 b=vTdJcnvY/D391TgtjecVNDU4XxhyMY0+HejMsb3hNNrc0JAsi2ep2ycKDUlIxjt1qM
 wrQIQVJO/3W+iPM87yDBYN6dpf61h6+vMunfb4Po4od1XbG8+9GOKOslP4stQWxfXK7I
 +gNCZyaTOwNJOCqKlgXMg6VATjnd5v4h/jwIWAIjviFtNXsAAF0I8p/o6j/maF12Ygq2
 gRW/g9IsG5OrWHxKKJZFnEJuTzSfPKSRhgvjEbWVjt9lPAfN2dKXHObtuGNLmsW4RNG2
 BkLYHkt+Z4WsgWs6C/ApWFrH52D7KkDd9vOrNexR7NVVBugPiIgqkOgEi8DULcOf/1GT
 qWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736528231; x=1737133031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HJgMoYVZSw03vmr4yFxmrqvyqQ16V6vJJHIRbydgVd8=;
 b=PpRDHsFY1YCwqes4cRBSX6CYGgRVEvf+07PMLKMGX/TAP8BeUSFrI5D7J0dANrFpj0
 /zPlOuIDvE+dx6Cylj8IjMgpcUJEgn6/qlJhXl519C1a3tXZD57spGqU0vz0tPFl+lJE
 rBYlhsp18eoyE6LR5n04hN0xQ65YOnqRHqaNZJz1rBca/0wJl+GMLjJremzDo2bYzaFI
 DlIk/YVfgJluuiSt/BWFJXIyScIYTNkn4cvflTvrMejUa9Z0cmKiXFg3+GImJ/4yufqo
 hd1Yo+lk3GKNOER9g3LJE1T1GTnRF5I9Y1WGnQfE4Cu4c82RCu4xLuR/SLDyrQG8VTlj
 6+oQ==
X-Gm-Message-State: AOJu0YxyUW6U6SKktYjlWutF2+243J0QirxwFoWVH2fQmGV5gkwjXhzj
 dL3h5SOs0BrEzcE23vmy3iSRC6be64v0keQZjbBS/YaP1MKQvmhu0kJyO5gU/YfTl4HQjyMvy08
 8hYMfOxfCs+va0Z8dGtAmmiGAcyRqamsTuqkdeQ==
X-Gm-Gg: ASbGncupBSbgNAfttzCaE9+QnVbAOeQT6wMX+UH8lRHZ6KudFqG3OkLq2xUU296sft7
 Bvh6G0beOGppTknrS3v/BxkAAe6QBjbtyYcIwW+4=
X-Google-Smtp-Source: AGHT+IE0AbRS6/Lx17cPdfKemuNfE+YcBfETH3IAk4MGIRsz+d9Sfs1xC0oIhdw/N3fZDEV9/mOdnvFtnO8MAmx7etM=
X-Received: by 2002:a05:690c:6609:b0:6ef:59ef:f1cb with SMTP id
 00721157ae682-6f5311ef279mr90704457b3.5.1736528229981; Fri, 10 Jan 2025
 08:57:09 -0800 (PST)
MIME-Version: 1.0
References: <20250107192637.67683-1-philmd@linaro.org>
In-Reply-To: <20250107192637.67683-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2025 16:56:58 +0000
X-Gm-Features: AbW1kvaEHzcBrIKmA8BESXRSFOHUPDktKCrZCqaTwEMuygcjlAg_UzUFizw-ClA
Message-ID: <CAFEAcA-F6CCD_RQ3J5f8bvoZ=3wP=WtOsgHjgbwMcY76pub3Lg@mail.gmail.com>
Subject: Re: [RFC PATCH] tests/qtest/stm32l4x5_usart: Avoid accessing NVIC via
 MMIO
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Samuel Tardieu <sam@rfc1149.net>, qemu-arm@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Tue, 7 Jan 2025 at 19:26, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> The STM32L4x5 SoC family use a ARM Cortex-M core. Such
> core is architecturally tied with a NVIC (interrupt controller),
> having the NVIC MMIO mapped in the core address space.
>
> When using the QTest accelerator, we don't emulate vCPU, only
> a dummy is created. For now, QTest is only supposed to access
> MMIO devices mapped on the main 'SysBus'. Thus it shouldn't
> be able to access a NVIC MMIO region, because such region is
> specific to a vCPU address space, which isn't available under
> QTest.

This doesn't seem quite right. We create vCPUs which should
have all their usual address spaces (e.g. in the arm code
the calls to cpu_address_space_init() are not guarded by
anything that says "don't do this if qtest"). They just
don't *execute* anything.

qtest's model of operation is "the qtest is doing accesses
as-if it was guest code running on the first CPU in the system".
So it should be fine for it to do accesses which access the
NVIC. (Indeed if we wanted a qtest of the NVIC itself that
should also be OK.)

In a more interesting heterogenous system you probably want
the qtest to be able to select the CPU that it is acting
as-if-it-were (though even then the first one in the system
is usually going to be sensible enough, assuming the
heterogenous board model did the usual thing of creating
the main application CPUs first and the BSP or other
minor processor last). Then you could have a qtest which is
"I'm testing a device that's accessible to the main
application processor" and also one which is "I'm testing
this device which is only accessible to the BSP".

> This patch is to fix the problem reported by Fabiano when
> removing the &first_cpu global in qtest, see analysis in:
> https://lore.kernel.org/qemu-devel/05820c9b-a683-4eb4-a836-e97aa708d5e5@l=
inaro.org/

Hmm, OK, so my idea of having qtest use address_space_memory
as a shortcut for getting rid of first_cpu doesn't work.

I'm not super-enthusiastic about this patch, since it's
basically adding an artificial restriction to what you can
do in a qtest. But maybe it's OK as a temporary thing to
avoid going too far down a rabbit hole in refactoring?

If we were going to have the qtest select "this is the
CPU I want to act like", what would it do? Pass a
QOM path to the relevant CPU? I feel like you would
still want to default to "pick the first CPU", because
99% of tests will be fine with that. But maybe we need
to locate the first CPU by some runtime thing rather
than by using the global. IDK...

-- PMM


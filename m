Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B250AC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjn5-0005ea-4F; Mon, 24 Jun 2024 09:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLjn4-0005eP-BD
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:31:26 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLjn1-0000x2-Rp
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:31:26 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-57d1782679fso5028267a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719235881; x=1719840681; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QW3RvusqWOMaRnIRBchybfSTW6PaZ83JR7WIKVAo8WE=;
 b=kbnz74XBYoJftQK5SGQqC5HCSulXDLKWqJIMfPAvJNf8BisxYOVa2M8OgWbzSkfEBk
 iMSc7qrsWftkWP3mD1Q4HL8ToatkiWu9WAtW52h+Q0drJnmzkJzkW8ZEc2HZABkJ665K
 gGW204SP/OqWeC/m6gcVWTCQ6cJSzbyYvnc6/33aYeo5HTT/RNpvixaW/XHXwvW7amLU
 i6jJVfmT4RlZLWOb5cUr3Il5U/pm7M5WRQUkjETzcFUGJKS+SviAnICy4TTxl04Nmqs8
 tKIbKaPzq7YZDxY7Ob1RGQNQhFTTRTxDkylSElH4GpAZqSoD+0LC2Z7VtuGKPWw0VSnc
 MuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719235881; x=1719840681;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QW3RvusqWOMaRnIRBchybfSTW6PaZ83JR7WIKVAo8WE=;
 b=u5ah2iS5s632lms1aFXwZR/kkfZFAYHyToJ8R/IxYz3h7uJQ/orkdpfAEEN9cIAzp4
 6tD9aBVQRV+zYaXX3yGyNst6n8lMkXsAIM3IYo6yk28xDIvZtQYI86a+ze1ItZURQRUi
 P57ssWLeHhOhPObRxQec//+EMVzFumtpnym4jVLTTxlIXXvcil5XtCQf9QMcHLDpENOq
 STG7LrBVv0uDg7Z8EaNTQgkwicSDFF9NdRxygyqucNO2ksShxnElbbWzsYMMwM+RZj2M
 CeOgVmOsjJ+0IMSL1+6rBNEk+HIyYdSxbEbQID+O/GQeMrtbml5szqDvNiksgttfX5Uu
 88bQ==
X-Gm-Message-State: AOJu0YzrYK8IdfNlt/JIuyGpVwiU6AA2itousggVzEMxrDiyl6lJmCdF
 oTx5W0/35R2WLrLghp5tzMQz8gMCFCZeYt+eOh9l461hD9RgwSURDyQElOqHCIhn8J70FVbueZ0
 pxHdnT2NmctPc+iPeXMdtYn0XsqrXunc7jEeFDQ==
X-Google-Smtp-Source: AGHT+IHjRshl7/9kNoGzCWhixaGE2/VAMUgGJfSVUti50m9o1wBmnGlajkGC9p/1NqqBRLAHRNj/gRH67L17txNeYAo=
X-Received: by 2002:a50:8e5c:0:b0:57d:3691:baf9 with SMTP id
 4fb4d7f45d1cf-57d4bd8151bmr2585313a12.22.1719235880992; Mon, 24 Jun 2024
 06:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240620-b4-new-firmware-v3-0-29a3a2f1be1e@linaro.org>
In-Reply-To: <20240620-b4-new-firmware-v3-0-29a3a2f1be1e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jun 2024 14:31:10 +0100
Message-ID: <CAFEAcA-axo2kObbc_D4U2VvwrQJz+HDPnnSOGt9zmT5VU8e2TA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] tests/avocado: make sbsa-ref working with >1 core
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 Ard Biesheuvel <ardb+tianocore@kernel.org>, Rebecca Cran <rebecca@bsdio.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 20 Jun 2024 at 11:19, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> Recent changes made sbsa-ref crash when more than 1 cpu core was used.
> We handle it in firmware now so one patch updates it to the working
> snapshot (TF-A 2.11 + EDK2 snapshot + EDK2-platforms snapshot).
>
> Other change drops "-smp 1" from CI to make sure we test default setup
> of sbsa-ref.
>
> Previous firmware worked with 1 cpu by pure luck probably.
>
> To: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org,
> Cc: Peter Maydell <peter.maydell@linaro.org>,
> Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
> Cc: Radoslaw Biernacki <rad@semihalf.com>,
> Cc: Cleber Rosa <crosa@redhat.com>,
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
> Cc: Beraldo Leal <bleal@redhat.com>,
> Cc: Ard Biesheuvel <ardb+tianocore@kernel.org>
> Cc: Rebecca Cran <rebecca@bsdio.com>
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---



Applied to target-arm.next, thanks.

-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B382C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1recJO-0000PS-Ij; Mon, 26 Feb 2024 09:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1recJL-0000PC-U5
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:50:32 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1recJD-0001Co-Ft
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:50:25 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5643ae47cd3so4138990a12.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 06:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708959021; x=1709563821; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/v8VZdq0jqEm+VYpi7FB+EPL6S/fctaFRXoRucyO1sw=;
 b=Cey/LaxVYrdqFyJqkgl7huc7VI90V25jngrVd60jb06PrsEj0qrzocjYdM5+dRGbGM
 Ri5E5PT2BzFK3uLRscZVsXE1g7ZtKTRrxZ7sbsRXagpLmhDF7Z+KTjZ9jA4OpHxfFRt+
 yttOs7og5IcMeMlwvAW8KYlq30gzQwco7ep21CF3hPvwJYWLCUohnJ/Llswrz81YVyWV
 WMRNA13mrU4mQFvWCMpV5NHMe29AxmIvLIRN/WUjbA0YMA9JxWQrmkkEqznjk8T/Zu6a
 a876Y2GpplIZBjiTOqm4nBUXABHBdlzYfziUpi14mvX44UKX/UuDH66iecv1NwkOJJ6z
 mJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708959021; x=1709563821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/v8VZdq0jqEm+VYpi7FB+EPL6S/fctaFRXoRucyO1sw=;
 b=VU3ntt9aBdSf+Pz/zR2P+2exa8Cyw5qycWS81YGBNcO2X7DgRbClQ+rsP3uocqJeLo
 qpf7SPWo1+MB3PMOJHj6LwvHvnL9+Q667XHqbEcwYwJ9rlTYHIpVvPlNAq9ZcH8iuPYF
 s9zPlZ5hxwIPuZ6ktYBZE3+OZkJJ3+CACtBzY5vISGCy4pmrgWGP7r2/ljc48z4FiUXr
 yXUd9iyyix91S8g5UZWpOtsn9My3kmhsxSg94HeKHs1dc0b2814KfafG4ldjfdmNmUbc
 ZurUuL6ZXSM3N2bmWYQWJJn2NrNbxfsE79G9nVM4EcB1kW0yLDsSZf8vEEu2IH4wHcOu
 EKNw==
X-Gm-Message-State: AOJu0YyuO1lH9TGQKsNQDMiqMF5CXcpzAhthcC5fcEoC5wZmJsfJsMBa
 ag4jnk6nOy1cbuX7TxQYsyfSUFjnsQ41tYu+i19o9Bpu0aoN8pT7Wl2NSKdWTBUaRb+R8+c6jlr
 K+OjQ2nrkBzUtW7ZzdRvHiiH6TO2wd6HX3JIrozbxpRLGbuAj
X-Google-Smtp-Source: AGHT+IHdzfeswn0fAIXAFtm3WEymj0Y/rwoz950/QZ78DG4jefbpwEnym3X5Re7Gowqegt0ZGZQ5JH8eefxHVFcGKDI=
X-Received: by 2002:a05:6402:1289:b0:564:3c79:930 with SMTP id
 w9-20020a056402128900b005643c790930mr5639155edv.23.1708959020945; Mon, 26 Feb
 2024 06:50:20 -0800 (PST)
MIME-Version: 1.0
References: <20240220160622.114437-1-peter.maydell@linaro.org>
In-Reply-To: <20240220160622.114437-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 14:50:10 +0000
Message-ID: <CAFEAcA-1MynkspfwuqvzvF4Jn1YK6nC+UFKo5D=DHfdAB9Rk=A@mail.gmail.com>
Subject: Re: [PATCH 00/10] reset: Make whole system three-phase-reset aware
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 20 Feb 2024 at 16:06, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset is an incremental improvement to our reset handling that
> tries to roll out the "three-phase-reset" design we have for devices
> to a wider scope.

The first two patches here are already upstream; I'm going
to take the rest via target-arm.next so we can get it into
git well before softfreeze and have some time to shake out
any unexpected consequences.

thanks
-- PMM


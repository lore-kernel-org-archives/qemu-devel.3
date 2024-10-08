Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D5FCEF15A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 11:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy8c5-0001Zo-Vb; Tue, 08 Oct 2024 07:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sy8c3-0001ZM-Tu
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 07:42:48 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sy8bz-0008Me-NJ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 07:42:47 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c87c7d6ad4so7487398a12.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 04:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728387762; x=1728992562; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L9bjrKMiG1XjAfVWKSbhToTRw4R1e8uTq9PWBp2Y6Go=;
 b=mZo4ShUreJ3koStqNkIFzWmqFEl/ZLFz2IImzXj1ljHFpg2fYxVtpVXzRc3vF9Cj63
 dB3HGjTs4sA7AevucC1YDp1tudyZQLQAuUSXCfEJpKJn8yx0hphWe1DvfcLNanlTzHUt
 eucuOo8KYlUK8PwDjXZizsczgfRq7TCd+WqK4ZvBG0tXb74kV/z/AtB6BhzuqI1gUWkO
 yYWKmpaiYba9ty2HWlZQ0h0TCgUsuDsSMvc2LZC0EwC7kPcNY03CgtRMKIUH4SFbfppS
 1PzHP7K07ZXMIPyoafIwJAN6r1Ra3kx4blX4eUhNAputXz7pVpK0T+kn3YBSw0LkCG3J
 HwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728387762; x=1728992562;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L9bjrKMiG1XjAfVWKSbhToTRw4R1e8uTq9PWBp2Y6Go=;
 b=gLSH26QBeb7n7rsQaR6cPuE5PxKOTO92cGyIXPRBvjTrgrvVoQ8kU5fWUBYVajucT8
 IZKMHRPL3YaUP2BbKun6JgrYDToRh3A3EKFtaiUME3E2fNJRygT4sJvxJAmwPQ/yYnwB
 A97GuhnI0Y5MMh1kejx3CrVglKNZo/3tlZpnkesi44EBQRBewUWXkpQMsF7raZWFWK58
 vEekCz5Qkf1bc27EfS1FevwsAjxBOjEiWbWwAgeI1EC+iOoSH+KxEWIk4fG0V7YDAunP
 Iy6z4+SBcyXoEVcZmIpPsjvYYYEpt7l96ivAHz4h0zI3xHACVTm/hQT0c84mS4L9R4kr
 b/eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX/Jh0OssOy4FVwbiLapoEkkKfSHjWoz+THFURKZp3nQrh5m+hhWUlPcpi3yDOxsv3eNf6i7yj3ts5@nongnu.org
X-Gm-Message-State: AOJu0YwNDQtuMRv1uUqcRlFugFtpTF6VMYP5jep9NB6hp3HFZUfTy31A
 eaoStqwS8hFHcmQqgHO4w9O7l0JPUduHND0escvmCiC9KyXmWgedYiyIyulUqJNIHjWSXmnfpfG
 BCCdfCMqq+ONP01KRaBZeeIpWy/nF4CLvJtYlZw==
X-Google-Smtp-Source: AGHT+IGhAjYV3C4huyYuFcrkw6VBMOTWRSgxkF9wmNcXycYdV/IUmwZd9k7mzlgCt9bp9FAjdvlYoUP/6EIDmtFXDC0=
X-Received: by 2002:a17:907:36c4:b0:a8d:1303:2283 with SMTP id
 a640c23a62f3a-a991bd7a123mr1614170766b.30.1728387761760; Tue, 08 Oct 2024
 04:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20241001221349.8319-1-strahinja.p.jankovic@gmail.com>
In-Reply-To: <20241001221349.8319-1-strahinja.p.jankovic@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2024 12:42:30 +0100
Message-ID: <CAFEAcA_xA0jCSd4Q1rbu9KyphthDrwLyiHhFdZnK9JwDXSCCBA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Allwinner A10 SPI controller emulation
To: Strahinja Jankovic <strahinjapjankovic@gmail.com>
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Tue, 1 Oct 2024 at 23:14, Strahinja Jankovic
<strahinjapjankovic@gmail.com> wrote:
>
> This patch set introduces the SPI controller emulation for Allwinner A10
> SoC and Cubieboard.
>
> Only master-mode functionality of the SPI controller is implemented.
>
> Since U-Boot and Linux SPI drivers for Allwinner A10 perform only
> byte-wide CPU access to the transmit and receive registers of the
> controller, the emulated controller does not implement DMA handling,
> and supports only byte-wide access to transmit and receive registers
> (half-word and word access will be treated as byte access).



Applied to target-arm.next, thanks.

-- PMM


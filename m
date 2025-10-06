Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF42CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 12:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5jwu-0000kl-2y; Mon, 06 Oct 2025 08:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v5jwr-0000kd-Ki
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 08:04:13 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v5jwh-0003oX-4z
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 08:04:13 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-71d603cebd9so59262527b3.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 05:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759752237; x=1760357037; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UDE8Z7qyajMCaXMrzd0HtBzhao2U4HKL5heui9QTuYg=;
 b=aAIC29vrduOe2Fw3bFXqpE305mn2i+kz82FEg8xy2i3jRV8n1Ve4hPyHuJ2hld1hrC
 EbRZwlFZekuFk68kv70y4xDWdMBMsfmw2Un+coYo45bKdIOPr+JedMloXzBoWztKmM9l
 wPaigty4gYLz/I5nbwzYpBX7PXq0CwtFjzwLaeSM48sjPd48itIY0U5V6DBPIza2uyQM
 j4DI7FBCoVmdpYUE9GoXhuQDnOA7Q/82g7+DF2MlYqUs/blslXw4rzp+TXOmIhXkT76A
 HCbIMBYKh34IU+k6A9sDAg+UvGIShW4hsf4qpYTsyqkfdBZk59vjdnnXNZy0QvhH+fKy
 f05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759752237; x=1760357037;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UDE8Z7qyajMCaXMrzd0HtBzhao2U4HKL5heui9QTuYg=;
 b=SJTZCnlreWybrpMFWjS0AvbgGJ1YPT9wxtRDHsYkIQ+zp/MBn7lqx837bJ2OSjA4EA
 Ph8zF138PlQMs7+bT+WESco2G05cV2JOrlEQ7SPKaKFlcU/C8qYN9ckaTYoGvrhhFihU
 Vya8GNY5+JdtHFMss37DMwBs7lvr1z2hTqaBR2lRc/xKD9yEA+SVd95gkowxyV9ZpoSz
 gxKrBOZUZZufiFora83030B1+X646b9VafQ/3J0c4B0ElbNHwb1nZvER5mAZ2hBC1hdS
 8unkpISnd///fyTRm8br6C41t+3Hz83W8n7tPv+vi/IwW/pGEiUoEr3bHFrNlrmCAK60
 XW6g==
X-Gm-Message-State: AOJu0YyreTJgDLhQhsZDpWVZ8RHaozatgone73lUAqtVAUD9I3uZL22D
 BnLqnEeyeX0WpJaRXOpP8y4m+L+/X6gm/5GsRIKJQq85JB2I01qqLf7jN5BzhM9HTjlAo2fjy9u
 UhCVO3zq/xuyHVb2ylbYhr0+L+PxX6suJIyXQsmuCAg==
X-Gm-Gg: ASbGncvid9eJDGj57MOuqiPycDZ5C8jyD5eh4vxkdsF8Rl8w0A+Ukmj3IlITS4b1v9r
 6jBdhbPG9lfDYgOXGiTUI6n3+7VM6z2D/7sr2YCF8qhJTlk0T9O3ULM9em17QvWUdQtPLt32aaP
 ODMRtQCKxKUhDClBfFXGNJzreWohBGwLWrcs2M0ILCUlLTrggtFEdqNp9MS+ZMTEjYyLC+TCBR5
 9Vz/OO+WiLOX5linrc2CHY/IdYSZfndaUHA
X-Google-Smtp-Source: AGHT+IFXqHZtrVuGjLZn1QobnOxMXN/Jcf2T2mSyTeyzJwvvKcfV62sSz9/Nq1M5CdubhOHsDhig01Poxi0vNmK/jEo=
X-Received: by 2002:a05:690e:ec7:b0:633:9631:2fe1 with SMTP id
 956f58d0204a3-63b9a05cdb5mr8677254d50.4.1759752237361; Mon, 06 Oct 2025
 05:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <CC5A0011-CD14-40F9-8023-8BF5F989BCCF@gmail.com>
 <CAFEAcA_PbfzTAW2qeFao1MhPG=jn9dtzt0AzwL-aPCEULijsuw@mail.gmail.com>
 <A1FB7B7D-603D-4D21-807E-17C1B18891CC@gmail.com>
In-Reply-To: <A1FB7B7D-603D-4D21-807E-17C1B18891CC@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Oct 2025 13:03:45 +0100
X-Gm-Features: AS18NWApgEMzNDZO0kxtQwB4du5YI0fAGqNypH-mlecyAMviTJQmK4da_dNMK_4
Message-ID: <CAFEAcA_F1OGcOQBw0xVG8g51t8v_kFz+oAtAve8mFMbKuJ6pog@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: add pvpanic mmio device for arm
To: Alexander Gryanko <xpahos@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Mon, 6 Oct 2025 at 12:52, Alexander Gryanko <xpahos@gmail.com> wrote:
>
> Would it be acceptable to add a new device like uefi-vars-sysbus that can connect to the sysbus?

I'm not a fan of the dynamic-sysbus mechanism either.
We end up using it for annoying cases where there is
no way to use cleanly dynamically pluggable probeable
bus for something. For pvpanic, there is a PCI pvpanic
device, and PCI is dynamically pluggable and probeable
in software.

thanks
-- PMM


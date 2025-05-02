Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8264C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 10:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAnmb-0006rs-Uv; Fri, 02 May 2025 06:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uAnmT-0006nI-Jc
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:38:10 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uAnmR-0008OB-V0
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:38:09 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-708a853c362so17010237b3.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 03:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746182286; x=1746787086; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3tIoENnubMgHGkKDFBO3Bv7GqNEB73Ou8SOy4pptmnc=;
 b=bKegW+PBLUJlciroGc3YLW1QcsgKYAF3hBXLcMbVyS7h4BDFBoT3+95i3n5fW2GDn5
 N9mb2MCwaRf9WcC2gZdKmmNscyqBzU1XOC5yWLv99DnPK+g8nUXh0Jr2yHTbqdFq2Hbu
 RRANzPPorFfSsQ0/h2KoCzKrZfyUIMHBsYYBJX0ZGRzAozhA7POv6VVGEFmWVV1mveiq
 M2A/lYfkruFT1t6cKFwv5o3loVQ5uPnX+0rvK1tlapaAL5m8CsN6/tqO9ZenPICWxTes
 MwpsDYs0X2iRSlBXNgatBh80XbPIbr/vykO3awYxveIsAtBlMWxb1GUSaV7Ky/bYl/CI
 FIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746182286; x=1746787086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3tIoENnubMgHGkKDFBO3Bv7GqNEB73Ou8SOy4pptmnc=;
 b=Sv99CETnMAbDpSUqO+EiKoHw2XPnv8KTTkGHkmer41jUTDlkrRY91yIrtO46y/UV7H
 Uh1F5Pz8WdAsLLTcx1O5I/6Y/BOekkA6uS7d/efeYbyCuuFzmXWaRoJXFRdFNT7OlhcZ
 xxa3tw+kHQQuKAoVr1SseYXXt4OY8B4KTFfrgleBHeIqveQaQyEW1njT+nzqzYdMA8do
 pit0dK1Und/KICbhGl2Heduyv6Zog7mHWZZRwKpLgGOkgfPS0nxiF/MuBmi71pfFNFoL
 fxl4THEKxLv+Ub2C6J3BO2fQpC/V4o3VcKsughlglRq94BJ73+pqZar81lrpuWv1G7YQ
 fY5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWRKXlrYzWNLnyC1ejKWQSJyJ2p82RCdKA9vgUDyJ9C+CRUQc/h+05vT2oICGEFp0WzKKpoONvEXts@nongnu.org
X-Gm-Message-State: AOJu0Yx5U5vPpoDqsTZ4/O/GYd8oTBG3hwhi/LCIPQRLrIpHdeqUna4I
 FCjv/Nf9IexMbQSvSO3lnHQ5Zs2juobQAIwdkYHAqizGwQfRSLwStMcYpeIdSkAMvM3S9ld5Ric
 +cPPxdlaJ3jSaSb00xBlhg1mUsRnbUEx0EQ8QRQ==
X-Gm-Gg: ASbGncu7lIPslke6vRhAfB84aUB16Mm1jFu0n6BMd4Lbs+HiyhbTsdBq2bqn9JmICVf
 QPPFxlJ7hkfYYhl12vXIQKb5xtAWHP6u62ADrOQY6aGjNJ59Y8pZb8nV6ArAwvAh678fm1Aq6fQ
 KQsDVYwzWS/ggo9gDH5UK4H8c=
X-Google-Smtp-Source: AGHT+IEbEvdtEXOY25mQz6ZwnIcW/v1hlvH7mLS/PE+kn7PKg4gqxTaAZKfmF/aecflgo3yFyOzzbJUeeJpFKYJvlP8=
X-Received: by 2002:a05:690c:905:b0:703:ac44:d37e with SMTP id
 00721157ae682-708cee1bb77mr34764107b3.37.1746182286683; Fri, 02 May 2025
 03:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250428022934.3081139-1-timlee660101@gmail.com>
In-Reply-To: <20250428022934.3081139-1-timlee660101@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 May 2025 11:37:55 +0100
X-Gm-Features: ATxdqUE6ujI42P6__rX1X47ikec_mSeFL67QxstZSelzdeBQnvkazZTqBY6e4aE
Message-ID: <CAFEAcA9tUdcunWBrtbxXhkjjrABM_EN8ZC+HKUNG0nWoOjPQ5w@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/npcm8xx_boards: Correct valid_cpu_types setting of
 NPCM8XX SoC
To: Tim Lee <timlee660101@gmail.com>
Cc: wuhaotsh@google.com, kfting@nuvoton.com, chli30@nuvoton.com, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Mon, 28 Apr 2025 at 03:29, Tim Lee <timlee660101@gmail.com> wrote:
>
> NPCM8XX SoC is the successor of the NPCM7XX. It features quad-core
> Cortex-A35 (Armv8, 64-bit) CPUs and some additional peripherals.
> Correct the `valid_cpu_types` setting to match the NPCM8XX SoC.
>
> Signed-off-by: Tim Lee <timlee660101@gmail.com>
> ---
>  hw/arm/npcm8xx_boards.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
> index 3fb8478e72..6d3e59f6b9 100644
> --- a/hw/arm/npcm8xx_boards.c
> +++ b/hw/arm/npcm8xx_boards.c
> @@ -213,7 +213,7 @@ static void npcm8xx_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
>      static const char * const valid_cpu_types[] = {
> -        ARM_CPU_TYPE_NAME("cortex-a9"),
> +        ARM_CPU_TYPE_NAME("cortex-a35"),
>          NULL
>      };

Is this worth backporting to stable branches?

Applied to target-arm.next, thanks.

-- PMM


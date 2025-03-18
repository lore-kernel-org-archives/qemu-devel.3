Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8BAC28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 17:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuaIM-00005N-IG; Tue, 18 Mar 2025 13:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuaIJ-0008VH-VX
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 13:00:00 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuaIE-0003Z9-RP
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 12:59:59 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e60aef2711fso4314243276.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742317193; x=1742921993; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sMT6Jk50mVoND0FsUtikB0YOobI1KlGFSg+zmDyEN4Q=;
 b=O32zzG2Yn9X2Y6hnamg1Znp+NfgpJVpHBHzjXaIwN85wVWunI6wDpQPZdZY3fsxqKE
 bB18giVOP2xaHxVaSSXZchERdpVVt/lB5EIdK8BjXBGI0YP5W2+FyU5mMKC2ARaNXJVI
 nSTNQe6Kp4a2jQy8qhlRXamoTY4cTGBqHMGazIq6iBS1bvvbUIuzXBygqO8tCNe3VAKV
 flVq1bEaQuHCnlqGU/lEGNNdLUfmeoIgwhflrp/tQm/XUdKA8wyPHdyxHTyt8U2U8gGe
 i9g/IGsFZiGApwRT37gvbu9U/A1x69Upj7B9itUb3QNRW3fFfMNJd0TQp72EkxRkJYiU
 Guxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742317193; x=1742921993;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sMT6Jk50mVoND0FsUtikB0YOobI1KlGFSg+zmDyEN4Q=;
 b=BKjTV+E5kONgFAn4qNufMxG/uxu1T2zQWCArinaBnQSJUsbWjCHl+tg3PJN70FxQ53
 vhr2/6XuFc1OATBqkeX/sC8taFiRXWN9OsMDaDOLHCZlmW3Vh2QsaT6GLmBoluYsrcSe
 7TOABkGwx8gZJxU2gewHxtg2NWV2JUOZTL1anJiZJn8yvJJSujBO0qK7cB9HdSd6OLMF
 0672sDza0IsnZ53UxOMxg98pWDK1C6DpMS3Z31adX3bqw8pxCO0hxgdnEJeuYaPmSjYU
 DYdzOfSGwMMs0wgNB1BKtnDW9+DFyOZ9yjWZhEg+t7zGR/kOzoHICHclMU4nP+oH/BsP
 hYVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXozJpqHcmH0AKni0ABuKFTBCOVPS4kYN5MEpT4l6bSRTWeUSyg6YXnoV5is9PTRcKvOnyJl4sGEeIl@nongnu.org
X-Gm-Message-State: AOJu0YwpOLuNGAT6iuEvEwDhTUsIOOY0cNGwakE2+yT/N1LQR5QOPEUR
 z4fOyqSIfQOjeBGxUWK3DcMJ8QInqz8G3Rsr1lMq3tXIhdWiTNlhbK9otqVzGYTuJghhuxvxGN2
 zDoiqWtSQtRt34tLX4jPcmxmuzvmxK6pX+wJp6A==
X-Gm-Gg: ASbGnctHbWu5dSlUZVPnR1bvnOHzJpq5tO5dosdRf1DW0mBgWu9CaU3HPoMSpZ0R1X0
 cyozHL0OgFYSKErxBObMBCHpRtP51KQOTJiKPL9lLZyDTORxC6pDKDkY78cyt2Rlb+hX0Wb2llW
 2QedFDpUBbq6dvHH/lGaLLjvqG894=
X-Google-Smtp-Source: AGHT+IHmZ6Fa8BhEnxz3plYwFJ91IY+A6RMunH10g44sgNSAmhYNMuyIfK/u/Av8WFTqghoPz+VU2BfJI7RkjyksJXQ=
X-Received: by 2002:a05:6902:723:b0:e5b:420b:8dc2 with SMTP id
 3f1490d57ef6-e63f64ec939mr23149287276.18.1742317193635; Tue, 18 Mar 2025
 09:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250315142050.3642741-1-linux@roeck-us.net>
In-Reply-To: <20250315142050.3642741-1-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Mar 2025 16:59:41 +0000
X-Gm-Features: AQ5f1JqIlD8ykM5M9CeqTV_4wmI9kZyi6aqmFVrhnLJr9HTlxu13djKw47PEY5E
Message-ID: <CAFEAcA-zPwJrq3oQk3MRp9ZCyTzDOg2-Je00v20pVzrKe8he6w@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Add missing psci_conduit to NPCM8XX SoC boot info
To: Guenter Roeck <linux@roeck-us.net>
Cc: Tyrone Ting <kfting@nuvoton.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Sat, 15 Mar 2025 at 14:20, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Without psci_conduit, the Linux kernel crashes almost immediately.
>
>     psci: probing for conduit method from DT.
>     Internal error: Oops - Undefined instruction: 0000000002000000 [#1] PREEMPT SMP
>
> Fixes: ae0c4d1a1290 ("hw/arm: Add NPCM8XX SoC")
> Cc: Hao Wu <wuhaotsh@google.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  hw/arm/npcm8xx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
> index f182accc47..e5a1929ed7 100644
> --- a/hw/arm/npcm8xx.c
> +++ b/hw/arm/npcm8xx.c
> @@ -346,6 +346,7 @@ static struct arm_boot_info npcm8xx_binfo = {
>      .secure_boot            = false,
>      .board_id               = -1,
>      .board_setup_addr       = NPCM8XX_BOARD_SETUP_ADDR,
> +    .psci_conduit           = QEMU_PSCI_CONDUIT_SMC,
>  };

Why do we need this for npcm8xx when we don't need it
for npcm7xx? Or is it also broken on 7xx?

thanks
-- PMM


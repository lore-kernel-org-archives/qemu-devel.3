Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29CACE7B1C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 14:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sma4d-0005IP-MA; Fri, 06 Sep 2024 10:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sma4Z-00050j-2M
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:36:27 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sma4W-0007XI-NK
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:36:26 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c3cdbe4728so2266688a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 07:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725633382; x=1726238182; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ogD1vTWNLkn3DUJWNYKKaFiFPRQDvOm/h8bvm2fWXXU=;
 b=rqZmWzP+GACrDdMKW7yF4JdB3ic8FA8hS0kwZ4y4bwp2PcoA3vvxbsWZ6FrEMwgD0y
 IWfmWpiTa7PNGEOxrRoDuo4+4f0N5S6zaTKRRa8l/1Qx33lpCtwER9u3xvfo0/VnpoY8
 21YmOLPDTUf7rbMjv/SQdxLrvPNePRJDqYjfOjLMYvR/q6mj/dPwlFGmsfkZo93gSRxY
 +X9J/YWum6mH5IHuR++LXt9rO/yrArcyaLEC1KZpeSTeMMVfmola1as/YOJQ9tYU8hzM
 5B3EfpKrbwDvASbdRLezyYdmTKWjxSd7s5reu1J24KqJVxileA6fffAs11B/aTmNfpFU
 x0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725633382; x=1726238182;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ogD1vTWNLkn3DUJWNYKKaFiFPRQDvOm/h8bvm2fWXXU=;
 b=BqA1mLdyTFPJGfGwXwy7kxq7MOCOUbegoMMhYDcOKzok+hs4+FleR0yxAoc4xEW8BK
 9X2+qDdXYKGBqokuc5dKYa6BM97YxMUFWk0r1S4P5HwBoBAqriSRGJ+nIXd3zcjK35f6
 dxjsyesm4t2R6oGj/uTeS0jBPSFK9aUMz/+cCyUlpUawD294fDqpkb56OZV7U+4tjOb4
 OmJB7kFXt9aiby3dH4BD4bzerIVTliGIEL02jQb2mFWqDWQNY+foQSgj8Ox+LzK3Gxnq
 m5v+KZmvzuKv7+/D7FSA8Ps9cUtL0JgUi7Y+m1eVcxByhJuSd7ybIg3ygfOfpbzow8mL
 YPhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsC2JxKevsP1kmM5fxgYEXl2HUueBclhVkGj0MShkBmJipxnq5A4MQX8U90zXENWARi+rOu3S5+sF8@nongnu.org
X-Gm-Message-State: AOJu0Yz+uF1FvVWO7Gjt4tVdUunq47q1cyPELcf3f8HWBShAMnU7AmG+
 1z/Oir1Oq+fHnw2P4fgvJAqMou6Mt7PnHFfeWPN+Km6r5vj4gaCnuWhnR8yxuqic4bD77AaW/6o
 4kXHcCigjBOVQFbB+Jxb3To/dmeWgk5suuseDtg==
X-Google-Smtp-Source: AGHT+IFWaa63AId9T1hsYVwFROL2/Kb3Dtu1tCwDKMPJqH85b2WMNRSx8Tc2PeAa6ZGtG/j28DnU4MwV6IULFENYfbc=
X-Received: by 2002:a05:6402:40cf:b0:5c3:cc7d:c2a0 with SMTP id
 4fb4d7f45d1cf-5c3cc7dc63dmr4275679a12.0.1725633381957; Fri, 06 Sep 2024
 07:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240827034927.66659-1-doug@schmorgal.com>
In-Reply-To: <20240827034927.66659-1-doug@schmorgal.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2024 15:36:10 +0100
Message-ID: <CAFEAcA_KEMTT8i8EhnYOgGCeGEEn093N2UF5kiFJ-YZFD3XSLw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] hw/net/can/xlnx-versal-canfd: Miscellaneous fixes
To: Doug Brown <doug@schmorgal.com>
Cc: Francisco Iglesias <francisco.iglesias@amd.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
 qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Tue, 27 Aug 2024 at 04:51, Doug Brown <doug@schmorgal.com> wrote:
>
> This series fixes several problems I ran into while trying to simulate
> the AMD/Xilinx Versal CANFD controller in the xlnx-versal-virt machine
> using Xilinx's v6.6_LTS_2024.1 kernel. With all of these patches
> applied, everything works correctly alongside actual CAN devices.

Couple of Qs for the Xilinx/AMD folks:
 (1) do you intend to review patch 7 of this series? That's
     the one unreviewed one and it could use a look from
     somebody familiar with how the versal canfd h/w works.
     If you don't I propose to apply this series as-is next week.
 (2) it sounds like Vikram Garhwal's AMD email is bouncing --
     do you want to nominate somebody else to take his place
     as co-maintainer/reviewer of CAN bus stuff?
     If not, we can just drop his lines from MAINTAINERS.

> - IRQs were accidentally not being delivered due to having a level other
>   than 1. The IRQ count in /proc/interrupts in Linux was stuck at 0.
> - Incoming CAN FD frames were being treated as non-FD.
> - The CAN IDs were garbled in both RX and TX directions.
> - The ESI and BRS flags were not being handled.
> - The byte ordering was wrong in the data in both directions.
> - Incoming CAN FD frames with DLC = 1-7 weren't handled correctly.
> - The FIFO read_index and store_index wrapping logic was incorrect.
>
> I don't have any actual Versal hardware to compare behavior against, but
> with these changes, it plays nicely with SocketCAN on the host system.
>
> Changes in v2:
> - Added handling of ESI and BRS flags, ensured frame->flags is initialized
> - Switched to use common can_dlc2len() and can_len2dlc() functions
> - Added fix for FIFO wrapping problems I observed during stress testing
>
> Doug Brown (7):
>   hw/net/can/xlnx-versal-canfd: Fix interrupt level
>   hw/net/can/xlnx-versal-canfd: Fix CAN FD flag check
>   hw/net/can/xlnx-versal-canfd: Translate CAN ID registers
>   hw/net/can/xlnx-versal-canfd: Handle flags correctly
>   hw/net/can/xlnx-versal-canfd: Fix byte ordering
>   hw/net/can/xlnx-versal-canfd: Simplify DLC conversions
>   hw/net/can/xlnx-versal-canfd: Fix FIFO issues
>
>  hw/net/can/xlnx-versal-canfd.c | 173 ++++++++++++++-------------------
>  1 file changed, 72 insertions(+), 101 deletions(-)

thanks
-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40933C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 16:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLqS-00081B-0h; Tue, 04 Feb 2025 11:32:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLpl-0007DM-17
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:31:37 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLpi-0003bP-BO
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:31:32 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e3c8ae3a3b2so5191018276.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 08:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738686688; x=1739291488; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=weNFiOUeXuTkCzNy2Pj0WVjcsbJPxWOUwHhfVmugXdo=;
 b=MC5uU+2w4y5ufsunKyejsJx9K5ciFSmAEQ+3868s0w7kP+PHNSTha1FQWJpCCwMO9s
 1CYCzZo4+xHDE58pHpbI2aSGF6bL0DtVDtx7wPjCPlcJNG9jLPRCFq//a9pnfmMP1imR
 GS/Jvq24VXgxVPp6HOQMq4EoJNicY5fRY+mLIX4INobodwG+YH8RaLjVqWSAmtd9LIgI
 EN2Mg3wnyjzSQzK5oUAN2PcnnhR/YCGMJgeV2cg2eR8oty/HoA7UbYtTGgfqObsHOZst
 0NPXOHunVU/4VPXN45FwG9P14Xrb0op8J7+TFJdJvHx9vDIAXr43oQarKv1kUnUmX/yc
 PhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738686688; x=1739291488;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=weNFiOUeXuTkCzNy2Pj0WVjcsbJPxWOUwHhfVmugXdo=;
 b=kwGpXGzf7rMCopHCRF4xuWE6rqXWveIKt8QrEmGjqajjZ8aGEdutdZ/i3d02KrFDsJ
 n+KS0XfGnsV88rpX0T79ryuGbGsmfT3xQLuoN5CStHnRL7G9LX5e2NZiViT02hmbCNtb
 Rq9oVL+j5S4C6s4///8fgNaoKbhohrF3METiwSduMpu7X2OchCydfz75jClkWxIKJdAH
 p0Cx9bBErxpQyn/1XLuuKfo8h6SRyQjBKx7p3NuOaI2IARJa012UD4gsdISdPxHh53b2
 ICB33aetM1/ltedeZN8kJdFUdtdv7XxH46BETvJsTQ2G3hebQRv0wa1blTICS1m5X5St
 5wDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9/d9WkUsQ1VJ5lH1oPM81b9wij9SDz2ZqUPrTdUuEoSCn99tvTZSSJi51m8GoaVwLJghLejN/6NV+@nongnu.org
X-Gm-Message-State: AOJu0Yzlvxe+iFHTDc8YplQydSm0xz7xI+sJM4qes2qpbLm8K5AwjfVA
 3/8od647WYcbe0W0Y/Jb1gdyBO1FTxUV7ML/KwF41v12FXh0mZDt9ICM804Pqf3wGaJXMdbWQ6N
 nswpglcjSANKZgiYtqdEjJCNE9w68P28DNvrnNg==
X-Gm-Gg: ASbGncucjjXSdfw8TNQI/xptd76q84SxgdbwEEsL6a3M3ceSVtZT4IMOlXaOZ1i9IjV
 dpmy2kVn6Hn7UNIFwxvwHuBAK/IpCi1IpG+OScdg+yKcaBCx4hi59S6Vdrb5cTvr0cnCaF/i8eQ
 ==
X-Google-Smtp-Source: AGHT+IHoIW+L64zU0DC7FoWspbjQGR22i9enKmWljsRRtqPfNjwcnPLo9b5RK4/f/gL3RNksxeHRseEOL8nS4aurn9w=
X-Received: by 2002:a05:6902:1ac9:b0:e58:1112:c3e6 with SMTP id
 3f1490d57ef6-e58a4a9c707mr21143927276.2.1738686687935; Tue, 04 Feb 2025
 08:31:27 -0800 (PST)
MIME-Version: 1.0
References: <20241226082800.2887689-1-wuhaotsh@google.com>
 <20241226082800.2887689-4-wuhaotsh@google.com>
In-Reply-To: <20241226082800.2887689-4-wuhaotsh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 16:31:16 +0000
X-Gm-Features: AWEUYZnHcokF_MJBr8VGWEBW9XSBoMAJsmVJArX1QgEeKlBk1cXBPVIP09i_Q8g
Message-ID: <CAFEAcA9h1P_Z8MX+c9yW1nvbZ1YofPJNoqXf9CoyP5jHVbL5JA@mail.gmail.com>
Subject: Re: [PATCH v2 03/17] pc-bios: Add NPCM8XX vBootrom
To: Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, hskinnemoen@google.com, 
 venture@google.com, pbonzini@redhat.com, jasowang@redhat.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Thu, 26 Dec 2024 at 08:28, Hao Wu <wuhaotsh@google.com> wrote:
>
> The bootrom is a minimal bootrom used to load an NPCM8XX image.
> The source code is located in the same repo as the NPCM7XX one:
> github.com/google/vbootrom/tree/master/npcm8xx.
>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F98CCD0438
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 05:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vczZg-0005V4-Dd; Tue, 06 Jan 2026 00:25:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vczZe-0005Ug-Uu
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:25:43 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vczZd-0007Hv-9K
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:25:42 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a0c20ee83dso7474805ad.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 21:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767677140; x=1768281940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OagJyw204oOcrZ3boHqyagBPaZ+eBts0fowwxGClcUo=;
 b=VjLJzHrfHiaEcnnCALA1NZdhya58D+2AnjFPLIlQ1m/nvuqKQoKxbTSe6XY8t0G2lI
 ko8eM0CAlKhL2Nwwi0kUGkPkTruYSnhQh052FezR8ZZ+ykQnRAMWHsMH8DLJL4hrFwjD
 jALlleH1C8AwZXrHjSTZrMCj7gA1nXzOKD9RaAFxSbRT8TD4gkT/W+0H5eJcGLsRbQi+
 h0PAXHbhmlFS7ZiMgewLgaO6VVDB9U1Ubykp3J/FiqTLTPpytMVVYKjfM/1eVMLCz21D
 wo7tULeQ86yxjiy3C+oDa6U+QD/FzVv4kkLqJWCHYC+yYI2fFuVdgvPqOlIaYKyeTV/+
 itnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767677140; x=1768281940;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OagJyw204oOcrZ3boHqyagBPaZ+eBts0fowwxGClcUo=;
 b=Hwb6rSLUfcA/Q2KqhiP4mMnb8SIBz+FQYEM9jDorD0iKSNBFQwZRIBUTWZLAqPobBF
 8agw+ml21hCYP57CqmnD+3pzZdA5xk1bKPXSePNgIPg0p8PvkIqVN5+QLATDId/Nw9l+
 M0FWR1pUr4+ON1BXLpq1bz70+5QXsKKzrR1d0fM1OyWY49tXjBSaHhEt9VPq0LqnJF5N
 U0XdH04i8BqGWeNu2s9MpP7ODrpS8OJGUQGU3H2CGwrC0R5De9XTfsFnaV8nfq5Tgjpo
 qzN/7iXOdZYGT66Q8MY6fqVxIEFxscaWlgiud749dLjiYJHHJm2wOQTEF4IlM0mxypTu
 jmOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWWorH9XaERGoJCH2OLOGelE3TzpZB/QIsY+c4AIju/REfyhCODHdabG3dMdl49eJIaDzYjYdHwTKQ@nongnu.org
X-Gm-Message-State: AOJu0YwvZRECVJzH6x0HG/dqBU2P2th08xBd1h+oTVpElEV29v5Lf6UD
 skdWmRsHFbQcU3sUuJsaVqtdEjxM1M3OlURYbekTxO6fTsttIgcNYLiCbN10izbKT/s=
X-Gm-Gg: AY/fxX7Lencf+ZCEQmEFYJ6IVuo+7XLjY7VX2LniSiakA2FtzfHeaxss2bGV2g4KNNF
 WZmI0MBQ/3+x0U20uRub8vsc4BehB7upkdwv4qm8nQsn4p3gdoNMrtvGFgoU0kRGJS84n+g8yjX
 QRpVKphhtNe7c56GqCAjKufzIl4uxFqI/MTXaWit+/eWK3GV5qTCVIbeAQ213WGQNQg3V+0CM+s
 J6A1INYK9PJXH3bI/4Xg89qpS+pDv/+LQTnHCEkpIC3rR3qWpKXEaJi4YLrHCTbZ5sUMMk5o8/Y
 oRoDSx+fKPGdPq5UGLuI+AhCtviOw5fh5iNZ60eFt8nR7GxiS2Mvo1vWmPnJEEkzDaD00TsXbfN
 tWBEkzD4WY8br4sTcwwWhPJL70Qgb2znNtYhkcvA2Qhtsx38Y2vuB4urn2F++moAkPq0NWX8RWE
 jIoUe8jvI7HOJWhWn5glR1jQH5KI3ZOQ==
X-Google-Smtp-Source: AGHT+IHMoQArOgOcd3HvdbkaScaTxW8IzpTJsi4ern51FMAMQDEw+SUZ9D4Su7MM9cAoQWJpJL2xPA==
X-Received: by 2002:a17:903:950:b0:290:ac36:2ed6 with SMTP id
 d9443c01a7336-2a3e2d5b815mr21229995ad.14.1767677139587; 
 Mon, 05 Jan 2026 21:25:39 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c47390sm8624125ad.25.2026.01.05.21.25.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 21:25:39 -0800 (PST)
Message-ID: <3647fe54-7a2a-4ec3-ade5-2cbb23e395aa@linaro.org>
Date: Tue, 6 Jan 2026 16:25:35 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/36] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260105125613.622667-1-clg@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260105125613.622667-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 1/5/26 23:55, Cédric Le Goater wrote:
> The following changes since commit 159107e390609f71b78268a4888563dcdce6ac65:
> 
>    Merge tag 'pull-hex-20260102' ofhttps://github.com/quic/qemu into staging (2026-01-05 07:35:40 +1100)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-aspeed-20260105
> 
> for you to fetch changes up to 9cbd8ee7f67fceee51d3c993a282e5adc397b6b9:
> 
>    hw/i2c/aspeed: Fix wrong I2CC_DMA_LEN when I2CM_DMA_TX/RX_ADDR set first (2026-01-05 10:38:02 +0100)
> 
> ----------------------------------------------------------------
> aspeed queue:
> 
> * Removed the ast2700-a0 SoC and ast2700a0-evb machine.
> * Added SGPIO support to the ast2700 SoC, including unit tests.
> * Added several FRU EEPROMs to the Catalina board.
> * Added support for the new AST1060 SoC and ast1060-evb machine,
>    including functional tests.
> * Fixed the silicon revision ID register for AST2600 and AST1030 SoCs.
> * Added an SFDP table for a Winbond flash chip.
> * Updated documentation for Aspeed boards.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~


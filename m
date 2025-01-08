Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334D1E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdE1-0004wp-6M; Wed, 08 Jan 2025 16:04:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdDx-0004wD-8S
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:04:21 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdDv-0000VO-Q5
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:04:21 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so143829f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736370258; x=1736975058; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IV77xNjjxT2bpQckQDvFW2MSzwf7sBnEC5E76in7R3s=;
 b=mU8PHL/uDO+C+lcgyCvDfH/DVo8AvaO4Ahwt43GQY/bNygzPhzwLmY+CBC/K86reUw
 srTu2cppLIVvXhJImEF8RpSyPFafiblL3rPoA3TdqXx/R2/jzJy8tCpwf9kzdg4PCwp7
 NBdFcV1+5lsjxcE8nYuFgOfl0BLkSM3fM//Wr1Xzlh5H/W66gXiFACftTyk2GJHt3kLg
 gqpnTEp5a4u96V5aXaOphWeyqw/ZdHVb0F7TUYVpmKLB/gP/Nu+2m5fyynjNDkuSUBjh
 RIS/vg+3W0Ug6UJp/7654X4kNnyFK92bb6v+eFIvwM/0Kxs7F+Iku0PyFpMF8IdBec2/
 dIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736370258; x=1736975058;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IV77xNjjxT2bpQckQDvFW2MSzwf7sBnEC5E76in7R3s=;
 b=xFCWj2SDOb2a3X0hvtewFO8Oqaj6Alwuq+JjBYFZIb06niOEFAcLAAa5x3xPFlVJxQ
 pQ1o+xR8XZ3B3ztdtCbLB0F/sYjpBsRCmAKNSlugLUn3leIKWkjEhwSCKZv5noHABnPJ
 2FNcficpRvk3HP9LJmHRGmWXoKDprsvMI+l7aH3VL2OACKJkqrv+ddFZC6TwhRmrMAiP
 qIuzUEe+k7+BJ/5VhCMw9AXlcjSdbrMt8OP+AnYpFUehRvtiGBnyRmEmjnSQ9vhkHC0W
 MBDzo0U0YnbfLvbXMZMWjeJPcURlufhYMT9XRzpkyTc0QbzhJ3J2PYf9QmEgL7HEUigt
 CaIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF7Hloj56ovsHNUCCZkOqNUZxJYGlxv4DrMOrm7N9BQ7TLRjj22subkW40AzIAtU5egIGWW897SdJe@nongnu.org
X-Gm-Message-State: AOJu0YyoKs8y1wDd3GfnQhEwX+h5iqVKyBTD/D9rNlzH2CEnfsdCs7+K
 nDFzyWgf+GvYVs+ta4t6fpibJkvHVf7ndj6v+SZGtryb3o5jJU34UtnnysbVfTANlV6tB43TCh3
 EDV4=
X-Gm-Gg: ASbGncuKMiDHgsfR3MSnG+P/n/X2rZc3XCa4J78lwHBbvlzeBDdH02UCuQea5zsl1YO
 hQ/Jx6MGvBlNXwOLgnsYRz6C3iDRfSogKXpByZfoH2cy4Xuk0188sJZrjLgGriykC7AgToQnlto
 h7p7oFbXbM8zb3Xbt+vof6uV0/qEjpbeLZwD6637NDBtiiudl80+eWy5MnzDoxJkD2cdJtQ2K/j
 KauF3o8a3TCtXEa4PLURmcEIfZpTj8F1VlemotjPuirQBZ2XtPwPoOStHiXC+rLwZcf8C5mSC2I
 LOHLqi/f48DAXTmcxf+htVnh
X-Google-Smtp-Source: AGHT+IECNneE+adDctYigSwtKX+ApUpGJHattzVcu+V/yeUaNWtvOHmC/8FskVZxQvWYctCh59ba7g==
X-Received: by 2002:a05:6000:1aca:b0:385:fa3d:1988 with SMTP id
 ffacd0b85a97d-38a872fc2d2mr3697051f8f.8.1736370258103; 
 Wed, 08 Jan 2025 13:04:18 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8a62b87asm1168674f8f.94.2025.01.08.13.04.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 13:04:16 -0800 (PST)
Message-ID: <b18a35be-1d39-481c-a2ac-4e1b2d33028c@linaro.org>
Date: Wed, 8 Jan 2025 22:04:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 81/81] tcg: Merge INDEX_op_not_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-82-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-82-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 7/1/25 09:01, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  3 +--
>   tcg/optimize.c           | 13 ++++++-------
>   tcg/tcg-op.c             | 16 ++++++++--------
>   tcg/tcg.c                |  6 ++----
>   tcg/tci.c                | 11 +++++------
>   tcg/tci/tcg-target.c.inc |  2 +-
>   6 files changed, 23 insertions(+), 28 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



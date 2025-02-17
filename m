Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45647C021A6
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwAU-0006Aw-BO; Mon, 17 Feb 2025 03:07:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwAF-00067N-21
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:07:39 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwAD-0008Sf-JD
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:07:38 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-221206dbd7eso14960825ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739779655; x=1740384455; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z9fZIU90g1Rj5IBfm4sORMxSWKA6AXGSbkNUM/+DS18=;
 b=r9ijRD7llYw+uiJWvR48T/GlstHcl+2A8nF77f7Slk1PYzbXWk2HbS/2UZXghUJUWF
 47rldg4QjGrQtsZMWP+amb3Fo2WctdgexGNtlle+HE8FBZihl7bR2akVHvb5DiKFmEXu
 OosXIdQHmncEEW9CikifyEFbiapFIwRqA28w6+FbfxKtGbvBlj81h0P2+46BgdTj0uSR
 Ox9+AYynEXH69ipdrZupZaDm11197YLUsSyToqze2uRZUNEReukDBs3q5nGI5htSZi9B
 5Zmpgk7sKgjsAiVtYFpatbH5Rr3vt4CFLC9GvrGD8NO2dy/G2CuCN8nasQa8/wTTg52W
 cMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739779655; x=1740384455;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z9fZIU90g1Rj5IBfm4sORMxSWKA6AXGSbkNUM/+DS18=;
 b=rore04Tx84eainLiaqw8IAEVcD+cqYUj1Km0806Xq1zofUEsO5mNqXDZayXg1czZqS
 xcMomqa1Rb8Oq5F4RLWeL2IYTwUsG3fy6djvrFCH3WYBYg7qFgZ1dpFFC3TnnDtu8nlf
 Vu/bBCu8RKwb7TBEaGLJS672IWqqoDeH3DsQQ7umexY8fpETuUwZa2A9ew9Yapwjq/XZ
 Mtns4ew2+xzn7zWuTHhh1hLEGtBUnuciRwOHhl7ozo/hH+xVdf+jD0hhS81sa5ignjp4
 QR97OijCBYViIv4kig1MZfsM5sF9J4Ov0yGZkxkwyFHTbfh+uC2wykSxvTWDYoNUeTrt
 RaXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUBZa0LcX2mfdRB0tL+LSsjXRxiWB9NwW/Q0KfW+XE/pvfBAbpQUH0jynQkaiqX/FAod3oFJKGQjg2@nongnu.org
X-Gm-Message-State: AOJu0YzL8Pb/5Ya3+9ytXdxUPq7WvjEZ690SjGZQWWRMoE5JyWC+HXjR
 mk24BA3V5P9ydjlgeS64dIWosm6NzfzA9e/y9ZXL9cMsXUFiXW0CtG3LMO6Zs70=
X-Gm-Gg: ASbGncviIWnWr+Jlmp50PzynTZ5FMbmb9nHipf9LVcEYVIZa5GE3V6RPy+i0xdj+F2X
 zLTXummKNLdTwEl++xj5dJU+XaHLyorWheQooCJWB2nyupVF671XoNvD53J+/ADjZlqHyjHgaV3
 c2Y4aU4xIgsnP1Qzg3XtuYJsxQIf29/iQ/7X5jw4IMbOJOc24Ru8Kwpuhce4GskuGj3qmRZY5E7
 7Bf4A1udQCtFkglFtVAHebI67l4mSOL04KDtvu2lLZdjo9/heT1BsiDBgE8bEb71s3jIrNEooY3
 LCdJ6e2OOuEyvDe4bJYtNR1P1uvz4A==
X-Google-Smtp-Source: AGHT+IG4nJf8yv94SBqb1zNCFsrWn/pnalABbj8uFu8DPbjyBu3zAuCWUoiLySNaCWhfoaQFa8Y93A==
X-Received: by 2002:a05:6a20:a125:b0:1ee:615c:6c99 with SMTP id
 adf61e73a8af0-1ee8cb0edc2mr12406576637.5.1739779655298; 
 Mon, 17 Feb 2025 00:07:35 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326ace1270sm3214776b3a.114.2025.02.17.00.07.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 00:07:34 -0800 (PST)
Message-ID: <f459b4b8-6ae5-4f59-b497-2a4e274b6515@linaro.org>
Date: Mon, 17 Feb 2025 09:07:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 087/162] tcg: Merge INDEX_op_bswap16_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-88-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-88-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x635.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    | 3 +--
>   tcg/optimize.c           | 7 +++----
>   tcg/tcg-op.c             | 8 ++++----
>   tcg/tcg.c                | 9 +++------
>   tcg/tci.c                | 5 ++---
>   docs/devel/tcg-ops.rst   | 2 +-
>   tcg/tci/tcg-target.c.inc | 2 +-
>   7 files changed, 15 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



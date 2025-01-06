Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EBCE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 22:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUvME-0000NN-ML; Mon, 06 Jan 2025 17:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUvMA-0000Mp-72
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 17:13:54 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUvM8-00007K-Gz
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 17:13:53 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so7065689f8f.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 14:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736201631; x=1736806431; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HrZg0/iuGpvI2yXx7shNNqh2Dm5J17MDyroMKz1K5TQ=;
 b=pCNCb0yuAKLBcWCgn/qO/UZ/qYJBdoESRQsbu0HLiai77sMPLbByEbdAPuwIKMrzBJ
 jNbkSyC62nnfOepOmc3kGyiF3x1BdsdEIsaJlncDF0iRe/h2TgXkpRbmtDF52COpaOmf
 Z85LIljVW799rNQVv+S7VVWu1o1pzIJp/vj7IgppKo9QAblRzdL5CwuKwjcWhsFYpkxg
 DujV+A/CIG7LXagtznLh4QfbVi9vz25a2pwRVGUzHywejCYFIH5ZZr9mnNharuvWzEk6
 nMOSDLO5f8oeOthaXKK2qhIr4ZtLzVFLQsnHqQYmlz4jJAWl1G0rcCkp3msdY4SCgkZP
 mG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736201631; x=1736806431;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HrZg0/iuGpvI2yXx7shNNqh2Dm5J17MDyroMKz1K5TQ=;
 b=KZ/OIM2nRZohT3mutUr0gEqoRJVPts80rGHxHWbg72mUw8aCXrj5vsualufMLFfcOz
 7hjJrthnirKc6nj14JdYZ8Ewi3W/kItAOmeJomq3R6Q47U5UepgCyAE6EM1LJtEGmJx0
 xluh06YJrMfi0jXay0J0XSKA6r25+1i73m7yvSznlYjcbEcpOKf/zN3pYIIpepXhKzGd
 +fetiTncbAMUEXAuBiPJbp6rGwJA2nU8Rk7gmw6y2jq4JGc6bGsJG8cz+EbMbafwMA2L
 hBKnziGZ6m6E5lTT7jJhvMDZIY6ibdgn5PBHZLIVmLX11IY8tQvKhw7vfCeg7vaPzzSd
 vMyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS0TZpS2ZXyAw7AYUyGreC5PVwJ1sQvyBHot6Vk5OJKLLj2bKgFvzOgm7y0FAC83sIr1vjLYXiwozl@nongnu.org
X-Gm-Message-State: AOJu0YwL61mEFu2R+H7H/x/BKhen5zgDg3Wa97uEwRFyQCh/OGxAvsr+
 8oX/XjwyTa2p/f62oJ13dv2H4dwdY4vdHnoo6/h9z9Zvm3Avi7T+VW9WQSU4/Wp105PdfCbVBh7
 wnbo=
X-Gm-Gg: ASbGncsFkEuZ7FaxxLG4vixlax39njwn+wP/20Dz5N87GjjvJ7HO0CauigsAwM0wbHP
 m4K/HD2Nd3xXwZgMOhm3z8qE3USsc4EcevVS9buorif+tB06b7gBhLp84AYH8tdL+dA4WxNj49O
 tdLkc1A/mKiLPVu0V1GwMVrXKBI88tKhfsq97xUxT6cje8kIoP4mQnVH831PJ0nduvpfLvTAjOp
 5Zazh0o+bZTJD+uC+gwcrTLUmk2WtIHobc5NMxovmAYMIrUzfI50/dhwrrKRKrWeCkjeuOfVLOI
 N5f/0ImAMg3unc3zp+GV7t0A
X-Google-Smtp-Source: AGHT+IHtYrrIzMORTaQQzjtNFbh9h+K+rRQ2w7NQovTDkKXCvVLFtvcUGURHmFe7dwwEzWV5mvfI7Q==
X-Received: by 2002:adf:a341:0:b0:38a:4b8b:c57a with SMTP id
 ffacd0b85a97d-38a4b8bc5d9mr26213822f8f.44.1736201630681; 
 Mon, 06 Jan 2025 14:13:50 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832e74sm48162753f8f.30.2025.01.06.14.13.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 14:13:50 -0800 (PST)
Message-ID: <ef237f04-f56e-463b-8a24-5c2b8b4e3049@linaro.org>
Date: Mon, 6 Jan 2025 23:13:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 61/73] tcg: Merge INDEX_op_mov_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-62-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-62-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 2/1/25 19:06, Richard Henderson wrote:
> Begin to rely on TCGOp.type to discriminate operations,
> rather than two different opcodes.  Convert mov first.
> Introduce TCG_OPF_INT in order to keep opcode dumps the same.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h            |  4 ++--
>   include/tcg/tcg.h                |  2 ++
>   tcg/optimize.c                   |  7 +++----
>   tcg/tcg-op.c                     |  4 ++--
>   tcg/tcg.c                        | 32 ++++++++++++++++++--------------
>   tcg/tci.c                        |  5 ++---
>   tcg/aarch64/tcg-target.c.inc     |  3 +--
>   tcg/arm/tcg-target.c.inc         |  2 +-
>   tcg/i386/tcg-target.c.inc        |  3 +--
>   tcg/loongarch64/tcg-target.c.inc |  3 +--
>   tcg/mips/tcg-target.c.inc        |  3 +--
>   tcg/ppc/tcg-target.c.inc         |  3 +--
>   tcg/riscv/tcg-target.c.inc       |  3 +--
>   tcg/s390x/tcg-target.c.inc       |  3 +--
>   tcg/sparc64/tcg-target.c.inc     |  3 +--
>   tcg/tci/tcg-target.c.inc         | 16 ++--------------
>   16 files changed, 40 insertions(+), 56 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



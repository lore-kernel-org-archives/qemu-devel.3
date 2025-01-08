Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC0DE77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVe4G-00029Y-Pv; Wed, 08 Jan 2025 16:58:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVe4C-00029C-AO
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:58:20 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVe47-0004qy-Sr
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:58:19 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so3748545e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736373493; x=1736978293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=udUJUuAdFr3vF+7ETFNGdPmqTXxPnpxTztgzmDCR61k=;
 b=Jhi5drNluGGSG4h5ZKTgcK0MqEZNvE2tphckpNDopd0Mbvy6BlvAYTOD48rBqeGQkc
 ObuAIq4EfLRRKugZuedX2hdrrHRsNKxbo49mYsasqwah24lvlF8jQ8lUucgMjeoJ+p5/
 2wWfWJnjcUTe9EAl6Qlk4mGrRgerGrCxQrHLPMqratlcJ1ffAXuJWefnquKssH9stS3/
 bQ0xm6Pt1EKb9pWPvw07bRkTeCmnfdsns5VNwBA9NwIXpOPF8Xanculkw4X72OOOQV0p
 JY4nWnsxYxXnaYiBdKRYzXEQceJUGrRtGlYxRqIzj+ya/qjGRozKAygFcmV4C11/1eyf
 YXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736373493; x=1736978293;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=udUJUuAdFr3vF+7ETFNGdPmqTXxPnpxTztgzmDCR61k=;
 b=O2vNxaWveGofSI8H9Cpg14h31VY20DUw+W2wrt8052NWp9KhBSH1nBPGi/QygODkhu
 HkNg/zyiuBIwom+zSUjAV6Bkb9bhXrk3S1KdpNgY5mJ0NKR9nvYcy8IUke5hP/W3OfDA
 eJ74I2/kF/DDCH0SsijOHN9xy1ecJmdozZLHq7p/Vzr8qlIrsy34pwtbDpKUFrKnyiDy
 LnJKNVXyEkh4dNstWTcEaYxXVZ6iqEMbkJqVvzG+x89EfMF3gi9Yu2ns7fzGqIiOD1km
 zQDPTHmOBJc0dSJ9uiEcP5MQmw/PrtyTP9X4lOv+LG6X2i/9rTN7m+dQqI3YZyQFBeg1
 vbxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWO4rKWx/e4lFkqBoGi+DGH1C8t/FXXTcSRnRsnfhbKsMFpqF+5uYbUpt+Qld0lwzr4f5j8+UL9y+3@nongnu.org
X-Gm-Message-State: AOJu0Yx5fNttsdOCW7mX4tD4mrRrHX2TPCz0pMTp6q1agHNtXNZoasJz
 aL43Xkm2YBdekAsxYPpGr1wnnGy6rMXZ2u6amSG5bX9vcbqH2BaZsN/lJE+Q1j8=
X-Gm-Gg: ASbGncvsL7GlDZc109N5DRAGWpPOZqKPbxFuWwBgqnaQp9nUQZ970eXefeAkdSfRLs8
 OHzgPnkAeVteKCAz4peojwcOb6CqHmkk/1LVC/T60ogIiGuaW+8z0QjwvHBSH3fSsGyZJ4CW/nu
 GJ5wZJJGPmJEgXBJun9LB1pAXw8RBKfNFH6IgDCeuHcxBRVEk39bvm3SxRjCXJ3AKFzwM/wmT9T
 M8yMpfWIZI71aK5hKGCmCV9llVq7JHbR1UdgI6/PDjX1V/Y/22I44rPNGiS3gdKxsWp4v9r+g24
 UvGajipZejHZtOCA93y0d2Ws
X-Google-Smtp-Source: AGHT+IH24kbg0iRPAH18bTv7CmhFPAcAODDrGPIu7Ld8aSpOSTE45D3EZdYS2KrMREexpyUkIeHlHQ==
X-Received: by 2002:a05:600c:138a:b0:434:a781:f5d5 with SMTP id
 5b1f17b1804b1-436e271bcb3mr43958295e9.30.1736373493030; 
 Wed, 08 Jan 2025 13:58:13 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e383623sm16654f8f.32.2025.01.08.13.58.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 13:58:12 -0800 (PST)
Message-ID: <8450ee49-4474-4ee7-9658-cd2ec2662aa7@linaro.org>
Date: Wed, 8 Jan 2025 22:58:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/81] tcg: Add TCG_OPF_NOT_PRESENT to opcodes without
 inputs or outputs
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-27-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> The br, mb, goto_tb and exit_tb opcodes do not have
> register operands, only constants, flags, or labels.
> Remove the special case in opcode_args_ct by including
> TCG_OPF_NOT_PRESENT in the flags for these opcodes.

Hmm this might answer my question about using 0 = TCG_TYPE_I32
for these.

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h | 8 ++++----
>   tcg/tcg.c             | 3 ---
>   2 files changed, 4 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



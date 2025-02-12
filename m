Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC1BC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 17:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiGtY-0002Bo-40; Wed, 12 Feb 2025 12:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiGtV-0002Ba-JL
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:51:29 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiGtT-0007gl-LT
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:51:29 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2fa7465baceso142486a91.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 09:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739382686; x=1739987486; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6s+ywLtucGd3omhtOd8r1GReli9Roqvp9b+gHZT468c=;
 b=ECxPFE3A2AoWoQQWat6yni6p5GwV7fy2fsMA/vHCQ9+epV9DfzUPWJXc9v0Bor2f66
 a+N4te6NXIEpzjegJDaPQYIEpyKdcDyCIL2y7S0wAs/YTnjZ9egMlTgkf/EJRfKPdpD+
 vdLrwxeuCISXMRAeJ3Uq5yZlRn04HtPbtn9mHi130jru4P5ULGIAiwJtQ0JuJDgIEUgF
 rxY/lS0MvsA7rFE921kwAIU0pgR5AJU9+RxyCqx4ue3uOjRirwSXggOUby+7f87JIGaW
 hCC45crnlemFrtdFn5+K/UqQKyrShob6+d7D2gQK0f7h93301kKKTOfHW/SmEDz2xoye
 uVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739382686; x=1739987486;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6s+ywLtucGd3omhtOd8r1GReli9Roqvp9b+gHZT468c=;
 b=h/eGUJqnEmMwEdMH66/Cdkn6a4s/2Dd4xio4Mh4opYbwpw4eNHG9RUTK8hUXNXDqh6
 JuA9P0yKbCSIK+E1l3xHva0xzYv2P9ed7UkT9jgX+suuALtquk0ExxjVMo06MK9MCNQr
 LBwRi2siCer8cBFBKS9jcRt1qskTfm/mA8XENbzxNr92LBZZJA5Z2LrfeOat2m1cL4Fa
 pZiwLqWHmsmWkFcOfygaJHT7f8o3yg2b8OB0XxveMD16Lq/Ntr1Q9n4cNhzILpg5jhAy
 KC29d4rIM049qeq1zOWK4i8H6DZb1TyMuKNRrzXbYhG3nuqdBLArxQ43DeWdO9TUE6eI
 Vpyg==
X-Gm-Message-State: AOJu0Yw1vc1c8MRQWeLwNog+LrWwZgRj81rqoBsh3IJ2CFGaU2Or1GwM
 is2COIkc0u+kEaTe08+nksIeAmgAShamtwQa764z8PD2U2Qlw+5p1Vumjkkn3G7SPNGtzxtQ9L5
 Z
X-Gm-Gg: ASbGnctzxt9H0Pnwo9xx+gmpnCbw6SfFZv6Nn5buGo4DPZpNoDIbMYPsBjENPmNZmm6
 YOjw8Nk+fC9lIAEHjIrDhBqL08kQ0gpQFfBXWZqB0vbDDNwF0Wog/iHGGnEEr+/XzqLuz+vQieo
 CWJW5ZaZjDxevgQdZIHJAIN4hYvMYZf0yEFyOigxuIBEcERUvln02EO86N35z4QPqRlQdMj6JCl
 3dPRaczFzMTEZnj3DCzy315jCfUubbw5gNSFzgigavL60TScTjQV2QYXMmYIfYpgdyL0r6Q7G1L
 jGFsoue4WP0HQsCYPy7q7hsKGNBxuUeCNTBf4GupVu7rhu7e8mxxEpE=
X-Google-Smtp-Source: AGHT+IGdReHd8PLBmX30bSUdRrlfXrnpAr8/lcA24//jcOAQgQdzik+BwCTUnYezSQqWnMfU5H5jiw==
X-Received: by 2002:a17:90b:4b88:b0:2f9:9e64:37b1 with SMTP id
 98e67ed59e1d1-2fc0f0a5778mr146400a91.28.1739382685866; 
 Wed, 12 Feb 2025 09:51:25 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98cfd19sm1785106a91.14.2025.02.12.09.51.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 09:51:25 -0800 (PST)
Message-ID: <958ad6b3-296f-40d4-baf5-25670d9188cc@linaro.org>
Date: Wed, 12 Feb 2025 09:51:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/mips: Mark Boston machine devices as little-endian
To: qemu-devel@nongnu.org
References: <20250212113938.38692-1-philmd@linaro.org>
 <20250212113938.38692-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250212113938.38692-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 2/12/25 03:39, Philippe Mathieu-Daudé wrote:
> The Boston machine is only built as little-endian.
> Therefore the DEVICE_NATIVE_ENDIAN definition expand to
> DEVICE_LITTLE_ENDIAN (besides, the DEVICE_BIG_ENDIAN case
> isn't tested). Simplify directly using DEVICE_LITTLE_ENDIAN.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/mips/boston.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


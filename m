Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4734C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 07:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7qci-00013j-7F; Thu, 24 Apr 2025 03:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qcg-00013P-Ax
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:03:50 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qcb-0001l5-Gq
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:03:50 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39ee651e419so307060f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 00:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745478224; x=1746083024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t5NSxJ8DqhCrc3V3rUITdYxuNPgDuXcfZtRDPfKBTpw=;
 b=aQ8ClFXiEE62v2TsgZLpSQEot1ixlJ6DoeZU3YwQyBQBaxEzIO5rQb6kkbJ1WY6YUs
 5fRATm30bhUKUkkAS/PAgB4ZqGk942mkQVNz0ymMvvMWm64oUIgiZ9h7XsvLH2OIhtJD
 V6Eyo8lyJqDy3cgtZcBx+vk+IMASq9tGw91lunH6lA96QovO+Tou7xyCJRDXC64PB/qN
 ypJMBmxFFHWey5jBmgnkJxNx2TK3oTUbnLtaWG19y4kB3M/q01LouK0JqpvbndyuPXZM
 DZDFTBCu6O+BeCSwzh8Pb04S4lX+w4w4FuXFdSeXDtdS+PNP8iRymvBQiCKy22Tb5ZdI
 293w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745478224; x=1746083024;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t5NSxJ8DqhCrc3V3rUITdYxuNPgDuXcfZtRDPfKBTpw=;
 b=uqSpQhV95XEAtHFhImUM9vmI0RhzDAw/HQbcnrdHegIo2g4Ll6HWktbQg6yWVFGolL
 /VC5B5R8gXcLFhSK0FTVGTiL92HLOqpNYlHWZk+LOo+eW8MGy3kKdhvKa/Ce8lGTD+Qt
 AoBzaLRBnsVjYlmXzm8JnBo6DYYGlR7iA0ALZ6lXlpR51gr+WkghbbUYBfd4utCGxOvG
 YCDmileS/Ez4+uNy+902zNzkeRpUsbTIDqE0E21d3rC5Dc0R3rjLWPYTCm2I10/tLDa9
 h4EfoZVs5yvkhNJpRNHfY7gpnwnj1Z++Ve/hAZ96QKs796pgENBPKde3xpSYpr8YQTm0
 +mbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0Ro7APUccBbYN8zwDovSzuAXqd++cSez/+PE2pzmNTCXGdfmnz1RHq8T/Uoh1iSSXFnxQk4nAXQVV@nongnu.org
X-Gm-Message-State: AOJu0Yzaq5BOywXMHiLnryk6V7U+DkwlkkWZJCse0M13KPFkRdKyDuhI
 +4MuMAmsr1renOyQS2eHihdjZVz4ioWPUqtBr+GZ0x0H8pPLefGoYcALc6GtqoM=
X-Gm-Gg: ASbGnct1Ib/r55VVkb8dCRqJy0OtUwgTLshcEd4KeNIVQKywavi6x0dnapAhFlWe4+f
 OYbtCWft3Q9EnttjlbDtCViTe6c/yUIwdNR0C3a1mbSxucoyvkCnPneM7IDcN0MBES33e7gSvYj
 3CFnirOxp7f0ssUv1OOcZhhpYb0xmnimAYPSNz/1aunOx2OzXFVp9xIE/Aj7Iuj4K+nDnieCkjT
 wNkj8t2NWjsLbxIkE4/aw5NYUrEbCBWYYyO0C4cN1YZzVy5G084nW233ddbxJUUKxvXkn/sH2jz
 zAbIqNoXb3mj9hawkBMNvczPPtVAFbzzd3CQoAcjnH89rAM0k1Io3cEpVLqdj+pMMjTtTrOVLXF
 KGejr1uqr+iRB/w==
X-Google-Smtp-Source: AGHT+IGBuOkvSf0xkhFGFarxACNti7pLXBBT5Iv2stjQMzA1FJl+Ok6g1mEswm0CFM1gJdoTvhvOSw==
X-Received: by 2002:a05:6000:2506:b0:39c:30f7:ac88 with SMTP id
 ffacd0b85a97d-3a06cf5f585mr1057914f8f.20.1745478223809; 
 Thu, 24 Apr 2025 00:03:43 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d4c5fc4sm1071029f8f.57.2025.04.24.00.03.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 00:03:43 -0700 (PDT)
Message-ID: <d85dd1d6-7e8c-472e-998c-df4d9651fe24@linaro.org>
Date: Thu, 24 Apr 2025 09:03:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] accel/tcg: Reduce scope of tb_phys_invalidate,
 tb_set_jmp_target
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-12-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424011918.599958-12-richard.henderson@linaro.org>
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

On 24/4/25 03:19, Richard Henderson wrote:
> Move the declarations of these functions out of exec/exec-all.h
> to accel/tcg/internal-common.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/internal-common.h | 3 +++
>   include/exec/exec-all.h     | 2 --
>   2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



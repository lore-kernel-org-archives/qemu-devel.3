Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD74CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 14:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPhTJ-0007Y3-Sh; Wed, 20 May 2026 10:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPhT8-0007Xd-Sa
 for qemu-devel@nongnu.org; Wed, 20 May 2026 10:00:25 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPhT7-0007XP-AJ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 10:00:18 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c7980c060cfso2172684a12.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 07:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779285615; x=1779890415; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pTp7mhpWrMatMp5v/+wbTKkwcetnLKgJL1QC2sVeYbs=;
 b=JJK61Qz5by2/aIh5qb4TY/OeMfGlUc+s3mmSRigC7WxAbEwWeGgX2O4tliZYsl3j8Y
 DRkTixGf7Vnc1c7/e6nLeDs4FtFW2ED5/06SBTAp/wVUAbbpycIuVNbdlNNxtNAPzmYc
 +IsBTayDrIEcZsFzFCvUpaNsTxEEFVYzFWNJ5qR/PU6If6s0JbyL15DUvCh6vQAolw0k
 ZojogdioLP1Bf9ilMxEsuqzDrb0A4yb1/ebhWfy/pcLwsUS6Pq8plJkKuOaTp+KwV7M9
 2bB+hnRML9RM+8DfaDsPvrOZOoiyALVWfD1G3j1OYxFbP2Cg4bujXeZ/vmGVUTyhe/so
 icMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779285615; x=1779890415;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pTp7mhpWrMatMp5v/+wbTKkwcetnLKgJL1QC2sVeYbs=;
 b=YNbOHtvbN7LKvWrBwpzV7Ula+9WyLOhMmM51zRMt9tGPUk7MnNePfqTndf4BLg43Ka
 lHXNw07TMJrYuxXBgSKOoD93/rExnK5UvBmGgI70krkImlqVEBE4EITrTQZ6r4TXDHet
 lqS21alkMCiDSKNTxNMMi/JO7m8nUQLuYTOaX3Yx0HhDEsQQjQgjDaEdPR39CXigq26P
 YqFJez6xdOifsHnOKu5BpuTmpiyZo/Y5Nw1Pp78qwjqnvJQs1ZabCd62NNaIAvnb9foq
 8G1Z0T3QzH2/L+fVMM+2rG2Oa2WpDtgV1rl12DsAydH0duQR9+zwrc+zyUgHdvgyLsEH
 3yTg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nU5VtWQJ8jh2KL4UfQNQXmy6eXpHehH3vmYJ0EXik6VYcUWe9INjESUhnHNPaHTMxmc2KfZ+g1uSa@nongnu.org
X-Gm-Message-State: AOJu0YxFYo1jDSmjliLlR4sd4AM393d6M1KY1OuNmAimUY77fxeEo5t2
 lQv+Lz+jbfeQUJ1UcBJte7IxnwV0iH5Xw0CdpDY1k2CaJq8GbkVMBQU6USouf+uHwWN/Ug/ONYm
 LTmbrCpk=
X-Gm-Gg: Acq92OGXI0kpZIee/of1wqVbaxB67lYqu+o/q+nqGTHgl5UqhwswIPqRunydh0rThCc
 51VoDb7u6LJU/yn/hMrcd5tq99V2z4eTN6vdBCAPJNdr8BPoSa17bJ821BYUo60Vmni7lPx1gTI
 cTlJLjAvOZFVjfrmr83WjKhW2lIBKlb6mYRqG2n6epoExLaq5YDo7wMiWYONbDlCD4Vf9eP8Mbb
 4XZNDmBRRplXYitwlKN2RCsh7mfUqon6N+kLGLQizNfomPE2g/Zm19wGogYXLrSU+QFUau33HvH
 a2TL7r/wXmxwC72ZAnmB7cXfY7RlmuB2vXrrcaV9wdCQA3zJajbqdJ5hlGNf/dW9BjhXlCL9pOK
 8qdsuQRxwd7w1iktkPP4UP0DUjKSIUR8K57bajXveed4bVC5Bl5ZThmsPZUnyNBWxc/giBNik5F
 uSAJWhQYxMT5UbYYVwHW6BvRsbtV/tABkjuz2T
X-Received: by 2002:a05:6a20:9153:b0:3a3:171f:6b23 with SMTP id
 adf61e73a8af0-3b22e14de52mr27751773637.0.1779285615111; 
 Wed, 20 May 2026 07:00:15 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82da93df0dsm13055080a12.19.2026.05.20.07.00.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 07:00:14 -0700 (PDT)
Message-ID: <d98ea90b-60cf-469f-bd2e-4e40ea78bd53@linaro.org>
Date: Wed, 20 May 2026 07:00:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/24] tests/tcg/mips: add Octeon instruction smoke
 test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260520101807.9971-1-philmd@linaro.org>
 <20260520101807.9971-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260520101807.9971-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/20/26 03:17, Philippe Mathieu-Daudé wrote:
> From: James Hilliard<james.hilliard1@gmail.com>
> 
> Add a mips64/mips64el linux-user TCG smoke test for representative
> Octeon instruction paths.
> 
> Run the test with -cpu Octeon68XX and share the source between the
> mips64 and mips64el target directories.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   MAINTAINERS                                   |  2 +-
>   tests/tcg/mips/user/isa/octeon/octeon-insns.c | 13 ++++++++++++
>   tests/tcg/mips64/Makefile.target              | 20 +++++++++++++++++++
>   tests/tcg/mips64el/Makefile.target            |  8 ++++++++
>   4 files changed, 42 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/mips/user/isa/octeon/octeon-insns.c
>   create mode 100644 tests/tcg/mips64/Makefile.target
>   create mode 100644 tests/tcg/mips64el/Makefile.target

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


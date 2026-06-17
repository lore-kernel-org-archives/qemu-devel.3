Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270E6CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrey-0002WN-3J; Wed, 17 Jun 2026 10:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZrew-0002WB-9Z
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:54:30 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZreu-0000gR-U5
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:54:30 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8452a597afcso497686b3a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781708067; x=1782312867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tzj+uvhvm5S11gxUya5STCv5ovZQovvIw+5jEMTmg80=;
 b=SItZRPkTN++56Hf/qwzJvWGkGsA2YEqwL0jA52a7bKKbwaKZ1dVaXRL6SQnAxqo2O5
 lW7eAIKIIlSUnMiCRF04rbgesOY7RtSlYxpDtWi+BKiAPhs4GHxNotwcTC9dYwKKJ3Fz
 Mj97bJAQu0dkMZTyd8lpEvhEOgoSvDFrvdt+5+UxqcDaZeYNF0+vZd8p1oTbvwIHbXHx
 g4X3Zx1wXSNvwhHXisUD08szWfTipgIjIl9lAveHpGzJlvE4pKPKHkM8bKaa5TIz1OBF
 Gy7epftf+0bzbXbrckfCGf+Gkqf48dDgDHL7ZBPQTmNDrCVMsMrTI5KI76rzjRur3x3q
 XYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781708067; x=1782312867;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tzj+uvhvm5S11gxUya5STCv5ovZQovvIw+5jEMTmg80=;
 b=NyoJCyVaYkypmOz36KgQIKIST6Dc+ZUjNE6TsMYZSIV34m1L0hgP5O2ZjQMJEGKLvx
 pPkd2WxDJiCsVX350tBY4GpLsr+Ahvgn8p2+01aXTBB27C1kug0l0hGX8l3F4rcHiqVo
 SRZPVMVaG7YRW3w/AcOkDcwQYCgs0pX6PKxeg2REuXCXi3Db7ui1kqhM68y1SFNzu46J
 eXn77d58RuQg3THFyIkYe29Ol67/K6SajDqcdF6hYy2+UVQAA5kQvBbuQ1DLsMcaDNsm
 sxkFgTUXmD2gyXUcSBinnNmgz0IbG5JyRP9d+tCaDcdjeTy1BQteKBc7w6zYS0DG0rPs
 hPAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fMaID4YgwFAfEu775WgkuO8Orwyp6KKZJu7vVfTN0bRqii+syVhL/m0b+7uLJkhWPBggOx8vjoYPc@nongnu.org
X-Gm-Message-State: AOJu0YyEepQ3DZlJpU9Rjeh8Zgh2vYsg6GYOUyKfq9LYxbT2+H5Sp8HC
 vZYN2lAd55NKBrS4MaIr/jsFQ903zkPEA/IrSyyG3AlihcxA6iNt83Mhmmd5/vR8nqfTrYXU6r+
 lqN69
X-Gm-Gg: AfdE7cmSW+WvKzZrO6n8AWPaKGhb3eIjIVF6nxNU2fG909HwA9RUl9U21bACsUYYbd3
 HnLOYlSDw3Zz76OtcQrO2USBtgezq3sVl65BJ80LQWgBJXRbIe0rnytgDvPJbgDV6PeEKtI2AUq
 0dUfAwNOd8DsMkBiPSyu2ARcYJn48yW017NLxn80PLQcRfHkh3LL+lt74eYgAhmSgAB71vIKuFO
 2JPVeJYL9WwkrjgGWZDmMJdTBY621hWT46OQBoRjXSQlBFwAzKSi9PHaFZkw4xlLZ86I5K8Macq
 qFZoy9pwRv0tR3LOF/YAKJdPv938P95HeVP+ELOKzO8MLEi2D5PeBsrdD+zBGBONORWyz5OdAYz
 lI2egGM6yFt+HKV+mtPZVr2uNYoQdlxhgLvFP2qgoEaDDhDGKuT7r8mPwDpmnCleAgO31WEVXcW
 w8QzEbYYMpZt7fQ9tjxvbfMtO9Ip2VqErnDDnan0W8JWlw+em7H5q9tzR2FQ==
X-Received: by 2002:a05:6a00:3d54:b0:843:468d:7804 with SMTP id
 d2e1a72fcca58-84524575795mr4721736b3a.34.1781708066533; 
 Wed, 17 Jun 2026 07:54:26 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434acffd04sm16160100b3a.26.2026.06.17.07.54.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 07:54:25 -0700 (PDT)
Message-ID: <7c693b7f-338b-4373-822f-d8734be6a689@linaro.org>
Date: Wed, 17 Jun 2026 07:54:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] accel/tcg: Move cpu_exec_step_atomic() out of
 'exec/cpu-common.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260616191716.12932-1-philmd@oss.qualcomm.com>
 <20260616191716.12932-6-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260616191716.12932-6-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 6/16/26 12:17, Philippe Mathieu-Daudé wrote:
> Move the TCG-specific cpu_exec_step_atomic() declaration out
> of the generic "exec/cpu-common.h" header, to the recently
> created "accel/tcg/cpu-loop.h" one.
> 
> Include "accel/tcg/cpu-loop.h" where appropriate.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/accel/tcg/cpu-loop.h    | 2 ++
>   include/exec/cpu-common.h       | 2 --
>   accel/tcg/tcg-accel-ops-mttcg.c | 1 +
>   accel/tcg/tcg-accel-ops-rr.c    | 1 +
>   4 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


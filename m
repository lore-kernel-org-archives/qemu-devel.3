Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBF2CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZref-0002T9-1J; Wed, 17 Jun 2026 10:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZreZ-0002RW-Vu
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:54:09 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZreY-0000Ys-JI
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:54:07 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c8629bed4e7so4274646a12.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781708045; x=1782312845; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=assrmf6I64OLdpCo0mknNIUEJuJMrnqmtIEbAtRzW9g=;
 b=BUEeIfk5KYjmnEizRa1H4Wmt/yw+YiEMK0hycTZ7UHHwYhRigybkxK2i3UFZvERJ79
 WrvCx7XPb0eq/0OnUqE/v/MZB8UIrdHRh6So5zkGjePc0RJjKATDRWClHSqT2NqnJXLO
 YL/hJkvDPN7DHOgYQcxEq2J4eNADJdQzXGi/L9otNGjdfq5GrEqTopBjb2hKaHwLTi1C
 W7NgroaDaw6N2qt/UlFicfHvCc3G3p+le5fpG/zRCrjt6cRbhW3iWs05VmPUIom3qIg9
 LJ6gUwNvSsNdKLL4YdhFh1/NRbv7iQc17GzJsKUGAP55JGPgpO5uTAxc4YXv9B/F9pTY
 fUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781708045; x=1782312845;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=assrmf6I64OLdpCo0mknNIUEJuJMrnqmtIEbAtRzW9g=;
 b=KrNkSwQFWVCHJ3E78QJb6j2Fisr0U+WD2J9hS8ZvBZxzqeK/L91VsTlrpaLSzAoKgV
 qf9S5ZTR1wnNvVMA7IyArvdn3ZPW0LY1dYwymYO3ywxamgWfflsqKW7+Q14XohLbsbjq
 XQdrOtjhRk8ZNXSfvFLuPWnQ2PLHs+KLqqOAd7M3xYmuv94MDu2V4CcprQjs9KWegX4L
 RAAJjk+rk9EHgsG5nT0AhbavAKPyXXtZ2pYRY1Gs1xOVYTzr4P42uozcC3P94Ev/GZuh
 ULXbErn02jVHiviXPybPYyfes357bWXnhIsucRtc1aitFYf4eUZF+ykTZqiwhRYcXVMJ
 QiKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+s1CKfSIQshR5inH/ugamymLobFO+Pw6U8C9Zcd/SFjZ79aQ8nxEOU4tDb1j4LhxbEI3AQsOjk7Tvp@nongnu.org
X-Gm-Message-State: AOJu0Ywh5Awqpq55VrrOF0TdBUpULpq5UtPvAC6zUQhYhrYMQ33TX8hy
 wpZBDGWDQNSU24DFlMB/1J9JCpNZ6XK9C/fBTbUMg/ABgEOiBHg1mshScAiW67uOnq0=
X-Gm-Gg: Acq92OEvZTXh8dujRea71/GzXY6cbKh/xrKTP/ZmVePWDjUNZ3HWDR14IIiN71KfNgw
 AcxIb4u5qYg3ulHEwG3IW3sUY70sj1PqxI+7osgFt2j0XEUuenNLFHG2u8pJws5Ytek90A67Fnl
 dffhZXzVDcLlICuslldbELploVNorV+vf/hxp6RRNUPFQtj9mQWAImyo9B6m8ubi0lh/071qnpi
 1UOIWwlOYaOWkndpwPbtXjoOWPmVuQ9cA/7qhrLTIkgLLD8udQs73Ch8PXs1gZgfUybONE/driz
 PCphgELHJ9BVJwZkoaxZ4uvlHOflimwgpy+MDCh1V2DacPQncrWlDqV88wEPSXgGSYm7COAnQkK
 jEJBlAbWJhhNRxh/P/tgIFT2d12P6jjbH9jz52edV6SXbED1/ETHOOQTCO28m8HauWmTdTQCY0I
 pGvCsL3teRneT5qXlxOVSEVyXUvJQ9XAwz6MF/WV8RLFPyC8yzc+arbCodIA==
X-Received: by 2002:a05:6a00:3284:b0:82f:5034:77a4 with SMTP id
 d2e1a72fcca58-8452452b1e2mr4332731b3a.21.1781708044993; 
 Wed, 17 Jun 2026 07:54:04 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434acca7ecsm16821188b3a.13.2026.06.17.07.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 07:54:04 -0700 (PDT)
Message-ID: <c444cb7a-910c-4526-831e-5dca54aa334c@linaro.org>
Date: Wed, 17 Jun 2026 07:54:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] accel/tcg: Move cpu_exec() out of
 'exec/cpu-common.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260616191716.12932-1-philmd@oss.qualcomm.com>
 <20260616191716.12932-5-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260616191716.12932-5-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
> In order to keep TCG-specific functions under a TCG
> API namespace, add the "accel/tcg/cpu-loop.h" header
> and move cpu_exec() declaration to it. Add a bit of
> documentation.
> 
> Include "accel/tcg/cpu-loop.h" where appropriate.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   bsd-user/freebsd/os-proc.h   |  1 +
>   include/accel/tcg/cpu-loop.h | 16 ++++++++++++++++
>   include/exec/cpu-common.h    |  3 ---
>   include/user/cpu_loop.h      |  2 +-
>   accel/tcg/cpu-exec.c         |  1 +
>   accel/tcg/tcg-accel-ops.c    |  1 +
>   bsd-user/main.c              |  1 +
>   7 files changed, 21 insertions(+), 4 deletions(-)
>   create mode 100644 include/accel/tcg/cpu-loop.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


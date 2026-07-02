Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DA7C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfLsR-00054d-4Z; Thu, 02 Jul 2026 14:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLsP-00054G-Co
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:11:05 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLsN-0003D9-Ud
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:11:05 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2c9f44ddf26so11811215ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783015862; x=1783620662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I30svW9C5scMzIdcKJvKp1XJLF/DCQMwzM6E31huKIs=;
 b=APs3yttmWYWCDtB77FHXTfXrhx2kP/n51SJqpRNsBU+0IKU0VZvTjrp4Zi8dywmHJc
 CBD7lQSQ5T8VpCzFnu7OSqOvcmT7Z3Bc2GtVAMoOMc47NHv7hIEAwuiWJ+zo7sObXbwt
 RrIKK4FhjTf+gB2tsyInrBwzE7iNcF6eEWMpCi0XZKsr5TKfZuhtvbcCc29tBTUQb/L9
 q+J+W1IUyX2rtajEgKVA+mHLx/fGe2tNBveW4LP9ZyWa+GI3oJN9ykRY4hjP5J1XACkF
 er4oQ9vwIJabjqe1p5Nk6Rc3F0XFJJRF2vnlk/eRkX/fHv0l45NQgJ6cyAQ//NSr9vnf
 k2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783015862; x=1783620662;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I30svW9C5scMzIdcKJvKp1XJLF/DCQMwzM6E31huKIs=;
 b=HvfDdgwUwrsEllxJxMoZKGf4yRME78PFrjx2eNrYPa2783VZmxWgIFiKU8sMUSSqQX
 QFMKnp0IVJRKG95XOi4pWcv5lO/G0hyqfcgeSC1mytkxh/w83sbMBaVETNv6nhBVDPC/
 LB8k9zvTaAPb8GrPsxxQdQIP/jeUTlb0YxncB6BOMCzEr8gQPp6HIizQdjKFMqq/xm5+
 On6Ro4njFvg19Fam7CePBMaNWBk2ioSmATdI9tgNf8EhByiJzRC9SuNLczhy66/glNdk
 Acihrdx0/V0Ppf/6zBKpDcuFFmPmbw0Fu+OiXkqpV5oxJi0MT6iDfsbrkiQAACMo6iYb
 UvrQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFbhWi+fZ6y7zdnlmG/obgy9si8iwnsYSdkpdhEA+7dOx+lukIMhhMjBxDDzmCw0Al7RBGeEcJqkqF@nongnu.org
X-Gm-Message-State: AOJu0YyAcvOUm8Zv5c4vSrEeln22DzzkW+lKNkcLBGS+nXmxHoeg8nn7
 6K7OsjHMsCn+RXZeemT1srE2jhCvyQWPzneS8zgEAS0GPOSw/ELVSQDVDJkDqiafcHo=
X-Gm-Gg: AfdE7cmOxnB/j31MfJF+XsnifFf8W8SXz9XC9pjPfIKVx5S5myIpAAY/N7uitthFfNG
 p7pO6qIaXvwmS0bk2g5MDHFSwS93EEkgs1Rzb0MaK81Kottb8PRxBQ4VSzS4tE0PgeL3WcetnDj
 Ho3YSBJMyrBE2EPv+U7SKq9OHKjutSsTTJJ2RSgcqcZ7hFtpT9MYJsvhqLG9mNwhmPmeV/HE/1K
 gxcJVYSEepr/HdOZRz1zdqQ1X3vYA4f4fA76owwye7fNQtxrzsQ1WKRAoIFz5HnD+Lwr2yUG4Bi
 3e6IUpHM9zJbAaG2YOgE6/9Gn3qIBLCKNeq2NMeaiE6hokb39dZNwowClQa55PiNLh9ANKMDbBF
 N9IztyOy5Brkxmg7D4oxzG2K3NhtuworiNe3WIxAI34OBqZEnlnk3D6wcYTCu1qLg754xayji4F
 bfY+z7W5H0Jwv23Eaknm0sPVP0MiG23tLkBVaFWfRn23t7kBaYy7KnYBZo1y7tuxgDH0Yn
X-Received: by 2002:a17:902:d2c2:b0:2c9:fa36:ab73 with SMTP id
 d9443c01a7336-2ca7e6f0b6emr74817745ad.8.1783015862122; 
 Thu, 02 Jul 2026 11:11:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca9a8dae33sm17326955ad.1.2026.07.02.11.11.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 11:11:01 -0700 (PDT)
Message-ID: <ff68141f-8d62-4671-a304-c4e0399cd78c@linaro.org>
Date: Thu, 2 Jul 2026 11:11:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/33] cpu: Introduce cpu_single_stepping() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-32-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-32-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> Access CPUState::@singlestep_enabled field with a helper.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   include/hw/core/cpu.h         | 11 +++++++++++
>   accel/kvm/kvm-all.c           |  2 +-
>   accel/tcg/cpu-exec-common.c   |  2 +-
>   accel/tcg/cpu-exec.c          |  8 ++++----
>   linux-user/riscv/cpu_loop.c   |  2 +-
>   linux-user/s390x/cpu_loop.c   |  2 +-
>   system/cpus.c                 |  2 +-
>   target/arm/hvf/hvf.c          |  8 ++++----
>   target/arm/kvm.c              |  2 +-
>   target/i386/kvm/kvm.c         |  2 +-
>   target/i386/whpx/whpx-all.c   |  6 +++---
>   target/loongarch/kvm/kvm.c    |  2 +-
>   target/microblaze/translate.c |  2 +-
>   target/ppc/kvm.c              |  2 +-
>   target/s390x/kvm/kvm.c        |  2 +-
>   15 files changed, 33 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


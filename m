Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35711C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Qmm-0005mC-MW; Wed, 23 Sep 2026 13:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Qmk-0005l0-9F
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:29:34 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Qmh-0003ND-RF
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:29:33 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-85469d249c6so851233b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790184570; x=1790789370; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ziEWh6Dg+Ckid0U+Ykz1atD92kwnbf3RzQPVPp1TOUA=;
 b=aUUpa2CVaNHWWAai3SrrwRGn4O/V2WLUD73coQk/EkhJIZS7B9SJeyrJBtSyxVfDjj
 Wh08EN2y2NYiT0VdV4YFPcGWZvT+n08f+MkkIFioBdEhrw+xHJA1Ns0qw8P+Vw9F4t1K
 VzZJViiHy4pQAmCjbSzFaGpd+X+hzX7T+d/l7yYms0OVMiY1MJvG/ryqq7y8s4NePQNo
 p9hqSeaPdP/U9TmK/lquj22OvValUygf6B3dMx6eD+JEXM55a/JGgdrbF+Emufe+XcbJ
 V1wbSZdRttIIs/w6c4yiR71uGdxdop9b40CyCtT6MQm2lDlRqZIt0t8P5joSKoaMDdPb
 xf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790184570; x=1790789370;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ziEWh6Dg+Ckid0U+Ykz1atD92kwnbf3RzQPVPp1TOUA=;
 b=NRWfaXtWYd5T0PBbbrG2z9SF12mQAADZO/zai38Gg8XGZ1HkAgh8Iwy/zdRG0v7xfB
 Hr8ftvoyRwrzH6GEFQe7lYeZw4oF2OhhlupmUWNooQ+mUE+p351lxoZ570pGppqteSYe
 eD/rYdW7+mZCHdmsdZhTE7PgzZ/bUtibBfgEcnk5X3Rta10bNYqr/SMwwNHp3cD2qeEL
 PQBn/WqSVtHFTbBmmeaTI0iM65VoCeh66gqcFdHY+/MRVVaWZcRUvakOoG9AO3Ik1rcj
 iM6ihoeo3Hk86vRFpCOH/Gqs8fgkw86gxBhqHTMY32tLJtuUej56neByF73BJAMt615p
 CHZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfo9QaHuDVadcegXPWCyh4OAuZV5v9UXhRvldshM2yC3e7Wc2VTb3M3WNPec4cwD8SwUZOyzasYL1N@nongnu.org
X-Gm-Message-State: AFuF++nyG+jMczI5oQ6F7HNCrQUFIsSkrWGDeHkXIJy4YbVLlvuVADhy
 xtUDCIU8YsDaXvpkNY1Je/+wQangIf333aqLM7tfSkhEdSEAbypPZMB6DOy6cZaF0WU=
X-Gm-Gg: AYBFou2hgmQ1aadTErq2pA4P9WWgLASyDLrNOvtN4Xw/nN5SUv5kikj/zTw2ATUosn5
 rZ27rtW+/Xz/tNfOHIrTARF9c9StU3n0CiuEnclaTAWwyjHU1RXFgjony4e83LmW76SXZ2+f3XJ
 mI2CmHJn7RrnDjDh6k1062+9iaf5qus1vlslPT/Ua3MEAsP/E0ZGbMQgUfu7GZzQd44oghflXIX
 qjP7BLYsmEQ7luGpbNzxqFE42cIfo//i3dR1Bil4rXt7aMSw0xjgGRZw/758zQFkgaP+TZ/GscD
 LjycrgXmU74IK4oXd9TQJTJI2zT8Ety1tRhCIq+rgd2c/Mhi6SxhvQu6yoY7gfeoi1Ewh7UR5/B
 ffT6P92Urq8sRPrZwNfIqW2jMfZKOPSJLbNFmb3iXiLZ4zKmi0pVeZrCKKnwztTQAHR69yLNlFC
 hn6WI7R8OfyLX67Q7uyEcNChW6kkis93nc24GlgF1maTP/G1Sgk815VhJM4+xq595it87w4e4XB
 MjsyzZngJcVQ5MmrIv21M62VG52/F/Jy870eWP9
X-Received: by 2002:a05:6a00:3c86:b0:871:2152:980e with SMTP id
 d2e1a72fcca58-87d1abb5128mr2637011b3a.23.1790184569673; 
 Wed, 23 Sep 2026 10:29:29 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1d4c483asm1695227b3a.21.2026.09.23.10.29.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 10:29:29 -0700 (PDT)
Message-ID: <70b6f5e2-44cc-4ab7-a279-ee8c5c51f43b@linaro.org>
Date: Wed, 23 Sep 2026 10:29:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/21] target/arm: Access halt state atomically
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260923171116.31276-1-philmd@oss.qualcomm.com>
 <20260923171116.31276-10-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260923171116.31276-10-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/23/26 10:11, Philippe Mathieu-Daudé wrote:
> arm_cpu_has_work() runs without the BQL held and can inspect
> halt_reason and event_register while other CPU contexts update
> them. The WFxT timer may also consume HALT_WFE asynchronously.
> 
> Use atomic accesses for the halt state, including the WFI/WFE
> and halt-exit stores. This keeps the halt/wakeup protocol
> race-free and matches the atomic state transitions used by the
> asynchronous wake-up paths.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
> v3: Dropped rth's R-b because of HELPER()s call also updated
> ---
>   target/arm/cpu.c           | 7 ++++---
>   target/arm/tcg/op_helper.c | 8 ++++----
>   2 files changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


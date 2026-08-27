Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E343C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzgL4-0002hr-6G; Thu, 27 Aug 2026 16:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzgL2-0002fs-De
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 16:04:40 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzgL0-0008Ih-UJ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 16:04:40 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-85339ed040aso354081b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 13:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787861077; x=1788465877; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CKQpWMw2aLuZz6hryE0T1XlvHPYk+aoHajkr6v6H19Q=;
 b=iflJTCjGan3cSdDnwSqLTQqThBcd+a0kKhlSFLady5r6+H2iajuSZ+7bEngSb341WG
 OD5RMk440nzPCwnfF6nCLXkJR1EVZ+1jJZvH6GG80qaEpn2FI2LBpvJwD5LsPV2X15dO
 bmkMgCrMG9r93GTjIYsK7YXSmvrMt07M60CZvKvo53OTtW86giSmoSocp6YmyBCKufSk
 sNhKaLSg18hPzzgM+AkBQI2h6ix7m0YAwJPi/r57fccHUzGIOhdEaEaSGUy+pWqYcEN4
 LBrCGD7tlURnabgWaHxuMpJ8RCcAO9/mXjAKtU2iT9HxQ41xQV+HrqVlif5gcFr/VnOb
 7Z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787861077; x=1788465877;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CKQpWMw2aLuZz6hryE0T1XlvHPYk+aoHajkr6v6H19Q=;
 b=rlLRzFTxnLVicUHQKU17U0Odi7VWRDd3pryuzJgHSgh4U/mtUnq9r1js9KSGhO3+/b
 kwmVERjTo46KHP8mwOip8FT7RJgG/KTu54P8SBqqL2SzRvN5ATuwTHZUySYZYw81VWFW
 Rp2m7T5xSaOaBTNmH6to+i/4DDFc962ds6Km4+HTcix/Cm6lggF52SRUkREe90HkLVBn
 jyPGKK6kQp/uhvYsZms42+tIzGaS9wgwOaayZLGrPh2hDluu8OIYIK5rAd0JBmOTMa86
 8yqRbxrv0EgPzjNOO8b1AI9uK3WzKLWMu8J53I3dlVyw93xMQwdcVspCCHrILLuUPlce
 iP/g==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro7l8ifBWKro67TbduZCSi/m6v+53kP4GTboJZZzx/NeDU8Rx/QDf/Y1oxlkZo171G/ZvZvarrS98m0@nongnu.org
X-Gm-Message-State: AFuF++kyaBNATuOH1HpuD5r22K5c5iXul+pfTDuOWoyWaN3b81OFJZIB
 G8lAbyTFCmafG7JBiTlapalM80eenNNRlORL4fvBgmbkT/PYxMRzfvjktvidYSaUTY8=
X-Gm-Gg: AR+sD11OkwsN3be2yTFl/kdvQ7UsHU2E8kp8vItMKZkMsLYkg8hf1LgwYSk9Td7d9Bk
 xybUvZ83yrPCc6Z5AhZH5wja1qp0v4uvUjPj+KnDySHD3AD3HKtvXK4EXgZZrlqP9HX5uPnHWTs
 Ue9Vi+OJvTYZjzVEx+C32WT4u6SdLxJ8w1jtc5+WlzB9ad/dqjJ3eyvOCxrxOSQZABnUhS+dNzP
 kz75nh/Ya8GskyDqDfBeogBC7c4n2XrPUZkfppDM4+zPiGQ3hXuvyJkjhU4qBlTAqxkuRxXGUcY
 LtNY8xcJwoNqzw5lEZuzRQvM0fcumyT4eaeN4VhJNBsMs1U53Ij4udH5K3Y55nWKBWDnAFntM5g
 mnNoSKRPLMWz39HTgCi+dV0Nk9SYM2NGNIsHjPKFmNKFuVE8VZOPospcTvxhYwZn+wG1gkrOA/t
 Nww3cg16qmMtCXCp7c+neqYY6SeHIiUIM+0yOagZ39f2SNC8y0ad1POYDhLZKjOD3HUeZuBO5sZ
 Yjeb77huEvGXkFdCqdgmZorAsOLxeG4phqMHN0=
X-Received: by 2002:a05:6a00:4109:b0:847:7f3c:b5f5 with SMTP id
 d2e1a72fcca58-8562a6e1024mr3088047b3a.11.1787861077238; 
 Thu, 27 Aug 2026 13:04:37 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535afb2caesm2387274b3a.26.2026.08.27.13.04.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 13:04:36 -0700 (PDT)
Message-ID: <d13ef96a-fc1f-4df4-bada-de2f04d55ea7@linaro.org>
Date: Thu, 27 Aug 2026 13:04:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] qom-qdev queue 20260827
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org
References: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 8/27/26 07:33, Mark Cave-Ayland wrote:
> The following changes since commit bbc8fb89fa3478a6f47c0475d2e4952e69a64f45:
> 
>    Merge tag 'pull-tcg-20260826' ofhttps://gitlab.com/rth7680/qemu into staging (2026-08-26 21:33:14 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/mcayland-ntx/qemu.git tags/classprop-hw-acpi-upstream-20260827
> 
> for you to fetch changes up to 3435f9eed289b362097429d031c75bdaa847446b:
> 
>    hw/acpi/piix4.c: convert ACPI_PM_PROP_PM_IO_BASE to a class prop (2026-08-27 15:22:11 +0100)
> 
> ----------------------------------------------------------------
> qom-qdev queue
> - Conversion of object properties to class properties (hw/acpi)

Applied, thanks.

r~


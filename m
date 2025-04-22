Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE864C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 07:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u77qN-0004N7-G5; Tue, 22 Apr 2025 03:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77qK-0004Jx-DN
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:14:56 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77qH-0002mV-4w
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:14:55 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso2878917f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 00:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745306091; x=1745910891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oTlziAf8UWda67nFyaJv/S82eWUs5po12clwDYv7Qss=;
 b=MhLPBG8HvIYPERzZhYddlRVRS7LmHGdGiTc4eQPv7RpDH7HkhX/DylvUDdIViB01md
 UQVkaQ0nqkPQHIgTmklmjbfvM90BUJcS9xo/b78MDqwzZ4WnGb+D8BJIy1yxIb7cqQLl
 fvjaFz8WntdvDJpE5GtDmNMCigSaeP+JzQ5D9EP+jjr44V7aE1kVR+EhOhCtynGTcQBE
 fk3jSjGEHj2ed0YgimKcmZ0/TGZFI9cuSLOwg/o1Ub5R0Z0sdS9dnH0sI0JGti2b9+pm
 WA3zTJvmRLDK05OJ2pkLf5PPm22kdVggHu0XrvdkJZ3b9W8zdR1+0lGC3HfVboGdL5YE
 MnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745306091; x=1745910891;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oTlziAf8UWda67nFyaJv/S82eWUs5po12clwDYv7Qss=;
 b=p1Tp6DBgkme4wmjCjF8nqrxU04VyuYJsQfvehKkJHSSG722j7KqHTik8JtPgcfmPSO
 TSOQ5d0jR9lyygDAer3sVUOhpnjthjizfijDhUDbEpCdmpRFzgxadjFK0baYQNamQZB+
 l/+hXXkfPxFOOILOwXgdki8/2vDLAVxe1n0UVp7bdna07Qr5LaZej03bq55NdLSWgGSp
 la41l8bunFUh+ovrtch6RMXukGsCgRxQGWd5Vq1RKxQgM4MZq1TJrCqyPuo4hIw5EsAa
 pgxUl6DgTYCvbBkWAeaI6cwKx60Gir5dPB2PTA2FFiXRKuHkPhmGyvzghUHztk881Wb6
 r+uw==
X-Gm-Message-State: AOJu0YxKSa7tHZK6hQH15++XdWO6cN1QOkEPfiCeaeL8z2oFRLsvTFKa
 QTiQV2BXIiSSeT4FU05tvo/DO7PUYevoZfu2nyWMKhuzebqf0GaGjh1JVQN2Wjo=
X-Gm-Gg: ASbGncuMYkkRlp7LmpWRAjDfzbOYLikfOZnAr6yl8VkT2IwVwIjyjphvvWcJZ0HA76Q
 LvHhUtU9Lhtg0Gag2XnaTzhEnaiPt6RWrp73cpVI1eAp3knplOBd2wLkRM1W0HFbtasw3fdYPyc
 ZCJh5rwboh8iYpmoAQaSt5lCJjxL2euIDMVlJxZWjeu0xETMEVoBI67s+6H1sI0/hqmtA2/Id6i
 mhd1A573wiT6gTR4fJYQ0QjDtp1TFkM3yPIisSIb3+PZA3tNZqBWsMBfX7tADLbfjpJhiZ+FixZ
 QKPzl8xyxCS+5nxkDsF8jTL+P1pc/aTMONzK4q1UAw5pj01nKrw4tKFVCQP0V0ErI7tEFsksbYc
 HkQ6sdWO3
X-Google-Smtp-Source: AGHT+IHY7dOoyY0QArJKyoUQWTJxESnXHXaHeRHfN9quwRUA3nq9hTECOuNYy7KmKH2nJWonUdkC5Q==
X-Received: by 2002:a5d:59ab:0:b0:391:2ab1:d4c2 with SMTP id
 ffacd0b85a97d-39efbacdb68mr10057395f8f.37.1745306090963; 
 Tue, 22 Apr 2025 00:14:50 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4a4f2dsm14319951f8f.95.2025.04.22.00.14.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 00:14:50 -0700 (PDT)
Message-ID: <0deebb7e-6962-4d94-b095-53a00c9398e9@linaro.org>
Date: Tue, 22 Apr 2025 09:14:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] target/loongarch: Add static definition with
 function loongarch_tlb_search()
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250422025742.2693096-1-maobibo@loongson.cn>
 <20250422025742.2693096-9-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422025742.2693096-9-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 22/4/25 04:57, Bibo Mao wrote:
> Function loongarch_tlb_search() is only referenced in file tcg/tlb_helper.c,
> define this function with static attribution.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/internals.h      | 2 --
>   target/loongarch/tcg/tlb_helper.c | 4 ++--
>   2 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



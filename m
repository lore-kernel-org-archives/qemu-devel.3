Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FADDC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 07:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUj12-0008JL-Tz; Tue, 30 Jan 2024 02:58:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUj11-0008JC-Hr
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:58:43 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUj10-0006y6-3z
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:58:43 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2906b859560so1630060a91.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 23:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706601520; x=1707206320; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LlleQCuHubA71GerGApAHa2R6HnCjIBOmeejQJNwqiI=;
 b=OKTE5MWrj0sVrmo1gma6y3XvIb4EVzDI6+pt7G/Hq/9p9uEtM/dC1NkQUuBqt7oS5D
 bU+avSvkguPmp+UQGCPb5BjAbWOtFiSQn73sS4ZuZFsf6ZO3K+TDApFWdTIRrsDm+MFl
 I846DxmV8Uaf6c31q+e8ycrNfwi1DruDnRyOugOVLaoB/9uV75/s1t7lcRxK/TuD+/Ip
 Z14mwwmCHCj8AeqCXXW1fL7K9juIiDvmURK7olPCUoUpoCIM6iwSBs6fkSl9iGhBNuFr
 VUIfuvuDSi/pG4t2yo4Ma5WQJXhuJi2mbs+TJp2bTS2HxYpBEWYCgjfUKwNGGgPG3b6Y
 ys2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706601520; x=1707206320;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LlleQCuHubA71GerGApAHa2R6HnCjIBOmeejQJNwqiI=;
 b=LiYvr/9wlN9FJ+PZFHH6eYAchbMA5AukszkMvCSUEEcR5wNImAaaC+wdTxY5zq9I3M
 6TinB4GrZEW5mX+ACVpw4kuc4FuGMM52Pz8sjom3hPymtRM4EKXQMMD9q/F6Dw9dBvIS
 rp6/fOUs8igICngYW21YYv0hqG4vXJ6aB2WLyUKs0ExBaLPH1LTIEFon6eMra/opCzcH
 RsBNA1puDt8S4sx+pDaN6P1cp12JmfmIOsP2NlnQflUvGYoSZjGHdbsguVOXMc8INo2o
 2c+EpA5FY9yd9XzL/J0wmdHMH3Tx4HM7t5wtq7+tySt8EnD6xAQxiNbpVireZTVV42wj
 Ilwg==
X-Gm-Message-State: AOJu0YxIifP72ZzdX2gVqAS1erVJvUTcEtD9h8iydkXDKa0ZPIumbzVU
 +2agwOOKx6+3dZV+1FMeIR6FVkEFHjfMF5TchT350MBb4f+6pQZUPrqwsIxaguo=
X-Google-Smtp-Source: AGHT+IGQN99nzDxYY/ZUNICbfRh4PoO3XVTlbGgN2tMtSZimR80O3eZSsC7jeu1X3dJwTWsxC44WZA==
X-Received: by 2002:a17:90a:5d15:b0:292:b026:6aaa with SMTP id
 s21-20020a17090a5d1500b00292b0266aaamr3377141pji.49.1706601519731; 
 Mon, 29 Jan 2024 23:58:39 -0800 (PST)
Received: from [192.168.0.103] ([103.210.27.218])
 by smtp.gmail.com with ESMTPSA id
 nb5-20020a17090b35c500b0029464b5fcdbsm7286693pjb.42.2024.01.29.23.58.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 23:58:39 -0800 (PST)
Message-ID: <654edbb0-b3f8-4b3b-969b-50c45577b1cf@linaro.org>
Date: Tue, 30 Jan 2024 17:58:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/29] hw/core: Declare CPUArchId::cpu as CPUState
 instead of Object
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240129164514.73104-1-philmd@linaro.org>
 <20240129164514.73104-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240129164514.73104-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/30/24 02:44, Philippe Mathieu-Daudé wrote:
> Do not accept any Object for CPUArchId::cpu field,
> restrict it to CPUState type.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/boards.h        | 2 +-
>   hw/core/machine.c          | 4 ++--
>   hw/i386/x86.c              | 2 +-
>   hw/loongarch/virt.c        | 2 +-
>   hw/ppc/spapr.c             | 5 ++---
>   hw/s390x/s390-virtio-ccw.c | 2 +-
>   6 files changed, 8 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


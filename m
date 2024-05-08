Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C5CC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 16:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4kD3-0001iW-4m; Wed, 08 May 2024 12:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4kD1-0001hx-AM
 for qemu-devel@nongnu.org; Wed, 08 May 2024 12:31:59 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4kCz-0001CE-Nn
 for qemu-devel@nongnu.org; Wed, 08 May 2024 12:31:59 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-34d7a32bdd3so2442604f8f.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 09:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715185915; x=1715790715; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RfjJTTalGHGby/cv1XPoExX0UBtHg1YNDDiKyuGSFDI=;
 b=t6GhRjb8saPNCrZKu7oth/vNtq6QA17wA0IlYcfVQeAjFlf2aKpEZlZsriDNKGGfDd
 HMy1tgs2xelPgusSHwwRAp5jqDRnIYByN5W+sS1lIzICH8trJQSJqmib87OyZT/ttsUn
 f9djGKZRXj/jT/iBLYx063iRGn41r+g3V4vBUIwEdCxs+k+3M7KENi48KcFo0F/i4woX
 +QVQFZhYhW0sKwxCqEmpZ698AdtFrIYqjoMzVMmKbRvqmxyUiydG1gmBfArmfakakpeF
 V0V9FlBm1wMPLiyLWbNp26goTDAGnXTcTI9SWcQsoBSZXShc5bFIo+eFYeF4FxPiqB6C
 LHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715185915; x=1715790715;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RfjJTTalGHGby/cv1XPoExX0UBtHg1YNDDiKyuGSFDI=;
 b=F7LgPpgCNSijPG3zu0guuObDKpbdS27vtcQjdpoPR+6eVCB0mZdJljeWaXBe6t+xe2
 P0QUqmQTJsvPqJryGJqm14JT71HQBBJsBCwzLTKdH6FeHshXQ3Dp56UCTDv7/4cB5kVv
 lqzpRtyz9k96/+EaNWKBd7/lcuTj9YyyIQ5e5+1XvE0r+HJJz+q+lcQen1a6iYH+qa2R
 5QeZcP0bUwMEbtZClYlhwNudtCH64zNGhOADCdRC00X/ozZsZdUWatOJ7sjNujl5Mbxd
 Sgsvc0QWGt143JzddwjjYThZspOCAKZQ5pdpOaPYu+9Bqz839ZfjBOMHICnBP3DfBciu
 EUOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH3Yh/Cp1+WW65TBYqAKg2uoEgPqqnt8Ssaqyx9GwrgKBDmaLL53OtA62zB7RJiDr6WXAoFxsqpfgRy4DZtCrwXlSPy/c=
X-Gm-Message-State: AOJu0YzBcOpmfKU9wupzFyCJlDyqnOxn3Yx9y7+YvwWbRWqluLKAtbI1
 o9D0LRd9AJ2DQaklg1R9DgzjZB+DTt+Tm2j7j/8zSssHfr59l8lxgZ22orek4lo=
X-Google-Smtp-Source: AGHT+IEBCYOXkazVKnylgXBBSU+OOTWPa/BdNBm3t/dnt957sDIcW/ZoV9WxhC5X+JGelirCXOcXvg==
X-Received: by 2002:a5d:4585:0:b0:34d:2466:df51 with SMTP id
 ffacd0b85a97d-34fca7185b6mr2138842f8f.48.1715185915402; 
 Wed, 08 May 2024 09:31:55 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 j7-20020a5d5647000000b0034e52844757sm14264649wrw.95.2024.05.08.09.31.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 09:31:54 -0700 (PDT)
Message-ID: <a197c403-d50a-4830-9dc1-9c661fdbd7fa@linaro.org>
Date: Wed, 8 May 2024 18:31:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/33] target/s390x: Disassemble EXECUTEd instructions
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424233131.988727-1-richard.henderson@linaro.org>
 <20240424233131.988727-23-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424233131.988727-23-richard.henderson@linaro.org>
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

On 25/4/24 01:31, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>




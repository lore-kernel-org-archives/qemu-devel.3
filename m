Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BE4D12663
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 18:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQVPw-0003o9-R9; Tue, 02 Dec 2025 13:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQVPs-0003l7-2c
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 13:48:00 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQVPq-0002LZ-GQ
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 13:47:59 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42e2e47be25so1758261f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 10:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764701277; x=1765306077; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QxLzfyyYPEu0p7GpXvd8gDn2MEeXIYF4E6DBaHHAXyQ=;
 b=mriUuHWgpfoQxYQMJqTaRaTAVAiHu8T1UJkqOmVfEhJNHjNUEj3YEv2mKaZQ8w8uHJ
 DL5vUvLBfFvcg/OfE2WAXcxC32I2drd/331lZk4k+bpNab4DKIiEf/au1+B5jHvel4/i
 aEpP/PwBwclIJrGjFJtjMKyUu5NVB5wsFxarafGOhmuyQAy8kCSGp+iukH1vh5dP40LH
 L6gWb6B8lYM+grcBAJ0JztaUJA+bT2eL+wsIHiTBH5sGulvcj6UHJSBwyU7Nw9sCqBig
 xP//6+DwGXtpP+ClCU89JQTgVe1mIU6Mr5syKgzFkrI2oZLGp1od7TG5VnJw3E2lTsVh
 pR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764701277; x=1765306077;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QxLzfyyYPEu0p7GpXvd8gDn2MEeXIYF4E6DBaHHAXyQ=;
 b=nGvrr0NRSSldEBbPjwMvKuPFCaAmE2oA4/dWzPv+BYJBZY8bEt/LX9d15fDfuwX9Gf
 d0HgzUoif7q8IMEqrzVg6CmCfBLUxzAjXZchAUWKglWxKqDuKjjsTuH8iEO6JVCicUC7
 cNLsORP6LLGcmcjTyiww1ojt+ZAaAiWLLjurQ7sEthsMk3+L8EMj5xulLpKZ4mE6dkAn
 9xJArnBHKgtsjCyHfBP0o/8HkHsdvVZchCtjpD0fpPrhr8nPnyAvvnYzMjsTKunLGhPy
 MXpCC7kMj9VNTWgixRSkFM/VjJiJTO/4MnAkK21tgJQlnZvAEo68zg3uFV3s7pPhEFPb
 EVEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXURUtnjGNFKmVadb0wUtiL1k1qixRruKfDU3NoUhRiWFJH2/JDn3vx7HKbLfWsyp24z44XA5/qSO49@nongnu.org
X-Gm-Message-State: AOJu0Yw2/HwTm9Fk1XcKaCDtpc/AGq04o5YiaXT2+XS7c+iJ97M+UKsW
 Fvoo6brKbFJKfzMdUadWHs3gMMG+alNC3eNfI84vcS0daGW/gc5uRvy7/MI4kge1uxs=
X-Gm-Gg: ASbGncuty5zRVErkv31ehIE+Mob85TILQKMeWnuBLCUIp/QlBGU/08YHIBwo6KAZZdw
 ZHCJzBDSF1uASDqcJs2jcIeGHkJ01mjm67lpeihTvG86hN3W6NDAyhbt3jp/zoprvJxSwZXp3Yi
 nv/CNe7mC+Ru8quyTDasts6M4ROA0Pn6RbVtrYt9BF2I4e9QvLerh/5FLM+3AnNzO5O7Lgv1Q4g
 7OWRWypSbach1PgOE6Ul9DrQrZpAVJzftBfrGdg2ve6MC+H/2LdDinsjb6pgHG4+8+sT1IVuLtL
 ZC+Z+TK1+w2gbEonynvpKp12BnplV7ydA7ilOzAenKkrR2vWMj1uF+3wN0iG7T6oZsrNfFYmR+e
 4H1wPmo45dN/+fnvJFf3Kx1ETKKoCig+iSJFF7rplDno/fqF45XLs3mNpghCfTDHu1Ji+Mj/kFp
 R7emO565r/9GkmZ02hkBQ/KkNF7WWKX0Jz58Q8borlUTqzoPuNwe74LQ==
X-Google-Smtp-Source: AGHT+IGVW6Vj6/8f+fTkY/cm8abAJIlbKZHk8Dd7WQ3yg9AaEN0gAZZTo+KfFZNmq32R3thO6XJbng==
X-Received: by 2002:a5d:5d85:0:b0:429:c851:69ab with SMTP id
 ffacd0b85a97d-42e0f35a730mr32361021f8f.55.1764701276941; 
 Tue, 02 Dec 2025 10:47:56 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5c3c8csm41374099f8f.2.2025.12.02.10.47.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 10:47:56 -0800 (PST)
Message-ID: <f483436e-b397-44e2-908e-43b850a895a1@linaro.org>
Date: Tue, 2 Dec 2025 19:47:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tcg/tci: Introduce INDEX_op_tci_qemu_{ld,st}_rrr
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org
References: <20251202011228.503007-1-richard.henderson@linaro.org>
 <20251202011228.503007-2-richard.henderson@linaro.org>
 <b2524f61-ba8e-4d3f-8852-9a97d3c05d27@linaro.org>
In-Reply-To: <b2524f61-ba8e-4d3f-8852-9a97d3c05d27@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 2/12/25 19:06, Philippe Mathieu-Daudé wrote:
> On 2/12/25 02:12, Richard Henderson wrote:
>> Since d182123974c4, the number of bits in a MemOpIdx
>> tops out at 17.  This fixes an assert in tcg_out_op_rrm.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/tci.c                    | 19 +++++++++++++++++++
>>   tcg/tci/tcg-target-opc.h.inc |  2 ++
>>   tcg/tci/tcg-target.c.inc     | 14 ++++++++++++--
>>   3 files changed, 33 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>



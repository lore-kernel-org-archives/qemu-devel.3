Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CE8CCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 17:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8MJU-0000jK-Kl; Mon, 13 Oct 2025 13:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8MJQ-0000iA-K7
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 13:26:21 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8MJM-0004rt-Vp
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 13:26:20 -0400
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-46e34bd8eb2so45289645e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 10:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760376375; x=1760981175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UpjLcCiNhxrbyzdwKLuAzLzhsQqt38WZSGQD7SsU9dc=;
 b=sS33s+sliQFjlepjI5ijYvvEJTCzRQYa6PPMSJN1p1X4xyb0HpDtDNABUpAsn530PX
 ovh97cYHyLhaZywidUsQm/kbzaRFwF9rZzgs0ryyqGF4pebpjD1Zjp1CXgq942ZF6Al5
 4Hqkp6fT2hRKMjDCTQVQCH41UN9JzWmduX4IGLxSewoFNxl59BOx/FeJ23EQabDMNl4Z
 c0pO9aajDoZr30gqdWHh9Nr8JhuxDTegRqlcRjOJicmKtbq8m8f5/SR9tW315jj+KOYa
 n2DfQrN+dyUV33ahVPfnsNTrWM2uUXJEADsnWNj8TLFQZ2JrRyDWY98d1wfb8V6jEewF
 LPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760376375; x=1760981175;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UpjLcCiNhxrbyzdwKLuAzLzhsQqt38WZSGQD7SsU9dc=;
 b=UuNwJLtXAHQae83vnp8EvxmvJ7+neCipDHM9LP4BeI0btxi5nPS403tstQK82jmoRx
 4InIe1tVTzJdWhyKQmQD788wM3HKYfjCxwRMLmrBBlajDxD3XrLAV7fwVaREjxFWcst7
 DhxtSiJlDkb/s3OtursqEco9v1Ku93vcfdFQpQhd+ACkfYpqYiF2KnYcP+rASLMp2Qlb
 jehm9VPGyYuby0HlnrAbErMWZ7EcQuYOgW26pFRwFmA+NjSAGB392U0f6KwDHBGO6ADD
 OnAP06qnyuJSn1+ywdf79f9PAt3aAaaxFxebAaAtHg0xHAwlPPb87X3Gx2X9LbzFOcW4
 yqvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd5/5wYJ0T15TuZFA1Yd9iI5cG6GR9W05cETIWN3q0F3EavFyAVHWWM7YsWy68uIOF6f6wrQaFa42q@nongnu.org
X-Gm-Message-State: AOJu0Yz6A8GzbhIzwzGHvv9zK9shj3fvTdRiHzMSgp2ZxKE9fe1YKdl0
 wOY6coLmgj1+pORSrBC8OuMpRU3iumor3+9vjV22GRheTAzDj40azp7aoc12SdrnPVs=
X-Gm-Gg: ASbGncvSSdA4zR7wz5x4xafAnLLO6zXEmgrFiYU5/vM7wkO5YD7oCEOjFiAghuR4lgx
 IV0rPChF2ZymcDuSbync8BKrNsevRLMrDYN/zrHqPbVtH6SCF+SWqB3V2MBN+L58OqlmApZJogV
 LV5BlujnnH7R0VPQ2KKxd4vRm0f5pb3EpAsHgkCTJKsHO/eETLEbpxFckIB4E7Tn/g3t4OzKWId
 eJsqmL9JV7Lkk3QZLUZlm26ynL1R0tzTWGOmCRi26vr+JtkIlH6EmjdLz/zKvju0i1WRW1yjVzv
 iNUdZ5YNsMe33sYBbqyzrs8n/fcP/+dcj9CClLMvfGOxYYf2q3zyBS3UwoKd6sWf/8wte/tlh7+
 leMOEbhejHl+21N0QPK21fHjm4GWbMyzogPbfG0nus/hGMSk6BsihEXQxhsYl2Q0NjbT9ZdYcTj
 6PJk4DlLd3XztWAp9On8+8nSg=
X-Google-Smtp-Source: AGHT+IF3j/Ua3au/GFUHEi7nHUj94RB3OnJ+CXZL84W0XlsbVeW9jVUJuLOHHR7/du7sCX+xR7U3SA==
X-Received: by 2002:a05:600c:5492:b0:46e:477a:16cc with SMTP id
 5b1f17b1804b1-46fa9af84ecmr149440365e9.24.1760376374773; 
 Mon, 13 Oct 2025 10:26:14 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb4989601sm192455665e9.9.2025.10.13.10.26.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 10:26:14 -0700 (PDT)
Message-ID: <e06b47fa-361b-4e6c-9477-61b556808670@linaro.org>
Date: Mon, 13 Oct 2025 19:26:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Fix reads of CNTFRQ_EL0 in linux-user mode
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20251013161040.216819-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251013161040.216819-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 13/10/25 18:10, Peter Maydell wrote:
> In commit bd8e9ddf6f6 ("target/arm: Refactor default generic timer
> frequency handling") we changed how we initialized the generic timer
> frequency as reported in the CNTFRQ_EL0 register.  As part of that,
> we chanegd the linux-user version of the CNTFRQ_EL0 sysreg from

"changed"

> having a constant value set at compile time through the .resetvalue
> field to having a reset value which we compute in a .resetfn.
> 
> This accidentally broke the reading of CNTFRQ_EL0 in linux-user mode,
> because the cpreg is marked as ARM_CP_CONST, which means we translate
> it as a read of the compile-time constant value in the .resetvalue
> field.  This is now zero, so userspace sees a 0 frequency value.
> 
> Fix the bug by dropping the ARM_CP_CONST marking.  This will cause us
> to translate the read as a load of the value from the CPU state
> struct cp15.c14_cntfrq field, which is where the real frequency value
> now lives.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3159
> Fixes: bd8e9ddf6f6 ("target/arm: Refactor default generic timer frequency handling")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



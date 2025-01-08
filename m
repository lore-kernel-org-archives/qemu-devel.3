Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39B0E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 22:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVeC8-0000QQ-T7; Wed, 08 Jan 2025 17:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVeC4-0000OL-H5
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:06:30 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVeC2-0006nN-FJ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:06:28 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-386329da1d9so144882f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 14:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736373985; x=1736978785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ueNZ6JRImmVOUMuk2ZOhnzSiBc9BYAFhYF4unDdExkI=;
 b=tdz9r11KtD96zuIqDEQTnqO4HZDLQmRg2oCRH2mMYiXEEuDSDTTZwilw5S5KBtn0+S
 5uruesu2BwYoVZJauICx/CpU/JfKubKEz5CowyTLYJCepog0pPQqk0IObCAOVQh/Q9Um
 5ONj83CQzIhKoetV8CZ5v9qenD0o20UQANmNZ68Vp1bADgOQdUZVAn52j71TyM62WvAY
 i/ZYIAiynlqwO0Lrog0hjO3kyJtWnL1qGZNe+jm5phgtH18WMekRrnTJOta7k+mzyTxZ
 w0FRzY0zxCBfIliP58imKPYJbSPL+1rcj9GEIQ6tS9NouI2sswL0rdFuSR+Xt7/M+Ib9
 7N5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736373985; x=1736978785;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ueNZ6JRImmVOUMuk2ZOhnzSiBc9BYAFhYF4unDdExkI=;
 b=F7XD/hsOiFwmZK4IX6+NOLebe8k3pSCqEXBesQd4T4xRR0vz6jgN6JRRfsfiM5QvZA
 pqcEarXJ3nhfYOmgLQJORaQqoEP+TiVt5f8yYMvKCKRfQKT2+JIFLJ0IGGq/hq65vMyu
 mryfVu256gnENp9aD7cTLoqJe70rJ4iuW7fXF8tj8m7XgqFPeJ9i2qsvtvbf76VLhwIb
 dvf/zfuZmO7CQZXLMglqjBx06BkC453jUgwz3Tg1NNUb0mgbn38PQ+0EQCe+Qp57ZfZW
 bSTszW3gmf9MZXzujN3T2SnmvJWzBq6mf6YPuYOjKgMmV1awWLnY7D+cXB+lq6IgzpS8
 VRNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX6FogHsRYMJjxtrlVMpbe24fSJ0Bjww7+oBi7nWteqCMchRWhDIyle5aieXRJf3/COOvZ392dk4OW@nongnu.org
X-Gm-Message-State: AOJu0Ywbi5hqq1s+aN8PAEZE6GO/wPQtwwNqkWkSoJd4uPFFbUnvmlgS
 l1TeTDmMRG3ptk9cwQmSNqjK+MqDXo5+REzIR5xCPNtVys9javolJVcErsT0/5ZxmXQNXDwpQQI
 Tf1g=
X-Gm-Gg: ASbGncsjnHuT0BXGerlA20eJTBXo+JcUPBvZGIrPGY8YwyFpRj7K2KAz2zvz9z2wKhj
 /624O2E8Cw59N5GwI4UzMPrhqBwjOqBRdN/nHzPnFETdBbHvRjesgOPN2Z8Bd2NCMBhWjc5Q/10
 7YObRCSB8k/YSVF5e2fwHiD7BuD8NZOJ7r68FCgX/fpoCe+1nbK8B0BqR59I+zb5nVLqh/Uxms4
 RbYeXv2pb3uqLmDrPXqkcNXiKMe/ijpZQuMnSOXPkpC8JI+x4Vwi/pUPYrrYIufzkRMnOKYtU9p
 wxOKW3lc2F1rqNGa2DInrlMO
X-Google-Smtp-Source: AGHT+IEZ/NO8muWIMRds2Bda5sTXXFgDouvo5eLN/urEQ5EbDySQUCZs5Wl6wXG61ADZvdKHmh47ug==
X-Received: by 2002:a05:6000:4012:b0:385:e968:f189 with SMTP id
 ffacd0b85a97d-38a873105c7mr3798524f8f.51.1736373984999; 
 Wed, 08 Jan 2025 14:06:24 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1ca9sm13550f8f.92.2025.01.08.14.06.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 14:06:24 -0800 (PST)
Message-ID: <b7331b9b-9fc1-49fe-b80a-40fedb9ce6e4@linaro.org>
Date: Wed, 8 Jan 2025 23:06:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/81] tcg: Remove TCG_OPF_64BIT
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-30-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-30-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> This flag is no longer used.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h | 22 +++++++++++-----------
>   include/tcg/tcg.h     |  2 --
>   2 files changed, 11 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



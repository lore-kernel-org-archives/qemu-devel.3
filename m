Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137B2F99C6E
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 00:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDtNx-0002XR-Jp; Fri, 17 Apr 2026 20:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDtNv-0002XD-Mn
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 20:18:07 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDtNu-0007Z4-BU
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 20:18:07 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a8fba3f769so5724775ad.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 17:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776471484; x=1777076284; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=056FbzWzhXH+PK5bWTMpRuDHFJ5ONlYZMRuV8c6Q1lQ=;
 b=OqkF5HuVi2ozE3qGv+WLUNf7qZnVBbNnBtHHQzUmbblb9UqQCY8vcLWp8SKCIQKqEh
 2vZ3+15z0Su2Iv1Be7N5z3nX/muOBzJyQQTMAGjHSwSJQa9N+E1+SPOtx1GPmUfELkqH
 h1xzUl8TRdfLJYHzrAvkLN9pBI55IveeKhfiweJF/y8qWkqxj82OMrryIFjnhTQidGE3
 p1TS8GCyS96CrwrQAYCw0a1Hdqi9wa8l4/ZxTxGScmzTY2k2qBKD/eWS1ka6Pq74njdY
 XvghNL+k8j5h21zabrFSn6YFCatbNRrCDVDm6C72rpqPCUV503NA6VOf7Ah/1iLDp5nt
 YC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776471484; x=1777076284;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=056FbzWzhXH+PK5bWTMpRuDHFJ5ONlYZMRuV8c6Q1lQ=;
 b=O6CBnbJDIFtOOMxe+LHlnUzDkj1s4NGJJuI7a5bRskm8Oh0GpIyhc43bWEPdYesK2d
 ZSFNnuEEOkaV2ul8Amg7DdVj9SyEI5Ng/N0hy+kwlWIVvsxVs60n+hqdXAx0N1I5ce+l
 Rxj9NxHezWX+woti4kEg/qBGOP5wIdtVPsG7ry3MgMM3LIGyinYS7134yoe6/1vuNLfp
 wF8u5V6i12UUk7s88KseggltYTrNtPOed36JZUQWmRK8LAkvhDRWOXH+u5y+PA4MnNNA
 4Be4aDWb23Af+J9EpEp8JKrPdv/48dblYLbuTZyE32bl7D3t5W7J7aJsvF5TpztRXdTV
 YGlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jee4gXY5QZdJSVdOajBZ9HeMMcPwcsIVJGBaqEr73brtBeeQIHFRSkDLLe2xZKwQ9jPsog6LKfdMY@nongnu.org
X-Gm-Message-State: AOJu0Yz2q4O+OOdqp1XQytzt3883yJ4iKftFA95TaI8zGNfPdWKT+N2r
 pUpdPI0+acEeiCMqKz0JQvpzMCm7Q2v5BcIRZButDNC318X649oU6x3iFUGSLzGbOUXTTTKy7nn
 NTpdxYdw=
X-Gm-Gg: AeBDievadBqz3rpj+ZU+XxUFl74JHCjJDEqo8D3qdPkvFYaddX8efiYlc/QSp7S7EAw
 n6YepQDhy3x/OoAgqx8sMzpE3FO33ZK9eJGxEnn6pUvfllVkTIiEEmuOdrHH+o7qkVoPQHi0zjm
 F9u6uMw3QuAIobF8s01YKAEfqkI/xMFdsrFpJe5IVwlenz+rjzKUJXM8SPFgdOD/Zi+h9iZo1dM
 1vK6uYGw9M+i/9tt0ahwgcB2gyZI0IfvPT38Mm9ixdFEQgs5b0h5pCJ20M/fZ7+9F1ar2Vu+x1w
 7+Tqg7s3CHEBW40k5MhfvQAPipsmnQTz++UODKxRNyJboigfXiYrn4cXgtFD2nBgvjv3wJk8AEa
 CaaC2UsmmiTR/5+rdV2Dqs3ou09RSIVUR7IpVS4D3Dr96Ec0GZutj+Uj4CD8SX58fowwRCnudXo
 9Ave0z4PCX6a5zA7ETu0jH38eKkdEarANe+lyzLSbWtxC2N729SEduyL/DbVyxS+EhIVIz4p8VM
 UWPaheMNyVQaIUOC3IYytY8pPdlpSGsQBX08EKo8703H6GKG7gzYlPsYqXNJMQcvQ==
X-Received: by 2002:a17:902:ca0a:b0:2b4:5986:cd80 with SMTP id
 d9443c01a7336-2b5f9f61984mr45557095ad.26.1776471484265; 
 Fri, 17 Apr 2026 17:18:04 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:742f:8dfc:5be0:dc23?
 (bg30dhzyct7sk57q2zln.ip6.superloop.au.
 [2401:d002:dc0f:2100:742f:8dfc:5be0:dc23])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff729sm40460295ad.15.2026.04.17.17.18.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 17:18:03 -0700 (PDT)
Message-ID: <7388ed77-68a2-421e-babf-87c540f1a45f@linaro.org>
Date: Sat, 18 Apr 2026 10:17:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] target/mips: Remove unnecessary target_ulong uses
 in LD/ST Multiple
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20260417035734.32334-1-philmd@linaro.org>
 <20260417035734.32334-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417035734.32334-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 4/17/26 13:57, Philippe Mathieu-Daudé wrote:
> @do_r31 is a boolean, @base_reglist an unsigned size
> and @i an unsigned index.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/ldst_helper.c | 32 ++++++++++++--------------------
>   1 file changed, 12 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


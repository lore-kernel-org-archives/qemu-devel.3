Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBECCF2594
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 07:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLcyk-0008Df-O3; Wed, 19 Nov 2025 02:51:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLcyH-0008BT-80
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 02:51:21 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLcyF-0003Yg-IU
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 02:51:20 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4779a637712so27389495e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 23:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763538678; x=1764143478; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OIFUfe0Ax/LbY8n3zSczwiP4edhWPEkUA2u984zhCGA=;
 b=RdyVXlMNdUEKP48+E8yEmkiDloZCXjcauMrohitcoyZomuKAg/g1XmR85FBoeMRQZo
 qUszX07PXtxb9KqAc+yxciRl5HX3ykzABFECDsQAvOFSkzPPLQ4UCJBmO2hwwi4MhCNF
 9B/QlLV/m1LhJVkQ8qkiiz0E6L7fKRXX2zKYBiiBticRCFOF224oejHqKi03MNmS90Hf
 N4yw7bAysw/oNit7TaMM7KhrpzcfE3+dioG0w4cU4DDf2RfUxEvaIugtsOxsT85dtVTg
 zlj87QaVRxja+Wew/NYMeeMhas/uQ4gItg4A3M63dl9zqPRinLDjqzkIOQCs3/DpcumS
 tJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763538678; x=1764143478;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OIFUfe0Ax/LbY8n3zSczwiP4edhWPEkUA2u984zhCGA=;
 b=gkT/c4jj0+xy6rs4uqQvL8+VJ+TTEJMdoG5DJYPm2j2dTEDk6OuXCFXo/eKMp3CwVB
 e9xPzj8iKSQ2Zqyj5J//N7mrX9oYIIKHT1a2lRT+2Nq5U818V9JLcmkkGzIc6qUfEO1g
 lQjyEt8aus62qBHuJOPqvGjiDjqCb1GcwHneUPdxpdg/sM+uenNgZhN+w5z4FIK8pRAc
 f7mLxDSSUlgKMJOfmt7F6frMjEfbPJnkbFbTxig1exBfzsRvn/3HuLK4/opnp0LVwshO
 D1dloOfB1YHzIIueeR53fYiLt2kOw9JBU0NsmPHUvQNicnovPanr038IevR9R2PN+p+q
 yhQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUcb/tCGZDZIAmA8nWFF+38WJMU5FhzreXG/zn170Bkh1s6ru9lS3acxNV3BkKyEcX9ZSIiXT5dNaY@nongnu.org
X-Gm-Message-State: AOJu0YzxQa25a7aPyN1yso3ZCLXZTi4o8rEnfPglgmCtqcNB9ARhhQws
 TvqFzPthQ81Me22FTElP8/f3tTHDC2UwKUeVGJpkFVw9OXN+789nv/r4mgko4eLUpqc=
X-Gm-Gg: ASbGnctw0U2UU85vV4Sa6ULfY3Km/fgP6p2ufWPVKIc2APS3vJiNPzzJaF3mXV4LIFU
 JDZTAq0Ypu8d6xBtsSazMgm9nFUL7NJnzGe7ZTHxBAAM2fAMeT6+FJ+LxycltY7FbJlrD3mmflF
 uqBHSq70p/ntKPBELwgqpGnNCmvysPyne77UYfngn+HrJ1YyHXP0hHvg/mUoOIr/kFQaQFg8BUI
 DjkMAofOv6FtFZzAizYvpfhlChdo2h8IhupCTFI26nrNzPFxVJSlK3k4/uFUKFcrZL/mWCoHNsD
 4YXFbRPgbUCHXbWTot+EOg5EOb0uaCtgLkAzX1FBJ6nWF9++uL/KKjmuDWwqEpp4Jka+0f3rkWX
 YKdtfAR+XmksALa9tdln//VUopoRcO9O5D1WWij4z3Zy9NgQQ1jUOuYNvsLvUAzNHjSjpHdRh3U
 HOHh8QSq5XRV+ZPV3GTXMsqGxQRCJuYCEn5gcokefxielqWZ0G5NZ62EcFVJMLb8nvCIzB18KCa
 t3/2Q==
X-Google-Smtp-Source: AGHT+IG253dnn7Y3Zux5z6kjfXJqQNkl0wue4SOZVv1WmIBx9qYjPcDhxtkWJfuGTcIaXzUfPstlYw==
X-Received: by 2002:a05:600c:1caa:b0:477:76cb:4812 with SMTP id
 5b1f17b1804b1-4778fe0694amr206399265e9.0.1763538677914; 
 Tue, 18 Nov 2025 23:51:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:ed5:b1f0:90e8:1fdb:2cba:9db1?
 ([2a01:e0a:ed5:b1f0:90e8:1fdb:2cba:9db1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b102a3a1sm32432465e9.9.2025.11.18.23.51.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 23:51:17 -0800 (PST)
Message-ID: <d1b935a5-61a2-43db-bcc8-df1e8a1d3649@linaro.org>
Date: Wed, 19 Nov 2025 08:51:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 10/10] docs: added MTE4 features to docs
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org
References: <20251116-feat-mte4-v2-0-9a7122b7fa76@gmail.com>
 <20251116-feat-mte4-v2-10-9a7122b7fa76@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251116-feat-mte4-v2-10-9a7122b7fa76@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

On 11/17/25 02:40, Gabriel Brookman wrote:
> The implemented MTE4 features are now present in
> docs/system/arm/emulation.rst
> 
> Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
> ---
>   docs/system/arm/emulation.rst | 4 ++++
>   target/arm/tcg/cpu64.c        | 8 ++++----
>   2 files changed, 8 insertions(+), 4 deletions(-)

Best to merge with patch 1, as I said.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


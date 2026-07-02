Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD09C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfL6f-0004Iv-EC; Thu, 02 Jul 2026 13:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfL6c-0004H5-NS
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:21:42 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfL6a-0005dP-9x
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:21:42 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2c9b42be8feso21842635ad.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 10:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783012898; x=1783617698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yJMLmBfSQ2nM11QZ9IlwqkPdUVHSKY8crGK/Aayr8R4=;
 b=qZmFdflF5TERSX4y9hagU6tCKJQXaN61VATSniHg/xKkAfK1LZLmu/MZUFtLCm48os
 VbzJHShighDPbvggKW95g5Z3rtQFWsN+YFC9Qh2cYVXnYWdai8Lh2yF2cZFP58y/N9R7
 ap+iWPEQD5/QynPoIgsB73t3bjBm2Um265Yq8acOVNAqtZ2aJNl7z8I257et1eI8x42v
 JkPoSTc1m0ajyv6GKMXPR7+3bv9QLeEO616mLOlMf6HpB9ZWKFKDUa64CahXcAwkUac1
 o3upAFDTmCH7aJLSxQWYeeE1f/23JTQgn0ruBj5PX5x/9DM+NDVEtNVOOi4/lNKDRoI4
 wLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783012898; x=1783617698;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yJMLmBfSQ2nM11QZ9IlwqkPdUVHSKY8crGK/Aayr8R4=;
 b=PzXeM7GpaFpcBxamue7H3w0R2s5xe5L6OuFBXz2+Rqzh3j6gfhHdm1Bg0OwVrOgZHN
 z5M9ERAcmfxaAs1FfVXX7LD8RfPj+94Q5fN7L5rJ78JLFPO8TbMPjoUfhnmmzYFkUc4X
 VaVyfCQTFT3onn8FA5e2riwqz1l9MVGe2+wquqTmsdzKDDWZeCnHg0xHyjZgrtY7vA53
 Z9SsFEBdv4O0eeHh/5cN0/gRAOgv9Dv6oXSDTruvdwQQyP+IDPwI5lSjgzYifjFo32wt
 CuD+ut0BVcJVBvPzp2B7Ukp009iea703hv4fcz+k+hSuNlhlOC0RlFRSsQDA4ID5Qqfi
 6jew==
X-Forwarded-Encrypted: i=1;
 AHgh+RqwxbifnWo/QxP5k5NUKm4ubQRXFq1aJ1vYIBuZXlW7wuW+1LhdmX8X2NApwOcg74Vg+TK2JQGB6NaW@nongnu.org
X-Gm-Message-State: AOJu0YyjdRb/CXMHAeN4IWYYiTcL7UjcTI4LJoq9sP4e6DSn7hcfjIHN
 JwCJm16b4+LMTg9Jbr2eDe7TUijjq7z1Hf9sGbuxtQQN7oQObFISSHfpik2F0bo3Cmc=
X-Gm-Gg: AfdE7cl7I9NxHHdtvE3ao62ifCe8jIL+SysgK3HUQwCqK6yjCMHSylOD4LYTScIzuSu
 5fsqyWeY2qO3DULoYjQoHZB/lBK+3fgqAy7rzpEJ9B+wuBdxxU7T3I2+i2KemNnT6BB7HMB7JW2
 LA0HR1wV4ZrQFOX0dO5uyaXdgOO73yfhimtKx9C2927Nmbf9fjv6C3S6cgg3U3NIXDE9u7GyufH
 6IA3a2g4IydgVOwCWO0iAHJfv7rak95/RGhx+0RzuyOUbz0+W+l6WOibTzYWCnNuIcdrwOg1TYp
 nffgWukqQJodF/rZ23Vy+MlMKNEb8mjmnv3fuy6Q/bSJ9SCGS1bFJAb/iTC6Sr7lUc+m5EIg0lz
 O9ifqFVT7IhCEBbbuuvA3ZEx4GHlSUl0tih4jYtbmBi8PE1xS74Q/DxolxNYU/JjnkoT0ChK9QJ
 dqzjVa7Dd0cS9SKc5t9oTM5tPEcqk+zsjBb3zhs8/Q4xIGOGyPq1fxU5+UEg==
X-Received: by 2002:a17:903:26c7:b0:2c9:c575:7e22 with SMTP id
 d9443c01a7336-2ca7e67b281mr77848185ad.9.1783012898403; 
 Thu, 02 Jul 2026 10:21:38 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca9a8dae33sm16806085ad.1.2026.07.02.10.21.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 10:21:37 -0700 (PDT)
Message-ID: <8988604a-9228-48e1-8255-6feab950f080@linaro.org>
Date: Thu, 2 Jul 2026 10:21:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/33] gdbstub: Make default replay_mode value explicit in
 stubs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-13-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-13-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> Make explicit @replay_mode is stubbed as REPLAY_MODE_NONE.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   stubs/replay-mode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/stubs/replay-mode.c b/stubs/replay-mode.c
> index 439d97e4a87..5bc8f7d6589 100644
> --- a/stubs/replay-mode.c
> +++ b/stubs/replay-mode.c
> @@ -1,4 +1,4 @@
>   #include "qemu/osdep.h"
>   #include "system/replay.h"
>   
> -ReplayMode replay_mode;
> +ReplayMode replay_mode = REPLAY_MODE_NONE;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


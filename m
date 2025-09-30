Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449D6CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 21:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3hYo-0007tb-4h; Tue, 30 Sep 2025 17:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3hYi-0007tT-Lq
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 17:06:52 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3hYa-00051O-1p
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 17:06:52 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-26a0a694ea8so52814935ad.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 14:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759266400; x=1759871200; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lq+drI2K+BnPf1JIFlAnQjGpHwNBfwg+R6T2KC5kGQ8=;
 b=yMgbcm6jMnzr+BhFrWZc1VEI+4f9cOcgKxAMyQW5PBAgaRkZOYwMdQeULrqaAZ6ViU
 GpoFtgueai+zP9kUW0jzGEQdKgJUAOeh/c6xTaeIVMVAvQf79ZihYLyM+mqE4C0X1cwv
 cWjKxs4IkSuTOZ1ypEFAbZ3eaDjU/Af8cLDwDIi7TuKT1HulnoNBb0Ogh/+UhuVevnTS
 eonKsLzvPOXT77PsAkP+1X/G5fi2CDYSNnDgxzsSnjbjyT7MFuhFaeUMEi5uhkWQFgrw
 lwYsE7WsqINQbENCSEs2lutDX9jBhr6FjumiH0xkhDWsGOMk1UN+b3UE3sPLRF4KRSW/
 RBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759266400; x=1759871200;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lq+drI2K+BnPf1JIFlAnQjGpHwNBfwg+R6T2KC5kGQ8=;
 b=kHMga/VM7y6536NzftHw0S3YoCFXMOE/tPJ45B/DDDvvsw7HLpazKjkjDpytyWq6Wa
 DUx6rqU6RMdkbDjTQKagpIgRQmwFhQhAEh/cKiarRCSobcMq4DZPtBdsTf2z+BWRM6I8
 XQ1NV6ritlkzDSryKI1JOd+thz2e7z1kFXmmUEEbU71h1vRKIsW1gdSdC+ZrT1nF6fgg
 bRXYmUS0V3vMI4dcTIVrsqSwWWaLwDCflseF6nugxceVFHF5G2kuNUmffUkgUfCDjzZ/
 Lk+4iDO+Rlokv8vbGawtnzovpvdNLHcR9TF8R0hrZNILWlji0D61GyIg8y1DVPWKdDG8
 reiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM2pliyM+hYY41Z+n93Vqn+GgJ2lBiAo9eAd8xA04yZhaVqIFS0FdplAh9ExWNk06n/znZNe39lg5l@nongnu.org
X-Gm-Message-State: AOJu0Yw92CSiwDzBtVrVaFU8rsZhFXpa173kqbXZ8M9kERtfOpjmUJb8
 6toU6F9YnlPo2rRZ1qfOcU9Z0ivkz9DHycEfroUEu19ba9f5x+DDjfOgSPMnPSgjxBU=
X-Gm-Gg: ASbGncvde7PruLmnlCzunWIhkcjaGVY7ZKfg1XR8hPnU4lTnLPK95QJGDABxlaYT+Vg
 7Jd8UnRCgubM/5vl33zDNA6IM18wKowYB495k8oxbWUGlZ2wziIVrmOlnRV6gT98P0hO7/nAwQU
 O3ZC5/uoWxN+lXjgIGia2k1uZFc8Bm0vjd76N7cUR3pOYYQuKnEFPfMSaP6LCYI19DbyoboG67f
 JCMT04+pIQXMRk6hj87ctEh0YE4pZPLiCVQvQ/7PX1oIrETRXCPcPGNcfy0GDjSTfp77IDUH7D3
 mMXNikDBpfafiueOF+JggUKHR4LccQe3GEo6aCt5cRaNNn2fSVvfXHNFy3Ci5kLc5nhu/fHTHyR
 T8lwDiCRlkGTEjYnpUlHFw05zcL2dh0aaU/ZFzUUZsXSMNt8MK/IoBUejtp6AKRH1OhzNI+4=
X-Google-Smtp-Source: AGHT+IEKjO6TSiXMch1Fs7BtlBx9NFZjP0YSOK4ecZhMBN4VWiAg6nG1P64E7dr/QkzbDdAIKRiP5g==
X-Received: by 2002:a17:903:2384:b0:267:ba92:4d19 with SMTP id
 d9443c01a7336-28e7ec8c907mr13039345ad.0.1759266400168; 
 Tue, 30 Sep 2025 14:06:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6882290sm165467455ad.76.2025.09.30.14.06.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 14:06:39 -0700 (PDT)
Message-ID: <9ab139aa-a56b-4fea-a393-40fa388de447@linaro.org>
Date: Tue, 30 Sep 2025 14:06:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/18] system/physmem: Avoid cpu_physical_memory_rw
 when is_write is constant
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
 <20250930082126.28618-16-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250930082126.28618-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 9/30/25 01:21, Philippe Mathieu-Daudé wrote:
> Following the mechanical changes of commit adeefe01671 ("Avoid
> cpu_physical_memory_rw() with a constant is_write argument"),
> replace:
> 
>   - cpu_physical_memory_rw(, is_write=false) -> address_space_read()
>   - cpu_physical_memory_rw(, is_write=true)  -> address_space_write()
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   scripts/coccinelle/exec_rw_const.cocci | 12 ------------
>   system/physmem.c                       |  6 ++++--
>   2 files changed, 4 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


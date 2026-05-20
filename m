Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBC2CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf6A-00034d-Bi; Wed, 20 May 2026 07:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf5e-0002xH-UP
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:28:03 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf5W-0004NP-Hf
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:27:49 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bcda7765d64so1103182366b.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276465; x=1779881265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SHV+1Rn1mxuUbjbRE0n9StM9qk6/MS2BQPDYNS35wkg=;
 b=Xm6uUyp3nVbRFRtPyqRlgDOox/S1qBLNvTa06w4rDPPhDFXy/icdYMlAA6rClDaCCm
 pBGSc1+SDlnxnW9PQ83/XI2Bgl6GBcYjmhpnwgSKMu+PJEemLF5/aOh5neTPQsUqyrsl
 H+jE0qa7mKcLPgxSQx0HadOGsjyxZFJkcxRWPQmog9kuhwB353kk29Jq1rUBKUd32b42
 koka4RKY8CmMqnwz3tH4EtFdGC7GbNaov8wgVy7NjkgiAcbv300ZzzW0B2GNrTsuWqnA
 FK9cqvWh81Na5dta9QOPqYMgtCR5xP4i+DxJXtpRf0pAW1WrfOC61lJQMYSsS6d8z6GA
 a64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276465; x=1779881265;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SHV+1Rn1mxuUbjbRE0n9StM9qk6/MS2BQPDYNS35wkg=;
 b=HGOr+qr3giyaNGPET6YsiIiEk9SdW9Vhzj7r3eUynXv3KSVlX015MV4unIFDV/2673
 yLm5km89AxUWe8AwESKo+P7Puq103qRo/LZ09VDA+2IXjavooeg76ld1yPExDSfsbtU3
 Bb9+fs00sIyKQOv+NQNqmkDCCqNr/jdLSG5lFfdSydAdOhiIJBPQK/dyLSC6rgJ0Vann
 Vk0Lc7vXjrT9TGnQb+AuaR5xW9RCqJHDQHo5fFJ2c+ImqBCnBYf2ykA2xJyGxmhw3eqz
 MBHsPqG1uyokTdd1iGP0TfBeu8lKP2tz5L7HgOEZXkSESgtYvQuyBJMaR5tGk5JCwrMx
 Dodw==
X-Gm-Message-State: AOJu0Yzq3yv6OVIdBTjr7o+Lr3k6cml/IAfN5mTnL5gRVgpMRJKZeEcc
 M37bokWjWX/tQJGhGoo3jVnsygB2Wn9zmvEXPftXthB0RV3XGJklnIXt1ItHtKE9H/zrlXCbeiv
 53Fbp9Bw=
X-Gm-Gg: Acq92OEmvJ2tKoIQ9AGqBMp2fsYiwe7GCh6w28zFd/R98yUF1DKvYBOxC+aJp//XxC/
 eT5LCl586mWEhi+8c3oJ3geLANDUDqpbXJDRytxXbUTmSgZdmtNchc9FcOyJBg0IESh+tXnh/MN
 Ntf3BtxNsmSA8lnKYcZNvgiICXFnQ3tkMojMMio6R2U1wveSPEP8+/2f8Wqxx7H6DMfYALs4vM4
 4Mm3tvFXLS9XEwpxd0Chk3Z6qwACMuIIFNJcLfP2Di+MaaJ64wzjG4G1xdj3DeafZ2nBzufOz+z
 i/q3qG+Y9cH7Xn6y97/sWbauKbahtczBNO2BpE27zG/J5WMzTtG6n2KTigp24cDyd/yXV7yRtCn
 KTqkI31RWfNlNmH8rFrr2SEWeIbqDPOxcOLrnM+kZWjde1SFHo/oeL1vmusO6F8h9koE6T2Bpye
 Sk0IVo07MyKz3URS765/bk4sdz6pv+k3ryVqnBshJiT9pqiLx/TZkSSa6eKQldNsA//Kg+58g=
X-Received: by 2002:a05:600d:644f:10b0:48e:9134:6ae7 with SMTP id
 5b1f17b1804b1-48fd62d9be0mr302470095e9.0.1779272724724; 
 Wed, 20 May 2026 03:25:24 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45e6a135f0csm34191537f8f.27.2026.05.20.03.25.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 03:25:24 -0700 (PDT)
Message-ID: <3d786d69-43bc-4cb1-abbd-d08911ea73c4@linaro.org>
Date: Wed, 20 May 2026 12:25:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 13/24] target/mips: add Octeon SAA instruction
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260520101807.9971-1-philmd@linaro.org>
 <20260520101807.9971-14-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260520101807.9971-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 20/5/26 12:17, Philippe Mathieu-Daudé wrote:
> From: James Hilliard <james.hilliard1@gmail.com>
> 
> SAA atomically adds rt to the naturally aligned 32-bit word at base and
> discards the old memory value.
> 
> Implement the common SAA/SAAD translator with TCG atomic_fetch_add_i64.
> The MemOp selects the word or doubleword transaction size.  QEMU only has
> one Octeon CPU model today, so keep SAA/SAAD under the existing Octeon
> instruction feature bucket instead of adding a finer-grained Octeon+
> feature bit.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/octeon.decode      |  4 ++++
>   target/mips/tcg/octeon_translate.c | 14 ++++++++++++++
>   2 files changed, 18 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


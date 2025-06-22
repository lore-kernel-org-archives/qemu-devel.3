Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86963C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 01:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT9cM-0006hr-IB; Sat, 21 Jun 2025 21:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9cK-0006hf-Tl
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:35:32 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9cI-00023l-SW
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:35:32 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3141f9ce4d1so2722059a91.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 18:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750556129; x=1751160929; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oH+ldliLM/S8FU5G+2VWE91Ruc8AmpnIlzGpx/IndAY=;
 b=f60ORUnv09oWExDJAgXWOlITCCUI2ljF/T/UmcGX8S80zi1j8Kf4mTOdnVqKz4bkGA
 3g/zX3m4k0PmTSq5xRIWl+6wG5EKbkvLfN6NnB2zJWlu/mAkHZw0Ade8IMrbPRfbhbxQ
 kIQo941ui/vylmbYZjJswPpfvLBMXyxKp3mARGw0zx2rJUA4gb0UkjizgSsdkt6fmKsT
 BQC+3NQQpTkkLgkKfkww9F9lKxFXqWybkZ7VhYk6xBQZ9y7nNlwbYVc1uYT//RskyodF
 bCn8MwtLXwElYu9ngus37ePEfqLK9EBrHUsiPgasbGMU/F0nwYIqCTRP0/1XxC/Umh40
 WjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750556129; x=1751160929;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oH+ldliLM/S8FU5G+2VWE91Ruc8AmpnIlzGpx/IndAY=;
 b=KSuDu8u0SJosXcAE80DD49Fc0NMVsptms+rimFAwcCJIq0bcqgM39iEDiPWnQGJGLs
 uJ6YYKqA/RczgkQ2ZraQ++tvkQePXF/shrpSQLaeuLR2Bb+BK7B55o79QrdhyD9MaPZe
 Zn8cBmwm5WT6TzGQKCZywkvML7mfmaKRyiLi2hJZJityQN5WJh4u4zyXINq/v1s02MTZ
 3A2td4i64AJ244Fr25pG1wFeLMEyqkGaGpHvO1NpSijkzg7AQBMPyXzyWE3+XkKIxCfI
 7HwHdWaknBOMVk9p8WXMCPFbhqJ7sDLTWdtz357Ns2aqYDCx0TfMd9MVHEf95nJXvH5j
 zc4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf+yn3gYoYyKI8xtX89LgI02qZtqx+h5xlCdTX/lkma2ZyjB1Ynu5sfvWKoOHBwdqwvSCoroSIjDHu@nongnu.org
X-Gm-Message-State: AOJu0YzbJkUYliZuVOIIAM/F9tEBycBb/8fSdVmNU6vw6cyav6nKS987
 DNcrzMK5Gc/hMmpqXfC+DSdQaIzlO7ad22ylPRqkQXN2otoWIOw65mldvBKjO5/laP8=
X-Gm-Gg: ASbGncuvotztf8YLyT4EoMzxtM2mLHu80LnY6vlxoDQusMgRQu1gICjXUBhRWUobzXH
 BofijC4HTVK8t1/FRRxMvfCIX2afO+xCREamlooq4huy83i4NMV3IU1V869I3igTLqtN/BXSDdK
 beATOtcPNSRwlCiGH07SX9SjeW09p26SCwRCC0iRu0UZtv4R/d9nVX+SPgpDZzqikVDlZ2zWG/+
 uwNR4oKiH/+l8057Lc248zYbAiEau9muELy9lkzc6qglwhpiZBQogknWRbsDqdf17LdQDg+OhC1
 h6VSm9BLFRxY462XwJOzYJCHB3wbuoQhOD5sIIvxi6RDgZ3aWNXfG0Y/dUBe1D3+KenFt8ldVr+
 o9jdEupUkTrBrlt7vrYKVKBCzmhrz
X-Google-Smtp-Source: AGHT+IHkzo0Fhcgd/b9X2ndv4KY8CCt50XkcxVBEXfckZC5mHGuYGXmRlLnjPj6g5Q6akh2Ooejpdg==
X-Received: by 2002:a17:90b:2584:b0:311:ffe8:20e2 with SMTP id
 98e67ed59e1d1-3159d6209e0mr11796192a91.4.1750556129125; 
 Sat, 21 Jun 2025 18:35:29 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3159e0483cfsm4841084a91.28.2025.06.21.18.35.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 18:35:28 -0700 (PDT)
Message-ID: <d3b975ac-c85a-449d-98e0-705313ac04c7@linaro.org>
Date: Sat, 21 Jun 2025 18:35:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 20/48] cpus: Rename 'vcpu_dirty' field as negated
 'hwaccel_synchronized'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-21-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> Try to better describe which side is dirty (QEMU process or
> hardware accelerator) by renaming as @hwaccel_synchronized.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/cpu.h |  4 ++--
>   accel/kvm/kvm-all.c   | 20 ++++++++++----------
>   target/mips/kvm.c     |  4 ++--
>   3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 69ea425c458..d5f82609943 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -441,7 +441,7 @@ struct qemu_work_item;
>    * @opaque: User data.
>    * @mem_io_pc: Host Program Counter at which the memory was accessed.
>    * @accel: Pointer to accelerator specific state.
> - * @vcpu_dirty: Hardware accelerator is not synchronized with QEMU state
> + * @hwaccel_synchronized: Hardware accelerator is synchronized with QEMU state

Is this change really helpful?  It isn't to me...

If you want to change anything, this could be a tri-state enum:

   - qemu state is current
   - hwaccel state is current
   - qemu+hwaccel are synced


r~


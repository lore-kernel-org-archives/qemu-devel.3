Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E69CC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WTd-0004X3-5I; Wed, 23 Apr 2025 05:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WTb-0004S9-Ir
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:33:07 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WTZ-0007RP-HR
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:33:07 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso3605028f8f.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745400783; x=1746005583; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VQ/1W89ukXJD3s+bae/D4pE58Zk4HqS/ETHOTRBiYpI=;
 b=BXg9GcNjd4fIYRRls/3QJ6ZhnVXQgCoUzodW0qKiG1WmmqVQ8H9Zb1YzR3w+slUAqX
 Kp9zJjpV3p2Vvu+8d6KNe9tMLt7w/WMEQoky5xPJKORCuZO7BMdjrq7yFR8Db7G6uvLi
 ndevrbBmp4wNvFnaFxDjJFIdwEjhMmXzoPxnZoD/Ef7WIPGVrTSGwWiF5jlTvjszpVof
 9cf1rHaorbmd5XpQ9K5zipSDL/kXU9/u8t0tqwcW9YgHntF3iQsF5PwHgoJ7EWA3sjWa
 pikL3ih0nS4jZy5kS35c17oY5lbLiafYjYGUONoIHKga2FeZV/dKqqdMwgvwA181Rh0F
 FdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745400783; x=1746005583;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VQ/1W89ukXJD3s+bae/D4pE58Zk4HqS/ETHOTRBiYpI=;
 b=VjO6kEQcKtuCh5ccVlCcN92KPvzSIEXc2AMQwzRmLkcblIaNpFHFoxVFnWK7n8gweL
 n6DFhrC4EZxZzV52kpHDjkrroNpDhgZ87a0v5Vsv0pJJ77P1doTy0T52WLPim522SRFf
 4XNki/wfTLJqR1DW1MRHVuBMd+1iONbKB716d+6LCfXiA9ZAjW3sm5Jfnh/K6eeEXNve
 HayYlxcQd3unV4G0N/QamGs+VcnGdKh7WPhh++5PdDzwQiUQK5KA2gsPuiwr643AH2AN
 0w8uH8esp02aMff8O3ZyldAIU4KltbxXu8m3T3QD27/0BWPNMctddzLvEd9to+wa90UD
 VUBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdeji7g7Z4OFiTYGTfGW+/pbDerJ6ndgWYsFlGJi37WrPWqiHWTz6kxWf6sd6F/5Jcf12kr80Jbw9g@nongnu.org
X-Gm-Message-State: AOJu0Ywpt5XlF0jcAPTYfwz+SKtpGyo7DcW2ocZn7Upjk86eAjpsmCRN
 kNwCudtMRlGTSm1QBr6T0SqiFRfRms1q0XA1JZAd0X9f+C5rsBmeRjfmVDweMzZ+FBSE+V9gRaH
 j
X-Gm-Gg: ASbGncuCHLSrWdLYPU/+IBCDq2VPah578MLqoVmdZToQP/Hes2vk+HO1uILXoi+gHsO
 dPa9UPxQhy0Yg4ahfdtbe0TmLgdtzrVEFwbdb+lwae+HTXdq0DOD0oxJEny9qqvckf/89bqwZ/E
 +Kg4C47yfd6Aj+VVFb+ce7hP8Lr5uAXRvpHMyssJPpqk6jtn8EKi69XROQ/CBYx67Y1O7nwbV+l
 GSrbEjuI1rlBw77TQsFd0vVeJgqg4pl2Q4YRFVgL7iYy4Zm1oIAIYxaPZ6PjAwZ5eBCCs2isrru
 /wJPb0rIQEwts3K+NH79eCPQuTNe3Nx7ihQJJyU8w8G/pvWJEos4eV2/sHuZTtjc8FnkHpSGLR6
 ExxX3RHBh
X-Google-Smtp-Source: AGHT+IEWmwu78Yjz2+NnG6Un5QfG3mZaFGxgf0N5Z9OI5+y7YiZtVMLGEGzmewlt1w33S5vsEK7ytA==
X-Received: by 2002:a05:6000:2209:b0:39c:2c38:4599 with SMTP id
 ffacd0b85a97d-39efbaee552mr14464134f8f.48.1745400783279; 
 Wed, 23 Apr 2025 02:33:03 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43d07csm18462886f8f.58.2025.04.23.02.33.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 02:33:02 -0700 (PDT)
Message-ID: <6e534445-521c-4807-b591-928375d343e4@linaro.org>
Date: Wed, 23 Apr 2025 11:33:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 037/147] include/system: Move exec/ram_addr.h to
 system/ram_addr.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-38-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-38-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 22/4/25 21:26, Richard Henderson wrote:
> Convert the existing includes with sed.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/{exec => system}/ram_addr.h | 7 +++----
>   accel/kvm/kvm-all.c                 | 2 +-
>   accel/tcg/cputlb.c                  | 2 +-
>   accel/tcg/translate-all.c           | 2 +-
>   hw/ppc/spapr.c                      | 2 +-
>   hw/ppc/spapr_caps.c                 | 2 +-
>   hw/ppc/spapr_pci.c                  | 2 +-
>   hw/remote/memory.c                  | 2 +-
>   hw/remote/proxy-memory-listener.c   | 2 +-
>   hw/s390x/s390-stattrib-kvm.c        | 2 +-
>   hw/s390x/s390-stattrib.c            | 2 +-
>   hw/s390x/s390-virtio-ccw.c          | 2 +-
>   hw/vfio/common.c                    | 3 +--
>   hw/vfio/container.c                 | 2 +-
>   hw/vfio/spapr.c                     | 2 +-
>   hw/virtio/virtio-mem.c              | 2 +-
>   migration/ram.c                     | 2 +-
>   system/memory.c                     | 2 +-
>   system/physmem.c                    | 2 +-
>   target/arm/tcg/mte_helper.c         | 2 +-
>   target/ppc/kvm.c                    | 2 +-
>   target/s390x/kvm/kvm.c              | 2 +-
>   MAINTAINERS                         | 2 +-
>   23 files changed, 25 insertions(+), 27 deletions(-)
>   rename include/{exec => system}/ram_addr.h (99%)
> 
> diff --git a/include/exec/ram_addr.h b/include/system/ram_addr.h
> similarity index 99%
> rename from include/exec/ram_addr.h
> rename to include/system/ram_addr.h
> index 8677761af5..3b81c3091f 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/system/ram_addr.h
> @@ -16,10 +16,9 @@
>    * The functions declared here will be removed soon.

=)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



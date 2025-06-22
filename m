Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539D7C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 01:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT9cr-0006rn-MO; Sat, 21 Jun 2025 21:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9cp-0006rU-MN
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:36:03 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9co-00025m-4P
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:36:03 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-311bd8ce7e4so2477114a91.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 18:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750556161; x=1751160961; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SqHAVHRHxJPOQlXK7gvsaUya4nYW273nqXP/wa03Yvo=;
 b=vNi6L9J+tDpse3nokWcRkVJ7ASShdLnVUVTwe0PYxetkHyJtNFgeR+eeqEQWLWVLl/
 bTWT1RsMuanrl3M7PsKPpCyMP+HM5UJFEaeV1oVRMXactm7w5R1byaMBY7M+2u42O2Zo
 1XUGX6sBkeTBdJpjT6cjSVae83c3IcjtpkCpKpJIx7qBBYlp5LHbUh4oGGIvwLhEq29B
 dZ2aIn1vuCN56wI1HL+FE9ylGCBsp9u0EWzyqrLWRDzrvr0M+sOGPpyIVyConEYU/C5/
 Qu07nAPY4oWmWo5VVZ1NM8DG7EG056qKGTvZzMZ0OQvdsIX920b6ue4dmAO+vhYUr7I3
 Ab+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750556161; x=1751160961;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SqHAVHRHxJPOQlXK7gvsaUya4nYW273nqXP/wa03Yvo=;
 b=AZrOX9su63nTWtnvTxXp50H4B79AZMY5SaCPUAJ0mz7BpJlBki4xrEfnct7TcwXlDQ
 ci8Kh1wI2WQ8NwT4B4CC0aIXA2yT3AklJnS9ht3/Ajf08uCALYN6yXq/uhpmISDWhGs5
 Ru6KBR07i5hZXmfVYsJ/2oyMm6S+iO3jdGieHC2u2mJBx6wrDVaFBU/s7GkD2NfKtYiF
 rLu2qjQYwJ/GLDNsyTTJYxh6RQ28BsEefuhje2bZIQ6lnF+VsKPK/AUliseQjNDmRh+9
 owTeFYe/NWT5znqwB1bRXrA29bIJwqvU+S9VONELe+/3bmhUP+XV74v6YJyfvEyNVkM0
 O4pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgLWv4RFKfLBwrQ/iWqWXT1UTdBibKDoHDE/+9mW+ROQmFgzb6wc7mfl03sW1ShvYBJgruzDXDx5Km@nongnu.org
X-Gm-Message-State: AOJu0YwgqkpNxgKhfQVr+sV+pSbg7DVrwkqxxhSJlIpP7BZIjBa0naTI
 tSNIJw0Y6BAwsF5KsuOM+mALpGHZ9U9hnB28vNM7PrfW0gekYYUDVY3E7ROzLGdSltApkSF6kzt
 RuEQ3Hs0=
X-Gm-Gg: ASbGncs3datOPY9uzcXRPHbFfu6liA4lUmq+NQAUISjj9XC2jeSXQ9KTaC92T42KO1+
 YrpRWoWTw4n6qvGXYy/bRQOeqbGVvNXjt9SqnxRB8R6I7q2Svy557SCSP7nKcBBA0hl0OddnxSK
 M+H/Ijc0vOvmvcnPBpOrYDV1ul4YZmcbrV3TuiKybi28NjRb8pq9NSJ3OfN4vbnYCWopBrKKT+w
 g1GinlYfQzf2EC67XpygBpDPvJ8jVDE4PZuvKYsjdh3Ww1h7CJ6GLMeoU0GaGEXKmFbGEi50Q0W
 ySlTDJnEmslmwPd4ZnnROv3NHsbY2iAQiAJf6r3dRfAkJ7DOmHVIlSHNixEuWa9dtJaG4+qu7WX
 0Ai6nNQt0CJBW6Py+KXZHuyVnQYrd
X-Google-Smtp-Source: AGHT+IF/1Fyn57arfIdtXmr9GAKlh+oojTlhHkx7Nl+gaXtvvQipmxkn3z5ysmP5WZqbyG52RvXSew==
X-Received: by 2002:a17:90b:57e7:b0:311:ad7f:3281 with SMTP id
 98e67ed59e1d1-3159d64e39dmr15130367a91.12.1750556160636; 
 Sat, 21 Jun 2025 18:36:00 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d83d0bedsm49808155ad.67.2025.06.21.18.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 18:36:00 -0700 (PDT)
Message-ID: <c8675659-678b-44ad-b529-d7000bdfcc19@linaro.org>
Date: Sat, 21 Jun 2025 18:35:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 24/48] accel/kvm: Remove
 kvm_cpu_synchronize_state() stub
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-25-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-25-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
> Since commit 57038a92bb0 ("cpus: extract out kvm-specific code
> to accel/kvm") the kvm_cpu_synchronize_state() stub is not
> necessary.
> 
> Fixes: e0715f6abce ("kvm: remove kvm specific functions from global includes")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/stubs/kvm-stub.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index b9b4427c919..68cd33ba973 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -29,10 +29,6 @@ void kvm_flush_coalesced_mmio_buffer(void)
>   {
>   }
>   
> -void kvm_cpu_synchronize_state(CPUState *cpu)
> -{
> -}
> -
>   bool kvm_has_sync_mmu(void)
>   {
>       return false;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


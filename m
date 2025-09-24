Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D97CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 17:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Te3-0007w8-Pe; Wed, 24 Sep 2025 13:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Tdy-0007vC-Kw
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:51:06 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Tdr-0004H0-1O
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:51:05 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b5526b7c54eso49005a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 10:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758736254; x=1759341054; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zx1RkzVWtNMzPHNrBhqMziGYdp3EQbRrchWc5yYIqQ0=;
 b=dje7+yQNMeXcBYd7Lu0AkW5ZZDYg5LkEZt0SHgdcULwzIo3c/bOaVhO1s/UK/d8X0s
 vJ2uvruWgQhI7f95+jNVw+AWGhCrgiJ2OTKO+x3JwF3RrmeZt8Z0tXj8bHB9AiLH7Amm
 zcmPZon2RvWxAa85+gqBttjvNwTn3BifCRobrcPFDfZwf28q4mUdKrY3NmLvR03aPqVt
 LO+nOyCmcAHSLhfntaA4gexBcDxEFD7rZvBiYzZPdIth8DOAXv05YdQjtZjLfUX1FX5M
 DgpmLSFCxy/fAbYp66LEl4gVkslZSxaLQDYRNvy45O4w5FqDXe/IjcfsAby+SdRRZ6uK
 z/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758736254; x=1759341054;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zx1RkzVWtNMzPHNrBhqMziGYdp3EQbRrchWc5yYIqQ0=;
 b=PvIzIYRxrPjd3cKcFmuDU4Y93lBl5n5wCvXdXtq+bBQEQ689ZGeA4BI1e0Pg0X7354
 TW/57jZ1GzfztdmMJ0yPjx7c6D581sZqyAz4Rjz0l1j9BhTrb2z9GpeL9gvEju8W9/K/
 CE82yDs22TGKmvr0VJBfHvE7Yev8c0JL0TKI4XpwMGPRZ+c7rAp6NPMdYEravW6UYSOa
 WlhZZq7OfmoTTF6WSPEF9HuZxdciDWqbVW1I95KykQp0zZSinSNsaA4VSx7bkyBaHs6j
 h2KUX8c6KVzlMRWcN09GMHEpEDyp7uyfo3hZ4R3S6fnS3hGoTogUKMWLiSWBfUm0mD/p
 JvCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfwP5M/GmuqCgbpXu4LLHxeBiftnMQZmmS+ZKV4ijQZdV/uEW/kOgHIvVaQ11b1Xc4Gc8QoYbq4okz@nongnu.org
X-Gm-Message-State: AOJu0YxdgMcT/443y16pS+iWWGQsCPcDOxBKdLvglkocZml+48DYQmdw
 K+2IP/PPrUIR9oT+lpdESkp6ZGxe7/yDlTHSWabD3y8hiuhAPH5K7LumuhOCBoLyl3g=
X-Gm-Gg: ASbGncsxuyYBTQIx4xBPHCnQ50Dt4dqaPnXKAhIBM5wZ+bvCWuXuTnt2g/sqvq/GG5D
 T5lty+wij3URkMtnXXsu3ITfbDAx661spKAw+VRPLTq5Jaor9Arp4Jml3dfevAjid4/IdrpdYns
 K7YoDADm8GxwsyraDEln4/Cj7Q4TzRepMohW6dP+FGROU5/vqt3OxpN6YylOy7WIkRibHkxlkkH
 F5kw5BbKFKHsWzG7cAvUMea3V72PR4QqlmrxHAgkidPE/6svF0xZl4qxK4KSatbsmvrQCCrX6fE
 TWx8nu3SdNEPK5GJ5SPMH5XkLZAv1yupsalVVnXN+Go9qkqiGtcQJupkKfyAeARe3+/hUpVsCR/
 rRRVSHeTIDxzc+cmVoDEpdGX8rGtTwrz71SVl
X-Google-Smtp-Source: AGHT+IEaZG1tYIZnB0oNVKiYXU1ZYiLRf8+fKLhPsDDu1dM2yuGf9yuwIsDmiqn/vYXbvH4tcl00XA==
X-Received: by 2002:a17:902:8e8a:b0:267:9931:dbfb with SMTP id
 d9443c01a7336-27ed4ab8de0mr5090165ad.54.1758736254157; 
 Wed, 24 Sep 2025 10:50:54 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2699ae52db1sm186510995ad.43.2025.09.24.10.50.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 10:50:53 -0700 (PDT)
Message-ID: <fafe30f7-bdc2-433b-933e-cbf862ab4cb4@linaro.org>
Date: Wed, 24 Sep 2025 10:50:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/core/cpu: Expose CPUState::start_powered_off
 docstring
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, Max Filippov <jcmvbkbc@gmail.com>
References: <20250924174045.54241-1-philmd@linaro.org>
 <20250924174045.54241-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250924174045.54241-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/24/25 10:40, Philippe Mathieu-Daudé wrote:
> The comment about @start_powered_off is buried within the
> CPUState structure. Hoist it to the structure docstring
> comment.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index fb788ca1107..f88765e525c 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -412,6 +412,7 @@ struct qemu_work_item;
>    *   QOM parent.
>    *   Under TCG this value is propagated to @tcg_cflags.
>    *   See TranslationBlock::TCG CF_CLUSTER_MASK.
> + * @start_powered_off: Indicates whether the CPU starts in powered-off state.
>    * @tcg_cflags: Pre-computed cflags for this cpu.
>    * @nr_threads: Number of threads within this CPU core.
>    * @thread: Host thread details, only live once @created is #true
> @@ -496,7 +497,6 @@ struct CPUState {
>       bool stop;
>       bool stopped;
>   
> -    /* Should CPU start in powered-off state? */
>       bool start_powered_off;
>   
>       bool unplug;



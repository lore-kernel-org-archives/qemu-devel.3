Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA62E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwl5-0005hb-JI; Wed, 18 Dec 2024 11:18:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwkw-0005Zw-10
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:18:41 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwkr-00046V-OJ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:18:36 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so45379115e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734538711; x=1735143511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9fO8nMjzZFLc8R8WzCO9PefY3tpK9vwCpbuaZ4XFGiY=;
 b=R9sTHckGlKWUKRNUgkJeBDHqpeuV1pCZuczxPw1q4q5yXhLqwixqNbPGeaDTuQ3vQo
 mQUOM6WBEl3OFKBdXRxG7JACpz0tolnrwlLVKrCwj+7pc+sbyslagfez777OFSiNQZ1T
 PhxhzY0SlnMmuIbr+c+zQl5Z78jBbpjNqzVeaPJnuGRjxA/rHmS+9vBPB6AuRahyueH9
 F7mzYNDrXu/qCj4X1vVOTJrDYNgHggq/2HAhzAotC/EPDCWkbhIo83G67FE3bP7QetWp
 GikxWpnceQ+2+wNi1XDctyCB1buVM18qfy5rfKR03UGZoqPfoj51/SsB94PWyGIUB18r
 daog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734538711; x=1735143511;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9fO8nMjzZFLc8R8WzCO9PefY3tpK9vwCpbuaZ4XFGiY=;
 b=SGNUQIG5fy7P6y0a4NcM+uGA/6iYix621jHGQoUfJgiymGbJ8EjBxOVZlWBm1fiNE5
 HH7KPkke///9Zy0BQusK2h9TvjNRz+JUsKWX3evckOJ3yyY02b/9RsECuWO87BA6so+F
 Mp2qpdoWaf0v4FDn6mFE3zmBsd2390y7f6j9aEC02QR0LFFH2QCf3nxD19l/UHb0+gCt
 yW+KazHGsojwOABN+oUdtX7KCmWUVnNu6gDoewBPDjAnO4EqKWvmn56qq2syUQE2xaGh
 zZhsbA+/dvjN9G+udw0ZdrXjH4obYG0IBB+OHC5GQeJIHvcczEULOosdB+RyA2gV3RB4
 vdsg==
X-Gm-Message-State: AOJu0YyaIVMu1KH2mj1eSmMpQwIYg8Bynoi7suo3q/xfvZY4n2t5i9Vo
 a4HramCmpUuYYuGjdzGYBPh673it8fqs8mb6JDnYVGk2qDeMbGYwwyudwrytUzQeQob7PnFyaKh
 l
X-Gm-Gg: ASbGncvSJOIV0lOxlq3PhiYLhAxo1/eraR7g3iZEB0YjKA/K7GvJBl9UZcjUj4gvknG
 4MBwBnzpzczLT1bJGeF1rqIY/hAY3j3y15Q1K840ck4IKVXF4Eo+xl2E7fyJuwl0XJsmLM2iOuu
 0O7i/ajrhxm/BAOD7UyJDcxkzF8TUwdTxFyoOdn1lQ1Tv+cJoYO8UHSefuCyjEniTaQgdmDT+in
 gYiux/HB8URwCIE/Y5yXnsJt1y5V1fbrbM6/tPIryryCNz22Y/p8OQ3DiUMw+SmsmoSsJ1k
X-Google-Smtp-Source: AGHT+IHKmuvMJW7nt1Lc5C2c7tw2Z7JNAi6p9+cbthJj4Q2DIpLHipgLC7L9mplOXcKwdUSugJuFvA==
X-Received: by 2002:a05:600c:190f:b0:434:9e1d:7626 with SMTP id
 5b1f17b1804b1-436553f4992mr27309735e9.25.1734538711536; 
 Wed, 18 Dec 2024 08:18:31 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b015absm24745605e9.13.2024.12.18.08.18.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 08:18:31 -0800 (PST)
Message-ID: <027fccdc-4ae8-4761-907a-3810b8e30cbb@linaro.org>
Date: Wed, 18 Dec 2024 17:18:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/i386/sev: Reduce system specific declarations
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, qemu-s390x@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20241218155913.72288-1-philmd@linaro.org>
 <20241218155913.72288-3-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218155913.72288-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 18/12/24 16:59, Philippe Mathieu-Daudé wrote:
> "system/confidential-guest-support.h" is not needed,
> remove it. Reorder #ifdef'ry to reduce declarations
> exposed on user emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/sev.h  | 29 ++++++++++++++++-------------
>   hw/i386/pc_sysfw.c |  2 +-
>   2 files changed, 17 insertions(+), 14 deletions(-)


> +#if !defined(CONFIG_USER_ONLY)
>   
>   #define TYPE_SEV_COMMON "sev-common"
>   #define TYPE_SEV_GUEST "sev-guest"
> @@ -45,18 +55,6 @@ typedef struct SevKernelLoaderContext {
>       size_t cmdline_size;
>   } SevKernelLoaderContext;
>   
> -#ifdef CONFIG_SEV
> -bool sev_enabled(void);
> -bool sev_es_enabled(void);
> -bool sev_snp_enabled(void);
> -#else
> -#define sev_enabled() 0
> -#define sev_es_enabled() 0
> -#define sev_snp_enabled() 0
> -#endif
> -
> -uint32_t sev_get_cbit_position(void);
> -uint32_t sev_get_reduced_phys_bits(void);
>   bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp);
>   
>   int sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp);

The motivation is to reduce system-specific definitions
exposed to user-mode in target/i386/cpu.c, like hwaddr &co,
but I'm not there yet and have too many local patches so
starting to send what's ready.

> @@ -68,4 +66,9 @@ void sev_es_set_reset_vector(CPUState *cpu);
>   
>   void pc_system_parse_sev_metadata(uint8_t *flash_ptr, size_t flash_size);
>   
> +#endif /* !CONFIG_USER_ONLY */
> +
> +uint32_t sev_get_cbit_position(void);
> +uint32_t sev_get_reduced_phys_bits(void);
> +
>   #endif



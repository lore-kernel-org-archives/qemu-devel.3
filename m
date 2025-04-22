Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD0CC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 07:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u77q0-0004DV-Bt; Tue, 22 Apr 2025 03:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77py-0004DH-Pc
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:14:34 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77pw-0002la-R6
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:14:34 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39d83782ef6so4052639f8f.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 00:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745306070; x=1745910870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=loj4lJ9z+Sut1fgTFJkxr0bUG1sqQJ3sbVCm7mluYHg=;
 b=sbv/jXUqvvprhjwSfkBryYa/fYOZJfWLvg9dIc1Wk6KeXGBbV80GKH+R+aoHLeIpT1
 q/mLNl/IxT0hgua+FSmUveoejyiOYF1QbRnmKBo3QLxM2x6WtnTY7joEfJFoUUZNT1JX
 BfLgKwUG8iB6hpr9kdFILDVm644OVKqLlTEcfnkL0jp4vozl8nbOe64hekX/IBE2zomu
 FuBXRu8KgAUbHnsopsICS5xrexEUgg1fHztzCBsBgzJ8p9j+ZFqATwyoqS1h+R+shyiY
 ZRjAz8CwRUryswgxdnGLAh1ogd76uAtowRUjgEkc7ioVA8dIUdQ6EgySZkKyCW8Hw+6e
 324w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745306070; x=1745910870;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=loj4lJ9z+Sut1fgTFJkxr0bUG1sqQJ3sbVCm7mluYHg=;
 b=CNsucXpbwLyAk6Y9XTN6W8O5AFGWNogPW4Mzs3vjdjjniCN2Ae6JDpwdQ/jwwOB4QR
 lwZXlNUi/hWisBihHrN5Jg59sK3c+jdhrOjnmZnYEDyS2qZjFsbdzoJgipEZjkZnHs/Y
 iYFlHcqvKhqbFsgu4R0fvjxjEkzoZqgFO9xCAyrI06tuJI9T++WT4D4Uf0vgg7iAC861
 7gGxELoTUjuHDk3k8dilGsdflWJ9f/+a7lvdCwZr9Ux/jUR0/K3BdPFlDCiaRyCUA/d2
 yEF7Dzzxfro5fecxJqrrV4E/Aar5a5HV4xyZUouF/Ai5H5Tn+ho2gYwV+CKnaMQSEIXm
 1STA==
X-Gm-Message-State: AOJu0YzP92eGjkS/kbhewd8RLGAik1gUV5tGpQ4gnuLfuwg6STNR8QxL
 HijCQuAY8Vge/wgKJuKA8BcOZ/D7hylH6MYiKLfLU6eFikZo+5szlYx+b6PIDCU=
X-Gm-Gg: ASbGncsYoVm29lkRKs9dyOUPqYGewYv5KaAiGr4joccQ+3Pfq2Xi5jCegUyvllBRPSV
 d6SqA97JwIYpqUKyJyXZFtpyR1Q2SYtY/SGgwsYfudOtXKN73ekqYECEP3gyUWgzxq0A83CelHJ
 I9klnWLuhc5hCKw1p6z9AG6blnLzMRRyIWPZhenW2D8N5rSsqNNyasMCjuy7EyxoKsY4mle4UWr
 Q9qZFv9cWSgpbd/fdrLPL5FnKtFQXUNeVL9Rgel4fhoh/wKR99NbILKPk0kPUZQoK737t5t3ox6
 Ievekw5JTvrPagpX5et0M/VeAYDGa5BnA396e8tfGX8Bbf+CI2PNxx9IkO97nd6kydz5A+gy1/i
 H76YJz3XC
X-Google-Smtp-Source: AGHT+IHfUOH5c8TOJf6FjOsBNXgWKrvASi1Xsz/o2s/hKtdC8qa6AYMsrfnQPe3Oie7ffw32XjqE5A==
X-Received: by 2002:a05:6000:4008:b0:38d:ba8e:7327 with SMTP id
 ffacd0b85a97d-39efbd60d51mr11616743f8f.8.1745306070171; 
 Tue, 22 Apr 2025 00:14:30 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43bf20sm13956918f8f.48.2025.04.22.00.14.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 00:14:29 -0700 (PDT)
Message-ID: <5aaefba1-5657-4bc0-8e0c-e0474d694617@linaro.org>
Date: Tue, 22 Apr 2025 09:14:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] target/loongarch: Move function
 loongarch_tlb_search to directory tcg
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250422025742.2693096-1-maobibo@loongson.cn>
 <20250422025742.2693096-8-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422025742.2693096-8-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 22/4/25 04:57, Bibo Mao wrote:
> Function loongarch_tlb_search() and loongarch_map_tlb_entry() works
> only in TCG mode, move these functions to directory tcg.
> 
> There is no any function change, only code moving.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu_helper.c     | 146 ------------------------------
>   target/loongarch/tcg/tlb_helper.c | 145 +++++++++++++++++++++++++++++
>   2 files changed, 145 insertions(+), 146 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



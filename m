Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C2CCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBw9w-0003x1-51; Thu, 23 Oct 2025 10:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBw9k-0003pC-Kt
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:19:12 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBw9i-00081a-1z
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:19:08 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e6ba26c50so7425675e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761229144; x=1761833944; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uNStpY5nr/9G5oXEqf21az2A1xlgu/SibaQAuG2FqQk=;
 b=mUn+OpKUTqxPCVcqB0E1/C0+CGkBxsnyi3Sih5tW/Lx9+a9RD3/5TSCrYxEujf7blk
 AQEso9R/U00mt9t7uS6AP5xoi9fh03IyaPn7AkhwJL897CSnf3lVDjzcuooUaA0gzYb+
 sgaLEPPAZzHeakzUWx665qq7XiLcPXTtHoikCshqYsARor21qSfiB8HRHeenVjZizdOU
 S3jvrdOwY4N61oGHWcnhx923bRbd7UqMQqO3JrYz9WTESf6eCZG43i1U8NLENQjK8MYJ
 1Q8Ef3zNegkl/IDHLSHI/POAOO3x2sCaOzECV/sPDbqfgWRqrvx+MktFbEQkEkoKAHB2
 i+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761229144; x=1761833944;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uNStpY5nr/9G5oXEqf21az2A1xlgu/SibaQAuG2FqQk=;
 b=f2rjsMHoQyCpzQPrigyC2CxNofSR8iWLs4eJZlaILBlkPkK9uPfMVRGmR6boeLQmru
 8w533m88XOxoE9olMPBZKV+FPhm8AFYlknvXVySzEVn2PB+Z/7HQ0LpW2dr1iCEisI5j
 CwxdUGiczx032n2wtjXSeiy35jdHrnsg52/nc+3Jdf1ttvSI38I+R3cOYb6qepynh41V
 x3XmcK43x0x2hDZ5ImtPy0E8NxSD5V0QysjL2EAtivuA0Ev8trsYu09eh31l0woXeujg
 RRF5FzeXx6yu5F267kzZSeKi3flIUnML+cQvq/4tqqCXJyH4SsT4XwNE+wkKd4hAZdIJ
 4I5Q==
X-Gm-Message-State: AOJu0YxWeZc9Ph7vwJxI0YTmTvtpctZAst3nlfibkyiGEf+YJVqa950L
 fpwNmjsuiWpTINS3pRDEaBlJQsSHWBbGMvhGC/BcRfxmDy7Uly1ZV3Ju07wE587TliC907LG4SH
 B93Si8uE=
X-Gm-Gg: ASbGncuvpE/pxK1iO4ue71EtK2cLO75VQZesiFh07swG6k7TYb1lJD8NIH0gbPQGKKR
 4HQ8w//R+uP4W5gLc/B8LMfKHkJLMVHvtmBlabVpG18bnUIhrsS5xoikO1LzeSR/T66QMh5p+Rh
 Dhu1z4y7u7KGkIz+1vIO9D4YUPrPL/5JIH7xscqeetT0pxo4RKXUqMf5eW1sVOW025bFyOiMvGP
 GpOamrti5esRVET+IjoQeux0dNG1aKRzKTQHzlbmkwGsGE8GNTGPQ6LWKiit0EKesojZ0B2Cop+
 aPv9DOUnQfTygrbdiXYgSl32zcDdCDB8ll0AKAZA69YYsMpscWl/78f6jl2WFRH8nvh7tkuxYMm
 Vu5lz29fLb66UVqzwp+ejV00qcUqMVeZ/ID/3mJMqhtGGKEi+dcUP+7JlnFuhclyPw3FJPkzT7q
 mGvSQHSobWtKun8oKbHlVYh/eoK0Wqecxf/UY4YWzUWbM=
X-Google-Smtp-Source: AGHT+IE5LrytYJNMBIK+S2/LCUFRjoXd/jYMJj6BFrDC1ce/40F1qLx6g1n4JVjq4qQ0PSjta64ozA==
X-Received: by 2002:a05:600d:416b:b0:46e:45f7:34f3 with SMTP id
 5b1f17b1804b1-47117874b06mr197294625e9.8.1761229143750; 
 Thu, 23 Oct 2025 07:19:03 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897f546asm4163616f8f.15.2025.10.23.07.19.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 07:19:03 -0700 (PDT)
Message-ID: <c5788f4c-1d03-451d-b31e-28962060f54d@linaro.org>
Date: Thu, 23 Oct 2025 16:19:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 35/58] target/i386/hvf: Use hvf_unprotect_page
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20251023114638.5667-1-philmd@linaro.org>
 <20251023115311.6944-6-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251023115311.6944-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 23/10/25 13:52, Philippe Mathieu-Daudé wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/hvf/hvf.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDDAE93804
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 00:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC5H2-0006w5-2B; Sun, 12 Apr 2026 20:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC5H0-0006v2-RW
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 20:35:30 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC5Gx-0007G1-Ey
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 20:35:30 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-82f138a6d5aso904578b3a.0
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 17:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776040521; x=1776645321; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J9KxxnuJB3942Z3pfrfnnNG+j3dmF8CcUQlJBKYaZeA=;
 b=BSGPXTQoJqMbYuwWi9EEDPI8jphmt96qPMsv0qtqwqJtbhIpkqHGxRgIArWcZbjPjC
 TJdE5kzvHORKz7hsi2RbXdJ4kvEV42wyu37paQ1PEY9Edj7zm8zu8aS6oG7uHuaiCYUe
 mtEeHnDztNmJ3gZ0IraqHaMGwqIjcrG7uBIl5DjtGaOVDbJOY7A/GBaKrTnhzb6re2pQ
 xqMQdGps9zfbcHsHl7F4Wo25v4q9fa2qEUUq68Cykwz2oFSWD7YD5w/5sYXiw72RGvfK
 FhP9HRn6RnX0pWmLOEAZVPiUivYtpZQ5/BgPMjbqCMWpEOQCA20R65+RJPvIjyeuoFvD
 7eLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776040521; x=1776645321;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J9KxxnuJB3942Z3pfrfnnNG+j3dmF8CcUQlJBKYaZeA=;
 b=Dda+5JFdLMN/QVNx766nL5DUOlx1VQcSE6jJaYM+Bcp/7S+sszKBtg9QtLH8c5OCuj
 RJOI1oNFQVaoQZDFcpF+Tj9OIUk/fDwGCBRK/CvXURBjFlFimJeRjqWYIjEsq4nE8QUK
 Wx1Kmzn0n+FVSa3w2fQOrLbAAMfDws/G92wBJQHFz5IsZqJsh0SY3gqvMTHrHPuaPN3C
 B9UkRie7O77ZBMTe7wkJ84KPnAYTnNuExFFr0hEtVQSmQzlYiSQTjfaqPFpI05m3TiZD
 c+W0LCDulfpOhHH7DavY3veeZH7cNCeQNptM8EykEkwPVth0sWa6CWtuHBX+LTzR5apf
 Mirg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vMQGgSSAFDgLRJxABVXGOTllayrJzHI38yBam0bUM8VamwWWi/JQLARfRCh5BlR44RPn+bT9+t49k@nongnu.org
X-Gm-Message-State: AOJu0YxaPKSxxRepkoRooq6iRv8tdvQi/5/X/efSzz2tYUeKLouHwICq
 sde6QRednd/HsTwsS0dwZW5U2LJhAIxY6hnUC5RmSWeY8l9Zseo7z6thoFJIc4RnBVQ=
X-Gm-Gg: AeBDietyh5c2j0FghiH/TGai/0bkWpg4A11kVwzx9oR7QUXiTXNlmAMREgazmJ/Pixc
 C2HD9NYAb7uBHtBfjjSRxmcm3ywOIWCceXfNH7mXtUa7731T59zf0ntnnO7zqdNjFvvXe7LWL1O
 BRNarWbCGXjYQnB65Cox35RksKj43SVnL3YTNrej/ca/hVNlaShXU1IGGO+4n5IKPA7zkuYig+d
 0JGS3+7QnauTH/RCNgpDFmttLuwCYBVN/e1ftOPzLnIRQ4fYa/FUWeyXyC3yCxw9BYsl26p4rPL
 Hm5hqel+VCmh8x58rcmJdouNk2+AXSToJ1BHYPMZKGot9x93A1jkZTpxkRYen41AIOtF2DVrDsC
 seS17bjvozyTCVTphmsM/Ny4TRBzoQ0gRv/iUwWD//GPZ5tzw0oJzk6oW568VYv5zQG2+cgddE5
 MKxvhrMQ6MJA2guNY2aR0ocYlJt4NSRbx/w6OGO8CAhZ9Ks9WKLTC+uivXg3lSFUOi6Xetq7WVO
 E/567gWfwl2Ew==
X-Received: by 2002:a05:6a00:e1b:b0:82c:e60c:f36d with SMTP id
 d2e1a72fcca58-82f0c3e7d30mr11668177b3a.48.1776040521088; 
 Sun, 12 Apr 2026 17:35:21 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 ([2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c500415sm9194752b3a.51.2026.04.12.17.35.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 17:35:20 -0700 (PDT)
Message-ID: <b64e7832-871a-4410-b4ac-6822fdb03a91@linaro.org>
Date: Mon, 13 Apr 2026 10:35:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpus: Remove CPUClass::init_accel_cpu() left-over hook
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20260412212547.29645-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260412212547.29645-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 4/13/26 07:25, Philippe Mathieu-Daudé wrote:
> Commits f50d0f335a6 and a522b04bb9c ("target/riscv,i386: Remove
> AccelCPUClass::cpu_class_init need") removed the last uses of
> the CPUClass::init_accel_cpu hook. Remove it as unused.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/cpu.h |  6 ------
>   accel/accel-common.c  | 13 -------------
>   2 files changed, 19 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


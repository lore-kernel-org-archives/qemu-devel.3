Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD2CE77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 15:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVuqT-0006Hn-CR; Thu, 09 Jan 2025 10:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVuqR-0006Gv-9P
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 10:53:16 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVuqP-0002Sc-38
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 10:53:15 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21619108a6bso18018915ad.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 07:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736437979; x=1737042779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PxAYVqsb6CEaTqgp8MsnpCsVpeTXhTf0kuyXHkUfDRI=;
 b=TQ4dup5Z6K7iCEp4Xk7qrzd1mQuN3m7/9hSoP3hzhrFImc06Xb1yI3B4eWAwzwADaZ
 YP6a2PgN0xC7Q07ArDcAlS3WCxbxPJjYU/ZqQxgvzKtfEDVti5Sj2mui1r+C/U3xJ8v8
 eZMDGjg394GruVIqDxYhNaW0sQv+6AR4dA5zxbHM6MIhJXETGkt4sWIRM/RfzREyyUie
 thCdYgFeL/C7np6HmTFggyXlwqQRgsLlvdjbTzVUFuMrTnQcw6I1sXkCAR7FBO1KntKJ
 3cdzB1P4mklrgpZNE+PKwpWATzxlw2KOUQqNqgVkQRBvjVOfEo7pBHQyy+QbUkgCnk7j
 Jspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736437979; x=1737042779;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PxAYVqsb6CEaTqgp8MsnpCsVpeTXhTf0kuyXHkUfDRI=;
 b=tbbBKhSdee95JRjh/hvHpPnOd3cFpzlS+o1isLUNKL9EqEIVWfnEC5DJSlWhS7JODF
 dhOge7D1IvO9QCHtdHaMhAVoqgWVHnS5Jrt6gjrW6JEvIyQrDLgTp+smTTkCKepPvxSc
 2e+lePYeU/PSAGO+FOx4cuKciwSx5sYSQG6jEe9JhLPSNBFe8J3fVeVQIZYJsp4p5aFI
 gakwBop+4cHUYk5CBuSGcgHEjU19jaMnQqY9l4sqS9kMCFwyZpzTqiFZg17akQfLrdoC
 Egmqiug+P2jfK6K+n750t2du5f4UlTjk0FT1k3gn1VgVmL9+N+PtyV1nBXvFGqOFUfzb
 cM0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUokL6HCUifcRHEpbxEfrl0KK3WbZQNijh2HRTJ2fJwzPgol7tVdoXwDr+4WEGoKY+kyk6ZcBDP2deq@nongnu.org
X-Gm-Message-State: AOJu0YypK0WIFSXSxjhsC8rqiki3zlvNRHF9efuL1wiJXxDTEjLhnOVt
 6ro/3NolMCzaiPJk+pxcJnmqIuMhrsHge5VV659xI4E1/Q4LrWOZi+8Eo+Mop/Q=
X-Gm-Gg: ASbGncvFo/DxTS9FgKefQ5PSP2ltzZQBOdFBqdi1Zr6w3tN0WrQElWyMtW2vEFcDX/q
 OqY1SlQRUMdoU8E0SNvnxLD8G9RtE2SYghl+aQofOJ/kq6To8i+HnPbFcbPSktBn8T+v0GzyNcO
 wAWOPSiX3TXowWUEO9VLY3pPYud1h8fDUfxQ9CWGFq+rfIPpr0Z/0/89x9XxGMbhj1Sky0rlDCI
 36YckBdkedDvhx2EXlJ2Of01apiRuDOa5Y4iv0iQU0TBNHHyAdDrs1fXrqoRmMxQmHr3nDn0/D/
 Iju3JbURTtxTVRt4jLnHYACPBRV7sCI=
X-Google-Smtp-Source: AGHT+IHQjcldgX0DZNit5JPivzfCzlptEglN5Bnzb1QHZUk6LJgG3GWp0acE09IdB8Gmt/g6vCATmQ==
X-Received: by 2002:a17:902:dad1:b0:21a:8716:fa97 with SMTP id
 d9443c01a7336-21a87264051mr78793795ad.13.1736437979149; 
 Thu, 09 Jan 2025 07:52:59 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a91766da1sm14415255ad.46.2025.01.09.07.52.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 07:52:58 -0800 (PST)
Message-ID: <1612c0c9-7c45-4bda-a977-8b7cd51ee0f9@linaro.org>
Date: Thu, 9 Jan 2025 07:52:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/cpus: Remove pointless re-assignment of
 CPUState::halted
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Song Gao <gaosong@loongson.cn>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241230153929.87137-1-philmd@linaro.org>
 <20241230153929.87137-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241230153929.87137-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 12/30/24 07:39, Philippe Mathieu-Daudé wrote:
> The CPUState::halted field is always re-initialized in
> cpu_common_reset_hold(), itself called by cpu_reset().
> No need to have targets manually initializing it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/misc/mips_cpc.c        | 1 -
>   hw/ppc/e500.c             | 1 -
>   target/arm/arm-powerctl.c | 2 --
>   target/hppa/cpu.c         | 1 -
>   4 files changed, 5 deletions(-)

This is a behavior change if cpu->start_powered_off.

I think it's likely that "start powered off' should not apply to warm reset, and that 
otherwise this change is ok.  But I think there's that nit to address first.


r~


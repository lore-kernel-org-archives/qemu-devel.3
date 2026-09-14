Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF26C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 01:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5vHi-0007Md-N4; Sun, 13 Sep 2026 21:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5vHg-0007LX-VK
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 21:15:00 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5vHf-0006VQ-DT
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 21:15:00 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so1631563a91.0
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 18:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789348498; x=1789953298; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qha8O7fIOACIdoDr+4f8rnJzFRtc1DQGdGU3sMCG/uA=;
 b=dGelAsmSfuWkidfDddWI78X2+JTD2AE8etn9Fo+qgrgAJNd0OHDfXYTkjWiUrffTjE
 rAebs+RLp4EjPJE8+zUjJCXrH/rvtFOi2xci3MTpoCUaUAxaUKn60WjthI2FRY9JCrtR
 DoaJZbbk8Tsggg3FTgodx9cX+UKUCLsRt1xFQlo0CeKiXKaMrsRMB6lBnJIFfd2ZyERB
 fMkdJ621TSKyQMDTEWJxGJKe6TUz/LwyANyNPIdr0qBe2GSbbOc6tggJ8+nmNQqueLwI
 WRvn0VbpBiWgOsebKk/g8YAODr4s+ydSYdGH5wVxykHCrb1NYWIn+ZynMhajhA+aCxQG
 WF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789348498; x=1789953298;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qha8O7fIOACIdoDr+4f8rnJzFRtc1DQGdGU3sMCG/uA=;
 b=jVVp/++NyzqNDmt5kzHhI+l4VmD9PkHqXh5K16HixXLbxgqPCtznjRqWpI1/iekaup
 AdkkB01yX5hHzpsopI/Z6ffP07hcgW5+4WwzBluT3ngWn4ZmdmgNnBpNHsXJyuMfO6I+
 0rrUo8vu02mWCX7oM0zQjcAknnnuWlZvpyi/I2y68DdhXIEUcX2503Beyvwq9EhgjLZN
 oxGlJwghH8G4rqQ+TeGTC9Pxi44U4EZXyBlP4youG0wAmlt3LX2jtyRSXftEyjTmYL5f
 ZyuZnhTPtGIrTWFJnW92YjPE8YONkyZ87cKO1eVwpHKoFnqf3PPpGpX2CWTFcviQou+6
 vsow==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmQKGbKmABXlq/M7pyMk2XId0IxdpgcRwCnIFt/S5VGOuxH6r01E5tRh0BcZgaVTBwiN17DRlJMvJd@nongnu.org
X-Gm-Message-State: AFuF++me48OxgK9G+nF9mtWn4uNG5CCRa7CSFxniuVgYT7kJWVOdPP4K
 rWrGw6OiKcWY1tKbUYElrVkKBJTqLJ7RKTbrX0MB9SkTrnMCqngHb9F7/Aa/cocESZc=
X-Gm-Gg: AYBFou1Z9iwaxI3Eqo0wNMAXykuiOoxfb0LED7UQUu9MsI6NKlA730HW9I0Tk2mMH70
 FXLJw8f4UrsknDEB0lNtV+FqYEgpgfWQL9z9UuV7u7mvO5R0OLWaZ97E4M3rlYSr5IJestNc52t
 rVwPzQtqWhRnLHx4PMZDNW+XIp5cM2J8K8Yz2eHplU3e9cd3pRFAPNCvUOhgQf9FiyuV8uYwUyA
 GUGtrWT/cWAUM9H4DX5X7QITdfyyAvp9Xml9IRcjGDW+4HeoMrxMu8IIsu4VcqvaOB/PbsHaOjY
 qogPnxU09qnjo/yeTueMkgkFP9zQkrsI3A677ihhPMd3vXawZHASht3KT0dHdG1N+dYW43jGsqh
 r5iQv7oafZqtmMGWP+0ssdSKIX/ZTEGPDKocmOn/rzNSdkMh918adq6r3MA6dJcUQhJOLTCipYL
 0Rb8s9/k9OTDUXyOKArC+B2KjF/sjeMsq0QU75Ts3ihSmq4B8IZKN0AVJGfQ6V6+PdG7tmCbtzO
 4rcp/3cWZuTapW6PNfoRLuUyIXYZyEvPCqByE8HVYLhZwPBoQu2WZp0k8oikw==
X-Received: by 2002:a17:90a:1c8f:b0:39d:ec24:5ffe with SMTP id
 98e67ed59e1d1-39dec2460a2mr586188a91.9.1789348497592; 
 Sun, 13 Sep 2026 18:14:57 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:1665:91c0:9a80:f870?
 ([2603:800c:7900:ed00:1665:91c0:9a80:f870])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4efc398sm26937961eec.19.2026.09.13.18.14.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 18:14:57 -0700 (PDT)
Message-ID: <19735ac2-9357-4d17-847e-672781539b0f@linaro.org>
Date: Sun, 13 Sep 2026 15:14:54 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] target: riscv: support TLB page flush for
 sfence.vma
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
References: <20260904-riscv_tlb_page_flush-v2-0-defec3f29312@baylibre.com>
 <165fb72b-3cf2-4693-88e4-f9d36c5c498d@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <165fb72b-3cf2-4693-88e4-f9d36c5c498d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/7/26 03:14, Daniel Henrique Barboza wrote:
> Richard,
> 
> 
> This tlb_flush change is giving a +20% performance boost in riscv64- 
> tuxrun.  From
> this:
> 
> 23/23 func-thorough+func-riscv64-thorough+thorough - qemu:func-riscv64- 
> tuxrun  OK   92.71s   4 subtests passed
> 
> To this:
> 
> 23/23 func-thorough+func-riscv64-thorough+thorough - qemu:func-riscv64- 
> tuxrun  OK   73.45s   4 subtests passed
> 
> Other tests weren't that affected - I take it has to do with the amount of
> sfence.vma being issued.  They look fine in my own testing with an emulated
> Ubuntu host as well.
> 
> This is all fantastic but I wonder if we're missing something.  If you 
> could
> please take a look at these 2 patches and see if we're handling the tlb 
> flushes
> according that would be terrific.
It looks good.

The only possible improvement would be to avoid flushing the PRV_M 1-1 
tlb, using tlb_flush_by_mmuidx / tlb_flush_page_by_mmuidx.

You could also rename MMUIdx_M to MMUIdx_PHYS and use it in modes other 
than PRV_M when the mmu is disabled, simplifying the test at the start 
of get_physical_address.


r~


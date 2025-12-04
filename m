Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163DCD2CDE6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 23:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRJ8S-00017i-CT; Thu, 04 Dec 2025 18:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vRJ8M-00014C-0V
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 18:53:14 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vRJ8K-0000qZ-9D
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 18:53:13 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-34585428e33so1561106a91.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 15:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764892390; x=1765497190; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FMkjvCbStvijs/DL1v0dwSw8xMGkRB84PU9HL0/Qnzk=;
 b=YsJVHqrm8F67ypZmiaJCe5E8m4uN5QVJ6piBlozQsw+G2k9St45HQyrctvYv0gef65
 wJ5ImvVtDAovDwcprdpeknxpK4OQdDn1LTumKRe29f1ZRx0NLmbYFiA6JldpHDDIt2/p
 2k2/F9K6IVSbZNAM52t6UE2XtVuXxoSLhoxqiFnuNEI8y+v91VApSxwS4f+1UDwPIPPU
 9yLqnC9/hRZzZ6XIDXH42+Wrnpnh6KWiTECoSWfXq5cDeqOPVxJdVpuUSvpZ34NlbpjX
 wN3PRkmip4A9uEPb/vcyn449PYkcelhm+UqpdT0Wa27lF2kwxjhiwDMWD1gX2H1ORPrI
 D/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764892390; x=1765497190;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FMkjvCbStvijs/DL1v0dwSw8xMGkRB84PU9HL0/Qnzk=;
 b=b3Yc1qEolCPzYCdLWcEHP5qvQyDVWstmqdLC3cDlRVQ4EhvZQSdTK+SPwX+m9MqE+Y
 u8HXVfxNhNOXbJv8xmue4VId9mpKuO3M1ccA/rxxm7rKm/OSkHGXkvPvbbTHnNR/rFYX
 NH7ug1/3o0bt98rtO6iYnc4fR3yCkjpU0LxsOVVPIF1V8pFI1A6ePy2sAH64iZsUBlkW
 /xiK0LL8UAIf3gfc7HHNM1v7FUoNX+LreFu3bM9mLwaQdyV1bOBlwpY6rOVG5PPTXHGC
 azfRxE+bthgyrAjoQEvoDKMod3DgdhZJKh33kRukTZNfN/NcxppN6oFf+8k0+OgFAFk3
 coRg==
X-Gm-Message-State: AOJu0YyT2fZU5T0ume245KLWAj+Qoj+NIvmSZgd5PAXqPSqxoOqAA+gX
 g056ncyVVq289/PH0nBH8MyxgSBON80hK28fTyhWtFa1K5qa2BQTLn3D6oa95tHF7Ro=
X-Gm-Gg: ASbGncuN4t0vg6BUMPiAt3JWSbiug/O8WcsjAGXl0735v453GHZAvRAwx1zmRq9a21o
 /awYFLQUJ1YSzoPDzVsHd2h7gvMUKu5aEkuZYZIDgM3nTI7Z1yGTEuV66FUb/Hm3AhT1zbvbE4l
 XIYXBogJCPSmwPMIP507U8vERvtdCfcUpcraVjLgJO8NzepyqxuNvgi+2idG+BT1Sh67ffHLVOV
 EMyeffU20TFen9eBBcBKgo/p3SEuXN3kEA2Ix9lmRDOibm4u/VPo4tTzGWUoBlp11Dp5/UwXtLB
 ybuDrVMEBXbW5U10f73jRTxE9kKwYyRVa/xBBhx1IUv3P3Z987qZOssULf/EsQHg7IsI31A676R
 C//eVc5wAdnywxNAsxtqTozlRERk1C77GKXSQHAC6T3LCmEA/gA+//0RjosMKI/CbSOs8OvzSCG
 FhfjoozFPMrRWyBA7RuoVc9AuV3ZLxX0ar16pxAjELKl2Z7h/xPkVnc2k=
X-Google-Smtp-Source: AGHT+IFLw/UmHSqtEtuj6ykoNuGoLjYc+cFsbjxXfedXb3X4N7XpUF5w9upjLcg2/WoJ876pPMtEzQ==
X-Received: by 2002:a17:90b:4a90:b0:340:9d52:44c1 with SMTP id
 98e67ed59e1d1-349126d7e86mr8712802a91.35.1764892390423; 
 Thu, 04 Dec 2025 15:53:10 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3494f5b94cfsm2838032a91.17.2025.12.04.15.53.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 15:53:09 -0800 (PST)
Message-ID: <9b2c0429-a8bb-4df4-ad95-492f463cf29f@linaro.org>
Date: Thu, 4 Dec 2025 15:53:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND v5 3/4] tests/qtest/libqos: Add SMMUv3 helper library
To: Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251126154547.1300748-1-tangtao1634@phytium.com.cn>
 <20251126154547.1300748-4-tangtao1634@phytium.com.cn>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251126154547.1300748-4-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

On 11/26/25 7:45 AM, Tao Tang wrote:
> Introduce qos-smmuv3, a reusable library for SMMUv3-related qtest
> operations. This module encapsulates common tasks like:
> 
> - SMMUv3 initialization (enabling, configuring command/event queues)
> - Stream Table Entry (STE) and Context Descriptor (CD) setup
> - Multi-level page table construction (L0-L3 for 4KB granules)
> - Support for Stage 1, Stage 2, and nested translation modes
> - Could be easily extended to support multi-space testing infrastructure
>      (Non-Secure, Secure, Root, Realm)
> 
> The library provides high-level abstractions that allow test code to
> focus on IOMMU behavior validation rather than low-level register
> manipulation and page table encoding. Key features include:
> 
> - Automatic memory allocation for translation structures with proper
>      alignment
> - Helper functions to build valid STEs/CDs for different translation
>      scenarios
> - Page table walkers that handle address offset calculations per
>      security space
> - Command queue management for SMMU configuration commands
> 
> This infrastructure is designed to be used by iommu-testdev-based tests
> and future SMMUv3 test suites, reducing code duplication and improving
> test maintainability.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   tests/qtest/libqos/meson.build  |   3 +
>   tests/qtest/libqos/qos-smmuv3.c | 731 ++++++++++++++++++++++++++++++++
>   tests/qtest/libqos/qos-smmuv3.h | 267 ++++++++++++
>   3 files changed, 1001 insertions(+)
>   create mode 100644 tests/qtest/libqos/qos-smmuv3.c
>   create mode 100644 tests/qtest/libqos/qos-smmuv3.h
> 

...

> +
> +void qsmmu_single_translation(QSMMUTestContext *ctx)
> +{
> +    uint32_t config_result;
> +    uint32_t dma_result;
> +    bool test_passed;
> +
> +    /* Configure SMMU translation */
> +    config_result = qsmmu_setup_and_enable_translation(ctx);
> +    if (config_result != 0) {
> +        g_test_message("Configuration failed: mode=%u status=0x%x",
> +                       ctx->config.trans_mode, config_result);
> +        return;

Is that expected to silently return if we can't configure translation?

> +    }
> +
> +    /* Trigger DMA operation */
> +    dma_result = qsmmu_trigger_dma(ctx);
> +    if (dma_result != 0) {
> +        g_test_message("DMA failed: mode=%u result=0x%x",
> +                       ctx->config.trans_mode, dma_result);
> +    } else {
> +        g_test_message("-> DMA succeeded: mode=%u", ctx->config.trans_mode);
> +    }
> +
> +    /* Validate test result */
> +    test_passed = qsmmu_validate_test_result(ctx);
> +    g_assert_true(test_passed);
> +
> +    /* Clean up translation state to prepare for the next test */
> +    qsmmu_cleanup_translation(ctx);
> +}
> +
> +void qsmmu_translation_batch(const QSMMUTestConfig *configs, size_t count,
> +                             QTestState *qts, QPCIDevice *dev,
> +                             QPCIBar bar, uint64_t smmu_base)
> +{
> +    for (int i = 0; i < count; i++) {
> +        /* Initialize test memory */
> +        qtest_memset(qts, configs[i].dma_iova, 0x00, configs[i].dma_len);
> +        /* Execute each test configuration */
> +        QSMMUTestContext ctx = {
> +            .qts = qts,
> +            .dev = dev,
> +            .bar = bar,
> +            .smmu_base = smmu_base,
> +            .config = configs[i],
> +            .trans_status = 0,
> +            .dma_result = 0,
> +            .sid = dev->devfn,
> +            .tx_space = qsmmu_sec_sid_to_space(configs[i].sec_sid),
> +        };
> +
> +        qsmmu_single_translation(&ctx);
> +        g_test_message("--> Test %d completed: mode=%u sec_sid=%u "
> +                       "status=0x%x result=0x%x", i, configs[i].trans_mode,
> +                       configs[i].sec_sid, ctx.trans_status, ctx.dma_result);
> +    }
> +}

What is the reason for batching operations?
We are not in a performance critical scenario for running this test, so 
it's probably better to have distinct calls to single_translation.

...

For the rest of the patch, which is quite consequent, congrats. It's 
hard to review all the setup phase here, but knowing it works with the 
current smmuv3 implementation, that's a good proof that it's working as 
expected.


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F122ECCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 15:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDPWk-0007AL-F4; Mon, 27 Oct 2025 11:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vDPWh-00077d-LI
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:52:55 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vDPWU-0001R0-5e
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:52:55 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so3480123f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 08:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761580357; x=1762185157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ogXZxyzPaxjWuprtWPOLHF5wOuMHCIeyn0aJmTaSpoA=;
 b=FB9Lc03R2CZYzz23hLOsviCEys8SNdVAfMl/t7ZXsdBWGRgXs5wLNvmOgHbMEmoQh+
 E7Oj1TlizsfdcLPOychj7OtlnXchvhoSQJ4cqDg9WDsw8nH0o37DSzdX3eH8y5QVD2YH
 0sMnxNjkZLfGH2GIokGqRPUuCrfViu7UBtJ34sdiJiSj+PazOGVv0j9c2ioN2tC2RRmx
 8TCy26X4glmN/bZNhg5OwiaMe95V/QuTy4IiVXW2NMTS1+YyNsYdKinIAln2grIqBklt
 dg10dD97ANX1t+jiLvb8KNbuIrLBzRZVHxApJRonGtPd5oCgynEAAuYDIFMy278XXkG7
 RQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761580357; x=1762185157;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ogXZxyzPaxjWuprtWPOLHF5wOuMHCIeyn0aJmTaSpoA=;
 b=Orbs4eg6f+3ZZ8EvwnBUmcliIhxBkcqz1o9LdxxYrWmK+cAxXM82XZXgJLFYdw451N
 MmaOc1eixOmHpCSKFJCt+oM/+g/m1qMag1f8U5cIPLO5GJXXhG+ctnFE71zYrKg2sMNQ
 cx1OsGITSs63OpoTbNcx+LmGmp9NjfKrshs+JUeKS494h+NYhN+K/cxJChTfYRJ20po3
 Ntyi4qGtEco9M/6v6amtpjaqOe4QnjQk3qdOjX0hgv/MVs/h3Y704vUr59JNIIrDuOM8
 Sdp5QF4zhZs6fHiqM4ijmDyEcJzvZ7u1B75x3CwhaavDrXPgebE1FSLioxqzieLJmoSW
 iEDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX87BJBvBvFKeSk0uzVOtC0GKvtAmg5n3bs7rOXWrYDHD5YGaxKFKCUk93hcm1rMvu+Wn8LPwHYz/ma@nongnu.org
X-Gm-Message-State: AOJu0YwkKj07IZcGKpqkHH8fxkyH0Ka0nh034S6lrG5CJuFaPSBm66FF
 3zDLmfobUH/om7H80QH8lJTw3lsye8nJrmuC2BlM0ZGDrtitVOSeCpM4TNp5aaTmZ/4=
X-Gm-Gg: ASbGncvWz39Pko5+mIO2l9mHsv8isbY/4ZyTqNGjtsGJePQHhwxaayHhujCXNZ5UmC8
 Vhw7rdJAQP6w8xmkjjsweTJYmfQzq7Uiz7fZW6JXQq61WRsi8A8F/sMIiXHheLXyZQz7AiwMt6r
 ABwegeo4kz5ihQ9CiKAShoEdKornh57KRUbGnrgdRE4DhxUVgRKSsB74mgNovcsTOgocUFThnuS
 jeGpI6Smnh2KVfiKdWdOBcW2sp1cMvc+nIKRsPjPQESe9cr8h1YbbZABQTx8nLjUzL4h34l79d9
 XszTOb2EoPuRkIRPU/rg9j8fdN8v6yRGoBswnQBrv4fGjBbzld1dNQLHtUCLY9Alu1JxJX36Jpb
 eYJAJYtYvd0bYMyGRu5+aQA+v91OhdBds0GXExGYBzxpQMt6IE1gCLUMgHooEjLif6sa7jf1cnE
 kcrQANFeqQkzoHZXmwFDpM4xu3sgjdux0RqUGt3soDn46yghDdnmiuo6Y=
X-Google-Smtp-Source: AGHT+IFJ1rYxb38BcPzvJi4w2kIpfoHD2jfv8K/V341TSmca0B3jWuLres9cuJYCpfrHmw37/t8szg==
X-Received: by 2002:a5d:5d07:0:b0:427:652:b7ff with SMTP id
 ffacd0b85a97d-429a7e91e75mr149714f8f.60.1761580356742; 
 Mon, 27 Oct 2025 08:52:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:404:4d10:9f16:e9b1:dc97:28e6?
 ([2a01:e0a:404:4d10:9f16:e9b1:dc97:28e6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d5768sm15340127f8f.24.2025.10.27.08.52.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 08:52:36 -0700 (PDT)
Message-ID: <792a06cd-302c-46a5-997c-026cb67f8f2e@linaro.org>
Date: Mon, 27 Oct 2025 16:52:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 2/2] tests/qtest: add SMMUv3 smoke test using
 smmu-testdev DMA source
To: Tao Tang <tangtao1634@phytium.com.cn>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
References: <20250930165340.42788-1-tangtao1634@phytium.com.cn>
 <20250930165340.42788-3-tangtao1634@phytium.com.cn>
 <87jz0lnan1.fsf@draig.linaro.org>
 <ce64f4a2-75a0-442c-a26f-7391a378e8d0@phytium.com.cn>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ce64f4a2-75a0-442c-a26f-7391a378e8d0@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Hi Tao,

On 2025-10-27 16:26, Tao Tang wrote:
> Hi Alex,
> 
> On 2025/10/23 19:02, Alex Bennée wrote:
>> tangtao1634 <tangtao1634@phytium.com.cn> writes:
>>
>>> From: Tao Tang <tangtao1634@phytium.com.cn>
>>>
>>> Introduce a bare-metal qtest that drives the new smmu-testdev to exercise
>>> the SMMUv3 emulation without guest firmware or drivers. The test programs
>>> a minimal Non-Secure context (STE/CD/PTE), triggers a DMA, and asserts
>>> translation results.
>>>
>>> Motivation
>>> ----------
>>> SMMU testing in emulation often requires a large software stack and a
>>> realistic PCIe fabric, which adds flakiness and obscures failures. This
>>> qtest keeps the surface small and deterministic by using a hermetic DMA
>>> source that feeds the SMMU directly.
>>>
>>> What the test covers
>>> --------------------
>>> * Builds a Non-Secure STE/CD/PTE for a chosen stream_id/ssid.
>>> * Primes source and destination host buffers.
>>> * Kicks a DMA via smmu-testdev and waits for completion.
>>> * Verifies translated access and payload equality.
>>>
>>> Non-goals and scope limits
>>> --------------------------
>>> * Secure bank flows are omitted because Secure SMMU support is still RFC.
>>>     A local Secure test exists and can be posted once the upstream series
>>>     lands.
>>> * PCIe discovery, MSI/INTx, ATS/PRI, and driver bring-up are out of scope
>>>     as smmu-testdev is not a realistic PCIe Endpoint nor a platform device.
>>>
>>> Rationale for a dedicated path
>>> ------------------------------
>>> Using a generic PCI or virtio device would still require driver init and a
>>> richer bus model, undermining determinism for this focused purpose. This
>>> qtest, paired with smmu-testdev, keeps failures attributable to the SMMU
>>> translation path.
>>>
>>> Finally we document the smmu-testdev device in docs/specs.
>>>
>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>> ---
>>> ------------------------------<snip>------------------------------
>>>
>>>
>>>
>>> ------------------------------<snip>------------------------------
>>> +
>>> +    /* Find device by vendor/device ID to avoid slot surprises. */
>>> +    dev = NULL;
>> might as well init when you declare.
>>
>>> +    g_assert_nonnull(dev);
>> surely g_assert(dev) would do.
>>
>>> +    const uint32_t modes[] = { 0u, 1u, 2u }; /* Stage1, Stage2, Nested stage */
>>> +    const SMMUTestDevSpace spaces[] = { STD_SPACE_NONSECURE };
>> top of block.
> 
> 
> Thank you very much for your valuable feedback. Also I will refactor
> these codes with the guide of summarized plans as described in patch #1.
> 
>>
>>> +    /* Use attrs-DMA path for end-to-end */
>>> +    qpci_io_writel(dev, bar, STD_REG_DMA_MODE, 1);
>>> +    for (size_t mi = 0; mi < sizeof(modes) / sizeof(modes[0]); mi++) {
>>> +        const SMMUTestDevSpace *s1_set = NULL;
>>> +        size_t s1_count = 0;
>>> +        const SMMUTestDevSpace *s2_set = NULL;
>>> +        size_t s2_count = 0;
>>> +
>>> +        switch (modes[mi]) {
>>> +        case 0u:
>>> +        case 1u:
>>> +        case 2u:
>>> +            s1_set = spaces;
>>> +            s1_count = sizeof(spaces) / sizeof(spaces[0]);
>>> +            s2_set = spaces;
>>> +            s2_count = sizeof(spaces) / sizeof(spaces[0]);
>>> +            break;
>>> +        default:
>>> +            g_assert_not_reached();
>>> +        }
>>> +
>>> +        for (size_t si = 0; si < s1_count; si++) {
>>> +            for (size_t sj = 0; sj < s2_count; sj++) {
>>> +                qpci_io_writel(dev, bar, STD_REG_TRANS_MODE, modes[mi]);
>>> +                qpci_io_writel(dev, bar, STD_REG_S1_SPACE, s1_set[si]);
>>> +                qpci_io_writel(dev, bar, STD_REG_S2_SPACE, s2_set[sj]);
>>> +                qpci_io_writel(dev, bar, STD_REG_TRANS_DBELL, 0x2);
>>> +                qpci_io_writel(dev, bar, STD_REG_TRANS_DBELL, 0x1);
>>> +
>>> +                uint32_t st = qpci_io_readl(dev, bar,
>>> +                                            STD_REG_TRANS_STATUS);
>>> +                g_test_message("build: stage=%s s1=%s s2=%s status=0x%x",
>>> +                                std_mode_to_str(modes[mi]),
>>> +                                std_space_to_str(s1_set[si]),
>>> +                                std_space_to_str(s2_set[sj]), st);
>>> +                /* Program SMMU registers in selected control bank. */
>>> +                smmu_prog_minimal(qts, s1_set[si]);
>>> +
>>> +                /* End-to-end DMA using tx_space per mode. */
>>> +                SMMUTestDevSpace tx_space =
>>> +                    (modes[mi] == 0u) ? s1_set[si] : s2_set[sj];
>>> +                uint32_t dma_attrs = ((uint32_t)tx_space << 1);
>>> +                qpci_io_writel(dev, bar, STD_REG_DMA_ATTRS,
>>> +                                dma_attrs);
>>> +                qpci_io_writel(dev, bar, STD_REG_DMA_DBELL, 1);
>>> +                /* Wait for DMA completion and assert success. */
>>> +                {
>>> +                    uint32_t dr = poll_dma_result(dev, bar, qts);
>>> +                    uint32_t exp = expected_dma_result(modes[mi],
>>> +                                                        spaces[si],
>>> +                                                        spaces[sj]);
>>> +                    g_assert_cmpuint(dr, ==, exp);
>>> +                    g_test_message("polling end. attrs=0x%x res=0x%x",
>>> +                                   dma_attrs, dr);
>>> +                }
>>> +                /* Clear CD/STE/PTE built by the device for next round. */
>>> +                qpci_io_writel(dev, bar, STD_REG_TRANS_CLEAR, 1);
>>> +                g_test_message("clear cache end.");
>>> +            }
>>> +        }
>>> +    }
>> I suspect this function could be broken up a bit as new tests are added
>> and functionality shared?
> 
> 
> Sure. I've actually been thinking along the same lines. As I plan for
> future tests, I'm considering how best to organize the test cases given
> the numerous combinations of features we'll need to cover. For example,
> beyond iterating through security states and translation stages, we will
> also need to test many other parameters, such as:
> 
> - Linear vs. two-level Stream Tables
> 
> - Different Output Address Sizes (Although only support 44bits in
> current SMMU implementation)
>

Reading through this, I start to wonder if we will not end up rewriting 
a full SMMU driver by accident. The problem with SMMU development is 
that from the outside, it seems to be "just a device translating DMA 
accesses". In reality, the "just" means we have a stateful device, 
configured from possibly different parts in a software stack. For 
example, with Realms, TF-A, RMM, and kernel all contribute to this state.

A possible analogy would be if we used a QTest device to test QEMU MMU 
implementation, instead of simply relying on running a kernel exercising 
this code.

That said, it's still useful for some basic scenarios, but I'm not sure 
it's the ultimate answer for complex use cases, and thus, it should not 
try to cover it.
As well, this brings the question of which kind of solution we would 
need for that. It seems that one need would be to check the SMMU "state" 
from user space, which moves the problem on having a driver able to poke 
this state.

> My question to you and the wider group is, how far should we go in
> covering these combinations for an initial smoke test? The current loops
> for security state and translation stage cover the basics, but I'm
> wondering if we should aim for more complexity at this stage, or if
> that's a task for future patches. I'd be very interested to hear
> everyone's opinion on the right scope.
>

We have to start somewhere, so something simple and not trying to solve 
all use cases is the right approach. It can even just be read/write 
config/registers before trying to add any DMA scenario.

> In any case, your suggestion to break the current test logic into
> smaller, shared functions is definitely the right first step to manage
> the structure. I will refactor the code accordingly in the next version.
> 
> Thanks again for the valuable suggestion!
> 
> Best regards,
> 
> Tao
> 



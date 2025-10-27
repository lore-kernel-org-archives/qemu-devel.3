Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8467CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 17:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDQh5-0001us-Uw; Mon, 27 Oct 2025 13:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDQh3-0001tJ-6L
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 13:07:41 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDQgw-0002hV-EK
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 13:07:39 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b50206773adso816074266b.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 10:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761584846; x=1762189646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=97HVYoLDkMvtFeRylUdOJxKUVmUFOe6G3QKh3XBaN3c=;
 b=uoaQlffa7Wp3YtgYf2PM0RpEFp2b0xtV6FATcQ/Xx05Dlc7/TEE0tknKohKf9D1quS
 TVTj3TnLST5JA05vhLsARCMxI424S1g/ViFHfltSixwOS+PIh0jNpfK9Ob0YhodEZD4F
 4Wu/tAAdxDzjfinKePqUQ8nvmYR37H8HWoAlLHXVnzBZK/oGbsyO77NxPz7qg8fOOzZN
 5GtiCU2sqQO3/qe2fxvj6SzX/9acJP5+jMhftb7fGvhsjJqGpKFR7g6TGoGyaEdMkdiD
 a1QbRTxVkK9U456YsMC/SBdcJMk9MHz61E1IOGzBzwEJrDfj29LAA0Ydz2kSn1X4hNqS
 e03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761584846; x=1762189646;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=97HVYoLDkMvtFeRylUdOJxKUVmUFOe6G3QKh3XBaN3c=;
 b=vTcSiO1CLG9/LH+1NfUVgUvCnm5ZOphiw1ZZ7tr8MUVmWTLLgfoRY4LpzjZwIF2ZXy
 PoZAY837L6aF05ZvNQ6ub3QnVzzXQY5uYdwc6Nni315pMjBld4bFRNbiUT0BN3LUudec
 DrwKyENCOEKDU8x7eUTsR1VatmJU6xBKQrnE+VqHLoDAz65C+CDqQSEj5G9ZF27UiAox
 tlaEVjo9/zp6BsSFl0nSfqrJn955s8GWO2xO9uS3HYFN9qlQklUKFsxq1gkZUw5IRGdR
 HTxhlDQhuMsepMfhW4s5KJdzhNbOT7BfV7rmSEaArZiED/8Vrqg8dkOW9F8Zl3pFPk57
 jk7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+OEFkoCSs5QU6HZqXaYMF5vLVIQgV+1QWhFa2X1P5LrPjSJYyLp1jME8/297xg2qhll6UWUnfByMV@nongnu.org
X-Gm-Message-State: AOJu0Yy32KZGgEipuws5gNCaWOoY/ozbMXqgZaYcu6/GTSJyMqJbE158
 eC9DxVXU/No2MltrQmNQjMZ/7vSItFBl/8ijXS3wMoyqQvFXxCok0xZM+8VXDBR5oWo=
X-Gm-Gg: ASbGncudaK17b8/Cps/urhkN9/LQk9z0I7IMhF8Wf57EOMRviYQdN7yoM0mGCoVMl0p
 gHfaEfDoF5mp4Af0UT/jQ38Gn8z/4vmOCi3TW0BRGMPeEnED3cIv0D8iZdb6cQKen0GO7gz5SWe
 i2QHRn6kMpwpWeZgAod1yOWMPeV64BbhbEn5qbXiGP2d2GDFLlW6sHZ6II4G0oGl7ZTjrFatJve
 VYqvhr2ixSjsJvfJm5VHxF97D9AYR5MQikwBflokwbr6CgLdPDAdyxLKlgEXtZOEGCWIGM/ijbi
 J9VVAIgQhHLsdt0oJ5ig+kYBaBi7lGp0GniOmsQ/p3ccUvELAOO09W0skHGrt0uMjUvkZ1cYZkn
 6F0AqnEM/9pJJ1sATqd0lZ20v1QCwJgH5ax4qc+Gu85ySjXzaSQWUA7SMf2GdYJ6IsX5C+LNQlZ
 JEqtc0ApNmKlA=
X-Google-Smtp-Source: AGHT+IFsUdZEiBtMkbjSzIAZN+VIvdKhEAI3p38lZfZEymTaX4dDYURe7jr2ljalUQPNZilSBCLWtQ==
X-Received: by 2002:a17:907:944d:b0:b3e:c99b:c77f with SMTP id
 a640c23a62f3a-b6dbbff3129mr19605766b.24.1761584845455; 
 Mon, 27 Oct 2025 10:07:25 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8544c9f5sm831675666b.68.2025.10.27.10.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 10:07:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C36B35F829;
 Mon, 27 Oct 2025 17:07:23 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Tao Tang <tangtao1634@phytium.com.cn>,  Eric Auger
 <eric.auger@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Chen Baozi
 <chenbaozi@phytium.com.cn>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,  Mostafa Saleh
 <smostafa@google.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Laurent Vivier <lvivier@redhat.com>
Subject: Re: [RFC v2 2/2] tests/qtest: add SMMUv3 smoke test using
 smmu-testdev DMA source
In-Reply-To: <792a06cd-302c-46a5-997c-026cb67f8f2e@linaro.org> (Pierrick
 Bouvier's message of "Mon, 27 Oct 2025 16:52:31 +0100")
References: <20250930165340.42788-1-tangtao1634@phytium.com.cn>
 <20250930165340.42788-3-tangtao1634@phytium.com.cn>
 <87jz0lnan1.fsf@draig.linaro.org>
 <ce64f4a2-75a0-442c-a26f-7391a378e8d0@phytium.com.cn>
 <792a06cd-302c-46a5-997c-026cb67f8f2e@linaro.org>
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Mon, 27 Oct 2025 17:07:23 +0000
Message-ID: <87ecqoxohg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Hi Tao,
>
> On 2025-10-27 16:26, Tao Tang wrote:
>> Hi Alex,
>> On 2025/10/23 19:02, Alex Benn=C3=A9e wrote:
>>> tangtao1634 <tangtao1634@phytium.com.cn> writes:
>>>
>>>> From: Tao Tang <tangtao1634@phytium.com.cn>
>>>>
>>>> Introduce a bare-metal qtest that drives the new smmu-testdev to exerc=
ise
>>>> the SMMUv3 emulation without guest firmware or drivers. The test progr=
ams
>>>> a minimal Non-Secure context (STE/CD/PTE), triggers a DMA, and asserts
>>>> translation results.
>>>>
>>>> Motivation
>>>> ----------
>>>> SMMU testing in emulation often requires a large software stack and a
>>>> realistic PCIe fabric, which adds flakiness and obscures failures. This
>>>> qtest keeps the surface small and deterministic by using a hermetic DMA
>>>> source that feeds the SMMU directly.
>>>>
>>>> What the test covers
>>>> --------------------
>>>> * Builds a Non-Secure STE/CD/PTE for a chosen stream_id/ssid.
>>>> * Primes source and destination host buffers.
>>>> * Kicks a DMA via smmu-testdev and waits for completion.
>>>> * Verifies translated access and payload equality.
>>>>
>>>> Non-goals and scope limits
>>>> --------------------------
>>>> * Secure bank flows are omitted because Secure SMMU support is still R=
FC.
>>>>     A local Secure test exists and can be posted once the upstream ser=
ies
>>>>     lands.
>>>> * PCIe discovery, MSI/INTx, ATS/PRI, and driver bring-up are out of sc=
ope
>>>>     as smmu-testdev is not a realistic PCIe Endpoint nor a platform de=
vice.
>>>>
>>>> Rationale for a dedicated path
>>>> ------------------------------
>>>> Using a generic PCI or virtio device would still require driver init a=
nd a
>>>> richer bus model, undermining determinism for this focused purpose. Th=
is
>>>> qtest, paired with smmu-testdev, keeps failures attributable to the SM=
MU
>>>> translation path.
>>>>
>>>> Finally we document the smmu-testdev device in docs/specs.
>>>>
>>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>>> ---
>>>> ------------------------------<snip>------------------------------
>>>>
>>>>
>>>>
>>>> ------------------------------<snip>------------------------------
>>>> +
>>>> +    /* Find device by vendor/device ID to avoid slot surprises. */
>>>> +    dev =3D NULL;
>>> might as well init when you declare.
>>>
>>>> +    g_assert_nonnull(dev);
>>> surely g_assert(dev) would do.
>>>
>>>> +    const uint32_t modes[] =3D { 0u, 1u, 2u }; /* Stage1, Stage2, Nes=
ted stage */
>>>> +    const SMMUTestDevSpace spaces[] =3D { STD_SPACE_NONSECURE };
>>> top of block.
>> Thank you very much for your valuable feedback. Also I will refactor
>> these codes with the guide of summarized plans as described in patch #1.
>>=20
>>>
>>>> +    /* Use attrs-DMA path for end-to-end */
>>>> +    qpci_io_writel(dev, bar, STD_REG_DMA_MODE, 1);
>>>> +    for (size_t mi =3D 0; mi < sizeof(modes) / sizeof(modes[0]); mi++=
) {
>>>> +        const SMMUTestDevSpace *s1_set =3D NULL;
>>>> +        size_t s1_count =3D 0;
>>>> +        const SMMUTestDevSpace *s2_set =3D NULL;
>>>> +        size_t s2_count =3D 0;
>>>> +
>>>> +        switch (modes[mi]) {
>>>> +        case 0u:
>>>> +        case 1u:
>>>> +        case 2u:
>>>> +            s1_set =3D spaces;
>>>> +            s1_count =3D sizeof(spaces) / sizeof(spaces[0]);
>>>> +            s2_set =3D spaces;
>>>> +            s2_count =3D sizeof(spaces) / sizeof(spaces[0]);
>>>> +            break;
>>>> +        default:
>>>> +            g_assert_not_reached();
>>>> +        }
>>>> +
>>>> +        for (size_t si =3D 0; si < s1_count; si++) {
>>>> +            for (size_t sj =3D 0; sj < s2_count; sj++) {
>>>> +                qpci_io_writel(dev, bar, STD_REG_TRANS_MODE, modes[mi=
]);
>>>> +                qpci_io_writel(dev, bar, STD_REG_S1_SPACE, s1_set[si]=
);
>>>> +                qpci_io_writel(dev, bar, STD_REG_S2_SPACE, s2_set[sj]=
);
>>>> +                qpci_io_writel(dev, bar, STD_REG_TRANS_DBELL, 0x2);
>>>> +                qpci_io_writel(dev, bar, STD_REG_TRANS_DBELL, 0x1);
>>>> +
>>>> +                uint32_t st =3D qpci_io_readl(dev, bar,
>>>> +                                            STD_REG_TRANS_STATUS);
>>>> +                g_test_message("build: stage=3D%s s1=3D%s s2=3D%s sta=
tus=3D0x%x",
>>>> +                                std_mode_to_str(modes[mi]),
>>>> +                                std_space_to_str(s1_set[si]),
>>>> +                                std_space_to_str(s2_set[sj]), st);
>>>> +                /* Program SMMU registers in selected control bank. */
>>>> +                smmu_prog_minimal(qts, s1_set[si]);
>>>> +
>>>> +                /* End-to-end DMA using tx_space per mode. */
>>>> +                SMMUTestDevSpace tx_space =3D
>>>> +                    (modes[mi] =3D=3D 0u) ? s1_set[si] : s2_set[sj];
>>>> +                uint32_t dma_attrs =3D ((uint32_t)tx_space << 1);
>>>> +                qpci_io_writel(dev, bar, STD_REG_DMA_ATTRS,
>>>> +                                dma_attrs);
>>>> +                qpci_io_writel(dev, bar, STD_REG_DMA_DBELL, 1);
>>>> +                /* Wait for DMA completion and assert success. */
>>>> +                {
>>>> +                    uint32_t dr =3D poll_dma_result(dev, bar, qts);
>>>> +                    uint32_t exp =3D expected_dma_result(modes[mi],
>>>> +                                                        spaces[si],
>>>> +                                                        spaces[sj]);
>>>> +                    g_assert_cmpuint(dr, =3D=3D, exp);
>>>> +                    g_test_message("polling end. attrs=3D0x%x res=3D0=
x%x",
>>>> +                                   dma_attrs, dr);
>>>> +                }
>>>> +                /* Clear CD/STE/PTE built by the device for next roun=
d. */
>>>> +                qpci_io_writel(dev, bar, STD_REG_TRANS_CLEAR, 1);
>>>> +                g_test_message("clear cache end.");
>>>> +            }
>>>> +        }
>>>> +    }
>>> I suspect this function could be broken up a bit as new tests are added
>>> and functionality shared?
>> Sure. I've actually been thinking along the same lines. As I plan
>> for
>> future tests, I'm considering how best to organize the test cases given
>> the numerous combinations of features we'll need to cover. For example,
>> beyond iterating through security states and translation stages, we will
>> also need to test many other parameters, such as:
>> - Linear vs. two-level Stream Tables
>> - Different Output Address Sizes (Although only support 44bits in
>> current SMMU implementation)
>>
>
> Reading through this, I start to wonder if we will not end up
> rewriting a full SMMU driver by accident. The problem with SMMU
> development is that from the outside, it seems to be "just a device
> translating DMA accesses". In reality, the "just" means we have a
> stateful device, configured from possibly different parts in a
> software stack. For example, with Realms, TF-A, RMM, and kernel all
> contribute to this state.
>
> A possible analogy would be if we used a QTest device to test QEMU MMU
> implementation, instead of simply relying on running a kernel
> exercising this code.
>
> That said, it's still useful for some basic scenarios, but I'm not
> sure it's the ultimate answer for complex use cases, and thus, it
> should not try to cover it.
> As well, this brings the question of which kind of solution we would
> need for that. It seems that one need would be to check the SMMU
> "state" from user space, which moves the problem on having a driver
> able to poke this state.

We should be thinking of targeted unit tests. The difference between
this and a full OS is we don't need to manage multiple shifting memory
maps over time. Setup a page (or two) with the permissions you expect
and check that works.

This would also be the place to verify edge cases that a more complex
driver might get to but is hard to trigger because there are too many
moving parts.

IOW the scope of the qtest tests should be focused on atomic individual
features and the functional tests cover making sure everything works
together as a whole.

>> My question to you and the wider group is, how far should we go in
>> covering these combinations for an initial smoke test? The current loops
>> for security state and translation stage cover the basics, but I'm
>> wondering if we should aim for more complexity at this stage, or if
>> that's a task for future patches. I'd be very interested to hear
>> everyone's opinion on the right scope.
>>
>
> We have to start somewhere, so something simple and not trying to
> solve all use cases is the right approach. It can even just be
> read/write config/registers before trying to add any DMA scenario.
>
>> In any case, your suggestion to break the current test logic into
>> smaller, shared functions is definitely the right first step to manage
>> the structure. I will refactor the code accordingly in the next version.
>> Thanks again for the valuable suggestion!
>> Best regards,
>> Tao
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


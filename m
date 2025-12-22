Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5493EE6B257
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 22:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXoTV-0004pi-FM; Mon, 22 Dec 2025 17:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vXoTK-0004oF-Ci
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 17:33:47 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vXoTI-0005FO-G3
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 17:33:46 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7b7828bf7bcso5058658b3a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Dec 2025 14:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766442823; x=1767047623; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wMK0Zg602XB6LYS2r0yx4pjV2hYI6R9FOV75pQ84bgM=;
 b=xXFH34eC35iXt5xf1+v3TrrCrqiponzgPcjD91KJWhQO4vbIX1hzsqdcxV0q3ybefN
 3dmQlV7WGOqa0wHi9sCz+zZ7B5GRzMPX0JjVUrnHCgIO1c/I8Qts/QDFdfETh9Ifkds8
 aLjQLY3e7iS9ZCDWW9TG3lercbsa9X3YFt7/q3Si35UMdJDEBO1OY9m8o7RC3gM9D5sE
 kjws1l/5xixjj7m0XY13tSlmWtZ42OZa+PPsVVMQ7UMN3HU0/IZmgq9UFTGO8Mj352oj
 JMO/xx+uNV1lT4yTkl0bGgSGVhAsDIWvaLIBMUd+fuObE5gMMbWMkJCAAJ5+xVC2flHH
 8H8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766442823; x=1767047623;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wMK0Zg602XB6LYS2r0yx4pjV2hYI6R9FOV75pQ84bgM=;
 b=PbC8Q2owjPYSyUP4sbcs85hd0oWRCNm9nmTS8bTbBEF4QRQqZLSuaq2QgYXK5/Y0zD
 NiB1zwpYZzWEyGq2AYnQkHhB7zDMYVXn0HfiKnPPCmO2HKfnX15CkH03JUV6WbjvHsNr
 zScRlnyHKdwh69pUdGVxIaQmF0y1j3EHvcGXLatpS/+xTepVLyIsNbtHpRqBLZqM91kW
 AyVIJHP+Z1fApM7bQRlEWEwXmqO7/NDFaEKZEVBOfMzRuv+cWZN3At+4aAAd6sCz93gY
 9lJuHH8XvLBXI5jEnfIG9fHLNiceyPadcsoVXv9QvjEYraY8678kaOW9CQjYIAPi1sKy
 7O0g==
X-Gm-Message-State: AOJu0YzMUot8zCM91tan/Oi3Dlpryzl5/zD5hc8YmHgTpJOGeV+AMtLm
 YXEsS2LySaEpyYhaoe7HiDQL+BN672srkJ4J06yGSyeaEExOuaMfuQimf8W5Lt1RUhg=
X-Gm-Gg: AY/fxX44YhI9zVPMq+5vhw48EC2+UmlQi35+pfkTmPixnt2lAywxmS+qagYMuJV8jwC
 aF5YcV6vMon1Ap+lsuCt5U+y6Gkk04YjKNputyWJZUZsVRkTodre3xae7qD5sHKbhuvF6gqD+mX
 Mhi3wozGvyYozHZN8MZjZe34AvP311TO0AAp4jmYrZDXaf3zOxFIlYM3G/K2JRAqAoKIOiySg9h
 FIZwa6bnRcvQ7Tw7wMiuj9yBzDIIOPZ7J2S2zofvwP0yd/SXFD74jae9XNXTN63Cr3EiKq6mbpO
 cjejWbbseA0jLfFLO3qHUemL6GW4xHlmnW8gt+go5fspndHKVBc6ft1SM5WBkVFns4hp3vxiosc
 avXtE6/N9R2iV2akJJpPsRvE3o/2J582mk1sc5qjfxjnM2p7k8cvXTk9KGZsSAJB+y9GJJHDsk6
 Kp9weQQtNLT3wWHwJzNnMFLTIoNePJ9de32k7ks4ANWlyP8+5l1/UGn2+qLeK39UVy4w==
X-Google-Smtp-Source: AGHT+IH1ZJ/Nrurf63eT7m4E3UZeJH16lwoOvad88LDVXqH9EhElup5YcKyJ1PgjV3Uv+H/r/U/4Og==
X-Received: by 2002:a05:6a00:a88f:b0:7b9:dbf2:3bae with SMTP id
 d2e1a72fcca58-7ff648ea0cemr11469256b3a.24.1766442822598; 
 Mon, 22 Dec 2025 14:33:42 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7ae354easm11440878b3a.16.2025.12.22.14.33.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Dec 2025 14:33:42 -0800 (PST)
Message-ID: <1712a7b5-b148-4990-aab0-7717faf7fa9b@linaro.org>
Date: Mon, 22 Dec 2025 14:33:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v7 6/7] tests/qtest/libqos: Add SMMUv3 helper library
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
References: <20251222124517.3948679-1-tangtao1634@phytium.com.cn>
 <20251222124517.3948679-7-tangtao1634@phytium.com.cn>
 <636d7352-794e-49e3-9e3a-6e32c1e8472d@linaro.org>
In-Reply-To: <636d7352-794e-49e3-9e3a-6e32c1e8472d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 12/22/25 2:29 PM, Pierrick Bouvier wrote:
> On 12/22/25 4:45 AM, Tao Tang wrote:
>> Introduce qos-smmuv3, a reusable library for SMMUv3-related qtest
>> operations. This module encapsulates common tasks like:
>>
>> - SMMUv3 initialization (enabling, configuring command/event queues)
>> - Stream Table Entry (STE) and Context Descriptor (CD) setup
>> - Multi-level page table construction (L0-L3 for 4KB granules)
>> - Support for Stage 1, Stage 2, and nested translation modes
>> - Could be easily extended to support multi-space testing infrastructure
>>       (Non-Secure, Secure, Root, Realm)
>>
>> The library provides high-level abstractions that allow test code to
>> focus on IOMMU behavior validation rather than low-level register
>> manipulation and page table encoding. Key features include:
>>
>> - Provide memory allocation for translation structures with proper
>>       alignment
>> - Helper functions to build valid STEs/CDs for different translation
>>       scenarios
>> - Page table walkers that handle address offset calculations per
>>       security space
>>
>> This infrastructure is designed to be used by iommu-testdev-based tests
>> and future SMMUv3 test suites, reducing code duplication and improving
>> test maintainability.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>    MAINTAINERS                     |   6 +
>>    tests/qtest/libqos/meson.build  |   3 +
>>    tests/qtest/libqos/qos-smmuv3.c | 632 ++++++++++++++++++++++++++++++++
>>    tests/qtest/libqos/qos-smmuv3.h | 256 +++++++++++++
>>    4 files changed, 897 insertions(+)
>>    create mode 100644 tests/qtest/libqos/qos-smmuv3.c
>>    create mode 100644 tests/qtest/libqos/qos-smmuv3.h
>>
> 
> ...
> 
>> +void qsmmu_setup_translation_tables(QTestState *qts,
>> +                                    uint64_t iova,
>> +                                    QSMMUSpace space,
>> +                                    bool is_cd,
>> +                                    QSMMUTransMode mode)
>> +{
>> +    uint64_t all_s2_l0_pte_val, all_s2_l1_pte_val, all_s2_l2_pte_val;
>> +    uint64_t s1_vttb, s2_vttb, s1_leaf_pte_val;
>> +    uint64_t l0_addr, l1_addr, l2_addr, l3_addr;
>> +
>> +    g_test_message("Begin of construction: IOVA=0x%lx mode=%d is_building_CD=%s"
>> +                   " ===", iova, mode, is_cd ? "yes" : "no");
>> +
> 
> Format error when building on host where long != long long (32 bits and
> windows).
> 
> ../home/runner/work/qemu-ci/qemu-ci/tests/qtest/libqos/qos-smmuv3.c: In
> function ‘qsmmu_setup_translation_tables’:
> ../home/runner/work/qemu-ci/qemu-ci/tests/qtest/libqos/qos-smmuv3.c:560:53:
> error: format ‘%lx’ expects argument of type ‘long unsigned int’, but
> argument 2 has type ‘uint64_t’ {aka ‘long long unsigned int’}
> [-Werror=format=]
>     560 |     g_test_message("Begin of construction: IOVA=0x%lx mode=%d
> is_building_CD=%s"
>         |                                                   ~~^
>         |                                                     |
>         |                                                     long
> unsigned int
>         |                                                   %llx
>     561 |                    " ===", iova, mode, is_cd ? "yes" : "no");
>         |                            ~~~~
>         |                            |
>         |                            uint64_t {aka long long unsigned int}
> 
> You can use PRIx64 which is portable.

See test pipeline here:
https://github.com/pbo-linaro/qemu-ci/actions/runs/20432605461

You can reproduce easily with:

podman run --pull newer --init --rm -it \
  -v $(pwd):$(pwd) -w $(pwd) \
  docker.io/pbolinaro/qemu-ci:debian-armhf-cross \
bash -cx './configure $QEMU_CONFIGURE_OPTS && ninja -C build install'


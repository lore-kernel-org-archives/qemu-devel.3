Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE0FE6B257
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 22:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXoPP-0003CT-5f; Mon, 22 Dec 2025 17:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vXoP8-000360-HN
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 17:29:31 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vXoP4-0003cP-P2
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 17:29:25 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8035e31d834so1810245b3a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Dec 2025 14:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766442561; x=1767047361; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9D3EvzRNeCcwWl4C2qJPjjYTGjyKB9LcB4/t8jyKtP4=;
 b=bXX7PNa+yMSPVp9l0A3exUTumAjeGKFSX9dRsGV5wWK5mm5Ajb/o39NPHhVjIqLBPo
 nYWazdbHwXb+a3cv3KS7VSptg3u++o3cDfrU22LZZFhThIkbtDtu01rMd5SLmUI9RQsA
 9TtteaFGRiPsaRy7Wyi2VkYf9vYmQqPD1sfQOkgKjYLmOepovwmm7J+D9+/3fFYjzXLR
 wglPkKNLWV7GWQzlnfBTQFcTfOV5OZcX6gWz8OYNBdYjcBYfgTu9oMie1xhzARD5y6FR
 dnNlCd3xQWLHgqny1VCgKyQl9HsRtl/bhXTmF3ALa5NEDXffb6XWN61W/GN/m1+9p9Bp
 8KWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766442561; x=1767047361;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9D3EvzRNeCcwWl4C2qJPjjYTGjyKB9LcB4/t8jyKtP4=;
 b=vK+J/8RkrXCKxr2XKMimb8zSEQ10RECpvlovOAdc3x+MctiaeGNs8Zu/SZYKSVxBW8
 ZE5JtIYvGMuMKjVAvd+PY2EFSzgSAVBq87pVqO0ch7dlvgqtvx4AomQ82WKaMRXPb7TU
 2gq5zxcOGIHEYPpOokd3uYHZk8H1NX6GGF5owNP9doF/tigmRfwPs0eASMY2HRsRZcC6
 h84KXggtVyNkwKlQIPHNY5Dpsg86a/m/OQmR23hY+cclFnE47FAskf0iF1Oq2iXBEHaG
 au8cjrDivFBuAoXVSCMQ+qdeXG1s7QRj6To/Eo1pXrXE56urTXDjAe8Qry4oGnlu6RoU
 Rerg==
X-Gm-Message-State: AOJu0YwIzoQoFcgnJ/2o6Ukubd6a+tAR2BqyY4RAnAS6egtaBQHuHC/+
 jNtyULOBBQV39V0ysi5TQWStgWrP6FghqyaUN29NIoa0/Id+aw+GAkVItpKS+aH3jIM=
X-Gm-Gg: AY/fxX7D7ts9hX7n12c7BF5dlZ9Bk1oyLPxxzVbkLZESVhzZOilXr0YauP8eyDsZ4Ix
 XSDZliJJEkbGzsV5tJeSST3g3wwSJgQUQ/wFknPad4aR1OL2WqPRNfoA2jW2hY1nA0LhP0coa+D
 5I2pH0GyHv80rDPv/SvLMsBNm4T5YrxMVPI5kzcZOHXnboQpbTKgUgM4pwszTogWxL8AFhjn9rB
 cuqb9t7DrKaW52aUZLm8UrtVcBzU0lyLe2kYMrLVuqnzpi+56olOqW/CNHfAHt6fY3/R8eRnanF
 8v4VunyGfQl2A5PuOAURliMPgqIFJrBlmZ6FMQSxUM4NTOlSTzvjWCebd264/hL78U95J9yjSp7
 55TvebYUyGb/57Eax42PNxIl0cKtfIZDtDHdY42anCqpSl4rxKEhSFrMPhMAybiExr957OFWzH+
 /xuFC5QKfmtxUmqRW9u6ruyRYtp5mUAylDG0CJy6ipbtKhiQp1qdWjvHs=
X-Google-Smtp-Source: AGHT+IGwN3xrPkLKKO4WgSc4WnvanRmDzZdYSDrM+n2Sjt7IxqgAexu+MA/CSEi7ONUhfuEzjSljrQ==
X-Received: by 2002:a05:6a00:4214:b0:7e8:43f5:bd24 with SMTP id
 d2e1a72fcca58-7ff6735f3fdmr10932245b3a.57.1766442560551; 
 Mon, 22 Dec 2025 14:29:20 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7a844d5asm11460268b3a.3.2025.12.22.14.29.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Dec 2025 14:29:20 -0800 (PST)
Message-ID: <636d7352-794e-49e3-9e3a-6e32c1e8472d@linaro.org>
Date: Mon, 22 Dec 2025 14:29:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v7 6/7] tests/qtest/libqos: Add SMMUv3 helper library
Content-Language: en-US
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
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251222124517.3948679-7-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 12/22/25 4:45 AM, Tao Tang wrote:
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
> - Provide memory allocation for translation structures with proper
>      alignment
> - Helper functions to build valid STEs/CDs for different translation
>      scenarios
> - Page table walkers that handle address offset calculations per
>      security space
> 
> This infrastructure is designed to be used by iommu-testdev-based tests
> and future SMMUv3 test suites, reducing code duplication and improving
> test maintainability.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> ---
>   MAINTAINERS                     |   6 +
>   tests/qtest/libqos/meson.build  |   3 +
>   tests/qtest/libqos/qos-smmuv3.c | 632 ++++++++++++++++++++++++++++++++
>   tests/qtest/libqos/qos-smmuv3.h | 256 +++++++++++++
>   4 files changed, 897 insertions(+)
>   create mode 100644 tests/qtest/libqos/qos-smmuv3.c
>   create mode 100644 tests/qtest/libqos/qos-smmuv3.h
> 

...

> +void qsmmu_setup_translation_tables(QTestState *qts,
> +                                    uint64_t iova,
> +                                    QSMMUSpace space,
> +                                    bool is_cd,
> +                                    QSMMUTransMode mode)
> +{
> +    uint64_t all_s2_l0_pte_val, all_s2_l1_pte_val, all_s2_l2_pte_val;
> +    uint64_t s1_vttb, s2_vttb, s1_leaf_pte_val;
> +    uint64_t l0_addr, l1_addr, l2_addr, l3_addr;
> +
> +    g_test_message("Begin of construction: IOVA=0x%lx mode=%d is_building_CD=%s"
> +                   " ===", iova, mode, is_cd ? "yes" : "no");
> +

Format error when building on host where long != long long (32 bits and 
windows).

../home/runner/work/qemu-ci/qemu-ci/tests/qtest/libqos/qos-smmuv3.c: In 
function ‘qsmmu_setup_translation_tables’:
../home/runner/work/qemu-ci/qemu-ci/tests/qtest/libqos/qos-smmuv3.c:560:53: 
error: format ‘%lx’ expects argument of type ‘long unsigned int’, but 
argument 2 has type ‘uint64_t’ {aka ‘long long unsigned int’} 
[-Werror=format=]
   560 |     g_test_message("Begin of construction: IOVA=0x%lx mode=%d 
is_building_CD=%s"
       |                                                   ~~^
       |                                                     |
       |                                                     long 
unsigned int
       |                                                   %llx
   561 |                    " ===", iova, mode, is_cd ? "yes" : "no");
       |                            ~~~~
       |                            |
       |                            uint64_t {aka long long unsigned int}

You can use PRIx64 which is portable.


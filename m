Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1001FD3B7E2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 23:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSkF6-0004K8-JX; Mon, 08 Dec 2025 18:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vSkF1-0004JR-OI
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 18:02:04 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vSkF0-0003aG-3b
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 18:02:03 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477b91680f8so55763015e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 15:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765234918; x=1765839718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B18bFogMiBZFvzcdH72KQIqsb0ufAd13NGkPwD3C3ug=;
 b=P8XFIwGkHxST006LiJIaRGxLLULic9yqB7Og97P/kZjoPjykHERwqxWGO/+1zPcDrB
 XRRwZ6OZjZcE1I+cfeQjxKxnDbLzFoGrqX7sjUASFzggAblidltys9/XC5tCdLASZ+Y7
 yUa1L/fZ3+j8b2WRr2O3RFWHGDXtsUgImR7emcUzzsaFWMnh23GwNB2gb3NYQ194Epn+
 JA16iKg1SiVzt2qF2ZAt5A/1v1hgGijwJDKgOKISiFzafzpN19BdOjlTYdhy7PsmRCRO
 2+CcKo3kxfXXHkAnRkQSP43g+6TsHW82iPCivXI6HFKDciKrEW07ntLIS+l+RGvM2JDA
 5ugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765234918; x=1765839718;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B18bFogMiBZFvzcdH72KQIqsb0ufAd13NGkPwD3C3ug=;
 b=Vila/2rscwDA3yrDMwijfvNbky4e+Dv6dFD50nFyEBO0xcrljdEf5a/J7ld5Oe51D5
 Uf0lxmFNG1RJB0s3YyJ/oo4mg4rhp25WwHOVP9DPEcJGtagK7EqDekxjvB1OiYmXfDwD
 MqjsOtol0yK70AEk44SBtisK7irsIx8LQEpIaKvBmNQkE5ykgNkF1G9F9MA2v3S058Yg
 sgV7RDxxc67ji/ipSRkLQkURZEwpGU58EWR770Nvn9s0/CSsErBNoSdSR3CzgHxIuXQd
 jErStePIwypvKAD8S3TAyiTBqPDQCExaMnPXfaLQkMmFLxajtOZIsKhEBSyWGeFx6cnW
 S3hA==
X-Gm-Message-State: AOJu0YzJUj3cLyOD4HCfDUqCbIaylTSp21GJxtRm60oPGS7RFBocggzJ
 +heDDtPCXlHs5EdY4Kf24eoqCJBPAhW6lG2msc52I+2pucYT24bfLkaNIxRaMd5t/TU=
X-Gm-Gg: ASbGncv0jCJUEF8EBnSoFCzLgzVBBUtKxIGNHEYUlGWVIO5rvqL3JwcrEEVYL26RUUW
 T5ZKHba84mofDV5rTvfGHANQbJu2fgmAYXfRBgcGvunajjqWoUKdM/soH6BmG4onKdndNfkuiYj
 cL8+1+ZqCSnMhq/nzfnvLMAx2ufLHiAP016ELqegWqMHqlrXrQrWyl/cR/DK0AgJ9YH0hhaEypt
 hH3pqd2VVFTn636BKYYrQFET/aTa0E4b9awNG6SXx7bxTu2eF6a7Wr/fI6pdVzFta6CCVrRfUia
 gMPStf6Dcmqka5/hPoxJBljNA8btOQneIVCajsXH9gPDtUL+bfKEwXu8V6uKggUb7AVLS9INOl3
 4rlp0OVk0HQmmvxZ/NPlwUAOjZGWWLmtbdn7f23eKdv3dNKrMNokXRC0LIhbEMcJVHPtvutlUCq
 0lE+Af8el/5+LO7BvqhQs=
X-Google-Smtp-Source: AGHT+IGL5cdoTBrRANMIpf3acxsZKxeVuzFeBSV870OtOKC8JQCOtBiyndr2bf0TQ9h2ihz2ui6tAQ==
X-Received: by 2002:a05:600c:3b07:b0:477:c37:2ea7 with SMTP id
 5b1f17b1804b1-47939e23e7bmr102645665e9.21.1765234918523; 
 Mon, 08 Dec 2025 15:01:58 -0800 (PST)
Received: from [10.14.0.2] ([82.102.18.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d6fa0f6sm7088505e9.4.2025.12.08.15.01.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 15:01:57 -0800 (PST)
Message-ID: <07afa374-e068-4f05-a70b-e8c6b207831e@linaro.org>
Date: Mon, 8 Dec 2025 15:01:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v6 3/4] tests/qtest/libqos: Add SMMUv3 helper library
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
References: <20251206155203.3015881-1-tangtao1634@phytium.com.cn>
 <20251206155203.3015881-4-tangtao1634@phytium.com.cn>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251206155203.3015881-4-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x335.google.com
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

On 12/6/25 7:52 AM, Tao Tang wrote:
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
>   tests/qtest/libqos/qos-smmuv3.c | 632 ++++++++++++++++++++++++++++++++
>   tests/qtest/libqos/qos-smmuv3.h | 256 +++++++++++++
>   3 files changed, 891 insertions(+)
>   create mode 100644 tests/qtest/libqos/qos-smmuv3.c
>   create mode 100644 tests/qtest/libqos/qos-smmuv3.h

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



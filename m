Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9994D3B7EA
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 23:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSkSB-0006C3-Py; Mon, 08 Dec 2025 18:15:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vSkRz-00063O-Vc
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 18:15:29 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vSkRy-0005Pu-3E
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 18:15:27 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7b8e49d8b35so6169580b3a.3
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 15:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765235723; x=1765840523; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HXDEnMSsq9Obi8Qx7sh+Y8zuA17vo/9J5diLflBtDgs=;
 b=XoFzKLUnhIID6N+FNZGEqWIbA0TR3hwAQmPs9kEEzeVen27YqvqBwux5y4Pk5QsUWj
 XPUbp2nM3dA0VaGtJjovsTzepQXSwx/3StXXfoaSWxrDYeZLIn9NGvZ4isE2YIXiKFM8
 IR/NKfQeH/h1Bcz1U/+xgE+5wLid7de/CTtGAc0su1o8Zh0+JSVo5zpXiOyvywYDUcFh
 +jtvyVaqKPjaQW1zWr3ZrKPbtoh1PdCnZOS57LfBzclXx3Oiez8gYoVjjlY0iB0sZxlZ
 4BEfzbKi90wvWfCSaK6OA517au0gLx0w5+wnHdkGNoh1vNHxHQ4PlzpwFmUd9LCJErgp
 /dSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765235723; x=1765840523;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HXDEnMSsq9Obi8Qx7sh+Y8zuA17vo/9J5diLflBtDgs=;
 b=AbznPNTukvJKr3YS61RmOZd9c0A9Mlp3GtbahMeYHjZjvYxKKyy0YVS6SQ775PRp4u
 +x06xy9zuKzlvrycLYJT+EkK70dvn3yy8AQibkW2WfSQ/jeYJzIKQUhBIVnnoOVRMZQp
 VXtlKa2QctqZ5V49renRTf2IO2EHCXkyRps/4ROhI9sKm1q6k6xPvratE8+oOa/LWzw9
 HWndRm/MYWmYhCOQVh+WLf/Y3WJfjtVWkxgpNCOxOCgOatRF5OPnhI5v929Y8xTDlTMP
 68V7D+kh/Y+kTEChb8kHiSlsklkwq2y6bCO9wjcj6N2kQxwRlq62CNaTdBbIKYtVXds9
 QBMg==
X-Gm-Message-State: AOJu0YzM7YCclMoXpH5hxQmcLJWIO2fMz0Hv/vas1c0A84jtA/vbJEXe
 0GdcL2YfvaoAj22YH927GqcmvOeH8GfZmiHDFX0qZL4deEfvh80dgbeEu1iH4I6gkqM=
X-Gm-Gg: ASbGnctLrl9gpfuB1wCo+9Tz1wFnppomm2lMcOPra2yTYu5PktyufKPLPEmntdDubVc
 LFVfAvFV8Nsh4BOremG3rcCjvbXsEHL+O1jeTD/jY02sikDEp0EMzXcWpmUs2/bJ9zSE8mn+sqg
 O1xzn1KcLTuMSeZsAJaUu/DqwnffrX+oFv7bVR1McUkMlmQgtw6GaRHYeB26zJAMl/qSD7M7lTa
 ZxaPULCYxJ7JIwTAj/xGziPBeLWtbajN7rcx5sPAumR4REX+p9WEFzviw2g6A32phznTn85kSMz
 zIgyKSm1i0LE2+m4vD90EtV2HjZzqhnwtlM/sqk8LadK1cbV/MduOZ56zm+Q8VPcmAqu8ehaoAW
 5MTvZP1PgY781/tGjD3Rw8qRLtcgfDz6QyIh8uN1LhP9undMIcT4rqrpI4MyNn9t/23p36W6Eou
 ZqtIw0tS46YTrHPXz1ykYhmLvb6KaKJwxnaQ/Xbzo9KqhdhBm2eovAPEU=
X-Google-Smtp-Source: AGHT+IHQsFpJB8WC0jCiO+E5XRXIEllxNtO5mjzT3Y/EA/pQUe2SDiqA2mfgzPdQhvg5nPBwGq/gQQ==
X-Received: by 2002:a05:6a00:2392:b0:7e8:43f5:bd29 with SMTP id
 d2e1a72fcca58-7e8c580841dmr9631103b3a.62.1765235722753; 
 Mon, 08 Dec 2025 15:15:22 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7e2adc5c400sm14129669b3a.37.2025.12.08.15.15.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 15:15:22 -0800 (PST)
Message-ID: <9a8d8ce6-6cc1-4e61-b148-9395344ee35a@linaro.org>
Date: Mon, 8 Dec 2025 15:15:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v6 4/4] tests/qtest: Add SMMUv3 bare-metal test using
 iommu-testdev
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
References: <20251206155203.3015881-1-tangtao1634@phytium.com.cn>
 <20251206155203.3015881-5-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251206155203.3015881-5-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 12/6/25 7:52 AM, Tao Tang wrote:
> Add a qtest suite that validates ARM SMMUv3 translation without guest
> firmware or OS. The tests leverage iommu-testdev to trigger DMA
> operations and the qos-smmuv3 library to configure IOMMU translation
> structures.
> 
> This test suite targets the virt machine and covers:
> - Stage 1 only translation (VA -> PA via CD page tables)
> - Stage 2 only translation (IPA -> PA via STE S2 tables)
> - Nested translation (VA -> IPA -> PA, Stage 1 + Stage 2)
> - Design to extended to support multiple security spaces
>      (Non-Secure, Secure, Root, Realm)
> 
> Each test case follows this sequence:
> 1. Initialize SMMUv3 with appropriate command/event queues
> 2. Build translation tables (STE/CD/PTE) for the target scenario
> 3. Configure iommu-testdev with IOVA and DMA attributes via MMIO
> 4. Trigger DMA and validate successful translation
> 5. Verify data integrity through a deterministic write-read pattern
> 
> This bare-metal approach provides deterministic IOMMU testing with
> minimal dependencies, making failures directly attributable to the SMMU
> translation path.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   tests/qtest/iommu-smmuv3-test.c | 131 ++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build         |   1 +
>   2 files changed, 132 insertions(+)
>   create mode 100644 tests/qtest/iommu-smmuv3-test.c
Looks great now!
Tested again, and works as expected.

Let's see if other people have additional comments on the series.


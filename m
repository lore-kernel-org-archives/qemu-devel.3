Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B694CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 07:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDI5K-0000hH-AU; Mon, 27 Oct 2025 03:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vDI5I-0000fo-M4
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:56:09 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vDI5D-0003Ah-Dk
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:56:08 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so3003376f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 00:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761551761; x=1762156561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SQl+NisJFxZKOAs0wWeJ4+Zx/WhIYmpfXNRhIe2eUS0=;
 b=rhdlZlLgXMmYImEDQz1r9Gg8YqroaKYeR/Z+v8Ck44Xko94RBFYt+DE38vr3zbDTWq
 lXltO2nSExzkr4zDPj/VlSk7srGx34/y+WfF2FB5t67K4SHqkHxaxW/CF+KZQbnfWsuB
 iSsgNEh4Jfx9AHBqmHrFmjBhnPecBRV87E0INSqNxghX7qbAcfFlnivjkGR2dSPtxNUb
 yUAgMvoP62R/gcfMrpSA86yA1R7Dv3AcGsQU++oIlxKa1r7qUjX/Qq4jmdUH/Ei6/n0j
 m2Jp5go1gC24pUtorCteNkRjoGbj+kSHQ+hWC2RACy1yCuCykY0i266cRufDLsMbG3P5
 hDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761551761; x=1762156561;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SQl+NisJFxZKOAs0wWeJ4+Zx/WhIYmpfXNRhIe2eUS0=;
 b=HIeprXo3KAcEgt+p56CNiQNPYeSuzTLK+aJiGCnE7MxkoHxDjVUfzD3n2zULX0fuKj
 H3FvYdNYJvRRLDGhvo8YcGnGpfsgipg18qgvQ8QjFtdYfYdhcz6KpFzJJzj1kUVCxg7a
 q38mCNoIuNKp6vrtqT0jwWg3KPMbrrpE5WNNYXEyRl407UJQyzmgBCHaMrWdKtRLenKG
 lSo+9ULibCF9eKa5z3u1DeIPUkDvdUCxLkfrrrVetCiMFghTXiAfANjSIQTDuEaG0gP0
 zGwAAq7d6pdE7Xkxf0CVOUJOWo1dPLYrxKb6e/Ge+LthXP3M6RXLdzyII/F0Bk9RAo/L
 Xx/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXusdq6bYLgPS3z0AaMz1kzdwW7500sPbhSlH/QCUKCobyuV3dKKHW/5GfP/CShX2kC9B197VlejdyF@nongnu.org
X-Gm-Message-State: AOJu0Ywf/nb733LXEEBHHr0H0gjhlYO67UtEfWT0k125aNMAkA7PPvxP
 G0R0zu+pT0U+j/YYDzpD+X6obJfDT+fjJBoVwjy5lQLAE0dWbrIYEnYO9SXOxJURAyM=
X-Gm-Gg: ASbGncsNPyDzd1A3vDHzcQ2sBPAfK8nsBiMZpA4nvoigNTnGXmW8BH29I6aY2tGOcmf
 pg5OoP7PasK6lnOxwidBPc3ZlKdbG+ztgqW2tif2x9Q/zomCGLtOPf0lAAYREpxrgIJHprkXbtU
 rZBYWTXuiXhXXYRtHv1u80Ku5WtAgPTTzWoHhSL4NlhzdtJfubYK8iaV2P4KoMNz33hW6XZeWAx
 0jIEnb7J3atFhNO9U3Sucy58tI/bTUSgwYWn9EzhWhFVoIyddcD2MdyMZBRgj/50or2/WrdfKWV
 sJGHfhmS5Y/xyZ73IF7PtYeGGkdDiIEMlbZKL/WQwtpslSfYE8ElKCRUS3uq71roQVrGMlpAXyk
 7GByhqHxo8JzdkxH5J+sMvvgZfEUk/G4VKG2m7dvOziwsrsuDYy3p1lx4lMmMzNvRxlyzEBHLxO
 ZbuCrZEEIWLBjyU0lEttymuhbrdQSsJxVRBjSkk3D11Ff0s9OMBLnO7/CxpVWZwNjD1A==
X-Google-Smtp-Source: AGHT+IEoa7YoqXjwVsW1lLWBoPF6gggZOI6+XF3bY9ecPa74D9gFf4/xAH6v1KQ7ZxIhD5F1vKXGuw==
X-Received: by 2002:a05:6000:2508:b0:427:9d7:8720 with SMTP id
 ffacd0b85a97d-4298a04e95fmr10995412f8f.24.1761551760763; 
 Mon, 27 Oct 2025 00:56:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:404:4d10:9f16:e9b1:dc97:28e6?
 ([2a01:e0a:404:4d10:9f16:e9b1:dc97:28e6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cb7dcsm13127131f8f.11.2025.10.27.00.55.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 00:56:00 -0700 (PDT)
Message-ID: <05a6fb35-a2ad-45f1-9a84-79477560442c@linaro.org>
Date: Mon, 27 Oct 2025 08:55:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 24/24] whpx: apic: use non-deprecated APIs to control
 interrupt controller state
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
 <20251016165520.62532-25-mohamed@unpredictable.fr>
 <2cbd9feb-2c20-46e0-af40-0bd64060dfba@linaro.org>
 <6982BC4E-1F59-47AD-B6E6-9FFF4212C627@gmail.com>
 <60cd413d-d901-4da7-acb6-c9d47a198c9c@linaro.org>
 <0C41CA0E-C523-4C00-AD07-71F6A7890C0E@gmail.com>
 <4F98A2AD-02A7-4A7F-91B8-269E9EC8E5B1@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <4F98A2AD-02A7-4A7F-91B8-269E9EC8E5B1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x435.google.com
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

On 2025-10-23 19:02, Bernhard Beschow wrote:
> 
> 
> Am 23. Oktober 2025 09:23:58 UTC schrieb Bernhard Beschow <shentey@gmail.com>:
>>
>>
>> Am 23. Oktober 2025 06:33:18 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>>> On 20/10/25 12:27, Bernhard Beschow wrote:
>>>>
>>>>
>>>> Am 16. Oktober 2025 17:15:42 UTC schrieb Pierrick Bouvier <pierrick.bouvier@linaro.org>:
>>>>> On 10/16/25 9:55 AM, Mohamed Mediouni wrote:
>>>>>> WHvGetVirtualProcessorInterruptControllerState2 and
>>>>>> WHvSetVirtualProcessorInterruptControllerState2 are
>>>>>> deprecated since Windows 10 version 2004.
>>>>>>
>>>>>> Use the non-deprecated WHvGetVirtualProcessorState and
>>>>>> WHvSetVirtualProcessorState when available.
>>>>>>
>>>>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>>>>> ---
>>>>>>     include/system/whpx-internal.h |  9 +++++++
>>>>>>     target/i386/whpx/whpx-apic.c   | 46 +++++++++++++++++++++++++---------
>>>>>>     2 files changed, 43 insertions(+), 12 deletions(-)
>>>>>
>>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>
>>>> Couldn't we merge this patch already until the rest of the series is figured out?
>>>
>>> OK if you provide your Tested-by tag (:
>>
>> Oh, I did for an older version of the series w/o this patch: <https://lore.kernel.org/qemu-devel/5758AEBA-9E33-4DCA-9B08-0AF91FD03B0E@gmail.com/>
>>
>> I'll retest.
> 
> Unfortunately I get:
> 
> WHvSetVirtualProcessorInterruptControllerState failed: c0350005
> 
> and the VM terminates. Reverting the patch resolves the problem.
> 
> Best regards,
> Bernhard

Thanks for testing it Bernhard.
I didn't have time to run latest versions Mohamed posted.

Pierrick


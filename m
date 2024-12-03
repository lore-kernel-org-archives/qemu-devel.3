Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3072CE74AD1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 20:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIZkc-0000NI-S0; Tue, 03 Dec 2024 15:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIZkZ-0000MI-Co
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:44:03 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIZkX-0003lD-Jz
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:44:03 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7fcdbfd8090so1948324a12.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 12:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733258640; x=1733863440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2m6CpvQHO/YDC11hJhBycspt3bWc9KD96XfQ75TSBo0=;
 b=F7ELCqXUdPPP6WvApDzy6l0UGhE/4saotNa6Ct6SrwvrphV+aBhxl/BzZRptyLRrDH
 ORXRbtfz5g2sAMd2V5K+64RcPJNBsm3tUkkejri/oe3IodcHr+D5lDhREOSYe0KvObqY
 8ucK9MCxcan9yWjgX7h1fuGC0K0gRuaUoEVU7PmU/GXGKcUnD/sivY206jZ5AYQU3m9R
 jsskHQwunGkRv0gKuZd2Iu0B3xvTPTMDxmIoIcpM+yGc6MiBtgvYcowfzuxeEW/ijJZS
 trjvLdcvrm0eZuV5D+L5Sn8seAajZNdSRYqmHHBS9/1XTP/+/we5GE3ax+W7sUq2GTy2
 C9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733258640; x=1733863440;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2m6CpvQHO/YDC11hJhBycspt3bWc9KD96XfQ75TSBo0=;
 b=PqjI2JO4Vc6NT43gZwvda38crHIFKKatpbGGhj8pwYtBFE95kopeFZUOcPY7RM9cgj
 M0MbUw5gQAeTZzABWX40E7byjiXip9QlEiTBMMOFzRen5fJp9tgNB9rz+GNjTjElhRrM
 ol6IdS2+fdiPWy29oi7s4IOvhr+xe4t7IaYP5Gd87P+mHF4hZj8fv87V55Cl26rAr1ch
 7juGoGPdu7galcM5XXL0yw1AxOnPvCwTA0C9thXqucqGIH2Xcr4zNTP6NTWJeQ1KNXTm
 qt0IttX3ky/YqMrT7X14yc4Z35r+wKGA5SzPHb2L2WtZ5OSYAfUdwGhRZdoBmHBc6AjY
 BG4w==
X-Gm-Message-State: AOJu0YztQ9OcGCQMR+3GNyfU9iFZ2EArewn+dbglUDuYAfRn/adoQnGz
 3R69VUd4LlCnElv6QpeQl47CghHu9yjvSUUJOn4mhqyng086lxrA0rwIVgGZAbc=
X-Gm-Gg: ASbGncudHI5diTvTimoJe6J2oGv44Tbvgof3wJbxf1LqQKSbWoVEx9gnMUMwXqhzQ8r
 Nzt4e+Qd1ceHrvyhp7kOaW+dZOtIna91IqcybAQUU7Yif1ryaKPJOmghBCwiUmTXFG3x4ennA+W
 Qwbth1XWtloZU5tKBXJ/r0uwvpFl+rk3lajL563xvCXw067TFlqgjlRfTqpRmUdSXvaOlZ598sC
 wNi71vYUF1bb9Wvn8GtdFjBYVWyno+3UEGKFH3wt+MtfplC/HAm6HHk+PzI2MpeWGKQKyUC30/9
 1WD1kW8W1p9sSxQ/zgVHuA==
X-Google-Smtp-Source: AGHT+IG2ETHF5mGEbGuuHv5fovAe2fL+4Jyw1sfOgWoAD7vzLq8AeZOpE/ZVGMcP7mLGDqXHq3168g==
X-Received: by 2002:a05:6a21:9998:b0:1db:e464:7b69 with SMTP id
 adf61e73a8af0-1e1653c5e66mr5968057637.20.1733258639794; 
 Tue, 03 Dec 2024 12:43:59 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7258cbb5e26sm58310b3a.119.2024.12.03.12.43.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 12:43:59 -0800 (PST)
Message-ID: <d204e918-6847-41f3-8085-72ee1206c066@linaro.org>
Date: Tue, 3 Dec 2024 12:43:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tests/functional/aarch64: add tests for FEAT_RME
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: qemu-devel@nongnu.org, marcin.juszkiewicz@linaro.org,
 gustavo.romero@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 mathieu.poirier@linaro.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20241203001741.2068452-1-pierrick.bouvier@linaro.org>
 <20241203155434.GB1903051@myrica>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241203155434.GB1903051@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
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

Hi Jean-Philippe,
(adding Daniel and Thomas as well)

On 12/3/24 07:54, Jean-Philippe Brucker wrote:
> On Mon, Dec 02, 2024 at 04:17:41PM -0800, Pierrick Bouvier wrote:
>> This boot an OP-TEE environment, and launch a nested guest VM inside it
>> using the Realms feature. We do it for virt and sbsa-ref platforms.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> -----
>>
>> v2:
>> - move test to its own file
>> - add sbsa test
>> - check output of `cca-workload-attestation report`
>>
>> v3:
>> - build and run test with cca-v4 images
>> - factorize nested guest test between both tests
>> - remove accel tcg option as it is the default when running tests
>> Note: It's a long test and there is a work in progress to understand why
>> debug build is so slow (x12 vs optimized).
> 
> Can the functional tests take as long as we want, or are they regularly
> run by a CI?
> 

It is run by the CI and developers as part of functional tests (make 
check-functional). The shorter the better thus.
Adding more (shorter) tests would be acceptable though, as they can be 
parallelized.

> The `cca-workload-attestation report` command is great for making sure the
> RME feature is working and the guest is running in a Realm, and it's very
> light. In my opinion it's sufficient here.
> 
> We could also run kvm-unit-tests on the host, various VM payloads and
> configs (in particular edk2 boot), and performing local attestation, but
> those would all be testing the other software components, so don't seem
> relevant to this functional test of the QEMU emulator. That said we do
> need regression tests for the whole software stack (including QEMU VMM)
> and this test automation is really convenient so I'd like to extend it
> with extra tests but outside the QEMU codebase.
>

I saw that kvm-unit-tests are mentioned in our documentation, but I'm 
not sure if we have any functional test image running them.

I'm not familiar enough with this topic to know what would be the value 
to add such tests, or edk2 boot.
That said, if we can have extra (short) tests upstream, I don't think it 
would hurt anyone.

For your need when working on an RME stack, it may be easier to keep 
those specific tests on your side.

Someone on this thread will probably have a better answer than mine :).

> Thanks,
> Jean
>


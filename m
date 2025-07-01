Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F88C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWXyn-00062a-5Q; Tue, 01 Jul 2025 06:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWXyc-00060z-8c
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:12:38 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWXyZ-00034C-Si
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:12:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-453643020bdso47395835e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 03:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751364750; x=1751969550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i48kyF48WGF1kOw5a2fFzh77wpZJNP5oYB8FFOd+ev8=;
 b=GsB78aT6Rotxxz1/XCoy3aIp//xs2rdz9iylZEo15eUJVqDK9ULg4zid3ZrljJdRKR
 N0CR0rAGwSEXIbrafV6y3Jr15qr6xVcOFZBEPgRPhp/WImsGGjZw1YFEVHS3JWHbbTZy
 Zq6IpAIsj90XkuT+NBIM5uS1MbUu0sYvV5+65yatKhXS/UruU5xwxtG1Rth1d1O30TmR
 reMtUruD8Oxu4VYqmPHFeAuexfPBeEqoVE+a0iBnuAmTeAjJjfoQqQvSZQ0E+aByCkVG
 G1XfkmuGZuInrmz6231JXiLqg6rC8e/f30AHTZlAJozF2wtUU3MHLCyycmMZ8W7Ba8kL
 HwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751364750; x=1751969550;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i48kyF48WGF1kOw5a2fFzh77wpZJNP5oYB8FFOd+ev8=;
 b=ENCgAcnXA1/5y+1elKPd94GwjzqVanc+9iwUoCY9ZvdT1cjwHYLZvps7/vGIJnsSD1
 5QubFJmuVyu3gXARSJHG/XX04SWq4alUCAS5nWX9wioTrhLke6e+ZUFL3qZQtYD7jjiL
 2sD5LTUZZjVDBYDNkYrK/G51DFcXDzPm8Qe+3Mq8+eKaWQ//VouS4PYtnfRuwDC0s1Dy
 kZzz3pV44c0pjUck+4RgLWop1uoVLBo+0q66Jzo5m360RKTEvTUwEqM5G/6ef68pHY8A
 aUsKpGlu8zfzyvv82OfyxsIgm2f50fMPPIr/6do5skM8mYJJkpfgrC4rGnsb1t/ULmrp
 pa2w==
X-Gm-Message-State: AOJu0YzPr4vey7P2ts91e5C7KEuimEiVPbX3Uob5OERcvlbv9THLS8ax
 CM3chqpzCnmi5uGWWOM/uBo5pDKYp6bQKmes6lXIzGQwygxOTtuX6SnpP2xBNGxTdRI=
X-Gm-Gg: ASbGncs6uXdgr5+W9VKkkjZ0QMnnfj9WqsF1wXVhAY/IQ9E45sPmNJdfmbG2lAIH1lW
 QYZn9IK6UYuRMwV6BNdEUmrU0yVzbRXXRo1zB21kRmQxVtnv391+KMgXFmSKjJZR+3mVPmHeI8r
 KoNNLi72fTpobc/XStcx7DF17fMJrHMGnQKKKjQROLPaaCHqihSInE/DgKQ0ebb6cmpDlkPT/wc
 sREdSJ2dqoR+h/Z3jVfQSApUAE8qysc3JzofJ3R5xQLumbeiNUDk0saMzSiqrZo7OCzpHm3Mb3l
 nDXK7FJBotVBMiPe4ZpTkyfgsWLYLhRrk6+2XXkCi+/fgxiHzKrB0MYsIVViCcwe9vDnyG6HaW6
 /e7BfrbMue3sfpIHg5aJ/gx0osETamw==
X-Google-Smtp-Source: AGHT+IG3V/DgLWI7Rr9w/9AtpjvbqCpEr0yemPeswRn1wIGk+oob6kO0PmMCNon/JHwIcG/zcwIGUQ==
X-Received: by 2002:a05:600c:8219:b0:43d:42b:e186 with SMTP id
 5b1f17b1804b1-4549f5db40cmr11080065e9.8.1751364749915; 
 Tue, 01 Jul 2025 03:12:29 -0700 (PDT)
Received: from [192.168.69.166] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823ad247sm197230345e9.26.2025.07.01.03.12.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 03:12:28 -0700 (PDT)
Message-ID: <1c7a557f-2ab4-465c-a84a-43dffbf4e0f4@linaro.org>
Date: Tue, 1 Jul 2025 12:12:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/26] target/arm/hvf: Simplify GIC hvf_arch_init_vcpu()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Bernhard Beschow <shentey@gmail.com>, John Snow <jsnow@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
 <20250623121845.7214-5-philmd@linaro.org>
 <CAFEAcA8+9TPps4NkRwRTZXq-nkR=zJ1SsFLnMzzNf7MioU-qsw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8+9TPps4NkRwRTZXq-nkR=zJ1SsFLnMzzNf7MioU-qsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 1/7/25 11:39, Peter Maydell wrote:
> On Mon, 23 Jun 2025 at 13:19, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Only update the ID_AA64PFR0_EL1 register when a GIC is provided.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/hvf/hvf.c | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index 42258cc2d88..c1ed8b510db 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -1057,11 +1057,15 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>>                                 arm_cpu->mp_affinity);
>>       assert_hvf_ok(ret);
>>
>> -    ret = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64PFR0_EL1, &pfr);
>> -    assert_hvf_ok(ret);
>> -    pfr |= env->gicv3state ? (1 << 24) : 0;
>> -    ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64PFR0_EL1, pfr);
>> -    assert_hvf_ok(ret);
>> +    if (env->gicv3state) {
>> +        ret = hv_vcpu_get_sys_reg(cpu->accel->fd,
>> +                                  HV_SYS_REG_ID_AA64PFR0_EL1, &pfr);
>> +        assert_hvf_ok(ret);
>> +        pfr = FIELD_DP64(pfr, ID_AA64PFR0, GIC, 1);
>> +        ret = hv_vcpu_set_sys_reg(cpu->accel->fd,
>> +                                  HV_SYS_REG_ID_AA64PFR0_EL1, pfr);
>> +        assert_hvf_ok(ret);
>> +    }
> 
> This doesn't seem like a simplification to me...
> 
> Looking at the code, I suspect what we should really be doing
> is setting the GIC field to either 0 or 1 depending on whether
> env->gicv3state. Currently if hvf hands us an initial value with
> the GIC field set to 1 but we don't have a gicv3state we won't
> correctly clear it to 0. i.e. we should change the current
>    pfr |= env->gicv3state ? (1 << 24) : 0;
> to
>    pfr = FIELD_DP64(pfr, ID_AA64PFR0, GIC, env->gicv3state ? 1 : 0);

Good idea.



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054FFC71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTAqf-00025u-Dh; Sat, 21 Jun 2025 22:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAqd-00025k-G1
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:54:23 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAqb-0000jB-MX
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:54:22 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-74924255af4so667138b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750560860; x=1751165660; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U5Vf0wLXJNxpMBp27FjR0fDyCaRNQYszCTdRwZVcA8s=;
 b=txPOE5yXfvkXPLukUo/ralPANXy/nAOcuwtGAJf6atkTFhGvZN5Yt5l7zWVwc5LZPQ
 UJYmuBUji7eJzdweRMFh0Icpi0Z0kj7reatLHjy3xxXWx7oBhLuhUbU2TDh3lRuOe+k9
 YMMLEsgJQ7K+a7jwWVHm/okhsLgjwwaT5c8SHJoGk0XPEUC24FrqZRLg7OcRgqFs6Bfv
 jyySnDmz+ro6+GDZRXkZzbjfi61S7SpWifLooMf4B5icFSxb37zMQsI7mrM6pO0I3DWY
 +dxhMaE7GWzUS8Ejwex7AkFBjGQVoWnLRm3ZPiVVB0XAHwUIOe7kpAqu4a2vYI1duxa0
 6RTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750560860; x=1751165660;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U5Vf0wLXJNxpMBp27FjR0fDyCaRNQYszCTdRwZVcA8s=;
 b=DgCHkzlaEuXQumQxMyU4gtEvOdNuWsROLMoNdHdzUmPKG1ow+wZSNQfxXBNCGgxDKD
 ADY++ynnNAY4RN0Lh2cx0tWmIduHLFEf+zMJwqBzJpcYrPu7eV3nPG7DdY6ZjosLHmBn
 RQ+ELN0Yla5ODbRn6oAh/MdCJhV8OPfB+0/WV9Qw6WcER+MLETxJRGVa3yfZ7jayZNSz
 RwWhdMnGMuee1SuJSdFrCmN+IgFcc3ts2slW6VY571ufEf/eF3ylJMsXw1JXCucWFdQd
 Q3ZmIzmgbIZiVtXtHfoF5RoxOU/X0Og3dhw3G19gvge1+45JHMRrlPIWbNJ9o69atSWc
 TgiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbFmLZxdjkN15yf3de20XSi4HjZ7q3eyEBeTZ/Dx9PYMyG6UaTpp5WKFienFtW353HKs73uUqPOcQ5@nongnu.org
X-Gm-Message-State: AOJu0YzxWOpg8RuR0m/S9L09l7YfEA/SuskxJzjc5g14dX8n01AHVXfZ
 5J81CaH0cS+rFdeb2C9C43BoHcSL7ffo9u3SIAZxakFhq/vKoTr+XjXjEiHJ/7gQfJfZF317LVJ
 8oIjltag=
X-Gm-Gg: ASbGncv/wQvWDu/fz+oguku6vx6uqx8+LXsD6hys+1yPZg5M8riGkXrNv1C7QVq6xzk
 weSPwCVzVB9WPnnBKHikLBq0xTLSulfKC3EH+w86xjxKaIeYBal3SGc2/rnPx0e+LuRblL5HU24
 JksGpAISi9o0WbJ6CS7J79gynu2h8Z6om1NgfBdImRcuQnOeyht+b8iI47zurH+eSntxDGrMl+R
 H9YQ7+XLFOlYJdjPo7L+vAsse7vHzXzWzUUnP3YgwbScP9pmJD29P60tQ4pV7dLbXX3luSzgiCW
 yACqGGsW8hgdlHoJAaHeb5N/sUMYwknSlEzW7Iqv1K/IShx+dWA0d6IcmLvPVew4FXArnRvno5e
 H4k2Z+OutlbHGkYz0gL2DoCNRjFli
X-Google-Smtp-Source: AGHT+IEKI5oOvxVOmk287j1SbJ8gcpT4yZ1sQQzXL+XGrLZaPwek0DDIiix5uPzoHjrSMVakTnE8ow==
X-Received: by 2002:a05:6a00:2e99:b0:742:b3a6:db16 with SMTP id
 d2e1a72fcca58-7490d67f737mr10985986b3a.20.1750560860200; 
 Sat, 21 Jun 2025 19:54:20 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a64cdabsm5244657b3a.129.2025.06.21.19.54.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:54:19 -0700 (PDT)
Message-ID: <9644ccb5-1785-46fd-971f-d626c11bfb6f@linaro.org>
Date: Sat, 21 Jun 2025 19:54:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 16/42] accel/split: Implement
 synchronize_state()
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-17-philmd@linaro.org>
 <8b5ed35a-dc45-4617-83dc-4770d6c3a39a@linaro.org>
Content-Language: en-US
In-Reply-To: <8b5ed35a-dc45-4617-83dc-4770d6c3a39a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 6/21/25 19:52, Richard Henderson wrote:
> On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   accel/split/split-accel-ops.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
>> index 65feb929404..80efbd82091 100644
>> --- a/accel/split/split-accel-ops.c
>> +++ b/accel/split/split-accel-ops.c
>> @@ -165,7 +165,16 @@ static void split_synchronize_post_init(CPUState *cpu)
>>   static void split_synchronize_state(CPUState *cpu)
>>   {
>> -    g_assert_not_reached();
>> +    SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
>> +    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
>> +    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
>> +
>> +    if (hwc->ops->synchronize_state) {
>> +        hwc->ops->synchronize_state(cpu);
>> +    }
>> +    if (swc->ops->synchronize_state) {
>> +        swc->ops->synchronize_state(cpu);
>> +    }
>>   }
> 
> I suppose in the short-term this is ok, but it does more work than it should.
> 
> Let's make the simplifying assumption that even if there is another sw emulator, it'll 
> still use CPUArchState.  So the "sync" to sw is pointless.
> 
> But syncing state to hw is only applicable when use_hw is true.
> I'm not sure how to do the pointer chasing to find that from here.

The same applies to patches 14-18.

r~


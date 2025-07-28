Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E102C87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 13:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugNzX-0007gZ-PZ; Mon, 28 Jul 2025 09:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugNur-0006oZ-9V
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 09:29:34 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugNun-0002nP-KK
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 09:29:20 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b78294a233so1333538f8f.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 06:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753709355; x=1754314155; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UxkcOg9W+C+ToL7yHNOyCSMWys+vPGmCNNvWHl1MgOs=;
 b=ERArb15b0fm8yq/86rqqx5DV1u9kaJqbUUqKTgLcRL6IWLEx77YF/qaCr3OnoJfaoj
 x34s2vv14B357XZn8AZVnUnwpEasOrYfPkHD3Sm8h1M+bI1vgl1uDu3/BS3okn5idF+h
 +58PY+8VE8IEgxEH66iZxX7tPdlgNg8tD6YXwCBbOiwIOZyV46EhAR+G8WT+3kd73rW9
 u0wqjr0ANgIrf/00QNkvoflZ9vhWgkpUlG+VhCbBS0EHNJ8NJmKVdRyFvL8ug61rHxGW
 jeZieo60yyz/4PfNyxd408ySZ0C666yFVlkKX5e/fCkRQqih6QEyjBvCgdruLFwFirSn
 /yhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753709355; x=1754314155;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UxkcOg9W+C+ToL7yHNOyCSMWys+vPGmCNNvWHl1MgOs=;
 b=NbH5b0cLH3YCAoop1v3XCFAR+do4YvW0q2WlyVvIb0zl2hdHCP94NFQ9rGULNGe4T9
 K9laoTfc7hfDj2vNZy0VHbLjK8UvnYrDS1MiLrGy4m4yVz12Vo9BaD27T686kNzgArqd
 c8Z4juWRBqpzTJzHeCt+jZZOwn/7GsD8Dfyh17ZPg1dLckSHNcEiargwYgO/Q+win8po
 bMbZ3sTkv1leCYi72vRU1ZzNHkClrLw595VFoH9Clu7Bp/4vKI80GzBmJIU8dQq7pvnq
 CDZmFsrXnoEVEFvr5AapERvkP62PXOBnXu+Y0pPtbtQamFmhgyQN3EYmh0ev4wi2ODO+
 TWQg==
X-Gm-Message-State: AOJu0YzjPtOurdeU6E946Wn8kgDqPAwada/TNzBEEEDSiqulaMtRsRBn
 l4VyxcNzdGRFzVMDirS83dmlhyBYjF0cBFPa+JD8NeGLrm3yoPLxU5Lwgqq8HnQhSYU=
X-Gm-Gg: ASbGncv70Gkg/bj6F/8rMdg1muMv1bmA4jrQH7Zf8TqHfUxmClRLHmTjAkIvr/X+DPM
 64j1WJogq6up1Kc6WiUd2SMlW8isfFgWlfPCkH5/YNZxyZ0eR8TRgb051eJEAFY/CuolJAhPz7q
 /201YPPAXNifL7bRWlRw9hEwx/riWJwKg6D1dFMwYSEG+NXMKiUjj9WiLV00BP0ntfS4AWrHri3
 7UTNQy35uVI53tnshkRJqUwko4TYhmSxMAx8aKs2o69gDYByYBq145QRkty6XfpEachaaXXPzRM
 h4brKt9jfXPgEGCBiT8QYuRK4Z9CbA2q59OTr3Zmo5507gY8cHczpAKBfv3lLeuVjrNcShc39sp
 0g1B1csytYN0TlBnlvAqc2tJktVe1DGlwrnrHveDLldz19AFLfcSbdMW0IlKiyzbj1A==
X-Google-Smtp-Source: AGHT+IH4Zi6woXLz4z+6eg1d9OT8WH5qXa2OfESghRXhWezaaQiZGQHIS0lcYEFAdR/Zhmi4Seipuw==
X-Received: by 2002:a05:6000:26c1:b0:3b5:e714:9770 with SMTP id
 ffacd0b85a97d-3b776733877mr8958144f8f.14.1753709354840; 
 Mon, 28 Jul 2025 06:29:14 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587abc13b3sm103311715e9.6.2025.07.28.06.29.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 06:29:14 -0700 (PDT)
Message-ID: <f7096e4b-63e0-422d-bb46-1fa2e7e03da2@linaro.org>
Date: Mon, 28 Jul 2025 15:29:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] target/arm: add asserts for code paths not
 leveraged when using the vGIC
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250725223035.52284-1-mohamed@unpredictable.fr>
 <20250725223035.52284-4-mohamed@unpredictable.fr>
 <e9afdf9e-b357-43a5-acc6-f4839c539585@linaro.org>
 <5F11EE68-0CC5-4A41-A89D-48CF789196A9@unpredictable.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5F11EE68-0CC5-4A41-A89D-48CF789196A9@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 28/7/25 12:46, Mohamed Mediouni wrote:
> Hi,
> 
>> On 28. Jul 2025, at 12:18, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Mohamed,
>>
>> On 26/7/25 00:30, Mohamed Mediouni wrote:
>>> When using the vGIC, timers are directly handled by the platform, so no vmexits ought to happen in that case.
>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>> ---
>>>   target/arm/hvf/hvf.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>
>>
>>> @@ -1965,6 +1971,10 @@ int hvf_vcpu_exec(CPUState *cpu)
>>>           /* This is the main one, handle below. */
>>>           break;
>>>       case HV_EXIT_REASON_VTIMER_ACTIVATED:
>>> +        /* This is only for when a user-mode irqchip is used. */
>>> +        if (hvf_irqchip_in_kernel()) {
>>> +            assert("vtimer activated vmexit when using platform GIC");
>>
>> This line does nothing (not firing), is that what you intended to?
> It’s specifically so that if this trips, I know that I really screwed things up. Helped me a bit in developing this.

Sorry I misread.

Better to follow QEMU style to ease reviewers:

   error_report("vtimer activated vmexit when using platform GIC");
   abort();

Or just:

   assert(!hvf_irqchip_in_kernel());

> 
> However, this whole patch isn’t expected to ever trigger irl, so would be fine to drop from that perspective.
> 
> HV_EXIT_REASON_VTIMER_ACTIVATED will never be returned by Hypervisor.framework when the vGIC is enabled.
> 
> Thank you,
> -Mohamed
>>> +        }
>>>           qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
>>>           cpu->accel->vtimer_masked = true;
>>>           return 0;
>>
> 



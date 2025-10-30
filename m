Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C22CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 12:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vES9M-0006HQ-2v; Thu, 30 Oct 2025 08:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vES9J-0006Gl-Gg
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 08:53:05 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vES96-0000rQ-N5
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 08:53:03 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-429b895458cso447201f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 05:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761828764; x=1762433564; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m776V6m0D6/vfvn1FV4xNqtr5h8+oJ1yaveKTo0Dt9o=;
 b=V9FmZnwJYzu4kgKYnwWKgZHHf7coFq75YbWD6oLPvGTq94VGi1t/CbrTu56Ceafh7C
 G7XPuGkS4057Cl1MmFmXLUWFeck9HMSgLICBY8mY1ZDmP3jZUmtNUKqvH/OUCeWKIFuK
 FeetAPOambP2yixHLxtx5mF7cusOuFPC6zEY9I3aMvhko4kJw2Mcb/O3qfN4tpGRAf1T
 sPOl4XWmL+Tod4CSaiCXXQXJcrbevAsx2GcO0A9uzbn3Qx9+yikj4KO7aMbfltWSukRF
 O5cC92qodLjntCBMIalYbzjqt3uO3P92QL2wx+S+jbOAzuRCR9Co9fwm8lK8mEaiu046
 uzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761828764; x=1762433564;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m776V6m0D6/vfvn1FV4xNqtr5h8+oJ1yaveKTo0Dt9o=;
 b=fo6e0QlfRihjPDf/4dscPXS81Hd+xKuJdcR1hMC2VPlMxzGpTm0KMpwdGcKNDjjddF
 MKmy6euREjydj1WtH8BMMwm62x6PkuNmKXDKBuSFh24fXxvpXtVLC5Cougb8lBbtueFu
 HheH7tPbvAgTVpsy+VnZDdRqw8izR78EnTLkBelTtEij47T8eEkUcx6SN635QXG4P9ef
 9wAICVWX2pJxa3oDdwwOBnkqhGV+zSAIvZTQKs3fqDkPdtBa13P7MjOdbQrwBdVzZ1Tp
 H+DJvkeihiyPuKt/l9RI9X76OJVfpisAVJSEEmFakNLthQjD6wEdnjO3sIz3Waa+a3/f
 Jp6w==
X-Gm-Message-State: AOJu0Ywp+F87jXgD0wuGd8cWw0qazefmy90Z3RuucYgzru4zg4wnO98h
 ciVIYwmdqul12JzEDJeOTY+RiBnOsd91h7KIGeabeg3NNWQ+Gk3sXRZ8m9R9g1lBbrg=
X-Gm-Gg: ASbGncvQ0b5My5gNnVL0CkMkSg23yvJ8YnxTlYRbl+VVEof5baGAMA76GBgpK9qwu62
 BWoxAtN5Da07cVNpWhm6nZLzdlQkaQZWV85mpvxmShRMPE5A2615bs5LthoULtS11DvHSmROMfj
 xXuxHwbnS6/1zx0mLursyaBIoqDb4BTN8ohyOdfm99fjN9rQzZNMPyy6ppPgpOzLaAslg5mKNbP
 5mTTC/1Dip7nd0JniKD0ixNsx2ThLjsNnHsiFdRJKwUiwrlpJW+97fs89Le9eeFDsFLl5HTKw74
 FZw1K9H1U9opoHtDpvb/ebS7krEEIeO2RTrgAy/eVMwCU9ozYFKTA6wAf6/E9O9067jHPHxRmQh
 AUOAyUTTeWYx8BkWXFZnyeAcpyh7xJRqFVJGLBXpVG8llSpfdy0Y4VJxecnzxZeXqzSJPo1URKU
 a1UyrW+67X0CG9152L2D0OMHtw0q/RpyCT2gykbdPWRLDfhXy0o7v+VRA=
X-Google-Smtp-Source: AGHT+IGbbd3BJRWFbFFfG+uT97yK1i0Cux4CA9jUOH/+WmltcThhav1Qp2+cJb26tXzFaAj/xv77pQ==
X-Received: by 2002:a5d:5d01:0:b0:428:3d14:7385 with SMTP id
 ffacd0b85a97d-429aef8481amr5991587f8f.28.1761828763955; 
 Thu, 30 Oct 2025 05:52:43 -0700 (PDT)
Received: from [10.180.230.213] (99.red-88-29-173.dynamicip.rima-tde.net.
 [88.29.173.99]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429ba445463sm2137237f8f.10.2025.10.30.05.52.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 05:52:43 -0700 (PDT)
Message-ID: <a3d39ae0-9c0d-4822-9dfc-9ddcf79f63e5@linaro.org>
Date: Thu, 30 Oct 2025 13:52:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] hw/riscv: Replace target_ulong uses
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org,
 alistair.francis@wdc.com, richard.henderson@linaro.org, palmer@dabbelt.com
References: <20251027-feature-single-binary-hw-v1-v2-0-44478d589ae9@rev.ng>
 <20251027-feature-single-binary-hw-v1-v2-2-44478d589ae9@rev.ng>
 <49e7ca69-3477-40c8-aad3-f799d848ce7a@linaro.org>
 <2y2ism54afg4ke5oeykqin5oy2kn4lb4gcd7fidgrmlwwbe6df@5h4wudvpyll4>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2y2ism54afg4ke5oeykqin5oy2kn4lb4gcd7fidgrmlwwbe6df@5h4wudvpyll4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 30/10/25 13:32, Anton Johansson wrote:
> On 29/10/25, Philippe Mathieu-Daudé wrote:
>> On 27/10/25 13:35, Anton Johansson wrote:
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>>> ---
>>>    hw/riscv/riscv-iommu.c | 6 ++++--
>>>    hw/riscv/riscv_hart.c  | 2 +-
>>>    2 files changed, 5 insertions(+), 3 deletions(-)


>>> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
>>> index c7e98a4308..65d2c92018 100644
>>> --- a/hw/riscv/riscv_hart.c
>>> +++ b/hw/riscv/riscv_hart.c
>>> @@ -93,7 +93,7 @@ static bool csr_qtest_callback(CharBackend *chr, gchar **words)
>>>            g_assert(rc == 0);
>>>            csr_call(words[1], cpu, csr, &val);
>>> -        qtest_sendf(chr, "OK 0 "TARGET_FMT_lx"\n", (target_ulong)val);
>>> +        qtest_sendf(chr, "OK 0 %"PRIx64"\n", val);
>>>            return true;
>>>        }
>>>
>>
>> What about csr_call()?
> 
> csr_call() is handled in the other series making cpu.h target agnostic,
> there we expose 64 bit variants of reading/writing CSRs which are then
> used by csr_call().

Ah, good then, thanks!


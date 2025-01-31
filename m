Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEF1C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 13:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdrC0-00045e-AA; Fri, 31 Jan 2025 08:36:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tdrBw-00045K-0X
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 08:36:16 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tdrBu-0000hF-EB
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 08:36:15 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21619108a6bso34298505ad.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 05:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738330572; x=1738935372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5MCeK5n+5gJL2xftSosJLZv/AHi2f2ABEnI3IJElVSI=;
 b=x7MhctkKIK8v968kNT+onyEgoR8rY3/5dkHSTsGR+KASNZ6OKvzf9nYlppZR4TIK3C
 BPFWWxWtUQA+gr5+PZ6ODx4xYtfM/14Z5NFrh9SfiEQFnSrXX/+LHVasJUxD71zO4XVl
 Iq/kcw6kOd5QqDjmtJ/iPm1PC9qVTx7152DMKo2PD9QUHn6rGCBOTfeIDrKhRlxfi0xd
 CiTmf69gcH7LrBJGOFMwDhbTYjjN4hwLNhaVjlFasTeXEviR4tcy0EQDx8BHEvd8ppOB
 SQz3V1i5wpFCTpDAK54zuomoreSwOmk7ZrhpyWJvPgtJH5jnuXh74WBmJbve+HgS35rL
 Mq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738330572; x=1738935372;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5MCeK5n+5gJL2xftSosJLZv/AHi2f2ABEnI3IJElVSI=;
 b=mDus7hH2RnVq1VxXw4OMmNiTViWGrHv/y50TZ0/VMmt6UfE+SRMBH+uloSakc/8hXx
 EDXkmYueT1nZJp5IG+BK2FKNfjdIklt3ET5ylQH8CzowU6oNnBV74h1IsaLXvFKo0Iqn
 A6LMHmko8xr9ySYo7gP6qBC/KkrauKjWxslWI5r2RbcRuE1xyY8779bC4PQEEkLlq7Tz
 fxLb3x6HgAkhWMhIRcjQPViq+nq7HeNeSErcvfXMEw9LnxgNvSfVdDVy9bwJgnuux5li
 QNw/B7jyHXANjstq+J6WFlifTFFPtMzL1/lmcMTpDpMFX1cL5d8DGHnGv1TzVx0wSOfH
 3nzw==
X-Gm-Message-State: AOJu0YzEsnqQZ4JkUC0Cw8U5qnsRfD9sop4fbovsM9KZZUIYUFprDjRp
 B38LnNMiJrbCyZzwxr/a82dFRzO/0nDn8KBEomW4cBilAXe8xaoshhhVrRCcg51PLCakUmmeOKd
 U
X-Gm-Gg: ASbGncv5vmGvQgPHCAMvQk2OqJZWqthNAS3kuWJnWKxbtRb9IT94wWEj3iqHXVTKc92
 eHXwVY7hzxEz2LzFQVUJUQZNel7gnXXAwwEAFJnDs5BiCrOASx7B91CFi4Bi9uW6yQ7LsHHN/G0
 SIgciI1sb4HKQ4LCFwrlhZC+MKjC0kzeFK5KF+iiEnCqhfFbwogEpqUkpq3cBRJBIwbJrL4cd1t
 8yebi1ywwvJ3K9eJ0yb/bK4PVeQ/uUXFH5Sz/VVTAaTcUsA/l2kMrwDxctUaKG9HT1fn4i4Eusv
 tZGou1hhF8v7X84pocjv01S/ptSZQTfi
X-Google-Smtp-Source: AGHT+IHuLJY2r8N7NNaWmk1HMrzsiDct5Q6PTZgC7Hi6tcguJzLsgKTny+ittmk3EK3rrsceapd2Cw==
X-Received: by 2002:a05:6a00:214a:b0:72f:d50a:9084 with SMTP id
 d2e1a72fcca58-72fd50a9263mr11057521b3a.13.1738330571898; 
 Fri, 31 Jan 2025 05:36:11 -0800 (PST)
Received: from [192.168.163.227] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe69ba3acsm3197143b3a.111.2025.01.31.05.36.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 05:36:11 -0800 (PST)
Message-ID: <b79b0416-d387-4dad-aa0e-26acff4369a3@linaro.org>
Date: Fri, 31 Jan 2025 05:36:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/76] fpu: allow flushing of output denormals to be after
 rounding
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-25-peter.maydell@linaro.org>
 <d8d04708-ddc2-476e-9e17-8493f573d7a5@linaro.org>
 <CAFEAcA91VD57mPb4y2bzWnf-p6o6O8Q_9HCdM0HGReddBp8WsA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA91VD57mPb4y2bzWnf-p6o6O8Q_9HCdM0HGReddBp8WsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 1/29/25 05:04, Peter Maydell wrote:
> On Sat, 25 Jan 2025 at 16:42, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 1/24/25 08:27, Peter Maydell wrote:
>>> Currently we handle flushing of output denormals in uncanon_normal
>>> always before we deal with rounding.  This works for architectures
>>> that detect tininess before rounding, but is usually not the right
>>> place when the architecture detects tininess after rounding.  For
>>> example, for x86 the SDM states that the MXCSR FTZ control bit causes
>>> outputs to be flushed to zero "when it detects a floating-point
>>> underflow condition".  This means that we mustn't flush to zero if
>>> the input is such that after rounding it is no longer tiny.
>>>
>>> At least one of our guest architectures does underflow detection
>>> after rounding but flushing of denormals before rounding (MIPS MSA);
>>
>> Whacky, but yes, I see that in the msa docs.
> 
>> BTW, I'm not keen on your "detect_*" names, without "float_" prefix like (almost?)
>> everything else.
> 
> Do you have a suggestion for better naming? Maybe
>   set_float_detect_ftz()
>   get_float_detect_ftz()
> to match set/get_float_detect_tininess()? Though "detect"
> isn't quite the right verb, I feel...
> 
> And for the enum
> 
> typedef enum __attribute__((__packed__)) {
>      float_ftz_after_rounding = 0,
>      float_ftz_before_rounding = 1,
> } FloatFTZDetection;

The enum looks good.  The accessors are harder.  Maybe set_ftz_detection, matching the enum?


r~


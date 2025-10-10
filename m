Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9A4CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 14:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7EGJ-0004o0-82; Fri, 10 Oct 2025 10:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7EG3-0004jC-Uh
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 10:38:12 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7EFv-0003gv-Vn
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 10:38:11 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e3cdc1a6aso16663955e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 07:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760107073; x=1760711873; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8quOKggH2MDngAZiD5kJOV1t5NoqB0UhD9/qU6D9F8s=;
 b=a9nLam65UEt2Qj2rlrKBcOgbzZ3vGedHO0skYx48MZAQzULu8DmTGeFG0Zc/UuUHyt
 PwKpLDw2YYJJIIrtEDpHDseyx8mwJOJlgyc0V9U3NZEKT0m/247O3W6gNQiNvmFgUSfp
 YiECkGj11nak2Xig4TwofLJPKrUzWS7Kb07sFWWR9sJ7fy1Ed/9JNE2xQqUnctwY2JtK
 pCdmW52D38VrT6mgxnyiIoAwoHEN1kEKfrPYBqdDFNeI5VuipUfiLr7J+BWlNYvg/ZwP
 iX0l3nfpnwSgEow4IeYxsi4vCeieGofYF/dXXi7sUXEITjdyYoe/rNLWWfg/V9/OoTLC
 jPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760107073; x=1760711873;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8quOKggH2MDngAZiD5kJOV1t5NoqB0UhD9/qU6D9F8s=;
 b=v36S2SjkfFckuYfnguoMoM3ppkeW/5i9xOqn9vaDkdHFJXU8KdP1buTiHirhyyai3+
 vrChqDAiKzwfQ7BQVibvvy6SALa634YxfIc5KWtH79AbnvMtnCHs+L98fOkVBzIZqkYP
 TDvhy/n+RdrZUZhX35UL/5k19jneTUiwCsNcMY2o/6JK04L+iiKlLCaw77VmIn2sHxx+
 cdu6wIuVtGoBZQR0KUIv9q+B/FEL5K2ZJNiXnh7wTJ6nWPPM0V4P1n1lFt4Y8HA/DOnL
 Zvud5m/pjxDerZRhQ8jZTdQ2H15sSvJhrTY0tyxYuHcOWtoFtj899EkycFs4nJWcuF99
 sq3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX43EGSUCmhVHTI4XxDoILVLmlEWkCQCosnTxAnkTNR0ughzjrkI+y/cgGTWnqbnpzDtMqp5kCYWjAO@nongnu.org
X-Gm-Message-State: AOJu0YyvqtDuol8NIVi+ROhtMKuL4lHhVdOnE12sHPxhuJf2LdkzExuu
 uiUwCGyjmPg27Xvxuw6HSakeMZEPrJXNNORqzaP83Zb6JdRXhwy3tHVh6RUyL+ad0BY=
X-Gm-Gg: ASbGncspejAx302ypttM7vo5h8CLCjcCWHJhKEEu22aIgFfx0qVLhes7j1Yr3ztT2Nn
 eNcYGFyj1LGeNsjMF/qBmCY78FnoCmI01cpIz96X09cBakQWM17LL97ohQNiZSxj+Fr5y0TXgKk
 w9/2GyZxq5HLGRuGmA176k9aeKilS/vnrRqT+LnUnqKY8Wmag2JylS/P3XpYCrP4tDS3qVBF9PX
 5ahH4JNDPwvNVNUcC1GtYNC65R+ruieF0EJNR9+7kWI3F6wQbKY6U9udjcgnwpxfr+Bg2olOfGd
 8wgsVn7cAIiQ9Qfj3YY3EcxWdMAUYiP57DpkD2EKR7PAF+hxaAWw+HGVk6U10d390Z2N4Yqtfec
 GluMxACvLf7YPbqNXLSJ96abPIW0LK3x9OrJKhE8oHqhGtiHIpl1bQv8Xna1GgW0djLSuilpOxU
 cPpuT27Np06cya
X-Google-Smtp-Source: AGHT+IGO1e0SuQS25tGqDlkxLz4xhu3MmOqg0u8G4suXSWNF437Xcfw8L7dSkV5uasgUDNa2d8L1Ww==
X-Received: by 2002:a05:600c:6592:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-46fa9ec796bmr87600855e9.16.1760107073294; 
 Fri, 10 Oct 2025 07:37:53 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb49d0307sm47978965e9.18.2025.10.10.07.37.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 07:37:52 -0700 (PDT)
Message-ID: <614c4af0-1fea-4d48-bb52-a1ef60302b9a@linaro.org>
Date: Fri, 10 Oct 2025 16:37:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] overall: Replace HOST_BIG_ENDIAN #ifdef with
 runtime if() check
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
References: <20251010134226.72221-1-philmd@linaro.org>
 <5e4d3a1a-ee13-40c3-b470-d68f5b6b4ad1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5e4d3a1a-ee13-40c3-b470-d68f5b6b4ad1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On 10/10/25 15:51, Paolo Bonzini wrote:
> On 10/10/25 15:42, Philippe Mathieu-Daudé wrote:
>> Replace compile-time #ifdef with a runtime check to ensure all code
>> paths are built and tested. This reduces build-time configuration
>> complexity and improves maintainability.
>>
>> No functional change intended.
> 
> No need to repost (and I didn't review), but please change throughout 
> the commit message to mention a *compile-time* if() check.  The code for 
> the wrong endianness will not make it past compilation, and mentioning 
> runtime checks left me wondering if you had mistaken HOST for TARGET.

I want HOST, and hope the changes are correct: I meant to express the
code is elided by the compiler, indeed not at *runtime* 🤦 I'll reword
the commit description. Thanks for catching this.

> 
> Thanks,
> 
> Paolo



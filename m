Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A51C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 11:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucMaq-0004qn-Fm; Thu, 17 Jul 2025 07:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ucMaM-0004na-7D
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 07:15:35 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ucMaI-00068U-IB
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 07:15:33 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-456108bf94bso5363965e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 04:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752750928; x=1753355728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W2plJ6J2I3uEkS9s/RoI/iLItjcXG/U6oXtMhASgX4s=;
 b=nEU9eaScAnfR3bgKzY3koe/HmFnOenCS2atSbvm3uxqzHbBrcWjsJLVrNcMrLbbSfJ
 kp3liXBVD+OTRlt6KYul0sF34OwWwg8ZUweyv4+wFjRN3E7uw5aRogwXl/QAVXmfM0jb
 EDgHbfn31ipSLM7FWxMwP42hQEGnYj/Qaf4BCX6Ua3S/vtTt6ZGiIEqHRVdwj0Ep7usk
 6MnFqLc3evgwIatDfCTC+fKEonKPe8FOZc96aYSRNH/0h7zu+NFPyOmuPknewozSxeZ7
 WI2QyCewAYTnpF3gxrbdKNfDEdyrQoTIhbncucF+zsOtBNhZsH/ds2/ETgJhuhTsqc/Y
 P5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752750928; x=1753355728;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W2plJ6J2I3uEkS9s/RoI/iLItjcXG/U6oXtMhASgX4s=;
 b=Jjd/9ezM+ixdbt/pNvZ5QRkAvhl1PxNCweSGOYjJw50Jzs9ZYdWUdt+F4HYb8kQvya
 VYd7iCKLh7Zqjs3Yfa4gGA3iboYYHtELQSonaFRrkqJ8B/8Pql1mYCw+l+q4O79WTKZj
 0BRujv+Crub6WHsXlQzNdMyhzRFTpeYgG+uwPLaiWpEdBAtdkqbFuK2L+NcIqP6IZqNu
 K7U1tj+2PlhD7G5xKI87I7HTDx5yU6nBIrCqa1Z3YL92RKeHNb+Zqq4CvjHoOKMjBvEc
 1aUB/W5okyRN3h0/sboFIHJ/qBJIy0HNoEpCkUKyx8TDbiapRz+a2EyqDSosO951Bnv3
 n6gA==
X-Gm-Message-State: AOJu0Yy7w/yLJwUw3eM6EiWGMNLLmG31dhXhOuEzcLSVEth52kVQOs6J
 ZwCvedXnTuket1LpQA+G/Sog4dcNO+AHVNblyzZfE+3LvaoUVwoyX0wpHsFPPcvR2m8=
X-Gm-Gg: ASbGncuUk6xwrDqnAZ/EGIaWPsv6MHxC2sKF2zxpXVue8nhd2E+IMHFOCyaFdPYTpFA
 WJWzxSH8lRtJMZuYclR7HL60XrDPYjZSu4waNEG66BfsEL32LftRwhY/33kCJYSWDRcNoHFRUP5
 ZNc8/Yy8Y1xXD/2wts5xdwGqKT8k95gHJCjV8qp+oUX1qdzycsII1+YSQPoUgVzfiLfhOU6mAOT
 WKsQADiSKGfkTQIGWD9ZwwFmmCgIZw5Mwh1WlzeOxViPtjvScs6dkWF2OR2SOdrRi9C6Ay8mxt7
 nJCRwqnS2l9wqw/TcyPhTsosWM2WK10cSjMbzgSZ1O3lQ3ket74rp6rGhTjI9j5GLbKy+GnAbWV
 hc4+MrETsb+TjntmK2ILZZCfLnEw4ogzSHiz/dZZOb3t52zKnZ0fXXmDrG8lQ2bwsqg==
X-Google-Smtp-Source: AGHT+IEwBtS17vkQ8tdLBxf1RxtutMZw9AuH/KjjR/nrxLAS7JNDF7P05sbX5z37XDDZdwwm28dKWQ==
X-Received: by 2002:a05:6000:144f:b0:3b5:e5c9:93c5 with SMTP id
 ffacd0b85a97d-3b60e54ab07mr5290509f8f.49.1752750928099; 
 Thu, 17 Jul 2025 04:15:28 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b60e3ed902sm4473107f8f.91.2025.07.17.04.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 04:15:27 -0700 (PDT)
Message-ID: <e941efaa-e856-40b9-8ed7-0b4053f25498@linaro.org>
Date: Thu, 17 Jul 2025 13:15:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 3/3] hw/arm/virt: Warn when HVF doesn't report
 IPA bit length
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>
References: <20250716172813.73405-1-philmd@linaro.org>
 <20250716172813.73405-4-philmd@linaro.org>
 <84250F37-CCCF-49A2-8CB1-5B5CD1839004@ynddal.dk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <84250F37-CCCF-49A2-8CB1-5B5CD1839004@ynddal.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 17/7/25 12:06, Mads Ynddal wrote:
> 
>> On 16 Jul 2025, at 19.28, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Emit a warning when HVF doesn't return the IPA bit length
>> and return -1 as "this accelerator is not usable", allowing
>> QEMU to try with the next one (when using '-accel hvf:tcg').
>>
>> Reported-by: Ivan Krasilnikov
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2981
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> hw/arm/virt.c | 8 ++++++--
>> 1 file changed, 6 insertions(+), 2 deletions(-)
> 
> I haven't been able to verify that hv_vm_config_get_max_ipa_size and
> hv_vm_config_get_default_ipa_size fail if HVF is not available, but

This happens with nested macOS guest. Maybe we are missing an earlier
check whether HVF is usable or not, but we shouldn't brutally abort().

I'll try to update the patch description. Annoyingly the GitLab issue
reporter isn't Cc'ed via the mailing list.

> assuming so, it looks fine to me.
> 
> Reviewed-by: Mads Ynddal <mads@ynddal.dk>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40B5C83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXbfs-00006s-J3; Fri, 04 Jul 2025 04:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXbfq-00006P-Ju
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:21:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXbff-0003qg-UV
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:21:34 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so7198365e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 01:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751617281; x=1752222081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j3pmj4E+UUNkJ1VujNm/R+83vDV6n8W8GdGh9Qdk8y4=;
 b=w8M1E7t+fpia9osPpZxvSYx31lnZz3okVSqN0853U6H28O18a7ZH7K+BH+hpayoKkH
 kEXjS4J3LnYikvCwxKnNyI5s1jNXDLBDjhsiEW8qD1qGVeJTahY808+3unkqkx8rtHix
 VHhCjiGxbKG1lf2wOULn3iMIydM+SSK4ikq0D9JG3Ohku0sjZpl0tuscNDG8K5XHe6Gd
 ZuIzcC8N5tQ2KgDmRg5Xfsdvnj7Y4ceIF8kuaZKaVRuGEj7EQFIqQWlEOZ0O4MCmotr+
 JPeGLkxmVjjIkU0GmZHsjB+Bv/3ui0/+RxsUWaamY3XS797jk/2EHReD7Z8j+uYZxVdi
 6LHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751617281; x=1752222081;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j3pmj4E+UUNkJ1VujNm/R+83vDV6n8W8GdGh9Qdk8y4=;
 b=ipo9ooqiZ2bfyeZ8A2SW3uf9yr2J14SslsClMRWZGtG+bS7taun/DUr6yqWgsxa1Ha
 xZGqLUdaJiLZ7ld0GL3wlHw/zkOZELmOVxbifJLi6qYFOf14f9BVOAixH4lAfdv16LDC
 I9S6bQLngLttMVYQUfq/4JoUEtGd+Q2DAJzaSrtY1tg/a3L6LpLxTukyvOnuypuBxllK
 8cfaNOrKgYKasPTg3R4qi1Cr81JHKAKBlW1IqfLxpOUwovSGJsse71ibpvlrl5GmEi5I
 FP4ceHRVPSS4vmngZKcX7Z+RPcfmCMnIP7j1rN3/Dn3/B1ztCApVPT1Scw0eLgy7jzYC
 8ejA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVwWSOZ4XJQOyKxDYeuiwX/A5WViVxQN4yBsN2QNtVhDhk0lsDSq28ejuhtLylf1FheEFD6NAjdteE@nongnu.org
X-Gm-Message-State: AOJu0Yzi4clONbMI0aRJ2aeDgilzDUhPJgdf/RAak9pk3xg4YsaH/RUT
 WjgAdOTQ9DHd5GmJE8ZRw9fKcPv1KfisN+cK037sUkUua2qGVwhrfjnmMRmSrl/SiV8=
X-Gm-Gg: ASbGncv672zkw1YdISlXttJeYqFa+IuhCYtWOETPTR9lzyjZKnEEoC60KRIm28wgvKn
 XiJwvzPyylrUl1NT7qwZSQmf9GC/CaehAepT1JafU9xfyKqHzo75r/qFmlREPX7pee3GtnjB0hT
 wV/gAEm/gA/uVqlPreErSMgE6mQsGkAtLv1P4OpJWf9Un1g8e7BTSwKAz++MI4vwYh2X8s08pSx
 g4Tead2swKZVT1icK747FG7ROYBT2Ur6kwbTM+he5+/1zu48TSE3yjw8DqIhz6qoB0pelpd0Uju
 V+dDXsZctGNTB7oxvw2WWlI+9YknHmVXxJD5KKxfghKQQCDlqM8B5BLW5HnROhe5jV2vBkFIWUT
 9eQ2s5/neIF968pCKS2r7sH0mtDpjuQ==
X-Google-Smtp-Source: AGHT+IFvZWHBNDiai5xFq7PF+spIVJPNCfa7GkoFOOIkcg12a2z2991uw8TwcVM4nKHvVswmXYMI+Q==
X-Received: by 2002:a05:6000:4a0e:b0:3a6:f2d7:e22b with SMTP id
 ffacd0b85a97d-3b4970131d6mr715821f8f.18.1751617281181; 
 Fri, 04 Jul 2025 01:21:21 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47285bdf8sm1817467f8f.87.2025.07.04.01.21.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 01:21:20 -0700 (PDT)
Message-ID: <ed12ed2f-4526-437a-a3ff-95e20dac1582@linaro.org>
Date: Fri, 4 Jul 2025 10:21:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 21/39] accel/kvm: Remove kvm_cpu_synchronize_state()
 stub
To: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, kvm@vger.kernel.org
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-22-philmd@linaro.org>
 <06dc9c3c-ccd5-43e8-82eb-3198c7f358a6@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <06dc9c3c-ccd5-43e8-82eb-3198c7f358a6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 4/7/25 08:02, Xiaoyao Li wrote:
> On 7/4/2025 1:32 AM, Philippe Mathieu-Daudé wrote:
>> Since commit 57038a92bb0 ("cpus: extract out kvm-specific code
>> to accel/kvm") the kvm_cpu_synchronize_state() stub is not
>> necessary.
>>
>> Fixes: e0715f6abce ("kvm: remove kvm specific functions from global 
>> includes")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Thanks!

> 
> BTW, as what you do for HVF in this series that moving vcpu methods from 
> hvf-all.c to hvf-accel-ops.c, do you plan to move 
> kvm_cpu_synchronize_state() from kvm-all.c to kvm-accel-ops.c ?

While it doesn't seem obvious, I'm trying to consolidate the minimum
in order to have split-acceleration. The proof of concept is with
TCG and HVF, so I'll not do non-necessary changes in KVM.

Regards,

Phil.



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2F8C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 16:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5RuW-000235-FN; Thu, 17 Apr 2025 12:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5RuP-00021M-05
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:16:13 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5RuL-0004Wk-Q7
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:16:12 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso9078655e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 09:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744906568; x=1745511368; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jbNfPaqPJRQMZFffhX21mulhTFj1mBAF4Cs+EQ6HTkA=;
 b=ECguBEQPbqQOrsfU5IqQh6RPtPe+bKW+cuOCp8CpQmhp4Hh5cpzs8LRVslZ5W5wzDY
 9uDoi/ZEB84KEJsz74WQdvDizdNPL/JSJnsBmleSR9RoUiJXUXRu9hFntVPIWuCbwK2C
 qauKtct/jf83kemnJFN4uXsZ34l9HwYKsUZPpWQxeMlXu7pYd/gaQC/OeAfChZnA6Qvk
 VkqRK+DEy6tqzzZxy8ERnDz3/37c0+edYwsHjzdaPGmOlCUmjNlleZMCqF0ApVglZvCD
 IWDjQL5zGYQdmTHGCViww3MJULWtB76FG0t3LoWR0k3akIKx1r+Ofpc/VZ3tvjSU/7/s
 pm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744906568; x=1745511368;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jbNfPaqPJRQMZFffhX21mulhTFj1mBAF4Cs+EQ6HTkA=;
 b=TGZScG+AIXIpjeSOCOz/E80Pu1xrEOZBcH/+o19llhOS2Q+SqWiEYfqZuWbz5byNHE
 EJGa8TVPEzNToLrNU095hzR5YxFOVRLdN4KECeBX9kJplT4ishtskMSE7euEI4wm9kOz
 K+BYOnnFB1WmpozCetvpwD3qB2BYVJcZC2ap85tm1rzVQ4lPrh1ZYaNkBvclirBmhiWA
 nUZuCj3HI7+/cYH5czktw31i24mFvHzn1oMDOctxFTNalR2tYePjcQKbV8YuZzZuxYdC
 IbE38oUjfxAKUpfSFUyq5UGQw5Eo6legz5Csbghzw/Y0nh5a47CXkhskqAdUaN12yq5c
 OWog==
X-Gm-Message-State: AOJu0Yy9od34RVFoA+4RpLYDO/mv1X99VBg45Z6fBN84bkdNgnThN8q/
 MePy4KYPp+VHO+OUpQ0IOsjR4wsNFS8yO3+87ICHzj3YvF3d+kx4UJ6HQqa2UlabKB+vbvRhjPq
 W
X-Gm-Gg: ASbGncs/5DMyb4gHOYMD738xffYEtUiQiiZGsxnvLF6j/cAjr4OYVL16AFjr8oXm87d
 03iTMIJe40MGc5HOb7PYflZOJoad/JDqV3khN8jb7rwqvJlhejrukElz29ILjk08haLo3OpPtN/
 ruLFYxX19IGKQ4mHbHyiRM3HWoJ1sYyHvaxXzoQPeJ2qsVdccWFp7UVrJyB33kXsnxLYG15gDr4
 LrHLeJkzV23/XzKDhOkxySQX09A5tlpoQlvDnJy/IsZp3TUKLuiskjYcuEzAt37U8D2t5EqIMC/
 cwlDhR2/ZUHHue3nEvCk1t2evsL2xoqq6zd6MOMHt3T9UpJDa/vZ8N4DvLjteDOmwMU1O9AZ3pM
 alrl4zc5U
X-Google-Smtp-Source: AGHT+IEkXf243kTEnx/88yjzHs8KS48n10YWZTKQMAf5uXdCx+txc0utmvAv4NOKOgGo/ZCCLBmxYg==
X-Received: by 2002:a05:6000:430e:b0:39c:1404:312f with SMTP id
 ffacd0b85a97d-39ee5b12fabmr6213013f8f.1.1744906567732; 
 Thu, 17 Apr 2025 09:16:07 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43d22esm30948f8f.52.2025.04.17.09.16.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 09:16:07 -0700 (PDT)
Message-ID: <72583204-e3a3-440b-9a50-66ee011437cd@linaro.org>
Date: Thu, 17 Apr 2025 18:16:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] cpus: Convert cpu_list definition to
 CPUClass:list_cpus callback
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eric Farman <farman@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250324185837.46506-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250324185837.46506-1-philmd@linaro.org>
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

On 24/3/25 19:58, Philippe Mathieu-Daudé wrote:

> Based-on: <20250324165356.39540-1-philmd@linaro.org>
> 
> Philippe Mathieu-Daudé (7):
>    cpus: Introduce CPUClass::list_cpus() callback
>    target/i386: Register CPUClass:list_cpus
>    target/ppc: Register CPUClass:list_cpus
>    target/sparc: Register CPUClass:list_cpus
>    target/s390x: Declare s390_set_qemu_cpu_model/cpu_list in cpu_models.h

While this patch builds correctly, I'm squashing it with next one as
suggested by Richard, and queuing the whole series.

Thanks all for the reviews!

>    target/s390x: Register CPUClass:list_cpus
>    cpus: Remove #ifdef check on cpu_list definition



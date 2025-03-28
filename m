Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4705BC28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 18:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyE4l-0001wk-UU; Fri, 28 Mar 2025 14:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyE4i-0001wP-NU
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 14:05:00 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyE4g-0004k5-JV
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 14:05:00 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so18119375e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 11:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743185095; x=1743789895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QHjP/YKXhLWoIr4nXTAjT7jA/tINeXrzU2bH0vCq4Ck=;
 b=sCNd4i8PUFVE1eFiPA8oemIzFYRJi30it7sJwKK+Qhms2kFCw7r9nF80K+meUQdm77
 Sfki3lFLSSHMATxOGRJMoMDrnmtckoCHWgVlCidXClz7aYOhrNKtoQTtZwmOj0R8VfN6
 cucE35r1UTrq3whEDvenTVF2E0fOAqj1jzTmVq4P3sZsh7SqZfz/fHtT8tDpmtpbMCNY
 LGdeL37vu7Sqmv2+RgCRgD0T5MZKsofjzX5JcTVHo5exoPbVXgpURowmLOLSPjJSjza2
 J5ePveZ5PFRbDtUyPzWDIqXcv12UV2AN4ilMZ/7Q1nYx0peFfJnGaH0gJZ68r+i/bgCb
 W7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743185095; x=1743789895;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QHjP/YKXhLWoIr4nXTAjT7jA/tINeXrzU2bH0vCq4Ck=;
 b=MG0HZEv+Cq6AgzBc14cKm0w9+qcT3qIZYPtoO2fnLafydvC69rRT2TeoEiJTsMNs3K
 t70qVTaoe3KbJopZ1dDhmyqx/7nm5nvD0CXQIetS+D8GMjrkna6ZG0qN9c1kCjFCsN1p
 AqHSvjr058THs797Ii0BTfKV9tdyxvRgrysk95w8MFbb8O+iMPUBzw9O+/KDYMQ6GqyY
 22+55XNCF+WWUsnaRpnsFu4TtYpper2btaB779NKHOfQtDdjVbA0NVPK+yw+TD/QSkfn
 n6I5OKWVmPpW8OvyLWoNvABNn2c4ihDzhuifq9IqalNMni/xOrMEuw741jw2wbpFSNdm
 UsnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgmgh/tCTNhp4ctwG7hNX1ZO1p9L37kNo4WqOnnYEMyirok4AR2vA1nOZpQXxf+euMBQvwkApTNemZ@nongnu.org
X-Gm-Message-State: AOJu0YzT9X3m5La2O7zmh253V8gzSa0RtHiz1oj2OqvbnE8DZl5iemy7
 +f8wIr2fIaggR1ht32tL8EpS17NPhvrVHGLka7S1dJY0VYziUfuQg/T0KtGmuWk=
X-Gm-Gg: ASbGnctKPAoDj3XGlTAXN35X2wLpqtjmEdgtoyN4SepIa7SBd4VovHML4xCB9cYAY5R
 tCnEbo0TlsodUAd5JdCE3CBCTR7uX0olOt2ejJ7F8qeCPc0UYw+kbXsaiTppQsofq7ePSecgTba
 Yn0HBzCqn3BVnAux9vbGRJ/fMR0fuxBubU+A9Kv+BxsGKD3Sz1p/D7zPxsU1qvJVKe/1HNZJhYF
 /MoCrG076nMAxgOIVBdsRH+OIkMSlyHnXxuWI0NgpdNtLmdyTUTDdruCPcvvAmPYwI0JSKYF9Fu
 7mMesfYs3kM1u1x3hhJH/pbQWiJNgtWwsRB4Xz5ykfX3CqtNqBMGN/KOKpMe+RidWjFhPtxJScR
 7/W3QcRwSO1fo
X-Google-Smtp-Source: AGHT+IHNWEeyVbg7i0Cp32DblEZfDTVW4rHwKlZ3otnD/FjvunMIrddE278DMIw5xZoY7mFtGtDwAA==
X-Received: by 2002:a05:600c:4747:b0:43b:c95f:fd9 with SMTP id
 5b1f17b1804b1-43db5fbe009mr4611675e9.5.1743185095245; 
 Fri, 28 Mar 2025 11:04:55 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fbc10f7sm35975175e9.14.2025.03.28.11.04.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 11:04:54 -0700 (PDT)
Message-ID: <6682f611-2cfd-4651-b3b5-3072e18ee46b@linaro.org>
Date: Fri, 28 Mar 2025 19:04:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/scsi/lsi53c895a: fix memory leak in lsi_scsi_realize()
To: Zheng Huang <hz1624917200@gmail.com>, qemu-devel@nongnu.org
References: <73cd69f9-ff9b-4cd4-b8aa-265f9d6067b9@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <73cd69f9-ff9b-4cd4-b8aa-265f9d6067b9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 28/3/25 04:21, Zheng Huang wrote:
> Hi,
> This patch addresses a memory leak bug in the usages of `timer_del()`.
> The issue arisesfrom the incorrect use of the ambiguous timer API
> `timer_del()`, which does not free the timer object. The LeakSanitizer
> report this issue during fuzzing. The correct API `timer_free()` freed
> the timer object instead.
> 
> =================================================================
> ==2586273==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 48 byte(s) in 1 object(s) allocated from:
>      #0 0x55f2afd89879 in calloc /home/runner/work/llvm-project/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:75:3
>      #1 0x7f443b93ac50 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5ec50) (BuildId: 224ac2a88b72bc8e2fe8566ee28fae789fc69241)
>      #2 0x55f2b053962e in timer_new /root/qemu/include/qemu/timer.h:542:12
>      #3 0x55f2b0514771 in timer_new_us /root/qemu/include/qemu/timer.h:582:12
>      #4 0x55f2b0514288 in lsi_scsi_realize /root/qemu/build-fuzz/../hw/scsi/lsi53c895a.c:2350:24
>      #5 0x55f2b0452d26 in pci_qdev_realize /root/qemu/build-fuzz/../hw/pci/pci.c:2174:9
> 
> 
> Signed-off-by: Zheng Huang <hz1624917200@outlook.com>
> 
> ---
>   hw/scsi/lsi53c895a.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



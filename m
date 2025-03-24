Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EADCC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twn6N-0000J5-Ih; Mon, 24 Mar 2025 15:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twn69-0008Uv-E3
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:04:35 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twn67-000206-LB
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:04:33 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf58eea0fso25598885e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 12:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742843070; x=1743447870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sAIi8sY1/6UcMbAwH0Ltev7RUjxPEZQiK6iEY7B6m4M=;
 b=oGiCS6zefsNB4q8CLgjsHgEd/wBvmrMtV+G7yVfkGhae9TrMXgt8zIiPLnylyFsbuE
 ITXbGxS/7t4+9z5BbcBQR8yUEJisFkC9hNBvoabjwFzrLfDiiRTFEHnyGVxMTnq4s8Ou
 hdowdGn8SM3s3Tf3NfoaNoBdhqCNYg2mRfOHQuCLWUZFOuFrfQNHKUM8z+yoOIx6sdqL
 3JuiFnLq0o2H1yuGKJ1XmhlzLuYlbcwMUhuCc99izycUtBt95D2UDCCFKCDQebkwF18A
 JiLPe6r2ndSof4t8cuBC86doWQSTZBoGsGCkWOr73n8L8bhpW2YyXi9WUmIfcFFp4xRk
 7CoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742843070; x=1743447870;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sAIi8sY1/6UcMbAwH0Ltev7RUjxPEZQiK6iEY7B6m4M=;
 b=jjP3JCyk5SjjwyPshtOpJoqphJgQEV756qsEbj8XYTYr5gY6Ho9iUc6YUIreposTx7
 zMcgQsx89F7vMB9+WgA3dZ4yUnYZOpeQOrdNJsyhZHtvYo4xt76vpJC5QMhiYXBKdu9x
 s42pjZO+YcyNNI80tDA6Byz7foP8syK91ln8cBrbi5l4evIflKUZO2rM+zMFVEVyUqGQ
 pTb28hlwRo5AEWYPyc4cwymPVGa6R8MiDDxyOqvcCF/s1Rf66MSkzDvIJ0Ydc/aAaqJl
 HKz8Ii1Y8XGnrNa7BEYbSyXvuaU2JhOTd1ePtWolOS/PItxAgXo2bdWcKB5CVt/2PGTa
 FhRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5DaStUWtoYxfjBeMqxsFWQxxaQSA4XcZ0NMHpeSms1BE/zE8u0w2M/sBK6VadMMIfSi3FETgx0C73@nongnu.org
X-Gm-Message-State: AOJu0Yx0IRVXIoEnPJ2PzgUx1yJfUX/vXprcpBYA7k/XTv5e9kn3dvlT
 TPGJ2UpVYbd9eZf4bsR/r2ljDzB+Avn8GgViNwbdWm7eJGHUlc5ZATzmYbx0rhE=
X-Gm-Gg: ASbGncvAAu7N+iVatk6jKgfHRyKwM0wU2PYxgnRfQ6bLuFtTZakL6bPOuFS8QDgrI3z
 yEZQ7nBrk8J9pJxg9GdFtQtKs4YKEPieoqOlGJm+tQn2fW2pFyf5oG6nqBrVUogxU3Q75OKloeX
 HiUxKSqlFlyTAzYfDo8hw6PuyfJIbG1ulFHgUBSL9bhzEl3BwMNuQmk8yTNyOpYyoxCOEI5oUFv
 dmoaqiRu3dDx/z7xcW0zQguEU81sM/nCt8fIi92WaY6tRha6ClZHSZxQGw+QnDSWqu3NhryBwI9
 feXoa6dx8QmNUe0RUCIjDdgDpAOeeApAKZwpqWvaih66nN+oPmXz0n9UrbVcYz4T3d0TZ02ZcZg
 VE7oFe4bZLJvxWs1y7Q==
X-Google-Smtp-Source: AGHT+IGXtR8qjGz6X4eudYun6jC9ohoqp1Il0rW0zVMqgEp7lGz2UdVLGTuu9m0p4ouYZb/rvoap6w==
X-Received: by 2002:a05:6000:184b:b0:390:d796:b946 with SMTP id
 ffacd0b85a97d-3997f932d65mr14002256f8f.44.1742843069886; 
 Mon, 24 Mar 2025 12:04:29 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b260fsm11529002f8f.43.2025.03.24.12.04.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 12:04:29 -0700 (PDT)
Message-ID: <793cf6ca-3aaa-4aad-a625-43f21feca6ef@linaro.org>
Date: Mon, 24 Mar 2025 20:04:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] target/s390x: Register CPUClass:list_cpus
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eric Farman <farman@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250324185837.46506-1-philmd@linaro.org>
 <20250324185837.46506-7-philmd@linaro.org>
 <fb9e488b-b6c4-4270-aeaf-d5bbffa942c4@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <fb9e488b-b6c4-4270-aeaf-d5bbffa942c4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 24/3/25 20:02, Richard Henderson wrote:
> On 3/24/25 11:58, Philippe Mathieu-Daudé wrote:
>> Register s390_cpu_list() as CPUClass:list_cpus callback
>> and remove the cpu_list definition.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/s390x/cpu.h | 3 ---
>>   target/s390x/cpu.c | 1 +
>>   2 files changed, 1 insertion(+), 3 deletions(-)
> 
> I really think this has to be merged with the previous.
> I strongly suspect that it either doesn't compile separately,
> or doesn't function as desired.

It does compile, because "cpu.h" includes "cpu_models.h".

I don't mind squashing if Thomas is OK.

Thanks,

Phil.



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF9AD6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBf29-0006No-3l; Thu, 14 Nov 2024 13:57:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBf01-00029z-J7
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:55:29 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBezy-0000Ic-Em
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:55:24 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5cf84214e9bso686359a12.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610515; x=1732215315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w0naVAqBaBhnTo/FtWYOVxr5hQzfywoobRP2hZPRLNs=;
 b=OZD85ZfsGo3NA18kQ5LDTHjS0+hhR2KkqK3x3qKjjwxNx+4vYXZ6L966+zJfqoShKw
 ANL5JqzNx39A9J0KWOEO3JBQth8ei9BSLGoIqIU41/Mj4Rk3ApxRXWI2OWWyZKCnTpE+
 z/Ttmd5chLK7WUCHe0lYtIN7zTotLMdHxt0UQ/c+LFUHeM00t4KXMzzk1lfqvikpo1Xw
 cFAckYzTRBPSa/0jnT1taCE1xrmB38DbGkOrxUvghqwjUuCcj2/o8aOZeWl4NvdkbboF
 29LZSETgLs+FuZo8q/75SPNo2UKUwDHiDZSQljoP5x9tN8XeLlUeHQUMxMzxU75Y9vQ6
 jbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610515; x=1732215315;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w0naVAqBaBhnTo/FtWYOVxr5hQzfywoobRP2hZPRLNs=;
 b=tXJp5lf+axWREbhTfB26Qr6Dl0Ax9oWy5Lt4inV61X1posGrN306L+rNCExEpmCgLg
 gZYQvKxOHoexFBtDYCYmS5TgxHDSKDwtNmTSGkNB5YGxDh3OehWcENqhO560j8DIRF7n
 jblVKFxVlBcnFSOLQyXKBa+0ActJK9GaLkN7TI+kwACeNYq9MYMIpfx7mj0PNYW1F+Lm
 Uk3zaq6+4EWNLZnETuzr29AQjLbc49l4VNEnY9f+WRVH6w01lhx7wCT03OtGQTvRrZcx
 Zi3ADkzlNb2XLxOLdmUyiU6wW6sQIn/+a8YIp/XhDEzk/uyUL80eQmlWSDREJYt45f4X
 1soQ==
X-Gm-Message-State: AOJu0Yw5AlCUefqNcf8vzKZIeaPiyea7NogprypZD7jWZsv42+wX9I76
 TGBVn2e4z3S3o+fqo9baLt8g7wLoDDw9xRKLBCsBVQQUkt2p/guHqHkRl8qbg2I=
X-Google-Smtp-Source: AGHT+IH9DCL4VEY6XlHhsr9ETN/JO6qiX3alagG6WYIncrj6066l7GvCphN7d/OXf+rv/GKymWKM5w==
X-Received: by 2002:a05:6402:510f:b0:5ce:af48:c2cc with SMTP id
 4fb4d7f45d1cf-5cf0a43fd2cmr22577511a12.27.1731610515326; 
 Thu, 14 Nov 2024 10:55:15 -0800 (PST)
Received: from [192.168.69.174] ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf8d0958f9sm71652a12.14.2024.11.14.10.55.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:55:14 -0800 (PST)
Message-ID: <0cf1cdc6-442f-45f8-b1e7-346b236b516a@linaro.org>
Date: Thu, 14 Nov 2024 19:55:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] hw/net/xilinx_ethlite: Map RAM buffers as RAM and
 remove tswap() calls
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
References: <20241112181044.92193-1-philmd@linaro.org>
 <ZzTHj3uHGfc2Z8Dd@zapote>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZzTHj3uHGfc2Z8Dd@zapote>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

On 13/11/24 15:36, Edgar E. Iglesias wrote:
> On Tue, Nov 12, 2024 at 07:10:24PM +0100, Philippe Mathieu-Daudé wrote:
>> This is the result of a long discussion with Edgar (started few
>> years ago!) and Paolo:
>> https://lore.kernel.org/qemu-devel/34f6fe2f-06e0-4e2a-a361-2d662f6814b5@redhat.com/
>> After clarification from Richard on MMIO/RAM accesses, I figured
>> strengthening the model regions would make things obvious,
>> eventually allowing to remove the tswap() calls for good.
>>
>> This costly series mostly plays around with MemoryRegions.
>>
>> The model has a mix of RAM/MMIO in its address range. Currently
>> they are implemented as a MMIO array of u32. Since the core
>> memory layer swaps accesses for MMIO, the device implementation
>> has to swap them back.
>> In order to avoid that, we'll map the RAM regions as RAM MRs.
>> First we move each MMIO register to new MMIO regions (RX and TX).
>> Then what is left are the RAM buffers; we convert them to RAM MRs,
>> removing the need for tswap() at all.
>>
>> Once reviewed, I'll respin my "hw/microblaze: Allow running
>> cross-endian vCPUs" series based on this.
> 
> 
> Thanks Phil,
> 
> This looks good to me. Have you tested this with the Images I provied
> a while back or some other way?

I'm running the same functional tests run on CI:

$ make check-functional-microblaze{,el}
[1/7] Generating qemu-version.h with a custom command (wrapped by meson 
to capture output)
[1/7] Generating qemu-version.h with a custom command (wrapped by meson 
to capture output)
/Users/philmd/qemu/build/pyvenv/bin/meson test  --no-rebuild -t 1 
--setup thorough   --print-errorlogs  --suite func-microblazeel  --suite 
func-microblazeel-thorough
/Users/philmd/qemu/build/pyvenv/bin/meson test  --no-rebuild -t 1 
--setup thorough   --print-errorlogs  --suite func-microblaze  --suite 
func-microblaze-thorough
1/4 qemu:func-quick+func-microblazeel / 
func-microblazeel-empty_cpu_model                                     OK 
              0.18s   1 subtests passed
1/4 qemu:func-quick+func-microblaze / func-microblaze-empty_cpu_model 
                                OK              0.18s   1 subtests passed
2/4 qemu:func-quick+func-microblaze / func-microblaze-version 
                                OK              0.18s   1 subtests passed
2/4 qemu:func-quick+func-microblazeel / func-microblazeel-version 
                                      OK              0.18s   1 subtests 
passed
3/4 qemu:func-quick+func-microblaze / func-microblaze-info_usernet 
                                OK              0.28s   1 subtests passed
3/4 qemu:func-quick+func-microblazeel / func-microblazeel-info_usernet 
                                      OK              0.28s   1 subtests 
passed
4/4 qemu:func-thorough+func-microblaze-thorough+thorough / 
func-microblaze-microblaze_s3adsp1800        OK              0.57s   1 
subtests passed

Ok:                 4
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            0
Timeout:            0

Full log written to /Users/philmd/qemu/build/meson-logs/testlog-thorough.txt
4/4 qemu:func-thorough+func-microblazeel-thorough+thorough / 
func-microblazeel-microblazeel_s3adsp1800        OK              1.50s 
1 subtests passed

Ok:                 4
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            0
Timeout:            0

Full log written to /Users/philmd/qemu/build/meson-logs/testlog-thorough.txt
$


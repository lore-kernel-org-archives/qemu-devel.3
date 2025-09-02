Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF8FCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utONq-0003JS-49; Tue, 02 Sep 2025 06:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utONo-0003JH-EB
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:37:00 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utONm-0001pc-6t
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:37:00 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45b7d87b90fso35113465e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756809415; x=1757414215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uwHm6mbj2pyWy2tbuuYIuRmq6LSOJTP7MuQQ0+qBY/0=;
 b=WhFeJgqUzDJZaUKDBSv9pjLEtjU4FpnMVhz8Xo3rTApPl+1/Vg1eqI1wVf7yez5foe
 maFrz2WOVQK0m4N2VIFg4hYnb9CJC7EDBU7hlS+KIIjuJzOVoabgVv1CJvHP6FjC0etO
 YhySXlFPqDk8519uYZKw4nhY/ZA9qaFJUbDa3qgaOMfo9jgE4ZS8Vac1L0DPTkWOKnlw
 vKeDKhv7lUFv92TNRE8R5bzcUvBcx1cMk9nKUoFZx0ev/U7qH+S+Mkw5vEhN0sLcWp8a
 N7G7CEujxuf1DRMyNvdeYYtdt4G25O3EEwsrpI7CRrZrqydTkGV0FNuHCW+uwjOCsTyj
 A1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756809415; x=1757414215;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uwHm6mbj2pyWy2tbuuYIuRmq6LSOJTP7MuQQ0+qBY/0=;
 b=P3vPESuMddqYbKR0t/yaYnsiRIKwH+bVOjAITKBFZ6JMuOQOHyawPwOjGm6w5OSti2
 EaSxHgoNyY0UNkdWJpMvy1JsAI5399N6KL7wcsTlJQyo/9o6tkbiEsdII3SGhTGnpqhc
 S0jp2AeKIwIq9GpsAosFp5ZN9HwZsG6EpPGGCI/7ZJT0YI1XO6/ovxOlNkPbZaggL1ei
 /vaG/5YURjEjWQlzcM6ZXUKL7gMON6GdDYeLy3vzYM5jv4h8NJZ4rVPIsq0XWUHkIa3R
 HId19gousednU1hsLDl84shXPOmCJPaf/t/XR/a4mERkx5UtZcRsUwSYomXtRPMGyAja
 2ykA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4uchK8Wuqa61MgFRZIKOa54fsofKgvoABYKq0MUayAo/kkSIzMKBy2pMjYdr4bz02uWIjZLKFmjSt@nongnu.org
X-Gm-Message-State: AOJu0YyevfNUNO+/EHZIQVThQcvaIY7E4D54Tn0H6bMGAchhPqPHSn/x
 BLZjv5oQrFIf+8MK6cKXrC1M0deWb+OFH/lmdc1jH1Wd0GneZ9AEksGfxaQGItWLzSMFk39f91U
 agCJVTD8=
X-Gm-Gg: ASbGnctySZO4MzuPHCPqVhnFo5e82Xa/TfNDtYmGpBZL0Dvp5qENB6t9wJCq3m0QIOP
 G4gGZ6zzFhQFWL6vul2ZUOL/ZARde/Ebbj203NeRnLk748l07boxN8vF+uH6f4/AwyPuuDAthoU
 yAIv+iiCZq6/OWVp7wgJKa9F0SXVCQRsTuqBQ1lM5J92Qw1kcNTstCHIalxYy6NYC8XdrvhdehM
 lKlGtxVPstXX6fr6SzphYwkfyb7f1wKw8XevbkRrt+qBuYhXjlhXd3DNU5WZ2Rt4p9OAypqnKfD
 n27ZdBjHFO7BPtGShY/qqVo30svCWPO7O6u4/RAtCaVRshmIJOSJas2gE7eROk+VO5bJE8OvtPd
 j1AQ0cJJkNrq7O4alonGqkxrZcbQGrXRz3fk9fEoLjlVr6vW+ya1LumSjqaq+X1j7Xdz5r24gE8
 Fen+fKfw==
X-Google-Smtp-Source: AGHT+IGmzsEhtijGxzR/ld5B0R5yOn760gfx4A5f9VONaR/cPH/R5Wv8hfhHeIf5b53H/omMiEGADg==
X-Received: by 2002:a05:600c:c0ca:b0:45b:8b61:396 with SMTP id
 5b1f17b1804b1-45b8b6104f6mr45560205e9.18.1756809414911; 
 Tue, 02 Sep 2025 03:36:54 -0700 (PDT)
Received: from [10.20.0.233] (151-0-205-164.ip282.fastwebnet.it.
 [151.0.205.164]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf34491a65sm18864650f8f.56.2025.09.02.03.36.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 03:36:54 -0700 (PDT)
Message-ID: <c080bfe4-9aff-48bc-b99a-b9045fabb3e6@linaro.org>
Date: Tue, 2 Sep 2025 12:36:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests: honor $TMPDIR for test_virtio_version
To: Michael Tokarev <mjt@tls.msk.ru>, Maxim Cournoyer <maxim@guixotic.coop>,
 qemu-devel@nongnu.org
References: <20250831125255.7066-1-maxim@guixotic.coop>
 <c1b6e93a-1c85-4626-8ea6-5efee2bf9489@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <c1b6e93a-1c85-4626-8ea6-5efee2bf9489@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

On 9/1/25 16:41, Michael Tokarev wrote:
> On 31.08.2025 15:52, Maxim Cournoyer wrote:
>> Until 10.1.0, the test suite could be run without having a writable
>> /var/tmp in the build environment.  To avoid now requiring /var/tmp in
>> the build environment (which can be a very minimal container like in
>> the case of GNU Guix), consult TMPDIR first, using /var/tmp as a
>> fallback.
> 
>> diff --git a/tests/functional/x86_64/test_virtio_version.py b/tests/functional/x86_64/ 
>> test_virtio_version.py
>> index a5ea73237f..501545f655 100755
>> --- a/tests/functional/x86_64/test_virtio_version.py
>> +++ b/tests/functional/x86_64/test_virtio_version.py
> 
>> @@ -68,7 +70,9 @@ def run_device(self, devtype, opts=None, machine='pc'):
>>           """
>>           Run QEMU with `-device DEVTYPE`, return device info from `query-pci`
>>           """
>> -        with QEMUMachine(self.qemu_bin) as vm:
>> +        with QEMUMachine(
>> +                self.qemu_bin,
>> +                base_temp_dir=os.environ.get('TMPDIR', '/var/tmp')) as vm:
> 
> I don't think /var/tmp is a good choice here, - I'm a bit surprised it
> come from you when your OS doesn't have /var/tmp by default - shouldn't
> it be /tmp here?
> 
> Overall, /var/tmp is a strange choice here and in a few other tests too,
> -- maybe only block.c default is the only right place to have it as the
> fallback/default.

It's possible that it's the testsuite that should be changed to prefer /var/tmp when 
present and TMPDIR is tmpfs.  I don't know enough about what prompted the original change 
in the first place.

But my point is that with *only* this change, it is very likely that this simply exchanges 
one set of failures for another.


r~


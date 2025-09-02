Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185D7CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 08:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utM4r-00010N-P1; Tue, 02 Sep 2025 04:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utM4m-0000zm-VW
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 04:09:13 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utM4k-0004LA-Qt
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 04:09:12 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45b869d3560so23768785e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 01:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756800547; x=1757405347; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fZAQmyhL9WvLuF0TmRf8zR7pBwGxwEwQ7hLm3IvksBI=;
 b=rUueHulld5R0tVhFOUkEJvAkIzGuQmnLgJcLrsNl9/28zurA52UxTLXrjhcDH4aUQz
 sPP6P552C5gZk8vsxJ8VtLsUHR/dbFnG9//e/awvJc7srYFzC1MIL3tjOQGi7NknAVja
 hTYDDCMLJi7SF6G1RF8HQp3k3ELSBrBayDHXh9W9fhSq7aHm/04SzT1kAEX197+sCyJc
 BlvA+Mm28OuI2LaBMGrHJCJlvHM6hFcdnHE7L1op8/paj6ll/n9VDkcgqbx78jseUucc
 BNW3SuxlMbtXLxvd5lxwz7mrSiYIBeO8yjiuPQJwUcpPzMhH56r0RA+al+aGcY/y8L6r
 q8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756800547; x=1757405347;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fZAQmyhL9WvLuF0TmRf8zR7pBwGxwEwQ7hLm3IvksBI=;
 b=D6yOOtNnCVeopB3Ru8Vdne9nqdAZGCPX8x8nB5Ah+qJrY5en4UBcmlXq8VZORRnkWf
 KjAd+qNYbCTlkwVVTUlsoZjREFisNNgFLqQjQSaRP7jZCXccad2phyCEKQ9r120kiOYi
 kdeAtxcBZZbk5ynTStTUgsdL3t1DJkl/b5Qwy2Ssr0K8lCSP930E38iBsOkEiap9YRZa
 bFwfWjhJtHQK0FZ+XoYGuya8HcLjWfNOkhzjZuwBr754X7WjN9V+65z7yvE1j+gLtoVn
 6yHfrm7fuIOkvXaFB0/0n1HunG1fM3gRVGCxQx605jADWkQ43wvjq8QwO+QpiR3PY5kq
 nW7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXij9OIsLkHblGaZjaZWU3h+xykdYEaldxYgvLh70PCCLKVtRAWMprAwMPNmjFfq5lcCx5GyHXx0sAZ@nongnu.org
X-Gm-Message-State: AOJu0YyR74oFMiBK+XqNbJOkGKNwaig8GrA/7TlbL/0oApKIE6czuPS5
 BtyFz+XqEJHl4ZMKGuNwaXmesViuQMrCqzKUlNkUQzZKjsm6SudULsjkt9AppDoTfIw=
X-Gm-Gg: ASbGncuLEpFcqJHi9grp+qpPcNxqqf7cHCU12bnbX0rZknaVHthE+YDZrvtVuWs2IzZ
 mGrsiZgpeJBLbu7xkiL5w+Pa4nw9UjWK93vt/OM6DBw/u13+dEm3jsIuNGNK5ibqo+bUM/GRWnG
 sOEW8b7P0+FU6zl+b6MBn5BUxFi55p1qMbqypzuuyHzfL+Jy6RQiiGbJKawhCFSH98RzGz/ojQr
 vjjRl9fU1S7xpm/fD+us5EH00Myq21ixncDVU4JhDxewsfJyUP9ChEKuh4bFhVHJ50J+6o1tfLo
 6jmAJXXjwymOH1Vo0Lr4CFyjoGSh8oQjL4wqunSAwLSBxRaxqMo+wIjCPYuxXcSCiPou50G7Hty
 jdTV+91bi+AzAbjxME12Hhy9pGYj30NqgVL6olF5WA0DDtCMlqSnRiCCNLy+FsYzmoLi2aZo9QD
 dx
X-Google-Smtp-Source: AGHT+IEcZxyARU1pYsnG5Ql4gDIOUxF+nOV1OhtIS9u1TW5PzGskgeQCaKgjSBiAdIpCe2EkUuemkA==
X-Received: by 2002:a05:600c:5486:b0:45b:8d2a:cd09 with SMTP id
 5b1f17b1804b1-45b9bd607a7mr2761025e9.13.1756800547367; 
 Tue, 02 Sep 2025 01:09:07 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33fba9fbsm18654326f8f.50.2025.09.02.01.09.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 01:09:06 -0700 (PDT)
Message-ID: <186d81e1-220c-47b2-a899-9f48520b44ff@linaro.org>
Date: Tue, 2 Sep 2025 10:09:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/loongarch/virt: Add reset interface for virt-machine
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
References: <20250901081900.2931303-1-maobibo@loongson.cn>
 <e99ce8c4-b2cc-4eba-a947-f150330eda34@linaro.org>
 <a205202e-7d0d-0739-ddd6-11a2081a9810@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a205202e-7d0d-0739-ddd6-11a2081a9810@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 2/9/25 04:27, Bibo Mao wrote:
> 
> 
> On 2025/9/1 下午6:51, Philippe Mathieu-Daudé wrote:
>> Hi Bibo,
>>
>> On 1/9/25 10:19, Bibo Mao wrote:
>>> With generic cpu reset interface, pc register is entry of FLASH for
>>> UEFI BIOS. However with direct kernel booting requirement, there is
>>> a little different, pc register of primary cpu is entry address of ELF
>>> file.
>>>
>>> At the same time with requirement of cpu hotplug, hot-added CPU should
>>> register reset interface for this cpu object. Now reset callback is
>>> not registered for hot-added CPU.
>>>
>>> With this patch reset callback for CPU is register when CPU instance
>>> is created, and reset interface is added for virt-machine board. In
>>> reset interface of virt-machine, reset for direct kernel booting
>>> requirement is called.
>>>
>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>> ---
>>> v1 ... v2:
>>>    1. Add qemu_unregister_reset() in function 
>>> loongarch_cpu_unrealizefn(),
>>>       remove reset callback if vCPU is unrealized.
>>> ---
>>>
>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>> ---
>>>   hw/loongarch/boot.c         |  9 +--------
>>>   hw/loongarch/virt.c         | 14 ++++++++++++++
>>>   include/hw/loongarch/boot.h |  1 +
>>>   target/loongarch/cpu.c      | 11 +++++++++++
>>>   4 files changed, 27 insertions(+), 8 deletions(-)


>>>   static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
>>>   {
>>>       CPUState *cs = CPU(dev);
>>> @@ -668,6 +675,9 @@ static void loongarch_cpu_realizefn(DeviceState 
>>> *dev, Error **errp)
>>>       qemu_init_vcpu(cs);
>>>       cpu_reset(cs);
>>
>> Devices shouldn't call their DeviceReset handler manually, as it is
>> always called after DeviceRealize.
 >> ok, will remove this.

This is a legacy pattern we want to eventually clean. Maybe we still
need this one at this point. See for reference this series:
https://lore.kernel.org/qemu-devel/20231128170008.57ddb03e@imammedo.users.ipa.redhat.com/


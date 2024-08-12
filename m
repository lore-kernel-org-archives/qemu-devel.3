Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D33C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 00:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdJFi-0000Vi-Dk; Sun, 11 Aug 2024 20:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdJFh-0000RV-EX
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 20:49:37 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdJFf-00029f-Pz
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 20:49:37 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7a263f6439eso2320296a12.3
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 17:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723423774; x=1724028574; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zHTax/FkRkPPuizBy457CfLinJ6lRsDxMFgWMKhBR1M=;
 b=P7ASzGGvab4qbX+tdC1/rzWvgBtwHXeDg49JpWSWfMkV9KPSRIhBD5mojPP79vTmrN
 LX/aqDuIVxOxWlybvAiFwv5x+yw7ntV1GCtR5SEFisRre7km9MEIY/d+kq4+2os9yjNE
 WN2W5TjX9ODbWZeROJ++6ZXVOnwipHon+rS1GfWkwZmIsMfTLWflvWqFpnbf0zwg3R9p
 z2mZYeqwluCkP8igGHj80vdXGL0jKbaol5t9W/5Q48M8lDbXqRnzOP2MpEL8/b79b8A7
 /pIVlQTINpQGmz96i20uxkgpWb7TSIEi8CchYyFh5gWLi49Uq57mfNbQRT5JD6mKir2q
 zPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723423774; x=1724028574;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zHTax/FkRkPPuizBy457CfLinJ6lRsDxMFgWMKhBR1M=;
 b=bIgxGSDFklpdSDOOoT6yXwz8W5L8Je+GDXXdUaSM19Vvs/8Vn6dT5p0NXWvDTK6Flk
 3ENsi2fCa1veeNiMLWfXXiPJmRokz0jYmOBj7od0KK9hFzcRaUE+Sz8GR+s/0qgc/jQ9
 u8xwuNdXioT6CNkMLghIm7vX3jVLPZk8VZ+UM71fBh6RtR5YSJSOYPZeVjoxq8heZdn4
 gSF1J7RiiDIPh7/cHd8f7ybJHzsR96SRpKBpzFedNl2nOgnBYc87u2Jg+/UU5mwOY0sa
 012QYcq+Lkq8gf7OL/4F4LcBIZZpa2s94d+sLsOrhGqQTs1KUECRy1KmKLCRdf4PSGS+
 tIWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEPRBwyIdrPtX5xnnzeXO2IgSjQabMFkslUYqzjIeppEvYKd/gJQ5c97vzUh1WGkwuW1sP53qcJ1cS@nongnu.org
X-Gm-Message-State: AOJu0YyugcgyhZiESlHg1M45lJwhsT1Yt5u3DiSgeB74Wt1vJW7K2nfG
 eUbN9HHjlEjQGeltcUX0vyWFGatNcnCKR/9bkYXmBQ2cdBQZirZBpEB4FCHhB3g=
X-Google-Smtp-Source: AGHT+IEe10W3+rzITnd1SeQMz2uc8H1/SDjbC7Lv7iYeUIMMzfwoVFfvquVGrkoGLVznirtYXPAb4A==
X-Received: by 2002:a05:6a20:e687:b0:1c4:c3a1:efbc with SMTP id
 adf61e73a8af0-1c8a0103750mr5486817637.39.1723423774156; 
 Sun, 11 Aug 2024 17:49:34 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-200bb7eed50sm27326635ad.10.2024.08.11.17.49.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Aug 2024 17:49:33 -0700 (PDT)
Message-ID: <9870b2f3-56d8-4d14-8548-26c8a12b412c@linaro.org>
Date: Mon, 12 Aug 2024 10:49:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/loongarch64: Fix tcg_out_movi tcg_debug_assert() error
To: Michael Tokarev <mjt@tls.msk.ru>, Song Gao <gaosong@loongson.cn>,
 qemu-devel@nongnu.org
Cc: git@xen0n.name, maobibo@loongson.cn, yijun@loongson.cn,
 qemu-stable@nongnu.org
References: <20240618125044.687443-1-gaosong@loongson.cn>
 <4f6741dd-35ae-45ac-8a83-2f4c3246c76e@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <4f6741dd-35ae-45ac-8a83-2f4c3246c76e@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/12/24 03:43, Michael Tokarev wrote:
> 18.06.2024 15:50, Song Gao wrote:
>> On Loongnix 20.5 systems, QEMU configure with option '--enable-debug'
>> or '--enable-debug-tcg ', booting the Loongnix 20.5 VM in tcg mode
>> will get an assertion error.
>>
>>      "...
>>      [   31.484992] [drm] Initialized virtio_gpu 0.0.1 0 for virtio1 on minor 0
>>      qemu-system-loongarch64: /home1/gaosong/code/github/clean/qemu/tcg/loongarch64/tcg- 
>> target.c.inc:394：tcg_out_movi: 假设 ‘offset_hi == sextreg(offset_hi, 0, 20)’ 失败。
>>      ./start.sh: 行 14: 2433006 已放弃               (核心已转储)./build/qemu-system- 
>> loongarch64 --accel tcg -m 8G -cpu la464 -machine virt -smp 8 -serial stdio -bios ./ 
>> QEMU_EFI.fd -monitor telnet:localhost:4498,server,nowait -device virtio-gpu-pci -net 
>> nic, -net user -device nec-usb-xhci,id=xhci,addr=0x1b -device usb- 
>> tablet,id=tablet,bus=xhci.0,port=1 -device usb-kbd,id=keyboard,bus=xhci.0,port=2 -device 
>> virtio-blk-pci,drive=test -drive if=none,id=test,file=./ 
>> Loongnix-20.5.cartoon.mini.loongarch64.cn.qcow2 "
>>
>> The values of offset_hi and sextreg(offset_hi, 0, 20) are:
>>
>>      "[   29.975240] virtio_gpu virtio1: fb0: virtiodrmfb frame buffer device
>>      offset_hi is 80000
>>      sextreg(offset_hi, 0, 20) is fffffffffff80000
>>      offset_hi is 80000
>>      sextreg(offset_hi, 0, 20) is fffffffffff80000
>>      offset_hi is 80000
>>      sextreg(offset_hi, 0, 20) is fffffffffff80000
>>      ..."
>>
>> When pcalau12i + ori is not satisfied, we should use other methods instead,
>> instead of generating an assertion error.
> 
> Hi!
> 
> Has this change been forgotten, or is it not needed anymore?

Fixed with 521d7fb3ebdf88112ed13556a93e3037742b9eb8.


r~


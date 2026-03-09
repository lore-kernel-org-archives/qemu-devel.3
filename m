Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4790F3C246
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 12:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzZhz-00024C-Av; Mon, 09 Mar 2026 08:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzZhx-00023c-Dk
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:27:37 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzZhv-0001Xs-Ta
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:27:37 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4853aec185aso8563355e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 05:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773059254; x=1773664054; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CtBGb9p00bM5mD4MpMsJ5mM8oT+b3h/34PMdnMEEpPs=;
 b=rJyaUuAd6331wsKJM2WSA5i0IVjSosuMVyR6SyhNBo4eRiw7YAt9dfzE1LGsP64vhc
 ubY+N3jCBPsypX6tGp4MpVrNhlP6H7V1e+WDv3LGrFdRD+3lAguWLMaDzM6kiz8iGImV
 TrBOp8JVUE3goDXQFeyaPRoNZEU+bCuX94O3GHpcwq+cow+9UmfjHdE0IjRCZpdL7gjK
 RMH/IxTfnhDptrm8gnxw4cQJJ/SkBJqBS2gquF2EeKNnMrPIxrfI1mDFFEJxWUtNMriG
 mfiwnRrIyPU7dlMzkNUnEzFh+a7wn7287XEMzYUSZV5NBaz+3feGooqtpc1+Ai0t7+I3
 Lxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773059254; x=1773664054;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CtBGb9p00bM5mD4MpMsJ5mM8oT+b3h/34PMdnMEEpPs=;
 b=J+ns9AMVB8eR3BlJo3sZ0N2jBzQKNcyjoCXLd+XBmsECPReiRj9YSxfxJVyJbrveY0
 1g8Gse5H67Kg+JCfGjindE9Vq8mbyotxpzqHx192wL65Q/yWHfgwPE/7EalkjfJi26UF
 DYiGQRdORnc6gpdSHt2vEucd194QqtwHEq67xfLv35aJvBjMjnA5micflEGvjtnsNwmr
 5F6Q8oZ96UwrHm7du9a5EnetEo29EKtOp71AROzGWZXJXIyeID9xLL4Ys17iIRHQcpGb
 MtJCnp63lUKo/eDJpkbdrhnsSma06dn1OPtE78yA5IZXKQedKLgRxFxchQHnsT4/F4qs
 7vCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmQv3Jx117deS1InnujEArmBkOvIWQnVH5yIdHQA+m2tWEEXUR4TKj8+8EXv5tLqBMWjG/WIHaFl0U@nongnu.org
X-Gm-Message-State: AOJu0Yy71hIOkIpc6Ju2G1UkoPL4za99+PC1SIcarRe93poktiqxbL7a
 CZh3noPnDb+m10vUe71UYjMz0x+juHHHsswDwi/cHo7ZCImrArf5MQ+Avr25ThWvMgo=
X-Gm-Gg: ATEYQzwwbR34ecJRGIFwTgsEFsoZ4OPmItY11zfS1k59SZ2v9A5NudV3KuqGTAn+RpY
 eErUTBcy/FIbIJoz7XIYaOCPTXTB5A/wynEE6R7PElsKZmR5dno47b4lzgZLs5u5M19l6yq4+eL
 F0z6XSULA+iZo5ZSn7qCzsmAeDvhaFciJA9NYGQLLU/IfeOzPB/0j5bFWqWteNPmMqEa3YTeN/s
 w+Pyl2FVRlPm4GzY+a9we4xXAT6AHWX+7yUO677F0oTRlP5xolX+3P0sbeihyh689ot11tSSqEH
 ziqYmy4ftq4XNXwzfOXd3lRgka+2IqFJ69w44MJL6VdkimnEiT+3Gh6BKGY/VieL+6LWIEZBKZg
 GiHVqbKcocE5Mwulpp8SCLTi5opQ2VjI6Xl8MpwgX9eJpoFle1nHFSzrTfeUOeWqctIN3BdOSeQ
 Y0GBsOBkg0fYwciST3kgPE5Xz52G+E6ITDWXgb9KCahhQeUz7kx8yMhhRQQ5hcgQcXPg==
X-Received: by 2002:a05:600c:358e:b0:485:3ec6:e634 with SMTP id
 5b1f17b1804b1-4853ec6e713mr29445815e9.15.1773059254155; 
 Mon, 09 Mar 2026 05:27:34 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae49177sm25528206f8f.35.2026.03.09.05.27.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 05:27:33 -0700 (PDT)
Message-ID: <0225a250-8dfb-41c3-8ec8-7c39b057557c@linaro.org>
Date: Mon, 9 Mar 2026 13:27:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/riscv_cpc: Free CPU array in instance_finalize
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org
References: <20260309095328.1406779-1-peter.maydell@linaro.org>
 <CAFEAcA8x70ruJzSXhSo5OentZnTgsh4xnZmqL3h9+1EcFY=z5A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA8x70ruJzSXhSo5OentZnTgsh4xnZmqL3h9+1EcFY=z5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/3/26 10:53, Peter Maydell wrote:
> On Mon, 9 Mar 2026 at 09:53, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> The TYPE_RISCV_CPC device allocates an array in its instance_init,
>> but does not free this, leading to leaks like this from QOM/QMP
>> introspection:
>>
>> Direct leak of 512 byte in 1 object allocated from:
>>      #0  in calloc
>>      #1  in g_malloc0
>>      #2  in riscv_cpc_init /home/pm215/qemu/build/san/../../hw/misc/riscv_cpc.c:175:15
>>      #3  in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
>>      #4  in object_new_with_type /home/pm215/qemu/build/san/../../qom/object.c:774:5
>>      #5  in qmp_device_list_properties /home/pm215/qemu/build/san/../../qom/qom-qmp-cmds.c:206:11
>>      #6  in qdev_device_help /home/pm215/qemu/build/san/../../system/qdev-monitor.c:313:17
>>      #7  in hmp_device_add /home/pm215/qemu/build/san/../../system/qdev-monitor.c:1005:9
>>
>> Free the array in instance_finalize.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>> ---
>>   hw/misc/riscv_cpc.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
> 
> PS: this file isn't listed in any MAINTAINERS section -- which
> section should it be under ?

A missing "MIPS Boston-aia board" section under "RISC-V Machines"
(see commit 2264f637da7 "hw/riscv: Add support for MIPS Boston-aia
board mode"). Commit authors Cc'ed.


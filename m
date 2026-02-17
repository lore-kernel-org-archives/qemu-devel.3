Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB3DE9A03B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsSkM-0000Dj-MM; Tue, 17 Feb 2026 16:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsSkK-0000CT-2E
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:36:40 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsSkH-000530-Jz
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:36:38 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so3473363f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 13:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771364195; x=1771968995; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/FYXE30Uj2OZKEpaDj/t+meUiLBkGctiaGU8pWV3SxI=;
 b=BE15FOunUGduSsWGKCxvxQA6tcBGqi6PM3HZklhOa4yHCkdXEr4ykSARl/kY9ynkCs
 k/7ySzYaXOLMQTBhQOiHrJfBS+DKcJgAl+LkZGcHqvktlNNUEezcwEJH9iUY0CElBCpB
 qY52hzNW7bNHvYRDVkEIBF8VSFlyptF8yGufh2S7HxIApN8avBQlwuTf7fsdxtOMLj66
 5+VtOs6pfkYsNEnz8d+OCbD+G47+i8OwZS1yIIabYctFj7gsd2Iq+niuEVCLR68kmART
 X29jwelLFbX8fnTH3AkOI3MHfQc6+5rqOh2LYpc8bdjAhGrff9bmyloz7jhsCA9v9qcm
 ZiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771364195; x=1771968995;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/FYXE30Uj2OZKEpaDj/t+meUiLBkGctiaGU8pWV3SxI=;
 b=PPRacOVjPFeeZKzAVTI+N5KIjqXhkwnaN/piOWs7l2DJW27tZMEClcJkmHHuI9x+Du
 zo4X+q7tjzK7MY5+/a3ElpLHJLoUYC8DN9dd+MMOjzUcH9KXSomNuzA4Xfb6QONLLzrT
 rqv88HoiCDtml89FLo+iKL0FGfZMSWGXDgBwJxB64+lPMOU2vZKgFFKojQLeoJRN/IHW
 Izn7aDaJwPzQT8agEc9GGNGuEXgnbbuTBz1UASv3fsriCj5+lN1nU77S92ACRn0rSftB
 U08je6QufZxFPHTeLeU+oHEVYddTaB20B80oMFl0F2gnx551M/FVPoKnmmgkRwjtbK+H
 nTow==
X-Gm-Message-State: AOJu0Yw4Xx1HKKQVSfHeOOjJAe1G/00MUYYDGM2unvjUExPIF4S0nHHc
 AXqmswKbcDQ/qd6XWHeC7xpxgqdiLJwXwOYr7u7nrBDoCIDvZqGahH6zpCayNX5l5zA=
X-Gm-Gg: AZuq6aJyAESRVk67R1mXkInA9U65ZjpKIjb8/9Uz+p3IadpZYMSg3mSwfcivOcRnom+
 WA6+lJbCEmDtp712GNjlJrQGiLjo3d9YpPE+mGKFfx59Nv867ScQWKUhv90Du99U4ZCON3CuFqg
 D18K4AeQPyjefxH1ZBm4KDN/lEdEclXDihSVIpZRVdHkjEW26tAVTbKrjudaxf9JPcIkl/FKHc8
 sr6Ems+bByVKTJ1hpm/RDNVOvx5gGWpSsQ29wGp3QKuQWDjVHKJzRR32AjCB4hiPIuDdOW1kPA1
 qFMYsQgedYNg1/XzBkE4moA1dW0/vLmXcLxouPHpx7GlOP76uG7S33kkzP84ypbdkG07zN1xhUL
 /QeYkAuMbAYEdrh3N+KRQ3KDQrHtT8CJbV1XHWUmL8tZfP4Tt5W19zy9b0LQ8wYP0WU9nBP3fAS
 0Fr2hm9j4galHEMi1GqwtSeqmkZIkl+39Xed9DIJQWnlXWHawK4g02XUNOoSZd1uiN4g==
X-Received: by 2002:a05:6000:1aca:b0:436:7a5:aac with SMTP id
 ffacd0b85a97d-43796a3bc1amr23957348f8f.0.1771364195324; 
 Tue, 17 Feb 2026 13:36:35 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abc8b1sm38296197f8f.23.2026.02.17.13.36.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 13:36:34 -0800 (PST)
Message-ID: <6210e3c6-d649-4631-8cc8-92d4c8e2ddb4@linaro.org>
Date: Tue, 17 Feb 2026 22:36:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] target/arm/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0
Content-Language: en-US
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: qemu-devel@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260118215945.46693-1-philmd@linaro.org>
 <20260118215945.46693-3-philmd@linaro.org>
 <af89e56b-1d08-457c-ac1e-8a94cf47c176@linux.dev>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <af89e56b-1d08-457c-ac1e-8a94cf47c176@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Hi,

On 12/2/26 16:05, Zenghui Yu wrote:
> Hi,
> 
> On 1/19/26 5:59 AM, Philippe Mathieu-Daudé wrote:
>> Keep CNTV_CTL_EL0 and CNTV_CVAL_EL0 synchronized with the
>> host hardware accelerator.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/arm/hvf/hvf.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)


> My Linux guest has been unable to start since this patch. I tested it on
> M1 (macOS Tahoe 26.2). Not sure if this can be reproduced on your side.

I apologize for this (it was tested on 15.7). I don't have spare time
(nor hardware) to look at this right now, so better to revert, as
suggested by Mohamed.

Regards,

Phil.


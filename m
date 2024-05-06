Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474CBC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 14:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3yzS-0000V6-Q6; Mon, 06 May 2024 10:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3yzQ-0000US-Kg
 for qemu-devel@nongnu.org; Mon, 06 May 2024 10:06:48 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3yzO-0003ME-T4
 for qemu-devel@nongnu.org; Mon, 06 May 2024 10:06:48 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-51f29e80800so2119210e87.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 07:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715004404; x=1715609204; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nRUoICy/spSW1zCEmwRT84NBpmmvaibCrHd5mY4msvw=;
 b=eXsilrjCvuZmvceyA38pTdgd3au7KHIM1qrhBYrm+wBmaAuxHmiBg74sZiVi7KBbqH
 mEL8dysyNCKhCtW3JgT8oyTwNNNPhL8FUZFoagc7hH3gvCFCfIDZdR9K1b9fEc36/NeJ
 enhgUEE2Ljgk78hGJfX+ISTnjPTNBLjFjRbo8QBYOl5Q2lmQCpWBuzDTbk3DvZiFOn+r
 FMA06pY6SdX3Fc51VpO+T2WL974PNegAD3TCRfE9uTyLETOMSzeT15Y/Xq5EeQBIaHF7
 EY139TUD/gBkC0mIMu5kVIoSQg3eAyhVslM/pxz23fM7TUjnvMKS0bWcVuDZMMoUE/jZ
 MdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715004404; x=1715609204;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nRUoICy/spSW1zCEmwRT84NBpmmvaibCrHd5mY4msvw=;
 b=jNqLVMuZVOIqbFsh8QvpWuvB4KzI8NcIzZYk1+kxPiKgLO87LMA6932VvCCW1tUFhI
 +zFsvNSBgtGLJNgau3tRmA1evypfHR8WjdIDTiF4XNL4e3o5yysoE/ncEXNz1dZY+0bM
 /uW62i6dYrf+euHCvVN9TlO9s28IsUcULXunO0SZXcnbYIbGVVGQSfwyMsH7TwiHlaSJ
 skh1kWRiqL8FdHpAOkVP5Yee5dMkhfMl8JRKKvt62nxR8YalGzH1Qjl+xJDiwMDSeP8w
 MOasQQP4hqMHc3hue8La2V1ZhArsaPNEJ0zVWetp8EK1VdYCFTy/hyIm5M7p2F63kOSQ
 GIkQ==
X-Gm-Message-State: AOJu0YwSXvCaWb+rpyUeU+7ndmBlm0DCxcA3aRCVOsPgSdMcJR2EzBKv
 Hdp1HkW0ruZG5xliUO1GJN/HkpSebRGOQRG0u2ytdrjxJr3HkdkSSUeytfh6NX0=
X-Google-Smtp-Source: AGHT+IFHKOAzZS/OvP1L2IsorPTSIYNmEiuyJPQww7PFn345i3QsZAHG+rFN8s09NPKdGPY6Y+Pomw==
X-Received: by 2002:a2e:be9a:0:b0:2df:55a3:43af with SMTP id
 a26-20020a2ebe9a000000b002df55a343afmr6980563ljr.41.1715004404242; 
 Mon, 06 May 2024 07:06:44 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 bi15-20020a05600c3d8f00b0041c24321934sm20038264wmb.41.2024.05.06.07.06.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 07:06:42 -0700 (PDT)
Message-ID: <3e4d3589-692e-4628-a883-3319e8a593a4@linaro.org>
Date: Mon, 6 May 2024 16:06:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update Aleksandar Rikalo email
To: Markus Armbruster <armbru@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Cc: qemu-devel@nongnu.org, Aleksandar Rikalo <arikalo@gmail.com>,
 qemu-trivial@nongnu.org
References: <20240209062147.62453-1-aleksandar.rikalo@syrmia.com>
 <87h6fbsc27.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87h6fbsc27.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

On 6/5/24 08:13, Markus Armbruster wrote:
> Looks like this fell through the cracks.
> 
> As far as I can tell, the patch did come from @syrmia.com.
> 
> Cc'ing qemu-trivial.
> 
> Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> writes:
> 
>> Syrmia LLC has been acquired recently and the syrmia.com domain will
>> disappear soon, so updating my email in the MAINTAINERS file.
>>
>> Signed-off-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>> ---
>>   MAINTAINERS | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)

Queued, thanks.



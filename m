Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE84BCD6E55
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 21:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTndl-0006Yn-QX; Sun, 31 May 2026 17:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTndk-0006Xt-Fw
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:24:12 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTndi-0008AP-TF
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:24:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49050bfe053so62539515e9.3
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 14:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780262649; x=1780867449; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iJHkyvndnuT8Gdc+CfeQsxhRaRgOdIV/+7xUOPQ/29k=;
 b=r2VJWw7L/Fvtuo1FWxZczJTX4Pa6EhpiGBeFb3RvecupEdGbIJPi9zHt4ckMAQSQ4r
 v77IokgJuO3msgN+JuVuYeNFe5IDsuCLR/z+YhtupWW8NFRdIZA2XsbbAYZin6K7V5Xr
 j/N5jg9mRzodrv/N4RXDIOmQrOjk0pAVO1CpOefjwHlLqcDIus993otVRdhVovW52ctP
 FYZLpXXnKmOJFMy80IcZVbPWFbU0f34W6ci0DNmCt7kZ52Ro7TVV1CubPcJuS2HMd8/z
 fkvuuMF27g4C342YMuhuZKSZMFtuQGCZ7PmOY4Fq09glGOnGeyJJk0NOLS3XqxLPJAEu
 NLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780262649; x=1780867449;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iJHkyvndnuT8Gdc+CfeQsxhRaRgOdIV/+7xUOPQ/29k=;
 b=YDUTC+w4r49eTkqT0/mvJSnOkVj0fRkEPPd3Bpu5EB1/t1o5pZjOhJ4ITZE/t4PtNC
 P3UklewH2BWmuxO7DkrZockkThF4GdJ8XSuGjtCUqY6xaR37uPMFcf0tMD21a5xs+swx
 wjILkjy4Kw7IlAtt71LfUm0tUm5Vz86S+a91pAxItcnJTJGrPT/iMpJHlpu5HL5VHJpV
 /tybCESJBowVr6gradRSh6TjMnjY/JHF1u+557w52DqL9ajyQ9K45W96RxLSp4MEPgbf
 WITMFuHT6Pe0iUPpcABxItKPZ4yAtseMX4UBsiTbJCg906+x3f2+frcIk+J0WnZRVXZg
 mj4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CPELYRjuqQpuJrGdE5Y/mXGjp2RKKXn8ACAUlozR8K97sNGAkM30qKCvxUDHoCh7Ccwr6Wewr9uxS@nongnu.org
X-Gm-Message-State: AOJu0YzbfXB3u1bVl7bQQIGWJAgE6LTNlb54+9LjCvCDPPxQ5mWDKUjV
 oQ5Vv06z2qxjX7/jzrzi8NKHMyVihPHXYCj6m2LQkDQC+fy7BESxtVHrLciDckxP5ys=
X-Gm-Gg: Acq92OG6WG2e2MOnmVMoO6KWjd6DcV3bpEOvxAXI7QH33oWEH6f/rn2U69nt2mt9gsq
 cs4VBu+bS/9BQ+puNzzq6TnKbwftAEU17Lxmm3R3R3B66M0Fap5aZT0/CSlXBF4AqfgkggPMgrS
 FkDsGi2IkXxjV8cq/qqaJ1y72Ihs3GuuFeoIS3Kh2SyPjpRdfrxwIonMnZYaNXx6Pix1dv7Jmj+
 2sh69mmlW9Vbd9xFvWXNxmFe8eaZeN2vCqdY1TNiRnqL6WGh3osJlD0iLY0MWKpvuPkTrncIxiC
 yUFpT189gNKEUNGaw6Rrs6eeCPYwvz2pmMNc7EGWmNSjwEjkJ+FbORZXjD1RIZj/384goMeB3gq
 GivmnJXlfuS+4zN4zqZEiDZU3+vWhPxvHD3DMuw7ossb4nysTC2eGjr/KbCzfRgYYSLSvBe6TWC
 RqLHcrMOfAtkz7QMUwbg/Tmdq/qfS3SIsTX1yi8vNCFMvDd4SZYHUz2EO0aoNRAohPOHEkCpFtR
 qGv
X-Received: by 2002:a05:600c:c494:b0:48f:d612:3c59 with SMTP id
 5b1f17b1804b1-490a2915525mr160853685e9.9.1780262648846; 
 Sun, 31 May 2026 14:24:08 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d696cfdsm184960965e9.4.2026.05.31.14.24.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:24:08 -0700 (PDT)
Message-ID: <1010c509-e20b-4aaf-9c57-5f0ef9ac39f6@linaro.org>
Date: Sun, 31 May 2026 23:24:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 22/38] target/hexagon: Implement do_raise_exception()
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, Brian Cain <bcain@quicinc.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
 <20260529215554.606133-23-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260529215554.606133-23-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 29/5/26 23:55, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/internal.h  |  5 +++++
>   target/hexagon/op_helper.c | 14 ++++++++++++++
>   2 files changed, 19 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


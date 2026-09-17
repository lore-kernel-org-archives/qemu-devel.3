Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A02C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77uI-00070P-BI; Thu, 17 Sep 2026 04:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77uE-00070C-44
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:55:46 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77uB-0005f0-PT
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:55:45 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39dbdfaef3cso536630a91.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789635342; x=1790240142; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aPPseos//j0azqefRdYqUKwNJsbiilaKk83OPrTEPIc=;
 b=tJgIYUl7z5dfvdQNaG2KQ31n4hyD/uuV1yU+brRB0ncrQrfdl2OJiyMUSzzFJKTXzn
 iCRJsuP2NtZfCJwEfL86I3GwBvefGZxyOlpM6dBVPMCoHBwxoK1jW92L99Zjt4yREnp0
 Opn2M9dlOg+QlQlyNe/wWmEK5ez1QD1fevue8eitY6i0S2UN3cwh0sai5/b22JJQ/+Rg
 a0JOLPn0x0F9DbF4G6iD9hpPSgDyiEsPog4Vk4dHX0RqjznSiGKhIUsoBQC3+K71QFpb
 nydbsJY1OcdL0jm3QUe3gtXb4PnaJTckHogWGHnIsePgk4AelXJ7QumUIMtb3RffCGfa
 KNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789635342; x=1790240142;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aPPseos//j0azqefRdYqUKwNJsbiilaKk83OPrTEPIc=;
 b=OWcR30t3M17tFpaS+T3Ym+8T06lM1bl+gd4XraWy/bY/JQ7b+nDnQZ5t1kP5MrHBRb
 ERaXn9YIrciim0GgEOGndhUDXiPh1dbmwRTTyYwZ0eUzq6osyyM66Bl8GQX078aFykjL
 yqW9i0CvUwqWfSTVTDNyLIwux1v3b9pmZ3dHepWxZYcBuK7hjVslUfBogflxySGyeDLy
 9GnxQXl1hxQ19IlZHEfqo9ZpBWao42e/R2TNPiRFPEABsRdwejidYqJc7Oh5/HWwLthZ
 KoqXP34TfUmcU1l17lhCO0chpy2Q/6ZUet/9FSbDy3hJL0Bs4A/VJV1xDuz26JnKzMK6
 K9QA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwBN0V/d+ouaqW9XolGFw4pn9dWOb78ySiKdUy/Umcyj++bsGPpVA7DFWfHWMzZlMXs3Z3n2N3XREcv@nongnu.org
X-Gm-Message-State: AFuF++nS8Ftbpa1Ol84O6Y+hVHOsEweL3ESzfGFX5FrVpJCZEdl+eubs
 gaF6CS7SWEPWNEs3M7pCt6sR0x1V6+AV1Jn6LIcuA5ELAjWeKlby1ahkT7LAxI6KZigNxt/MHgy
 mfkEeLGA=
X-Gm-Gg: AYBFou1x0jaMav2RVDFeuyjvc2beWYSpJn8pMXtNbjD8yWjuZih3tzow9Vg1YgatI1n
 ZG4hP3VGvN/DTR5ArBDR5h8YOcP/w73d4KQk2mlboYDUiV5z253LFCt+DwDPlqut4L835MpdOs8
 M0vaFomv88DDT9/YnOfIMhdHG3Y0cibyWPOsExOkmu/KWCZMNeKJVkj8Mt+dKv7fkzZ94aYsDJl
 sV9eUL4K01yy30hSLsv7dNrjvOEzQKebdRLE8DnPV5R4GFmvVibODBK2RqpsvlRov8YNFZcmtoJ
 ULVTDS3CG5/J+i3MQnsEgrpSlnIChhFpHFT2XPbyzVeNsbCpLiS5bLDzo8+dQo/MmG055145McP
 cXgKwz0WU0kru9/6a4joY6WDBe4XTRHUuvPp5AzFV1lUUvhx9yla3+DsZcr+gipHGBz8WK6ySVq
 WO9385OQuxHMl8EucOL00fhNqwm1Gk9PXrdgmoWdDoML+YTBXpQzfB8TAAFaL2P4QGpLippdTpz
 5QdBc8ESIklcu22BRuRZKOi8IkIYch7tVPpfn+rXSoRynRDCiyjxPenek2Q0w==
X-Received: by 2002:a17:90b:4a81:b0:39d:f773:37b5 with SMTP id
 98e67ed59e1d1-39e1df6193cmr17773273a91.0.1789635341929; 
 Thu, 17 Sep 2026 01:55:41 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:325f:1938:d075:8c13?
 ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395cacce6sm12360682c88.1.2026.09.17.01.55.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 01:55:41 -0700 (PDT)
Message-ID: <9bf69562-9c53-46c7-9d24-17ed91116b45@linaro.org>
Date: Wed, 16 Sep 2026 22:55:38 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/11] loongarch queue
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
References: <20260917024742.200257-1-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260917024742.200257-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/16/26 16:47, Bibo Mao wrote:
> The following changes since commit 28e7aad52202c7e6210e0e05d4f60360aaf8d027:
> 
>    Merge tag 'pull-target-arm-20260915' ofhttps://gitlab.com/pm215/qemu into staging (2026-09-15 09:50:49 -1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/bibo-mao/qemu.git pull-loongarch-20260917
> 
> for you to fetch changes up to 2dfba02c30509a8c36a3bf10ccac5519495a811d:
> 
>    target/loongarch: Add la664 CPU type (2026-09-17 10:08:16 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20260917 queue

Applied, thanks.

r~


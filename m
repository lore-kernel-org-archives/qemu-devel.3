Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133A6CD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 06:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS7p3-0000HA-FK; Wed, 27 May 2026 02:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wS7oz-0000El-Tr
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:32:53 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wS7oy-0001uZ-9z
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:32:53 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490388fd0dbso57148945e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 23:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779863571; x=1780468371; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aNEkSC47d5RS5YWXZhRHunigyyWERXaqiC9yt1R+Jyc=;
 b=JONs1Hd88LlMsVLbQ9DpXFR87ADCfj+I7eiGRyT1RPIJ5iiRfa1gn9A6SopXpoHLMZ
 LRfmENioElXG9sgH4sEDKl23t8sBJzrTwVS6KRofHauTnPLgoIXhHygklbnDDt0E5aQo
 7gga1Xr+JIzB4gkf8WAgfPv2USIaxlAc3QUU8GRSZ/dace5PRcQIUOrYtSkWf7udUQx2
 Y59b7oINQsj5fBr4xQEz86Ia5G1leIs99JSzBYZqVeHzxyvX3rZ7re3wnjZSZa8rGV7C
 +xG5+Chv1MpM3B7ZFERUW6/0jNwz+icH9Gzw+wQqda/pmriygyBtx1OhjR9dnLByAaoZ
 6/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779863571; x=1780468371;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aNEkSC47d5RS5YWXZhRHunigyyWERXaqiC9yt1R+Jyc=;
 b=AHj7xrRsBuY4WTmdprOnCa2DO+L7r0Lb1HxRLdy4ToWHLgDJbxlHeg7QUMTgqp4EvZ
 VTdmRFhRupIAijNCoOfhVTIq2aJVUM95UJ7RE13PX6TwfUyPkJZ0t+fJL0YLkQ3H7Jt6
 4F4pT51qrk892nAyxDA/f3QKKXRbeUyV10+fQPvwB7lROikZ4Ve4W/E5EVYvL4spX7vN
 /9bPeYRmOxKSUZMq3rSkSiXY0cWZguU3zld/8+e9TFdYJxNq2HJyQEQnLZviUV5ye/9S
 vcBs0Vy+DpoxksWxeq6wT68rFIadg9yoPyFJTW1hGRAJp+nFsKNraar+6XpvtQi2IpSc
 /AQA==
X-Gm-Message-State: AOJu0YyO8a3GlQbCzjrP5hZ/zGFB2puFZkuE3oB3dZIWMA/HTG/NKZG0
 h76KKTESUoZgksJ8DdvAmmzK05q+i6WcvHS7gCjUDbSyqqeYeRDPm/bkXgEc1s2ro2miYXoe020
 E8alfB/sp0w==
X-Gm-Gg: Acq92OH6eBNsD9wz1wh27Gf25D+nLJTOxI6IK1qTBDEcAG9H/PFcfZWidAOYxqiPVvQ
 mpSVHwZxkR4QS8VxbT1do9OV4AJ6m54N4zyAw7zcHSGdFr16PigRoQP9x9mmZlKgefCDkM/ctFR
 Jv1tmd0jQ4Rk9FRsuSLDKIocBo/BzWn3ldRbcYVxqUStQ5VvHBR+EMCER6exwRZzGDpucHBXrpD
 ZxGSombsOP47dn2cCFyLl6E++GAYtdhKOtq5bsB1c+FGDZfyh1fxYt5yERW4KF83rEEf2hysY5l
 E64DIAQ/tmqf11w+Wt3co7zd4NnHyuExison6SW7Ed7FgYUIGfLPqbIOOq1DNeyXG+kBdrBuK7u
 MezTeB2mKAdWmjb2v/yiB2JhZmjRBFbPKFz2Bhkvc/iTMwVBNLG2V5nQ3/YT+Y6MiiIX0AGlkBN
 71WC+CZSYBlmpXSR6PtVsVu4Kx0bNUVXxwt8cXCA9M6PTwuasAoi1O1mS87ldYzU+ecC9TSLkel
 EvjT1V6ryVRYPzPC9DB
X-Received: by 2002:a05:600c:4e0d:b0:490:5655:8d3f with SMTP id
 5b1f17b1804b1-49056558e57mr288494385e9.28.1779863570683; 
 Tue, 26 May 2026 23:32:50 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb557679sm6244281f8f.10.2026.05.26.23.32.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 23:32:50 -0700 (PDT)
Message-ID: <7fb08392-d8cc-478a-b20e-b606932485a1@linaro.org>
Date: Wed, 27 May 2026 08:32:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/hppa: Inline UNALIGN() macro
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260513074323.10616-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260513074323.10616-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 13/5/26 09:43, Philippe Mathieu-Daudé wrote:
> Rename 'unalign' as 'mo_align' and use it in system
> emulation too, allowing to remove the UNALIGN() macro.
> 
> Philippe Mathieu-Daudé (2):
>    target/hppa: Use DisasContext::mo_align in system emulation
>    target/hppa: Inline UNALIGN() macro

Series queued, thanks.


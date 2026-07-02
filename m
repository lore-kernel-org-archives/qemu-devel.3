Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E9BC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 21:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfObK-0000b4-Rx; Thu, 02 Jul 2026 17:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfObJ-0000aT-DB
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 17:05:37 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfObH-0000EM-Vn
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 17:05:37 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ca64c3ce5fso22255895ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 14:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783026334; x=1783631134; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2nuEHbLofNMLkUv29YGQaLZl0dyUSwgCeek9GzJsN3A=;
 b=jCZ1N1gOxRll0Spjsd8DNo7Lpm2cTD7ruQ5YtlJUeHzPcK6jUs1lDqGHNL5/xVbLRR
 OSQgIvn/1TnsHXiuyAG3GrzbF7hoLHGdxFTgUOs7zdRhLqY2LwVhXKyzvN7LrCmS3EdU
 RWT8ZwBcn/nuLgNsaqwd5P2J5bihdVIIpdc2P91Pr6K7yWOA53ImssLilUrxjRx/TFtK
 SXRM2j+TUtO5LCkwV3cAEKTkfT4RKACitS2BSqxMgUexHrUnN9CNyDSQg36VQELoZo75
 N1WrGvzfLlnYT2ZLdnXJc3nBffNmrygZ/xM5F+lRPrraZbcONZUanWXCasJj1T54TFFy
 FDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783026334; x=1783631134;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2nuEHbLofNMLkUv29YGQaLZl0dyUSwgCeek9GzJsN3A=;
 b=iP06yXQkH4G+KcVGJrzttv2oY1/XJSc6JwssCB/N9Dw2d3eZGf3YqPJyo9kjH7MX1N
 7w5hwOrjo4ktBrmfaMQ8d+qW2e5o5HbEqKIhtreSEx9tSeaywbBnOhg7G8iTc6A6Rzy/
 AccxEimzAeDHzCUsbhYy1nV0V+AEKYaUTnt7b4vuR9Q3Yho+hoyVmtJB5BDZOnYosTml
 kisraynZASbmFWFUQCPbtYp4HAsBiAzEFWfo6T5e3Zf8iGBuPrNNmlBSa12St2ilAT9E
 o5YvoKz7Pl6ZCQ88EQt+hAVPNjYqrl4pz5t10so7He6ic4nzxE0489pLdER5GIU6EwgL
 cJvg==
X-Gm-Message-State: AOJu0Yzw+X6xdL3x1kiHuawUYMsPL+jQ2CS/7seEgaV/YB0C6SMrCIh/
 +PCUwDByW32BjG8dRe8SsLZbvg+ftCZrqw3EejhXOcmz1TOvbcGo4wPUEwJUo1GJSJDLrwBAJr2
 1Xf2u
X-Gm-Gg: AfdE7ckkUnZd/OTWRyb//BWAb/eTJOKDtyGfJVsKQotCYxdl3clgDlWhMQgtf+W1TFq
 hoK9GQQZGB1moBlgOz0yItKbdElSeLGaEBpf7/jv92EGy2xsGYhp701ylNa2fk1Vf1NGyobgIFV
 0nLncWnd2ZBi2i3igpU003IZLuJIhVGUfpV3j1xwMTFuJ/NuopGKTsrA47R6iaxUmZJkT+r4s8j
 7imRrId+v7vts8HehDd4UUFFSWkW4sPkKLNQkxRxKeTBrBoIdqBtKmCt8dErOA9SifqH+3aC4uT
 uNByF26Qq6vWpJCbF49MWBvQtlfRy8L8rPLVQNComkQnaux4LnoSfs3IRwc6bg7DLAhBJUeulNE
 vKePJUqexTv67hT6mRkGJ5WiQrM37ayeVtaTTm8lqFJbQMO66uCuOkZyYY9vFjshHWz4y1K2561
 Z62atKOwTkcoxMGGDfz5rrlFOomrEp8UM7Ppjom0kDSn71e4/6BtaD+N1WlQ==
X-Received: by 2002:a17:903:9cc:b0:2c9:97a8:8c1a with SMTP id
 d9443c01a7336-2ca7e8d9f82mr79618405ad.45.1783026333477; 
 Thu, 02 Jul 2026 14:05:33 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cac3a9841fsm6695945ad.45.2026.07.02.14.05.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 14:05:33 -0700 (PDT)
Message-ID: <65b87803-0df9-40c3-a5ab-16b308f641f1@linaro.org>
Date: Thu, 2 Jul 2026 14:05:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] target/arm: Handle NSACR.NSASEDIS in CPACR accesses
To: qemu-devel@nongnu.org
References: <20260702184019.3431139-1-peter.maydell@linaro.org>
 <20260702184019.3431139-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260702184019.3431139-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 7/2/26 11:40, Peter Maydell wrote:
> In cpacr_read() and cpacr_write() we have code that implements the
> "CPACR.{cp10,cp11} behave as RAZ/WI from NonSecure when NSACR.cp10 is
> 0" behaviour.  There is a similar requirement for CPACR.ASEDIS: if
> NSACR.NSASEDIS is 1 then CPACR.ASEDIS behaves as RAO/WI in NS.
> 
> This doesn't matter to us yet because we don't currently implement
> ASEDIS or NSASEDIS. But we're about to do that, so add the handling
> to cpacr_read() and cpacr_write().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


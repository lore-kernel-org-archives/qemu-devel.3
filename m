Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCA5E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 12:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJAhZ-000758-5G; Thu, 05 Dec 2024 07:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJAhY-00074y-4l
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 07:11:24 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJAhW-0007fe-Na
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 07:11:23 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4349cc45219so8851725e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 04:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733400681; x=1734005481; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=joOUa8/e5MJUXyMKH4vpNj3u6q+VSGch+F5p5E4HEH8=;
 b=GkwJ/yrLZxlmAnDs3YJV9vrTa6SamzZBtQJAlknnweDr7Mn3uXwI8SPgLYrUjZobj/
 sC0LvQPED2ULNc/8Q2p8AQAPYPiu3ZuioeVK3JVvRGqosnRjlhgP6VmsjisPIzymEUYD
 0QBeSgAuc+9NUHEMdQvMIom9iiVRIsax8EnJiY3vO6ID33oRjp03cZ+bmmcCL9BTbZRh
 USQLoiGpnePVxxz5HqEDQRGyF4ZFOY82MEXUFPKg4Jrstme81Pzw/6+nrXv2sX8gM2aV
 luzeiF3l6e5393jj3qT61FLyEHe3IwsAdZroucBJF3g/fCiBjSDchdE8BJyNPM0jaa2a
 vAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733400681; x=1734005481;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=joOUa8/e5MJUXyMKH4vpNj3u6q+VSGch+F5p5E4HEH8=;
 b=MXxf2dsWh0pWmIYD2/J4jy2zxR40HAsIghCRYbVZpAgDnDHPonGHpNJAUBpZMtvxNd
 RcTFzAu3AG2ccsG+SMcEewYsD2RRribp0qnjEkS2OK9TVPmDND7L47asfODUB/jAAzy+
 ydML9AEbIreVkCDZkfqePuGoFn+j50PmvPeeoY47+prka7pIW+ZMV5HbfiOgzGuoHT/U
 VTz0aSW9gdS6b+2PRXBvxVOwbagARCcz8kxppso6py91/55vVnchfAhSKdU7IX6f0ptr
 DU+7ieIrWmhSzjEbrOqhlXlvoPT640wQ8zikA9f6yXUdELIjgZwgGii3IDA2jxwgmRBp
 bQ4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMeJ3cBDJonZdcMPOsIGZFn76eNLzrrg5cvKPTjz9jM+MWD5Rq7ecX4I8cgS9gZU85WuTggQSONcNc@nongnu.org
X-Gm-Message-State: AOJu0YyhnqXixA6OH/5mHtX8VGI3HAS+8G1HOtEME/5gtEjE9PNKXPqS
 OPMBj1qXXcAnVrwUtpTAEGhdF4Uir85/2qGB/J/Dhl1rj1bHKiRCZ3SqQtyE8YeZu7BXb9fY/fx
 d
X-Gm-Gg: ASbGncv3BtiOXWCv7TuWp5N+M/Sf4EFMHSVhLK/p/fiDqcNYvl5lhaU3I6/KujODL9V
 gYtOu4mlaPiVsKQJbWuvbTcyY86y6eBTk1U969VNmofE+qSxvaAWT1SknlItfC15FNsvc4TsNPg
 quxOVM0yAkuSGgx+uV4GbVo+3piUN0uXjb5Ql3VqMGOiLx/3PjgK4zFtIuzFEdG+go8pSMarb+0
 XZZb2YrLLoSjZsvkztOID3xVt9ybd2T+RZVX9ie44KpGHAnUvsneJAAOcpL6yRp+zef+u/F4F2S
 A1O/4/czFSaSupTwqA==
X-Google-Smtp-Source: AGHT+IEXGWMcQ59oYTZRCwxSAgEfslwBP60XYTCLMBLyv0WSyrVFHpz8Db3MFORJd58mAzSz6tDjwA==
X-Received: by 2002:a05:600c:5101:b0:431:93d8:e1a1 with SMTP id
 5b1f17b1804b1-434d0a143cemr83670265e9.27.1733400680836; 
 Thu, 05 Dec 2024 04:11:20 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434da1134b9sm21466375e9.33.2024.12.05.04.11.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 04:11:20 -0800 (PST)
Message-ID: <01b7c620-5cee-4349-8608-ab4675ef4683@linaro.org>
Date: Thu, 5 Dec 2024 13:11:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update email address for Leif Lindholm
To: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>
References: <20241205114047.1125842-1-leif.lindholm@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241205114047.1125842-1-leif.lindholm@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 5/12/24 12:40, Leif Lindholm wrote:
> From: Leif Lindholm <quic_llindhol@quicinc.com>
> 
> I'm migrating to Qualcomm's new open source email infrastructure, so
> update my email address, and update the mailmap to match.
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
> ---
>   .mailmap    | 5 +++--
>   MAINTAINERS | 2 +-
>   2 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>



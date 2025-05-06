Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12886C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDRn-0007n6-JJ; Tue, 06 May 2025 04:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCDRl-0007mB-Cx
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:14:37 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCDRj-0002Ze-Er
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:14:36 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ace98258d4dso770968466b.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 01:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746519274; x=1747124074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B1ObcUak8rP21keTA6ccHVXsEABYgIw70qlfR8gFXqQ=;
 b=P7c6ULEQa+hsN0Ga+jMF/jZHnyWuiCvu63RqB636SR8VwmDMjIqzMABdSGbM1TJ4xT
 bfn0aREiNaZ9TGLOGyOtaQNzYDMCcLSWiNtQZOzYfzDfHdD2DtOHX9dpkHrbxJReM+Ua
 jEs6ISYBgpURn/wmysExY4qC+Bk53NIF14z+9sW2GKw/my4676YjVoZzNcvDhjBPCPme
 icYnbWGME+YXrtgJP7HpON+w4hz46kBEYWb3uhs8PIfpQlj5Cvy9e3Sw9rU6Tvgmrcrl
 TVOCUHkfrGbakdJSWbM3JS73Gz8U/TaT8YSnb95zVeZJ3shjaDskAyxNjj7CRsikHFbM
 GisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746519274; x=1747124074;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B1ObcUak8rP21keTA6ccHVXsEABYgIw70qlfR8gFXqQ=;
 b=BivUz8GLXWW8XSxpFlp3rgNUQ6V2/f89X+5AzaAvObZqZR18RWLwhLQdGEaAIjitRd
 rwzsZSXKJXSIfFOw2Ui5KwfoZKxDUrPUmRRFjkXFCYpIw4GxbAQESzgeRVctihTNT9ny
 7tpzefy9ZpTRenb7iRjto5T7BC1pAIAyiMucvuyo4PVyid50HmOnZ2awsqSC11O+gw2T
 1w+aiZn9xLiM4DakJfW4hNsme3Tcz4vapTr6UtcPAVT11ae3xf9wJHKgNeEzbhFe+00/
 av45yoVPHt4WBFIBBiiaM0W/JXfMDAfDFWsCzXA9c3M7LD1ePxlrgapkAvw90rDoJguH
 yxng==
X-Gm-Message-State: AOJu0YwLTG1I35ba5dTHzUMBLemorqksSM6uiKBPnIwYa5wCuyC+jo+a
 Rm9R5XyP+AyCZDq+xIq8+Jjr8V19tq8SPJXjr1VuSlynijTUQr+t8eT7A3ghcK4=
X-Gm-Gg: ASbGncvBG3FeodCry+jqpSiNDKP4fEOB0qWcsygRoFZNECYhswxM2rL+xUy2KC6wq3K
 sxkd/tx3KSV8+8W1YtEvvNQiXpzakUyRPT26aGYxkW9pVY0POz39aRSpJwE1r9yjZ/JO/4ANB0N
 iE0OztxC2SEN+koF6dyTKsg9Tovfgxl+qs5UQAZi1u0dwIKOAJY8ON7k0sDb0aRe3WSsN3JQjwK
 4Gaeusfx5O9dyHed3N/IpvQ/+tELNCrSm6S6m9HNOxrUYBKCM040KMR5+zuRwQ2hBCXBX3OEVCP
 6vfGwWgney8hCC3+DWcKc/WzE/snzmTkx0MLAuEqRUg0O9HBhhP8sZ3lMYmQ0wDqkWA+zotC/qU
 Kb5A=
X-Google-Smtp-Source: AGHT+IGkaF+Bl/Zjva4ElVab2vaC5IEekbHHdXG+PUFXqCxM8LDP+Cr/g3/XUWXzB4K6NXXGLfSJ4g==
X-Received: by 2002:a17:907:c283:b0:ac3:413b:69c7 with SMTP id
 a640c23a62f3a-ad1d467aff8mr199345666b.39.1746519273778; 
 Tue, 06 May 2025 01:14:33 -0700 (PDT)
Received: from [10.194.152.213] (238.21.205.77.rev.sfr.net. [77.205.21.238])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891a26bdsm653613566b.43.2025.05.06.01.14.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 01:14:33 -0700 (PDT)
Message-ID: <f0bc5dde-afd9-4246-bad4-0618251e6735@linaro.org>
Date: Tue, 6 May 2025 10:14:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] hw/s390x/s390-virtio-ccw: Remove the deprecated
 4.0 machine type
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250506062148.306084-1-thuth@redhat.com>
 <20250506062148.306084-10-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250506062148.306084-10-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 6/5/25 08:21, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The s390-ccw-virtio-4.0 machine is older than 6 years, so according to
> our machine support policy, it can be removed now. The corresponding
> v4.0 CPU feature group gets merged into the minimum feature group now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/s390-virtio-ccw.c  | 14 --------------
>   target/s390x/gen-features.c |  4 ----
>   2 files changed, 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



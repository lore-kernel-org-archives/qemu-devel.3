Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD4ECCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 10:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB99a-0001FV-Ug; Tue, 21 Oct 2025 05:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB99X-0001Ev-44
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:59:39 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB99V-000305-Av
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:59:38 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-470ffbf2150so35638445e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 02:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761040775; x=1761645575; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=diEGpjF07VrSCVJ5bbgvOPW0SLJplmYw9QFlNMvv++g=;
 b=CNf46BOf8PiVIUKciytNv1Ynt/d01Rvjj7Qotkqv4vLrvrNpMfCRmDx5DnnQWTbsxR
 b745bZnKkqr22lEDbXAIhPiMOp4rCmvRggOYVTAUHRVNtmdjI4AlH2kwT1oUIwg/rAAQ
 VtijCkt/k/kadTO2u20PRTWO9ZZeVsmL/MTc0GXkXHAIue0OJdJWFldo8G8bM7V+oXg5
 nW5drZLOYifMWSyiXSijsfVtFJify9+KL08AMnlo89ilmYiIfX8msZi8RNmHF/nEIhoS
 DA4d+toPo9WyA93vnsiqdj/SBgo1yqdbAFLQh3vcEcUbEtfQ3hvQkGQQmBXOxcVTUkI6
 Fiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761040775; x=1761645575;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=diEGpjF07VrSCVJ5bbgvOPW0SLJplmYw9QFlNMvv++g=;
 b=cZgRdpCkER/uP4SmNNGttnNdcGz3nWFYxnAIi6GqNzU0gBacJ1JxY920KaJscyZrhL
 CNxPWk9fsjFLych6h+R10CKFJW+AX6uX1JUJdqUuGR7fo9MAsmefN+byWFx9GIJYFWt3
 uOfqLVsgXL74bhVidtxUcsN9cvbfyV194vkxvbmnvoopu74beR2M8Hiwc5M2FfD6lkEm
 vCok0i1uEfePaZ9XaYdBIZH2ORo7SMzYpH0UYsuVwKcvNvDr1RcHuMXDCs3D/HgXXZAd
 UQQAky+NdeVQPWQBXVU8zvSrxulGsgYpCKbc/Ez4gJ/zVoGd0qS6RKFLavaOqnknxcRu
 eoTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnltd1a2fAgge8lkV4pGQEkFt4xWuIWJtDp3iy/KZoDyVOJh2mPm+UWdqk58yiC/hHJE5s888G1hwj@nongnu.org
X-Gm-Message-State: AOJu0YxTG0rmIes/uGRHK3P2Noi2iAfVG2YNFdSWkAcsEei/CzUQx0uQ
 3xwsUlBx6sz0rrXobGumEkRhFE3hmUxPSQ6txuhMuDjG7RE1e1CUR7gAYu66Ma9gRjU=
X-Gm-Gg: ASbGnctYOvwHFsBDYsY67ClifikiK9Pye5lvmOodj5vAtVNq7c0GPlTpgNAwxj6esFt
 5Xe7RZccviP75IBMevX57JeeulaSIyfFFGV1xlBae943iNd6RereKf3b0PBvd/9ZvB/EtwyCyH2
 g/vIp0AGVwFWX2vVFdMo9Nij5AXIA1FpLkjA+Z0l7ViX+GCaqShuBLDf6Tp9WnwSkUb9RMAWxxo
 +64VzslIMbSsGFAu83ElSpFqWLX8prS3gEbiI9ajmgGPYq3VPZYygLhC7A6Pnamxb+bYRcRusco
 93M9NWLpB9opn0Di5wcM23yUTTu1zJcJby34wgngfzut6y/GNoDoztQwl/0C2nuTixRSqeHRxuC
 TuOCFqUv7fIE5h4JEH4nuZmAPZunT19nV1c62MULVKHHxqDbBHgcYtu6F/0Fj2RlsnOaDIOHMTN
 fClOzrfPIIzeQmPMrCisYvD30m/owq1O3is9GtII7DrTNhBHwBiVh2jw==
X-Google-Smtp-Source: AGHT+IGxxJJMwiORZBljHoNwNlzwsdKNa/mN/29fcf3y8Kxged0WfLKhK2w+El3kib5hIzRxQZQG5w==
X-Received: by 2002:a05:600c:3b98:b0:46e:6339:79c5 with SMTP id
 5b1f17b1804b1-4711724b354mr158150935e9.5.1761040775642; 
 Tue, 21 Oct 2025 02:59:35 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4714fb1b668sm217594205e9.0.2025.10.21.02.59.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 02:59:34 -0700 (PDT)
Message-ID: <0fcdb819-7fd3-4d3b-8e56-afc32cad3296@linaro.org>
Date: Tue, 21 Oct 2025 11:59:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/43] audio/paaudio: remove needless return value
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-20-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251021090317.425409-20-marcandre.lureau@redhat.com>
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

On 21/10/25 11:02, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/paaudio.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



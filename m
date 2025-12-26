Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5BFE8FDA8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 11:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZ645-0005R3-1k; Fri, 26 Dec 2025 06:33:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZ643-0005QS-Pp
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 06:32:59 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZ642-00023G-86
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 06:32:59 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so3999027f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Dec 2025 03:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766748777; x=1767353577; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BZHBXK4X23LOfjikstAJWMHoGRgVA2k2Qi1r6MxO49o=;
 b=C8LUsfYB+Z8pbpJwYndh0miPkD6dRN2K7VDUj9HYDcyGaBiCzfIatjxndGChBAskyH
 iwInOTi1CuDeBdTSU5SfJ+2Kd5m40T/MltOJxo8L3eGJbpvOG+cTI13o2GUPX4BMwkZz
 x5tEQNOITE+kyZdCHpLfShFGNP2+M1KMEAtll6I0Qn+yv7s6FWQoG3AglSke3V8tir9M
 cE4hIdCLzdn7j8VT8RR3/UGjY4c7aXfRvcM8ytLkGtGS3OafSnOmNrqhPXXsboDLpiA1
 JNLEJdIQElSmV7gtnmNx2l3/x/6pN16yY5t1wRd83lJ8wLZC2KdNmUWaPBgygX3Buw5e
 FTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766748777; x=1767353577;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BZHBXK4X23LOfjikstAJWMHoGRgVA2k2Qi1r6MxO49o=;
 b=Ab+tf3RFPiaCpE7qaxEqyfHOSVxHRH09uxdqyfn2o0HoAEKXIDhKbN4zjH22tdghoi
 esCcPSUUH7jfV7Yg124JiilEgruZHpovH2DNt/YROPTPQidu+2jdOW+4RTeYh8o5XSpg
 RU6V8jg1Qi3QXDukcueNG4PUev9hbvBcc1H+HebulK7CFfYoL4Sko1MrpTUcYNsoFXV9
 ZHuNOVJ0Pz1bUVcppvRa23h0bStnVOW2HNC4IA9xW+vCsuB0yAMfpKYBQJN92cgViJyg
 +wdzV0ZAbkdNQeA5gzS9npYR6brBlJFCZDu4gAfRZP56+uZ4JaFVTChVhvUPcYqb9S63
 d7tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIxioUdtwrIhHA//oQ8fWYHN2ciO8d2K+jWrCI5QEb3kgFhEm+WuUIj5Dt1RguCTUDgBUSrKrvZWpA@nongnu.org
X-Gm-Message-State: AOJu0YyDxVDSn0msTmkkEaCFYUy2F3BghC5KHvw6oPspG3vDQIkrXo9k
 SRjXO/ho96KQzhiHLf24SoTbiF4sWxUIfOBo47dSLqZb76NvhJOsPdX8HNTySxYt/5s=
X-Gm-Gg: AY/fxX5fYUJF1n6QZa6JHqa4TpMABPHBXhFzcGxNgCGzGOPmXthouuMKA0LIMuOtWxB
 rAgXVj5jpfB4XmjHvJy/W+a2KN+Pt++pyONP3KpEvk9CMwqXAbah826A2L6YTGheXkrpsl8ca6G
 Sj1TlQtjIajyVYGX9oqFSX78+zCpGlWyGrL4C+7sCNSjTRBUWcKgFgBRo76y+oRvaWk0lSych0o
 ZhNkDwNmBWlMUQAguTIg/aCs18+aTrF0WWwF35JHMUho/p9SqvU1cyY1AqcJrCBoZwgAUvG6m5j
 u7T2UDmgDa7p/ZLOqfTPY3tgNwT9iO7l8rfQytJ4mYIt+stlFw9pmRyjqJXjYWVPslChIw4V+JB
 IiP1U0Hcpfy6JoagMaBiRVp0MEsvAz6Vhh8Wf1wz4RwQ6lhYIIqWXfsI5GmGIoE+lwJKjk33Nf3
 6XlCDm1ZTnF1qPWUzr0HzF6IY7YLAJ43gMW/xT0UYNoodLj3BMcKP0C7toeqCXWg==
X-Google-Smtp-Source: AGHT+IE3VcyFnoqKSzexugaZxTMNtVX4ifQu/ix258gpLU0EkrO2TWIXnc0c0hTJXy1Z0AKqjdEW5A==
X-Received: by 2002:a05:6000:4029:b0:429:cbba:b246 with SMTP id
 ffacd0b85a97d-4324e45d729mr24232036f8f.0.1766748776651; 
 Fri, 26 Dec 2025 03:32:56 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43277b82a58sm11620143f8f.6.2025.12.26.03.32.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Dec 2025 03:32:56 -0800 (PST)
Message-ID: <9d5614ad-f334-4e58-83ac-bd2afd5352b6@linaro.org>
Date: Fri, 26 Dec 2025 12:32:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] memory: Add internal memory_region_register_ram
 function
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <cover.1766525089.git.balaton@eik.bme.hu>
 <cb3aaafb264b8f85f57549019163ac1728583d1a.1766525089.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cb3aaafb264b8f85f57549019163ac1728583d1a.1766525089.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 23/12/25 22:50, BALATON Zoltan wrote:
> Factor out common operation from memory_region_init_{ram,rom}
> functions to register the region for migration. This avoids
> duplicating the long comment in several functions.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   system/memory.c | 75 +++++++++++++------------------------------------
>   1 file changed, 20 insertions(+), 55 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



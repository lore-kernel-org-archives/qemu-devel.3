Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D884EE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 12:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhzu-0006pP-J0; Thu, 12 Dec 2024 07:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLhzo-0006ju-6r
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 07:08:44 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLhzm-0005sr-Iy
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 07:08:43 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434b3e32e9dso5674725e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 04:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734005320; x=1734610120; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S/jG4OZSmoMTOr2t+Ro6gcZl08OYi5Fi8NlV2v6K0q8=;
 b=JM2LdRqaz4CtAXd/qjltCwLGgRrDHTODP6AO/RSaZkY135Nx4M6+QYP97xxZMxlw/H
 ft+qrJ6m6HT1cX0uwRy38nnJLkQRtpRGqIbAO4I8ocg/3Ls73wjvW+4v9aqL0edifLK2
 gl4o3s3YPn73w09h30LN4wfOcmIbRRwk4KXVEC3Qa6Lj3A2qqiahhcR5KR9/TqYB2wui
 W4P1ZoxMcUPd+IYXMd9tlChaBaU0mFJufTGGaqSxdBaRRWzY8H4PStxPtNrylcRu9/rY
 mPc4tmcjPaCbKyI7RB9TlRQD1xF3jbznMfosb9GEnq3pijg2sIR6pDikhP0eiNd6BYpO
 EI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734005320; x=1734610120;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S/jG4OZSmoMTOr2t+Ro6gcZl08OYi5Fi8NlV2v6K0q8=;
 b=Ppg9KVpOIpt22zpaUJdivGp2nUqBA/AB4YVtsmxVMyKZgjXsaB6rYs0LaFq+lNtjJz
 vKfQqX5KspvoGPdbU1D5XopRsEj5p9c8jydw4qFI6fuvs6oKAM163HzH7PHnRfM3Je6V
 nRXZ6JFTGF7z7kZva5KCjk3mFOMELrwA/LIKX0qR2hT+nNPVRaVag9KDzSB+Z8qMGDjT
 MZ74F+fduA1n8+g5XT1ys0NTGMd6IZXUQWdieWZDrBuJR74/JWdhNWnS4vLiue53lSPp
 eF9IXs/U6hLDXDaG4RSfasqDMXcraxMp4jW4wJuHLCnkZeablSjX8vp/TZbzx4qtb6Gy
 eUqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOL6sUA88KYb5uldG15RELe07i3bSEAM9xw4fokkt7dHlQvCoOkoSVRYlAZzZSLN4MYb1O5p0RBkQ2@nongnu.org
X-Gm-Message-State: AOJu0YyP1y4TQIG63an/ukAlzOTIMyGzeVozuAKJqD7Fnw3o1erPg5dp
 HeblSXv4QXf1E0hSPU+GZABu/krYg2K0/WlhMz2yAYCTNiTba0xoBXRmFHS9yQM=
X-Gm-Gg: ASbGncv2H16gjV88bI0HfB2BRHVCuAwMf8R73kJQSTv+EaA/RqFi8TzjuDIlOXBPA5T
 cbRYiqbuiCwZxrW6auYKxHfMZyJKCYkXfqdTAL97btqzkRB3ouua0SC/y9pNWlIhDdVt0EufUx/
 puJAxN3b7SeOuZVUpuXrHzz11zB8Y4+RhypieZq6UW/5p8y2IJ94j5hP82xJxjzQ09ffsIxKQbW
 f2GIrhvNrXO9Slu6ErL3ODpteERKCtbpiCSI5NaIrA14BNJ8jaw55qaOfhUybYvP28juBjgWfCZ
 JCnkNt4EameE6LNpGk4I/AlQkfMNVw==
X-Google-Smtp-Source: AGHT+IG/XJh3zRSHUQQCO2RgR8kDNZsHgG8Zlv0b7TKcaLkCpXJJmSSUHgVVMgUh1FQ7K9gKlLgspQ==
X-Received: by 2002:a7b:cd9a:0:b0:434:a815:2b5d with SMTP id
 5b1f17b1804b1-4362286c273mr25775595e9.24.1734005319929; 
 Thu, 12 Dec 2024 04:08:39 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436256e0615sm14534465e9.41.2024.12.12.04.08.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 04:08:39 -0800 (PST)
Message-ID: <0bf8e8cb-2c83-4c62-aa6b-c21a8770ad39@linaro.org>
Date: Thu, 12 Dec 2024 13:08:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci/msix: Fix msix pba read vector poll end calculation
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20241212120402.1475053-1-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212120402.1475053-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 12/12/24 13:04, Nicholas Piggin wrote:
> The end vector calculation has a bug that results in polling fewer
> than required vectors when reading at a non-zero offset in PBA memory.
> 
> Fixes: bbef882cc193 ("msi: add API to get notified about pending bit poll")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Taking closer look at my msix pba mmio write patch, it looks like there
> might be a bug in the calculation from the code I copied? I haven't
> looked into how to test these poll notifiers though.
> 
> Thanks,
> Nick
> 
>   hw/pci/msix.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



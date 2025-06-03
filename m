Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AB3C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPy5-00074R-AB; Tue, 03 Jun 2025 07:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMPy1-00073g-C1
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:38:05 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMPxu-0006wK-U6
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:38:05 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ad89d8a270fso1359140366b.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748950676; x=1749555476; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cUATE6JR4IIbTWwCxY0j9twbYtygmGAFWDRnOW8Xe7E=;
 b=eXFPU94UoaTblmD6mCUjyYcayl+Ml7UZ3pbLP+UzcLUC8sEatbbJbwbN3eaROjeM0M
 KurzED/xFsICp9sEJl6Wthk+1+vfxh/Wz2OU6V9kFhbfJTOdBNSPjgxENpEXHAzd88qi
 1XN+96QLKxkB6sbJEKCqWX7O+0fxZQVfFlT1wDwLplNMVR0LQTcmKFAtTVXG6Qi/+bDY
 twZUCUwF5HW/uCOF5SnGE/SGEMt64SCaa7IdeSXgUqOQ2niCTDed2KERSfbdRKewnDdQ
 RmaDlSKTSj2fRE/LRxqxa6KMojMEhMSJnB/yzuODkpiSXP947BgWkq51uBQVN7AXD3Qg
 dzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748950676; x=1749555476;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cUATE6JR4IIbTWwCxY0j9twbYtygmGAFWDRnOW8Xe7E=;
 b=ihlpA0r9Cl+A90AcC2GbfWzMxKuvzciHqnj+vu18nLA73zR31LeGAQ3TJcyFm9RPb8
 TKwqa7Jc7npHGPrPdebJXbgA5pgKKrEyEiP8ls+gBMemx/pzb8l4kmC3mtNjwl1Ro/Kc
 xeDqx5Qcme8Xg4eQTQ8v43zrpIzsrImNWmhjL0XPHJb7Cy3vN4MB/X3l1ptsiFsVLmU0
 VuxhZp+v4LadzaaEwXeF+Apmcm4fN/2xzzEH/28s3NhtFJt2ZLvbRfFm1bJuqNBI4ntZ
 rpF0/rE2ErymQAE3qegFrq8ZRwQevAXA2MgDDQt/3gVXyYMFuAABpNU5KlSMX9SNki6m
 chww==
X-Forwarded-Encrypted: i=1;
 AJvYcCW76OKYdznWmo7DpYSH+vesAqF6FF6Q32ClRLyg1CQhPHNFhHhA8xvPFH88WidyvnEPLCegbrDrZ6FU@nongnu.org
X-Gm-Message-State: AOJu0YwgQghL+LnQnQTAW4MrLuKc0S2M+C/c76eRQG+6Opl114ERqlfO
 1+bSVfuEfR8Wd4v0gylV9/sEFntetfve+tS807sELBbVZLaxC0gNmSSnqWPZ+DGuesY=
X-Gm-Gg: ASbGncsob+EG10CjinOEitjZOY5UWQ2qZXKHbkMtMCxSqxPB0z8qriH0RLxBaqp4Rrk
 LF1Lgz+5gy+sFDe47xvPtLKvhtzuGreTCaf+Z2Cv7pyQs4ihaWrK5nQv1H4GznKnnaoNHVLN/mh
 hSrQYZsBYZ5J1LYZYKpAA+iiamf/91+i1NnuT7AR8pZvLDHaPDU9kTr65xNuMqafJ2il1+WyP+p
 GBv6dOid4kEzQM37uwFflilhaX4l9zQGoTN44bXWsxf4gtedkNTie4XchASRbzGO+XO316pvC4w
 kkbzzY81Kn+j8e+2hwQMxH5Wq0rqykgQJJCJa6nzseePunD7gm+uDxBeQTBwxqxR3PnuSIzZ6sC
 LfwY7Z1OauGmdTqFjQ89kdCCe
X-Google-Smtp-Source: AGHT+IFzjUFKk+8YS7Ua0FUYntEPWE9UBnxT1KNPhnDSeSCNgg/Eg11sqKnhpeVA5w0AnlRdqYvjkw==
X-Received: by 2002:a17:906:7312:b0:ad8:e448:6c64 with SMTP id
 a640c23a62f3a-adde5fe16a3mr202533566b.24.1748950676203; 
 Tue, 03 Jun 2025 04:37:56 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada6ad6ab06sm945314166b.171.2025.06.03.04.37.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 04:37:55 -0700 (PDT)
Message-ID: <4e0e1f04-0d9b-4d2c-9131-5472c2ed37e5@linaro.org>
Date: Tue, 3 Jun 2025 13:37:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] hw/pci-host/raven: Revert "raven: Move BIOS loading
 from board code to PCI host"
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1746374076.git.balaton@eik.bme.hu>
 <4ca4f71bf661923d9a91b7e6776a0e40726e2337.1746374076.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4ca4f71bf661923d9a91b7e6776a0e40726e2337.1746374076.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/5/25 18:01, BALATON Zoltan wrote:
> This reverts commit d0b25425749d5525b2ba6d9d966d8800a5643b35.
> 
> Loading firmware from the PCI host is unusual and raven is only used
> by one board so this does not simplify anything but rather complicates
> it. Revert to loading firmware from board code as that is the usual
> way and also because raven has nothing to do with ROM so it is not a
> good place for this.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c | 55 ---------------------------------------------
>   hw/ppc/prep.c       | 27 ++++++++++++++++++++--
>   2 files changed, 25 insertions(+), 57 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



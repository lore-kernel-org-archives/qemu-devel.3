Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21702C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 18:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trLnT-0007m1-UG; Sun, 09 Mar 2025 14:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trLnP-0007le-MG
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 14:54:44 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trLnO-00030f-7q
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 14:54:43 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22435603572so26148385ad.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 11:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741546480; x=1742151280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aTZMi2Ox3sWCdU7vkKaTOfMg7d81yatyGVq7y2TsqEo=;
 b=U3oJrzntiBFoG08aJRtJ6BfgY/bDz9CxMbFICfXrOxLb4lyf4ve4k1VNk0SNb6T/Ns
 X5WDxiMpiOU0fwsif8hWqU+WzMQWPVrVLU4o9WlnESAs9PqStbMdI/bEhe2PM5GLVjIF
 +fk4NtedREYBPP0BD2zbOy6+cwfPfHWsBFKz+1Lupg28oP5WKcHy0VqjJNzHNK52AFsl
 Qyfr3n7I2Y2cLWpDktPIl6yRXHySX7EAZLv4wvJnovXYman2sOOh/ag4gn81Xp+TaVcw
 3JJjfDJ/KIglB8FDIDuqmZ7gkRG/nigcqetraPUWAW6Jl/U19x38V0hUpUdk8FWQkoq4
 gFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741546480; x=1742151280;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aTZMi2Ox3sWCdU7vkKaTOfMg7d81yatyGVq7y2TsqEo=;
 b=EFa23fKslBaATbuu9UwgBj/VKD4c655a00vJbiOGFOEuZNMNZNe0ezccrMA2hPNgw9
 lw/AxChVZyBWnGxQT6yXMEAd5ObBT7FQiT9zfVNhogPz3+rx6PJ6TOseNrMqh+uhfTVd
 ZDQ2bInYEsKVH8rKgLo7FQU9YofNustod8L2lDHr/4xD51VcqY0oiBFi6acqd3UQl/fQ
 fn3LSDKY+cqmHFu0mjBi/MwmLVxp+hEJKZus2TgBSldEh+MrE0btXfewQE4JdAkkv05h
 aooQkwbAv2vjZr9voR/ICQtkV1V8dblafLMooY8T9O5nkmEnnZI6goonnxzLcdLlDYGd
 v1zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP0+vQqDrTB0UI+xXaN+uo/l8+R+VvBITE9jEGK4Nwiq3UYiy9nB+gVOhxKwYqnhAkKu1TnCndM5Yf@nongnu.org
X-Gm-Message-State: AOJu0Yz+i2nA3bEyjFHJacurtU2hFVtCE/FWXlonOPTeGEFcsSpA8yYa
 vXBSwNIT7UZCDnZ6+5uX1D0uId7zNhsUbBYAsUeRgnUI+DjH+uq+Ew6ltl2ZO/Q=
X-Gm-Gg: ASbGncsRI3sljh7GNI+gmjL3po+mL1CZmBjZZSHtV3sglMBJ8UroN6/Z6fPXnquPf6I
 uZ8DPA4DKvUyJ83U6k6RBbXY8vYm995J7vbb9A5DbiKQroK4lHwl3A4GNQz5b4iHBxw8eAvU3h7
 MnBIMEdXgjBMSUxpsLIihykq5ElSBx8/Bw+WBTne847qCz47TVz6HehVx/JEbOCai/peEkV30U1
 lq6895Ji6sTESEbjE2m6UtUwHHA/oCKo+V2lJg+zv9JZpfaXmDVEVPz5dmmJA23c8FyQMVOWNhN
 WjiKu0o5ziTnug0oCm3ZhpyBX1A2MJBuOHjk6Wr4u4Gw2ErkNCCRFlQLVtKiZS86afVS/NoeTNE
 YPTNgDo49609c7kjNroU=
X-Google-Smtp-Source: AGHT+IFeObLgJtHVcJDJKQD1fEKjqMNawpoG1OnNFO2PQhvxW6kgX1Dpd8OEYr+uvBHxCe87ov0ILg==
X-Received: by 2002:a17:902:e802:b0:220:da88:2009 with SMTP id
 d9443c01a7336-22428c12f78mr161789305ad.45.1741546480101; 
 Sun, 09 Mar 2025 11:54:40 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736b6305227sm4305237b3a.16.2025.03.09.11.54.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 11:54:39 -0700 (PDT)
Message-ID: <4c139702-f13a-41f9-82f1-af3c98cf4a65@linaro.org>
Date: Sun, 9 Mar 2025 11:54:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/21] system/kvm: Expose
 kvm_irqchip_[add,remove]_change_notifier()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250308230917.18907-1-philmd@linaro.org>
 <20250308230917.18907-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250308230917.18907-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/8/25 15:09, Philippe Mathieu-Daudé wrote:
> Currently kvm_irqchip_add_irqfd_notifier() and
> kvm_irqchip_remove_irqfd_notifier() are only declared on
> target specific code. There is not particular reason to,
> as their prototypes don't use anything target related.
> 
> Move their declaration with common prototypes, otherwise
> the next commit would trigger:
> 
>    hw/vfio/pci.c: In function ‘vfio_realize’:
>    hw/vfio/pci.c:3178:9: error: implicit declaration of function ‘kvm_irqchip_add_change_notifier’
>     3178 |         kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |         kvm_irqchip_add_irqfd_notifier
>    hw/vfio/pci.c:3236:9: error: implicit declaration of function ‘kvm_irqchip_remove_change_notifier’
>     3236 |         kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |         kvm_irqchip_remove_irqfd_notifier
> 
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/kvm.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


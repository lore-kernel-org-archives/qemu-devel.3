Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18920C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 13:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seENX-0003AH-W7; Wed, 14 Aug 2024 09:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seENW-00039F-Ln
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 09:49:30 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seENV-0005wp-10
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 09:49:30 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52efbb55d24so11879327e87.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 06:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723643367; x=1724248167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MvmdxaeKXNXybhr4dzq5qE4MfB4QIdk7RoqfISfO1ns=;
 b=uMbc914yRjG0VHthcArU229cH5ZOm6abcJCWhoC9Bm48dYOwzR8sj9kRc4o7A8N0j6
 UG/IltzoDF0gZUjvWdWm7is964xe36mexMZfmh9VddUVBUzrom8IvJlwIJs3zuovmGWJ
 k/Q22OIw1SVSey5ItNo7rDhSwENyzLsm4hHe3U9sIaApBrYJLlzfN9i9PRVmlMaXoiHj
 SSDEjypt9mRSDccmwtyNDH4m5MChJTK5CFZAlLol539yIyzzYSjcEyH+4yoX42iskoms
 Oa62oa79hw+OxnGRniXsT4kRKVdqWCrTeLt557cNSrVmTVFDrvnslet1jSoxV+p5owHA
 atWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723643367; x=1724248167;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MvmdxaeKXNXybhr4dzq5qE4MfB4QIdk7RoqfISfO1ns=;
 b=EhhC7QKtsEudGawItpyVogSWtbND3AY7O08WYQdaw8mh1HhrpWni+zLjgNkmb6wjhp
 PdBSrnje2bevM//kZKe3/2p+PTTX1pXzNmB6lSkZ3s4ak61DGTMBDUympokONfikDcAy
 XOMeSc6+uVoyMyutxkt0UX3pCeY0Obpj9ZHk2y+s3hW7z6BdJbNP7c3q+WSdpfy2owdm
 QkMA3VsHBOSJvx8c+JEwAWwF3ZQ4KmPbInrh+YzWi95JOrNqnOD63j0oV3SmNJp5F+Eo
 JLueIGiz2vfVUGn9Uxk2c0i38+l+7/EyaHGXMA1uctvW+dJupABphHjmMtc7PtgmpKuZ
 qfEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/UMZwnDhB02pE9Wnwnb5rntcI0TTH+jk7R4uwzbO0caSCVEBtY3INj3i+2u/GE5mEe0W+jeqQ1qOLGrW3lkAEsm4uTYE=
X-Gm-Message-State: AOJu0Yy3OoEatZTyfiEAk7nEQycRhyUhHie5Ai03ali8+aAFp7f1OqpW
 CzRD+RespLfGXHndtR9fYmuCyJ6OhHR7jRXiwkzawsHgM3m9B1CWD6mAFAkVwqI=
X-Google-Smtp-Source: AGHT+IFojsUY/FvvM3/tL2ToNji4/sH6NFuQvXR+pvINpMqEZOgyGG9Q8MIHgffxBO2Bc32lT9WgeA==
X-Received: by 2002:a05:6512:318a:b0:52e:9cc7:4462 with SMTP id
 2adb3069b0e04-532eda67246mr2277692e87.11.1723643366499; 
 Wed, 14 Aug 2024 06:49:26 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.57])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53200ec3a85sm1270514e87.98.2024.08.14.06.49.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 06:49:26 -0700 (PDT)
Message-ID: <bf66bee5-1a52-4add-a6f5-56cb03c3a24f@linaro.org>
Date: Wed, 14 Aug 2024 15:48:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 06/10] hw/remote/message.c: Don't directly invoke
 DeviceClass:reset
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <20240813165250.2717650-7-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240813165250.2717650-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 13/8/24 18:52, Peter Maydell wrote:
> Directly invoking the DeviceClass::reset method is a bad idea,
> because if the device is using three-phase reset then it relies on
> transitional reset machinery which is likely to disappear at some
> point.

This seems like fix-for-9.1 material.

> Reset the device in the standard way, by calling device_cold_reset().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/remote/message.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>




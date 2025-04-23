Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4333C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Y6g-0006k2-LL; Wed, 23 Apr 2025 07:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Y6a-0006dO-57
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:17:28 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Y6Y-0001t8-9l
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:17:27 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39bf44be22fso4327587f8f.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 04:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745407043; x=1746011843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j3dF8XsoLGRcZL9i4eMNjIcEEBRNDL3P/zQ+KH091kg=;
 b=LGgfqeM7b7juBzojFb/S3Jk1wwBqbslngcM8QyZYyoTQfRr9wEpg1GJjTux7hGOEzt
 6S3BtLAXArKcciYfPh4vqXsY7UpALgUXViF+Pg638s3vhJbNf82mJBbzD9z7FgixfVdU
 CH3bESe14mOqqWVOQygjfNt4wD6bGhob7ZgMPHip3tb9aG6J993cPqz3srS0lceZh4oJ
 j/DQyG0e64sGFWsKjegXfBIB2xjeY5bsSCcV+NXq+oXHJbmLoMZA1auUofWSrXrcuAjR
 7i8gG9HxcqFM9pW3AG8J+T9Plr35u/2BhJGf7+9iMJ+A6HfVMzBSqvLKL53rXz0v7I0L
 ci8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745407043; x=1746011843;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j3dF8XsoLGRcZL9i4eMNjIcEEBRNDL3P/zQ+KH091kg=;
 b=T0ecvyxql2ImSB0sf2/4EBBftC1GLNGWZIYPGEHY8E6QClpj1XKaxBb63vwZ/EnjyE
 80ZL4CrrLrKl7BMrVmnQ3xpKlSf0IE1lgTbFKms8bl+tDIvYrrFQtgU/qbUr5N995mgJ
 ilfmCke/bkgzqVQOfarm57FSjACihUJDANsL7iLm86Bo5r3EJ/aL54Sq5J503IbPN3xS
 7vcQ6TCmtKtS500h8SqiVYcPdWIHr9aM6bHZTUYmdm7/FKLyI+TkQIXE+CmJedTv6ICu
 kKvmmj3CCfZt2tlWsEdLzVPUQur8xm9kFyPEjTRrCZCDA3bP3uj3diLovFdSXch2Udev
 owGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqD8ccn94KGCM+6IjFrwQTZBIN/UirGMeyid4IJMkVgQNlyJJ11W8qMrQpA6uko912Oman2+dmM1Ev@nongnu.org
X-Gm-Message-State: AOJu0YzX4B/9l/JN9xrJsDLTGsR0AX+Hgquvun6nNuJahl6xXbLqja7B
 nncPPe4H22MZ9OZEXJQwWbxElLUEcvIwj72P9fw9zW01IkUpuakyS4Hu760OUAKQkImfWs4YumH
 4
X-Gm-Gg: ASbGncu0fwVTLqJUWcO6TJNnkBgiGuI1WNZHxw1fG8VqS6QDw6DoRhyla0MY+Obxx65
 w/+7XrwgbWbKOcex+//dzUoWbn11BldsovBrGo5GSznlMFrtPLUAdB4/bNt+4S8+avV/GKrRPsD
 hm3XBVuOz6kYFFXpeUmQLf2Y1XhSeYU44oYb0rC9g9ZNT7UrJ1WPDpg+x4fDRNby5J9Mjo89nh0
 zSSmq4pQ1orih2iypjeqXeb1d0Ah2Co6fp7Whb8U+xQg8VTp2LzXc53DMebrsyiA3oGjbZcRro7
 Y6Zv/MP7Bp0GqDQp6+j+Q+zWj0uWtbuQE7JnIHdD/d29cPo4xBybBW1cgzc1ygZCxdNGLXzZCa5
 9PSB0Q/Pn
X-Google-Smtp-Source: AGHT+IEvVwh/VQ70BdSL8QgdtRDKO4sWiTXUso9bOL8qOYX5UoySIFKYPqrWGH2eHHdVRo5YNZ+/Dg==
X-Received: by 2002:a5d:64e4:0:b0:38f:37f3:5ca9 with SMTP id
 ffacd0b85a97d-39efbaf1126mr15081984f8f.50.1745407043214; 
 Wed, 23 Apr 2025 04:17:23 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4a4b9csm18073196f8f.84.2025.04.23.04.17.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 04:17:22 -0700 (PDT)
Message-ID: <fc3846bc-8443-435e-afa6-11fde4d3cf97@linaro.org>
Date: Wed, 23 Apr 2025 13:17:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/i8259: Remove unused DEBUG_PIC define
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250423101125.B243A55C592@zero.eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250423101125.B243A55C592@zero.eik.bme.hu>
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

On 23/4/25 12:11, BALATON Zoltan wrote:
> The debug printfs were converted to traces so this define is now unused.
> 
> Fixes: 0880a87300 (i8259: convert DPRINTFs into trace)
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/intc/i8259.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued, thanks!


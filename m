Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1653CFC293
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 11:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0fwh-00013j-0K; Tue, 15 Oct 2024 07:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t0fwe-00013K-Mg
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 07:42:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t0fwd-00063w-6g
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 07:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728992549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=56Sd/sXHPAXlxuCVJIVmNNJa4yqWVrWIwOjvMVdZPPU=;
 b=H/1tIMHOWP9oQaz29jD+WAyV9Gmzt12pAYi0302fhVB+UuANWhjUw3vRx+dQDOQVJy0+yo
 1ztyE07P2KnVqrrHSJgwsX5dPTaKlJcuextsHnmUYeVeoaRf6vkg5u0ZscxJMqARxHJRgn
 1NAlgYW1Vrpu9pF8rT+PEKqfLQ11CN0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-Cs8EVPTzNPu62ZNuN7tR0w-1; Tue, 15 Oct 2024 07:42:27 -0400
X-MC-Unique: Cs8EVPTzNPu62ZNuN7tR0w-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-539e294566dso2942966e87.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 04:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728992545; x=1729597345;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=56Sd/sXHPAXlxuCVJIVmNNJa4yqWVrWIwOjvMVdZPPU=;
 b=DJeIP7vaOXLM4INyFUQKH9Iz8TZ8uaNMav4+im0C4uR+c8nhzaeEIUZ8ekNgBvkO/L
 k850pf5Py9k6lUtqMxib0EkoVMKcYbbFA1jod/4geA8bFFC9YrZLH8vu11AMpXv0DZUq
 IHFfqBJ2Rhr5kxZc72OGpO1fAr5aNI6sScpRiRBbMxhGX9JstPd3tzDk7VVSqvzqGiZA
 TbBXvwSsxVeJyoNQkEvmmc5Ejm0uxyyFTiKYqSAp7PTKUAOVoIk/OzlEcRp8/33g4rR7
 8vyCozTWQridI8YwXiQxR4xNQ6eQfD5dV3PoV6BVdPhtha6WjZDNMe4opkR8rcqYiweC
 lqpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhxkhOohk87t43WF5PvDdxj1wO4VQudWZZo2a+x8T+eXXk60Cf7D0MKejHAZc31t4MnilBBMU0oPOA@nongnu.org
X-Gm-Message-State: AOJu0YzxTmbf5FgsYSba6dJJTGd55mlrFG+OsvYatitJRBjxJuQmC1s6
 YGNyp1090BDDbmlVwTMBDr8OLrl6Ntp4zfPoKC3gQnAzkqV9P9OLjCIYx5Gpa7qIG44lS9B3Ub9
 DDbeXJhq0vZ1owpZaR0998KWbwFBC4XkogT1r72whSbS8KNo81HTk
X-Received: by 2002:a05:6512:6606:b0:539:dc87:fd3a with SMTP id
 2adb3069b0e04-539dc87ff49mr5679215e87.6.1728992545376; 
 Tue, 15 Oct 2024 04:42:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdEFoVzyIdpPoLtdyTZTt5bhn46sLxY59in30nQsXHtR8jxpAECCDsaDTYZlxcbREhiivedQ==
X-Received: by 2002:a05:6512:6606:b0:539:dc87:fd3a with SMTP id
 2adb3069b0e04-539dc87ff49mr5679204e87.6.1728992544845; 
 Tue, 15 Oct 2024 04:42:24 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-109.web.vodafone.de.
 [109.42.48.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f6c5531sm15502935e9.46.2024.10.15.04.42.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2024 04:42:24 -0700 (PDT)
Message-ID: <24e57088-ebbc-4a9e-919d-5d05cfca00a4@redhat.com>
Date: Tue, 15 Oct 2024 13:42:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Raise the ide-test timeout
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241015113705.239067-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241015113705.239067-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 15/10/2024 13.37, Peter Maydell wrote:
> The ide-test occasionally times out: on the system I run
> vm-build-openbsd on, it usually takes about 18 seconds, but
> occasionally hits the 60s timeout, likely when the host machine is
> under heavy load.  I have also seen this test hit its time limit on
> the s390x CI runner.
> 
> Double the timeout for this test so that it won't hit its timeout
> even when the host is running more slowly than usual.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/qtest/meson.build | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index b207e386965..e8be8b3942d 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -4,6 +4,7 @@ slow_qtests = {
>     'bios-tables-test' : 910,
>     'cdrom-test' : 610,
>     'device-introspect-test' : 720,
> +  'ide-test' : 120,
>     'migration-test' : 480,
>     'npcm7xx_pwm-test': 300,
>     'npcm7xx_watchdog_timer-test': 120,

Reviewed-by: Thomas Huth <thuth@redhat.com>

PS: It's a bit weird that we see more and more timeout problems recently ... 
I think I've also seen some local ones on my laptop when my system was under 
load, but not really reproducible. I wonder whether we have a performance 
degradation somewhere in the code...?



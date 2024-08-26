Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3FCC5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 10:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siWVE-00056Z-N9; Mon, 26 Aug 2024 05:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1siWVB-00052c-Eq
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 05:59:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1siWV5-0000WZ-MM
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 05:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724666340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fT72gMaFME0vEI+lskxQABj2puN0glmxGVGG+rztaqE=;
 b=gIIEtc4oHO/zaMSq+r/w4o7W5E4VJ0whuDdsryWxB7nKweDAyYA1UMWnztx9MTeRaBT1h5
 D9bMXRaPUJeK5LK6SLc2UhbTvduMF3j1OhTzmdQeGlYvjg7UwK7d/GspGPK5qnb9XbZRRv
 tPoS6zBhY8whNddJ9xGfUmlCRZME5EM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-Wy0ufnx4O-yw3BE6uI7msQ-1; Mon, 26 Aug 2024 05:58:59 -0400
X-MC-Unique: Wy0ufnx4O-yw3BE6uI7msQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42ac185e26cso41114465e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 02:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724666338; x=1725271138;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fT72gMaFME0vEI+lskxQABj2puN0glmxGVGG+rztaqE=;
 b=p5dDjbJNqRtC1Xi9wRa1CwL0qmPvYMyXhxQHMyhuHGJUnrot2y3vzxTUxkkmW9VWsb
 1+k6Es5Njsv/JVmdVOTQTh6CzFSv3vk825FRmUAzGO1J/N+KzKDQn5noIXTInHsXbDW1
 oyQwWZ9h/ceBVFbBChga2EdiLtupnmIE6zvumIaxLCMO00+zxPjQewyY9EeCywuxEKfS
 rAVxj8RnklOszlEUCjM0fJL4XADxUwCTokEZBAGDdbqKr7hy1eqXvDKJZ4+6B0VWtQZy
 /xHW55HR1oTochaNgD+5aJww9855ke8/A87ciOH+/Yl3ni4sP78mRyyRbRm0I2RZZxV+
 QG8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7mNx0hNKljEWkSwXs/MwBH4EnGl18vpvXJMWN6+0Y5Ao/EfF7ROdsVsQ4dY3JOSyCXXQRoc7SNNpY@nongnu.org
X-Gm-Message-State: AOJu0YwTZ6isj4OHbYOdDZFZIBDU4iOM2pBNOxNGVMF2w9ppUQwjRyo9
 B3xKfi7FoA4IrZUTTqcFRSTmvXdxJHZbhODsmFPFovwYDbroUJcb11cC48qGB4KPFbVaFzv4zu8
 YElyN6WL2KMJybNMbLgA95HrtPhhForuRmy1iV6kA2EJNvBZmGtKV
X-Received: by 2002:adf:f143:0:b0:371:7e19:b9de with SMTP id
 ffacd0b85a97d-37311878689mr5273608f8f.32.1724666337799; 
 Mon, 26 Aug 2024 02:58:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGniSroD3zQGjVl9F4GRXldsavkf8we3JgGCKdzntrwZ0ZU4AtKTehkZY+302URNjVNlRC3Rg==
X-Received: by 2002:adf:f143:0:b0:371:7e19:b9de with SMTP id
 ffacd0b85a97d-37311878689mr5273595f8f.32.1724666337348; 
 Mon, 26 Aug 2024 02:58:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3730813c5edsm10364173f8f.31.2024.08.26.02.58.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 02:58:56 -0700 (PDT)
Message-ID: <5fb7342b-fa67-4cb2-b6fd-2241b7b76d03@redhat.com>
Date: Mon, 26 Aug 2024 11:58:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] aspeed: Deprecate the tacoma-bmc machine
To: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240625070830.492251-1-clg@redhat.com>
 <4e04f930-e7af-4084-99a8-2a3139e2bf43@roeck-us.net>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <4e04f930-e7af-4084-99a8-2a3139e2bf43@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hello Guenter,

On 8/9/24 00:05, Guenter Roeck wrote:
> Hi,
> 
> On Tue, Jun 25, 2024 at 09:08:30AM +0200, Cédric Le Goater wrote:
>> The tacoma-bmc machine was a board including an AST2600 SoC based BMC
>> and a witherspoon like OpenPOWER system. It was used for bring up of
>> the AST2600 SoC in labs. It can be easily replaced by the rainier-bmc
>> machine which is part of a real product offering.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> I have been using tacoma-bmc to test tcg,tpm-tis-i2c functionality
> on arm. rainier-bmc doesn't support that, and other IBM BMCs which
> do support it (bonnell, everest, system1) are not supported in qemu.
> 
> Do you have a suggested alternative ?

Could you use the ast2600-evb machine instead ? as done in
machine_aspeed.py, see routine test_arm_ast2600_evb_buildroot_tpm.

We can't add a "tpm-tis-i2c" device to the tacoma-bmc machine init
routine because a TPM backend is required.

Thanks,

C.




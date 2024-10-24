Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D52D0BB5E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 05:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3qeP-0007VC-5b; Thu, 24 Oct 2024 01:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3qeM-0007Uf-FL
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 01:44:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3qeK-0005el-Ml
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 01:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729748683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LhDSc78mbj/tVU33sqYHlS7jBB5c6NG8lTPb2n97Oc8=;
 b=Axu3IL5kYqebA0SdWwC5hD4foCXhkonIAIqBkwHzMLA5i5petSgsha1nIS7KenjQqfoWNv
 YnCZWywpC56dbYIv90xooUDYQRo47jUEg/H0hkM9IeyMMtbyz44S4Cr+R+uppRRJiT3CHr
 jdvf8xNSF4aRP4/fcaBqjQ81CHNkXt8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-ZvfyN3k-O4yZXDPe0EdYcQ-1; Thu, 24 Oct 2024 01:44:39 -0400
X-MC-Unique: ZvfyN3k-O4yZXDPe0EdYcQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a9a2a81ab82so26909066b.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 22:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729748678; x=1730353478;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LhDSc78mbj/tVU33sqYHlS7jBB5c6NG8lTPb2n97Oc8=;
 b=oYEnUN80X5bysROKyr0xQtibWuswxy2c8tTV9yfEfWtyyYpzu+FxiCFW4b3AQz8Mss
 Ywj+qjYMmU3fq/0jChK60LhReaVmS6A2oEROUSSWTcIZLioyPm8CjhhklOsB8L15QOPj
 8xJ/IxnivbjkuCpddM5tSKxhYPF4HzlEiR1d1QORSYOWrwJbkc90lOWIyLjTMEUNzS8U
 0p60YNKU7GMRYotp6S9CSWCPKuQuOuM1GaaG8sLgVc7BxxbM6aGFjwp3kY9ebCG98JxP
 9d9h691xIRxaSzzLGkYHPYkMkklXgIFA2RrrTypHsk01esE8p6JbL2kPqsSYH0bKI+XZ
 fvGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/bul48tXENdpTqhVMg1SsQbAugMC27dJpOf3JFfEKpRXnSR3ldiKyyOcSL5Tt1qvLZDPzsab5S8SQ@nongnu.org
X-Gm-Message-State: AOJu0YxQ4kXG2+WJ2gtzCtrsDXDvPVqVgSzRMyYSAL/EDSCQKSsp/Kco
 vmgbDP72Xfv3n/PZhYR8nzYgi2AiOGsfb8Ug3MSf7K5NmWhPITVL+vPGLbUB7C5K2xLYYoE9GWQ
 3FqOCL/BqTc1vJBbnc2Xoo9apprrpBXWex/bo1unT4NRjr6rfuRhz
X-Received: by 2002:a17:906:f58d:b0:a99:4aa7:4d6f with SMTP id
 a640c23a62f3a-a9ad2709897mr66793566b.12.1729748678373; 
 Wed, 23 Oct 2024 22:44:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNrT+XQYGunJTt46EQSenuz+QQ936OeTfE9OaIHAXI8161EL5zC3hzwo+It6euVG7YHkifAg==
X-Received: by 2002:a17:906:f58d:b0:a99:4aa7:4d6f with SMTP id
 a640c23a62f3a-a9ad2709897mr66791666b.12.1729748677981; 
 Wed, 23 Oct 2024 22:44:37 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-40-241-30.web.vodafone.de.
 [109.40.241.30]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91559dfcsm560497666b.132.2024.10.23.22.44.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 22:44:37 -0700 (PDT)
Message-ID: <9f8b2357-a28a-4b80-aa5c-ff1725e364d9@redhat.com>
Date: Thu, 24 Oct 2024 07:44:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Please put qemu-system-sh4eb back.
To: Rob Landley <rob@landley.net>, qemu-devel@nongnu.org, jeff@coresemi.io,
 peter.maydell@linaro.org, glaubitz@physik.fu-berlin.de
References: <d6755445-1060-48a8-82b6-2f392c21f9b9@landley.net>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <d6755445-1060-48a8-82b6-2f392c21f9b9@landley.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
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

On 24/10/2024 02.11, Rob Landley wrote:
> I use it, and ship system images for it:
> 
>    https://landley.net/bin/mkroot/latest/sh4eb.tgz

Oh, that's interesting, I've been told that the r2d machine does not work in 
big endian mode:

  https://lore.kernel.org/qemu-devel/87a5fwjjew.wl-ysato@users.sourceforge.jp/

But yes, your binaries apparently work there, so sorry for the confusion.
I'll send a patch to revert the removal.

  Thomas

> And here's me recentish-ly debugging an issue via it:
> 
>   https://landley.net/notes-2024.html#24-05-2024
> 
> (Compile/test cycles are WAY easier there than copying files onto an sd card 
> to test on actual hardware.)
> 
> There was a big-endian issue breaking r2d last year, but it also broke big 
> endian mips and some other targets too, and it got fixed. The binary I built 
> a few months ago was working fine for me with vanilla qemu git source? (I 
> don't _think_ I had local changes?) I can try to build the version removed 
> to check that...
> 
> Yes I should be better about pushing local patches upstream. For example, 
> here's the kernel patch I use to run fdpic binaries under qemu:
> 
> https://landley.net/bin/mkroot/latest/linux-patches/0002-sh4-fdpic.patch
> 
> Which lets you enable the FDPIC loader on an mmu kernel, which is useful for 
> testing j-core userspace under qemu.
> 
> Rob
> 



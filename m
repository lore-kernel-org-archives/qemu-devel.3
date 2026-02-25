Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79278EFB7F0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 06:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv8eR-0000Wf-LC; Wed, 25 Feb 2026 01:45:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vv8eP-0000Vk-BP
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:45:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vv8eN-0006nf-0U
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772001933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qQlzP7R+aGrBmQTMQNnIoUiYbYcejk2ZvxxDY5duvMk=;
 b=W9w7Ogxqo/34do9e0Vx5kdRzLkjXtFDARt0jJZQK1XiUJbD0NWIwW8W5Rx4T3tPs3MPuy+
 gq3aLcYgWdC6UOU0u+duWvo+IB/wFTkqQ8hbKWFMd0bbLe4eRBrTeh/hqR7L2b9d+AcXiK
 uskeuR+tm8C/TxXy6Rc/MknQqddFmBs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-bQeIPsZQNGiAt_zqw8n9uQ-1; Wed, 25 Feb 2026 01:45:31 -0500
X-MC-Unique: bQeIPsZQNGiAt_zqw8n9uQ-1
X-Mimecast-MFC-AGG-ID: bQeIPsZQNGiAt_zqw8n9uQ_1772001930
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-482d8e6e13aso52704505e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 22:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772001930; x=1772606730; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=qQlzP7R+aGrBmQTMQNnIoUiYbYcejk2ZvxxDY5duvMk=;
 b=bhiIYoMZSMGyR4j3DdS/WYHuiS7VnHtg0WnqSETpaERwBC5/d4PdEBJa7tGdpugy50
 g6dM4VcG9nIONyOFXLAeNUMSkI3SGZJpt0igElco7VOMwXd1ELYol/SkQE+f+83E+rp/
 UnAIJruwKymSW6M310aJwkrQo7V30eG9PDVDTzRWBwUiRqs68IyHlKOPzQHlemimxeNM
 gj4k/MEnIm8vZyk7+6c1E1ZSVr4lDqU80WnltzGvyahfIoReN5rOKOET8WCq24+Fm449
 LAEh67pLiv9nWILnr3tkgyof+Ew43pjDb2quJWgGqj7LYI68ReprVk+m/iwjCTVcH3u3
 kWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772001930; x=1772606730;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qQlzP7R+aGrBmQTMQNnIoUiYbYcejk2ZvxxDY5duvMk=;
 b=CxBpQHljxA8q7bywAu6DMu17soeR2y5Gt/G9KLqdblgZ53TmowP2qO1wU9NSSR1V5g
 4Da1lOsDV+gX45fMT+/e44xmpqEns5IR0XoVAQeO2C45xqNXHP8AuUhv+77uh8X5L+gO
 SdkBtvUgNJ4PJ7mP1bAq5+qcqZv2S5s6c8E7jdoX7yHhPEb6tH04XyewjoGeB5WkCYIq
 Eq5hDAmUcM/pM0nKiG9NEA68KpURjDL4Iahv/RqnVa5/o+MKLxjkbaAbmiAT+MAJ2upH
 ZRa7Sk7RW0GzXUPAyaCi1b48qpbmle8/lYTw42NOrOeZz/ENbDoMRDieexvPbcstZXdZ
 kMoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmFA2av/gzNPIoJ7zTMVCBnmb+xtxEWbsyfjD5xPIE5oXxmvCUj8y58D7BbtRDiNf7AlKdSqUmM1Dz@nongnu.org
X-Gm-Message-State: AOJu0YwLAheBZi2B+mu3e0iSzwGGcoRCAqFfX0Q1sKy9Lrk/C/JOTLCX
 nc8KkGqjLaluiqAE7fTnCPw8eSeKNY2It61WG7c1Pb2BlHVgkvaoUralgxHl2wAC7z4Cq5yBxbz
 rM1oco1WqqwsISg4G5sojy2nHDkck7W60VXSy5ci9hOqTWIDDaJGQp0q6
X-Gm-Gg: ATEYQzwAX+qLaL5vP4bHGikJZnJZhcE5taN6f7N99HyzN7/rOdgFF9xZNmMA1ZTwZ/Y
 YKO4Zjkphr7LS9oNFLanwQhQNRHePRjcO7PT6ao8K+EjPpx90QJ5DgKL8H1+KfrG+Hpyb0YI4sB
 N7s2wTUS7EVEutWsNGnw9lGM48fEySzJk8HpQ43GSYMJy7YQXwVqbZCAtp6e8v4vJItLRgnFBXi
 hS2dPTAfJmrBHZbh6t/Wz5lpNANrTo7tqR0SBrBKcwP3gFj6rF31rLZ1cK0vIMCw6ZMJcyJ0I2c
 ZxgQxuyfeMTH8oM/xAyK47jHE3FPmRpwvdnbgYTbgUJkCJ9UjrxDahKFEAYtgHPvnIlv/ZMnKJ8
 5Fd9coaKHOdBFtxsyedoIG9Khwcxd2OTSgpEKJasqNnk3+KTpfr1PiVuHkQ==
X-Received: by 2002:a05:600c:46c9:b0:483:a21:774c with SMTP id
 5b1f17b1804b1-483a95eab7cmr249368455e9.25.1772001930386; 
 Tue, 24 Feb 2026 22:45:30 -0800 (PST)
X-Received: by 2002:a05:600c:46c9:b0:483:a21:774c with SMTP id
 5b1f17b1804b1-483a95eab7cmr249368065e9.25.1772001929903; 
 Tue, 24 Feb 2026 22:45:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:2c1a:3780:4e49:dfcf?
 ([2a01:e0a:165:d60:2c1a:3780:4e49:dfcf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfccb9f9sm4531085e9.23.2026.02.24.22.45.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 22:45:29 -0800 (PST)
Message-ID: <47860c63-e6df-40a9-b34b-e981b246b204@redhat.com>
Date: Wed, 25 Feb 2026 07:45:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/16] tests/functional: Add SDK tests with Linux 5.15
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kane Chen <kane_chen@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
References: <20260212213955.2225662-1-clg@redhat.com>
 <20260212213955.2225662-3-clg@redhat.com>
 <CAFEAcA_oJgTc2SyRr11QTeTkmCPgvKiwngAaDiDNw5nUcTFA2w@mail.gmail.com>
 <CAFEAcA_9Np04vouA-m99xB8yU-JhduwxxLj_dTG0QM=AnDbHoQ@mail.gmail.com>
 <aZMwvfw4O5xeH-Gm@redhat.com>
 <98898cd4-de19-41b7-b519-541c48b462ea@redhat.com>
 <7b68fe15-f8fb-4d72-9559-8b6b89bd7563@redhat.com>
 <TYPPR06MB820657F01C98468E1F166C7FFC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <aa6cbbb8-d8db-451e-9f9d-c430b2e030d9@redhat.com>
 <TYPPR06MB82061B01B8E9B13A241A6AF8FC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <6be71017-6be7-4be1-9010-6a1cc4391bd8@redhat.com>
 <TYPPR06MB8206A6B15C49657A1465DA4EFC75A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <TYPPR06MB8206A6B15C49657A1465DA4EFC75A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Jamin,


> I plan to create a new set of artifacts for each QEMU machine.
> The original packages will remain available on the ASPEED SDK release page, as they should not be modified.
> These packages are used by customers as well as for ASPEED internal testing.

yes. This is what I expected.

> 
> If users need to test specific images such as ROFS, U-Boot, the kernel, or perform full OpenBMC firmware updates,
> they can download the default package (for example, ast2600-default-obmc.tar.gz) for complete testing.

Good.

> The ast2600-default-image.tar.gz package will include only image-bmc for QEMU functional testing and will support programming the entire FMC flash.
> 
> The contents of the new tarballs will be as follows:
> 
> 1. ast2600-default-image.tar.gz
>    image-bmc
> 
> 2. ast2600-default-66-image.tar.gz
>    image-bmc
> 
> 3. ast2700-default-image.tar.gz
>    image-bmc
>    u-boot.bin
>    zephyr-aspeed-ssp.elf
>    zephyr-aspeed-tsp.elf
>    bl31.bin
>    optee/tee-raw.bin
> 
> 4, ast2700-a1-image.tar.gz
>    image-bmc
>    u-boot.bin
>    zephyr-aspeed-ssp.elf
>    zephyr-aspeed-tsp.elf
>    bl31.bin
>    optee/tee-raw.bin
> 
> 5. ast2700-dcscm-image.tar.gz
>    image-bmc
>    u-boot.bin
>    zephyr-aspeed-ssp.elf
>    zephyr-aspeed-tsp.elf
>    bl31.bin
>    optee/tee-raw.bin
> 
> 6. ast2700-a1-dcscm-image.tar.gz
>    image-bmc
>    u-boot.bin
>    zephyr-aspeed-ssp.elf
>    zephyr-aspeed-tsp.elf
>    bl31.bin
>    optee/tee-raw.bin
> 
> Please let me know if this approach works for you.

That seems perfect to me. Thank you very much.

C.



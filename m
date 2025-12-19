Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DFBD7879C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdEz-0001u5-7d; Fri, 19 Dec 2025 11:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdEv-0001JA-8J
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:22:01 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdEs-0006KB-Ll
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:22:00 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so1432525f8f.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161317; x=1766766117; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=joj8i0fNR24LPYYr+YaX/7y5L4NeOssFigh3GN1Oyo8=;
 b=W9prVp9+7o1e28qEB7G3rdW2BNTaT4uDoXRWvrYkh0Upwmq+awWYSqjNoN/YL+m7j+
 vFK0wkG00vcN9ynMLCQUjxElwOZucpC4BIJ28uyX7qOViM8ZJ4SmM02GvRr/YI1RVx5b
 XKLN3QfZcRfMIZYTvHvmKr+syj9JFTawP0R5LxmexbfSktxWxojLzdDIYouxxJUl/KXP
 HxcDQFMVg4z2INjXgWSNQPDM7IYlNFM5QBZrWcRdLJftEag/OoLmnfwKHqkkc8jGZVxX
 UvJWymFMkjBrnZtd8iSmSTUaweqplfnHUsBwy5jDKaSJKx76zX7Z21H5vh73Jeu6vinb
 omaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161317; x=1766766117;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=joj8i0fNR24LPYYr+YaX/7y5L4NeOssFigh3GN1Oyo8=;
 b=D1MJ11rKBCL4Wgu63ElrzdV0RWIIOPVNy98OOOGQNNCXOk8bx5+LMAoQFRQ9hWVCoR
 MvxgidAQXQ8JM9Pv0Zlodg/96GaABAc1j5KOnKwZ2SrhxXADXrP97t8xbn5FYBO0yNJJ
 UZlgB9nE6W6DVGd8sg0+2ZkbzNbODbuNuxHGTev+BF9FF5BXM1wlhg5x+v5uztqgR7hs
 EYuRr5yrNHEQTics8070y7ZYJ2DQYX+UCvFC0tw6AwndSvS1M/uZxfVXsuoDDIMCdw5w
 6r+wAfy8Bk8y/J0RYmxjN89usuGbfyaDF1i5MjMOdEV7483nLPT2Yd9yFsTOnrAM+rwa
 WM/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBZqb5VNY5XiaHV1GkHRp7Qg4PCwRKhPA7IPw7hYAXec7AwSEGj89YOmT0vMnyTvr9t3j3/Jhe5MjT@nongnu.org
X-Gm-Message-State: AOJu0Yy31kqrYS4NGKCbmwLB3J0e8eDggFGEN9nFk1Uo3fUVR6DAUBOS
 yNSqGY0IY0x8iRirNDXhaHUYEKDkqolFmz20cyD/AgcEI9mztzSaUDUfihkOBhghQZU=
X-Gm-Gg: AY/fxX4GhqSvSBsaW5qLTDHha2G36rbwluCA0JzMYPYL29gr1ZBC3tT80Sk1pCXjG58
 7L+O0gCQ7iW2fq9B9ahzGsQnugzLA2PAx+5diW5+OMsH/SlX4KYt5ebySkusewGL/Fefmmg27Vx
 PJcjEdIy+mkWYoFm9m2/U8+mQ8oy+6zL7LItVX23Fu91z2GynsQ84b2ieyRl3VtAo+i9qPpJcJA
 K2CXxmBD0/0oOhcEmeeDiq2J8AKAs/PVXBRJs0JCuqQFuMdSIDPi3LI3ppHZ7zde/QpZKYSSHC8
 I3VxTdWU1R/DtrmWp6Ht2I9L/gBJxd4JX17VrYecCy/WbJppzuBSCj5JiWhdUyYtusi7J80mf/h
 mzS12wi60hXeVM5wBmj3SMKTkGKG4eSGg/hPKlM67qeWDPED19VcsdZY+xHggPDTI9RVzBSNAQe
 JoXHCtH4xMonzZyktzGcANdx2o5SGznAeT83/lF2Vh5wUm+B91xo316X/1nSX5ypy7
X-Google-Smtp-Source: AGHT+IF1J9ionw+GAqgeIPhVOr2K5m8jNtF/sjDWSd4IRG5EyhFKTEphDUwm/6WHogI9A4dwoJ3k9w==
X-Received: by 2002:a05:6000:2305:b0:430:f5ab:dc82 with SMTP id
 ffacd0b85a97d-4324e4c38c8mr4361857f8f.3.1766161317038; 
 Fri, 19 Dec 2025 08:21:57 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1aef7sm5619208f8f.7.2025.12.19.08.21.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Dec 2025 08:21:56 -0800 (PST)
Message-ID: <0c3e13e1-0aeb-47f9-9c44-5af8f3f47055@linaro.org>
Date: Fri, 19 Dec 2025 17:21:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] util/vfio-helper: Fix endianess when enabling Bus
 Master
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, thuth@redhat.com, stefanha@redhat.com,
 kwolf@redhat.com, fam@euphon.net, alex@shazbot.org
References: <20251217184253.1520-1-alifm@linux.ibm.com>
 <4d7e4040-349e-4772-bdf9-43d4f8a6f771@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4d7e4040-349e-4772-bdf9-43d4f8a6f771@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 19/12/25 15:51, Cédric Le Goater wrote:
> Hello,
> 
> On 12/17/25 19:42, Farhan Ali wrote:
>> The VFIO pread/pwrite functions use little-endian data format.
>> When enabling the Bus Master bit, the value must be correctly converted
>> from the CPU's native endianess to little-endian format.
> 
> How did you find the issue ?

I presumed using VFIO on s390x hosts...

> 
> Thanks,
> 
> C.
> 
> 
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   util/vfio-helpers.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
>> index fdff042ab4..3c8284284f 100644
>> --- a/util/vfio-helpers.c
>> +++ b/util/vfio-helpers.c
>> @@ -443,7 +443,7 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, 
>> const char *device,
>>       if (ret) {
>>           goto fail;
>>       }
>> -    pci_cmd |= PCI_COMMAND_MASTER;
>> +    pci_cmd = cpu_to_le16(le16_to_cpu(pci_cmd) | PCI_COMMAND_MASTER);
>>       ret = qemu_vfio_pci_write_config(s, &pci_cmd, sizeof(pci_cmd), 
>> PCI_COMMAND);
>>       if (ret) {
>>           goto fail;
> 
> 
> 



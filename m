Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043F6C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 11:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCdQo-0004TJ-Bh; Wed, 07 May 2025 07:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCdQk-0004PR-HF
 for qemu-devel@nongnu.org; Wed, 07 May 2025 07:59:19 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCdQi-0000HH-Mr
 for qemu-devel@nongnu.org; Wed, 07 May 2025 07:59:18 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ad1e8e2ad6bso173307466b.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 04:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746619153; x=1747223953; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SH6b9zQQV0lci+6HTZeoMmH460ygIDVI8hLOfHQhD9s=;
 b=MYnQkp849RpaLQ3RtdLo/mknjJd4M01VEe+r6rG7cDpv4YUKW5d34QJSzTasYQeSke
 mBbd+Yjs2D6WdsMeiQZAZO7a4w6cfqrYti+IPhKG3V0s3Vbphq/CQPL3bZumFdiZLvLY
 uABNQGkE4Uykf+kdAbLs/I9LzaP2wTXU9uVxiWHKbvLTJEBCJQh2+ikJm6QHjhFUu/sw
 trDIPrlV/qJm/lcSE58wk/NjY2NhSYoXQGEPhJNjiezZrrVVasBRXAZX9h1TLS2hlVRX
 nRP7STWjYTQ2NM28WWSv5iofWyGMuEGgMet/OjE4H90+sMvY9njt+y9MOJbMtjgQSHJc
 FQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746619153; x=1747223953;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SH6b9zQQV0lci+6HTZeoMmH460ygIDVI8hLOfHQhD9s=;
 b=teFV6HhIPgwz75mGP3I0YLiKDcuABIeqxe4AShUqLluRC5bBMEaXl1F9R7tN6zkgqJ
 Ix1KR/UmKxKOHCeMrRTAr7b5c1EZoyr45vVmNlan8e6icBNpf+w6jhlOL09N4uS1CVTz
 hkTS4LGNN/+1GJVuxdAcoKEWOFAwWWOk9llB+O6/jN5/yMF2kLeEXa9t6XNOK9om2/F0
 HUOFUcFRPZeKlBvANWW7D1zO9eT5gD/XJrJNu+fnYCI7FJ0oA4uuU2hXnnt/LdUcXq1u
 bDuJgDtVCxKjpWJDpbtfIdb33zRK/ieakn/onW+uF75iV8LEHz0w6Yv/rLFLQ74tPI0o
 sS0g==
X-Gm-Message-State: AOJu0YyFLLoUd0E5EfExnN+J6XvBj7RAz+pnBypwXCYbzQLbGOS6GB5i
 stX9mjAXhAA6ZqkJGB0iRAm9WTu/UuX0ysxVryfle158g2fDkQi6CAyW+PaGep4=
X-Gm-Gg: ASbGnctXzON/VdXTKC+nuxLqKCLEFwGX5Dek1shfrXko1FOlOyKANzPrGx7zoTXqYQA
 yYhcm4IGzFNXAGGNkA7DYAjWoRhhuI/sQrX6PGfWHHGPYsbXiVWryIAA2S9JBpS5fJHmn5w9MQv
 Z300Gq1nqpzn7tUAsCwcVmikrdNIINq4LgxntlHTbuC9GHjXr/fz/RQ+EroMEYQKjpa/OKJ8QyO
 25+W35keoH+hqL81YXVVWU7l0oHkJPAOi9sHAoYfTKiMKpCH23eD64xRQ0Gsh4RywdRt/OAkdyI
 7snf1xTDqB7oQIhYGNfIdv4bwlL0x/A6sWwKHt0WnoyOQjtbBuQ4QyQXLPPA
X-Google-Smtp-Source: AGHT+IGmNvGQqSCk8kKK1pEFe/I4HvHCh4+Kte9nrnuMN31GDrb0CZtujtwvMGbmjW4JsPisBAQoiw==
X-Received: by 2002:a17:906:ba86:b0:ad1:825f:e326 with SMTP id
 a640c23a62f3a-ad1e8e2b533mr262364166b.52.1746619152940; 
 Wed, 07 May 2025 04:59:12 -0700 (PDT)
Received: from [192.168.55.72] ([176.171.151.116])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891a311bsm904468566b.54.2025.05.07.04.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 04:59:12 -0700 (PDT)
Message-ID: <89e7e6e9-2cb5-42bb-8155-ce891db2caba@linaro.org>
Date: Wed, 7 May 2025 13:59:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/19] hw/mips/loongson3_virt: Prefer using
 fw_cfg_init_mem()
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Amit Shah <amit@kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20250502185652.67370-1-philmd@linaro.org>
 <20250502185652.67370-4-philmd@linaro.org> <aBr+OFe2KKKYnGEb@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aBr+OFe2KKKYnGEb@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 7/5/25 08:31, Zhao Liu wrote:
> On Fri, May 02, 2025 at 08:56:35PM +0200, Philippe Mathieu-Daudé wrote:
>> Date: Fri,  2 May 2025 20:56:35 +0200
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: [PATCH v3 03/19] hw/mips/loongson3_virt: Prefer using
>>   fw_cfg_init_mem()
>> X-Mailer: git-send-email 2.47.1
>>
>> fw_cfg_init_mem_wide() is prefered to initialize fw_cfg
>> with DMA support. Without DMA, use fw_cfg_init_mem().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/mips/loongson3_virt.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
>> index de6fbcc0cb4..41733988729 100644
>> --- a/hw/mips/loongson3_virt.c
>> +++ b/hw/mips/loongson3_virt.c
>> @@ -286,7 +286,7 @@ static void fw_conf_init(void)
>>       FWCfgState *fw_cfg;
>>       hwaddr cfg_addr = virt_memmap[VIRT_FW_CFG].base;
>>   
>> -    fw_cfg = fw_cfg_init_mem_wide(cfg_addr, cfg_addr + 8, 8, 0, NULL);
>> +    fw_cfg = fw_cfg_init_mem(cfg_addr, cfg_addr + 8, 8);
> 
> EMM, I'm not sure if I'm basing on the wrong code base... in which patch
> does fw_cfg_init_mem() accept the third argument?

Doh, I missed that, thanks :)



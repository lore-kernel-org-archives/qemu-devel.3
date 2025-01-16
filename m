Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1983BC02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 18:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYUOq-0007xJ-9G; Thu, 16 Jan 2025 13:15:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tYUOk-0007wv-Pi
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 13:15:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tYUOh-0000Vh-2n
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 13:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737051313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FGBEudZxS/EtxR82kGm4Kmqe2HD40hbdFZuaL36wmwg=;
 b=JPGvGICF3mqtQY2RU2+wwIKkJxFtY7m3aFKmkVkl4wRq7jRUnmrPAw1RCUrVjv78bEeCQ2
 gp/8q3auGgnQ08gPyhWxcYfnXW/neLMPJQm6AClQN/JEMagFY4PIWtpOr7Nk8gFcwQIInb
 4aqM//BNjXuBglieGp5lDERwEE8D52A=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-VT-U2AZtPtKVcox9vCKuaA-1; Thu, 16 Jan 2025 13:15:12 -0500
X-MC-Unique: VT-U2AZtPtKVcox9vCKuaA-1
X-Mimecast-MFC-AGG-ID: VT-U2AZtPtKVcox9vCKuaA
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6e23e2b8fso112314485a.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 10:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737051311; x=1737656111;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FGBEudZxS/EtxR82kGm4Kmqe2HD40hbdFZuaL36wmwg=;
 b=sMQ6hxJf1AjRCM+IXM2evxnN4YFapRWvgbnztvhOvyp9dNKIMHXriBB6xNr5tNer4x
 bjW4t+kpWtQwDudUI9MbmuTgmc8jeI+BLFgAShvRWrFPcxClOMTfg+2+/GfYlu70SfyO
 CtEkkrEZZTjIrlHSWCERLWpyrCvXB+1OtrzREsiTsIEeE2HD2tWabBXIvpztA6s3MxCR
 keHXkcTcZKU2CBcqlfmDmOiaNd/EEe+SvpMuog8S/BHJwoZVxOL0csnoCGq4bUJeGZ+L
 OQg6gpY8bDb9IMKXVltSKmQNpz+TZutLs3cBrkDhw4hWTgaXur1Obs0B3Q7isV4w23yK
 zW+A==
X-Gm-Message-State: AOJu0YxdTJjSX4e+TwbjI65oy1gSGoKh3rAgt5UJ168gCuvkxfJnjCoJ
 srTcFkKgXbry4GU42I9lnZNuM1o8D0+YYZaCayNs53ak6zx7XpiCLblwRaMIqk0XqUmXU1N8Yjo
 MwfsiPIHsthTcKGcqz0+Df/x5MFOPMnYw0NbQlaYTQa8Kz87NhY6+
X-Gm-Gg: ASbGncs4w0pwoinmxQfMIMJWSqnE4xoDhd9+jT7m2SISqZX8JzmpV6x0ynCzzW/ii7Y
 t66ThPO0ZXvDenryJB93cL3D5J7iLq7B9enGaqqIuQwlunk1T3+ePuF1TEDhCPSlDi0T2RLmZCi
 0P9xOxHY1XCNj0dtFuu6Uo/j2fxNBfyrHfceEfuNHxcTYBVoAQzSmD2+DXHQ3JF/Rl3SHqUFp26
 acapgbhaqJBV0vaz2qOIZb75mW6csaMKEvvYWISVT6PK6G0/emviVWfmCdMnpLwsoL9BK9JH50R
 mve1ugtlaKnex4e/dU4=
X-Received: by 2002:a05:620a:6009:b0:7b6:dc74:82ac with SMTP id
 af79cd13be357-7bcd96e8c00mr5776601485a.1.1737051311317; 
 Thu, 16 Jan 2025 10:15:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBtCR+zdTK1ajR5TQKR0CaqUbeIqiFaMK2naWEOZxOf/4tmp3PbuwqblWW/bRETW5wZwOZww==
X-Received: by 2002:a05:620a:6009:b0:7b6:dc74:82ac with SMTP id
 af79cd13be357-7bcd96e8c00mr5776598185a.1.1737051311013; 
 Thu, 16 Jan 2025 10:15:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afcd387fsm2332056d6.79.2025.01.16.10.15.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 10:15:10 -0800 (PST)
Message-ID: <f4539bec-d74b-4bf8-b874-dd8437126978@redhat.com>
Date: Thu, 16 Jan 2025 19:15:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: Support P2P access in confidential VM
To: Alex Williamson <alex.williamson@redhat.com>,
 Wencheng Yang <east.moutain.yang@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, mst@redhat.com, sgarzare@redhat.com
References: <20250116095355.41909-1-east.moutain.yang@gmail.com>
 <20250116124740.51cf4182.alex.williamson@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250116124740.51cf4182.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
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

>> --- a/linux-headers/linux/vfio.h
>> +++ b/linux-headers/linux/vfio.h
>> @@ -1560,6 +1560,7 @@ struct vfio_iommu_type1_dma_map {
>>   #define VFIO_DMA_MAP_FLAG_READ (1 << 0)		/* readable from device */
>>   #define VFIO_DMA_MAP_FLAG_WRITE (1 << 1)	/* writable from device */
>>   #define VFIO_DMA_MAP_FLAG_VADDR (1 << 2)
>> +#define VFIO_DMA_MAP_FLAG_MMIO (1 << 3)
> 
> Where's the kernel patch that implements the MMIO map flag.  That needs
> to come first.

Yes. This patch should also be divided in 4 parts :

   - kernel header changes with links to the threads modifying the kernel.
   - common part,
   - vpda part,
   - and vfio,


Thanks,

C.



> I also don't understand why we're creating multiple read-only and
> ramdev flags to distill back into vfio mapping flags.  Thanks,
> 



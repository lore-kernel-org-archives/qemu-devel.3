Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28846C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 11:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtmnc-00071I-2J; Mon, 08 Apr 2024 07:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtmnR-0006yP-Ix
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 07:04:17 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtmnP-0001W2-Nj
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 07:04:17 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a51969e780eso508835566b.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 04:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712574254; x=1713179054; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s6AHTQKYPihinDiPWQIe4PgmMGxin9ba7XefhChk05U=;
 b=T4yPrPbwoCuJPX13fvL3nzQbUMaKkFegXwTgcPWIhe4CpKxD7vl/mzTgNm72fTJwRO
 iAxO+i1v2GeOy46GLWoJtiWf2C35tHBMHBh6yTs8bQ/0XHXx8UTtt/f7c5f9IiApqXOm
 RhqZpeyaHB/AzWHiQnaQ0CtCRgo5nV3ISEBBXaDaMspZ+bCAz6Wf2xLY/kM0jobIf3Pw
 MTetGk/lA2TdCSKsRMb1BELa4NgnxyIsf30m4ddcqIy1prCGfWxb52TxS5EgRaPutHqR
 GPxYZQceZkpxrYj3HTyJg3nxF1iDxytECE1Ux2jYs7n7bVRR6GlUOGciCNJgeUFU+OIi
 JF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712574254; x=1713179054;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s6AHTQKYPihinDiPWQIe4PgmMGxin9ba7XefhChk05U=;
 b=JgbTlPPuOkZcLqXfy3ku+KLsw7JAWQSLrpQdKQdXuw0swOwMzZw/k1JfrQ6dKjGVMh
 DvW4HyZLhZSisfbSNqgcsNrVF7lf1jInBbEl5sSNG+oZzpghzXsUtu34zW10mPovvh1i
 uwgcs7oq0TIem/Z8dDZURA8fFKdLARXNFx7dRsYXVFYtLiAJj/ojLvA+iH6XmpRHCH+Z
 8huJXYn5dsylt59+dfjUtDGSjBv8tMkO9bWw5Ar7LkRgFP05tQuBz+1KF6P1PGBGrlRb
 VPxjsygQ5x8N88TNq9BZLtHjPVoMmiyN1iGmXYGukK6isZbOEtn7z7rNPB3UkJ9fYkC4
 O8tQ==
X-Gm-Message-State: AOJu0YzVWlqnC6ynhbxBeFoKok2UYBBpB6xiCb+6vYEvdikLRzN6DkQx
 UNsjRjnTos3zTO4Lv1bAr/dkgtJwVcfG+Zj9xQrPjehuvzuYol8D/oS6FD3H8kY=
X-Google-Smtp-Source: AGHT+IFnMY6pUOaQ2Ot7oC4ACQbK9cUmXlxUSz/8G/8hVJCpxpXbmC6d0fZrWTvkMYAwq4+HDAez8A==
X-Received: by 2002:a17:907:944e:b0:a51:e05f:2455 with SMTP id
 dl14-20020a170907944e00b00a51e05f2455mr726107ejc.48.1712574254053; 
 Mon, 08 Apr 2024 04:04:14 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 w19-20020a1709061f1300b00a4e03823107sm4318392ejj.210.2024.04.08.04.04.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 04:04:13 -0700 (PDT)
Message-ID: <1daad71b-d1dd-44bf-ba6c-668bc80b99fd@linaro.org>
Date: Mon, 8 Apr 2024 13:04:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 3/4] hw/char/virtio-serial-bus: Protect from DMA
 re-entrancy bugs
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Amit Shah <amit@kernel.org>, Alexander Bulekov <alxndr@bu.edu>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
References: <20240404191339.5688-1-philmd@linaro.org>
 <20240404191339.5688-4-philmd@linaro.org>
 <942c06fd-fac0-49da-9421-92dc3a357cb3@linaro.org>
 <20240408060802-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240408060802-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 8/4/24 12:08, Michael S. Tsirkin wrote:
> On Mon, Apr 08, 2024 at 09:14:39AM +0200, Philippe Mathieu-Daudé wrote:
>> On 4/4/24 21:13, Philippe Mathieu-Daudé wrote:
>>> Replace qemu_bh_new_guarded() by virtio_bh_new_guarded()
>>> so the bus and device use the same guard. Otherwise the
>>> DMA-reentrancy protection can be bypassed.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Suggested-by: Alexander Bulekov <alxndr@bu.edu>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>    hw/char/virtio-serial-bus.c | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
>>> index 016aba6374..cd0e3a11f7 100644
>>> --- a/hw/char/virtio-serial-bus.c
>>> +++ b/hw/char/virtio-serial-bus.c
>>> @@ -985,8 +985,7 @@ static void virtser_port_device_realize(DeviceState *dev, Error **errp)
>>>            return;
>>>        }
>>> -    port->bh = qemu_bh_new_guarded(flush_queued_data_bh, port,
>>> -                                   &dev->mem_reentrancy_guard);
>>> +    port->bh = virtio_bh_new_guarded(vdev, flush_queued_data_bh, port);
>>
>> Missing:
>> -- >8 --
>> -    port->bh = virtio_bh_new_guarded(vdev, flush_queued_data_bh, port);
>> +    port->bh = virtio_bh_new_guarded(VIRTIO_DEVICE(dev),
>> +                                     flush_queued_data_bh, port);
>> ---
> 
> I don't get it. vdev is already the correct type. Why do you need
> VIRTIO_DEVICE here?

This function doesn't declare vdev.

> 
>>>        port->elem = NULL;
>>>    }
> 



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0194EC0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 12:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiYH6-00062L-OO; Thu, 13 Feb 2025 07:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiYH2-0005gn-Iq
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:24:57 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiYH0-0002mA-Up
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:24:56 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ab7f860a9c6so179729566b.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 04:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739449493; x=1740054293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ldbrOXDGLA2zzNOu8ivbvSm+nWxIbVBN+X/37gvTz6E=;
 b=eQT4EAITQ76KWsUrbeDsbXRJtv6+k5S52zYrl5SgOf1cHVAaA0M9UDR0UFiRQP6CLO
 KbQkHfli+3FpQpxaRXnuRfD4UZ9AtZabLLX+P3+WxZFyYmyvDv3FpUSxyyJ4C7ARTA0+
 EcEN5ZphhJwKSNapxexlfpB9O1fvEdJCiZmVonOAsv3Pdd13rRaxmmPVBy5V4ht8ZtUO
 SVZt6drIzeRbazFaKV80N4sSt4TDYyl+YriKq3eWXVNutSKa7MqtubGd2OluzxuOstFr
 +9WNX4TTBkuEKUIbvGzARMIbc2rT3+VSQg/XqO408lzufnuzdJLHmLqDSMSpRmSQA+i7
 /a0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739449493; x=1740054293;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ldbrOXDGLA2zzNOu8ivbvSm+nWxIbVBN+X/37gvTz6E=;
 b=UZSsw/DNFHp/DL7r+s1J567+jNUioo0CEp5ddq5sDuqE0foqGV/miubJD9bvQGR0FL
 tYYyidXaERE9JLpP0uSAEAWJ22GmaPth5i6YDoSscOHmjbTCQ2h4s1te7CUv0hzqkVMN
 xBhSFeybmow3jBIdnLU9TzYez8x5oQv1h0UbTNZKOgKidkxhSpR9MnZSe+hUwFpgS0RJ
 28U5MVsNnPiIf5UnYTt7qqR5Oe+DztTxQhHvU4GpCPWr5pTJnRLKVw5okOgmov6WK4av
 G7asj1trOWyUttYxo/jS/sb2XxtXocmCUPj5tljV301KAmmt9R7h3lePBR6U+W9tBv4M
 8AvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/UN/o/f6S72cs1UL5RjlP0yv1PtMXMaaVWz5uB7RaMhLXpfMyki70e5wOdV1+e8/NQsI1vpHpN+su@nongnu.org
X-Gm-Message-State: AOJu0Yx1KoeUyx517KZu4+FlI2+i/6NbR/WfSIPgWVb0N5y4THz2v6X7
 Cqk0hlM3wV4Kg6Sm9joIUjF+G9Cu7M6eKxqWiR1JL6waEq4Q5RIy66FWsSGtwww=
X-Gm-Gg: ASbGncu11KZHmS3yV51s+PoX4+bIkRQkTDLsxvGe/r15eQFWr1e44VdX8Hdh06tUUts
 z3vKDbk5YsPfuqi89Ag5cKuh+cwKypDAMXFd3otQntvuBFUaH2buC5h4yzPJFt4z7yksncCvZOR
 6KQzlimF5vNLroQHS2VZoOMVDSYG1CTpjW5oKNAg8GaJymVQ6vkL8HccIZGfUlZdQuB6D0BhJZu
 v43LtYo6hQRwR/3j+K2xyASMrbCVaCPzNioj+CM7woeF3+/Nd2aIp1x7W0kx2cB4Agn1+mwBLw1
 XxoLO/KTyRdBuFYLyAUqKKQdIeZu1RzzEnPrfRIHasN7dDts7Vsj
X-Google-Smtp-Source: AGHT+IFoixFi+Lq8Oq23nejDyXHKnCOHRZ7wYjzoij/vnWdVrzS9Y7ztRQfpPyADyvaaxw+vqACThA==
X-Received: by 2002:a17:907:9495:b0:ab7:9a7a:d37a with SMTP id
 a640c23a62f3a-ab7f34a0a58mr734167966b.43.1739449493237; 
 Thu, 13 Feb 2025 04:24:53 -0800 (PST)
Received: from [10.223.46.213] (6.170.88.92.rev.sfr.net. [92.88.170.6])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba533be1e7sm122521666b.171.2025.02.13.04.24.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 04:24:52 -0800 (PST)
Message-ID: <ca2813d4-c1f3-4653-b854-0397fe4bf26d@linaro.org>
Date: Thu, 13 Feb 2025 13:24:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vdpa: Fix endian bugs in shadow virtqueue
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Konstantin Shkolnyy <kshk@linux.ibm.com>, mst@redhat.com,
 sgarzare@redhat.com, mjrosato@linux.ibm.com, qemu-devel@nongnu.org
References: <20250212164923.1971538-1-kshk@linux.ibm.com>
 <7a07090c-78d4-4d5a-9d8e-56fa41db06cc@linaro.org>
 <CAJaqyWeOY9+UwyjokOJmFjabJpGvo=zDhyZPzYh2e_gEmzHpPg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJaqyWeOY9+UwyjokOJmFjabJpGvo=zDhyZPzYh2e_gEmzHpPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 13/2/25 07:43, Eugenio Perez Martin wrote:
> On Wed, Feb 12, 2025 at 7:11 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> On 12/2/25 17:49, Konstantin Shkolnyy wrote:
>>> VDPA didn't work on a big-endian machine due to missing/incorrect
>>> CPU<->LE data format conversions.
>>>
>>> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>>> ---
>>> Changes in v2: Change desc_next[] from LE format to "CPU".
>>>
>>>    hw/virtio/vhost-shadow-virtqueue.c | 18 ++++++++++--------
>>>    1 file changed, 10 insertions(+), 8 deletions(-)
>>
>>
>>> @@ -228,10 +228,12 @@ static void vhost_svq_kick(VhostShadowVirtqueue *svq)
>>>        smp_mb();
>>>
>>>        if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
>>> -        uint16_t avail_event = *(uint16_t *)(&svq->vring.used->ring[svq->vring.num]);
>>> +        uint16_t avail_event = le16_to_cpu(
>>> +                *(uint16_t *)(&svq->vring.used->ring[svq->vring.num]));
>>
>> Nitpicking, sometimes using the ld/st API is cleaner (here lduw_le_p).
>>
> 
> I'm not sure if it is right in SVQ, as it is not accessing guest
> memory but QEMU memory that has been mapped to a device. But if you
> think it is still a valid use case for ld* and st* family I'd be
> totally ok with that usage.

No need to change, better use a consistent API over the file.

Regards,

Phil.


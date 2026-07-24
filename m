Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79B7C531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnHmA-0005hu-Hh; Fri, 24 Jul 2026 11:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wnHm9-0005fJ-1W
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wnHm7-0008VG-6j
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784906722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nZLsHEnq5zIsiLNX9NFStEFLnzFOXt5WKQii4g+GlPo=;
 b=hphYwZq6lrgcyREy63P/Ir3fHGoeapS0Fetfv7QKcaf8NoxTRGx9ef0ESeuLoeWnq5S35s
 ho+2eNZmX4DyH9pheveXstiDqnlWb/gG0VzWGue8qEeycfA3sRk9xSIWa7XNP9P801amVN
 yMJSjuibHYFurvLqBxm45mcexpFci6c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-9pRk-9BvMC6lMtU9EzYt7w-1; Fri, 24 Jul 2026 11:25:20 -0400
X-MC-Unique: 9pRk-9BvMC6lMtU9EzYt7w-1
X-Mimecast-MFC-AGG-ID: 9pRk-9BvMC6lMtU9EzYt7w_1784906720
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49561facb1dso5254605e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 08:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784906719; x=1785511519; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nZLsHEnq5zIsiLNX9NFStEFLnzFOXt5WKQii4g+GlPo=;
 b=B4Ah66P2S75/w0/qv1Fl2a1Dxw+2xPhLAxbZcWzKm/3PhRgxZTEUJUIEuuQFMmaVts
 lSFdfxVgUlLUw/XRkNcTtQWRMXoH1SYUBlMYsyqD9IWIOf1eGIJ9vFL0a7FGjPPGLrX5
 Z66oEBzFdqTyrhuHrck105Ji2nLAkjsQ8TU6bgNsXlzkH9EqMMg/uw5276cMVUdDa5wv
 84Y2vHlk45l1I8WAGNnRkJaMJcXExKKEfunsbUU7GWg9L+cE12H46DvvlraXl30IdbfH
 YR1qpBV+HiT/D+tVzfnQ1ORtwAKrLJS+97z3ydAwLl8Bury34jXNdMAj+znuQD3jNInN
 h/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784906719; x=1785511519;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nZLsHEnq5zIsiLNX9NFStEFLnzFOXt5WKQii4g+GlPo=;
 b=ZilUxngFjlywEoPzWEbFAuU3BV+YwaQsTGX/ryHpIA12s+RK7Fmv62mjquEDF2hQCV
 DWVFK0PLzyLGydyN9FRt1NKmA4jlR8nHN0hBfIJ25mws64V3p7YHVV0/vaH1+kb3iTIb
 vs6SsRNCmFJfVYdfnsgRxj7Ca7OVjpg0dSCtVlJWmXoharDXPpEi5IiuhBs/MvYIkMuY
 iSBRIV0ZpeJEjov1qhPCIMGy89HWu2Xwu0vYM9Iwmos/iI00hj1ZOOCP4tCCna5xIp9h
 sndi2OolYPJrCGUtBrznBPOZtRtVc0ppKdiXy2EpzH/vLNCt73aRxLk4ECGA+PPpQqpu
 h/lA==
X-Gm-Message-State: AOJu0Yynt7Ee3D6T4nlm73guSqI5ihwYCk3QN0/Ygf1bUBEGCRM+kMo+
 I0BjNaMXYJu7C3Z5RVzYxFBVoPy6IGF6vkjWjKcrQKZ7PfvOLgjNtQ4pPm4g+GjhoVHgEYE74La
 QAbqKmo0oT5juMuNv0e3fkflfXBWP0Krk4CJ08DJl9jyh1RBBIbbR1Dm6DBgn6ynd
X-Gm-Gg: AR+sD122CTc/yXdiTsH+fgkbCnML5SzvuPD3nA9q8JzVSurjwlN6jwHHpWhcVqlI82D
 AgOSlLrVbUK5xYTR+qNEKodoZnoh+OEmBO2CtUuCnfR/XrbAgjkS20XR5Z43ikVy5kkm671DOZA
 65hSVCJDnJqedMk/YD7TrJVBnkgKtYCsHWB6ozJJsZ0rBiqL3HhTjVMz3CMiOmYOQ9aonsgLpuj
 iyHW+RC4f+G1YdN7G18I2I/LubqLNNd/ud2EdRgZzMrrvx1WtNb4UQbgYJzyCOP3IiwiwUW2T61
 Fr5vrKtR+a3S2Z0V5cNoh/BcB5JLBDVWBRmyDrMJkbol1D8O3iFh4pnlnyhZa0DcnTIsUYubKTB
 CJwaK79UvnvtNrhBYKQUTn/7QT6b/518/Mx+OGwEBt4qV
X-Received: by 2002:a05:600c:55d0:b0:493:b811:e549 with SMTP id
 5b1f17b1804b1-49573cff4d8mr68527445e9.29.1784906719432; 
 Fri, 24 Jul 2026 08:25:19 -0700 (PDT)
X-Received: by 2002:a05:600c:55d0:b0:493:b811:e549 with SMTP id
 5b1f17b1804b1-49573cff4d8mr68527055e9.29.1784906718929; 
 Fri, 24 Jul 2026 08:25:18 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:670b:f6b9:3441:1a72?
 ([2a01:cb19:8426:ae00:670b:f6b9:3441:1a72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5c4sm24260780f8f.8.2026.07.24.08.25.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 08:25:18 -0700 (PDT)
Message-ID: <829cb692-f33c-4283-a7f4-8206ece9a560@redhat.com>
Date: Fri, 24 Jul 2026 17:25:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Fix ROM load failure handling in vfio_rom_read()
To: Alex Williamson <alex@shazbot.org>
Cc: qemu-devel@nongnu.org, mcasquer@redhat.com
References: <20260724092413.348354-1-clg@redhat.com>
 <20260724081750.65449051@shazbot.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260724081750.65449051@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/24/26 16:17, Alex Williamson wrote:
> On Fri, 24 Jul 2026 11:24:13 +0200
> Cédric Le Goater <clg@redhat.com> wrote:
> 
>> When vfio_pci_load_rom() fails, vdev->rom is NULL but the memcpy
>> still computes a source pointer from it, which is undefined behavior.
>> Guard the access and return a 0xff pattern instead, which is what
>> hardware returns for an absent ROM.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/vfio/pci.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index a3147d28665abd29fd804bd08bdffc3c7440033c..16d4f70ea58c9e5b174dd57950df55dc2ab91f6f 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -1176,8 +1176,13 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
>>           }
>>       }
>>   
>> -    memcpy(&val, vdev->rom + addr,
>> -           (addr < vdev->rom_size) ? MIN(size, vdev->rom_size - addr) : 0);
>> +    /* If ROM loading failed, return 0xff pattern */
>> +    if (vdev->rom_read_failed) {
>> +        memset(&val, 0xff, sizeof(val));
>> +    } else {
>> +        memcpy(&val, vdev->rom + addr,
>> +               (addr < vdev->rom_size) ? MIN(size, vdev->rom_size - addr) : 0);
>> +    }
>>   
>>       switch (size) {
>>       case 1:
> 
> I thought we guaranteed that when (vdev->rom == NULL) that
> (vdev->rom_size == 0), thus we end up with a harmless zero-sized memcpy
> here.  Also val is pre-initialized to ~0 so the memset() is redundant.
> 
> Does this actually change any behavior or is it only meant to sanitize
> the undefined (NULL + addr) pointer that's never dereferenced?  If the
> latter, I'd drop the memset and note it explicitly as a sanitization,
> not a fix.  Thanks,
Right. the memcpy is a no-op because the size is 0 and val stays ~0.
I had that patch in my tree for a while, but Mario's recent fixes made
it useless. Let's drop it.

Thanks,

C.



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C163CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 13:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE69t-0006iJ-Ai; Wed, 29 Oct 2025 09:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1vE69p-0006i7-Sn
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:24:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1vE69g-0008Bm-5C
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761744233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AogRYBHoO4A57v3hzc3wexA/dhZmmHaY+zW6HuELAzE=;
 b=WFKHUBe2oESnCwF88btAqakakoXHosV4qKGHSYjRTcJDps6jjrt+tRrmrlzKCOIoykJvbG
 4ZF5B5j4L+t8c8/m2UTvvIFjLx6h/TC2cj06WVo5RWgacLj+DnyJy/SlWXixI8+rezMt/n
 TTCR1OL1KC2QvFAXX005nav6BDo1DtE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-tNRDnEKMPXqPWS8aeIX2hA-1; Wed, 29 Oct 2025 09:23:51 -0400
X-MC-Unique: tNRDnEKMPXqPWS8aeIX2hA-1
X-Mimecast-MFC-AGG-ID: tNRDnEKMPXqPWS8aeIX2hA_1761744230
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-428567f67c5so4234568f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 06:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761744230; x=1762349030;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AogRYBHoO4A57v3hzc3wexA/dhZmmHaY+zW6HuELAzE=;
 b=BF4MbKJurmtJH/QRe0doRAhTEsT1K49VgEpZuyE13cg/yCDncztzwdUQfMFwQI7W/C
 DRxlpQc64o7XK/OmS10oNjJ1L47oyBTTdiM8aQTYnNS1/ySJhNXfvaSzlhdFVHm7JIcT
 bW0/+zEZQ/iEqCe14Sh9kQcQX0AqOnh2uZ+kWu3sCuOoU4TfCaTwHbsQdZJo3z8KVXzK
 8uX3QQk2xBgVisUtQ/8+aX3+cDOO0nTHYqUl7z6GDiS2HPIKjvBFF4l2vLI5SopgpZGj
 puuTnH6CSOTbEJe5vdJxxS5ANWua0nfr64+jBta/HxcNYqZOUQQt+KvZ7j0WOvrLQCcz
 KnzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI/B8N/ocsVqIwIW6bkUx4cMIaVHvUJh1CEq3xE3n50uEkw1teu+iJ+PeQGreL6GfRxPc/6ZFsN5t9@nongnu.org
X-Gm-Message-State: AOJu0YzUOdpP0bho0W04X0sVKldUXLgBdk+MfT5iW/aIOn6YM+0EAoZS
 O5zwOVZS3iFKuC3Ut6hxT+iZm9vxIUGbC9mgdrFehMi0SyA8v7FOAYvBBefbbwYmTQC8g/uL8O8
 0pAUPQMKTffuG7iErO0Wk6GsvpO4NXRL5FyUtTfdEhRHsoF/BBdykYc+D
X-Gm-Gg: ASbGncuCs3vMatWeycw5bvkU1NvFzyvnoH1LiGiFpewSx3t4eEeKB8w5qBPC7czzdQS
 rOJB5KhfjAlDuQh1rmzF42iNy3xFuRvcGViFz7W+vKNkqE5N3D3/Fru3IpTbIRzrblfN1w2IIrv
 znl9eTqEG/p3DY8iU473/V1wuSHZYrVCpMplMS3Oj/GmVYu7HQRl70YRszOP2gxfFtPQn+IpA5v
 VfC296wLla5Xnhp2rVHr4W1R58N9c/g7veClsIb0w7ylh9L70mHqw3OHIyZoq8rof6f4LiQTMCg
 PfKm/f4YAam17gE5Rn/t9fJZJ6whjksigRhuiyKFXhrTT8gdPLYtIILsfhAOuTRPXIyM3l7PA0F
 mlZVCCp1TBLrysclYWo4/XQ==
X-Received: by 2002:a05:6000:43c5:20b0:429:b2ad:f31e with SMTP id
 ffacd0b85a97d-429b2adf486mr1103767f8f.35.1761744230304; 
 Wed, 29 Oct 2025 06:23:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs3GHPTxhTJjem3aESiDF4BQX1bREhvCngFdtuNJwqQU7ImFOFBiOT/tU0aym0SPUb+UjcwQ==
X-Received: by 2002:a05:6000:43c5:20b0:429:b2ad:f31e with SMTP id
 ffacd0b85a97d-429b2adf486mr1103748f8f.35.1761744229881; 
 Wed, 29 Oct 2025 06:23:49 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7badsm25787894f8f.7.2025.10.29.06.23.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 06:23:49 -0700 (PDT)
Message-ID: <dede2c38-7b86-4df7-8d26-e4dceb20e653@redhat.com>
Date: Wed, 29 Oct 2025 14:23:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/25] hw/s390x: Use memory_region_get_address()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-17-philmd@linaro.org>
 <f99989f4-88bd-4167-b9e3-fe4a249a2c99@redhat.com>
 <99870dc8-830c-4ce9-a25a-5aa7c47e074f@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <99870dc8-830c-4ce9-a25a-5aa7c47e074f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 29.10.25 14:18, Philippe Mathieu-Daudé wrote:
> On 29/10/25 09:28, David Hildenbrand wrote:
>>
>>> @@ -510,11 +514,12 @@ static MemTxResult
>>> zpci_write_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
>>>                                      uint64_t offset, uint64_t data,
>>> uint8_t len)
>>>    {
>>>        MemoryRegion *mr;
>>> +    hwaddr subregion_base_addr;
>>>        mr = pbdev->pdev->io_regions[pcias].memory;
>>>        mr = s390_get_subregion(mr, offset, len);
>>> -    offset -= mr->addr;
>>> -    return memory_region_dispatch_write(mr, offset, data,
>>> +    subregion_base_addr = memory_region_get_address(mr);
>>
>> Any partixular reason for the temp variable?
> 
> To fit the 72-80 chars per line limit. Since various people
> asked the same, I'll just replace in place, ignoring the
> checkpatch.pl warnings.

I was wondering about a simple

	offset -= memory_region_get_address(mr);

by minimizing changes to surrounding code.

Anyhow, I was just wondering about that.

-- 
Cheers

David / dhildenb



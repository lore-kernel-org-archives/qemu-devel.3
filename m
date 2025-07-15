Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAEBC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 08:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbTs-0007Td-C4; Tue, 15 Jul 2025 04:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubbTY-0007E1-QY
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:57:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubbTW-0000pL-Ge
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752569841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tpDCRdDUCzxc6AdghgUVNXaGz5CPdFgq95lQvt4giY0=;
 b=MPPwx19BnJxmifblkp0A+FxcIL9FFoJp5U+YYuKrwW6cHCCFs8U2Lv5Cugl2iRyNfdwgGx
 hkWPJCEnHVCrY00TooZBy4VdLUel8suVVyepZd+W5m3Sw4fYodg9XW3sEDrSLQfIKCMOTL
 ZzWcIAAiUqnlprTk+mF9qU26/nfuxpE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-59D1lWloNMSXP9uZfJYYdw-1; Tue, 15 Jul 2025 04:57:18 -0400
X-MC-Unique: 59D1lWloNMSXP9uZfJYYdw-1
X-Mimecast-MFC-AGG-ID: 59D1lWloNMSXP9uZfJYYdw_1752569837
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f8192e2cso2932404f8f.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 01:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752569837; x=1753174637;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tpDCRdDUCzxc6AdghgUVNXaGz5CPdFgq95lQvt4giY0=;
 b=oi60BE5liTOa9zsurLdUkX4/WeOCUwtQk/xR/GtsHFQ6YTHxnB+SjeFJ4H+mJtPcRJ
 or9qS8Ti8Tv+M6JOYQhn77WfifzpXuixPAUvqVcpOh4L+ljkWFwwtnKae45kO+d7DZmi
 V+Vbzl8hg8zOmK6q624fOlXy/ybU6xFosNnP0GmKntJUG+5EGklKKr66iFs6IxmDnVG4
 fOCPtO/nDO1CTfy9l//X2AGPUovN59HWMyB76K+MchjZgVYCtH0xutjSY09E/R+G/MKP
 ZqHWd3J9JnUbehEPgcrFnYnOzaQ2VQ78DxbgEP96ygwoDIRSy4x5sDrrmVI7iliXs0RW
 u+Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDTHtzHU59MSMcE0dDqj9NEm0/5Ux2/ABPYnRscgi6Cn7CQqdtjGjX7+mLq5ZLEuZDkRkjbFeKT7p8@nongnu.org
X-Gm-Message-State: AOJu0Yx/fEyzDV0ynncMjVgzsZrWUwxO2Tvu10GydXee5WcABUxs1zvp
 xH3IUpku7Q1J5umBiNezX/Rkev4mFl1i0QaXR2p5IdfPVbVgX9FqYHWnHULhJ79QU+ywFWiehSe
 FMgNQ3ppyWrgdqTQEKXNGJpx5HSLF5jIGxA+hUAnZoF3dC8VcdgjBpevg
X-Gm-Gg: ASbGncuWBO7Ee56c3p5bP7rq262GsziIHJGuemhXZ4ysaWH/IbV03fcc4lgZIEfgeqt
 QMr+9L1i6hT86wMy59HQPmH4m1QnfHvDD9KrsKAVmRGWXkZqy4vlhZtZLkfZeVsZq743rL32qEg
 QE9suHcPr8Q5oX/wdSde9vPh11BJBe8PsVDqa1833xbiHkRP4hKMlw5gfRJfDU7wHAbPHGPNyuB
 TXqJUf2lhLj3ujhAngyN1RYsa6FjnvMb1i6Fe+3ZbPXZDlERPTBvsWt8io8ZXOCWM6YogOaVsJf
 pfFujFoqc/v3lXySdRN1Vop8hXv7cX0kH19FhftEg73TMmeRWZZ0BH88w20jYMFWWi+aScCVLw8
 =
X-Received: by 2002:a05:6000:3c1:b0:3a5:2cb5:63f8 with SMTP id
 ffacd0b85a97d-3b5f2dfd929mr10925214f8f.29.1752569836711; 
 Tue, 15 Jul 2025 01:57:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG8blftA21e29tuGweBe38fO2Oqftk3JrnZMsJxqrpNqvBVfyKvo/lDafvVgAlYKBJPucWwQ==
X-Received: by 2002:a05:6000:3c1:b0:3a5:2cb5:63f8 with SMTP id
 ffacd0b85a97d-3b5f2dfd929mr10925196f8f.29.1752569836251; 
 Tue, 15 Jul 2025 01:57:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:266c:b13b:afd7:40fd?
 ([2a01:e0a:165:d60:266c:b13b:afd7:40fd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-456278a4460sm9975265e9.1.2025.07.15.01.57.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 01:57:15 -0700 (PDT)
Message-ID: <7339beb6-141d-4f81-b87d-87e7c32ec957@redhat.com>
Date: Tue, 15 Jul 2025 10:57:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] vfio/migration: Max in-flight VFIO device state
 buffer count limit
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Avihai Horon <avihaih@nvidia.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <cover.1750787338.git.maciej.szmigiero@oracle.com>
 <0e88a253e06647f6c01bdeba45848501b3631bd3.1750787338.git.maciej.szmigiero@oracle.com>
 <4fbc3288-edb4-4942-b3dc-df7beb1e3f24@nvidia.com>
 <cb4049d8-b6e4-46ab-956e-5f65029e50bf@maciej.szmigiero.name>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <cb4049d8-b6e4-46ab-956e-5f65029e50bf@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

>> But do we really need both x-migration-max-queued-buffers and x-migration-max-queued-buffers-size?
>> I think one is sufficient.
>>
>> I vote for x-migration-max-queued-buffers-size as the actual memory limit won't change depending on VFIO migration buffer size.
> 
> If just one of these limits were to be implemented my vote would be also for the size limit rather than the count limit.

Let's keep the size limit only.

Thanks,

C.



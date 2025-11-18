Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88609CEBF97
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 14:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLN0g-0003lV-LB; Tue, 18 Nov 2025 09:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLN0Q-0003b9-OU
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:48:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLN0O-0001jk-T5
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763477306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+NVkHQ1QpL7Jeoh3sLPP1pKa/wiI5u8l1couPp1qIxw=;
 b=GJVoltIik4uAZGkS03UBOeN+q80SvTw0e9/AeU9IKZ/WbmKzDQRX4A5bc0PVmPYRo1W6f7
 2kSHDjpEE+qutPZ/3S0LbqULojWl2bYxL9fKXfusxn8JokvfAKc5zGHkT3IWkphocqVhOh
 CZCZqSOnDmdueIdd0LMsklCzifttiho=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-bv3le3EhNhaxpSiyor7efg-1; Tue, 18 Nov 2025 09:48:23 -0500
X-MC-Unique: bv3le3EhNhaxpSiyor7efg-1
X-Mimecast-MFC-AGG-ID: bv3le3EhNhaxpSiyor7efg_1763477302
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b2ffe9335so5872440f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 06:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763477302; x=1764082102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=+NVkHQ1QpL7Jeoh3sLPP1pKa/wiI5u8l1couPp1qIxw=;
 b=VSs1oxwp2I1ziOeOSYMC6gqRBBdQaRYUc3VGVngLthKEiJ8I93/SAxpr6FzjQfZ6cL
 YWiQZ8cePv/6yeALo+vPHC20P3se1d6EgGmIm09OzplfmJxPXbVuHTzB3nb9pOfdpFMy
 y5QoYcXouAf6MsnhQVpgDHzZS+qZuGzA7wMdX1Bb8y2RSyeL6asJILZMdTIZXcxkSpgu
 5+FCAuO/0YIKVTSSoidCH2t2LAzoVZTvz/hP2D45Lnazn5GgURjWeVQcTb8lkYAI4snh
 r24eQMSF5SicEOjpwDw6ETJ/2SMvKubyffXZemwd8Okj4NMnrudWZ/jmLzd5aWqVFoMj
 5NLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763477302; x=1764082102;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NVkHQ1QpL7Jeoh3sLPP1pKa/wiI5u8l1couPp1qIxw=;
 b=raFQBSSry7HnRyHZZr9K6xqsrntIfWyKcmJ8bQOxA5Wfo2Y384hvQj+U4wnk9gf4zV
 hXR3Lt8YmFqeSJeTeVrEJ+hprNRJifULx7vbAQ9ZTv5Tf855Ymlqbl/XsA0GaqQhkjpp
 VXdu6OesvLROYnm+QmQ8dy97g7u4MlrSTyf+lpM1lEAvLEth770Mr2yW6wUAeT18Xkxm
 nYlbygxclT6ETNLRYszTsNSzY5oYk3EzevUpBMaraK74DWjyRm9mmxZJZC647DQhTwMk
 2NIQevEYrpGXp0oZ70ILoFg6k9BowkLRbbBNop7kuNLPAsQePvL2pFznYTCEzLZVe4ch
 vmHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEZjbe/em3o/2dbhr3P4oxgZeEjp1yuHLAjWYr5+UtYjTi8U3sFlcY7awlLGuv/20kPgs15a4pgTFV@nongnu.org
X-Gm-Message-State: AOJu0Yyvf1cMA4ri24KLMV8plxst5s04PfYmdI15EeoqZA2+uLXjhgdW
 BdrKfTFQeZE+i8aKbPCLJpi2glnP6cRRaiRtkezAW91W6bYMRDxqYeBumGm/FNCDsD1iGq5hM+2
 orb1JVI6IGdK1wAUGJd17hQXMVC7uaqjjMS/ClzWSUWlzExYt1kR1vyah
X-Gm-Gg: ASbGnctVoDPtqykifW2CQLCyHr8bRrmc7AHNZMwnmERh2Y+kKC6Kf1QBPSdZEWKyoFR
 /kPnB1MllgEb3LX4WrAPmEA3aSvXaLHegxV7BY2UkyNSgCNZzv01gHdfM1frfmK0cUpMcCkaa8X
 568DSVaFJJYA6fzoEyCgl/+fRDycx6nhDi94DOVlVDtXWAEdwdrnPr1gTqQFgxHBxmS80wy9V4o
 eh8pq68DgEw+j964VdkXB9/Mie4zrzoOlNAHPQpFDOIB9lxDTJ5rhdlZL2z9zT9ZFh996Pl36k0
 M/KSA5Cua4d+ADZvYV5W0Jyp5kLyN06uljr5NihJZGBtplHq5gv49nhP+2f7AHxc+HM+6/HH879
 wHWb0wic=
X-Received: by 2002:a05:6000:26ce:b0:42b:4279:eddd with SMTP id
 ffacd0b85a97d-42b5934aca1mr16105291f8f.24.1763477302250; 
 Tue, 18 Nov 2025 06:48:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrm3GxGBjtmINbt7K1rCocJGlvgD6Ff0LKI7XUHA90nBLUK0Hku97YGJthjHfBMeNVNwT5NQ==
X-Received: by 2002:a05:6000:26ce:b0:42b:4279:eddd with SMTP id
 ffacd0b85a97d-42b5934aca1mr16105266f8f.24.1763477301780; 
 Tue, 18 Nov 2025 06:48:21 -0800 (PST)
Received: from [192.168.0.7] ([47.64.114.102])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f174afsm31738370f8f.33.2025.11.18.06.48.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 06:48:21 -0800 (PST)
Message-ID: <9d1ee20f-7533-422d-b72e-00d10912997e@redhat.com>
Date: Tue, 18 Nov 2025 15:48:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/s390x: Fix a possible crash with passed-through
 virtio devices
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20251118093945.35062-1-thuth@redhat.com>
 <20251118130218.30d3da33.pasic@linux.ibm.com>
 <50f79156-dd93-40c4-831e-66e558531be8@redhat.com> <87h5urquyq.fsf@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87h5urquyq.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/11/2025 15.25, Cornelia Huck wrote:
> On Tue, Nov 18 2025, Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 18/11/2025 13.02, Halil Pasic wrote:
>>> On Tue, 18 Nov 2025 10:39:45 +0100
>>> Thomas Huth <thuth@redhat.com> wrote:
>>>
>>>> Consider the following nested setup: An L1 host uses some virtio device
>>>> (e.g. virtio-keyboard) for the L2 guest, and this L2 guest passes this
>>>> device through to the L3 guest. Since the L3 guest sees a virtio device,
>>>> it might send virtio notifications to the QEMU in L2 for that device.
...
>>> So I think it would really make sense to prevent passing through
>>> virtio-ccw devices with vfio-ccw.
>>
>> That could be a nice addition on top (in another patch), but we have to fix
>> handle_virtio_ccw_notify() anyway to avoid that the L3 guest can crash QEMU,
>> so it's certainly not a replacement for this patch, I think.
> 
> "Prevent crashing" is certainly the correct first step :)
> 
> I'm not sure where we would want prevent assignment of non-dasd
> devices. The kernel can't (because we're dealing with a subchannel
> driver.) I think maybe management software on top of QEMU?
> 
> The other direction would be supporting things like diag500, so we could
> pass through virtio-ccw devices as well. But I'm not really seeing a
> use case for it, or is there one?

It could be a very nice test setup to check vfio-ccw in CI pipelines (where 
you likely don't have access to a real DASD) ... but apart from that, I also 
don't see a real usecase for it.

  Thomas



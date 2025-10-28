Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B87CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 15:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDlAN-0008Gb-Pv; Tue, 28 Oct 2025 10:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDlAM-0008GH-VZ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:59:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDlAH-0006e3-6u
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761663547;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxGGz+2X4ypdTnDUgnXV0gyvH8gT2giV+hULMQqRzOU=;
 b=RSkvvXZv/DXXmv5lFQd133o7lt+xmHS8mB5XZezq+yJMv2tjodxA8tPKN33OA6X3YRFqFE
 Az1fIyfsyJzCGzKX20Fg3JmJMG4VemX//ApzS82OtM+ux6Dp3YC3KkT2RJClrvsq0csDna
 koAgsFDUg9Kc+qBRKmMFHrnxIE+j74c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-9736hjgWPDq_cy7pWQdl6w-1; Tue, 28 Oct 2025 10:59:05 -0400
X-MC-Unique: 9736hjgWPDq_cy7pWQdl6w-1
X-Mimecast-MFC-AGG-ID: 9736hjgWPDq_cy7pWQdl6w_1761663544
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-470fd92ad57so73766495e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 07:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761663544; x=1762268344;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rxGGz+2X4ypdTnDUgnXV0gyvH8gT2giV+hULMQqRzOU=;
 b=tuzjO5GlL6O9d+06fQL5IFzJh6szb7xigmKU5VdEnh0IO0NqPagoVKgqj9fme0FZ09
 69okjAcBJIYcYCxpf7dFT1tFq4kMxjsTyckVwhEnc9EFZOQA6jo2crOGKT0lv8O/zjqt
 JMdlXPsUmBpn4uBnhzxHbgFASm4VLL2UEKYF49ts0vkcZnPbHXveEQuspzQeDcCIDZcP
 iQaCrxbRRdIHCqJVYhvKq10M0fy31gRLEvzpQZZrC00Zj9Gl+uH2Fo+AtZf2BtKsB7te
 KEX2VOK4acv9y0c2F6L9SllCLyA2U003vUirWi+nD/84w1lT6D9MCcqlK77GHi3OB7pE
 Q/iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHTtAlhpXgyA1VLj3oWfAhXrbivvVbBPtLY1fzPKlbYzj9Ny/j3ZCFk0FvimjeC7hwn4Pp/YRG/4tx@nongnu.org
X-Gm-Message-State: AOJu0YzGCKtcLpquxe1QNMUoRcNPt25jT6odyQ2RFKBwciNzkf9X6XWx
 F8ijCsv+i38cep9aGsRNAcdvZpQrk360ikW2ufaOnjA62/R84WunRuu+VrJKs7qn234iYL64Mr1
 9rhs5ojNU+9W4sHltDswWwtcJV0/Y9fitCFqjbq7zMxbj+g+EAyY//a8B
X-Gm-Gg: ASbGnctFcJOZpmvp5AHjxZKmEQhNfdr7mIChK33iX5jbwDDzs0H9LDHYXj2m65ePFD1
 mbv5ePjoA/2DY1MWvfqlscTRWPB4aQQwTs1FdKPYz0BVhmoXei4GeiTGJC/i+EZBWZdqtqln6bk
 guW98BBNgiqgdhsrorYt6S+FVq3nwPzJhAOaXp3U5M2H25eZrGKCeuH64VY7rVvh2SU+xxh/FqL
 PUorkBhkk4cdEDOaDiPl6weU+E9BCR/KLczCTD6OBEwaBaagJ6SCKtXizJeLS+iQFwY8jmS4Zw+
 fG2+UFTEPKFR5QddCEK2okFqpWzLVp42CPub+l7h2gcIPTTDWL/xHQrED9bzk3qCeilw2rbWLcO
 BYtrffwvX1QX9TrfdaP3id45CCsCMioX7Hkz7Febw9spRRA==
X-Received: by 2002:a05:600c:6217:b0:475:dd05:93f with SMTP id
 5b1f17b1804b1-47717e70407mr32744365e9.36.1761663544451; 
 Tue, 28 Oct 2025 07:59:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH74yGoEhY2aDD4HnZqnmznjBzv85hjfmkrBMmFCge9XyPmj3iGHUFbmh+R7p9HZHtBXlKveg==
X-Received: by 2002:a05:600c:6217:b0:475:dd05:93f with SMTP id
 5b1f17b1804b1-47717e70407mr32744095e9.36.1761663544028; 
 Tue, 28 Oct 2025 07:59:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4894c9sm194591435e9.5.2025.10.28.07.59.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 07:59:03 -0700 (PDT)
Message-ID: <30630f4c-0d77-42da-8df9-97e737c5c515@redhat.com>
Date: Tue, 28 Oct 2025 15:59:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/27] hw/arm/smmuv3-accel: Add support for ATS
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, ddutile@redhat.com,
 berrange@redhat.com, nathanc@nvidia.com, mochs@nvidia.com,
 smostafa@google.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, shameerkolothum@gmail.com
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-23-skolothumtho@nvidia.com>
 <26f4d9b2-75be-4913-bb60-01e647a7ec83@redhat.com>
 <aP+oRLu/BYNaAPHG@Asurada-Nvidia>
 <25d22f06-69e2-4954-9bd9-f73f899fc114@redhat.com>
 <aP+xhmLCRu6y0eQm@Asurada-Nvidia> <20251028121625.GF1018328@nvidia.com>
 <9748e922-057b-4e7c-ad6b-b83f5591290a@redhat.com>
 <20251028134148.GH1018328@nvidia.com>
 <15e0d683-e524-44ed-b253-c6221585d9bd@redhat.com>
 <20251028140340.GI1018328@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251028140340.GI1018328@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 10/28/25 3:03 PM, Jason Gunthorpe wrote:
> On Tue, Oct 28, 2025 at 02:51:29PM +0100, Eric Auger wrote:
>>
>> On 10/28/25 2:41 PM, Jason Gunthorpe wrote:
>>> On Tue, Oct 28, 2025 at 02:21:32PM +0100, Eric Auger wrote:
>>>> On 10/28/25 1:16 PM, Jason Gunthorpe wrote:
>>>>> On Mon, Oct 27, 2025 at 10:53:10AM -0700, Nicolin Chen wrote:
>>>>>
>>>>>> Hmm, that sounds a legit reason, though adding the ATS support to
>>>>>> the emulated SMMUv3 isn't seemingly a small effort...
>>>>> What is "emulated ATS" anyhow?
>>>> I guess it means implementing ATS translation requests and capability to
>>>> send ATS invalidations. something like:
>>>>
>>>> https://lore.kernel.org/all/20250628180226.133285-1-clement.mathieu--drif@eviden.com/
>>> Why would you even want this? The cover letter didn't explain what the
>>> point was.
>> well I am just concerned about exposing ATS support to emulated EPs
>> while we actually do not support it.
> Sure, that shouldn't be done. There is ACPI/DT tables indicating if the
> each device supports ATS and qemu should not be marking the emulated
> EPs as ATS capable in the first place..
>
> However, there is no big work with showing EPs as ATS capable. They
> don't implement an ATC and there is no concept of "translated address"
> inside qemu so the only requirement to make it "work" is to just NOP
> the ATC invalidation SMMU commands for those EPs.
For the record, there is some form of ATS support in virtio-pci devices.
They have an ats property. See hw/virtio/virtio-pci.c and
virtio_pci_ats_ctrl_trigger/pcie_ats_config_write

vhost can be seen as implementing an ATC cache on kernel side.

https://lore.kernel.org/all/20230512135122.70403-1-viktor@daynix.com/
>
>>> qemu emulating two levels of IOTLB caching in software, with a
>>> software page table walk?? Why??
>> About the actual use case for ATS emulation you'd rather ask the
>> contributor, early SW development, IP development?
> I guess, I assume some OOT driver is trying to model their ATC with
> more accuracy. Maybe to bolt qemu onto a chip emulator.
>
> Jason
>



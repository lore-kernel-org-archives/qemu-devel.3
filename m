Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858E0CAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 08:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0bte-00058Q-UQ; Mon, 22 Sep 2025 04:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v0bta-00058D-H3
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 04:27:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v0btS-00036T-Jm
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 04:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758529642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FjsbbxrlxvP6eznkQjCtJyhze5Ay7fDEuOZSug9kXg8=;
 b=hIQVbQLxOYTedZLJoOANFHhcW3TCVJnY1T9C5opTS0WRJ0AxUEo5ZyiKDp1zgmvlHyWnvT
 6yDpFD2o4huoRQ1nhK4xdNlo88E3zLtOCBr4GtH0tHE7qd+qkcfOCtGGtCgigZ1jDk/9Pn
 Cq48mhpzBcKF5PyOchGQ6uXiqDb/qtU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-RkCq6wvjPLWd5rerY6aBGw-1; Mon, 22 Sep 2025 04:27:21 -0400
X-MC-Unique: RkCq6wvjPLWd5rerY6aBGw-1
X-Mimecast-MFC-AGG-ID: RkCq6wvjPLWd5rerY6aBGw_1758529640
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46c90948deaso9037185e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 01:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758529639; x=1759134439;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FjsbbxrlxvP6eznkQjCtJyhze5Ay7fDEuOZSug9kXg8=;
 b=ffBclwnkTDq4LHoq7b9aI7uIs2XV+j61SCazMau5SNtnUX9d6gTVg1S6I0pdOcGYAz
 yAvFP/1E+mFzge+WcGGTOWztRNJbtPnJYsXzVB7E6M75TRWdyjXGQWhq75XPanMiDQwB
 ySiFjaVuUbWTuZP7r0Clc7ZmUP43YaZQGVBI8uPxVCA7oW4ChB03DuD6t95QU6GQRQsE
 uwXW/WIiYEsYuaa2WyvEWHM1OZhO5gN6OyZYx987LXWf2wShb2TYcL5K4Jb9YIPmB6on
 WWp/KSzaBky/ubm2eeqF3RDUsf36iu/QvYkkTWzohQWO2Fs7oOy3egwjPK8aXS9QFV/h
 CTMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEiaL3R4khdSlnTBv/T2bztawAQ2Zps9LbDziSmWvKqVmE9c8Q/vEZRKEWChPBdSPnaBv6/ob4IIRI@nongnu.org
X-Gm-Message-State: AOJu0Yz8f/OQ3ykIcl6irJZqvWaLS2KwvV/kR5ieC9LRuiR9GjxLbht7
 Si2sAzfz5PMkQ9tpXN9wKo/LUHnAsaSeKy9313OwkpM4JW3odZ3VaUMqElQrwlLi3jywdR2bEsQ
 7Pzu4+JpzjKzJiJCrWjYcNgSWxntAKVfVgT+tKV/pSap37dMlvLSIXZ92
X-Gm-Gg: ASbGncsXzsEYIU0cTlkED67tbPGC68RtjVdK0r6Xk+BQXDrvJZIVuv6WOXWLaHT/Rzl
 WGz18y5KkJDHwnyseRF2viq2CGde2Bx5ddO83k1E3KM0WdpdKzr86cy3uEVVH4fixoh/fMh87el
 It3FPHDIHLysPtBJVzI7RRkS4EXI7X/Y+FW1NzSbBiZLXoiwK9mb8kWlxFRBAwzR3Dbex59Q2+5
 sVfHGWGgjJuWB4pVD4WmK1HDLUZRjTy0FCy7expmU5USz5ieKFlR5qL1B4kK16y5WPUJoEEh5t+
 erw3/vOgjh7TLn4zDxf2xx+NAomA0uo8DI91GkzXvgBI6kzMJN7ilRZkQToUpCe9s6XrZubGV1e
 PVSA=
X-Received: by 2002:a05:600c:c04b:20b0:468:86e0:de40 with SMTP id
 5b1f17b1804b1-46886e0de83mr77200875e9.4.1758529638810; 
 Mon, 22 Sep 2025 01:27:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ7fsnJyQiErNKHhkATyX9GalxAIjMv0qQ3Gln655azeABND7CSmztsTvvk0rx9BhAD1N3FA==
X-Received: by 2002:a05:600c:c04b:20b0:468:86e0:de40 with SMTP id
 5b1f17b1804b1-46886e0de83mr77200515e9.4.1758529638335; 
 Mon, 22 Sep 2025 01:27:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbefd5csm19969573f8f.51.2025.09.22.01.27.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 01:27:17 -0700 (PDT)
Message-ID: <e0a2c3f0-eb14-4d06-9658-23208ee6e870@redhat.com>
Date: Mon, 22 Sep 2025 10:27:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] vfio/iommufd: Add framework code to support getting
 dirty bitmap before unmap
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, Xudong"
 <xudong.hao@intel.com>, "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
 "Gross, Mark" <mark.gross@intel.com>,
 "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-2-zhenzhong.duan@intel.com>
 <ee5c9d7c-a85e-4da4-bd5a-a59951a19a06@redhat.com>
 <IA3PR11MB91368AE2A58185BE00627E149212A@IA3PR11MB9136.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <IA3PR11MB91368AE2A58185BE00627E149212A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/22/25 05:17, Duan, Zhenzhong wrote:
> Hi Cedric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH 1/5] vfio/iommufd: Add framework code to support
>> getting dirty bitmap before unmap
>>
>> Hello Zhenzhong
>>
>> On 9/10/25 04:36, Zhenzhong Duan wrote:
>>> Currently we support device and iommu dirty tracking, device dirty
>>> tracking is preferred.
>>>
>>> Add the framework code in iommufd_cdev_unmap_one() to choose either
>>> device or iommu dirty tracking, just like vfio_legacy_dma_unmap_one().
>>
>> I wonder if commit 567d7d3e6be5 ("vfio/common: Work around kernel
>> overflow bug in DMA unmap") could be removed now to make the code
>> common to both VFIO IOMMU Type1 and IOMMUFD backends.
> 
> I am not clear if there is other reason to keep the workaround, but the original
> kernel issue had been fixed with below commit:
> 
> commit 58fec830fc19208354895d9832785505046d6c01
> Author: Alex Williamson <alex.williamson@redhat.com>
> Date:   Mon Jan 7 22:13:22 2019 -0700
> 
>      vfio/type1: Fix unmap overflow off-by-one
> 
>      The below referenced commit adds a test for integer overflow, but in
>      doing so prevents the unmap ioctl from ever including the last page of
>      the address space.  Subtract one to compare to the last address of the
>      unmap to avoid the overflow and wrap-around.
> 
>      Fixes: 71a7d3d78e3c ("vfio/type1: silence integer overflow warning")
>      Link: https://bugzilla.redhat.com/show_bug.cgi?id=1662291
>      Cc: stable@vger.kernel.org # v4.15+
>      Reported-by: Pei Zhang <pezhang@redhat.com>
>      Debugged-by: Peter Xu <peterx@redhat.com>
>      Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
>      Reviewed-by: Peter Xu <peterx@redhat.com>
>      Tested-by: Peter Xu <peterx@redhat.com>
>      Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>      Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> 
>>
>> I asked Alex and Peter in another thread.
> 
> Just curious on the answer, may I ask which thread?

According to Alex, the QEMU workaround can be removed :

https://lore.kernel.org/qemu-devel/20250919102447.748e17fe.alex.williamson@redhat.com/

> btw: I just found unmapping in halves seems unnecessary as both backends of kernel side support unmap_all now.
> 
>      if (unmap_all) {
>          /* The unmap ioctl doesn't accept a full 64-bit span. */
>          Int128 llsize = int128_rshift(int128_2_64(), 1);
> 
>          ret = vfio_legacy_dma_unmap_one(bcontainer, 0, int128_get64(llsize),
>                                          iotlb);
> 
>          if (ret == 0) {
>              ret = vfio_legacy_dma_unmap_one(bcontainer, int128_get64(llsize),
>                                              int128_get64(llsize), iotlb);
>          }
> 
>      } else {
>          ret = vfio_legacy_dma_unmap_one(bcontainer, iova, size, iotlb);
>      }

Good. So we can simply both backends it seems.

Thanks,

C.








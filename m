Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FADCCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 13:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3aq0-0003FF-ES; Tue, 30 Sep 2025 09:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3apw-0003EF-AZ
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 09:56:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3apr-0002Yt-Hk
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 09:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759240560;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/suQ7wbS6Ffsygh1vK7bTksgy2Vsmyzot6Os1pFbPNs=;
 b=f0XPz2hB8kxEM3tWyJmNYe5bHloutm0sghVhPWYKG5GIwTmT7sQ/e1gwzBt2KPDClvueQJ
 Qxk3Fo4tsA7WfWcyQiYdhP4PAqvaJUkGxl4lFwWQRIAGmq2DQJQ7UxkWYS0kKmi1T2AEAm
 nenuUWhFyOZb5WY4AMZSIdHSc9PYAhc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-i1aiV-olOoS3cB1t7sP24Q-1; Tue, 30 Sep 2025 09:55:59 -0400
X-MC-Unique: i1aiV-olOoS3cB1t7sP24Q-1
X-Mimecast-MFC-AGG-ID: i1aiV-olOoS3cB1t7sP24Q_1759240558
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e3dcb36a1so32706385e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 06:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759240558; x=1759845358;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/suQ7wbS6Ffsygh1vK7bTksgy2Vsmyzot6Os1pFbPNs=;
 b=Y9UbiwtMdG4FVCSNWiGqpsI6WNsI1h5RZ+a+ImRHiiPKsDiJt2sF31JSDqXR9THyt6
 GjebklgiJEGcudf36o9RbeglgNO2/qc+J/UaDTc9WvyKaHOZzGEoewWFeYpykqBLB39G
 km3t5Cfp7Kzxj1D/el6q9xsGXysCi3jAxXTtPtVZ3iUGs3HgtFhjp2w90Wa77/41ktdH
 p9ZJAVPE+RXsQssFY3SLWViw4zLX9h165UtUDeNEirQ05/Q9AKnKr/xvrrCIG6coY67x
 JvvuccGLy5pytHGvi7yE/flN1LaFS/YXT8CZjIVAWXTOxgH3eMBjh23NR/477/xPWo3s
 v7yQ==
X-Gm-Message-State: AOJu0YwLxFtaXnrhJKywsymxRfGwxA6SnM/szY/Xbf3G5ytuNlXgtRj2
 BRv2g1+Zhcix7qYOHTdarxJb9u2GdbzuSQYrnmbOnoEYt+Kx+A6s2lw6ZePjmwl0ZDmsiiJl4vR
 R/+IzhreYS6pfFUHoWBeNL/XlUfGL37UZ2iM1vkRV7Jm7D/oqNQTxuSEj
X-Gm-Gg: ASbGncvijzx6+ntyhQycCnWicIMre7rzK5oUXtTr/dUJYTfE8IZUjg38mraD0Dt+NaU
 nSZ8ftpBPxS3KcoqkE4a6kL7yUygR0UybdQyoadJwb7xXE7AMLcsiRgCVpM91Czsjo0GS0qySN1
 iHf3wiYCfFaV9fEvJj67XgXnj35wtL9tpEoYPE073g9KjmCLzrmZdq3jUUH8lsD0v9JkrJRJz/f
 EixRMvK0dAp2MzHNkYR5q4AMYgolL5W8rpUy8FRNlGCKHBHknpsUwAw6pE58MZifdtMk0dqXkCd
 T+URyClecaCH8Bb3f7JINcqtEf+iHNCFKUj6QQNkyvqkcPWfT6C8Xy9sHT1DxLOUdC7aah0PN3m
 xOS0Pa/ToaUlY6X8Y
X-Received: by 2002:a05:600c:468a:b0:46e:4705:4958 with SMTP id
 5b1f17b1804b1-46e47054a6fmr110203095e9.30.1759240557877; 
 Tue, 30 Sep 2025 06:55:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETNjhu13lLoZ/apuZyCmHApeXKSf7cZEOT6xkq8Xex1smU7PeKXF7lsI/VJ7CVyge/ik37TA==
X-Received: by 2002:a05:600c:468a:b0:46e:4705:4958 with SMTP id
 5b1f17b1804b1-46e47054a6fmr110202875e9.30.1759240557409; 
 Tue, 30 Sep 2025 06:55:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc560338csm23487123f8f.41.2025.09.30.06.55.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 06:55:56 -0700 (PDT)
Message-ID: <bdd7f08b-b577-438d-aa23-aecd41fe1712@redhat.com>
Date: Tue, 30 Sep 2025 15:55:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/22] hw/pci: Introduce pci_device_get_viommu_flags()
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-6-zhenzhong.duan@intel.com>
 <aNLrOIbBxZy00cS4@Asurada-Nvidia>
 <IA3PR11MB9136AE59AECA079CB61C4165921CA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aNOqH3u3vNFRukew@Asurada-Nvidia>
 <IA3PR11MB9136110BBC15C20546401288921EA@IA3PR11MB9136.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <IA3PR11MB9136110BBC15C20546401288921EA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 9/26/25 4:54 AM, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Subject: Re: [PATCH v6 05/22] hw/pci: Introduce
>> pci_device_get_viommu_flags()
>>
>> On Wed, Sep 24, 2025 at 07:05:42AM +0000, Duan, Zhenzhong wrote:
>>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>> Subject: Re: [PATCH v6 05/22] hw/pci: Introduce
>>>>> get_viommu_flags() is designed to return 64bit bitmap of purely
>> vIOMMU
>>>>> flags which are only determined by user's configuration, no host
>>>>> capabilities involved. Reasons are:
>>>>>
>>>>> 1. host may has heterogeneous IOMMUs, each with different capabilities
>>>>> 2. this is migration friendly, return value is consistent between source
>>>>>    and target.
>>>>> 3. host IOMMU capabilities are passed to vIOMMU through
>>>> set_iommu_device()
>>>>>    interface which have to be after attach_device(), when
>>>> get_viommu_flags()
>>>>>    is called in attach_device(), there is no way for vIOMMU to get host
>>>>>    IOMMU capabilities yet, so only pure vIOMMU flags can be
>> returned.
>>>> "no way" sounds too strong..
>>>>
>>>> There is an iommufd_backend_get_device_info() call there. So, we
>>>> could have passed the host IOMMU capabilities to a vIOMMU. Just,
>>>> we chose not to (assuming for migration reason?).
>>> What about 'it's hard for vIOMMU to get host IOMMU...'?
>> vfio-iommufd core code gets all the host IOMMU caps via the vfio
>> device but chooses to not forward to vIOMMU. So, it's neither "no
>> way" nor "hard" :)
> Yes, that needs to introduce another callback to forward the caps early,
> unnecessarily complex.
>
>> To be honest, I don't feel this very related to be the reason 3
>> to justify for the new op/API. 1 and 2 are quite okay?
>>
>> Having said that, it's probably good to add as a side note:
>>
>> "
>> Note that this op will be invoked at the attach_device() stage, at which
>> point host IOMMU capabilities are not yet forwarded to the vIOMMU through
>> the set_iommu_device() callback that will be after the attach_device().
>>
>> See the below sequence:
>> "
> OK, will drop 3 and add the side note.

With Nicolin's suggestions:
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Eric
>
> Thanks
> Zhenzhong
>



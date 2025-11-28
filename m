Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D42CFD376
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 12:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOy3y-0003Lq-Kx; Fri, 28 Nov 2025 07:59:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vOy3w-0003Lh-KM
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:59:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vOy3s-0005WK-Pr
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764334735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l+FvwAOMj9Y8xpMdtZbulp2NOjuxhSadJLVll8YmhLk=;
 b=d08zxwNNXe5MYqbISBR+YA6OfNM/kEU2lbECeMA9xE1g9PhmAH/IwSnIN6nEZVDpxUcSa/
 +mJButHvy7YpbZ07JoiXnV7vqxEhB99g/UhhsTmdjiZIUJ5243jCbvzY43An9dufUYcz/G
 cNsSbeKR5cnt6qOGpsKMaXAtoecwKSw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-PuvMXiU-N5eYBI78dsiIKw-1; Fri, 28 Nov 2025 07:58:53 -0500
X-MC-Unique: PuvMXiU-N5eYBI78dsiIKw-1
X-Mimecast-MFC-AGG-ID: PuvMXiU-N5eYBI78dsiIKw_1764334733
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-429c5f1e9faso1456489f8f.3
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 04:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764334732; x=1764939532; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=l+FvwAOMj9Y8xpMdtZbulp2NOjuxhSadJLVll8YmhLk=;
 b=TSsbHyq3wK8yzoCL2MAeU/ewWGGHHpJu7F3TaS+AcR6fA02xNt6dEWv28zarQOYxP9
 Xhrp8IWfJSdtIAYPb+u9j7+0K4heaXdQ1tz6CH8Qh9Ax4b8dePi0jgA2PjLkmbOMXIvK
 WJmVTIpBcEkOalj37WchkpkgJ7AZDnGTEoPIoG7+xg94OmEgqO+PaaLhQktovof27J+7
 V2zi1uWTW62CXM86Y0XeaXYTUgb9CwMTEbL4xSnMvSbvR3TBNiSZVGStD7ZMI9AV0D10
 ewCjg5dK5dIV7wJxQXJ0YUsZ3fbZK4vGvxrkCCPHug0y5jllJ0cOa0l0txnZ35hDnss+
 Bqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764334732; x=1764939532;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l+FvwAOMj9Y8xpMdtZbulp2NOjuxhSadJLVll8YmhLk=;
 b=ibYKrRlVJhKoKywdndJYMGvjpzuKwzgojob1JqtRi1SXFCL6/XcImK85WjwzqRKckV
 gsqpgHyH+2dLp3h2CkG8IYHFQvejFZrPXpGFYtS8r23bR6K12uEho3JPq4vRAjcpnMOu
 +ibofEL30Bs7pbzLhMkbja4ubrWxiphyG2NdUkUc7aMoXeJdBSFC772FRS/RJI99+m0g
 FLD9uSMh18mAcDO3V7Tu1ddt5VlwIPLlOBCGP7KZTrr852F95DY0i+gtut9ZdolwmiaS
 wlyExAJQ5StMutc53XGgYDKk4C2haABz6zWJHKDKnXqpVGRgmh2BjPEGJ0QiJ4ZLhujT
 3H6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzUXNhZB+DdKZ7S9xvtJxxPSdR/Ay4PDYfk7QdpfW9CBMbte3lheSiDHIpvNlWMEqCEOn/rb0TJAcC@nongnu.org
X-Gm-Message-State: AOJu0YwNMGvaU2gGYpmnNIl+hJdMcj1ZKoTrwx11qY18EBUfERQYeFdm
 IKKOhUdWQKpqpYtwp3bSxRio6VPgo/r7XwyY5sGmxg7YjuC6ZCDUVrVN6awQYjMHbbgQXu8pHUn
 bkgwfUt/UgMIeyuVRa++oiYISDRrBhR5QuPL5Woe4brM3m8gY2vtTPijq
X-Gm-Gg: ASbGnctthIgbjRb/4pBHTtPHKRP+wq85dGYH24uDUwyWp9K6ge4ID8dhgVqatPw0KvL
 v0j0OGSEvtkrgNYYQjFiacmx2W4Gl9aQwCLtSc95PX2sS4cLzG586/hh+0hzi8MnlbZ2RJRv8tV
 7UxmlaXPMmcTSvSWdUOL3n/5UdGuYY5Z+RK5btii/Wvsu3zTn6aZnHoQfpHB0USiOUJxOwrQZsy
 8bSnI9TgAC2FJxHB02rIU3TCy4G3jCfLj3XWo0mYgYheR094ZB363Ietryex6UoKVGO5WSo3pVy
 XYqGc9S4YdfJ1UNLjw4Go+i0eL0mGeuVTW7bOWEDYGWmX22iDZfK1Oevx3yof/0gHM3oZ7HgE9X
 wZDwOxm6QSwFbQWOpduf53O1FoRkWPq+Vn2/jYwENQlJWSQ96
X-Received: by 2002:a05:6000:2c11:b0:42b:3131:5436 with SMTP id
 ffacd0b85a97d-42cc1cedb16mr28747091f8f.16.1764334732555; 
 Fri, 28 Nov 2025 04:58:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF51ezI3N+OAlPvrTT82ggYAWs5KZCWAXGSr+zGelTWrYvswqNV31HRY7u4Ven965vKyxlIhw==
X-Received: by 2002:a05:6000:2c11:b0:42b:3131:5436 with SMTP id
 ffacd0b85a97d-42cc1cedb16mr28747055f8f.16.1764334732148; 
 Fri, 28 Nov 2025 04:58:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca4078csm9326857f8f.29.2025.11.28.04.58.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Nov 2025 04:58:51 -0800 (PST)
Message-ID: <bbc8412b-25c3-4c95-9fde-a1c9c29b54ce@redhat.com>
Date: Fri, 28 Nov 2025 13:58:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 17/23] vfio/listener: Bypass readonly region for dirty
 tracking
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex@shazbot.org" <alex@shazbot.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
 <20251117093729.1121324-18-zhenzhong.duan@intel.com>
 <DS4PPF93A1BBECD8E078A7FB081E0AEF07E92DCA@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <DS4PPF93A1BBECD8E078A7FB081E0AEF07E92DCA@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello Zhenzhong,

On 11/28/25 03:08, Duan, Zhenzhong wrote:
> Hi Yi, Cedric,
> 
> Could you also help comment on this patch? This is a pure VFIO migration related optimization, I think it's better to let it go with the "vfio: relax the vIOMMU check" series.
> I'd like to move it in next respin of "vfio: relax the vIOMMU check" series if you think it make sense.

IMO, the "vfio: relax the vIOMMU check" is fine as it is.

I would instead introduce a new series to handle ERRATA_772415
since it is a special case of "intel_iommu: Enable first stage
translation for passthrough device".

So we would have 3 series (in order of appearance on the list) :

1. "vfio: relax the vIOMMU check"
2. "intel_iommu: Enable first stage translation for passthrough
     device" without quirks
3. "vfio: handle ERRATA_772415" with the quirk part, so that's
    patch 17,19,20,21 ?


Series 2 seems the most important, as it sets the foundation
for the other architectures which have a need for nested
IOMMU support (smmu/nvidia). Series 1 is nice to have.
Series 3. is an extension of 2. for broken HW.

For the next iterations (QEMU 11.0), let's get series 2. in
first. I have been including it in my QEMU tree for a while
now I didn't see any regression. Should be fine.

Then, we can merge 1. and 3. through the vfio queue. Shouldn't
be a major task now that we had all these reviews.

How's that ?


btw,

   Reference from 4th Gen Intel Xeon Processor Scalable Family Specification
   Update, Errata Details, SPR17.
   https://edc.intel.com/content/www/us/en/design/products-and-solutions/processors-and-chipsets/eagle-stream/sapphire-rapids-specification-update/

Url is not accessible (for me).

Thanks,

C.




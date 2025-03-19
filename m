Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBDCC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 17:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuxQN-0005xm-PD; Wed, 19 Mar 2025 13:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tuxQ9-0005wD-Ch
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tuxQ5-0007fd-K4
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742406092;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=afKwMH3Ahotwp7v2I6DY6rbyXWrTqYfCiVPwabqxEe0=;
 b=AMtl/kHKvkFqBx0p+gx8rwONhYF0plkUzk9DZGMORZGgKcwAbyr73tKUU+B+iV/ZOsigo+
 NFv7w3IilQWA/6dE7d049z22k6Xvhj2mtexSB1ahdRtih2MAqrhjfc19axlATxgxI0O91R
 J1jfmHrv0lklIfEr6WXDZNHqfmFFYOE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-UoQGm2P7MtmBEqFSro5oRg-1; Wed, 19 Mar 2025 13:41:31 -0400
X-MC-Unique: UoQGm2P7MtmBEqFSro5oRg-1
X-Mimecast-MFC-AGG-ID: UoQGm2P7MtmBEqFSro5oRg_1742406090
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cec217977so31923185e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 10:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742406090; x=1743010890;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=afKwMH3Ahotwp7v2I6DY6rbyXWrTqYfCiVPwabqxEe0=;
 b=YynZ+1zkAMm/I5r96yiMo7bjhj7V51Ffu7/JINwNq8lw+tWbAdaLu8sT3dP/LG+Pcr
 DUXtm0w/nxODH5BkrxZZYnax/Lj2SAUJumA/VsXHRbPkjwTYZn5jP6wDkQB4rBkqN4jx
 5eHput8zkXXynJaYb8cL95TldykrdDG+BrjDkJfP+jsxoZBvMrF1+aromF9KG4b8wMVz
 vxrEz37pLWUEdSE3hDXNjzqFdCBRl/IuGRn7+sf8H/v5hSOefGSTfcVR+U6n/axG7VL4
 6+OO3tcXB6zhz+p1p/nOgAMxtwS0JUMxDVWMdqNgJOeZnhWMMKqWZWqmXkcYM0IcJjgJ
 xQEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJv0dWuXi7/hToZjHuy4BuXUpxPt3Bprp4yiKxdM0cp9CNtflz+B5tSkMUXT0+y7X3mkq49PCPU3hS@nongnu.org
X-Gm-Message-State: AOJu0Yxn24dnsrMYrX1W7hAaPVly1lyhCjz5ehBD8vAqYwuRATcxH3RP
 F2Bo/jzlmZbccqHkikoW4MAs/KCKoTH3yaFgmJdfl/yNqYV2xAs7i7HjIZjaatDsTVT4yHjrZqP
 k4tijXkJGOxZIFM8Urw9cj6v814n4za1QZtSHfHgYP0HuVe4fFPDv
X-Gm-Gg: ASbGnctQWn+Ya2tlxXj15VMFh3FMS0sVEHVPNa+VuAzr6TQCeg0qIo0KVdulVdXpfPZ
 gaoiiy79q5LmCiSiiFCPgIWYTWfrwEzaGrFL2Ka5FIjNdbx7YEo8QBuqu8CUv4rqBzVAHqMyytt
 oHP9VXcsxLwzc8MbEuUevJ4eWuvgsPvJuP8VEKqjAoyt+HBIDjkNtrShk1CY3e6urCQOUoNugtT
 +zbdkdtNGikaLmtJK5jgIDKeXr8Dvqm9mdLQkya2tXNugoLRaiqDpXRkAmUDhuSMumJyTkupArJ
 /RTed+aElEGcwULoOQ/Y84JXYqBxRVDez3GpWeNZA7D0XNWgS3Ss1qBIRVD123A=
X-Received: by 2002:a05:6000:1448:b0:391:39fc:6664 with SMTP id
 ffacd0b85a97d-399739b4dafmr3659348f8f.6.1742406090112; 
 Wed, 19 Mar 2025 10:41:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDQazgaVFkeNoiZJd3Uo19R97YA88m/1ZCk2kdfYqTLhOV+0jaWXONUMQE+x4TztuQAw6Ntw==
X-Received: by 2002:a05:6000:1448:b0:391:39fc:6664 with SMTP id
 ffacd0b85a97d-399739b4dafmr3659319f8f.6.1742406089739; 
 Wed, 19 Mar 2025 10:41:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c83b6b2bsm21102774f8f.26.2025.03.19.10.41.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 10:41:29 -0700 (PDT)
Message-ID: <79bd70c8-a0bc-429f-bc25-7bc5daa90c04@redhat.com>
Date: Wed, 19 Mar 2025 18:41:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Nicolin Chen <nicolinc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
 <Z9hzmzHfWw18OyGO@Asurada-Nvidia>
 <11895c78-d6ab-40c8-a500-4abed1565234@redhat.com>
 <a1a62689da8c43ca98a4379773db241c@huawei.com>
 <5a273945-3557-43f6-a235-1517d5db9b48@redhat.com>
 <20250319173444.GN9311@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250319173444.GN9311@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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




On 3/19/25 6:34 PM, Jason Gunthorpe wrote:
> On Wed, Mar 19, 2025 at 06:26:48PM +0100, Eric Auger wrote:
>> Effectively with ASID invalidation you potentially need to do both qemu
>> IOTLB invalidation and host invalidation propagation.
>> but this code is already in place in the code and used in vhost mode:
> Let's not forget the focus here, the point of the accel mode is to
> run fast, especially fast invalidation.
>
> Doing a bunch of extra stuff on hot paths just to support mixing
> virtual devices with physical doesn't seem like a great direction..
fair enough. Then let's disable the internal caches if we are in accel mode.

Eric
>
> Jason
>



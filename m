Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F0BE7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 11:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM3XO-0006gm-2w; Fri, 13 Dec 2024 06:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tM3XE-0006g2-O4
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 06:08:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tM3XB-0005gb-1u
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 06:08:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734088114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7IXLr+TRnnhPquC4z8x6LRu9U4BMsgbPwWiMYFQoe5o=;
 b=VZolD5KBb8IP+NkGjwH6fPa4edXtbrbaXm/cUy17yc6nWYanmky2NXotKf0DmPuhjFNf3m
 cZTrriCmgquMiXc8Fc17QhuuP/8d2Eue4eRth6dSCSAC9oBkaiu0hYZuFrCOmJjkqPDHyD
 aFxPki8IEZ7od/eXEF9NyinDGRfYnI4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-b5y0hlLMNb2fFUA37k4btw-1; Fri, 13 Dec 2024 06:08:32 -0500
X-MC-Unique: b5y0hlLMNb2fFUA37k4btw-1
X-Mimecast-MFC-AGG-ID: b5y0hlLMNb2fFUA37k4btw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361efc9dc6so9672485e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 03:08:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734088111; x=1734692911;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7IXLr+TRnnhPquC4z8x6LRu9U4BMsgbPwWiMYFQoe5o=;
 b=CuyCmQ3TX7AUG9BAYoK7Vxozmha5kuACg8g4qn6/cLTemXLyic9PaBjpWENdt4UEif
 3zgqpUMbt5MYXmbFUlvGYVoIxPcBfwP3YmP62fEI+hwvbnOVnVRIe/7o/CEmPFUB9uLo
 NkIO8umG2XvKY/AoxWfET8le+8FCX2ElYfISrltnuwJQEQAGpi8RphTz8TVFU8AMTPbx
 anKroAp+fExAvXwsha6/AphD5LqBXRJN6LeBBTrfBmaFMMFexD1/9FTHM6Z19jiQEHtj
 OCB2Xb68sao4wxEvP5o/B3gLD03YEp+ccv9gCKzG9YU303axNrzWS8UEqNtX4qZxaVuK
 gaXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdq192ePpjMSCdjl4eFKrGTpGKmcNVy+iraGnIHoBTj12kclW0ypZ2tDnXxuFwFcYed0mfMHn4iZBO@nongnu.org
X-Gm-Message-State: AOJu0YywckAp/bkTXdvRd6uoN8SeWw4Nox6B9utVkam6yzAc/Q3g4pnN
 DVuKVUDJMilt6fchcLmqurop+Y1MxIpKhnSiJNUUUzc4nUWz3Qz+0S+SHAD5rgF2efW2CoMxzwb
 2TH2odOkWI2QKHXslhaKOQkjzweODsTmFbfWsjY22EFLPUdpjnTzb
X-Gm-Gg: ASbGnctvUIfkHDI8xyu+i7+6x9cfZvXoG1YBKg+Fte1/uGrE06Tm8YOMOMN6nth8obK
 fD9DrOQDac3qKIyTCMXEeJDvpMo2oj6DT+jfphnm0BfmM8b7BpLVxMuTwThLgjcJxIDZg1UtsWg
 S/nDL3FaZjo1VTagkHf9HWavAFmtsBvOqe2MKJrgMtOwGRTDV53add41L+MexjjHuPB9mB/6sCT
 3pmeFBSAAfV926wTaHZsZwB8w6R3R1bkDNyqMVazit2At2g6QTRSdEjnzbrG6FA972hddGNMk2m
 55k=
X-Received: by 2002:a05:600c:1f14:b0:436:aaf:7eb9 with SMTP id
 5b1f17b1804b1-4362aaa49c8mr16282785e9.20.1734088111486; 
 Fri, 13 Dec 2024 03:08:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfSLj25YMd5gCx/vmX0J6N7ZgKlG2K+oLIxVLRHXgXXfx0q5K213O7MCM386+n1pTfjczqPg==
X-Received: by 2002:a05:600c:1f14:b0:436:aaf:7eb9 with SMTP id
 5b1f17b1804b1-4362aaa49c8mr16282575e9.20.1734088111185; 
 Fri, 13 Dec 2024 03:08:31 -0800 (PST)
Received: from [10.33.192.233] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362557bfd8sm46147295e9.11.2024.12.13.03.08.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 03:08:30 -0800 (PST)
Message-ID: <59897119-25d7-4a8b-9616-f8ab54e03f65@redhat.com>
Date: Fri, 13 Dec 2024 12:08:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/24] vfio/migration: Multifd device state transfer
 support - send side
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <4f5c33b97be09fcb4e1885073e31c5e930a39ad0.1731773021.git.maciej.szmigiero@oracle.com>
 <51279885-5229-4c5f-93af-d1214dd65f90@nvidia.com>
 <06360868-95e3-46e2-8960-51348025a1b7@maciej.szmigiero.name>
 <80c9dfc4-4105-4e48-bcae-4fa9780a43c8@redhat.com>
 <4c8c3309-b2a1-465a-9108-52eae22d67aa@maciej.szmigiero.name>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <4c8c3309-b2a1-465a-9108-52eae22d67aa@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

>>> By the way, this kind of an implicit dependency in VMState between devices
>>> is really hard to manage, there should be a way to specify it in code somehow..
>>
>> vmstate has a MigrationPriority field to order loading between
>> devices. Maybe we could extend but I think it is better to handle
>> ordering at the device level when there are no external dependencies.
>> It should be well documented though in the code.
>>
> 
> To be clear, by "handling ordering at the device level" you mean
> just disabling this functionality for ARM64 as proposed above?

I meant handling the migration ordering in the device load/save
handlers without making assumptions on other devices.

Regarding ARM64, it would be unfortunate to deactivate the feature
since migration works correctly today, on AMR64 64k kernels too,
and this series should improve also downtime. Support can be added
gradually though.


Thanks,

C.
      



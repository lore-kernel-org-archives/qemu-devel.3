Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00684C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbcV-0006eT-OU; Tue, 15 Jul 2025 05:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubbcR-0006dP-TN
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:06:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubbcJ-0005sV-5q
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752570383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=khw2eKWlZu/wkhA8zxGEFMbpqpGd0hoFw3N8lyYL4Dc=;
 b=fDsVqvzodRpNcyRW8i3kWtgnp+PFubzZdCpmFysA1mhLvpjzVUr7NRmGM2jEWw2+bHLW31
 E5DAGcnv9HPfB4//RG8YAiKJPzi6AwJgmW8VSjykyVUwTEu0hME32c4JVb0WJPQE0W/GYr
 ncX4wLshl/M7Pm6IbmI4X5pKwtBlo60=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-xiAcKKyeMF-dOkgo5ymSUw-1; Tue, 15 Jul 2025 05:06:22 -0400
X-MC-Unique: xiAcKKyeMF-dOkgo5ymSUw-1
X-Mimecast-MFC-AGG-ID: xiAcKKyeMF-dOkgo5ymSUw_1752570381
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4561dfd07bcso9334525e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 02:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752570381; x=1753175181;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khw2eKWlZu/wkhA8zxGEFMbpqpGd0hoFw3N8lyYL4Dc=;
 b=uwrOfYWM/pHSKcARLPxw1QJ/XASFzsyHVmXTIIuO3Uos9CjA8nMq7MvMlDV+Ut3dts
 nSOzGkVb1nUUotwvnKRIoALWvGxtX1DoN2PzZA4XwQ3xicceYbVVi1jphXEdx/hX/xFd
 RjfFGTh1ZFQ8nbud9ivOfLJHFv5s3n0YZcYZhLNNOCwqNzzYZ6wJtraT9w+kzh6ODxc+
 nSo1zG/DBfcmn0OtI85vgfRZ/rHOYIfTwQQ4v2/FMryMxIGBglYUKVxgFhGXzJl4XrmH
 6tOyHEeRTVrV+yEg0IkBMk6Ad9FTTJo0fC1gc0FBrgorp76lumcnsAVnXEmcVyAs0ITD
 75uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWWUoAPQqUrlSJtZ1myLMHyw4nr/2zR9KOZtL3tLPYf7CPEhbZCx4PuSEHm424JdFEZfLKmpx1ICEW@nongnu.org
X-Gm-Message-State: AOJu0Yw41bz3GjeEMS0yYwt8uEwyrgJwcYJ20CTNr0r3KDtaIDPBeLLE
 R3OBLM4j2GqU0oT6t8nfgM7NHETuAuZgzg17nycDQd9zNmRnFmqp5JRpD7aQQFdoYpnVAckib1+
 pmsuwpQfpZDJn2ZxF3nA6I/pVY0Hdj82BZGpn+0ES9s8oxeDxj/X5urPV
X-Gm-Gg: ASbGncshcMOpcRXen8/Q8zr2Ib3cRCTc5mZvJCeJG9nPTx/qjqqVn2gzmB7fBRrvpAM
 R8MvIDGlbEQjGcF/BgVvk1iwZQUqOALQRU1a3/lmWiLVvIyx/HZbD+UrZckU0Boo5hV6N32gwJw
 7kShQG5PajDw7ojIlv9xh1kqJODo2YgmKsY90UlTA9qwfMVFEJnCUSw5LL5bwHU+++idGU4T4OH
 8jOTFxAvaYQ4NppctoGz6Si8Mr0nDdkjxd58p8xMgSiEQzNG5kWf/BTW5vF41e4b50ltZOHA0T8
 va8yAAJdnOyXXGEmwBK/ClJw3WMIYFwyniJc23PvZ/rNzyMB2ggDY71Vq9Mo3Qf0hg3erY45fIc
 =
X-Received: by 2002:a05:600c:3b94:b0:456:d25:e416 with SMTP id
 5b1f17b1804b1-4560d2660a8mr102778065e9.6.1752570381081; 
 Tue, 15 Jul 2025 02:06:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUY5wLiSSkBKsdzCwAoPgPbysib+ZCtM5JeBcVkjY2NPlOKR8bHThMT7GyhpMu1G+YNT6BfQ==
X-Received: by 2002:a05:600c:3b94:b0:456:d25:e416 with SMTP id
 5b1f17b1804b1-4560d2660a8mr102777675e9.6.1752570380625; 
 Tue, 15 Jul 2025 02:06:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:266c:b13b:afd7:40fd?
 ([2a01:e0a:165:d60:266c:b13b:afd7:40fd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e285sm14391303f8f.76.2025.07.15.02.06.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 02:06:20 -0700 (PDT)
Message-ID: <021a08dc-c6c0-46a8-ab9c-acfb7290024d@redhat.com>
Date: Tue, 15 Jul 2025 11:06:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio-user: wait for proxy close correctly
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>
References: <20250710154731.1266732-1-john.levon@nutanix.com>
 <cdf4931c-cf7b-4849-8aff-0f73fc3d1189@nutanix.com>
 <cc3be6c4-82c5-4152-8206-f475e8762616@redhat.com>
 <fcb72644-123f-4cd4-afb4-98ac2ad72d9b@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <fcb72644-123f-4cd4-afb4-98ac2ad72d9b@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> BTW I have a series here that fixes up some of the QOM issues with vfio, but I'm guessing it's a little too close to freeze for this?

Please send and we'll see.

Thanks,

C.






Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88AAC83F21
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbuS-0004A9-Eh; Tue, 15 Jul 2025 05:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubbuR-00048u-2w
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:25:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubbuO-0002m7-Ak
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752571507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=buIRkHnvb4fSBDO8wBdvc7FHno8E6FZPFPoKmrJoMY0=;
 b=ZCWVKJOmwwmn1bcH2SWAtEA+8hjPpHaXq1C+ik5Rhdms8H4R0ltDojPYcE0tQn0S3IxwjP
 5tCiCFCVEAgLGj6+W3D3LKFwBS6R4h75CkyhFWZXkUP6CsQL7zzKaWzTVd4m3X9nWZ/DZu
 TwUMIo3eoaXBRjRCwRZTDAR3rziOpzg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-GyG5Z6t3MuOCQ-4OCna_xw-1; Tue, 15 Jul 2025 05:25:04 -0400
X-MC-Unique: GyG5Z6t3MuOCQ-4OCna_xw-1
X-Mimecast-MFC-AGG-ID: GyG5Z6t3MuOCQ-4OCna_xw_1752571503
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-456106b7c4aso8975595e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 02:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752571503; x=1753176303;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=buIRkHnvb4fSBDO8wBdvc7FHno8E6FZPFPoKmrJoMY0=;
 b=qIcBBgyGoqCbT6OmPRQmGMOdvbDzX7OMKVFX2k2iFJR0PyFSfeEjOi1r+gy2Zchq19
 34qFGM+V/2zizwFqB8CYGa0tlJDjk47OK5xScrx15m1VqwCWP3AQM+Re0X8LL6pBZIT1
 iZvtBlZJAd3y1Zaw/Ij4a6zhEMjcGtpE+tjLkj4iJBFNbif53sXoooYpWnPheuwX16J1
 NpaW9F+0VQlt15KeYbKHOr/zPpkx2ssa+iuopWPHOF/X8NexWgknFAQ1LiVvCAnw/E2o
 rCLwFuU+ieqd1wfkm20hxBH9lCsKB24iSlQ92SJgsiIPheY/C2XMiJAuYGuL6KqS+g2Y
 JEQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtMdW3le33sKoHaI4YeCEiIobKBy7gQXlCqPumQEa9u2pce+GEFTkRoJIX0Ll2nGCBwLXdJO2i4Ghz@nongnu.org
X-Gm-Message-State: AOJu0YxXcyO7tfgpxAIOllVui8zXaWHDlBDMFtCP/nHXVfk5Y2/Vau4+
 Yr120Yo2hOe7CYgRSvnt8Ytnjs8IYIrILDDRvnzDHzQ0p05Fp7dudUc2M4il41oiDQ54KxAz9rk
 ux08+p7xrvFtijMxJX3plnkF6LowzdF6uFarYbXkVwK8BiHO9KmeSpB/Z
X-Gm-Gg: ASbGncvGsbw7CElN8+gZbTY5XtP/fjsmnuqGysNjcAACgK4NLfjV+t61alcPlMTdeyY
 Vr/aQovYNqgTWRKP2xnSPMo1pRBUN0bGNMboxIxb6LIkYuKwfwFRJOgaL4tcTCJ9BHWbHohGMPY
 KHS7iefJ5wJ43YzWNDivQm5gaWFKQSv73SQuYtXtelVOROCNe5loD/d3PeJ0HdEyup3uEGj4qAs
 I7Qq53O+Cqt4M/7ERIL4yXhVeg/aopl1zeGLm/xwDkLehxx5D471q4VOs2/1YhdZyteIduFXozg
 wiWyhsHCJSxGIorbUhCZHUzefL5YAx0jEeyC+saj5O40D0ifXYjoGzQW9LTOkGjemezcZ0SKUbY
 =
X-Received: by 2002:a05:600c:1d8a:b0:456:1122:8342 with SMTP id
 5b1f17b1804b1-45625e2a951mr22749465e9.5.1752571502823; 
 Tue, 15 Jul 2025 02:25:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoyb+TyS3zO0+/QabBse5zMuxXT/dibI8V2KoJ7FdylmlN49PvPazGBgSwbA7f3vFLMZncaQ==
X-Received: by 2002:a05:600c:1d8a:b0:456:1122:8342 with SMTP id
 5b1f17b1804b1-45625e2a951mr22749185e9.5.1752571502422; 
 Tue, 15 Jul 2025 02:25:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:266c:b13b:afd7:40fd?
 ([2a01:e0a:165:d60:266c:b13b:afd7:40fd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd538b63sm157339755e9.19.2025.07.15.02.25.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 02:25:01 -0700 (PDT)
Message-ID: <b87ed404-4214-4d83-9912-95609903eba6@redhat.com>
Date: Tue, 15 Jul 2025 11:25:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] VFIO multifd device state transfer patches for QEMU
 10.1
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Avihai Horon <avihaih@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <cover.1750787338.git.maciej.szmigiero@oracle.com>
 <59a87a67-9283-4dd0-a29b-dae58fffe9ea@maciej.szmigiero.name>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <59a87a67-9283-4dd0-a29b-dae58fffe9ea@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/14/25 11:46, Maciej S. Szmigiero wrote:
> On 24.06.2025 19:51, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> When VFIO multifd device state transfer support was merged in QEMU 10.0
>> some of patches were separated for the future QEMU release after the
>> spring cleanup.
>>
>> Since QEMU 10.1 code freeze is getting closer let's have them reviewed
>> now.
>>
> 
> Hey Cédric,
> 
> I see these patches in your "vfio-10.1" GitHub tree

vfio-x.y is the branch I use for vfio-next candidates.


> but I don't see them
> as a pull request on the qemu-devel mailing list.
> > Are you going to post them? - the soft code freeze is tomorrow.

We still have some time. Let's see how v2 looks like.

I would prefer to have some feedback from the virt-arm team or
a Tested-by at least.

Thanks,

C.




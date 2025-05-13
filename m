Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C348C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 13:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEppG-0004ZF-45; Tue, 13 May 2025 09:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uEppA-0004Z1-Oc
 for qemu-devel@nongnu.org; Tue, 13 May 2025 09:37:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uEpp7-0008RF-Q4
 for qemu-devel@nongnu.org; Tue, 13 May 2025 09:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747143450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RoQkIKa2sSS7r7/SkJ/WHHLHLJgEglvh+zU88h7tJGg=;
 b=JRYdqxiHTaiv1cMw8RmPPNBAh4ABdyeS4EjbiQf2Jw+TtdAJqIw9jxdqwCqRJFS6B/NrrX
 PaLjrLQ/xs80h63tQ3Gwn7UdKekwu/fhsrDFEdf7b/KEztod6vOFX6WItdIlfMSm+o8H2h
 5ojutHly4bJ3eMA55tF5otQ5GWvx+NU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-UvmIfrIvOr6ODWkv_pLtKg-1; Tue, 13 May 2025 09:37:29 -0400
X-MC-Unique: UvmIfrIvOr6ODWkv_pLtKg-1
X-Mimecast-MFC-AGG-ID: UvmIfrIvOr6ODWkv_pLtKg_1747143449
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6f6f06890e2so103352326d6.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 06:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747143449; x=1747748249;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RoQkIKa2sSS7r7/SkJ/WHHLHLJgEglvh+zU88h7tJGg=;
 b=ezEOUEE9eKSRgC6iRgEUx4gYl5b5l/aaufadBjLt29MPyjjVpFcZe2vGmDrKUDKcCJ
 QdOYqiV/eBO2N93RVKWXJOyZ6M57ha3K7TxjGE+Qmb0NyphP9Xf4mlMv8a1CSiJ51Kix
 yxBwj1NRp4oq0Eig+cMXTWFs8AEFRibrG91nOy1XS9DCiNfnC5auHcaTBw0erJbrwDuA
 BFhPDrmt8t3/KrDGGgy7wfJM65pMtraf8xSZDVmnFoR7CE76630CcVzn8iIDcvBxQhyC
 NovFYXZquyb7T/PQwDMWvldkCbTc5YbCtgJMyiQmTQYCqlRF8ezmO1l6VsWsjzISMPJB
 J9fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGzq8XpobW2pLL7/VihZTs5WXBKVztg2zkNz2hE43n3HML4u/Zd08x1qX8lCUmWqbtnVq6Ce7upVvF@nongnu.org
X-Gm-Message-State: AOJu0Yz5054wSvoQouZ7OHFIN+txkUwcSI6yYhUomT6qmOyNM7JYfR0r
 NTW3dUUGvw1puz7d+Y1YQOb37QisnQfY+QOqpQ9hmcvxig3XVTODnYEwtOgFMQVF7BaXt48uTD/
 OY8wKMaz3mrIfcEHori5kV8OYyVpvAblI2KAsjfV2aE7ABwVbSVv4
X-Gm-Gg: ASbGncvSEONQc/QiCcsBgaTZoTvbXcbTgQqjXZ+VVoq0G+CMXEAFSDHDT3z5uPRCdQ4
 MdgYmeWGbGb4yzuoPjLRXnCvIdvnWebAVQlFmNZNpbApeq+guLEKysCKQDeXGbDmgYH3TksNbO+
 0nEyA+FF4AFyUJa0D1q0jwhWdjhswQjBpRXOAwvwlXQpgF0sxtXTN2VNIw/leRst3DcJsZJAFCj
 w8+GvPyRQ/iaUvPNQKDEHHrBi0KSFkoDZP0YZXCveqIJhfZSMSK5YONyWe8oxoYzLMDVTkx6hjF
 feQ=
X-Received: by 2002:a05:620a:2a14:b0:7c5:5e05:df33 with SMTP id
 af79cd13be357-7cd01155600mr2103449885a.51.1747143449042; 
 Tue, 13 May 2025 06:37:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXf7HMJvrnkJtA541MBg8LXygImQrO7fLD4eBJvoRej2JrTgooFjp3ok5OzPgnG/nu09q3/w==
X-Received: by 2002:a05:620a:2a14:b0:7c5:5e05:df33 with SMTP id
 af79cd13be357-7cd01155600mr2103448485a.51.1747143448736; 
 Tue, 13 May 2025 06:37:28 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd00f63bb0sm707380085a.38.2025.05.13.06.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 06:37:28 -0700 (PDT)
Date: Tue, 13 May 2025 09:37:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jack Wang <jinpu.wang@ionos.com>,
 "Michael R . Galaxy" <mrgalaxy@nvidia.com>, Yu Zhang <yu.zhang@ionos.com>
Subject: Re: [PATCH v4] qtest/migration/rdma: Add test for rdma migration
 with ipv6
Message-ID: <aCNLFWEgolUViugY@x1.local>
References: <20250513012207.2867069-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250513012207.2867069-1-lizhijian@fujitsu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 13, 2025 at 09:22:07AM +0800, Li Zhijian wrote:
> Recently, we removed ipv6 restriction[0] from RDMA migration, add a
> test for it.
> 
> [0] https://lore.kernel.org/qemu-devel/20250326095224.9918-1-jinpu.wang@ionos.com/
> 
> Cc: Jack Wang <jinpu.wang@ionos.com>
> Cc: Michael R. Galaxy <mrgalaxy@nvidia.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yu Zhang <yu.zhang@ionos.com>
> Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V4:
>   adjust the address format per its ipv6 address type

I used this one, thank you!

-- 
Peter Xu



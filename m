Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBA3CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 07:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAjtc-0008Tp-J1; Mon, 20 Oct 2025 03:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vAjtX-0008Sn-3J
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 03:01:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vAjtV-0004Yp-Av
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 03:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760943684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ce6a+r2zYEIIak1H9gln/r1PqxxeW1y45sVTsUMR6/A=;
 b=YWeVPPtgbvY3zlRys/ZGXpXZiNM4aNjniCcYJ72gZb17WC7cR+JePW4FD3qOmyXFKOgYPt
 +MOkOpErT6k1NAXxMklnFeBKRdBtOApZNen/WRTWmfSvYLdluMyQSRsiBbmY2VJ9HMZLv8
 SV2FcXG/l/TwPWUdZcohc15Ec+KaxPM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-F6Acalz4PLiaJLHuprq90g-1; Mon, 20 Oct 2025 03:01:22 -0400
X-MC-Unique: F6Acalz4PLiaJLHuprq90g-1
X-Mimecast-MFC-AGG-ID: F6Acalz4PLiaJLHuprq90g_1760943681
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ee888281c3so8020199f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 00:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760943681; x=1761548481;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ce6a+r2zYEIIak1H9gln/r1PqxxeW1y45sVTsUMR6/A=;
 b=tWRkNjN7klDjoHsjhfK+mIYEpOx61aZEWY0OFv6Ie9TDLVSk5tsPVkm7uiEnf+jD5B
 c9MQGjCYsDqENHNNVPRzvE8qOz4+VU9LViGXRTP6ePKt2sUp5iJB+Jw2gk2lt6J9n1lH
 N0K1cAUPoaUEf5UQpC1zWOWF9ld+2rLFGobHNHnpDfvl2Bh4uzaBWYOTGhRUSP3f8h1u
 X0rw0Ro5lmyVIXj9W32lHXqS1wHklduKdTWGQzWPl5Iyhehm10Zx6ExHRN768r0jy7hh
 kqITPnbkjQ1eozYO7pVG3DG2nMd1BnTTU8OHVrSCOelr+guV2oQHDUe1iWGAS6jsAl2T
 fp5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0mx5yzvXfUPhc29YWlD9TWpGckf7YdoYK/IfvAlyyQsF7PQW/Z+yNm7jwnKc8yEUAV0l//JuGGXSA@nongnu.org
X-Gm-Message-State: AOJu0YwKCXE88JakJIf71O4Wl19FdHh7ZRmQhkfkETstnaVbgBMcbbE+
 GDV4jLgn9XYjCX1XMj4YrgG6ekdYHTRWx53KUzoO9b6uKSU+VnhTP+ZBypJL7wLxWs9c+dFBHBx
 T5Q5iQDfDVdu7GMM4zpOg1NaAV/fabbyD6TJr9Sh4hl/bW/lW6v6qfuXc
X-Gm-Gg: ASbGncsifgxyX6O0bc1+shhjLIVrZ9ryIGgSqZ1NUbH2oX0sQNtzKFX/gekPpHS3O2s
 4tJMTjx5qQrmm1j0lkX6x1GSh5+Nv3QJmRg1QPiUt+T3LrD0yJc8EyRm+L+YTaVU7vsctatwHM+
 16QkXIsVRHZgIemh0Lu9BixMH2Dh//qwDLWSNnklrGtKM0J2WRQAyj9wAhrqhZw9eUUoN+GukvD
 jN0RaYeoPw6Sqi78hFYDAxCENM7tmWZYZu+k77JG3MabB9TqjeG/XKdpyObGR/O/cwsj/MQtqiT
 3DgzqEaolgLS/AwKISzmRqPD/tFoAXbrjTu0mWfKl1lx0Mbw02od7gCgPBYz1toWCkfEZoPYJdV
 dA7knAZoiiA+ffgnIqt7je1bmjfYW7N1ysanNwg==
X-Received: by 2002:a05:600c:1914:b0:471:c72:c7f8 with SMTP id
 5b1f17b1804b1-47117907a52mr82132915e9.21.1760943680676; 
 Mon, 20 Oct 2025 00:01:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwFRZ+B83RzrC86bWjOda8qJxyj+KGyvYv6oZwOW9v29jTlLwH6uqcCHSAGohaDlLgVWuDhw==
X-Received: by 2002:a05:600c:1914:b0:471:c72:c7f8 with SMTP id
 5b1f17b1804b1-47117907a52mr82132665e9.21.1760943680319; 
 Mon, 20 Oct 2025 00:01:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471529598c9sm127838885e9.5.2025.10.20.00.01.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 00:01:19 -0700 (PDT)
Message-ID: <c39e42e8-6956-4279-b9ee-5432d6e42bac@redhat.com>
Date: Mon, 20 Oct 2025 09:01:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] vfio: Add a backend_flag parameter to
 vfio_contianer_query_dirty_bitmap()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com, eric.auger@redhat.com,
 joao.m.martins@oracle.com, avihaih@nvidia.com, xudong.hao@intel.com,
 giovanni.cabiddu@intel.com, mark.gross@intel.com, arjan.van.de.ven@intel.com
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-5-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251017082234.517827-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 10/17/25 10:22, Zhenzhong Duan wrote:
> From: Joao Martins <joao.m.martins@oracle.com>
> 
> This new parameter will be used in following patch, currently 0 is passed.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
> ---
>   include/hw/vfio/vfio-container.h |  8 ++++++--
>   hw/vfio-user/container.c         |  5 +++--
>   hw/vfio/container-legacy.c       |  5 +++--
>   hw/vfio/container.c              | 15 +++++++++------
>   hw/vfio/iommufd.c                |  7 ++++---
>   hw/vfio/listener.c               |  6 +++---
>   hw/vfio/trace-events             |  2 +-
>   7 files changed, 29 insertions(+), 19 deletions(-)


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




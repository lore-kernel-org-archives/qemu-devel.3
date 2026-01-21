Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092E2C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 09:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viULA-00028p-8T; Wed, 21 Jan 2026 04:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1viUL8-00023V-CC
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 04:17:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1viUL6-0004cT-5D
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 04:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768987042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FQrWhWpM75WasJ9TP3ohL3Ur0bYN4zciwHG2ype3POo=;
 b=GYgOxuy6tOP55KzLjcRD0rigKgBgF7mmGLnIhP/z0qN8DIPtGabBpmWl5vJTEOz68Ink0o
 Rvt9JTGGZG0ukP8AmcJar8iUqwDybvcCwszrWP7OR4Io2C1W0TJa1o1ZiSu7rpaimTQICd
 oENedPRoadFHie6v9p0FeSqlNS1/QUA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-7xl-jvz2M4O9Tfar7GLO3A-1; Wed, 21 Jan 2026 04:17:21 -0500
X-MC-Unique: 7xl-jvz2M4O9Tfar7GLO3A-1
X-Mimecast-MFC-AGG-ID: 7xl-jvz2M4O9Tfar7GLO3A_1768987040
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4803e8b6007so10563025e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 01:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768987040; x=1769591840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=FQrWhWpM75WasJ9TP3ohL3Ur0bYN4zciwHG2ype3POo=;
 b=pwMbfS1vOC4L+xv4snhGhvnRpKDITCu0IL1QQaYXdyP6OKPf+1Ngzvve2BJ1lj1+ZH
 XSGEwdFF292koULX3fguyn3k0KIm9WeTKKnJm1Ba2SMVg20oBJV6/YFm28UGODa12L7C
 zfP6Qh73aJAaODur2g8BR3CkADG6HM9z1XCO183FeEezb40Jvlh/BVdQ0ZL/3BHsSf6j
 19Dpr8bTCE/B/B+WSd56IWr03KpSKM4ECfeIi4r0YwwuNdDxuZ0BJs3KP7e9n1dSp6dW
 uRUqrXzkiYs+Ggw3iyUWfBpa5lDwU+Jec2oHk4Z56x2ViC3E/7sLl7v+D9/c21eRnZ4G
 WyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768987040; x=1769591840;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FQrWhWpM75WasJ9TP3ohL3Ur0bYN4zciwHG2ype3POo=;
 b=rXV/sV0nva9qIVBLAX+Cpx0x29ssMy7SY6Jl5vuiGE4UZEG70aZ1dJv9vZLXml9zZX
 PuZwch/3mBUk6kJ407C/Mc3IfM/UPid8cMRYPFKNpUyQR3pYq4n8OAT/Vsy1dcHYyws7
 +Arju8umnMLPQn4HzmMMDmpvvhkeKZuqEZDpvPxHypqvcnDgPhCvVUGGFLkZvhPTxO0U
 qbvd0Aoh79jAqKAZS5qX1RiYqpnvpGImc2xmw08qkQXKLMjBEjfPiRiWJhHoOQOp8xJA
 4YFzVXNFNUgdPBzHx0OkqnM97Cc8ZrXxvAyMORiYf7Q9q+lVN5qcFR4T2ZKfal17tXgB
 aEvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrNgkT2bOdw5yPIxtIGWljXJOiMwoiPXTx8k2ovJPsP0lSngCTKTTzLj5aAbKDfdwDxhOZ7SjmqgGe@nongnu.org
X-Gm-Message-State: AOJu0YxHKWB3ZUyJb2BFXMHhv2uPU44T0TU0ms04VH1zSKbzS0zJmTJF
 dPy3gM7oJgAfoDxvJkyQsneueJjldxPfOQvGn+RqUXrt92AAg+pM6BGoknL6kiy9nOyJtifuyuq
 z/NlSeVtZ6HUczH1txcAJvzHOFJvvBnjgVdbqXQW4QClm6wifsWjTA7/p
X-Gm-Gg: AZuq6aLSiKmBX4EnH+63BLccHMsePGUHpL/Vta08iDhbzLlUe5pXJNGjHLrRxFyAYGE
 /dKCsrEQC+lUgTxSJqt36wN5gvNPYa89HKiyn4d4xs9ilZy+aEznAEoIBGL3hXcH3XT5/2Diy4j
 XaAmZ5RmaI8yaEQFsPJVh8gkviBo+fClUxWr+VwjWx1GhtM1mlqYAdHcJq82JS+xK99r5Zfxwc4
 y4b1nIFHWFKitOU5AL7WVg//FxvO3o5UFSUb+Dv2xL2Oez6pH5v02H3cf7+x2BdvwGxnmNdyWHv
 ZraWpdhi+K0/rKAXShTptIQw/IHUi9IY21GScECxMW16YEAPJZ5/yMrNipvGQ0tcC1MiZ9rdCOi
 tIXRJJi0VQBVv2qcuVf2RyQlvprVpHltrIjetsarRZOmaLQ9H
X-Received: by 2002:a05:600c:8b75:b0:477:b734:8c22 with SMTP id
 5b1f17b1804b1-4803e79b7famr72660125e9.8.1768987039815; 
 Wed, 21 Jan 2026 01:17:19 -0800 (PST)
X-Received: by 2002:a05:600c:8b75:b0:477:b734:8c22 with SMTP id
 5b1f17b1804b1-4803e79b7famr72659735e9.8.1768987039361; 
 Wed, 21 Jan 2026 01:17:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm354931795e9.9.2026.01.21.01.17.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jan 2026 01:17:18 -0800 (PST)
Message-ID: <b2e3728d-90f7-4875-87f0-f55f2e44f0d0@redhat.com>
Date: Wed, 21 Jan 2026 10:17:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio: cpr-iommufd: Fix wrong usage of
 migrate_add_blocker_modes
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>, Markus Armbruster <armbru@redhat.com>
References: <20260121063418.2001326-1-jim.shu@sifive.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260121063418.2001326-1-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/21/26 07:34, Jim Shu wrote:
> The return value of API is 0 for success and negative error code for
> failure. We'll check if the return value equals to 0.
> Also, the MIG_MODE should be CPR_TRANSFER and CPR_EXEC instead
> of 2 same bits.
> 
> The API usage is aligned with 'hw/vfio/cpr-legacy.c' after these 2
> changes.
> 
> Fixes: 3ca0a0ab05c ("migration: Use bitset of MigMode instead of variable arguments")
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>   hw/vfio/cpr-iommufd.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
> index c244db88fbb..6758c73b6b9 100644
> --- a/hw/vfio/cpr-iommufd.c
> +++ b/hw/vfio/cpr-iommufd.c
> @@ -159,8 +159,8 @@ bool vfio_iommufd_cpr_register_iommufd(IOMMUFDBackend *be, Error **errp)
>   
>       if (!vfio_cpr_supported(be, cpr_blocker)) {
>           return migrate_add_blocker_modes(cpr_blocker,
> -                    BIT(MIG_MODE_CPR_TRANSFER) | BIT(MIG_MODE_CPR_TRANSFER),
> -                    errp);
> +                    BIT(MIG_MODE_CPR_TRANSFER) | BIT(MIG_MODE_CPR_EXEC),
> +                    errp) == 0;
>       }
>   
>       vmstate_register(NULL, -1, &iommufd_cpr_vmstate, be);

Reviewed-by: Cédric Le Goater <clg@redhat.com>


Thanks,

C.



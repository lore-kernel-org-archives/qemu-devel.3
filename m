Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E019BCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8kZe-0006l4-3m; Tue, 14 Oct 2025 15:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8kZb-0006hP-RU
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:20:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8kZV-0007pR-IF
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760469631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=odSRJtlmVbY5xpM7FP63AV3QylDOFf2Em/FpHNDFPBo=;
 b=LSDmFjq0yFk7AKF2UO1nDDKtH/V8uA11JNQ24lIewbXp3fWBTuYq00jsrqlq9NnxNJcfiE
 LXapHzK+3/Dp0C2EFi/SjJXj1UMKEd39rqYsIK54sYU8DKIqrpPBkw4U5n9GWFVLJ3aVYO
 0fUa/c3PBPw0TAG+mr0vunj8RmyuqpQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-VB0UFkw9MX-XUztjDFUpeQ-1; Tue, 14 Oct 2025 15:20:27 -0400
X-MC-Unique: VB0UFkw9MX-XUztjDFUpeQ-1
X-Mimecast-MFC-AGG-ID: VB0UFkw9MX-XUztjDFUpeQ_1760469626
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ecdb10a612so660538f8f.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 12:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760469626; x=1761074426;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=odSRJtlmVbY5xpM7FP63AV3QylDOFf2Em/FpHNDFPBo=;
 b=vXdqxYbtk5ve3GDUnH78+V2+0MtQGCimauHYqohuPKJRoFVRwtT8RFJ3nlDhS7FFEA
 P5+QrKUDNlkM7frnfZRZ7nnLmS51h1ShEnxalCKtH/9A37nXOFTCban6kaeNFFGlN8v6
 mqEIy2vzBs5oIgHn/558ZMDWVBBMCODjyoynMg/CTqNpay/gLXruS5EwUpeJ+QnMG4Ve
 hlrJr0oTyIeFzi0iIJlkpSicXij91QCOBYnHOP0GDMGzx7h1KlTgq2kf2yA5kSgW8Jbc
 2ok/b+Nchby7odRSP6L1ip6P+xJMmfEGKv8jS1RgdP/AJ7YH9swXKqSZ4n9Xv4NlLd3T
 A1AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV29gXrtOlEqcwUHrtapUISMaJdkC8vEI7uIhdrTOgMP9gUzVi6dZ5Sw53joMJM++s2xIZ/7/IbSqg@nongnu.org
X-Gm-Message-State: AOJu0YwbGS1lZsmemihSNsCVt5Kn/wE4qYlgCBP4Wv7Fow/yyoNywjT1
 ++HGxqFP4Kfkau+fBPfMJBNgiYkZucPdHkN1tZj4aTbI4Zjg9gRhyXZJ18jjYCj9NaRXNGVikaw
 9qP60zkluMmDLJOk6Nyg6/zTC4/zFrGc3hMB85Cz4v7bnXdlJuo4Lyuxc
X-Gm-Gg: ASbGncsw6yqvdhyufve6PK+lUJlC+s/G01+YrYtmn4s+MUVF6Eqjta5Oo5vqZweEVg2
 QGIOonDQkBLR0UKkQnjPNN7PJSv8SFfCHErvBm+FMdfxNPFQIrkGrpw8Rmg5vohG0iPJ7IWFWrS
 HrC6oMnLpXPVB1AZETanQsGS/BAga6gmmMd24D52C3wtoSd38mAoBm3MoRYv/fks87biDyy20j6
 Huji4PJTqpYgarpEtTIZgvJqeDRGQdjuUY3k2QoyaCwk4zaw7S6BiojwZXaORWYykPkGPPZaS2X
 1rqdNpDVnWlzH0uYpd8mKtrihdSZRRjCPuBNlMv45IWMQi2HHCiY/q33RpFqQK3HwoXOLoL7Ij9
 UKmk=
X-Received: by 2002:a05:6000:22c5:b0:3e7:5e19:5ec3 with SMTP id
 ffacd0b85a97d-4266e7e02dbmr15455731f8f.41.1760469626224; 
 Tue, 14 Oct 2025 12:20:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjo+KtpW6vK9eDPohpl7cCx+RhNEAjIIw4KUNxkI1D3qIPbJ+/Key+7eJ1S0iLSX6No5VUJw==
X-Received: by 2002:a05:6000:22c5:b0:3e7:5e19:5ec3 with SMTP id
 ffacd0b85a97d-4266e7e02dbmr15455721f8f.41.1760469625833; 
 Tue, 14 Oct 2025 12:20:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57cce5sm25668561f8f.1.2025.10.14.12.20.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 12:20:25 -0700 (PDT)
Message-ID: <0810aee1-b57d-4682-9455-92b1c8dd5715@redhat.com>
Date: Tue, 14 Oct 2025 21:20:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vfio: only check region info cache for initial regions
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org, qemu-s390x@nongnu.org
References: <20251014151227.2298892-1-john.levon@nutanix.com>
 <20251014151227.2298892-3-john.levon@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251014151227.2298892-3-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/14/25 17:12, John Levon wrote:
> It is semantically valid for a VFIO device to increase the number of
> regions after initialization. In this case, we'd attempt to check for
> cached region info past the size of the ->reginfo array. Check for the
> region index and skip the cache in these cases.
> 
> This also works around some VGPU use cases which appear to be a bug,
> where VFIO_DEVICE_QUERY_GFX_PLANE returns a region index beyond the
> reported ->num_regions.
> 
> Fixes: 95cdb024 ("vfio: add region info cache")
> Signed-off-by: John Levon <john.levon@nutanix.com>


Cc: qemu-stable@nongnu.org

> ---
>   hw/vfio/device.c | 27 +++++++++++++++++++--------
>   1 file changed, 19 insertions(+), 8 deletions(-)
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




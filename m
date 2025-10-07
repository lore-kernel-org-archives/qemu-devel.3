Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA90FCCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 20:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6EOR-0003oq-OM; Tue, 07 Oct 2025 16:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v6EOH-0003l2-I6
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:34:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v6EO9-0001Ps-7g
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759869261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Z5S8IGHTQa2sNKIAirWuwXw8AOD4Z9h+xYZj6llT9aE=;
 b=QxKm6E1LFzmuwZa+Vbrf/ecwaAuXsrQj0V2a5Y8EfyvGjH2uqRnvIKIXDRwqd6E8umdO9W
 ApK9btsHe2dfbmdmsVWkVYIDwWJOPFyqtQSgKAhXwD2dY173tt3nF0krs1vsjt1p6gpP34
 dda8/DGUE//v622QNVpqtddVpfBvUfY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-ocuK-iUWOMCJZBJhgnRUOA-1; Tue, 07 Oct 2025 16:34:19 -0400
X-MC-Unique: ocuK-iUWOMCJZBJhgnRUOA-1
X-Mimecast-MFC-AGG-ID: ocuK-iUWOMCJZBJhgnRUOA_1759869258
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e4c8fa2b1so28558425e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 13:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759869258; x=1760474058;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z5S8IGHTQa2sNKIAirWuwXw8AOD4Z9h+xYZj6llT9aE=;
 b=IAZ6U0icHHlQbVm0IEMjW32+3/9tOj3eUC1k2quD6gdT0YVDGZkHjwVHWfP74GVPbQ
 gWtoaugnkmeriKV6Kg0ZESgyTjJhANs5XEUwGPaxIBZgQwWRSOIWm1cHMcwUAbRJUrxO
 vuvDqnOguqf82K30ZU2Qh7Wx6SB0spIlpw2dUsJ+vciIxpXDhOI6ED5EBWmzOuZ6ztK/
 F946rjiQx184HbNHPhIOsG4xrCwf58ZqD6S9mzVQ4mO/JKP1gcxyC6B5z+9frCRoZbhB
 QQ/R7UULiG6I9ztheMaGDCkR4soC6Gahh88j3pht20DKXTsMGHoVppvoGP8CpJbm1QzX
 BFJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjAE7n17euFzZvTjqfKQwTwbQGH+S+1I/MzOxIuNQZuxauRMncF7yrzUYEv0r0NhIPsHsGvbtx0Jgh@nongnu.org
X-Gm-Message-State: AOJu0Yx78y2y4U6Vj8a03lHGnkgB3XN4VtyKOLJTbpQyL/Y2yZuwWAtY
 4SXungA43rLMya9FDgvKe7P6UcS3bEHJxkKUuUbn/hM3i4oKHAmMzYuE2GrXQfYAhj4RKbEjtHO
 cZpekbc7cD+yzvrYhGMIsEeI43eGt4cvcbU2q95fdDjmxnOG+Zx3uCQgh
X-Gm-Gg: ASbGncvwwp6mBq7ixak5erixJsR2L9aOtd2ZZ0JVo/pUPSAS1N18CxEnS3v8WV+mDvw
 Z83etoBSumldVTNhzFrqt9u9wDv/51QExmlYR8QUU0lW+oa+GLqGGnxIID78I79p+gv+/nC6gKP
 WObDKJClcEvpMgwrYEKmZJCUSa6y+pOzv3ILBrTHXS/UUQLQUsnm7MYcwOk0BRnX1z/DnF4cNXv
 VNZcUXzv+anYkkz0RSsXC4CpvIXvk0PxLY1YIUgewnAuo76gjmLN+UnKDOV8c5FKjEYythtsKFG
 eZNVw0/KQFcD0rhfNkebkTaDWXlFn5s3l3oKJuZWYFcpgxSxCUClNSEVFK2TgREj+1st3ugNaiB
 TMw9Y/5Nj
X-Received: by 2002:a05:600c:46d1:b0:46e:36f8:1eb7 with SMTP id
 5b1f17b1804b1-46fa9a98e73mr6767395e9.10.1759869257966; 
 Tue, 07 Oct 2025 13:34:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLKPWctNW/J0wsJmQ9OZv1xmFjcYnF3Nq0n7lRbDBbgs2xrdRl6wYy3esE3Rb9CI3CNOTD3w==
X-Received: by 2002:a05:600c:46d1:b0:46e:36f8:1eb7 with SMTP id
 5b1f17b1804b1-46fa9a98e73mr6767265e9.10.1759869257580; 
 Tue, 07 Oct 2025 13:34:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f02a8sm27268602f8f.39.2025.10.07.13.34.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 13:34:17 -0700 (PDT)
Message-ID: <c5669458-a57e-4d95-9f73-18892dbd5c18@redhat.com>
Date: Tue, 7 Oct 2025 22:34:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update entry for AMD-Vi Emulation
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 qemu-devel@nongnu.org, mst@redhat.com, sarunkod@amd.com
Cc: philmd@linaro.org, clement.mathieu--drif@eviden.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20251007182951.1284171-1-alejandro.j.jimenez@oracle.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251007182951.1284171-1-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

On 10/7/25 20:29, Alejandro Jimenez wrote:
> Add myself as maintainer and Sairaj Kodilkar as reviewer.
> 
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>   MAINTAINERS | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 75e1fa5c307ea..08de896ca942a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3891,8 +3891,10 @@ F: tests/functional/x86_64/test_intel_iommu.py
>   F: tests/qtest/intel-iommu-test.c
>   
>   AMD-Vi Emulation
> -S: Orphan
> -F: hw/i386/amd_iommu.?
> +M: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> +R: Sairaj Kodilkar <sarunkod@amd.com>
> +S: Supported
> +F: hw/i386/amd_iommu*
>   
>   OpenSBI Firmware
>   L: qemu-riscv@nongnu.org


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




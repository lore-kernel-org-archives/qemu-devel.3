Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015DCC3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFCOZ-0001Q8-6L; Wed, 14 May 2025 09:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uFCOX-0001PV-P8
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:43:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uFCOS-0008Jf-1c
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747230205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wVeA15JjBG1Z3rVOep18THL7YrFTvml76cJ1Cr/Fiv8=;
 b=eIUntIaGq9WPLoWTkwIudsal43jXFv1NGYWcISZu4c+4fBa/2PV+olVMFlVUF6rKnarE5L
 ZY98/QUgwwgDbcnxWSE2Rge71Upzq6GkZMsZgnHYxiShapTIh80ocEbjO3GrmuK6YC6f5m
 G0OffElkrgilgDePNA7TB7Ar0Ieez6k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-at4x2fiPNPOJIV-47o1JoA-1; Wed, 14 May 2025 09:43:24 -0400
X-MC-Unique: at4x2fiPNPOJIV-47o1JoA-1
X-Mimecast-MFC-AGG-ID: at4x2fiPNPOJIV-47o1JoA_1747230203
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cec217977so34663355e9.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 06:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747230201; x=1747835001;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wVeA15JjBG1Z3rVOep18THL7YrFTvml76cJ1Cr/Fiv8=;
 b=ClqwWII9iBx2Y+avLcmhu3dUP+BwdNXhcJnkAK57nSTVlVan0a/kthDIp2E75nWxqk
 8h/5NguJZ3NWvEjoB2VZ4j1bicUN9+Qo5DfIa84yVR8G70PKIRyrJKIokjcmxM5D62F2
 lOp718JbjXF7G1FNouInybexubfS3r9WOu7PEl4kasEYaCp80+/USrVferaVNhwzq63s
 3gFP5ik25pPD7SUVo4GqCB+UsvyrlUMuQPOa+9CsEoYnaguQWUJIOOcp1qemC5s568Ue
 fUHHCBNzm5WQNgLTOzBNgcsvOjkBxOm2j6VNzjTtXB9JZU5hPYP4nrgM9G1UWfQt5GJ5
 /w4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEbNAbsSnxOsFWqHgdXDIzKg5j9JrFvblHCNr+rn67ivY6CP5i2IRq0XtQQSDD3Ixj48sjublLid75@nongnu.org
X-Gm-Message-State: AOJu0YwvQeT7rzHURrM+9X9JWRPlEMHgjUmpPzfF/YfMXrGxBM63KVp2
 9dISG76UO+SvJQd+hM+xZp4sCLAJqpmZHf1HNsD7mTID2XPlduR2ueRCBeyBzGq+JSZGkWpOdq4
 +VP1MNNlBxhg9l6zvUzH9hth31Vy4WM5ocuWTHSeGqaUjJbvMTBAv
X-Gm-Gg: ASbGnctdsP6zo/VCY1WSC0Hjx9nxZi2/NZHtZm1e25biarbXxRhYfbXkJAsQKabMmT1
 253oLmieGH6xH9P3egbYprVqLNicnn8+ZgAvvnP+brJicagAg7OoiiSWLGQzlvC3grH1t4hULQe
 X2ZSIN/tfscbOmrDT9uL5jnc7uhJH+eTa7jFc0QtuAhQ0eKfuQycOLuD/5/jhfvRG4EIBA6TNnw
 kLj3E/SNOgRWTkI8shZeJ1r+zjsbWnZlBKPddVnmZLi+XOBVBSoYWSVM/j+U5H9uMG5sQp9OGJO
 y8H2S9Z6tvm8EpORZGF0ZjuLGZRmdn2qTeqj6kUKcEzCgsTvaqeuYIOMcdFVqb7vtb8SilIg4ms
 qGkdoK/dlYevxdiu2qFpkkGjVJHhQk9pBes/DQ57l
X-Received: by 2002:a05:600c:a09:b0:43c:f513:958a with SMTP id
 5b1f17b1804b1-442f20d65f9mr30132105e9.13.1747230201572; 
 Wed, 14 May 2025 06:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwYzMoUgF50d2lh6eODwOZwOPUgoGsy2/S17cRM3NndSDMcoyZTOKc7f8W51kHhFMY2f3NWg==
X-Received: by 2002:a05:600c:a09:b0:43c:f513:958a with SMTP id
 5b1f17b1804b1-442f20d65f9mr30131855e9.13.1747230201145; 
 Wed, 14 May 2025 06:43:21 -0700 (PDT)
Received: from ?IPV6:2003:cf:d728:a0e0:44e3:3ed5:b7d1:f2e5?
 (p200300cfd728a0e044e33ed5b7d1f2e5.dip0.t-ipconnect.de.
 [2003:cf:d728:a0e0:44e3:3ed5:b7d1:f2e5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f395096csm30767415e9.18.2025.05.14.06.43.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 06:43:19 -0700 (PDT)
Message-ID: <ce352802-6951-4249-a806-2e0b1ea9d5f2@redhat.com>
Date: Wed, 14 May 2025 15:43:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] file-posix: Probe paths and retry SG_IO on potential path
 errors
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, bmarzins@redhat.com,
 qemu-devel@nongnu.org
References: <20250513113730.37404-1-kwolf@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20250513113730.37404-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 13.05.25 13:37, Kevin Wolf wrote:
> When scsi-block is used on a host multipath device, it runs into the
> problem that the kernel dm-mpath doesn't know anything about SCSI or
> SG_IO and therefore can't decide if a SG_IO request returned an error
> and needs to be retried on a different path. Instead of getting working
> failover, an error is returned to scsi-block and handled according to
> the configured error policy. Obviously, this is not what users want,
> they want working failover.
>
> QEMU can parse the SG_IO result and determine whether this could have
> been a path error, but just retrying the same request could just send it
> to the same failing path again and result in the same error.
>
> With a kernel that supports the DM_MPATH_PROBE_PATHS ioctl on dm-mpath
> block devices (queued in the device mapper tree for Linux 6.16), we can
> tell the kernel to probe all paths and tell us if any usable paths
> remained. If so, we can now retry the SG_IO ioctl and expect it to be
> sent to a working path.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/file-posix.c | 82 +++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 81 insertions(+), 1 deletion(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>



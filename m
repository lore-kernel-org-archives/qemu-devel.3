Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2363E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 08:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ09L-0004ea-R1; Tue, 24 Dec 2024 03:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ09J-0004e9-3U
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 03:20:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ09H-0007pQ-4I
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 03:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735028413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B0/7WLmNZIb4BFkLWJnkxUMOoSDrqddEJZybQFxRkQM=;
 b=JlwpiFisqBy40iZXJataC9kyfrxRuYSrugkDsh/SuI7Y/a+ap3YDselYwLoXLlo34HCqcL
 PVeeO7cy4wisJRwWSe7YZh+VbVHD3MCJWXpM20uPBZn12BUHmKhvLf+Yt3CPDDEFqgwDo3
 hkFtoydNjW6CrWWwMn8yK3oCHbudjmY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-kTO0OsrbOTaE2eUxv8QpPg-1; Tue, 24 Dec 2024 03:20:11 -0500
X-MC-Unique: kTO0OsrbOTaE2eUxv8QpPg-1
X-Mimecast-MFC-AGG-ID: kTO0OsrbOTaE2eUxv8QpPg
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6dd43b16631so21156686d6.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 00:20:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735028411; x=1735633211;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0/7WLmNZIb4BFkLWJnkxUMOoSDrqddEJZybQFxRkQM=;
 b=CWvwJni1Qjlgf0VMM5EPjtVcaTBbZ8ia2J3gDouav9LHzLNmBg0Odt5ey7l9oObjHz
 aoz0J7SbGtP1F8VYYjRug8394iFR5kTdJ1XwVGvHoOVhRfBn5R1I6MUDE+25blC34ozy
 KM6vnH0WAB9XAAl277tHMEGhxXLrbW3c6GR7KP5X/B68bxOl3sUZeavCdqmzlmym9yz6
 QsePGTHZTBOAuGt40cZuAjGRHVV7NPG0J6z80rzMtLJX3W/JfMK21C8XE3y210txV3o7
 TWbYR5kxvMqrYpxAyw5vpASH2vCS75e5mxc5UAJRFXXmOjIFaBeMGY2XmKhmPQAB/Bu4
 Q8sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW198v5bCZfbfmdk5qsxinTg//QoxbaZAOGP+w8hl+eXs466hS+CeNllXQjAbbgdE7GGg8KPWVbVB95@nongnu.org
X-Gm-Message-State: AOJu0YwB7G1YjFmjZs86b3rZWFatVeyu2oHmOpuXCkJX8S8wQZbhz1Zh
 uciQrwKdFfEQmuF5uuITbYr1FkIy0btRWdIv/YfrSln3O5xZj8S0CB0p0wDnD9UWfoJLnstecXB
 QRkhLbhONVmnfd5O9LTOqlm2/SXWhSFSKZUgo56Hl8ifr7PiCQTQy
X-Gm-Gg: ASbGncuN602o/PP/wsQ33St32ytFRZxN0i/DW/B3G8pawhFp6x0osfkQyGmnYPaETYv
 EwUWe+rhEp7NyLi7u+2XidBsSlgSFUUL2hIHKMha5Zh1muk5ADtmLfRxBs9iELs289oC2cTdyqx
 L+NbvYAXzS6KaHxlm4I95UIDsIIoGrKBJtRYhYcJOFa08kPsiJeNODUIwBSzGwHkQd1vlsZyQkk
 98x9Z/GzM9fL/IKJ8Phzc8NEYX17UTHoCpl6uRdYgw5cobPzc7mNOIEJX+AxZ9bopSikBbA/M0z
 b5LZ3isSUbLIbS/g
X-Received: by 2002:a05:6214:4290:b0:6d4:1a42:8efa with SMTP id
 6a1803df08f44-6dd230cbcabmr252611486d6.0.1735028411216; 
 Tue, 24 Dec 2024 00:20:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVeTdDGiU/7XuyT35ZWr51N61wNR3kXWDpRweNRyFi1x+XJHBSqSUnI1D3wTBp3FhBYjvQkw==
X-Received: by 2002:a05:6214:4290:b0:6d4:1a42:8efa with SMTP id
 6a1803df08f44-6dd230cbcabmr252611186d6.0.1735028410834; 
 Tue, 24 Dec 2024 00:20:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d82fbsm51105496d6.123.2024.12.24.00.20.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 00:20:10 -0800 (PST)
Message-ID: <7e89a423-14ef-4b6e-b1ae-9b2e6e947a38@redhat.com>
Date: Tue, 24 Dec 2024 09:20:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] migration: Drop/unexport migration_is_device() and
 migration_is_active()
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Joao Martins
 <joao.m.martins@oracle.com>, Maor Gottlieb <maorg@nvidia.com>
References: <20241218134022.21264-1-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20241218134022.21264-1-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fabiano, Peter,

On 12/18/24 14:40, Avihai Horon wrote:
> Hello,
> 
> This follows up on Peter's series [1] to simplify migration status API
> to a single migration_is_running() function.
> 
> Peter's series tried to drop migration_is_device() and
> migration_is_active(), however VFIO used them to check if dirty page
> tracking has been started in order to avoid errors in log sync, so they
> couldn't simply be dropped without some preliminary cleanups.
> 
> This series handles these preliminary cleanups and eventually drops
> migration_is_device() and unexports migration_is_active().
> 
> The series has been migration tested with the following:
> - VFIO device dirty tracking.
> - Legacy VFIO iommu dirty tracking.
> - vIOMMU + Legacy VFIO iommu dirty tracking (migration with vIOMMU is
>    currently blocked, so I used a patched QEMU to allow it).
> 
> I also tested calc-dirty-rate as now VFIO dirty pages should be included
> in its report, and indeed they are.
> 
> I didn't test it with iommu DPT as I don't have access to such HW.
> It would be great if someone with the proper HW could test it.
> 
> Patch structure:
> 1-4: Refactor and clean up VFIO dirty page tracking helpers.
> 5: Refactor dirty limit code.
> 6-7: Drop/unexport migration_is_device() and migration_is_running().

I can take these migration changes through the VFIO queue.
Is that ok for you ?

Thanks,

C.




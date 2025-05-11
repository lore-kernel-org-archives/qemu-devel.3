Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81A5C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 18:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEBTD-00027D-Kx; Sun, 11 May 2025 14:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEBSx-00023u-Oh
 for qemu-devel@nongnu.org; Sun, 11 May 2025 14:32:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEBSt-000420-O1
 for qemu-devel@nongnu.org; Sun, 11 May 2025 14:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746988313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=md9tO/JYhmqs8ItlOqizpA5dP+fNACJdsyw6gCP0azQ=;
 b=E3EEbhtwhO722wfbYWMi45EoqeRFRFQwIv8czylm1AzO8bQXr6/9p3J4koum5jUZ62nvBj
 8TM+Fkv9ULIrRkiUE+db1e5KBFoJPljO7svz6W1zjUKGV391a9mdUtQ3E46GOLko4hBcyr
 uQGUctNt3/vOu6NOugW77z6y6O9u8VQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-9d_V_o4XP0qYtnIWvEcdjg-1; Sun, 11 May 2025 14:31:52 -0400
X-MC-Unique: 9d_V_o4XP0qYtnIWvEcdjg-1
X-Mimecast-MFC-AGG-ID: 9d_V_o4XP0qYtnIWvEcdjg_1746988311
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so13948415e9.2
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 11:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746988311; x=1747593111;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=md9tO/JYhmqs8ItlOqizpA5dP+fNACJdsyw6gCP0azQ=;
 b=eIVtcgJGbE29qsgrIE0vmOB5GegL8oOXa7P+nyyU2N3pg0GYpt/Jd1sEBKa7Z6wNva
 cIXfwRnlE9TMyeoXte/PYpVZ0rZJS/yzxT6MO+wtzsfXuBwfpWvPaosH7wA0o3zH4vad
 0Di3v1O5OlaY7nXWacvnP1HsiswZGxPgSJzICJ0wccNVwMHHQo8nNPEqwOYr8Zu9qKIa
 mgghndztmRcLLyoKuYs+aiMnR+qTvQbS0mpf1dHlLpJvwr+ZLya47oaCuiWeJcTgWHhE
 e4o0CVZtVGOW6zdN6RyFU52nnm2jS0SkmWOgjdWfaqFowI9m8zVPQYnbh6fGSuV46/q6
 DYxQ==
X-Gm-Message-State: AOJu0YxXFgvx6oPkKt1ww8CCnO21eN/dCJT+yn859mAYUS/sUOaoascp
 +B0mAjUpF+z5O1ESaWMeiNaxrGFA92U9LoeZ49qn+W+x0Ai3o2STCMPyJvn8qsHimrsR/iakSaz
 E/+6ilK/oNKe7yHG48Ewcu7zayp0mns+NGB5EdklU0yJg+jzNW9ML
X-Gm-Gg: ASbGncvoz0JtTfY95NclNGnJjCPuOY3yT77oDERTyvkQH5tbTUgp8IbE9k7x2vRheVV
 7DdlWX8BYsq5o7SCijCT3uPSO2LcHGmJEIHji8Y4GUxFGPLsdLFQwv5G3Nezyvlr84DHYzcBBec
 rIPsC+Xioa6cqiR23zgowAFpDbrnZn3NTCQZsFLDuZ/GmbKa94emL2jRCbM8cqrJTq4eQtOrBfb
 z7YkJlEC/bYHyUDikPZEkz3tqmumQBS8xt+M7hysFt4ahG5E/dttE1alakA5NEdobY0tsyIDLyn
 7Kq6CQ==
X-Received: by 2002:a05:600c:a44:b0:43c:ec4c:25b1 with SMTP id
 5b1f17b1804b1-442d6dc5328mr76917205e9.23.1746988311205; 
 Sun, 11 May 2025 11:31:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGRX/u3lhHRbxQfvbmI+OJsQWb1aJ8HlgFvToxHC5hDUwQcuEwyNnlJjaiHwS/dRw183d5TA==
X-Received: by 2002:a05:600c:a44:b0:43c:ec4c:25b1 with SMTP id
 5b1f17b1804b1-442d6dc5328mr76917085e9.23.1746988310857; 
 Sun, 11 May 2025 11:31:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3aeb26sm143270125e9.29.2025.05.11.11.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 11:31:50 -0700 (PDT)
Date: Sun, 11 May 2025 14:31:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 clement.mathieu--drif@eviden.com, ethan.milon@eviden.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 01/20] memory: Adjust event ranges to fit within
 notifier boundaries
Message-ID: <20250511143114-mutt-send-email-mst@kernel.org>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-2-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502021605.1795985-2-alejandro.j.jimenez@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, May 02, 2025 at 02:15:46AM +0000, Alejandro Jimenez wrote:
> Invalidating the entire address space (i.e. range of [0, ~0ULL]) is a
> valid and required operation by vIOMMU implementations. However, such
> invalidations currently trigger an assertion unless they originate from
> device IOTLB invalidations.
> 
> Although in recent Linux guests this case is not exercised by the VTD
> implementation due to various optimizations, the assertion will be hit
> by upcoming AMD vIOMMU changes to support DMA address translation. More
> specifically, when running a Linux guest with VFIO passthrough device,
> and a kernel that does not contain commmit 3f2571fed2fa ("iommu/amd:
> Remove redundant domain flush from attach_device()").
> 
> Remove the assertion altogether and adjust the range to ensure it does
> not cross notifier boundaries.
> 
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Looks legit:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

can we get an ack from memory API supporters?

> ---
>  system/memory.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 71434e7ad02c..7ad2fc098341 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2021,13 +2021,9 @@ void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
>          return;
>      }
>  
> -    if (notifier->notifier_flags & IOMMU_NOTIFIER_DEVIOTLB_UNMAP) {
> -        /* Crop (iova, addr_mask) to range */
> -        tmp.iova = MAX(tmp.iova, notifier->start);
> -        tmp.addr_mask = MIN(entry_end, notifier->end) - tmp.iova;
> -    } else {
> -        assert(entry->iova >= notifier->start && entry_end <= notifier->end);
> -    }
> +    /* Crop (iova, addr_mask) to range */
> +    tmp.iova = MAX(tmp.iova, notifier->start);
> +    tmp.addr_mask = MIN(entry_end, notifier->end) - tmp.iova;
>  
>      if (event->type & notifier->notifier_flags) {
>          notifier->notify(notifier, &tmp);
> -- 
> 2.43.5



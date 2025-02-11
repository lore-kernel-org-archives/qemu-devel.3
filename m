Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE416C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 22:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thyrL-0000x5-Gv; Tue, 11 Feb 2025 17:36:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thyrJ-0000wZ-2L
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:36:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thyrB-0000fr-Bs
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739313350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AQmLFir4UkEGYUUsaqSF/TAOnlHne0O7Pyi3Uz6Gm6s=;
 b=QmPSfKUPEzpS5S8KwQAh/2R4PaNjZ/uW5qWXA+gJSOVJhRI05zOcp8uEfixVXXGinhEDes
 g/TrqvbR+ho+iUTZ1wAoYuyGp0JEgJjfXbhnoOc9QVfS7KRo19AHIAUpOOLrgmyKJgHrfs
 xSplmJgsxXOBHVTBvCQNsaHq84g0MGc=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-6kt0exFXPmyslSzQlXuclA-1; Tue, 11 Feb 2025 17:35:48 -0500
X-MC-Unique: 6kt0exFXPmyslSzQlXuclA-1
X-Mimecast-MFC-AGG-ID: 6kt0exFXPmyslSzQlXuclA_1739313348
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3ef3847424aso6703256b6e.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 14:35:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739313348; x=1739918148;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AQmLFir4UkEGYUUsaqSF/TAOnlHne0O7Pyi3Uz6Gm6s=;
 b=RvY1L77qp+F/BP+n6ps+wMSmnpqtJgKWXEplRKQlNoMDqpojLKhNd8fvg4EGjrqy2I
 JVPFv+u/aw10a0Ta5Zh0bDzjS19tiJbp6tcCqtucLli/o3SMdvcH8y6HEw87d/R4+LwB
 /cbpw81nHhsQUdzFJ+32eHf474LFk2jADndxHuFXLahprVizQ6Z05+t9jzyI9wBsDS1G
 A/H0YCGIY9nf0+KGsnq8e/k5EeVnmlueJwNGG7NLNbj9SgKT/gXQNmNWlznmbcmQv2L5
 dVp/xweQPd2QuZO7/crQwuvi4TkQ40r04T5uKqJ8ti2CKYfEQJw3LoZaLl10+4QPs+O+
 ujGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXWpwHzJxP3Ghs7llu3G3w8/iuj1ettdjkTEiHnWwwIuaydUj34UUYPVthTZJirG9vDC6EghU/fdoV@nongnu.org
X-Gm-Message-State: AOJu0YyXo4ioQaYuKPYQHaYYu811AxDhRYifszFOWnYwfVaafPHmck58
 c8MMp7uYUqBHN2CDf+KpH4Mgiewp9JUn64GFrR1AuClgTUu1dMFsTpU5ADIYfCvBbK7wJKh58Z5
 c68hqf3eLv6Spy7r9qItI4YtQr1mrSMS3jv2GAf81TNclcaBBa74t
X-Gm-Gg: ASbGncsc2CkVy8UDS21O1jd8+FGIsOtjAu1lCxGPtwpCXYlfUo7GEbu6uKVe00j2ABY
 xBtm56FKpXdGGaXi+qbJvzNHegf0+B6VUwEwzYfnRjoZnqNhORCmOUrd0cH13cfbJFDNQKvBzwD
 uIbQ8yNA5GqV9RnwMRSCi3u4wYME62vqtL+a/ZML6eb8851g8yJ39pq3gvtYYp183Q6j93J3dcU
 UcQ3OHEbk/H0cZjrmdm0rtuccjwCIduGT7HjznZD2KJvtOx6/Z5tWLr9pI=
X-Received: by 2002:a05:6808:80cc:b0:3f3:b0ae:7998 with SMTP id
 5614622812f47-3f3cd601076mr1099272b6e.17.1739313347846; 
 Tue, 11 Feb 2025 14:35:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtm+HslfUZKczOhDisXpbAz9Wg8zd23YUSu/nhTnz2WuQo5SFimH65ggUbt/iDHmN7BQOJCA==
X-Received: by 2002:a05:6808:80cc:b0:3f3:b0ae:7998 with SMTP id
 5614622812f47-3f3cd601076mr1099254b6e.17.1739313347528; 
 Tue, 11 Feb 2025 14:35:47 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f389efebe9sm3576089b6e.27.2025.02.11.14.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 14:35:46 -0800 (PST)
Date: Tue, 11 Feb 2025 17:35:42 -0500
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?=E2=80=9CWilliam?= Roche <william.roche@oracle.com>
Cc: david@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, joao.m.martins@oracle.com
Subject: Re: [PATCH v8 0/3] Poisoned memory recovery on reboot
Message-ID: <Z6vQvr4dCCsBR2sX@x1.local>
References: <20250211212707.302391-1-william.roche@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250211212707.302391-1-william.roche@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
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

On Tue, Feb 11, 2025 at 09:27:04PM +0000, “William Roche wrote:
> From: William Roche <william.roche@oracle.com>
> 
> Here is a very simplified version of my fix only dealing with the
> recovery of huge pages on VM reset.
>  ---
> This set of patches fixes an existing bug with hardware memory errors
> impacting hugetlbfs memory backed VMs and its recovery on VM reset.
> When using hugetlbfs large pages, any large page location being impacted
> by an HW memory error results in poisoning the entire page, suddenly
> making a large chunk of the VM memory unusable.
> 
> The main problem that currently exists in Qemu is the lack of backend
> file repair before resetting the VM memory, resulting in the impacted
> memory to be silently unusable even after a VM reboot.
> 
> In order to fix this issue, we take into account the page size of the
> impacted memory block when dealing with the associated poisoned page
> location.
> 
> Using the page size information we also try to regenerate the memory
> calling ram_block_discard_range() on VM reset when running
> qemu_ram_remap(). So that a poisoned memory backed by a hugetlbfs
> file is regenerated with a hole punched in this file. A new page is
> loaded when the location is first touched.  In case of a discard
> failure we fall back to remapping the memory location.
> 
> But we currently don't reset the memory settings and the 'prealloc'
> attribute is ignored after the remap from the file backend.

queued patch 1-2, thanks.

-- 
Peter Xu



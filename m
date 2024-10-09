Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6771CCEE322
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYtG-0004Ui-5P; Wed, 09 Oct 2024 11:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syYt2-0004T6-CE
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:46:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syYsy-0003nj-QT
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728488756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PlzQWPOjYSNkzCN9W8sMelrGptif3yHwA7aQv3qQb94=;
 b=KLHeF2zMhJZEJSLK4urbaOCVgVOtMK1Huhj563n461Hv3SCs6SrFeuRR2htHigqDkx1Joc
 dkPC5ZtjsfLK9ooUtpcaHFyin44ya13ZNnDS31HCv1fNaIuCvvA9E2YqAEGCg4FtB5LE7b
 D64Efo2ndf00i+uDunhC77XBVxsevr8=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-147jcR3kMk-GjfQ5qzBVMQ-1; Wed, 09 Oct 2024 11:45:53 -0400
X-MC-Unique: 147jcR3kMk-GjfQ5qzBVMQ-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3e4d719c73aso79989b6e.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728488752; x=1729093552;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PlzQWPOjYSNkzCN9W8sMelrGptif3yHwA7aQv3qQb94=;
 b=agALoNzkOrs4MDMOvpArNsgYraIVmqFH8belGp2oCqaVVS+07MF4xHlCfrF2EKWcJ6
 Pdqk9H/lWHDorDzCX7ZiD0f+jg4r/ymOY35N4s+nHoNJtIVKhmpuWktjkonLvYNKlm9/
 zvtOaGeERr8DXa0g8MfwYaEQEu3dRwxeu1gYn5vLBg3qBVhgFLWAr2W0BqS5sCJ8bnTF
 75+wlnwNQUGxy1xFK6GipfLAzC3kOCJrX4fVp7t4xx6U3c0DL5f/Qeu35a67YEmO51Pz
 cMN0rTG/GXnl810uaUnGQyeOqpB/dtjT1ekjmdijojQ/hBg3R527b/nna9nZPPGe8dhd
 /3Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaSMD52TXqpAA+CdqI5IOdVkajzR8BeQLRrFNaiqxheukbHzNorqGN8CVinxKpjZ90spP5XwY4EraZ@nongnu.org
X-Gm-Message-State: AOJu0YzZezlXhCnDU1UcTToTyn4GG/Ie4D2o1+7UmdpL3+rFtIIUnmL4
 2Rx/mUOp9EWKp/uabiW0rY1DFnhkTN8yu8H0HwkWnmnJDnVpyiyF9B0o9Yq+S0NnGV7q2fnWsGf
 s0iAJAhdnKCJQBJddasULHDJOF0ISIfsHJ0i8nfVMGVd15ZjivExM
X-Received: by 2002:a05:6808:151e:b0:3e3:9721:4ced with SMTP id
 5614622812f47-3e3e67463e8mr3310052b6e.40.1728488752443; 
 Wed, 09 Oct 2024 08:45:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR8gQvAV8ArRtq51PGblZVCF4q4BulbMX3U3jI9+d4j+KrG2IxEICdXaQ+KderMMs9CVfK3g==
X-Received: by 2002:a05:6808:151e:b0:3e3:9721:4ced with SMTP id
 5614622812f47-3e3e67463e8mr3310012b6e.40.1728488752092; 
 Wed, 09 Oct 2024 08:45:52 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6c46a20sm7429373a12.76.2024.10.09.08.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:45:51 -0700 (PDT)
Date: Wed, 9 Oct 2024 11:45:47 -0400
From: Peter Xu <peterx@redhat.com>
To: William Roche <william.roche@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, pbonzini@redhat.com,
 philmd@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, mtosatti@redhat.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 joao.m.martins@oracle.com
Subject: Re: [RFC RESEND 0/6] hugetlbfs largepage RAS project
Message-ID: <ZwalK7Dq_cf-EA_0@x1n>
References: <20240910090747.2741475-1-william.roche@oracle.com>
 <20240910100216.2744078-1-william.roche@oracle.com>
 <ec3337f7-3906-4a1b-b153-e3d5b16685b6@redhat.com>
 <9f9a975e-3a04-4923-b8a5-f1edbed945e6@oracle.com>
 <cf587c8b-3894-4589-bfea-be5db70e81f3@redhat.com>
 <966bf4bf-6928-44a3-b452-d2847d06bb25@oracle.com>
 <0ef808b0-839d-4078-90cb-d3d56c1f4a71@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ef808b0-839d-4078-90cb-d3d56c1f4a71@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 19, 2024 at 06:52:37PM +0200, William Roche wrote:
> Hello David,
> 
> I hope my last week email answered your interrogations about:
>     - retrieving the valid data from the lost hugepage
>     - the need of smaller pages to replace a failed large page
>     - the interaction of memory error and VM migration
>     - the non-symmetrical access to a poisoned memory area after a recovery
>       Qemu would be able to continue to access the still valid data
>       location of the formerly poisoned hugepage, but any other entity
>       mapping the large page would not be allowed to use the location.
> 
> I understand that this last item _is_ some kind of "inconsistency".
> So if I want to make sure that a "shared" memory region (used for vhost-user
> processes, vfio or ivshmem) is not recovered, how can I identify what
> region(s)
> of a guest memory could be used for such a shared location ?
> Is there a way for qemu to identify the memory locations that have been
> shared ?

When there's no vIOMMU I think all guest pages need to be shared.  When
with vIOMMU it depends on what was mapped by the guest drivers, while in
most sane setups they can still always be shared because the guest OS (if
Linux) should normally have iommu=pt speeding up kernel drivers.

> 
> Could you please let me know if there is an entry point I should consider ?

IMHO it'll still be more reasonable that this issue be tackled from the
kernel not userspace, simply because it's a shared problem of all
userspaces rather than QEMU process alone.

When with that the kernel should guarantee consistencies on different
processes accessing these pages properly, so logically all these
complexities should be better done in the kernel once for all.

There's indeed difficulties on providing it in hugetlbfs with mm community,
and this is also not the only effort trying to fix 1G page poisoning with
userspace workarounds, see:

https://lore.kernel.org/r/20240924043924.3562257-1-jiaqiyan@google.com

My gut feeling is either hugetlbfs needs to be fixed (with less hope) or
QEMU in general needs to move over to other file systems on consuming huge
pages.  Poisoning is not the only driven force, but at least we want to
also work out postcopy which has similar goal as David said, on being able
to map hugetlbfs pages differently.

May consider having a look at gmemfd 1G proposal, posted here:

https://lore.kernel.org/r/cover.1726009989.git.ackerleytng@google.com

We probably need that in one way or another for CoCo, and the chance is it
can easily support non-CoCo with the same interface ultimately.  Then 1G
hugetlbfs can be abandoned in QEMU.  It'll also need to tackle the same
challenge here either on page poisoning, or postcopy, with/without QEMU's
specific solution, because QEMU is also not the only userspace hypervisor.

Said that, the initial few small patches seem to be standalone small fixes
which may still be good.  So if you think that's the case you can at least
consider sending them separately without RFC tag.

Thanks,

-- 
Peter Xu



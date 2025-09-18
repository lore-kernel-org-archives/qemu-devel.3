Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF4BCAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 21:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzMMt-000551-6Z; Thu, 18 Sep 2025 17:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzMMq-00054g-FG
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 17:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzMMo-0000Q6-GB
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 17:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758231635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4B+IyI6bsO5sv46rHVxYykJl8+IxX8MB0+se8gQEOMM=;
 b=XZzNi79tWcnKtTpIjk4V72LCqk3BAykTtV0Pv50IRi6di7Y3vbdkDDtluK/wlyZS+TSWUq
 NbTpvVNKVE0+m9o7O5jmLsb9IcqRrKi3TmXtxH428WoEm2je+kpN3QQ7pdiswJVXkWUIZA
 MVUXeDWBFOr9cebiYF58Nx59nvoBqV8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-lLNmpQmdNCCuYPvSMewe7w-1; Thu, 18 Sep 2025 17:40:34 -0400
X-MC-Unique: lLNmpQmdNCCuYPvSMewe7w-1
X-Mimecast-MFC-AGG-ID: lLNmpQmdNCCuYPvSMewe7w_1758231633
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-82b1934907dso305898385a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 14:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758231633; x=1758836433;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4B+IyI6bsO5sv46rHVxYykJl8+IxX8MB0+se8gQEOMM=;
 b=qZDuXVOdDKvksznvKqUpgBFIBzO3Vrt1rPTjV6U0bIgiFrGlUtkGkKBwt4PgcbHtUO
 Jdp6s4HurR07FPKl1vVxy77Krzqgfl4l2s+5n53ZCZJv2p6+29Q1XrmK1RHoMxTMo8tZ
 1fGB3yqyR9ndXnw+UkSKlVq2/6V3ZrQhwWk/8lo+Ycula9ACPSq+XtyOYegG8z3yMwm2
 /bBl932qmEcP/gyDbQTWc5I9fvMy7YFUMWnyZGcvPKbkoHZtCvbEq1MwZpD80LCPkjKS
 EuLOG+bKrpMOlIBOL6smQ0AME/3c3ux5lj0DubWUORZma/yrjivwnd8gIkwgcutxlfk9
 U30g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8xKK1wrtNUOWsjQ7vG6KQiAmWeJk0BoMdZ6AI4A/uMDWXgs23umqxSCBynubH+kP2DScFZ0U3xeiA@nongnu.org
X-Gm-Message-State: AOJu0YwWtGjUgos9eHTUnLXRB0Q5aWEIV0Dl/nC94+PcgQ98TJD0qOKO
 kZcov0JtX/L5Q8/ThnEzHdWgp08mDBqevBSqazVTX0DSnF8EVF0wxNNdeEmaTHSkwC84CteymSb
 P0kaTbnQEVEVcsCWXyCtRlL1wGF3EsSyF7JMyQaBVX8vEYP+Cji4DBDoQ
X-Gm-Gg: ASbGncsIp4tfhoq1BuUXkp20+ZpOWmYOQwzKNSISlL1bkUtQmhdFYVT2nfPJwwNl9av
 dAYw2ivN7wIGM3RmLCukJxWsKvJjQcttOv/6qQQXuNYEcQLPZxw1twmgyzrSet8PHWPHJLpXmLh
 /8rPxrNAdKpi+caqTw6+481quM+RpfHCLX6EfN/15A5UjRfM/nW2i8z59il6Pu4wFi0hkM6/Jzl
 fcTmxBPm5vFZpu7kOLnzG5s5zx1tuJF+q6Q+SfOEVGHtSteuQenEV2TbyEqBpKJwt/ZyhqMYs4Z
 pVChUwnesIB+3hMv4OReAiMetrckCtjXS6D0428MJ6ZKAQNb+krk4+s1ujHMnNOB3Uk8GE1ERxK
 cxE1s3uc6JgpUPvDRcThuKg==
X-Received: by 2002:a05:620a:21c3:b0:82b:1f48:6e96 with SMTP id
 af79cd13be357-83ba494ba31mr118276785a.29.1758231633515; 
 Thu, 18 Sep 2025 14:40:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzDJNEFRyt6p9051XoSvJBxwpBRLkVsOInVSkyjI1BSLDMXHjnC4q48Dep8jKAv+HcoR4dPQ==
X-Received: by 2002:a05:620a:21c3:b0:82b:1f48:6e96 with SMTP id
 af79cd13be357-83ba494ba31mr118274585a.29.1758231632994; 
 Thu, 18 Sep 2025 14:40:32 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-83627d7dd01sm237001785a.27.2025.09.18.14.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 14:40:32 -0700 (PDT)
Date: Thu, 18 Sep 2025 17:40:31 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] [PATCH] vfio/common: Work around kernel overflow
 bug in DMA unmap
Message-ID: <aMx8T5-u6Uj64Vgx@x1.local>
References: <154707542737.22183.7160770678781819267.stgit@gimli.home>
 <cd287f5c-796e-4172-9537-b00991a95391@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd287f5c-796e-4172-9537-b00991a95391@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 18, 2025 at 10:55:47PM +0200, Cédric Le Goater wrote:
> Alex, Peter,
> 
> On 1/10/19 00:10, Alex Williamson wrote:
> > A kernel bug was introduced in v4.15 via commit 71a7d3d78e3c which
> > adds a test for address space wrap-around in the vfio DMA unmap path.
> > Unfortunately due to overflow, the kernel detects an unmap of the last
> > page in the 64-bit address space as a wrap-around.  In QEMU, a Q35
> > guest with VT-d emulation and guest IOMMU enabled will attempt to make
> > such an unmap request during VM system reset, triggering an error:
> > 
> >    qemu-kvm: VFIO_UNMAP_DMA: -22
> >    qemu-kvm: vfio_dma_unmap(0x561f059948f0, 0xfef00000, 0xffffffff01100000) = -22 (Invalid argument)
> > 
> > Here the IOVA start address (0xfef00000) and the size parameter
> > (0xffffffff01100000) add to exactly 2^64, triggering the bug.  A
> > kernel fix is queued for the Linux v5.0 release to address this.
> > 
> > This patch implements a workaround to retry the unmap, excluding the
> > final page of the range when we detect an unmap failing which matches
> > the requirements for this issue.  This is expected to be a safe and
> > complete workaround as the VT-d address space does not extend to the
> > full 64-bit space and therefore the last page should never be mapped.
> > 
> > This workaround can be removed once all kernels with this bug are
> > sufficiently deprecated.
> 
> Have we waited long enough ? what does "sufficiently deprecated" mean ?
> Is it related to the linux stable updates ?

Alex might be the best to define it.

To me, it doesn't sound a major issue to have it even forever just in case
someone was using a broken v4.15..v5.0 kernel.  It's pretty small, limited
and self contained workaround.

Any blockers on this?

Thanks,

-- 
Peter Xu



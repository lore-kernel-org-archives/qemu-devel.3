Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177E7C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 17:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEWyS-00082v-Dx; Mon, 12 May 2025 13:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uEWyP-00082T-Kg
 for qemu-devel@nongnu.org; Mon, 12 May 2025 13:29:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uEWyM-00048v-St
 for qemu-devel@nongnu.org; Mon, 12 May 2025 13:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747070987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0AYsWCkTU73Z5hWR5XJM21cdiGhbjPymFFXlB1PhBNE=;
 b=LGkTFVYpxTAkYKzBJRvIltDzgVk4ZEIONLFdXnbKrehROFkb94nCF4E+77m98aOAdzeIkO
 DSLSNujcEEegV/PrAFVtXt+4RykczOrGHlYi877kCttI/dldX8T42hGHD911pUCq2eaQdY
 0yl2Hde4i0DP8n9BD+zSOPucw/FS2NY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-_5epk2C1NcW1TOxjelcmWQ-1; Mon, 12 May 2025 13:29:46 -0400
X-MC-Unique: _5epk2C1NcW1TOxjelcmWQ-1
X-Mimecast-MFC-AGG-ID: _5epk2C1NcW1TOxjelcmWQ_1747070986
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6f53d2613easo89651936d6.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 10:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747070986; x=1747675786;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0AYsWCkTU73Z5hWR5XJM21cdiGhbjPymFFXlB1PhBNE=;
 b=AtE85OFFGZUzK7nBwWiEn8PYkxu6D7YjrNtKpMkUgugAmUHAzi11+4MGkEFwk6Nxfw
 ErgDTHonerDIP9epctBLZB45e/7Lv0lJdfY1kL/VOJucHuQhvwphvOVXPjeORh+KiZOH
 jAFb7/qe6iXX7iYT++/7k5X4D2ySq56PTs6g/Vs6jsN79oqJMKr3vytPlVFOpd1Nm7KU
 o13oVMtcb12yZgm7FeJiTv8AgJvYo9I4NgD771LkxxsmuyGwUXgo5Mo/8PqeHtY+EjIU
 6C1ey6y8p79gHzEtyg32GSdD1tWYa6IS+8I4uuNrKsul/A/TxaQmDgwsr+32sie2wY+K
 oAuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaLmKXc/Y0qGiYAQ0hjjEDKp+Wy2VKUVI8RjEAhf5XZvI2LF3NW0nwpCsa8cuizUOajVn1J8jq92p+@nongnu.org
X-Gm-Message-State: AOJu0Yz4FerUk/3HgX+AJCH07X0S91yIdz83DDjAJutZ2aXWD1/WRDJq
 hovvK5uVxzjfu8zdZgezmOkoYaoQq+f60vZOZLRXI/N7+ma0SZBHXx0Z2EIiTUTwvuwPmaY09WA
 7rFD6x2qcQjEcd163tey7IyCD5Kk0q9bQXEQj5NlePKsxNVtHkxDj
X-Gm-Gg: ASbGncv33K1jqFiSTd9iP/FunQUT9ZQVc7tBSytDu7grwu6bSQicGN9f7jAZsu0QJiW
 OroCwirL6hU56Mk4iG0/UGOcEQl8VrkKerk8KPowjq+qQuPY8TjfT8GGLFEL4Y6LqxpJrNbKxd3
 bRr1xXh1+G00sgcQpO/YcOS/wq9fkuvb07yc04xvr1GYhOvJCUnTnz66HqiWbN8A2p8oL+BaO8G
 UFoPtzyfZt0sw32jxyglX+b1p0Ed8N/6sU15sJD9IOXWS42SevTOKqWmKaCMrLwmVdZXE17DugN
 se8=
X-Received: by 2002:a05:6214:246c:b0:6e4:5a38:dd0f with SMTP id
 6a1803df08f44-6f85b549fc9mr5123556d6.4.1747070986088; 
 Mon, 12 May 2025 10:29:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2d8ex09NWHZ++L/+rp7PD6t9/CaQ7+bQqAYwyU6oqXmJqQlXPUt4Inkeo9FUzCMTEuUxdSA==
X-Received: by 2002:a05:6214:246c:b0:6e4:5a38:dd0f with SMTP id
 6a1803df08f44-6f85b549fc9mr5123086d6.4.1747070985641; 
 Mon, 12 May 2025 10:29:45 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f6e3a60479sm54749206d6.120.2025.05.12.10.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 10:29:45 -0700 (PDT)
Date: Mon, 12 May 2025 13:29:41 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 philmd@linaro.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, Wei.Huang2@amd.com,
 clement.mathieu--drif@eviden.com, ethan.milon@eviden.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 01/20] memory: Adjust event ranges to fit within
 notifier boundaries
Message-ID: <aCIwBa1EC0E7wMMX@x1.local>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-2-alejandro.j.jimenez@oracle.com>
 <9880adf5-b1be-4311-a2b1-9e9a3cade213@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9880adf5-b1be-4311-a2b1-9e9a3cade213@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, May 12, 2025 at 10:02:16AM +0200, David Hildenbrand wrote:
> On 02.05.25 04:15, Alejandro Jimenez wrote:
> > Invalidating the entire address space (i.e. range of [0, ~0ULL]) is a
> > valid and required operation by vIOMMU implementations. However, such
> > invalidations currently trigger an assertion unless they originate from
> > device IOTLB invalidations.
> > 
> > Although in recent Linux guests this case is not exercised by the VTD
> > implementation due to various optimizations, the assertion will be hit
> > by upcoming AMD vIOMMU changes to support DMA address translation. More
> > specifically, when running a Linux guest with VFIO passthrough device,
> > and a kernel that does not contain commmit 3f2571fed2fa ("iommu/amd:
> > Remove redundant domain flush from attach_device()").
> > 
> > Remove the assertion altogether and adjust the range to ensure it does
> > not cross notifier boundaries.
> 
> Looking at the history, we used to have the assert unconditionally, and
> made it specific to IOMMU_NOTIFIER_DEVIOTLB_UNMAP in
> 
> commit 1804857f19f612f6907832e35599cdb51d4ec764
> Author: Eugenio Pérez <eperezma@redhat.com>
> Date:   Mon Nov 16 17:55:06 2020 +0100
> 
>     memory: Skip bad range assertion if notifier is DEVIOTLB_UNMAP type
>     Device IOTLB invalidations can unmap arbitrary ranges, eiter outside of
>     the memory region or even [0, ~0ULL] for all the space. The assertion
>     could be hit by a guest, and rhel7 guest effectively hit it.
>     Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>     Reviewed-by: Peter Xu <peterx@redhat.com>
>     Reviewed-by: Juan Quintela <quintela@redhat.com>
>     Acked-by: Jason Wang <jasowang@redhat.com>
>     Message-Id: <20201116165506.31315-6-eperezma@redhat.com>
>     Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> 
> I think this change here is fine, but it would be good getting Pete Xu's opinion.

Agree, that could be an old sanity check only when it used to be guranteed.

> 
> Acked-by: David Hildenbrand <david@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



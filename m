Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A10BEDE9B4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 20:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so7GE-0001pT-Ut; Tue, 10 Sep 2024 16:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so7GE-0001nN-D2
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 16:14:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so7GC-0003xo-EO
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 16:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725999285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kN0SVQe+R6Q/Am9uMaXvCjMgaZkrm3d5lGXG7KM9Ceo=;
 b=CmJWG3cZd6TN1Qvpw0M0OT2WcyTAfo0zxkY/vr5O/YcK5r2t8r9hgucqc+qIMByoc+d31z
 P6R0P1KXec4Q6YOLKUFYnCeSRgJoZIGjOzbdaQTYYa+oS+VroO8BJXj35H6veLjqTjBJLN
 PP2BXiRAk5KSdgBhJ/uZqfK4aNX03rs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-mQqPqX6-PQSLnbr4AvvoHg-1; Tue, 10 Sep 2024 16:14:44 -0400
X-MC-Unique: mQqPqX6-PQSLnbr4AvvoHg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a8d21b5cb5fso219404066b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 13:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725999283; x=1726604083;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kN0SVQe+R6Q/Am9uMaXvCjMgaZkrm3d5lGXG7KM9Ceo=;
 b=PKuWPur6zEZvGzS0/VnWX/Poiv/uOoWx1hfzEFl6zM/s7Lz5F7Me8BX4PQz0Jdpjcl
 Rb6+hXm5zC+VdRtyNKq3DVzHxhTu3RY8dfw3kPXQAGVPMaL0DlJ9crpirRECU9IBnl6e
 p2VpitVNM6cHNMFbz2VSBRLEQ5zaiBoZip1XTzYStr+LUuNWIusAJqlOzlBQGGMAwofw
 wALcvIPJeMUeg28guwwgC6V6Or30ubj/OuOOlvsXncvFfZeJVoE+PUIiCBUSKu7IZsIL
 g8XkuHkhMwOOWLIGoaieHeItQwp/dewp6fFrhc8plTTkVsJsfdayo2Ggfqk3V3cJe7UK
 6UFg==
X-Gm-Message-State: AOJu0YzIveqQhazQX0SfV6BceckxbL8B6E7klNgxMu5CuMhsdC7HSuUJ
 IsRjNbQFq3ib6h1nf7SeMcLOFcQgQrsNwBMZg+Lz7/rJmdyMYcPuUKBDMCLGDqudKxut96tYNoF
 uomtBvoClAyHxajQpY32PQBHnM7m/RcHO3mdgpk0yrOJEtAYGwDFyVSN23Ejy
X-Received: by 2002:a17:907:9812:b0:a86:a30f:4aef with SMTP id
 a640c23a62f3a-a8ffab29059mr170986266b.22.1725999282799; 
 Tue, 10 Sep 2024 13:14:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRTOz/XOwI7jwjExfz071xYB1R3GP0HZdczdNcd6gKXHqvAF4ENbRAF3AM5S/K0ITzRNI8zg==
X-Received: by 2002:a17:907:9812:b0:a86:a30f:4aef with SMTP id
 a640c23a62f3a-a8ffab29059mr170983066b.22.1725999281897; 
 Tue, 10 Sep 2024 13:14:41 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:f5ce:2d9:5bfa:9916:aa0a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d645a0sm525177266b.214.2024.09.10.13.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 13:14:41 -0700 (PDT)
Date: Tue, 10 Sep 2024 16:14:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Santosh Shukla <santosh.shukla@amd.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, joao.m.martins@oracle.com,
 Suravee.Suthikulpanit@amd.com, vasant.hegde@amd.com,
 mtosatti@redhat.com, marcel.apfelbaum@gmail.com
Subject: Re: [PATCH 0/5] Interrupt Remap support for emulated amd viommu
Message-ID: <20240910161403-mutt-send-email-mst@kernel.org>
References: <20240904100257.184851-1-santosh.shukla@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904100257.184851-1-santosh.shukla@amd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 04, 2024 at 05:02:52AM -0500, Santosh Shukla wrote:
> Series adds following feature support for emulated amd vIOMMU
> 1) Pass Through(PT) mode
> 2) Interrupt Remapping(IR) mode
> 
> 1) PT mode
> Introducing the shared 'nodma' memory region that can be aliased
> by all the devices in the PT mode. Shared memory with aliasing
> approach will help run VM faster when lot of devices attached to
> VM.
> 
> 2) IR mode
> Shared IR memory region with aliasing approach proposed for the
> reason mentioned in 1). Also add support to invalidate Interrupt
> remaping table(IRT).
> 
> Series based on f259e4cb8a8b4ef5463326fc214a7d8d7703d5de.


Fails build on non-kvm:

https://gitlab.com/mstredhat/qemu/-/jobs/7791357916

/usr/lib/gcc-cross/i686-linux-gnu/10/../../../../i686-linux-gnu/bin/ld: libqemu-x86_64-softmmu.a.p/hw_i386_amd_iommu.c.o: in function `amdvi_sysbus_realize':
/builds/mstredhat/qemu/build/../hw/i386/amd_iommu.c:1660: undefined reference to `kvm_enable_x2apic'
collect2: error: ld returned 1 exit status


> Testing:
> 1. nvme/fio testing for VM with > 255 vCPU with xtsup=on and x2apic
> enabled
> 2. Windows Server 2022 VM testing for > 255 vCPU.
> 
> Suravee Suthikulpanit (5):
>   amd_iommu: Rename variable mmio to mr_mmio
>   amd_iommu: Add support for pass though mode
>   amd_iommu: Use shared memory region for Interrupt Remapping
>   amd_iommu: Send notification when invaldate interrupt entry cache
>   amd_iommu: Check APIC ID > 255 for XTSup
> 
>  hw/i386/acpi-build.c |  4 +-
>  hw/i386/amd_iommu.c  | 98 +++++++++++++++++++++++++++++++++++---------
>  hw/i386/amd_iommu.h  |  5 ++-
>  3 files changed, 85 insertions(+), 22 deletions(-)
> 
> -- 
> 2.43.5



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2BCCD98E4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 21:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJewT-0001sY-Mh; Thu, 13 Nov 2025 16:33:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJeYf-0002Wt-Vy
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 16:08:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJeYe-0005tI-DH
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 16:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763068123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TpcFGgdSWZ5AsF1vV4PRrxl7iUCrQtOsXSlW8E7tVFs=;
 b=BHveR2XnhsXSVxMfYCCFECOYMVtgoOpaOkXiCMakjDLqaxEQfy/nOtA1kJHHOrbB3G6hL4
 akfGxzHIjQ4jcxduCS+r9kPPz2VkEAV4V/DRLmo6zPP2PtUS/v+HWBdfwD0aUS0nrhY6IR
 O1RMJ5K6gbLlcP3nZqak95y4w/7XxwM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-VmpuQDoCOXStaoAULkA-EA-1; Thu, 13 Nov 2025 16:08:42 -0500
X-MC-Unique: VmpuQDoCOXStaoAULkA-EA-1
X-Mimecast-MFC-AGG-ID: VmpuQDoCOXStaoAULkA-EA_1763068121
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b244ef3ed4so409441985a.0
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 13:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763068121; x=1763672921; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TpcFGgdSWZ5AsF1vV4PRrxl7iUCrQtOsXSlW8E7tVFs=;
 b=Q4zVAj0P5L4beAnmqQEB902537ublqFYy9jnfvps+IDOvKiWMj9gYvN42HLwlcW2Ei
 4TfS7P1/8bXuPGVsMb5G/xOGhRiRsT+aKQNapaPURCLrzRMf3WghVPjHLxMZJRG8YQgI
 4pOgBGRcxxEYHDNI2LxXxNPTVF8X0MbrAxWUXMtCcMBUT4KYzHH+oMXuyKWk0qq655Ok
 BoU/Kkjyd5da96hOhffWbILTzUdOXsv0oBVkBncVAyl6qCRHF2pzycUhGhuVxY2m2ne4
 /b3X5CzSgQKTHRO5wA0g76hdCNLb1bFhPtib/1Dk5iMm1pxDzvEp/SkkAw41qcy0AkwT
 S/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763068121; x=1763672921;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TpcFGgdSWZ5AsF1vV4PRrxl7iUCrQtOsXSlW8E7tVFs=;
 b=Eq7vgz3RFsl0wX3bTqG77WxXa2xAt1zfu7r9QWcLyXMKdRt7tVlSXupapnRPR7NGDT
 bMADYnooOH6ilkxHsIrQHO0YXxCGSP5WcpilCjVhlrh/GhrCVigpaKzeWmzHREwtxV91
 YCk/JoV0vgLtEhPvksORqxcn9vD1c5LsEZycnhjqXIicu+chR53DrwEiFvg74vbYR2G7
 a/md3n4GDdFGWKFgp8EnghgVdyoIAZt+TnsYo0xDGtJtH5Bzv27CPUccTIwiH7hvlDX8
 YA8vG+y8eOmbRV1S/zDFgORcI48oW1l7tXqk6Nt9z3thHGXUf7eW5nRGqu7magYwcecQ
 Q2Vg==
X-Gm-Message-State: AOJu0YypQy75HwOzZ9Ed0IFGNFdQOzcM/FNSJuXel3cvAk7yKmjB4nai
 x6+a1Tz3N5/w8bCsCXm6ChYsu+P+ZTBJJuUOYTl0GlI37GVRNsckDHe+87W3oRa860oyVmu2BxL
 6jbgBnpjk3G0WnjH8rCFQtfKECG544pJhJ62fm6cg8RXyz9yJyY++GBIY
X-Gm-Gg: ASbGncs2s3moEie8Osrw5ACi7mmCyXOPK2X7dvF3IUoRnVYhsqfUBtMylNuVLjMzv+I
 eP3AZKBd16R4sZ86jOLRMZ6LFuq/NADW/AcbLNmqQ3TgldMwcBMe05/p8goEp3K0pbZOTvIvDXD
 Wrins2aWgZqsvJGCb+j7hIEvaRqXqzskC9IQDpDxl3YaZqQBVareYB5HM4K05ZPuMkE650VSpo/
 757XHLdkB39wKffNVZNy8Dnxt2vUZrugZQUkM79CB8uL1Gj3TTGUE4pGWRMgIHCRrOmxeukmqcG
 zQR2ZtC3zsQfM6/WaRSndmA8maPPm9sNzAPpZnUxUAXLB29b1osFbveYzLRIE+cGxB2Kbcs+xBb
 2VA==
X-Received: by 2002:a05:620a:1911:b0:8a4:107a:6772 with SMTP id
 af79cd13be357-8b2c31dd43amr119895785a.76.1763068121353; 
 Thu, 13 Nov 2025 13:08:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS01cbOv8YqaWCdo/ga8BIFiHkyW+zoAINhuEeAUO/zGjwdCKJGgHSVjmaSH88K3uuxPdaCw==
X-Received: by 2002:a05:620a:1911:b0:8a4:107a:6772 with SMTP id
 af79cd13be357-8b2c31dd43amr119889985a.76.1763068120801; 
 Thu, 13 Nov 2025 13:08:40 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2af043045sm202632285a.39.2025.11.13.13.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 13:08:40 -0800 (PST)
Date: Thu, 13 Nov 2025 16:08:36 -0500
From: Peter Xu <peterx@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 2/8] kvm: Allow kvm_guest_memfd_supported for non-private
 use case
Message-ID: <aRZI1O18HAHcxaFV@x1.local>
References: <20251023185913.2923322-1-peterx@redhat.com>
 <20251023185913.2923322-3-peterx@redhat.com>
 <9614d727-97bf-4a50-be13-6754952bec96@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9614d727-97bf-4a50-be13-6754952bec96@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Oct 24, 2025 at 10:30:19AM +0800, Xiaoyao Li wrote:
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index 68cd33ba9735..73f04eb589ef 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -125,3 +125,8 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t
> flags, Error **errp)
>  {
>      return -ENOSYS;
>  }
> +
> +bool kvm_private_memory_attribute_supported(void)
> +{
> +    return false;
> +}

Hmm, I found that your this patch seems newer than the one you pushed here:

https://github.com/intel-staging/qemu-tdx/tree/lxy/gmem-mmap-poc

Do you want to push it once more to make it latest?

Thanks,

-- 
Peter Xu



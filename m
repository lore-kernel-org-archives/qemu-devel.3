Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125B7CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 21:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJfCV-0004lx-5O; Thu, 13 Nov 2025 16:49:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJejK-0000rF-Lv
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 16:19:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJejJ-0002kJ-9H
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 16:19:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763068783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R5bpTRuZ7CHJ+KZYxHEVym6m16h46Zr5yYjNFq0AFHk=;
 b=At5MUtB/sJFMMm3tP9W+KHbAGF6a4qL8CvPiCPGp2ArCpphohAO0n1zRlH6jsFhai7ErL7
 rmExH309Y6qI7z82ae/a8hWAA9TTwgP4y+ahXou2tYbYqWP3TxgRshynTdliCQBTa0A/ZR
 9/9IvDD2ybdgAO/fXcty5p2PSXbUDYw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-bEq4NEQCPRu8-HkrnbWRcQ-1; Thu, 13 Nov 2025 16:19:42 -0500
X-MC-Unique: bEq4NEQCPRu8-HkrnbWRcQ-1
X-Mimecast-MFC-AGG-ID: bEq4NEQCPRu8-HkrnbWRcQ_1763068781
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8823a371984so28975716d6.1
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 13:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763068781; x=1763673581; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R5bpTRuZ7CHJ+KZYxHEVym6m16h46Zr5yYjNFq0AFHk=;
 b=L8KufbTVuKKnq66vv+W+1fGwn7LYWs/weLc28IW5b1YBvGTZXE2D/zhYcmPTJrg+GJ
 K8cGhJiIgbtc2cxFzqnai2kv5OOm2WFDFHBS0Vby6as6wjIJlRWtRt5fnfyxBatKk9QS
 bLn+8Oui15AYxIEwGmMwJmPoAP5IBfp+0URrMWFms8N+sLV3Zj5zKCFNVRgp8ujOvsNO
 1jLP0mlvPBS/JJdhZgO89ezW89ChVYlCnp/jLTdsw31h3518CP6UJzp9BBPVVsj+5pD+
 sMXkMltDW9LJ4RXvYdsNs+o9inPisEzkvafyPJLIDKAjp2YiF5QW0WX1AkGtNoR8jV3R
 aS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763068781; x=1763673581;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R5bpTRuZ7CHJ+KZYxHEVym6m16h46Zr5yYjNFq0AFHk=;
 b=Ye9MIW4XMgzqafsps2se2wxw+wmfNIevRh1LsPVE4eaoGUOtsnbd/dC9LL1eKiXbkR
 0ok6Z5TEHPfhX8eCcEFTooSo7b3V4UCNPxKeT3a0sQgyaA1O7wXVHXK+B6F4hpxZnRw3
 lbLDapUJn6YggPUJNf0THDOmeyMmkD8E2EiAQ602hPnghCxaKc9iElQ6gnKZj+oRGhO4
 YWjZb2SA6MC3VFJ4vBahiPdivRXe5qKVFWD3Jj+JkmXPpo+sgpbQIrVALTEShHHf1o/4
 G4ea8hgSXT7tiois3L0kWj9foYntLeAV4WIMBp0jDrFkB+yct90TnCcxrAHdYkuRTQoU
 YCXA==
X-Gm-Message-State: AOJu0YyZMTTOvSplCEcPYDh4ZWoj7hDQ/FDyWA86YsU24sz0HmdBynMR
 aE36T0x477IXAgcn2IaB3ygkawP3zsotQgMWWzb87vFbpBz3ZjHxbys5+vCvv0oYRY+N4FpsbPQ
 umEs+8pMrq6gUxL/TURDNF29Dz1sx00FmVIBn70j2jNU+j5gnNw6I6G1U
X-Gm-Gg: ASbGncseggWoVOmDKUiUfHHhSwPVYXSaOVw9ZSKSsEDShKecMTFdFXsBTN202joFQNO
 vDFguCliml030dk6tSeA7aK4OrQvHzTY9wP9uoBQGIh/LJ0DhwpDg7ys2LwUCg8xTjqh2s86l72
 2iNQSzM6gV1zea10IC2SyvZtj1j/3ZCTPAXVR6cDzPCXOzCiAEvkvMt4iLHVf7Zw/W91BdrViql
 MjYDdmIXvzo2mKddvHHO4Qh/GVFWD6hLjI7JOLhaXa0YjrXTu7u2HyN0P+zGf3n8mhazjnpq7Yl
 VMhTrg2tn9vEFWNd+jYBqd+9IoFezqKR9BqWOgNLqnFy5oKH3SK53fv4TilaS0L0MyOmhulkf/I
 sYA==
X-Received: by 2002:a05:6214:21c9:b0:882:762c:6b84 with SMTP id
 6a1803df08f44-8829267c636mr10103616d6.35.1763068781555; 
 Thu, 13 Nov 2025 13:19:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKg8YoYCYx9EVwK1xiufDUyFgvBs+a8aX69FtrUIoFGN9915dLhLSfte/06eAxa4sZuGdWMA==
X-Received: by 2002:a05:6214:21c9:b0:882:762c:6b84 with SMTP id
 6a1803df08f44-8829267c636mr10103226d6.35.1763068781118; 
 Thu, 13 Nov 2025 13:19:41 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8828656ba3dsm18999386d6.45.2025.11.13.13.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 13:19:40 -0800 (PST)
Date: Thu, 13 Nov 2025 16:19:36 -0500
From: Peter Xu <peterx@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 3/8] kvm: Detect guest-memfd flags supported
Message-ID: <aRZLaJZ8ZP5lU6Hy@x1.local>
References: <20251023185913.2923322-1-peterx@redhat.com>
 <20251023185913.2923322-4-peterx@redhat.com>
 <30f9d0b9-0a27-4b78-9633-8912bc18998b@intel.com>
 <aRZKhniIgG7HFaoq@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRZKhniIgG7HFaoq@x1.local>
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

On Thu, Nov 13, 2025 at 04:15:50PM -0500, Peter Xu wrote:
> On Fri, Oct 24, 2025 at 11:52:01AM +0800, Xiaoyao Li wrote:
> > > @@ -2781,6 +2782,11 @@ static int kvm_init(AccelState *as, MachineState *ms)
> > >       kvm_supported_memory_attributes = kvm_vm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
> > >       kvm_guest_memfd_supported = kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
> > >           kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
> > > +    ret = kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD_FLAGS);
> > > +    if (ret > 0)
> > > +        kvm_guest_memfd_flags_supported = (uint64_t)ret;
> > > +    else
> > > +        kvm_guest_memfd_flags_supported = 0;
> > 
> > Nit:
> > 1. QEMU's coding style always requires curly braces.
> > 2. is the (uint64_t) necessary?
> > 3. can we name it "kvm_supported_guest_memfd_flags" to make it consistent
> > with "kvm_supported_memory_attributes"?
> > 
> > so how about
> > 
> > kvm_supported_guest_memfd_flags = kvm_vm_check_extension(s,
> > KVM_CAP_GUEST_MEMFD_FLAGS);
> >     if (kvm_supported_guest_memfd_flags < 0) {
> >         kvm_supported_guest_memfd_flags = 0;
> >     }
> 
> Yep this looks good, I'll use it, thanks.

About naming: note that we already have different styles (both below
variables introduced by your previous commits):

static uint64_t kvm_supported_memory_attributes;
static bool kvm_guest_memfd_supported;

I personally preferred kvm_guest_memfd* as prefix, so I kept it.

-- 
Peter Xu



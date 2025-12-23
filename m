Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE20E6F085
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 17:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY5nL-0006eh-GT; Tue, 23 Dec 2025 12:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY5mp-0006DZ-Gq
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 12:03:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY5mn-00079a-Oo
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 12:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766509379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yGZuEWpp6AWstqbPJiX1cQukvVgz76NEQW/frUoPaDQ=;
 b=U/8s39rGLx6OPS9qnAgQJn2ccaSTUiSiFuZFnY/NPH5IIYTuwqDBkelxVE89Uu84y/Kv3y
 oyg8FgVbu5ONIQHwhEs+zxVhGjkLG+74xewhJegclnOoIMtP++CLWJYPSbgMnMyeGlHluk
 oJKAsQnwTPzT3eWAxDY/9IxJXIhFqRo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-vdZHkrdANKudqnEaU058qQ-1; Tue, 23 Dec 2025 12:02:58 -0500
X-MC-Unique: vdZHkrdANKudqnEaU058qQ-1
X-Mimecast-MFC-AGG-ID: vdZHkrdANKudqnEaU058qQ_1766509378
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b2e2342803so1283940685a.3
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 09:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766509378; x=1767114178; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yGZuEWpp6AWstqbPJiX1cQukvVgz76NEQW/frUoPaDQ=;
 b=bjjioURk+Obw1R7IKQfYIIpHb6jd/1L13ZcGfQKpka4EMIpxHMXuVWzssC8wB6h0gc
 GJeaHvw5gcgHOTfC2kQXi8VcjcyAmrt325y8xLXsN2fHZ+Q7SxjmoxwdcEA3KLn6sFGm
 XS0/zRFOMhZhh8KWEdvV5ndFt1OnTqvhU/1d4krMC1grIGAKirzL+LF85fgz/9sipUO+
 TR7XlGSCNhhsPW9tKI0P6kpnwJOcA5o/SenpiMBUQJtwB30u1vU4TBttBD4WNYisO2gm
 MqYdiKoHPoGgAc9TDZSuYWN5EfHQ3VtJCBDGU9nKaHqjpu/LjUL7yXwRAxoZMZxfpS5G
 kwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766509378; x=1767114178;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yGZuEWpp6AWstqbPJiX1cQukvVgz76NEQW/frUoPaDQ=;
 b=JO0KG7yZXt54jnLYwUItkLdZsTgEz0WIQfHps0P7yMJcdxmY70SaNa1h/xZo3bUVmn
 /hmVHJPft3lUUqJfdh6Mo0RQ3JPg44U3Sn2DQmgTVN+GQ5GknIa9JR1Ek2SbsE2aid+Z
 HtZG/ZCZ9KuRBlqSDLko8VcD8YoThC3mrfV3mHLLZb55CW1gzcO+SG841Uj4w0zFmAq7
 lbfShJO8XvluQ5MeeecwEv/fTDpRBiEBSowurJBL/KQQURLHAiBA4Cvm+qwBNh2fCcfq
 W67R5B6SQe0GWvIlSR2nrPmOkVM8krLYSr2efBQL84ZPTFFGtGhW0g2ok76+rWiLSIb3
 KtTA==
X-Gm-Message-State: AOJu0Yz9dn2TRJiGlvKwdmLNvfSfdDQtbrihNKSCJ0CkaGjyRXPUpbVd
 CMg5iamp1V8eLVcIgt+66ZO6GuqvnxSsX/8LpOy1qxEKq6Q+t0e/PPJZO6erlocKvJUq4c7vYBm
 MWY/kpk5STuYUEVbAenjLw5s4dkF9FnshO9wVu7bqXE3i+2Rp1EM+M6Ew
X-Gm-Gg: AY/fxX4lbcuysAtXEs6VTZE5SdFHSTARewTKldYY49GMkec/f11VFVxWUHhkoO6+Oi8
 6Cub3BlzYDTFvsEMQDW73AZQtk+MQ1Db23Ab/YlbSOymG4gpNJMUN99lhChsdn45IDi2570Q9nk
 GjVJ1izSMxVc4zNT4QHp4cg5pPqASqARNtAaTqEi1i/RQH7rW9m9oGkhLM5wYS4evm3kcz8M1UZ
 9O3U1OHjUEdD77FLdn/UByfzZvWV0B7f8vJQiG4mfS2J4/Sae9Ups+nB8h8C+bCraF+UghEymQa
 QB9j3QutjLWPjl6Q4SyRcvcJCGD6sjgYRizAk5+IHBi/q9kLgowY9HIgu7NqQrMJvQ/K3hJJROZ
 VtYw=
X-Received: by 2002:a05:620a:1a1a:b0:892:5b57:ea41 with SMTP id
 af79cd13be357-8c08f655157mr2023132985a.4.1766509377675; 
 Tue, 23 Dec 2025 09:02:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUYzcxtvUD/v2JbiU4c6TDI9cN/qPgxOeLylBVP0X+afJ56vjpETsqgaov7usjhD4HFE9DbQ==
X-Received: by 2002:a05:620a:1a1a:b0:892:5b57:ea41 with SMTP id
 af79cd13be357-8c08f655157mr2023125185a.4.1766509377046; 
 Tue, 23 Dec 2025 09:02:57 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c0968913ccsm1143616885a.16.2025.12.23.09.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 09:02:56 -0800 (PST)
Date: Tue, 23 Dec 2025 12:02:55 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 David Hildenbrand <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 01/12] kvm: Decouple memory attribute check from
 kvm_guest_memfd_supported
Message-ID: <aUrLP3i-SWftPpWA@x1.local>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-2-peterx@redhat.com>
 <87345a354v.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87345a354v.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Dec 16, 2025 at 10:53:04AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > From: Xiaoyao Li <xiaoyao.li@intel.com>
> >
> > With the mmap support of guest memfd, KVM allows usersapce to create
> > guest memfd serving as normal non-private memory for X86 DEFEAULT VM.
> > However, KVM doesn't support private memory attriute for X86 DEFAULT
> > VM.
> >
> > Make kvm_guest_memfd_supported not rely on KVM_MEMORY_ATTRIBUTE_PRIVATE
> > and check KVM_MEMORY_ATTRIBUTE_PRIVATE separately when the machine
> > requires guest_memfd to serve as private memory.
> >
> > This allows QMEU to create guest memfd with mmap to serve as the memory
> > backend for X86 DEFAULT VM.
> >
> > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/system/kvm.h   | 1 +
> >  accel/kvm/kvm-all.c    | 8 ++++++--
> >  accel/stubs/kvm-stub.c | 5 +++++
> >  system/physmem.c       | 8 ++++++++
> >  4 files changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/system/kvm.h b/include/system/kvm.h
> > index 8f9eecf044..b5811c90f1 100644
> > --- a/include/system/kvm.h
> > +++ b/include/system/kvm.h
> > @@ -561,6 +561,7 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
> >  
> >  int kvm_set_memory_attributes_private(hwaddr start, uint64_t size);
> >  int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);
> > +bool kvm_private_memory_attribute_supported(void);
> >  
> >  int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private);
> >  
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index 28006d73c5..59836ebdff 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -1501,6 +1501,11 @@ int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size)
> >      return kvm_set_memory_attributes(start, size, 0);
> >  }
> >  
> > +bool kvm_private_memory_attribute_supported(void)
> > +{
> > +    return !!(kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
> > +}
> > +
> >  /* Called with KVMMemoryListener.slots_lock held */
> >  static void kvm_set_phys_mem(KVMMemoryListener *kml,
> >                               MemoryRegionSection *section, bool add)
> > @@ -2781,8 +2786,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
> >      kvm_supported_memory_attributes = kvm_vm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
> >      kvm_guest_memfd_supported =
> >          kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
> > -        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
> > -        (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
> > +        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
> >      kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
> >  
> >      if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
> > diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> > index 68cd33ba97..73f04eb589 100644
> > --- a/accel/stubs/kvm-stub.c
> > +++ b/accel/stubs/kvm-stub.c
> > @@ -125,3 +125,8 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
> >  {
> >      return -ENOSYS;
> >  }
> > +
> > +bool kvm_private_memory_attribute_supported(void)
> > +{
> > +    return false;
> > +}
> > diff --git a/system/physmem.c b/system/physmem.c
> > index c9869e4049..3555d2f6f7 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -2211,6 +2211,14 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
> >                         object_get_typename(OBJECT(current_machine->cgs)));
> >              goto out_free;
> >          }
> > +
> > +        if (!kvm_private_memory_attribute_supported()) {
> > +            error_setg(errp, "cannot set up private guest memory for %s: "
> > +                       " KVM does not support private memory attribute",
> > +                       object_get_typename(OBJECT(current_machine->cgs)));
> > +            goto out_free;
> > +        }
> 
> Hm, it took me a while to understand why this is under (new_block->flags
> & RAM_GUEST_MEMFD) but checking for private memory support. If it's at
> all feasible I would just squash all those patches doing
> s/guest_memfd/guest_memfd_private/ to avoid having intermediate patches
> where the terminology is not aligned.

Yeah, the hope is it'll stop being confusing after this series applied.

Keeping them separate is logically more sensible, not only to make review
easier, but the rule that each commit should be self contained and also
minimum..

> 
> Anyway, up to you. For this one:
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Thanks!

-- 
Peter Xu



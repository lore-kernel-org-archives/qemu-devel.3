Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7F1CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 15:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCJcr-00056y-Sx; Fri, 24 Oct 2025 11:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vCJcp-00056b-Sq
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 11:22:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vCJcm-0000xV-FA
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 11:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761319358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IpCyBdc3mGDv318Zks4HT/Qc6yQ7wZTXWSx9OLA37Nc=;
 b=hi9VM9wZOcLx2DB+HMMb1fT7yD0vZc4xvs6osAd98ZilXwrTsDnSwYc8c/cN52Dp57J3Rf
 /PrEJkdVBYtk/Zi9plazJ1U4kAWBoCiCIEC9u2hjhqJykQxTTf9sj+Cuga9OE8a10CF591
 2cmWZsm2bukY2XnmAmFc7w31T/BRdFE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-5fLl6ihoMNmTqc55lq9maA-1; Fri, 24 Oct 2025 11:22:37 -0400
X-MC-Unique: 5fLl6ihoMNmTqc55lq9maA-1
X-Mimecast-MFC-AGG-ID: 5fLl6ihoMNmTqc55lq9maA_1761319356
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-871614ad3efso529460085a.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 08:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761319356; x=1761924156;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IpCyBdc3mGDv318Zks4HT/Qc6yQ7wZTXWSx9OLA37Nc=;
 b=YZDJ52g5J+XTBroCknGgJKPM+h2wgBRRIGWSG833DoNKrlXVMIEt0C08vgzPUCdI3C
 gd59FHsWlBRX6VeM+NvASASJr+/11nl53MiXkzYhI5RtrOq3JMOMq7Z7AcihflSPZQ6R
 uMZwWS+68//w5QWiq+07MpYVeveTm6Fhylr2VxW7hd8ndVHmjite148pLH7fpAC76+KC
 GoxsNgfJif9P8bcZGRbzGzEYrsrDa39CWGJ06rLxNEg0nXZJj0xg38/4JXbj+/uytPgg
 JSsnYnAzagUxrGtFXCzrKe1EQDd0Hob+FlQBZ1LH/TEOViUp8weCeuIrTXS5245STT/s
 hGxA==
X-Gm-Message-State: AOJu0YwqivYYdtdbTCJX5ORjne8+2w1nMObggTeQWlOsrdeXs7tb/a30
 oVD0Dlx7w16y71PcKh4jrDKpxQ55K/zNrWZTeGA3HdPtzkOR8r6ApswnXZ7Vc4h0+VvNFQ7L/S7
 QdddHuQUk1TRd2Mgc9uGKs7K1fK/b7iDZKqDjkzxRZvcpGCINIQdVdcm5
X-Gm-Gg: ASbGnctwtXikiHhZkygTajcFZOg5jgkTJWDMHvaHYA/iXUDq0vqDKgKFoaiFBSI+ZCU
 tzs9Sz7cP3h2hVCcuyH+nBEq8P8YdSagkl65dCD43hh5BCZbETNOQoq//12UJk51TWBstkU8+E7
 N18EIEOKLdxhrYnzeiG+ndqPmSv3x+fVEOYLB2yToum2iD5bO0b8w/FcFxpa2bWjh4GvyZsVGwC
 wiMrBUQ8bzKmw2WF/ftEG016SYJO/eVPWDQ9jPsVws0wAbKRFmRRLNmjYkHRDMw3FCvBizd/gMr
 H/5Th4qP4lHWZQTRQowUNru18+Ltgw25IjsH1WwM2ONDaSW/YeAM3RibpdY3lPrBp8I=
X-Received: by 2002:a05:620a:1790:b0:82b:2bad:ba33 with SMTP id
 af79cd13be357-89c0f701d5dmr746692585a.2.1761319356330; 
 Fri, 24 Oct 2025 08:22:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpGM6GqLHJH2mN/GoN5HLu0KIpm6mmF/RqYp9a5qytysHqOcX0HWZxDOeYpfvXcwgTXWx1KA==
X-Received: by 2002:a05:620a:1790:b0:82b:2bad:ba33 with SMTP id
 af79cd13be357-89c0f701d5dmr746686685a.2.1761319355737; 
 Fri, 24 Oct 2025 08:22:35 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89c0e586d32sm409929385a.18.2025.10.24.08.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 08:22:34 -0700 (PDT)
Date: Fri, 24 Oct 2025 11:22:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 8/8] hostmem: Support in-place guest memfd to back a VM
Message-ID: <aPuZuf_S-gvOf_7J@x1.local>
References: <20251023185913.2923322-1-peterx@redhat.com>
 <20251023185913.2923322-9-peterx@redhat.com>
 <fe713fb6-56db-4080-b03d-a0c36952ee22@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe713fb6-56db-4080-b03d-a0c36952ee22@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Fri, Oct 24, 2025 at 05:01:44PM +0800, Xiaoyao Li wrote:
> On 10/24/2025 2:59 AM, Peter Xu wrote:
> > Host backends supports guest-memfd now by detecting whether it's a
> > confidential VM.  There's no way to choose it yet from the memory level to
> > use it in-place.  If we use guest-memfd, it so far always implies we need
> > two layers of memory backends, while the guest-memfd only provides the
> > private set of pages.
> > 
> > This patch introduces a way so that QEMU can consume guest memfd as the
> > only source of memory to back the object (aka, in place), rather than
> > having another backend supporting the pages converted to shared.
> > 
> > To use the in-place guest-memfd, one can add a memfd object with:
> > 
> >    -object memory-backend-memfd,guest-memfd=on,share=on
> > 
> > Note that share=on is required with in-place guest_memfd.
> 
> First, I'm not sure "in-place" is the proper wording here. At first glance
> on the series, I thought it's something related to "in-place" page
> conversion. After reading a bit, I really that it is enabling guest memfd
> with mmap support to serve as normal memory backend.

It'll be only proper in current context of qemu, but yes I'm aware CoCo
also has such idea, so at least I should have come up with something
better. My bad.  When I wrote the patches a while ago it wasn't as clear,
and I didn't pay attention when I prepare them upstream.

> 
> Second, my POC implementation chose to implement a separate and specific
> memory-backend type "memory-backend-guest-memfd". Your approach to add an
> option of "guest-memfd" to memory-backend-memfd looks OK to me and it
> requires less code. But I think we need to explicitly error out to users
> when they set "guest_memfd" to on with unsupported properties configured,
> e.g., "hugetlb", "hugetlbsize", and "seal".

In my local tree I actually reused hugetlb* parameters, that needs
Ackerley's 1G kernel patches, and some mine on top.

Before I go and reply your other series..  I was definitely not aware that
anyone has been working on it!  Could you share a pointer?  Or is it still
in a private branch?

I'm more than happy to drop this series if you have an older / better
version.  Then I can rebase whatever I work on top.

> 
> Third, the intended usage of gmem with mmap from KVM/kernel's perspective is
> userspace configures the meomry slot by passing the gmem fd to @guest_memfd
> and @guest_memfd of struct kvm_userspace_memory_region2 instead of passing
> the user address returned by mmap of the fd to @userspace_addr return mmap()
> as this patch does. Surely the usage of this path works. But when QEMU is
> going to support in-place conversion of gmem, we has to pass the
> @guest_memfd.
> Well, this is no issue now and we can handle it in the future when needed.

Yes, that's something the private guest-memfd would need.  For completely
shared guest-memfd, IIUC we will use a lot of different code paths, the
goal is to make old APIs work not only for KVM_SET_USER_MEMORY_REGION, but
for all the rest modules like vhost-kernel, vhost-user, and so on.

> 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   qapi/qom.json            |  6 +++-
> >   backends/hostmem-memfd.c | 66 +++++++++++++++++++++++++++++++++++++---
> >   2 files changed, 67 insertions(+), 5 deletions(-)
> > 
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 830cb2ffe7..6b090fe9a0 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -764,13 +764,17 @@
> >   # @seal: if true, create a sealed-file, which will block further
> >   #     resizing of the memory (default: true)
> >   #
> > +# @guest-memfd: if true, use guest-memfd to back the memory region.
> > +#     (default: false, since: 10.2)
> > +#
> >   # Since: 2.12
> >   ##
> >   { 'struct': 'MemoryBackendMemfdProperties',
> >     'base': 'MemoryBackendProperties',
> >     'data': { '*hugetlb': 'bool',
> >               '*hugetlbsize': 'size',
> > -            '*seal': 'bool' },
> > +            '*seal': 'bool',
> > +            '*guest-memfd': 'bool' },
> >     'if': 'CONFIG_LINUX' }
> >   ##
> > diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> > index ea93f034e4..1fa16c1e1d 100644
> > --- a/backends/hostmem-memfd.c
> > +++ b/backends/hostmem-memfd.c
> > @@ -18,6 +18,8 @@
> >   #include "qapi/error.h"
> >   #include "qom/object.h"
> >   #include "migration/cpr.h"
> > +#include "system/kvm.h"
> > +#include <linux/kvm.h>
> >   OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
> > @@ -28,6 +30,13 @@ struct HostMemoryBackendMemfd {
> >       bool hugetlb;
> >       uint64_t hugetlbsize;
> >       bool seal;
> > +    /*
> > +     * NOTE: this differs from HostMemoryBackend's guest_memfd_private,
> > +     * which represents a internally private guest-memfd that only backs
> > +     * private pages.  Instead, this flag marks the memory backend will
> > +     * 100% use the guest-memfd pages in-place.
> > +     */
> > +    bool guest_memfd;
> >   };
> >   static bool
> > @@ -47,10 +56,40 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
> >           goto have_fd;
> >       }
> > -    fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
> > -                           m->hugetlb, m->hugetlbsize, m->seal ?
> > -                           F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
> > -                           errp);
> > +    if (m->guest_memfd) {
> > +        /* User choose to use in-place guest-memfd to back the VM.. */
> > +        if (!backend->share) {
> > +            error_setg(errp, "In-place guest-memfd must be used with share=on");
> > +            return false;
> > +        }
> > +
> > +        /*
> > +         * This is the request to have a guest-memfd to back private pages.
> > +         * In-place guest-memfd doesn't work like that.  Disable it for now
> > +         * to make it simple, so that each memory backend can only have
> > +         * guest-memfd either as private, or fully shared.
> > +         */
> > +        if (backend->guest_memfd_private) {
> > +            error_setg(errp, "In-place guest-memfd cannot be used with another "
> > +                       "private guest-memfd");
> > +            return false;
> > +        }
> 
> Add kvm_enabled() here, otherwise the following calling of
> kvm_create_guest_memfd() emits confusing information when accelerator is not
> configured as KVM, e.g., -machine q35,accel=tcg
> 
> qemu-system-x86: KVM does not support guest_memfd
> 
> 
> > +        /* TODO: add huge page support */
> > +        fd = kvm_create_guest_memfd(backend->size,
> > +                                    GUEST_MEMFD_FLAG_MMAP |
> > +                                    GUEST_MEMFD_FLAG_INIT_SHARED,
> > +                                    errp);
> > +        if (fd < 0) {
> > +            return false;
> > +        }
> > +    } else {
> > +        fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
> > +                               m->hugetlb, m->hugetlbsize, m->seal ?
> > +                               F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
> > +                               errp);
> > +    }
> > +
> >       if (fd == -1) {
> >           return false;
> >       }
> > @@ -65,6 +104,18 @@ have_fd:
> >                                             backend->size, ram_flags, fd, 0, errp);
> >   }
> > +static bool
> > +memfd_backend_get_guest_memfd(Object *o, Error **errp)
> > +{
> > +    return MEMORY_BACKEND_MEMFD(o)->guest_memfd;
> > +}
> > +
> > +static void
> > +memfd_backend_set_guest_memfd(Object *o, bool value, Error **errp)
> > +{
> > +    MEMORY_BACKEND_MEMFD(o)->guest_memfd = value;
> > +}
> > +
> >   static bool
> >   memfd_backend_get_hugetlb(Object *o, Error **errp)
> >   {
> > @@ -152,6 +203,13 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
> >           object_class_property_set_description(oc, "hugetlbsize",
> >                                                 "Huge pages size (ex: 2M, 1G)");
> >       }
> > +
> > +    object_class_property_add_bool(oc, "guest-memfd",
> > +                                   memfd_backend_get_guest_memfd,
> > +                                   memfd_backend_set_guest_memfd);
> > +    object_class_property_set_description(oc, "guest-memfd",
> > +                                          "Use guest memfd");
> > +
> >       object_class_property_add_bool(oc, "seal",
> >                                      memfd_backend_get_seal,
> >                                      memfd_backend_set_seal);
> 

-- 
Peter Xu



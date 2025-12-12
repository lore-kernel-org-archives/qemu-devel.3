Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB84D59D6F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 17:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU79R-0003cV-IM; Fri, 12 Dec 2025 12:41:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vU79L-0003bt-EC
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:41:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vU79H-0007O0-5X
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:41:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765561306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1+8jv00MddKKIXyAZcBGoWNhmCtATBEd0rdJiomvH5c=;
 b=BVoZygGtUCz8uE46DeEHUdXb/q9OuSGN1txNnm+7RnVOA+QwkX+sQgJQEGJ0TI+DE2mXTJ
 0E/koiPPvUDCLNfYrGY9Bbqa+na62ZHNvZ+XbV9adrOTaxeo/eOBfHV8fGExJ4gS9tYapK
 UNQfqo9tbgyT45cA/gmGl1DVwjYaoRs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-21iIox3MOCiIeHqjJvyb5A-1; Fri, 12 Dec 2025 12:41:45 -0500
X-MC-Unique: 21iIox3MOCiIeHqjJvyb5A-1
X-Mimecast-MFC-AGG-ID: 21iIox3MOCiIeHqjJvyb5A_1765561304
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b2f0be2cf0so431587985a.0
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 09:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765561304; x=1766166104; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1+8jv00MddKKIXyAZcBGoWNhmCtATBEd0rdJiomvH5c=;
 b=EaDYYJvo6+q0aC6/6q3VMX1milO08Xh8SrjmR6MBTXhL1kabeOBxrUPxSYmr4xq9Wt
 NGsakn42eHlm2JsnxchlqwvcjwXQhIZAeJRQLc6E+m+x9mh9F0zKuSAMYa3AVi1kXd9Q
 p6xwtzm3jmuzrfmdpKmh/qzUA8J8uHUQS7xojeAF/4LAQP77PvvLhoh7OLBrqPl3dGTl
 uYm0XYqgATbAB7z6Y4G6Xq3ouUv1CPRmTdDXr0cdGJ44phkMYunZK4vTQE/zPtbW6Xo5
 yA0upJ4bUij7gOPmeFqF5Y5pjWiIMcZt2ngGddo5w5KjuTzsBkqhc5yLIIOE5wZg9YJT
 pdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765561304; x=1766166104;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1+8jv00MddKKIXyAZcBGoWNhmCtATBEd0rdJiomvH5c=;
 b=sBx1IcDcwAtsyVXuDv6OfkxxHYfe0wBWFs5bxPQ7iEZVogOvzSx8kC2I8q38wfizFG
 H07xokEtbOjR6sa4s1+2hWVZqqpGngS8AHc75fLh4PhGnfQ7OFA9BIkcVZYYISwwlvkD
 VAkkZDI3x1xbIsEGbMmnnKgWCTw2E2CVjvKb2Q14nl9ajUQWDL4LQJkhoxlzKOrD5Uj/
 LzVVxyhnbKVSsh6Q8rxZvTpCU7xC5t/Ln9Bw64Cwao5y688ZASZoEZKLSpNJ21L/+Gnr
 /5XnVvMBP2Hg8GIZtkcVKQ6KtFyKgqkgGp+A5q0/L2thCzVeJQ5PYmXHs8BgN6wsn4n6
 VUIQ==
X-Gm-Message-State: AOJu0YyoCCGJHM8PaeN3O+8NgzT9Ej12KCgFqe2DypnfGisMTuTA1Hss
 WdCP464qfJWZVlWbdnBhcJxgBoo+m41/egj/tYbwkXswIrUgi1RVQsdiGLwLI/Qh33RnMRuqBW5
 RutSsGAl6DIdHcrA7kaAsUIqfHYZxoR6VgnJMjxFKQ8EAkj0GLC26FRUW
X-Gm-Gg: AY/fxX4od1pRsLC4Y741tYYMaFper40C90+Ixit3wQlzxDlj3rX4R6j6Xj3PMJ1Er8X
 lRIhEQV754tTwOVNV8hFw1y89KsRr4EinzT8JU2Rg80ShFobWOG6yjKiuFqNvvirGleK225/m3/
 FQ6O8XA5imwut1NdVqn8IEqGNMpFQ/DUDpzPuEW/xzYiny+uK4NCWgtfDq7fGtNpr52q4X0MnMU
 rwmwhrC1k9UfCQigdCTGBPcgDfMdX+ZlNJ1AR1h0Xe2A171P1YOLnfrhKOB3YnxODgpEfTvh1yk
 PZr36AZugKucb/S6NfJDIIpw66vRCz0A9dR0A1qHVVjtTV3/Ek03+T898re/gW2gPZqbh7k88J7
 fnrg=
X-Received: by 2002:a05:620a:178d:b0:8b2:f1f3:901e with SMTP id
 af79cd13be357-8bb3a38770dmr354147085a.65.1765561303557; 
 Fri, 12 Dec 2025 09:41:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZIQyZhKPY2rlx1Fkzsd/xBHAFFhqHeq9/lsK9VXjArGHsa/CdVY6Rq15MXMc4AePRtphd8Q==
X-Received: by 2002:a05:620a:178d:b0:8b2:f1f3:901e with SMTP id
 af79cd13be357-8bb3a38770dmr354141885a.65.1765561302974; 
 Fri, 12 Dec 2025 09:41:42 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88881a1ddb6sm14954206d6.53.2025.12.12.09.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 09:41:42 -0800 (PST)
Date: Fri, 12 Dec 2025 12:41:41 -0500
From: Peter Xu <peterx@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 7/9] hostmem: Support in-place guest memfd to back a VM
Message-ID: <aTxT1SLlqhfb4QZZ@x1.local>
References: <20251119172913.577392-1-peterx@redhat.com>
 <20251119172913.577392-8-peterx@redhat.com>
 <2ee4383c-f21f-448e-ac3f-2b621d687bf2@intel.com>
 <aTrw6Xtg_GRh1DQO@x1.local>
 <b9309d98-381b-4531-925c-a4558be1428a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9309d98-381b-4531-925c-a4558be1428a@intel.com>
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

On Fri, Dec 12, 2025 at 11:05:44AM +0800, Xiaoyao Li wrote:
> On 12/12/2025 12:27 AM, Peter Xu wrote:
> > On Thu, Dec 11, 2025 at 03:41:46PM +0800, Xiaoyao Li wrote:
> > > On 11/20/2025 1:29 AM, Peter Xu wrote:
> > > > Host backends supports guest-memfd now by detecting whether it's a
> > > > confidential VM.  There's no way to choose it yet from the memory level to
> > > > use it in-place.  If we use guest-memfd, it so far always implies we need
> > > > two layers of memory backends, while the guest-memfd only provides the
> > > > private set of pages.
> > > > 
> > > > This patch introduces a way so that QEMU can consume guest memfd as the
> > > > only source of memory to back the object (aka, in place), rather than
> > > > having another backend supporting the pages converted to shared.
> > > > 
> > > > To use the in-place guest-memfd, one can add a memfd object with:
> > > > 
> > > >     -object memory-backend-memfd,guest-memfd=on,share=on
> > > > 
> > > > Note that share=on is required with in-place guest_memfd.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > 
> > > overall looks good to me except a few comments below,
> > > 
> > > Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > 
> > > > ---
> > > >    qapi/qom.json            |  6 +++-
> > > >    backends/hostmem-memfd.c | 66 +++++++++++++++++++++++++++++++++++++---
> > > >    2 files changed, 67 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > > index 6f5c9de0f0..9ebf17bfc7 100644
> > > > --- a/qapi/qom.json
> > > > +++ b/qapi/qom.json
> > > > @@ -763,13 +763,17 @@
> > > >    # @seal: if true, create a sealed-file, which will block further
> > > >    #     resizing of the memory (default: true)
> > > >    #
> > > > +# @guest-memfd: if true, use guest-memfd to back the memory region.
> > > > +#     (default: false, since: 11.0)
> > > > +#
> > > >    # Since: 2.12
> > > >    ##
> > > >    { 'struct': 'MemoryBackendMemfdProperties',
> > > >      'base': 'MemoryBackendProperties',
> > > >      'data': { '*hugetlb': 'bool',
> > > >                '*hugetlbsize': 'size',
> > > > -            '*seal': 'bool' },
> > > > +            '*seal': 'bool',
> > > > +            '*guest-memfd': 'bool' },
> > > >      'if': 'CONFIG_LINUX' }
> > > >    ##
> > > > diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> > > > index ea93f034e4..1fa16c1e1d 100644
> > > > --- a/backends/hostmem-memfd.c
> > > > +++ b/backends/hostmem-memfd.c
> > > > @@ -18,6 +18,8 @@
> > > >    #include "qapi/error.h"
> > > >    #include "qom/object.h"
> > > >    #include "migration/cpr.h"
> > > > +#include "system/kvm.h"
> > > > +#include <linux/kvm.h>
> > > >    OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
> > > > @@ -28,6 +30,13 @@ struct HostMemoryBackendMemfd {
> > > >        bool hugetlb;
> > > >        uint64_t hugetlbsize;
> > > >        bool seal;
> > > > +    /*
> > > > +     * NOTE: this differs from HostMemoryBackend's guest_memfd_private,
> > > > +     * which represents a internally private guest-memfd that only backs
> > > > +     * private pages.  Instead, this flag marks the memory backend will
> > > > +     * 100% use the guest-memfd pages in-place.
> > > > +     */
> > > > +    bool guest_memfd;
> > > >    };
> > > >    static bool
> > > > @@ -47,10 +56,40 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
> > > >            goto have_fd;
> > > >        }
> > > > -    fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
> > > > -                           m->hugetlb, m->hugetlbsize, m->seal ?
> > > > -                           F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
> > > > -                           errp);
> > > > +    if (m->guest_memfd) {
> > > > +        /* User choose to use in-place guest-memfd to back the VM.. */
> > > > +        if (!backend->share) {
> > > > +            error_setg(errp, "In-place guest-memfd must be used with share=on");
> > > > +            return false;
> > > > +        }
> > > > +
> > > > +        /*
> > > > +         * This is the request to have a guest-memfd to back private pages.
> > > > +         * In-place guest-memfd doesn't work like that.  Disable it for now
> > > 
> > > This seems not correct to me. I think in-place guest-memfd can work with
> > > guest_memfd_private. The former serves as shared memory and referenced by
> > > the userspace_addr while the latter serves as private memory referenced by
> > > the fd of guest_memfd.
> > > 
> > > While the argument of "disable it for now to make it simple" does make sense
> > > to me.
> > 
> > Oops, I forgot to touch up quite a few places that kept mentioning
> > in-place, sorry.
> > 
> > I'll squash this diff into this patch when repost:
> > 
> > diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> > index 1fa16c1e1d..e9e288651e 100644
> > --- a/backends/hostmem-memfd.c
> > +++ b/backends/hostmem-memfd.c
> > @@ -57,16 +57,16 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
> >       }
> >       if (m->guest_memfd) {
> > -        /* User choose to use in-place guest-memfd to back the VM.. */
> > +        /* User choose to use fully shared guest-memfd to back the VM.. */
> >           if (!backend->share) {
> > -            error_setg(errp, "In-place guest-memfd must be used with share=on");
> > +            error_setg(errp, "Guest-memfd=on must be used with share=on");
> 
> lower-case the guest-memfd? since it's the name of the property?

Sure.

> 
> >               return false;
> >           }
> >           /*
> >            * This is the request to have a guest-memfd to back private pages.
> > -         * In-place guest-memfd doesn't work like that.  Disable it for now
> > -         * to make it simple, so that each memory backend can only have
> > +         * Fully shared guest-memfd doesn't work like that.  Disable it for
> > +         * now to make it simple, so that each memory backend can only have
> >            * guest-memfd either as private, or fully shared.
> >            */
> >           if (backend->guest_memfd_private) {
> 
> After rethinking on it, I think we just remove the check. There is nothing
> from QEMU side to prevent such usage. It is KVM currently that doesn't
> support INIT_SHARED guest-memfd for confidential VMs.
> 
> If we change to KVM to allow it:
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 8bb8830561d4..a658b636a9cf 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -13957,7 +13957,8 @@ bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
>   */
>  bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
>  {
> -       return !kvm_arch_has_private_mem(kvm);
> +       return true;
> +
> 
> and remove this check in QEMU, it can actually boot a TDX guest with
> fully-shared guest-memfd back'ed as shared part.

Yes, logically I also don't see an issue with it.  I wanted to add more
restrictions because that's not an expected way of consuming fully shared.

But I don't see it a must indeed.  In practise, IIUC it's not triggerable
anyway with the current KVM (as IIUC the flags will report less when CoCo
is on..).  Let me drop it when repost.

> 
> > I'll also fix the commit message on in-place, now the one to be reposted:
> > 
> >    hostmem: Support fully shared guest memfd to back a VM
> >    Host backends supports guest-memfd now by detecting whether it's a
> >    confidential VM.  There's no way to choose it yet from the memory level to
> >    use it fully shared.  If we use guest-memfd, it so far always implies we
> >    need two layers of memory backends, while the guest-memfd only provides the
> >    private set of pages.
> >    This patch introduces a way so that QEMU can consume guest memfd as the
> >    only source of memory to back the object (aka, fully shared), rather than
> >    having another backend supporting the pages converted to shared.
> 
> As above, I think what the patch achieves is to enable guest-memfd (with
> MMAP and INIT_SHARED) to back shared memory. And it is not conflicted with
> using another guest-memfd to back private memory.

Sure.

> 
> >    To use the fully shared guest-memfd, one can add a memfd object with:
> >      -object memory-backend-memfd,guest-memfd=on,share=on
> >    Note that share=on is required with fully shared guest_memfd.
> > 
> > I'll not take your R-b as of now, please check and ack again if you see fit
> > after reading.
> > 
> > > 
> > > > +         * to make it simple, so that each memory backend can only have
> > > > +         * guest-memfd either as private, or fully shared.
> > > > +         */
> > > > +        if (backend->guest_memfd_private) {
> > > > +            error_setg(errp, "In-place guest-memfd cannot be used with another "
> > > > +                       "private guest-memfd");
> > > > +            return false;
> > > > +        }
> > > 
> > > please add the following check as I commented in v1:
> > > 
> > > 	if (!kvm_enabled()) {
> > > 		error_setg(errp, "in-place guest-memfd requires KVM");
> > > 		return false;
> > > 	}
> > 
> > IMHO it's redundant to set here, when kvm not enabled,
> > kvm_create_guest_memfd() should be a stub.
> 
> No. The KVM stub is for the case where KVM is disable at compile time.
> 
> The kvm_enabled() check here is for the case where users use different
> accelerators other than KVM, e.g., -accel tcg.

I thought the kvm-compiled case is already covered, at least the flags will
be 0 here:

    if (!kvm_guest_memfd_supported) {
        error_setg(errp, "KVM does not support guest_memfd");
        return -1;
    }

So I can change below stub patch into this one, would it look better (so
that we'll provide explicit errors for all cases)?

===8<===
commit 70012ceb70d3ffe624db33a8aeaaec581c7b4ccd
Author: Peter Xu <peterx@redhat.com>
Date:   Thu Dec 11 11:19:44 2025 -0500

    kvm: Provide explicit error for kvm_create_guest_memfd()
    
    So that there will be a verbal string returned when kvm not enabled, or kvm
    not compiled.
    
    Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c    | 5 +++++
 accel/stubs/kvm-stub.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 68d57c1af0..c32fbcf9cc 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4492,6 +4492,11 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
         .flags = flags,
     };
 
+    if (!kvm_enabled()) {
+        error_setg(errp, "guest-memfd requires KVM accelerator");
+        return -1;
+    }
+
     if (!kvm_guest_memfd_supported) {
         error_setg(errp, "KVM does not support guest_memfd");
         return -1;
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 73f04eb589..01b1d6285e 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -123,6 +123,7 @@ bool kvm_hwpoisoned_mem(void)
 
 int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
 {
+    error_setg(errp, "KVM is not enabled");
     return -ENOSYS;
 }
===8<===

Thanks,

> 
> > However indeed I found the stub didn't set an error, so how about add one
> > trivial patch to add a verbal error for it instead?
> > 
> > commit aeeaba6dfc68a1c89af90c12f36cb8fe48faecfd
> > Author: Peter Xu <peterx@redhat.com>
> > Date:   Thu Dec 11 11:19:44 2025 -0500
> > 
> >      kvm/stub: Provide explicit error for kvm_create_guest_memfd()
> >      So that there will be a verbal string returned when kvm not enabled.
> >      Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   accel/stubs/kvm-stub.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> > index 73f04eb589..01b1d6285e 100644
> > --- a/accel/stubs/kvm-stub.c
> > +++ b/accel/stubs/kvm-stub.c
> > @@ -123,6 +123,7 @@ bool kvm_hwpoisoned_mem(void)
> >   int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
> >   {
> > +    error_setg(errp, "KVM is not enabled");
> >       return -ENOSYS;
> >   }
> > 
> > IIUC it'll achieve the same goal with better layering.
> > 
> > > 
> > > > +        /* TODO: add huge page support */
> > > > +        fd = kvm_create_guest_memfd(backend->size,
> > > > +                                    GUEST_MEMFD_FLAG_MMAP |
> > > > +                                    GUEST_MEMFD_FLAG_INIT_SHARED,
> > > > +                                    errp);
> > > > +        if (fd < 0) {
> > > > +            return false;
> > > > +        }
> > > 
> > > how about just removing the fd check here because ...
> > 
> > We needed it because at least the stub returns -ENOSYS..
> > 
> > I can remove it, but I'll need to change below to "fd<0" check.  That I can
> > do.
> 
> yeah, change to "fd < 0" looks better.
> 
> > Thanks,
> > 
> > > 
> > > > +    } else {
> > > > +        fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
> > > > +                               m->hugetlb, m->hugetlbsize, m->seal ?
> > > > +                               F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
> > > > +                               errp);
> > > > +    }
> > > > +
> > > >        if (fd == -1) {
> > > >            return false;
> > > >        }
> > > 
> > > ... the existing check can work for the guest memfd as well.
> > > 
> 

-- 
Peter Xu



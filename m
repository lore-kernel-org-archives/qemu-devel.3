Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D369DD41D68
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTjVt-0007au-Hx; Thu, 11 Dec 2025 11:27:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTjVr-0007aj-UF
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:27:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTjVo-0002Jm-DH
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765470446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dCPyk+7pju6V8lgfBUQINZGcEzqq5EpDhsc0zBN7554=;
 b=KFDGR38e3WojFXZiGK8cyFdhQBcqP5SrdbKWxWGfFS/0g7qi4hKoUsOS91Id+R1G1mb0w0
 oONwRYB+UX7aA+rEDhqqGtHzSLV8VmwHb6MCyYCVsMrZ7jf0GRiFnrWp6NSyLiSnYTRIr3
 V6D8cMfa30RQvy7+dhmWw4uAdVL6cHg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-SucLBiuqO2yejoMyZv8ZEQ-1; Thu, 11 Dec 2025 11:27:24 -0500
X-MC-Unique: SucLBiuqO2yejoMyZv8ZEQ-1
X-Mimecast-MFC-AGG-ID: SucLBiuqO2yejoMyZv8ZEQ_1765470444
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b2dbf4d6a4so63073685a.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 08:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765470444; x=1766075244; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dCPyk+7pju6V8lgfBUQINZGcEzqq5EpDhsc0zBN7554=;
 b=o5MJaQUvUmOsWwZbpRWrnqHh0ZA4QfQPZDVDmPHDV5nqLW2oBSNcfFYdZU9V6RYvnM
 cf4iWjBR4CW2QfNyaV2L+R+iK+KiqCQXVOLC6l9k8jpL1OUefcX4spEGSnDRBwUHqbyw
 0+bDWod6JhpTtDQza6pBxYfHbWmC4Lm/qjW5tjMJKSWIju8gWsrtrZOL7BQriJ8ABVc5
 0qJenuNv1+d7hptANZVzW0uPAa4THwV0NuUjmZB4Q3Zsxjf39w2gAQd/budj3t8epVFJ
 CmDz++ObHWCV3OtpzfnfvPWA/r2+rvlQgBuzdrG/U6aBBRGgzt0LGp6/BBHh6hKe0lUw
 7CFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765470444; x=1766075244;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dCPyk+7pju6V8lgfBUQINZGcEzqq5EpDhsc0zBN7554=;
 b=BgzYaxsw2Fzg4ByBRAsn099LBve0O6EXaj+fCYkSCuCpQMsbXOWXL+NIaw6qdrMFQg
 2sxqGxOozhB1vu3HwAcfjuAldLO1zY4U/EigvD3j3rc/GLsy+AZc//UTA/udM23Hz+Z1
 /yJPq8YALCAqlxKEeu/1TvWnb4c/vYakYdEht7zy1Ob8pSpMODz5G4HQmsLEOryPjG/a
 G8nI0357VSG8GgiSWWAbCo3j8FrJiHn7D+wefvz2ywqVYr3N+bS7NunlHLmPfsCHPHxv
 v/2Jvl2lu1Jl7HMUhfqXxPNetyD9LsVEoa3q8r6h01p/Mgz7Bg1PfONxs5gVHCPp5XDl
 RDzA==
X-Gm-Message-State: AOJu0Yyy4LaFwLn8zeya81E2dADn3zplaDrfrY19WXQ7ysoc6ygyEbuk
 zNwOygnGzoRNEFQ6qQEZyBGxi3Y0kdu2/YgUgoexiTej5vo+Y3itfhNO91DsoQmhrQJeSVS5rnO
 cTk9kCo3+QjlpmCe8fEmX1Y64JfmFIsjEAdbJF5UHR+xTdqGu8ZclxvDU
X-Gm-Gg: AY/fxX5s22203XqhlTX+M+t9fRsGe70Pp9dGrndSMJ1Fhwfqh6mzsEIhiarWOi1y+BE
 NGO1zORO7E+jriGOnDCklKpRDu8/wIjfhjyJVlXpu8b+fFLWdYTQczWnOGuNd+FLrHxyxbVKKWN
 tj2HvPr+9xtyugDboOdFlZNnYZsu4mUfHkNmOLa7EqDT/Z9gBWYnAJvbiA7TNwXlG+MNC7SvuRJ
 lpMDWkknn2/RgwkgC2XPfi7kWsv+9er1HfAvG80+KazfzX9lKjrOywQxrOkjFnKz97snd5DmGhH
 Ncnwk4Imc0ErcAeF85KN0OaRReEgwNaq2IzxINNDJ+LEljl07ioikPmQih1WzqeLC9Vb+XBY5O9
 Sh1o=
X-Received: by 2002:a05:622a:1450:b0:4f0:2258:fe1e with SMTP id
 d75a77b69052e-4f1b19b51c6mr81217281cf.10.1765470443569; 
 Thu, 11 Dec 2025 08:27:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE++jkpIINp8T6Bxd0ung6luxNcBrOZ4dpsFkEhBNeSTnER+t+N/LmrkE71gepsulw+xjC+BA==
X-Received: by 2002:a05:622a:1450:b0:4f0:2258:fe1e with SMTP id
 d75a77b69052e-4f1b19b51c6mr81216881cf.10.1765470443022; 
 Thu, 11 Dec 2025 08:27:23 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f1bd58d034sm24270561cf.5.2025.12.11.08.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 08:27:22 -0800 (PST)
Date: Thu, 11 Dec 2025 11:27:21 -0500
From: Peter Xu <peterx@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 7/9] hostmem: Support in-place guest memfd to back a VM
Message-ID: <aTrw6Xtg_GRh1DQO@x1.local>
References: <20251119172913.577392-1-peterx@redhat.com>
 <20251119172913.577392-8-peterx@redhat.com>
 <2ee4383c-f21f-448e-ac3f-2b621d687bf2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ee4383c-f21f-448e-ac3f-2b621d687bf2@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Dec 11, 2025 at 03:41:46PM +0800, Xiaoyao Li wrote:
> On 11/20/2025 1:29 AM, Peter Xu wrote:
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
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> overall looks good to me except a few comments below,
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> > ---
> >   qapi/qom.json            |  6 +++-
> >   backends/hostmem-memfd.c | 66 +++++++++++++++++++++++++++++++++++++---
> >   2 files changed, 67 insertions(+), 5 deletions(-)
> > 
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 6f5c9de0f0..9ebf17bfc7 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -763,13 +763,17 @@
> >   # @seal: if true, create a sealed-file, which will block further
> >   #     resizing of the memory (default: true)
> >   #
> > +# @guest-memfd: if true, use guest-memfd to back the memory region.
> > +#     (default: false, since: 11.0)
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
> 
> This seems not correct to me. I think in-place guest-memfd can work with
> guest_memfd_private. The former serves as shared memory and referenced by
> the userspace_addr while the latter serves as private memory referenced by
> the fd of guest_memfd.
> 
> While the argument of "disable it for now to make it simple" does make sense
> to me.

Oops, I forgot to touch up quite a few places that kept mentioning
in-place, sorry.

I'll squash this diff into this patch when repost:

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 1fa16c1e1d..e9e288651e 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -57,16 +57,16 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     }
 
     if (m->guest_memfd) {
-        /* User choose to use in-place guest-memfd to back the VM.. */
+        /* User choose to use fully shared guest-memfd to back the VM.. */
         if (!backend->share) {
-            error_setg(errp, "In-place guest-memfd must be used with share=on");
+            error_setg(errp, "Guest-memfd=on must be used with share=on");
             return false;
         }
 
         /*
          * This is the request to have a guest-memfd to back private pages.
-         * In-place guest-memfd doesn't work like that.  Disable it for now
-         * to make it simple, so that each memory backend can only have
+         * Fully shared guest-memfd doesn't work like that.  Disable it for
+         * now to make it simple, so that each memory backend can only have
          * guest-memfd either as private, or fully shared.
          */
         if (backend->guest_memfd_private) {

I'll also fix the commit message on in-place, now the one to be reposted:

  hostmem: Support fully shared guest memfd to back a VM
  
  Host backends supports guest-memfd now by detecting whether it's a
  confidential VM.  There's no way to choose it yet from the memory level to
  use it fully shared.  If we use guest-memfd, it so far always implies we
  need two layers of memory backends, while the guest-memfd only provides the
  private set of pages.
  
  This patch introduces a way so that QEMU can consume guest memfd as the
  only source of memory to back the object (aka, fully shared), rather than
  having another backend supporting the pages converted to shared.
  
  To use the fully shared guest-memfd, one can add a memfd object with:
  
    -object memory-backend-memfd,guest-memfd=on,share=on
  
  Note that share=on is required with fully shared guest_memfd.

I'll not take your R-b as of now, please check and ack again if you see fit
after reading.

> 
> > +         * to make it simple, so that each memory backend can only have
> > +         * guest-memfd either as private, or fully shared.
> > +         */
> > +        if (backend->guest_memfd_private) {
> > +            error_setg(errp, "In-place guest-memfd cannot be used with another "
> > +                       "private guest-memfd");
> > +            return false;
> > +        }
> 
> please add the following check as I commented in v1:
> 
> 	if (!kvm_enabled()) {
> 		error_setg(errp, "in-place guest-memfd requires KVM");
> 		return false;
> 	}

IMHO it's redundant to set here, when kvm not enabled,
kvm_create_guest_memfd() should be a stub.

However indeed I found the stub didn't set an error, so how about add one
trivial patch to add a verbal error for it instead?

commit aeeaba6dfc68a1c89af90c12f36cb8fe48faecfd
Author: Peter Xu <peterx@redhat.com>
Date:   Thu Dec 11 11:19:44 2025 -0500

    kvm/stub: Provide explicit error for kvm_create_guest_memfd()
    
    So that there will be a verbal string returned when kvm not enabled.
    
    Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/stubs/kvm-stub.c | 1 +
 1 file changed, 1 insertion(+)

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

IIUC it'll achieve the same goal with better layering.

> 
> > +        /* TODO: add huge page support */
> > +        fd = kvm_create_guest_memfd(backend->size,
> > +                                    GUEST_MEMFD_FLAG_MMAP |
> > +                                    GUEST_MEMFD_FLAG_INIT_SHARED,
> > +                                    errp);
> > +        if (fd < 0) {
> > +            return false;
> > +        }
> 
> how about just removing the fd check here because ...

We needed it because at least the stub returns -ENOSYS..

I can remove it, but I'll need to change below to "fd<0" check.  That I can
do.

Thanks,

> 
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
> 
> ... the existing check can work for the guest memfd as well.
> 
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



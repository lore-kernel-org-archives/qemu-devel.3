Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55D9C5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 14:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuW4n-0006Gw-Hy; Thu, 13 Aug 2026 10:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuW4m-0006GO-57
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 10:06:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuW4j-0003vw-Is
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 10:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786629987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b16fmMwKu+HWDYKJLuFLIupEmUyJiO3RjwTtt8deoC0=;
 b=KYATVETf+p9ZdfKPZD8Lw4YX6k/WLC66R1C+eire814OK9M1q9QfH7mEEsAJw4R43dUTnJ
 89PNw+0ecv0pm3kOEb5IGZqbdhyn9dy05ioZqkQ3sjv9KBw25TfqfQc9KE5O18TQRfremA
 zd+MZLqIdsn6HUqOUPmlNoDVtRynoHU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-ys4PERW8NYGJwBD0fdVdnA-1; Thu, 13 Aug 2026 10:06:25 -0400
X-MC-Unique: ys4PERW8NYGJwBD0fdVdnA-1
X-Mimecast-MFC-AGG-ID: ys4PERW8NYGJwBD0fdVdnA_1786629984
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c1f74261f67so211116066b.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786629984; x=1787234784; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b16fmMwKu+HWDYKJLuFLIupEmUyJiO3RjwTtt8deoC0=;
 b=Qpusgk2jPgn0qY6Jnp4Svr/pM/1W3LeTZc0ON5oWhQ6c0DIXSteuHJQ/6WwE1PnLr8
 CJPy0dNJAN5mbw/6eU/OoURtA/5QhmlEQr+n4jOvWcZJ+QHuMEuBC57Q2HM95FV7AHp9
 X5H+SGU+qjYbYPEgB3giqFa0VhhU2Yy8WKOeB5UOcltU+ptTnTV1hFRz/fsM6xJbufiG
 g3mnv6VonQxzFLu9wpfF6Uhku0AcPFrnZbXyQLVJ6NrwGFZO0T+BtYLryWuy1K6bxqzC
 +GjlKA+fG1jAaimg26dXrH/O0N7Zxs7dAUCRZWcN36cU4ujkMsDOJLvaafKyHA8PSQ4B
 TFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786629984; x=1787234784;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=b16fmMwKu+HWDYKJLuFLIupEmUyJiO3RjwTtt8deoC0=;
 b=QArGmmHFuSfMvV469uzm3e3vinNRyy/hxzOUNUyMvwyhKLNL+ieNY1gcV5/8hBKxNg
 gj4TNr+Kxm/tjLBKCRE4hkbYZuKn+iShycv9ubWDUkReZsMi5Ll3WvWAaplNHCQv8YvO
 k8a6cvIr1kcM7SI+4FT2l3qiLHlmSqdoK6GOlkXNY1n3moCBF1A3tt01U4ziAJJ8SkII
 p71OcTHyd1I+w4w0tcz5ZE7LC28WcFEdplW4LylGO4xXjROp16tMogzlzoxXXg/QIbA9
 Qot/UignJXH585sXjlMrAhaL829N6SOwZjxZsfD61VZxu6wopniDZlQIKaW7XOgNUCOF
 ZvWw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/+pXqwtcmyraf2TNiD8S06DlsWpAr0XzA6OSNkosQ8Snne3PTwBI25oHlyEbxgpg3FELtivDKbUjn@nongnu.org
X-Gm-Message-State: AOJu0YxD+g60+5xdAXEgkCnvGEUzFy8i9XQ43lc4DcjjM6Ador/poToe
 /YnAjGSxrgH+UQ8lf/0U8w6/nCNbdEvbhwIU/j6RSmLSSYNRm1VsuxlMuOaCuYwB66larg5oec7
 dcn8qzgj/gT3IBbhFitNr/f7yVNV37Q00vfZcSxApOShRpFSTbvgOsA0d
X-Gm-Gg: AR+sD13JXk7dQvhkg4sY0K6VqR1J3lhM2bN35Opf6b6HnI8hLg9fZz92pDqM4kNSW5R
 sh0IS75/cHJoI8kiZOgNF2PxId62L28IAjB3XggAmfA8dNTLE1cpcdqcNq4abZefBAUvJruOyIY
 +qEJNG8uOwdVoqXUbZWnvT/4gAB44iElWANCVFVykB5iNmsDkohRK1JHFv8v5/UZRA6bRMbbKkk
 AkCF9Nh6qwAm+d3ln4NOHeVYiA9k6fsujOtlwQRGAhVQfITPMSDW8CiZq0JTgHif85jZofavAyi
 SvI50WOIAeQa4w3VmVefB2qGqWUfVHBkvnyOrG2YcBA0PrGcB1iNFFpB+yOkeFCf8gtURV/M
X-Received: by 2002:a17:907:7246:b0:c1f:983f:d8a with SMTP id
 a640c23a62f3a-c2108fc8906mr283789166b.24.1786629983907; 
 Thu, 13 Aug 2026 07:06:23 -0700 (PDT)
X-Received: by 2002:a17:907:7246:b0:c1f:983f:d8a with SMTP id
 a640c23a62f3a-c2108fc8906mr283785066b.24.1786629983325; 
 Thu, 13 Aug 2026 07:06:23 -0700 (PDT)
Received: from x1.local ([2605:8d80:6cc9:637f:db7f:22cd:4098:82fd])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c210889558fsm94183866b.61.2026.08.13.07.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 07:06:22 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:06:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 jmarcin@redhat.com, david@kernel.org, pbonzini@redhat.com,
 chenyi.qiang@intel.com, farosas@suse.de, aik@amd.com, xiaoyao.li@intel.com
Subject: Re: [PATCH v4 08/12] hostmem: Support fully shared guest memfd to
 back a VM
Message-ID: <an3PWdPIdb6afDsS@x1.local>
References: <20260812201938.198915-1-michael.roth@amd.com>
 <20260812201938.198915-9-michael.roth@amd.com>
 <an1_NmWhtHY_Cf9V@redhat.com> <an24aI4sAILoxncp@x1.local>
 <an29FY93x45qnJuR@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <an29FY93x45qnJuR@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Aug 13, 2026 at 01:48:21PM +0100, Daniel P. Berrangé wrote:
> On Thu, Aug 13, 2026 at 08:28:24AM -0400, Peter Xu wrote:
> > On Thu, Aug 13, 2026 at 09:24:22AM +0100, Daniel P. Berrangé wrote:
> > > On Wed, Aug 12, 2026 at 03:16:46PM -0500, Michael Roth wrote:
> > > > From: Peter Xu <peterx@redhat.com>
> > > > 
> > > > Host backends supports guest-memfd now by detecting whether it's a
> > > > confidential VM.  There's no way to choose it yet from the memory level to
> > > > use it fully shared.  If we use guest-memfd, it so far always implies we
> > > > need two layers of memory backends, while the guest-memfd only provides the
> > > > private set of pages.
> > > > 
> > > > This patch introduces a way so that QEMU can consume guest memfd as the
> > > > only source of memory to back the object (aka, fully shared).
> > > > 
> > > > To use the fully shared guest-memfd, one can add a memfd object with:
> > > > 
> > > >   -object memory-backend-memfd,guest-memfd=on,share=on
> > > > 
> > > > Note that share=on is required with fully shared guest_memfd.
> > > > 
> > > > PS: there's a trivial touch-up on fd<0 check, because the stub to create
> > > > guest-memfd may return negative but not -1.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > > > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > > > ---
> > > >  backends/hostmem-memfd.c | 56 ++++++++++++++++++++++++++++++++++++----
> > > >  qapi/qom.json            |  6 ++++-
> > > >  2 files changed, 56 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> > > > index ea93f034e4..fbe65b00be 100644
> > > > --- a/backends/hostmem-memfd.c
> > > > +++ b/backends/hostmem-memfd.c
> > > > @@ -18,6 +18,8 @@
> > > >  #include "qapi/error.h"
> > > >  #include "qom/object.h"
> > > >  #include "migration/cpr.h"
> > > > +#include "system/kvm.h"
> > > > +#include <linux/kvm.h>
> > > >  
> > > >  OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
> > > >  
> > > > @@ -28,6 +30,13 @@ struct HostMemoryBackendMemfd {
> > > >      bool hugetlb;
> > > >      uint64_t hugetlbsize;
> > > >      bool seal;
> > > > +    /*
> > > > +     * NOTE: this differs from HostMemoryBackend's guest_memfd_private,
> > > > +     * which represents an internally private guest-memfd that only backs
> > > > +     * private pages.  Instead, this flag marks the memory backend will
> > > > +     * 100% use the guest-memfd pages in-place.
> > > > +     */
> > > > +    bool guest_memfd;
> > > >  };
> > > >  
> > > >  static bool
> > > > @@ -47,11 +56,29 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
> > > >          goto have_fd;
> > > >      }
> > > >  
> > > > -    fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
> > > > -                           m->hugetlb, m->hugetlbsize, m->seal ?
> > > > -                           F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
> > > > -                           errp);
> > > > -    if (fd == -1) {
> > > > +    if (m->guest_memfd) {
> > > > +        if (!backend->share) {
> > > > +            error_setg(errp, "guest-memfd=on must be used with share=on");
> > > > +            return false;
> > > > +        } else if (m->seal) {
> > > > +            error_setg(errp, "guest-memfd=on must be used with seal=off");
> > > > +            return false;
> > > > +        } else if (m->hugetlb) {
> > > > +            error_setg(errp, "guest-memfd=on must be used with hugetlb=off");
> > > 
> > > Reporting an error without returning false like the other cases.
> > > 
> > > > +        }
> > > > +
> > > > +        fd = kvm_create_guest_memfd(backend->size,
> > > > +                                    GUEST_MEMFD_FLAG_MMAP |
> > > > +                                    GUEST_MEMFD_FLAG_INIT_SHARED,
> > > > +                                    errp);
> > > > +    } else {
> > > > +        fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
> > > > +                               m->hugetlb, m->hugetlbsize, m->seal ?
> > > > +                               F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
> > > > +                               errp);
> > > > +    }
> > > > +
> > > > +    if (fd < 0) {
> > > >          return false;
> > > >      }
> > > >      cpr_save_fd(name, 0, fd);
> > > > @@ -65,6 +92,18 @@ have_fd:
> > > >                                            backend->size, ram_flags, fd, 0, errp);
> > > >  }
> > > >  
> > > > +static bool
> > > > +memfd_backend_get_guest_memfd(Object *o, Error **errp)
> > > > +{
> > > > +    return MEMORY_BACKEND_MEMFD(o)->guest_memfd;
> > > > +}
> > > > +
> > > > +static void
> > > > +memfd_backend_set_guest_memfd(Object *o, bool value, Error **errp)
> > > > +{
> > > > +    MEMORY_BACKEND_MEMFD(o)->guest_memfd = value;
> > > > +}
> > > > +
> > > >  static bool
> > > >  memfd_backend_get_hugetlb(Object *o, Error **errp)
> > > >  {
> > > > @@ -152,6 +191,13 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
> > > >          object_class_property_set_description(oc, "hugetlbsize",
> > > >                                                "Huge pages size (ex: 2M, 1G)");
> > > >      }
> > > > +
> > > > +    object_class_property_add_bool(oc, "guest-memfd",
> > > > +                                   memfd_backend_get_guest_memfd,
> > > > +                                   memfd_backend_set_guest_memfd);
> > > > +    object_class_property_set_description(oc, "guest-memfd",
> > > > +                                          "Use guest memfd");
> > > > +
> > > >      object_class_property_add_bool(oc, "seal",
> > > >                                     memfd_backend_get_seal,
> > > >                                     memfd_backend_set_seal);
> > > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > > index c55776af7d..ee981fc44c 100644
> > > > --- a/qapi/qom.json
> > > > +++ b/qapi/qom.json
> > > > @@ -771,13 +771,17 @@
> > > >  # @seal: if true, create a sealed-file, which will block further
> > > >  #     resizing of the memory (default: true)
> > > >  #
> > > > +# @guest-memfd: if true, use guest-memfd to back the memory region.
> > > > +#     (default: false, since: 11.2)
> > > > +#
> > > >  # Since: 2.12
> > > >  ##
> > > >  { 'struct': 'MemoryBackendMemfdProperties',
> > > >    'base': 'MemoryBackendProperties',
> > > >    'data': { '*hugetlb': 'bool',
> > > >              '*hugetlbsize': 'size',
> > > > -            '*seal': 'bool' },
> > > > +            '*seal': 'bool',
> > > > +            '*guest-memfd': 'bool' },
> > > >    'if': 'CONFIG_LINUX' }
> > > 
> > > We're reusing the 'memory-backend-memfd' class, and then at runtime
> > > refusing allow the user to control any of properties in
> > > MemoryBackendProperties.
> > 
> > gmemfd should be able to use all ultimately.
> > 
> > For seal, IMHO it's already implied, kind of forced seal=on but it doesn't
> > matter, gmemfd was introduced with sealing, at least what QEMU implies with
> > "F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL".  So IMHO we could ignore what
> > user selected and assume it's ON.
> 
> Then we should not have a 'seal' property defined for guest memfd
> at all. Defining a property and then ignoring it, or only ever
> allowing 1 value to be set is a design mistake. The property should
> not exist if it can't ever be changed by the user/app.
> 
> > For hugetlb, we will support hugetlb (and allow specify hugetlb size) for
> > gmem in the future I believe.  It's only that this is done one step at a
> > time so we haven't supported it yet, while the kernel support is still in
> > progress.
> 
> The problem with this idea is that it makes it impossible for a mgmt
> app to know if hugetlb is supported or not, as QEMU will always
> report it supported against memory-backend-memfd.
> 
> Having a memory-backend-guest-memfd ensures the public interface
> matches what is actually implemented/permitted for guest memfd.
> 
> > > "memory-backend-memfd,guest-memfd=on|off" is switching between two
> > > separate implementations of the class.
> > > 
> > > This whole thing is just shouting "use a different class".
> > > 
> > > There is no meaningful sharing of code here, and the sharing of the
> > > public interface is offering apps no value as the impl prevents them
> > > from choosing the value of the properties - they have to be set of
> > > certain values which are not introspectable.
> > > 
> > > Please introduce a "memory-backend-guest-memfd" backend instead.
> > 
> > This is indeed what Michael used to suggest, and we were discussing in
> > previous version on which is better,
> > 
> > https://lore.kernel.org/r/rjqfiwh57gip3u3psqg33jhmo7ixaj2qwzupc7zdk7f3d26qnu@tglactz67ogk
> > 
> > The hope is this is also easier for either libvirt or most users, but
> > please correct me if it's not the case, especially for libvirt.  The plan
> > is when CoCo flags are provided, all things will automatically switch to a
> > CoCo-friendly implementation within QEMU.
> > 
> > It also means here the guest-memfd= parameter shouldn't be needed in real
> > CoCo contexts because they'll simply be implied (no cmdline change needed
> > for the same "-object memory-backend-memfd" one used to use without CoCo).
> > It's only needed for only special use of guest-memfd, in this case
> > init-shared is the special case where CoCo doesn't use.
> 
> Reading all this, IMHO reusing memory-backend-memfd for the current
> Coco support was a design mistake, it should have have a
> memory-backend-guest-memfd object from the start.
> 
> Given that we need to be able to control memfd vs guest-memfd for
> the non-Coco case, it is still worth introducing the new object
> class today.
> 
> Even if the two classes shared all their properties (which they
> don't given the comment about 'seal' being always on), then a
> "foo=on|off" that toggles two separate impls is still creating
> a pair of sub-classes by the backdoor. 

The idea of that, at least in my mind.. is an user shouldn't need to worry
about differences of guest-memfd and memfd, QEMU should just do it for the
users, based on the machine configurations.  Memfd is a concept more widely
spread, the hope is anyone using guest-memfd should simply treat it as one
memfd, no matter it is shared, in-place converted, two-layer-backed, or
whatever is happening underneath.

Now we do create guest-memfd via a separate ioctl, what if we can create it
via memfd_create() syscall too?  Then do we need to do the separation from
QEMU layer?

IMHO that is now an ioctl is not required; it really can be part of
memfd_create() syscall, it's just easier to manage, e.g. it's completely
KVM alone, and it also has attached to the KVM instance.  The idea is still
similar, and we can see that from possibly shared properties here on huge
pages and so.  I don't treat seal= a block just to introduce a new object
for that, and I expect as gmemfd evolves it will gradually get most
features memfd supports.. like folio migration and so.. but I could be
wrong.

IMHO one major question to ask is, is it more convenient for libvirt to
have that new object?  Please keep in mind that after we introduce this as
a new object, we may start to introduce even more *-guest-memfd in the
future, we roughly talked about DAX in the previous discussion.  My goal is
to make it most convenient for either user or libvirt to maintain the
cmdlines for QEMU, but if you think that makes libvirt live harder instead,
I've no strong feeling to go back to what Michael initially suggested.

For example, if libvirt wants to detect hugetlb supports for an object, it
can still pass in the parameters and test-boot a QEMU and then IIUC it'll
still correctly capture an error for gmemfd case.  It might be that I
didn't really get what will make libvirt complex by reusing the object, but
I'll definitely follow your judgement on that.

Thanks,

-- 
Peter Xu



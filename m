Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB3FC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 12:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuUY8-0007ya-MT; Thu, 13 Aug 2026 08:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuUY6-0007yS-Uz
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 08:28:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuUY4-0003hi-P9
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 08:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786624118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tydCjltfWAuFdXnDnOsSZ1PqFbfWbSS3q7Lmj92Umv8=;
 b=P0HQWHAt6ZaDLBLNoafUVQinuIEmXAEoqTu0YD9m47PWQzC65bmoYVelEsiK37TaAsGVq/
 vt9GSEINFchGb1ooLS1ZSIZTO38GY2Iqs5zixq0r4uuc2IuDUAav5zDFGXcXSMkojGYH5v
 /cI6MbfbCj9JoE3yeUCkZOrpmFHI1Ws=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-YQPX4cMwOPmbvNpn_PRAWg-1; Thu, 13 Aug 2026 08:28:37 -0400
X-MC-Unique: YQPX4cMwOPmbvNpn_PRAWg-1
X-Mimecast-MFC-AGG-ID: YQPX4cMwOPmbvNpn_PRAWg_1786624117
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-930b571432fso90415485a.0
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 05:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786624117; x=1787228917; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tydCjltfWAuFdXnDnOsSZ1PqFbfWbSS3q7Lmj92Umv8=;
 b=Glsn/hDXZhYCbVad3z6PUtVVk0BfXEt3/aw1+VzDREzW4laJZ7Kbwy6LJEoZL0on3z
 do9GZ/qScwXjqExwWpy782vUNUGKGe3odrq9NQNvbcwLrtn+I4Q5z6cujgdyDQMQ6v1r
 8c+d0dLNub0QnB/Qvg+tLLuIN7oQfug1hq6U3IsiddOcfE3xTLawuQwhNDNVcCt2GtKJ
 3CpLbJ2LBi1LCdjLT3jNKRMy/opBHEWxJKI99AspImQPizOT2oFSg53vl6BQ5GCr53kd
 lmZQhslQylY8NZTb81wlvrjmz73JmX8PI4QwpqBNehWbqIRkYILvnB2uc5qvFujSIhwu
 /Upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786624117; x=1787228917;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tydCjltfWAuFdXnDnOsSZ1PqFbfWbSS3q7Lmj92Umv8=;
 b=eSc3g9kmgrZQofFPuPGvFzz+mNqKjnJ1nYfwLe2MAJxZDjtVJqLxEURQ5Q6LALTQ/6
 7M21lAKWvAW8Z7lrgGVvcFhHj8iFD+6EAEjpeIegIJPr/WAP46gIFjb/yRK5IUayaKGi
 kwFcuJ/cGyxVvBBcGIbeqqTmi/q367qywOCUn/XHjAn0TLrwILkFgJTzRNa1RPBsTIsd
 FVx7qhbCudXZoli67L8nW8xRh7J7tlsjub+QCtX2EOuu9a7MpCUcMnwaE054bTvuZBTT
 XJZiNL86Zow/c4//aoURYkTXOcGdK9/z1i74VDUqCuIaR/kUZPaZLmS9/ild9a7tcKsU
 IaMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoAC661lHXTKLzzUlj7WFDsZVGt2hLOoqgkiQi0kzO+z0R0A0yDdaS3YzCagjTSMkPvcqPXntEAvdh/@nongnu.org
X-Gm-Message-State: AOJu0YxbDKisYXo8csvWhUCQPikkRasLFY3GGe2ZrMPofxgG/HFnrpwC
 4d/2FAxBDTCkpFyn5W/p5/xQXNQu41Gg4joAmw+cfLt3aSrspZH0F+y/p7cgLjPEuhsTansX05D
 UiTLkcPbLRn+phnGVKemIFbCbG4LpTnQ76QhjCRl5CijuH9Svy+F2hX9N
X-Gm-Gg: AR+sD11oxtyx71A2U5lH0B4TdLJrUw4lvttoOs/X2o+CgOkS6bvNyWysw+aaSCYgGJP
 aoASXiBIkxMHvwrhF/Z5gWvEyR4n/e6VPvQ2NMwbRmgowHnjbmrSt9QSkDJ6g3l0HUhLnQnQJ07
 uPZxtNMjDGDSoBNxN2SYX2IAje0pY0cH9P/6OAgei2bfbTG67gw5WaCxmxCx2BdRzHK5zMCjUds
 PVM661h49VIwroNhpe7Y8G61yA9oVhmXJvWQwDnY8R2scj9sILkBjKTKjY9Ba2aIbDlB265fEaG
 u7FJ5PFULb17hlhTMI/mfPvI/d3u+SuRJSX9q99hgKa13FYveaHagIhjQMJHEyXkSeRc
X-Received: by 2002:a05:620a:ac12:b0:936:5a38:2fe7 with SMTP id
 af79cd13be357-936c0b88e2emr403324585a.15.1786624116899; 
 Thu, 13 Aug 2026 05:28:36 -0700 (PDT)
X-Received: by 2002:a05:620a:ac12:b0:936:5a38:2fe7 with SMTP id
 af79cd13be357-936c0b88e2emr403319285a.15.1786624116323; 
 Thu, 13 Aug 2026 05:28:36 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936c1bac5b4sm134943185a.47.2026.08.13.05.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 05:28:35 -0700 (PDT)
Date: Thu, 13 Aug 2026 08:28:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 jmarcin@redhat.com, david@kernel.org, pbonzini@redhat.com,
 chenyi.qiang@intel.com, farosas@suse.de, aik@amd.com, xiaoyao.li@intel.com
Subject: Re: [PATCH v4 08/12] hostmem: Support fully shared guest memfd to
 back a VM
Message-ID: <an24aI4sAILoxncp@x1.local>
References: <20260812201938.198915-1-michael.roth@amd.com>
 <20260812201938.198915-9-michael.roth@amd.com>
 <an1_NmWhtHY_Cf9V@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <an1_NmWhtHY_Cf9V@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 13, 2026 at 09:24:22AM +0100, Daniel P. Berrangé wrote:
> On Wed, Aug 12, 2026 at 03:16:46PM -0500, Michael Roth wrote:
> > From: Peter Xu <peterx@redhat.com>
> > 
> > Host backends supports guest-memfd now by detecting whether it's a
> > confidential VM.  There's no way to choose it yet from the memory level to
> > use it fully shared.  If we use guest-memfd, it so far always implies we
> > need two layers of memory backends, while the guest-memfd only provides the
> > private set of pages.
> > 
> > This patch introduces a way so that QEMU can consume guest memfd as the
> > only source of memory to back the object (aka, fully shared).
> > 
> > To use the fully shared guest-memfd, one can add a memfd object with:
> > 
> >   -object memory-backend-memfd,guest-memfd=on,share=on
> > 
> > Note that share=on is required with fully shared guest_memfd.
> > 
> > PS: there's a trivial touch-up on fd<0 check, because the stub to create
> > guest-memfd may return negative but not -1.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > ---
> >  backends/hostmem-memfd.c | 56 ++++++++++++++++++++++++++++++++++++----
> >  qapi/qom.json            |  6 ++++-
> >  2 files changed, 56 insertions(+), 6 deletions(-)
> > 
> > diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> > index ea93f034e4..fbe65b00be 100644
> > --- a/backends/hostmem-memfd.c
> > +++ b/backends/hostmem-memfd.c
> > @@ -18,6 +18,8 @@
> >  #include "qapi/error.h"
> >  #include "qom/object.h"
> >  #include "migration/cpr.h"
> > +#include "system/kvm.h"
> > +#include <linux/kvm.h>
> >  
> >  OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
> >  
> > @@ -28,6 +30,13 @@ struct HostMemoryBackendMemfd {
> >      bool hugetlb;
> >      uint64_t hugetlbsize;
> >      bool seal;
> > +    /*
> > +     * NOTE: this differs from HostMemoryBackend's guest_memfd_private,
> > +     * which represents an internally private guest-memfd that only backs
> > +     * private pages.  Instead, this flag marks the memory backend will
> > +     * 100% use the guest-memfd pages in-place.
> > +     */
> > +    bool guest_memfd;
> >  };
> >  
> >  static bool
> > @@ -47,11 +56,29 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
> >          goto have_fd;
> >      }
> >  
> > -    fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
> > -                           m->hugetlb, m->hugetlbsize, m->seal ?
> > -                           F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
> > -                           errp);
> > -    if (fd == -1) {
> > +    if (m->guest_memfd) {
> > +        if (!backend->share) {
> > +            error_setg(errp, "guest-memfd=on must be used with share=on");
> > +            return false;
> > +        } else if (m->seal) {
> > +            error_setg(errp, "guest-memfd=on must be used with seal=off");
> > +            return false;
> > +        } else if (m->hugetlb) {
> > +            error_setg(errp, "guest-memfd=on must be used with hugetlb=off");
> 
> Reporting an error without returning false like the other cases.
> 
> > +        }
> > +
> > +        fd = kvm_create_guest_memfd(backend->size,
> > +                                    GUEST_MEMFD_FLAG_MMAP |
> > +                                    GUEST_MEMFD_FLAG_INIT_SHARED,
> > +                                    errp);
> > +    } else {
> > +        fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
> > +                               m->hugetlb, m->hugetlbsize, m->seal ?
> > +                               F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
> > +                               errp);
> > +    }
> > +
> > +    if (fd < 0) {
> >          return false;
> >      }
> >      cpr_save_fd(name, 0, fd);
> > @@ -65,6 +92,18 @@ have_fd:
> >                                            backend->size, ram_flags, fd, 0, errp);
> >  }
> >  
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
> >  static bool
> >  memfd_backend_get_hugetlb(Object *o, Error **errp)
> >  {
> > @@ -152,6 +191,13 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
> >          object_class_property_set_description(oc, "hugetlbsize",
> >                                                "Huge pages size (ex: 2M, 1G)");
> >      }
> > +
> > +    object_class_property_add_bool(oc, "guest-memfd",
> > +                                   memfd_backend_get_guest_memfd,
> > +                                   memfd_backend_set_guest_memfd);
> > +    object_class_property_set_description(oc, "guest-memfd",
> > +                                          "Use guest memfd");
> > +
> >      object_class_property_add_bool(oc, "seal",
> >                                     memfd_backend_get_seal,
> >                                     memfd_backend_set_seal);
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index c55776af7d..ee981fc44c 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -771,13 +771,17 @@
> >  # @seal: if true, create a sealed-file, which will block further
> >  #     resizing of the memory (default: true)
> >  #
> > +# @guest-memfd: if true, use guest-memfd to back the memory region.
> > +#     (default: false, since: 11.2)
> > +#
> >  # Since: 2.12
> >  ##
> >  { 'struct': 'MemoryBackendMemfdProperties',
> >    'base': 'MemoryBackendProperties',
> >    'data': { '*hugetlb': 'bool',
> >              '*hugetlbsize': 'size',
> > -            '*seal': 'bool' },
> > +            '*seal': 'bool',
> > +            '*guest-memfd': 'bool' },
> >    'if': 'CONFIG_LINUX' }
> 
> We're reusing the 'memory-backend-memfd' class, and then at runtime
> refusing allow the user to control any of properties in
> MemoryBackendProperties.

gmemfd should be able to use all ultimately.

For seal, IMHO it's already implied, kind of forced seal=on but it doesn't
matter, gmemfd was introduced with sealing, at least what QEMU implies with
"F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL".  So IMHO we could ignore what
user selected and assume it's ON.

For hugetlb, we will support hugetlb (and allow specify hugetlb size) for
gmem in the future I believe.  It's only that this is done one step at a
time so we haven't supported it yet, while the kernel support is still in
progress.

> 
> "memory-backend-memfd,guest-memfd=on|off" is switching between two
> separate implementations of the class.
> 
> This whole thing is just shouting "use a different class".
> 
> There is no meaningful sharing of code here, and the sharing of the
> public interface is offering apps no value as the impl prevents them
> from choosing the value of the properties - they have to be set of
> certain values which are not introspectable.
> 
> Please introduce a "memory-backend-guest-memfd" backend instead.

This is indeed what Michael used to suggest, and we were discussing in
previous version on which is better,

https://lore.kernel.org/r/rjqfiwh57gip3u3psqg33jhmo7ixaj2qwzupc7zdk7f3d26qnu@tglactz67ogk

The hope is this is also easier for either libvirt or most users, but
please correct me if it's not the case, especially for libvirt.  The plan
is when CoCo flags are provided, all things will automatically switch to a
CoCo-friendly implementation within QEMU.

It also means here the guest-memfd= parameter shouldn't be needed in real
CoCo contexts because they'll simply be implied (no cmdline change needed
for the same "-object memory-backend-memfd" one used to use without CoCo).
It's only needed for only special use of guest-memfd, in this case
init-shared is the special case where CoCo doesn't use.

Please check if you agree after reading above.  We can definitely still
rethink the interfacing.

Thanks,

-- 
Peter Xu



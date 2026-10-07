Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F94CA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xESpv-0001RD-RO; Wed, 07 Oct 2026 10:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xESpc-0001HX-Ln
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:41:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xESpa-0002Qq-Un
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791384078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jFt7LVBGVzBv7QOFbPaAF9oy0ndJs61Ahiugq1XkAs8=;
 b=iJoJu95Qk0sIqgQO90WPCVor2rqQIkZyzNcw3gC/Aj+WYgPPfx3eeSxD9UykYgECPmtBq9
 Gv618eOoAZTHa5VB85xf8buIFeUaeJmh0UN8OqH9urBXmzoea3qSI2ZNSab9q9k++iVFV6
 JRvgHu15zd7KDqV5rMbXOiLkp6D3Yec=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-lo0dST5mOnSkUq2_N7rcTA-1; Wed, 07 Oct 2026 10:41:17 -0400
X-MC-Unique: lo0dST5mOnSkUq2_N7rcTA-1
X-Mimecast-MFC-AGG-ID: lo0dST5mOnSkUq2_N7rcTA_1791384076
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e82060977so8243585a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 07:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791384076; x=1791988876; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jFt7LVBGVzBv7QOFbPaAF9oy0ndJs61Ahiugq1XkAs8=;
 b=o5kk+BUdqXT5OBLapfoqQizkkQd3vYMdf3AEo4iwqQg1pZfenmJ7LvuF7SSQZNMo10
 mdoGf6HrusaxOnefAR3V4jCtZaDlZpkpGX2xPpGSOXPLv4IXxV3xjj2fXTSnSO9sZPpv
 dLYCrU8qgCNClkvE1u4ggi1pVHAUBCEb2EZ5u5DZx1nv7QHTLuUqaGHbLaUHHEGaacw9
 1X9xS5KEvnPtyl8DBr77jKCEVqObPkLJsCdGKY8hrqzL0ma71MaZrkqETiRpmgl8+zSP
 7LsSFd8Z4NgykAJW2FKH6Ne9K8S5VbMDLWmwqevzLU8rHM6fMQvfVYInPavCEKoHKxXy
 N9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791384076; x=1791988876;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jFt7LVBGVzBv7QOFbPaAF9oy0ndJs61Ahiugq1XkAs8=;
 b=rZ0Up/fNnuldwXJ84zVhGh6yzS9Mxe+92rnr+r0dxr85kpiEwa0/HYfdGpjjuxQsqp
 hhxdTkC4p9TlvIh71Sef8UAW00+tmuRaOvHyDORFVv/ACuK4rz/BgZBpgKXFON9SgKdr
 590ElcV/InADYYg1f8597SodLa7W28PyJ0AEtlrZ28QX+fzmEfD3+ntc3eY3iNim6EWj
 tOkUmTzluktA9/kLG3iZCjbcCaeZjbKZPpO2iv8mdQwniTc60qnaQHvZXM3pKN+kCMMY
 TECwHNf2r0l198mAHpexwcNg5L9s1hy061kAp+W03KKHeJWmWQVrE4clGWS5hlERLmA8
 3kPg==
X-Forwarded-Encrypted: i=1;
 AKwUvByMNyJU77B4TOrLuZRy9Xob43ayA2vDAYWehLekMCbqScWWh/7pZtczzmdWbFyiiInsX08anHkhrFfp@nongnu.org
X-Gm-Message-State: AFuF++l4TcLn3aUuUY7fuZmC7/+1AUCFwDYGQR3gpKR5YXlUy60rKhCi
 hlWOVz5O4R6zDGscfWP9TyUXs47F0y50JPJjJeMM1qFCbgotMoMOJ8s5XZLkC5GqDsI2n4VbQs+
 xcgkNrblM2K9QY+lxnpEh+QlBmbQEwXKErFQ/D5Ggi9i/La+9jBnlMk1J
X-Gm-Gg: AYBFou288Z+PVChH0l7yPp1SnG6PCSkeqg3TF4IuGEv9z7UoiIGu0N94XNV/lxHBW3m
 EBzZbnsJeIZB7uZKXBFV9AyYs1U3C5EmitpvJf7Zr7nw0ZI5xpNRPRH5zUSht0WsoQ0Xl+Tn9uP
 WlBUPXO2PdBvWbhqJ3Ox6ugbVV3UZto63devUE/VtOxi4BXRWewVuoxQFMAMGezZCzHcvIYTYfw
 eWTGMjIx3jfpTdsLIPplx1hvBtHIJXW8y1Nv9cDenOsg3G+zoHsBIU/QQnKVE3d+DnShjv/MQJ+
 fMgSytCYpKeciC0tHN4jzNJ+1WiopncSQvozL3znVDIuOLT/EXREPZmiAuhMmSEPP5HZPpI=
X-Received: by 2002:a05:620a:280c:b0:93a:1196:ce5 with SMTP id
 af79cd13be357-93e860fc57cmr1189024685a.33.1791384076208; 
 Wed, 07 Oct 2026 07:41:16 -0700 (PDT)
X-Received: by 2002:a05:620a:280c:b0:93a:1196:ce5 with SMTP id
 af79cd13be357-93e860fc57cmr1189020185a.33.1791384075486; 
 Wed, 07 Oct 2026 07:41:15 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93e99104dc0sm234803485a.11.2026.10.07.07.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 07:41:14 -0700 (PDT)
Date: Wed, 7 Oct 2026 10:41:13 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] hostmem: fix cpr-exec of VMs with bound guest memory
Message-ID: <asZaCerfcnfmAlIw@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260924125800.4188406-1-den@openvz.org>
 <20260924125800.4188406-2-den@openvz.org>
 <cd0292cf-2a87-4716-a8c9-d87853949c76@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd0292cf-2a87-4716-a8c9-d87853949c76@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Oct 05, 2026 at 09:00:47PM +0200, Maciej S. Szmigiero wrote:
> On 24.09.2026 14:57, Denis V. Lunev wrote:
> > From: Denis V. Lunev <den@openvz.org>
> > 
> > cpr-exec kills a VM whose memory backend has host-nodes when the cgroup
> > no longer allows those nodes.
> 
> What's the use case for starting a VM with a limited set of allowed NUMA
> nodes for its RAM backend(s), then moving this process to a cgroup that
> excludes all these nodes?
> 
> > The old QEMU saves its state, the new one
> > exits during startup with
> > 
> >    cannot bind memory to host NUMA nodes: Invalid argument
> > 
> > and the guest is lost.
> > 
> > Guest RAM survives CPR: its fd is passed to the new QEMU or its backing
> > file is reopened, and the pages stay where they are. For shmem-backed
> > memory the policy set by mbind() lives in the shared object and survives
> > as well. host_memory_backend_memory_complete() treats the memory as
> > fresh anyway: it calls mbind() with MPOL_MF_STRICT | MPOL_MF_MOVE and
> > preallocates again. cpr-exec keeps the PID and the cgroup, so if
> > cpuset.mems has been changed to nodes outside host-nodes since the VM
> > started, mbind() returns EINVAL and QEMU exits. Where it succeeds, it
> > only walks or migrates pages that are already in place, while the guest
> > is stopped.
> > 
> > Skip the NUMA binding and preallocation on incoming CPR. The source
> > blocks CPR while any RAM block cannot be preserved, so every backend
> > created in this mode is an inherited one.
> 
> Are you sure that CPR incoming QEMU can't be launched with additional
> "unused" memory backends?
> 
> > This covers cpr-transfer too,
> > where the new process may be placed in a cgroup that does not allow the
> > original nodes. For a file backend outside shmem the VMA policy is not
> > restored, which affects only pages first touched after the update.
> > Memory added after the incoming migration completes is back on the
> > normal path.
> > 
> > Fixes: 2b7e9739fad8 ("physmem: preserve ram blocks for cpr")
> > Suggested-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > Cc: David Hildenbrand <david@kernel.org>
> > Cc: Igor Mammedov <imammedo@redhat.com>
> > Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Fabiano Rosas <farosas@suse.de>
> > Cc: Mark Kanda <mark.kanda@oracle.com>
> > Cc: Ben Chaney <bchaney@akamai.com>
> > Cc: Steve Sistare <steven.sistare@oracle.com>
> > Cc: qemu-stable@nongnu.org
> > ---
> >   backends/hostmem.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/backends/hostmem.c b/backends/hostmem.c
> > index 02846b597d..26c7fce1cb 100644
> > --- a/backends/hostmem.c
> > +++ b/backends/hostmem.c
> > @@ -24,6 +24,7 @@
> >   #include "qemu/madvise.h"
> >   #include "qemu/cutils.h"
> >   #include "hw/core/qdev.h"
> > +#include "migration/cpr.h"
> >   #ifdef CONFIG_NUMA
> >   #include <numaif.h>
> > @@ -365,6 +366,10 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
> >       if (!backend->dump) {
> >           qemu_madvise(ptr, sz, QEMU_MADV_DONTDUMP);
> >       }
> > +    /* Memory inherited over CPR already has its pages and policy */
> > +    if (cpr_is_incoming()) {
> > +        return;
> > +    }
> TBH silently skipping all the rest of memory backend
> initialization makes me a bit uncomfortable.
> 
> First, it effectively silently ignores the memory backend
> NUMA setting on the incoming CPR QEMU.
> 
> Second, it also skips the backend preallocation step below.
> 
> Instead, would just turning the mbind() hard error in
> that case (on CPR inherited backends only) into a
> warning make it work?

I agree on the questioning of the use case, and I think we should
understand that better before silently skip some failures.

It already sounds like there's a mixture use of ways to do numa assignment
to me.

IIUC host-nodes= should only be used if static binding is desired, I don't
think one should change it, e.g. qom-set doesn't really do anything live.

If flexibility is needed, cgroup seems reasonable, but then host-nodes=
should be unset, AFAIU, otherwise there's the involved question of how
cgroup manager can talk to QEMU's manager so as to update that field.

So to me, the real fix is if memcg used stick with memcg, set whatever used
to be host-nodes= to memcg upfront, then tune with memcg forever with no
host-nodes= parameter.

Thanks,

-- 
Peter Xu



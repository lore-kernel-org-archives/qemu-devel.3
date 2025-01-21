Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49700C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 17:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taIEJ-0005KP-NK; Tue, 21 Jan 2025 12:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1taIEA-0005H1-MW
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 12:39:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1taIE8-0002yo-MG
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 12:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737481186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SJpAcBBlL0DkF/rqvAnTAxWXBbsgTzsvUrzs6vqSQas=;
 b=CHPfyteA96vHwkYh1zAWfjRwHAJ6xsZIKqmbpuznZuAUMxUaeUSuBM+zZPlurR5/VIRNFO
 56v+YwLOCeoMqO0PB+v9mPq4Ky/sEaN//sjzu9f8tcYFKPtsZoiVP0LHy0B0YxUYwgrsLH
 3nPDl+mmQOCFlQo9JlOKmBSFTd0IS0s=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-trF_7XHAO_-7S2SRketxlw-1; Tue, 21 Jan 2025 12:39:45 -0500
X-MC-Unique: trF_7XHAO_-7S2SRketxlw-1
X-Mimecast-MFC-AGG-ID: trF_7XHAO_-7S2SRketxlw
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-468f80df8caso108565721cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 09:39:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737481184; x=1738085984;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJpAcBBlL0DkF/rqvAnTAxWXBbsgTzsvUrzs6vqSQas=;
 b=wjsJ+dkN8Mdb8QPOj1x9MWsMdybz5gUc8DmdIgeOKsNjnL2zLd8SHTJK18zVluLpgc
 K10USWfP9KFaAcWOCQuXdwB/7Fv0NgHrKKmKEOjTVEEzJa++0srWpUf7E3hpSseew3Qm
 2ap2mcCnpnWzOIz3+1SaXdTLModIB44vxYuBxFm8OxwDi6gooZyrzfoOhBbdCifDlRtN
 XIs5nkcgMXDegUDp3yorPOxKTx5Bwc7O+k1fvEfKn+YaUuC41g0ns4CoNDrAdMOWVpS4
 1MgWt82wjwKdDP/vQTLGxT7XqXWQmTgHfgd4wRQRpmNlL/M5CBAbexXjpuBf7/KEmirP
 cXmA==
X-Gm-Message-State: AOJu0YyMezNCefx9wD4g4rRN8xbKJFshmGUKueJMKnBsfbgPC68ryCfl
 O84QWIk2pO9KVoYUEMTlMPGtVlcbEtSDpG79IeepAT7QtUWhGG+1sM17a+tqNqu3g7tLRxORxv5
 /ra62/FYJyX14qC5+sBtp1qgFmXehEX3dgI4dnYl6Q2Z3MEiWMlS0
X-Gm-Gg: ASbGncuf0Kvesxxfc6aNBqAcrC2FAfvz1L91/poIGAgQarbQKujL/TCsHI+r3SCkPEE
 Jl9y5Hx6NOHFtVM4DCpVtOcTKJs2NeHp7dYOYCZMKvYt5668cVJcieW/6q5hBIoRxTJqPMhAgZS
 QHP81f7B1/mRN9S0jEgrst6XjVPMw3rlXUjKZwLsHwZShmazTZwAG8iIx1IE4IAjw13XA78h22C
 jJBQtSxmIbZlnro623CZCV5rhSZG3cYXUsBZ6E65nQKq3N9LXkK6Mme3iAK6cwR1jeSbe1yilO6
 CP+i6ri5F6Jxnnu4wJOUiM59fQMVz5Q=
X-Received: by 2002:a05:622a:593:b0:46c:716f:d76 with SMTP id
 d75a77b69052e-46e12a54b3cmr222521761cf.12.1737481184516; 
 Tue, 21 Jan 2025 09:39:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSOzWJGHqmg9LOa5rr5rY8CrqVpDRBLBM3pf64QCL1gsb574jLKWMD64nEaccRrEDcspqvnQ==
X-Received: by 2002:a05:622a:593:b0:46c:716f:d76 with SMTP id
 d75a77b69052e-46e12a54b3cmr222521401cf.12.1737481184132; 
 Tue, 21 Jan 2025 09:39:44 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e1030e4ddsm56320121cf.40.2025.01.21.09.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 09:39:43 -0800 (PST)
Date: Tue, 21 Jan 2025 12:39:40 -0500
From: Peter Xu <peterx@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 07/49] HostMem: Add mechanism to opt in kvm guest
 memfd via MachineState
Message-ID: <Z4_b3Lrpbnyzyros@x1n>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-8-michael.roth@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240320083945.991426-8-michael.roth@amd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Mar 20, 2024 at 03:39:03AM -0500, Michael Roth wrote:
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> Add a new member "guest_memfd" to memory backends. When it's set
> to true, it enables RAM_GUEST_MEMFD in ram_flags, thus private kvm
> guest_memfd will be allocated during RAMBlock allocation.
> 
> Memory backend's @guest_memfd is wired with @require_guest_memfd
> field of MachineState. It avoid looking up the machine in phymem.c.
> 
> MachineState::require_guest_memfd is supposed to be set by any VMs
> that requires KVM guest memfd as private memory, e.g., TDX VM.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
> Changes in v4:
>  - rename "require_guest_memfd" to "guest_memfd" in struct
>    HostMemoryBackend;	(David Hildenbrand)
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  backends/hostmem-file.c  | 1 +
>  backends/hostmem-memfd.c | 1 +
>  backends/hostmem-ram.c   | 1 +
>  backends/hostmem.c       | 1 +
>  hw/core/machine.c        | 5 +++++
>  include/hw/boards.h      | 2 ++
>  include/sysemu/hostmem.h | 1 +
>  7 files changed, 12 insertions(+)
> 
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index ac3e433cbd..3c69db7946 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -85,6 +85,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>      ram_flags |= fb->readonly ? RAM_READONLY_FD : 0;
>      ram_flags |= fb->rom == ON_OFF_AUTO_ON ? RAM_READONLY : 0;
>      ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> +    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
>      ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
>      ram_flags |= RAM_NAMED_FILE;
>      return memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index 3923ea9364..745ead0034 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -55,6 +55,7 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>      name = host_memory_backend_get_name(backend);
>      ram_flags = backend->share ? RAM_SHARED : 0;
>      ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> +    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
>      return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
>                                            backend->size, ram_flags, fd, 0, errp);
>  }
> diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
> index d121249f0f..f7d81af783 100644
> --- a/backends/hostmem-ram.c
> +++ b/backends/hostmem-ram.c
> @@ -30,6 +30,7 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>      name = host_memory_backend_get_name(backend);
>      ram_flags = backend->share ? RAM_SHARED : 0;
>      ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> +    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
>      return memory_region_init_ram_flags_nomigrate(&backend->mr, OBJECT(backend),
>                                                    name, backend->size,
>                                                    ram_flags, errp);

These change look a bit confusing to me, as I don't see how gmemfd can be
used with either file or ram typed memory backends..

When specified gmemfd=on with those, IIUC it'll allocate both the memory
(ramblock->host) and gmemfd, but without using ->host.  Meanwhile AFAIU the
ramblock->host will start to conflict with gmemfd in the future when it
might be able to be mapp-able (having valid ->host).

I have a local fix for this (and actually more than below.. but starting
from it), I'm not sure whether I overlooked something, but from reading the
cover letter it's only using memfd backend which makes perfect sense to me
so far.  I also don't know the planning of coco patches merging so I don't
think even if valid this is urgent - I don't want to mess up on merging
plans..  but still want to collect some comments on whether it's valid:

===8<===

From edfdf019ab01e99fb4ff417e30bb3692b4e3b922 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 21 Jan 2025 12:31:19 -0500
Subject: [PATCH] hostmem: Disallow guest memfd for FILE or RAM typed backends

Guest memfd has very special semantics, which by default doesn't have a
path at all, meanwhile it won't proactively allocate anonymous memory.

Currently:

  - memory-backend-file: it is about creating a memory object based on a
  path in the file system.  It doesn't apply to gmemfd.

  - memory-backend-ram: it is about (mostly) trying to allocate anonymous
  memories from the system (private or shared).  It also doesn't apply to
  gmemfd.

Forbid the two types of memory backends to gmemfd, but only allow
memory-backend-memfd for it as of now.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 backends/hostmem-file.c | 8 +++++++-
 backends/hostmem-ram.c  | 7 ++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 46321fda84..c94cf8441b 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -52,11 +52,18 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         error_setg(errp, "can't create backend with size 0");
         return false;
     }
+
     if (!fb->mem_path) {
         error_setg(errp, "mem-path property not set");
         return false;
     }
 
+    if (backend->guest_memfd) {
+        error_setg(errp, "File backends do not support guest memfd. "
+                   "Please use memfd backend");
+        return false;
+    }
+
     switch (fb->rom) {
     case ON_OFF_AUTO_AUTO:
         /* Traditionally, opening the file readonly always resulted in ROM. */
@@ -86,7 +93,6 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     ram_flags |= fb->readonly ? RAM_READONLY_FD : 0;
     ram_flags |= fb->rom == ON_OFF_AUTO_ON ? RAM_READONLY : 0;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
     ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
     ram_flags |= RAM_NAMED_FILE;
     return memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
index 39aac6bf35..8125be217c 100644
--- a/backends/hostmem-ram.c
+++ b/backends/hostmem-ram.c
@@ -27,10 +27,15 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         return false;
     }
 
+    if (backend->guest_memfd) {
+        error_setg(errp, "File backends do not support guest memfd. "
+                   "Please use memfd backend");
+        return false;
+    }
+
     name = host_memory_backend_get_name(backend);
     ram_flags = backend->share ? RAM_SHARED : 0;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
     return memory_region_init_ram_flags_nomigrate(&backend->mr, OBJECT(backend),
                                                   name, backend->size,
                                                   ram_flags, errp);
-- 
2.47.0
===8<===

Thanks,

-- 
Peter Xu



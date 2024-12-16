Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB51E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 18:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNFhE-0005gP-CD; Mon, 16 Dec 2024 13:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNFh7-0005fn-6y
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 13:19:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNFh4-0002E9-Fy
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 13:19:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734373185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vBBw6wS2jQaRx2jWZAk+TRsAxX+XeX2KQp0Yh1L3zm8=;
 b=ioPWB8+RrrhbCvbXTSb7XQqHky0vQivjhXds7srLLtuVU8P31RlJM14S1CyshuuR3Hn9XF
 xoZoZUpoaU6h0p8GWxgKB3gEed3e8ySoNFWWgcBFH5n0OhrO9xFllFgUH3kQbkZuBgw+by
 h9FAMhB3l7mDDMpEjYC0FFQiB0jw92I=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-YJlkG5FgMWSKxt1spZsiCA-1; Mon, 16 Dec 2024 13:19:38 -0500
X-MC-Unique: YJlkG5FgMWSKxt1spZsiCA-1
X-Mimecast-MFC-AGG-ID: YJlkG5FgMWSKxt1spZsiCA
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b6f1595869so388988485a.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 10:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734373178; x=1734977978;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vBBw6wS2jQaRx2jWZAk+TRsAxX+XeX2KQp0Yh1L3zm8=;
 b=aE7W6YYtOjM8UR2BgG0n5USoC+AEOuSVKvSRQl8ZJfpbNTa2QI5NrS6PlqxfMmaccg
 u01/kvHDWinU432CT4+jbHX0a5XYVeMLFn+YBq+ACCcet63A1fHefLNvkLhJaeMYHxno
 tuiO2am/baPYp9EfZaTNv8ITBoNb+mlisn9958sLEcZQJ1KoXpFrUjtZHB88GL55XEO1
 4g9ZpNT1SvfmqkNEeHymhqGDed3VusC8jQZITmt0CinsovBF+p+sWUz3bRJDBxFjCBSZ
 MMNnhcDPppIDgEYHK3W/FJfjDbcrjp80yXYicOwRmebvwnT1QSu9i/JcWMSz85y1wWh9
 nnvg==
X-Gm-Message-State: AOJu0YwZs3htRMpH3vu2I1fujFzN9yduNepRdAkIo2xT3eloQ5Weyept
 BR1jVuQrfdF2M0EbvcpCdhEv5PI+To8SzUwpDbEevAfT5J0HG7955KTYGAgtD0WU01mOg2JliU4
 +5x6BD5/X83XymnuirclieNMOJb69uyUiZ1edoO4pmvU6evzyxdyY
X-Gm-Gg: ASbGncuj3/Ev1YF6Bvv/EdFXJnoM5+3BRqvZhrQbkeQ/xAzNEfglNhwehStHjk+RM/h
 2uWAPkd235Z2A72t5VDNI5fPtjtupGMGoERI99oUzqwWm78O3Hza7+rJdB0uxzvavjMOlj7lZkg
 l0Gry43K8TTd1c8d4M7xm8lEW9B85PG0G8UPpUhfpYmvcluKzBxPP4E3OW4cWslqc8jJFtrjJxv
 dYJof0zMmNgu4KNSULFbWbqKXRSZDI4KAm7Zus+4AYk3hXn2sIxGV6i3IHBlBZg9jxm0ltGeod+
 peUUpv5udZfOzWMsZQ==
X-Received: by 2002:a05:620a:4412:b0:7b6:dddb:b88 with SMTP id
 af79cd13be357-7b6fbf3d084mr1750247485a.38.1734373178009; 
 Mon, 16 Dec 2024 10:19:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG71ffBYle5dlbOJ8LzifSSZ2oAdrAQAdARxePuYp1NpYiOl6AviOYxRt07hcT4z3lZyJEksA==
X-Received: by 2002:a05:620a:4412:b0:7b6:dddb:b88 with SMTP id
 af79cd13be357-7b6fbf3d084mr1750244085a.38.1734373177545; 
 Mon, 16 Dec 2024 10:19:37 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7048cad55sm245941785a.107.2024.12.16.10.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 10:19:36 -0800 (PST)
Date: Mon, 16 Dec 2024 13:19:34 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V4 02/19] physmem: fd-based shared memory
Message-ID: <Z2BvNs1zTz42Tpqx@x1n>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-3-git-send-email-steven.sistare@oracle.com>
 <Z1dIEUcSrI1aROSp@x1n>
 <ecbae03f-a8b2-4a41-89bc-5a671a4c3c7e@oracle.com>
 <Z1tUBUcpf1XcVRhG@x1n>
 <bf0e7550-54a0-42ff-a281-6a65cb1ba7b5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf0e7550-54a0-42ff-a281-6a65cb1ba7b5@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
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

On Fri, Dec 13, 2024 at 11:41:45AM -0500, Steven Sistare wrote:
> On 12/12/2024 4:22 PM, Peter Xu wrote:
> > On Thu, Dec 12, 2024 at 03:38:00PM -0500, Steven Sistare wrote:
> > > On 12/9/2024 2:42 PM, Peter Xu wrote:
> > > > On Mon, Dec 02, 2024 at 05:19:54AM -0800, Steve Sistare wrote:
> > > > > @@ -2089,13 +2154,23 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
> > > > >        new_block->page_size = qemu_real_host_page_size();
> > > > >        new_block->host = host;
> > > > >        new_block->flags = ram_flags;
> > > > > +
> > > > > +    if (!host && !xen_enabled()) {
> > > > 
> > > > Adding one more xen check is unnecessary.  This patch needed it could mean
> > > > that the patch can be refactored.. because we have xen checks in both
> > > > ram_block_add() and also in the fd allocation path.
> > > > 
> > > > At the meantime, see:
> > > > 
> > > > qemu_ram_alloc_from_fd():
> > > >       if (kvm_enabled() && !kvm_has_sync_mmu()) {
> > > >           error_setg(errp,
> > > >                      "host lacks kvm mmu notifiers, -mem-path unsupported");
> > > >           return NULL;
> > > >       }
> > > > 
> > > > I don't think any decent kernel could hit this, but that could be another
> > > > sign that this patch duplicated some file allocations.
> > > > 
> > > > > +        if ((new_block->flags & RAM_SHARED) &&
> > > > > +            !qemu_ram_alloc_shared(new_block, &local_err)) {
> > > > > +            goto err;
> > > > > +        }
> > > > > +    }
> > > > > +
> > > > >        ram_block_add(new_block, &local_err);
> > > > > -    if (local_err) {
> > > > > -        g_free(new_block);
> > > > > -        error_propagate(errp, local_err);
> > > > > -        return NULL;
> > > > > +    if (!local_err) {
> > > > > +        return new_block;
> > > > >        }
> > > > > -    return new_block;
> > > > > +
> > > > > +err:
> > > > > +    g_free(new_block);
> > > > > +    error_propagate(errp, local_err);
> > > > > +    return NULL;
> > > > >    }
> > > > 
> > > > IIUC we only need to conditionally convert an anon-allocation into an
> > > > fd-allocation, and then we don't need to mostly duplicate
> > > > qemu_ram_alloc_from_fd(), instead we reuse it.
> > > > 
> > > > I do have a few other comments elsewhere, but when I was trying to comment.
> > > > E.g., we either shouldn't need to bother caching qemu_memfd_check()
> > > > results, or do it in qemu_memfd_check() directly.. and some more.
> > > 
> > > Someone thought it a good idea to cache the result of qemu_memfd_alloc_check,
> > > and qemu_memfd_check will be called more often.  I'll cache the result inside
> > > qemu_memfd_check for the special case of flags=0.
> > 
> > OK.
> > 
> > > 
> > > > Then I think it's easier I provide a patch, and also show that it can be
> > > > also smaller changes to do the same thing, with everything fixed up
> > > > (e.g. addressing above mmu notifier missing issue).  What do you think as
> > > > below?
> > > 
> > > The key change you make is calling qemu_ram_alloc_from_fd instead of file_ram_alloc,
> > > which buys the xen and kvm checks for free.  Sounds good, I will do that in the
> > > context of my patch.
> > > 
> > > Here are some other changes in your patch, and my responses:
> > > 
> > > I will drop the "Retrying using MAP_ANON|MAP_SHARED" message, as you did.
> > > 
> > > However, I am keeping QEMU_VMALLOC_ALIGN, qemu_set_cloexec, and trace_qemu_ram_alloc_shared.
> > 
> > I guess no huge deal on these, however since we're talking..  Is that
> > QEMU_VMALLOC_ALIGN from qemu_anon_ram_alloc()?
> > 
> > A quick dig tells me that it was used to be for anon THPs..
> > 
> >      commit 36b586284e678da28df3af9fd0907d2b16f9311c
> >      Author: Avi Kivity <avi@redhat.com>
> >      Date:   Mon Sep 5 11:07:05 2011 +0300
> > 
> >      qemu_vmalloc: align properly for transparent hugepages and KVM
> > 
> > And I'm guessing if at that time was also majorly for guest ram.
> > 
> > Considering that this path won't make an effect until the new aux mem
> > option is on, I'd think it better to stick without anything special like
> > QEMU_VMALLOC_ALIGN, until it's justified to be worthwhile.  E.g., Avi used
> > to explicitly mention this in that commit message:
> > 
> >      Adjust qemu_vmalloc() to honor that requirement.  Ignore it for small regions
> >      to avoid fragmentation.
> > 
> > And this is exactly mostly small regions when it's AUX.. probably except
> > VGA, but it'll be SHARED on top of shmem not PRIVATE on anon anyway... so
> > it'll be totally different things.
> > 
> > So I won't worry on that 2M alignment, and I will try to not carry over
> > that, because then trying to remove it will be harder.. even when we want.
> 
> Yes, currently the aux allocations get QEMU_VMALLOC_ALIGN alignment in
> qemu_anon_ram_alloc.  I do the same for the shared fd mappings to guarantee
> no performance regression,

I don't know how we could guarantee that at all - anon and shmem uses
different knobs to enable/disable THPs after all.. For example:

  $ ls /sys/kernel/mm/transparent_hugepage/*enabled
  /sys/kernel/mm/transparent_hugepage/enabled
  /sys/kernel/mm/transparent_hugepage/shmem_enabled

And their default values normally differ too... it means after switching to
fd based we do face the possibility that thp can be gone at least on the
1st 2mb.

When I was suggesting it, I was hoping thp doesn't really matter that lot
on aux mem, even for VGA.

Btw, I don't even think the alignment will affect THP allocations for the
whole vma, anyway?  I mean, it's only about the initial 2MB portion.. IOW,
when not aligned, I think the worst case is we have <2MB at start address
that is not using THP, but later on when it starts to align with 2MB, THPs
will be allocated again.

The challenge is more on the "fd-based" side, where shmem on most distros
will disable THP completely.

> as some of them are larger than 2M and would
> benefit from using huge pages.  The VA fragmentation is trivial for this small
> number of aux blocks in a 64-bit address space, and is no different than it was
> for qemu_anon_ram_alloc.
> 
> > For the 2nd.. Any quick answer on why explicit qemu_set_cloexec() needed?
> 
> qemu sets cloexec for all descriptors it opens to prevent them from accidentally
> being leaked to another process via fork+exec.

But my question is why this is special?  For example, we don't do that for
"-object memory-backend-memfd", am I right?

> 
> > For 3rd, tracepoint would definitely be fine whenever you feel necessary.
> > 
> > > Also, when qemu_memfd_create + qemu_ram_alloc_from_fd fails, qemu should fail and exit,
> > > and not fall back, because something unexpected went wrong.  David said the same.
> > 
> > Why?  I was trying to rely on such fallback to make it work on e.g. Xen.
> > In that case, Xen fails there and fallback to xen_ram_alloc() inside the
> > later call to ram_block_add(), no?
> 
> Why -- because something went wrong that should have worked, and we should report the
> first fault so its cause can be fixed and cpr can be used.

Ahh so it's only about the corner cases where CPR could raise an error?
Can we rely on the failure later on "migrate" command to tell which
ramblock doesn't support it, so the user could be aware as well?

> 
> However, to do the above, but still quietly fallback if qemu_ram_alloc_from_fd
> fails because of xen or kvm, I would need to return different error codes from
> qemu_ram_alloc_from_fd.  Doable, but requires tweaks to all occurrences of
> qemu_ram_alloc_from_fd.
> 
> And BTW, qemu_ram_alloc_from_fd is defined for CONFIG_POSIX only.  I need
> to modify the call site in the patch accordingly.

Yep, I was thinking maybe qemu_ram_alloc_from_fd() had a stub function,
indeed looks not..  "allocating the fd" part definitely has, which I
remember I checked..

> 
> Overall, I am not convinced that using qemu_ram_alloc_from_fd in this patch
> is better/simpler than my V4 patch using file_ram_alloc, plus adding xen and
> kvm_has_sync_mmu checks in qemu_ram_alloc_internal.

As long as you don't need to duplicate these two checks (or duplicate any
such check..) I'm ok.

Reusing qemu_ram_alloc_from_fd() still sounds like the easiest to go.  Yes
we'll need to teach it about resize(), used_length etc. to it, but they all
look sane to me.  We didn't have those simply because we don't have use of
them, now we want to have resizable fd-based mem, that's the right thing to
do to support that on fd allocations.

OTOH, duplicating xen/mmu checks isn't sane to me.. :( It will make the
code harder to maintain because the 3rd qemu_ram_alloc_from_fd() in the
future will need to duplicate it once more (or worse, forget it again until
xen / old kernels reports a failure)..

-- 
Peter Xu



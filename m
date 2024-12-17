Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7E7E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgKq-0004tx-Kt; Tue, 17 Dec 2024 17:46:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNgKp-0004qb-Oc
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:46:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNgKn-0001tu-A6
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:46:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734475591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TieZ1FvAe7hwEgr8/RXsPXShLK1k45U5VUB8B/2uj8A=;
 b=NxQO92qrP1T/Uc1JqK4y9Rcquh5YBfcElk5VeIhNroDnhzgvFawGRhqYMzQ0zbvlPQay5j
 fhs/x/JNHn3yGFyZqz/5z01+h+Tx5aEvy5KGqQ0bhN/9CO16FNOr+7/hF+Gk2B3u1zVD1F
 hDicIofy+cqkgsvRhNGgBnuhrhz4LYk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-5t04HBw-Om6FGk1v1Syn9g-1; Tue, 17 Dec 2024 17:46:30 -0500
X-MC-Unique: 5t04HBw-Om6FGk1v1Syn9g-1
X-Mimecast-MFC-AGG-ID: 5t04HBw-Om6FGk1v1Syn9g
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6dcccc8b035so4917536d6.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:46:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475589; x=1735080389;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TieZ1FvAe7hwEgr8/RXsPXShLK1k45U5VUB8B/2uj8A=;
 b=No99iDuUQCdKz8jiwmV7e4W3bLGB7xqBvqwB9EYT32s2heO77NoBZTdDUMNA8ub35B
 k4UuRfifBc/OYWpjsOifeJvT+qqgdJjUpBHYX+bVAbi4urqnSjfZNFHarl3p8MJ9s4SR
 ALneWk0JxS8xMGdEw/hGBuwZnGVzW78SNqApkFyAzxKHITz/Li0vJpjqZNT9+8ZMq97t
 LsJ8u3jBB4oIW9OlvoWVM3vJljgsgIOT2C2yL20xs+tlgONsYLkfwzKB3WWAf8PUc1+e
 9sjY6PcF7xHIV0Cknyw/iuFcwK7M5rSXLXToYEwcuXzaZPJiK9/zoSkn1cUIZpCSUhpF
 Dz9w==
X-Gm-Message-State: AOJu0Yx+CzcRArOGbT29a2SHuTV1SGbQg5+v2kESgwltul6dIKIrnlbv
 rDMaT0x60NRRNL5ckBRTDuZbBAYaQe3zzBrbfOlDwRoZ6ClgI1W2FMeqOYtW8Kpfn7fG78Bxdgq
 r2EK8PvAf5CLGkRJKzuuOE4qWmDWi0nGmTTrAdT+mrlXbJdfQbRAQ
X-Gm-Gg: ASbGncuz0+LUowyxm2vU4GgYSpWn3C1vZ3A1ZJKRM9+K8ZaWxrm+MDAi7fpy8LlVdWX
 IguEadM1ZwW9wd4jNR0d/AM1X8pohDABjk9dPFg3ENMugZ9mBO+LuwQkBswMroqglOFLVYJSwO6
 ebnMacDv9Xg09/SUirsmggZ3/T5rA9g/IU0wd4wz9ig+JKJkNdpXYjr4710ylg383SulwNvHx7W
 iF8Oqc+z572th9dMTd/SVGy9VOoVd9imNAwQNl4TarkwdKZBRvjr/k39A54/6FPbF/UAo0JQhE2
 VuqhEqt7+Vv3rqS0Rg==
X-Received: by 2002:a05:6214:202c:b0:6dc:c8bc:f913 with SMTP id
 6a1803df08f44-6dcf4c84ad6mr81663136d6.15.1734475589322; 
 Tue, 17 Dec 2024 14:46:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1UjvXILSn46mkEs0agajrclL3YM+YRlQd/tPrIi5pM79lovG6u26R0lwMW3z5MgfkhuZ1kw==
X-Received: by 2002:a05:6214:202c:b0:6dc:c8bc:f913 with SMTP id
 6a1803df08f44-6dcf4c84ad6mr81662826d6.15.1734475588897; 
 Tue, 17 Dec 2024 14:46:28 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd3805fbsm44235146d6.103.2024.12.17.14.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:46:28 -0800 (PST)
Date: Tue, 17 Dec 2024 17:46:25 -0500
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
Message-ID: <Z2H_QTcgyHeONq9P@x1n>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-3-git-send-email-steven.sistare@oracle.com>
 <Z1dIEUcSrI1aROSp@x1n>
 <ecbae03f-a8b2-4a41-89bc-5a671a4c3c7e@oracle.com>
 <Z1tUBUcpf1XcVRhG@x1n>
 <bf0e7550-54a0-42ff-a281-6a65cb1ba7b5@oracle.com>
 <Z2BvNs1zTz42Tpqx@x1n>
 <7acde39b-9448-408d-894c-6fd96eb2324e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7acde39b-9448-408d-894c-6fd96eb2324e@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Dec 17, 2024 at 04:54:43PM -0500, Steven Sistare wrote:
> On 12/16/2024 1:19 PM, Peter Xu wrote:
> > On Fri, Dec 13, 2024 at 11:41:45AM -0500, Steven Sistare wrote:
> > > On 12/12/2024 4:22 PM, Peter Xu wrote:
> > > > On Thu, Dec 12, 2024 at 03:38:00PM -0500, Steven Sistare wrote:
> > > > > On 12/9/2024 2:42 PM, Peter Xu wrote:
> > > > > > On Mon, Dec 02, 2024 at 05:19:54AM -0800, Steve Sistare wrote:
> > > > > > > @@ -2089,13 +2154,23 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
> > > > > > >         new_block->page_size = qemu_real_host_page_size();
> > > > > > >         new_block->host = host;
> > > > > > >         new_block->flags = ram_flags;
> > > > > > > +
> > > > > > > +    if (!host && !xen_enabled()) {
> > > > > > 
> > > > > > Adding one more xen check is unnecessary.  This patch needed it could mean
> > > > > > that the patch can be refactored.. because we have xen checks in both
> > > > > > ram_block_add() and also in the fd allocation path.
> > > > > > 
> > > > > > At the meantime, see:
> > > > > > 
> > > > > > qemu_ram_alloc_from_fd():
> > > > > >        if (kvm_enabled() && !kvm_has_sync_mmu()) {
> > > > > >            error_setg(errp,
> > > > > >                       "host lacks kvm mmu notifiers, -mem-path unsupported");
> > > > > >            return NULL;
> > > > > >        }
> > > > > > 
> > > > > > I don't think any decent kernel could hit this, but that could be another
> > > > > > sign that this patch duplicated some file allocations.
> > > > > > 
> > > > > > > +        if ((new_block->flags & RAM_SHARED) &&
> > > > > > > +            !qemu_ram_alloc_shared(new_block, &local_err)) {
> > > > > > > +            goto err;
> > > > > > > +        }
> > > > > > > +    }
> > > > > > > +
> > > > > > >         ram_block_add(new_block, &local_err);
> > > > > > > -    if (local_err) {
> > > > > > > -        g_free(new_block);
> > > > > > > -        error_propagate(errp, local_err);
> > > > > > > -        return NULL;
> > > > > > > +    if (!local_err) {
> > > > > > > +        return new_block;
> > > > > > >         }
> > > > > > > -    return new_block;
> > > > > > > +
> > > > > > > +err:
> > > > > > > +    g_free(new_block);
> > > > > > > +    error_propagate(errp, local_err);
> > > > > > > +    return NULL;
> > > > > > >     }
> > > > > > 
> > > > > > IIUC we only need to conditionally convert an anon-allocation into an
> > > > > > fd-allocation, and then we don't need to mostly duplicate
> > > > > > qemu_ram_alloc_from_fd(), instead we reuse it.
> > > > > > 
> > > > > > I do have a few other comments elsewhere, but when I was trying to comment.
> > > > > > E.g., we either shouldn't need to bother caching qemu_memfd_check()
> > > > > > results, or do it in qemu_memfd_check() directly.. and some more.
> > > > > 
> > > > > Someone thought it a good idea to cache the result of qemu_memfd_alloc_check,
> > > > > and qemu_memfd_check will be called more often.  I'll cache the result inside
> > > > > qemu_memfd_check for the special case of flags=0.
> > > > 
> > > > OK.
> > > > 
> > > > > 
> > > > > > Then I think it's easier I provide a patch, and also show that it can be
> > > > > > also smaller changes to do the same thing, with everything fixed up
> > > > > > (e.g. addressing above mmu notifier missing issue).  What do you think as
> > > > > > below?
> > > > > 
> > > > > The key change you make is calling qemu_ram_alloc_from_fd instead of file_ram_alloc,
> > > > > which buys the xen and kvm checks for free.  Sounds good, I will do that in the
> > > > > context of my patch.
> > > > > 
> > > > > Here are some other changes in your patch, and my responses:
> > > > > 
> > > > > I will drop the "Retrying using MAP_ANON|MAP_SHARED" message, as you did.
> > > > > 
> > > > > However, I am keeping QEMU_VMALLOC_ALIGN, qemu_set_cloexec, and trace_qemu_ram_alloc_shared.
> > > > 
> > > > I guess no huge deal on these, however since we're talking..  Is that
> > > > QEMU_VMALLOC_ALIGN from qemu_anon_ram_alloc()?
> > > > 
> > > > A quick dig tells me that it was used to be for anon THPs..
> > > > 
> > > >       commit 36b586284e678da28df3af9fd0907d2b16f9311c
> > > >       Author: Avi Kivity <avi@redhat.com>
> > > >       Date:   Mon Sep 5 11:07:05 2011 +0300
> > > > 
> > > >       qemu_vmalloc: align properly for transparent hugepages and KVM
> > > > 
> > > > And I'm guessing if at that time was also majorly for guest ram.
> > > > 
> > > > Considering that this path won't make an effect until the new aux mem
> > > > option is on, I'd think it better to stick without anything special like
> > > > QEMU_VMALLOC_ALIGN, until it's justified to be worthwhile.  E.g., Avi used
> > > > to explicitly mention this in that commit message:
> > > > 
> > > >       Adjust qemu_vmalloc() to honor that requirement.  Ignore it for small regions
> > > >       to avoid fragmentation.
> > > > 
> > > > And this is exactly mostly small regions when it's AUX.. probably except
> > > > VGA, but it'll be SHARED on top of shmem not PRIVATE on anon anyway... so
> > > > it'll be totally different things.
> > > > 
> > > > So I won't worry on that 2M alignment, and I will try to not carry over
> > > > that, because then trying to remove it will be harder.. even when we want.
> > > 
> > > Yes, currently the aux allocations get QEMU_VMALLOC_ALIGN alignment in
> > > qemu_anon_ram_alloc.  I do the same for the shared fd mappings to guarantee
> > > no performance regression,
> > 
> > I don't know how we could guarantee that at all - anon and shmem uses
> > different knobs to enable/disable THPs after all.. For example:
> > 
> >    $ ls /sys/kernel/mm/transparent_hugepage/*enabled
> >    /sys/kernel/mm/transparent_hugepage/enabled
> >    /sys/kernel/mm/transparent_hugepage/shmem_enabled
> 
> Yes, but at least shmem_enabled is something the end user can fix.  If
> we bake a poor alignment into qemu, the user has no recourse.  By setting
> it to QEMU_VMALLOC_ALIGN, I eliminate alignment as a potential performance
> issue. There is no practical downside.  We should just do it, especially if
> you believe "no huge deal on these" as written above :)

I'd wager nobody will be able to notice the anon/shmem difference at all,
so if it really regressed nobody will be able fix it. :)

Not to mention it's a global knob, and IMHO it doesn't make a lot of sense
to change it for an aux mem not aligned.. while changing a global knob
could OTOH break other things.

But sure, if you do prefer having that I'm ok. Please still consider adding
a comment then explaining where it came from..

> 
> > And their default values normally differ too... it means after switching to
> > fd based we do face the possibility that thp can be gone at least on the
> > 1st 2mb.
> > 
> > When I was suggesting it, I was hoping thp doesn't really matter that lot
> > on aux mem, even for VGA.
> > 
> > Btw, I don't even think the alignment will affect THP allocations for the
> > whole vma, anyway?  I mean, it's only about the initial 2MB portion.. IOW,
> > when not aligned, I think the worst case is we have <2MB at start address
> > that is not using THP, but later on when it starts to align with 2MB, THPs
> > will be allocated again.
> 
> It depends on the kernel version/implementation.  In 6.13, it is not that
> clever for memfd_create + mmap.  An unaligned start means no huge pages anywhere
> in the allocation, as shown by the page-types utility.  Add QEMU_VMALLOC_ALIGN,
> and I get huge pages.
> 
> > The challenge is more on the "fd-based" side, where shmem on most distros
> > will disable THP completely.
> > 
> > > as some of them are larger than 2M and would
> > > benefit from using huge pages.  The VA fragmentation is trivial for this small
> > > number of aux blocks in a 64-bit address space, and is no different than it was
> > > for qemu_anon_ram_alloc.
> > > 
> > > > For the 2nd.. Any quick answer on why explicit qemu_set_cloexec() needed?
> > > 
> > > qemu sets cloexec for all descriptors it opens to prevent them from accidentally
> > > being leaked to another process via fork+exec.
> > 
> > But my question is why this is special?  For example, we don't do that for
> > "-object memory-backend-memfd", am I right?
> 
> We should, the backends also need to set cloexec when they use a cpr fd.
> I'll delete the call here and push it into cpr_find_fd.

Maybe we already have that?  As CPR receives fds from iochannels.  I am
looking at qio_channel_socket_copy_fds(), where we have:

#ifndef MSG_CMSG_CLOEXEC
            qemu_set_cloexec(fd);
#endif

> 
> > > > For 3rd, tracepoint would definitely be fine whenever you feel necessary.
> > > > 
> > > > > Also, when qemu_memfd_create + qemu_ram_alloc_from_fd fails, qemu should fail and exit,
> > > > > and not fall back, because something unexpected went wrong.  David said the same.
> > > > 
> > > > Why?  I was trying to rely on such fallback to make it work on e.g. Xen.
> > > > In that case, Xen fails there and fallback to xen_ram_alloc() inside the
> > > > later call to ram_block_add(), no?
> > > 
> > > Why -- because something went wrong that should have worked, and we should report the
> > > first fault so its cause can be fixed and cpr can be used.
> > 
> > Ahh so it's only about the corner cases where CPR could raise an error?
> > Can we rely on the failure later on "migrate" command to tell which
> > ramblock doesn't support it, so the user could be aware as well?
> 
> The ramblock migration blocker will indeed tell us which block is a problem.
> 
> But, we are throwing away potentially useful information by dropping the
> first error message on the floor. We should only fall back for expected
> failures.  Unexpected failures mean there is something to fix.
> 
> I can compromise and fail on errors from these:
>   qemu_memfd_create(name, 0, 0, 0, 0, errp);
>   qemu_shm_alloc(0, errp);

How are we going to be sure all existing systems using RAM_SHARED ramblocks
will always succeed on either memfd or sysv shm?  IOW, what if there's a
system that can only support mmap(MAP_SHARED) but none of the two?

That's my major concern, on start failing some systems where it used to
work, even if they're corner cases.

> 
> but ignore errors from the subsequent call to qemu_ram_alloc_from_fd,
> and fall back. That keeps the code simple.
> 
> > > However, to do the above, but still quietly fallback if qemu_ram_alloc_from_fd
> > > fails because of xen or kvm, I would need to return different error codes from
> > > qemu_ram_alloc_from_fd.  Doable, but requires tweaks to all occurrences of
> > > qemu_ram_alloc_from_fd.
> > > 
> > > And BTW, qemu_ram_alloc_from_fd is defined for CONFIG_POSIX only.  I need
> > > to modify the call site in the patch accordingly.
> > 
> > Yep, I was thinking maybe qemu_ram_alloc_from_fd() had a stub function,
> > indeed looks not..  "allocating the fd" part definitely has, which I
> > remember I checked..
> > 
> > > Overall, I am not convinced that using qemu_ram_alloc_from_fd in this patch
> > > is better/simpler than my V4 patch using file_ram_alloc, plus adding xen and
> > > kvm_has_sync_mmu checks in qemu_ram_alloc_internal.
> > 
> > As long as you don't need to duplicate these two checks (or duplicate any
> > such check..) I'm ok.
> > 
> > Reusing qemu_ram_alloc_from_fd() still sounds like the easiest to go.  Yes
> > we'll need to teach it about resize(), used_length etc. to it, but they all
> > look sane to me.  We didn't have those simply because we don't have use of
> > them, now we want to have resizable fd-based mem, that's the right thing to
> > do to support that on fd allocations.
> > 
> > OTOH, duplicating xen/mmu checks isn't sane to me.. :( It will make the
> > code harder to maintain because the 3rd qemu_ram_alloc_from_fd() in the
> > future will need to duplicate it once more (or worse, forget it again until
> > xen / old kernels reports a failure)..
> 
> I'll make the necessary changes to use qemu_ram_alloc_from_fd.

Thanks.

-- 
Peter Xu



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDBBE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 21:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLqdx-0008Q7-1f; Thu, 12 Dec 2024 16:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLqdk-0008Pd-KE
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 16:22:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLqdh-00038K-9u
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 16:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734038547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QOyXxqgKIvJMiN/Eq4EPEe2Tvt5h7qfXSOVsS+Kdtqg=;
 b=dGKWIPdqCqZgRfJuq5t3MJyPuczXxS+b+uGfT6Rn6Tw+WdeL5pAwuYTowwJZlqLiBAdbEA
 m2Sp58zCjC/6+pMQ4axie5npzjm6Xi0cMtAmX/cKjGVITp6lNsa/oqNfrgX7T/5SOoNwLc
 nEK7+QeXqGPGAF7s0qsuDZdwMilsZh4=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-vDGkkRegMqG-T0B0NPbM4w-1; Thu, 12 Dec 2024 16:22:25 -0500
X-MC-Unique: vDGkkRegMqG-T0B0NPbM4w-1
X-Mimecast-MFC-AGG-ID: vDGkkRegMqG-T0B0NPbM4w
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-844c34cde5eso175302639f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 13:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734038544; x=1734643344;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QOyXxqgKIvJMiN/Eq4EPEe2Tvt5h7qfXSOVsS+Kdtqg=;
 b=ZlaA0pTWc4LT8Fa0QXR9zXrhALgbf/DoEAw2TBUHu2LKRWpANB5el5YBc9D0DevEpR
 P2xBtD2FyHmEv/2g9eEvj57jZ/xaomufV8MlziW713OpgdaMJ4XTQu+0rBts0v+JyTdQ
 yj12FMbxMkBH4LHqPpSTgx4C3m/u/Vxk18r6wO76z3mNxMWbrX58Kyfvky8v9UTjY/sV
 9GSDM0GIfU7CZB/T/IkllulHu1kVEPWj1iQtW++fHNppiS9esDsRqxZJesdNUh25LRZ8
 Qfxuj7XW0vb2jw8ztuQ2Ok3JTOygKfXHOa0INPt0cvzaPMrxBlHYJBF23u51WXhx6eAH
 WCdw==
X-Gm-Message-State: AOJu0YzOhnMLeYXwLpz4YU/H1UAZkqz2KoPI9uXSvJIL5xjBKN7iVdSo
 753jMTeej3ycHydRX1eKRSmeeEGKXyRWI8UZzXtrjMsePW3BzsfXZEjpCIwraQe3kz6U1J9Q7MS
 lL8+abe6S4mDY9RsrJuFc7JHr0HP+boIgi0kSQZ8w7pGGTZ+0ggfL
X-Gm-Gg: ASbGncszaCJWF+Nm/1FK2nGsd5H2Id5tuWMFlzmFvEAJzFcpP5A7C+2r1MZks8Al/Ea
 ztrSySFrHEOGglQ9O7DsD5cXhdo5MmOvutBu9RSAUWgwVWcEkobbPU14MhJXvP0NNF6MaA4lL/1
 I/zrU3IjdJsSzrnbLmCcQzWVw7HxTT9XU9/c0a/whkE6WlFT9WpN3vqU6WMbYxFgjUaf0YLa1VX
 v6Ssyf3leYz5eo+CpxhAv7P5nZTDJzim8EDLnDWVO5Xr7dFPz5378dmaj8aB0Yld1agtepK9Jh2
 XDVcXeJVJYsRn0fprQ==
X-Received: by 2002:a05:6602:2cc3:b0:844:7956:df9c with SMTP id
 ca18e2360f4ac-844e8679cfdmr52001539f.0.1734038542890; 
 Thu, 12 Dec 2024 13:22:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIrFBPYx/IXd8QEoHaQZ3o/JQC0uwPmvbmgVMTZ/bEY77ABdjkegHzmBaefnmGBUybeit/IA==
X-Received: by 2002:a05:6602:2cc3:b0:844:7956:df9c with SMTP id
 ca18e2360f4ac-844e8679cfdmr52000039f.0.1734038542589; 
 Thu, 12 Dec 2024 13:22:22 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2bb66b174sm2359113173.151.2024.12.12.13.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 13:22:15 -0800 (PST)
Date: Thu, 12 Dec 2024 16:22:13 -0500
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
Message-ID: <Z1tUBUcpf1XcVRhG@x1n>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-3-git-send-email-steven.sistare@oracle.com>
 <Z1dIEUcSrI1aROSp@x1n>
 <ecbae03f-a8b2-4a41-89bc-5a671a4c3c7e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ecbae03f-a8b2-4a41-89bc-5a671a4c3c7e@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Dec 12, 2024 at 03:38:00PM -0500, Steven Sistare wrote:
> On 12/9/2024 2:42 PM, Peter Xu wrote:
> > On Mon, Dec 02, 2024 at 05:19:54AM -0800, Steve Sistare wrote:
> > > @@ -2089,13 +2154,23 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
> > >       new_block->page_size = qemu_real_host_page_size();
> > >       new_block->host = host;
> > >       new_block->flags = ram_flags;
> > > +
> > > +    if (!host && !xen_enabled()) {
> > 
> > Adding one more xen check is unnecessary.  This patch needed it could mean
> > that the patch can be refactored.. because we have xen checks in both
> > ram_block_add() and also in the fd allocation path.
> > 
> > At the meantime, see:
> > 
> > qemu_ram_alloc_from_fd():
> >      if (kvm_enabled() && !kvm_has_sync_mmu()) {
> >          error_setg(errp,
> >                     "host lacks kvm mmu notifiers, -mem-path unsupported");
> >          return NULL;
> >      }
> > 
> > I don't think any decent kernel could hit this, but that could be another
> > sign that this patch duplicated some file allocations.
> > 
> > > +        if ((new_block->flags & RAM_SHARED) &&
> > > +            !qemu_ram_alloc_shared(new_block, &local_err)) {
> > > +            goto err;
> > > +        }
> > > +    }
> > > +
> > >       ram_block_add(new_block, &local_err);
> > > -    if (local_err) {
> > > -        g_free(new_block);
> > > -        error_propagate(errp, local_err);
> > > -        return NULL;
> > > +    if (!local_err) {
> > > +        return new_block;
> > >       }
> > > -    return new_block;
> > > +
> > > +err:
> > > +    g_free(new_block);
> > > +    error_propagate(errp, local_err);
> > > +    return NULL;
> > >   }
> > 
> > IIUC we only need to conditionally convert an anon-allocation into an
> > fd-allocation, and then we don't need to mostly duplicate
> > qemu_ram_alloc_from_fd(), instead we reuse it.
> > 
> > I do have a few other comments elsewhere, but when I was trying to comment.
> > E.g., we either shouldn't need to bother caching qemu_memfd_check()
> > results, or do it in qemu_memfd_check() directly.. and some more.
> 
> Someone thought it a good idea to cache the result of qemu_memfd_alloc_check,
> and qemu_memfd_check will be called more often.  I'll cache the result inside
> qemu_memfd_check for the special case of flags=0.

OK.

> 
> > Then I think it's easier I provide a patch, and also show that it can be
> > also smaller changes to do the same thing, with everything fixed up
> > (e.g. addressing above mmu notifier missing issue).  What do you think as
> > below?
> 
> The key change you make is calling qemu_ram_alloc_from_fd instead of file_ram_alloc,
> which buys the xen and kvm checks for free.  Sounds good, I will do that in the
> context of my patch.
> 
> Here are some other changes in your patch, and my responses:
> 
> I will drop the "Retrying using MAP_ANON|MAP_SHARED" message, as you did.
> 
> However, I am keeping QEMU_VMALLOC_ALIGN, qemu_set_cloexec, and trace_qemu_ram_alloc_shared.

I guess no huge deal on these, however since we're talking..  Is that
QEMU_VMALLOC_ALIGN from qemu_anon_ram_alloc()?

A quick dig tells me that it was used to be for anon THPs..

    commit 36b586284e678da28df3af9fd0907d2b16f9311c
    Author: Avi Kivity <avi@redhat.com>
    Date:   Mon Sep 5 11:07:05 2011 +0300

    qemu_vmalloc: align properly for transparent hugepages and KVM

And I'm guessing if at that time was also majorly for guest ram.

Considering that this path won't make an effect until the new aux mem
option is on, I'd think it better to stick without anything special like
QEMU_VMALLOC_ALIGN, until it's justified to be worthwhile.  E.g., Avi used
to explicitly mention this in that commit message:

    Adjust qemu_vmalloc() to honor that requirement.  Ignore it for small regions
    to avoid fragmentation.

And this is exactly mostly small regions when it's AUX.. probably except
VGA, but it'll be SHARED on top of shmem not PRIVATE on anon anyway... so
it'll be totally different things.

So I won't worry on that 2M alignment, and I will try to not carry over
that, because then trying to remove it will be harder.. even when we want.

For the 2nd.. Any quick answer on why explicit qemu_set_cloexec() needed?

For 3rd, tracepoint would definitely be fine whenever you feel necessary.

> 
> Also, when qemu_memfd_create + qemu_ram_alloc_from_fd fails, qemu should fail and exit,
> and not fall back, because something unexpected went wrong.  David said the same.

Why?  I was trying to rely on such fallback to make it work on e.g. Xen.
In that case, Xen fails there and fallback to xen_ram_alloc() inside the
later call to ram_block_add(), no?

> Thus we still need to pass errp to qemu_memfd_create().

-- 
Peter Xu



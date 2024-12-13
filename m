Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87525E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 15:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM7V8-0002py-Mq; Fri, 13 Dec 2024 10:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tM7Ub-0001vK-45
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:22:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tM7US-00060f-09
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734103321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cvKe2M6AnU0BX3n8TzcLgWngoeswsNBj8vs8oOQfuUU=;
 b=KWw/PMC8c56sCPfNQgPwvignJFfCx8ZD6bZfP+adWUmnl6JMt+axD1IqXXC7ZBklpZA/mZ
 xLhJbOC9MkUEz+HOfEBJFv3YJ18nIW2QKACH6KB9kkgghszI8o+KbbSfutsADfysjOVMJH
 jMAdb/H7/IKyYj6P6J86enDm5snooQo=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-PwrrI2IpNv2beeaRUNKSfw-1; Fri, 13 Dec 2024 10:21:58 -0500
X-MC-Unique: PwrrI2IpNv2beeaRUNKSfw-1
X-Mimecast-MFC-AGG-ID: PwrrI2IpNv2beeaRUNKSfw
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-e38d8aaeb4aso2549567276.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 07:21:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734103318; x=1734708118;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cvKe2M6AnU0BX3n8TzcLgWngoeswsNBj8vs8oOQfuUU=;
 b=HMcDyVDrrX9/F4CE04Fi80TTWvY2J3LtxKHyDZuWEaJLto9K4s9VZpE+Ynj+BRsB4B
 VXlxMRSoo/SPpUArsbX9E6oMmKwalyjylUu1mD4yD8HokaMJ9wZ9uECAJqE1quSwFR3e
 vkvQc1FYd4wuLC3u+nZ2gl/x9aGMpl2VcZBHhyueZcT7mQEB4WTI4veZqae0QRoO6SFB
 XRgULCQEH2WKkgc+IVRSzdMFNJ6cOoyzRsz0iTeGeA9W/g3+wVe9KI14JtUyUnfHRp9p
 8I80o0cFt5TWiRNSqXlrL4ZA/cBVQc3GXduLdD1tHwZlNSm2tdxDh3kKJhjhak2nVrOI
 Fkhw==
X-Gm-Message-State: AOJu0YzsEYJZ9ipo3hIfW4So/t76xCc10QDLhvtw9wmUOB4lJ2+6jyZR
 eq+FJNN0hAg1NpsJP1/u0FvasOTp7PQ4nNRavmotmeIPx8yHnARygmSyefEqc3y1ELO8Rnu+KSD
 deP0MKmjX0PKAZue/QNkL1uVrEkJYnuPljWAEGEuveuOjyPIIw7Op
X-Gm-Gg: ASbGncsNSqIlwxbqq1vbnOMzlARwh1WDAawGA7wpiNEzzbF1GqtXWcmu328su149p0w
 4+mKNfqfmQAp5U5DWvIQxO4NGsBOGNymMFd5ZS4DdCvgASOrLxp2dGtkhweqdVSNrMiC+w6YKej
 38BqH16YhLry+T/YC0XdQVrSHFygO6sc4NyDCYzhwDQ7tGHMXPrwkKm4SKhVm5bFGXas3r/sjra
 bKDgK4jqfokY1ivNvLlrY+R/wKcasVPExzOmI6bZxHkrjz6pH5kAJDZfPsDidtWwYMSvWEsRKpl
 1WI+RkfqYWXPVG1JlA==
X-Received: by 2002:a05:6902:1b09:b0:e38:a081:f533 with SMTP id
 3f1490d57ef6-e43494e3721mr2412623276.7.1734103317910; 
 Fri, 13 Dec 2024 07:21:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGv1WapsXsZbdVbf8eYmDfSDUA0C+AyAT6I9S6atOeF4rwNll2LNbUf2aLENtXSHAxvp5sKXQ==
X-Received: by 2002:a05:6902:1b09:b0:e38:a081:f533 with SMTP id
 3f1490d57ef6-e43494e3721mr2412584276.7.1734103317377; 
 Fri, 13 Dec 2024 07:21:57 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e3c949c7022sm1352250276.23.2024.12.13.07.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 07:21:56 -0800 (PST)
Date: Fri, 13 Dec 2024 10:21:53 -0500
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
Subject: Re: [PATCH V4 06/19] physmem: preserve ram blocks for cpr
Message-ID: <Z1xREcVCi-hn4BlW@x1n>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-7-git-send-email-steven.sistare@oracle.com>
 <Z1dOBioqzQmEwW16@x1n>
 <bbb7b4a9-6078-4cb1-89c9-ec2d57b996f0@oracle.com>
 <Z1toIxDzI56ODYcC@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z1toIxDzI56ODYcC@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Dec 12, 2024 at 05:48:03PM -0500, Peter Xu wrote:
> On Thu, Dec 12, 2024 at 03:38:14PM -0500, Steven Sistare wrote:
> > On 12/9/2024 3:07 PM, Peter Xu wrote:
> > > On Mon, Dec 02, 2024 at 05:19:58AM -0800, Steve Sistare wrote:
> > > > Save the memfd for ramblocks in CPR state, along with a name that
> > > > uniquely identifies it.  The block's idstr is not yet set, so it
> > > > cannot be used for this purpose.  Find the saved memfd in new QEMU when
> > > > creating a block.  If the block size is larger in new QEMU, extend the
> > > > block using fallocate, and the extra space will be useable after a guest
> > > > reset.
> > > > 
> > > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > > > ---
> > > >   system/physmem.c | 36 ++++++++++++++++++++++++++++++++++--
> > > >   1 file changed, 34 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/system/physmem.c b/system/physmem.c
> > > > index 0bcb2cc..aa095a3 100644
> > > > --- a/system/physmem.c
> > > > +++ b/system/physmem.c
> > > > @@ -70,6 +70,7 @@
> > > >   #include "qemu/pmem.h"
> > > > +#include "migration/cpr.h"
> > > >   #include "migration/vmstate.h"
> > > >   #include "qemu/range.h"
> > > > @@ -1661,6 +1662,19 @@ void qemu_ram_unset_idstr(RAMBlock *block)
> > > >       }
> > > >   }
> > > > +static char *cpr_name(RAMBlock *block)
> > > > +{
> > > > +    MemoryRegion *mr = block->mr;
> > > > +    const char *mr_name = memory_region_name(mr);
> > > > +    g_autofree char *id = mr->dev ? qdev_get_dev_path(mr->dev) : NULL;
> > > > +
> > > > +    if (id) {
> > > > +        return g_strdup_printf("%s/%s", id, mr_name);
> > > > +    } else {
> > > > +        return g_strdup(mr_name);
> > > > +    }
> > > > +}
> > > > +
> > > >   size_t qemu_ram_pagesize(RAMBlock *rb)
> > > >   {
> > > >       return rb->page_size;
> > > > @@ -2080,8 +2094,18 @@ static bool qemu_ram_alloc_shared(RAMBlock *new_block, Error **errp)
> > > >   {
> > > >       size_t max_length = new_block->max_length;
> > > >       MemoryRegion *mr = new_block->mr;
> > > > -    const char *name = memory_region_name(mr);
> > > > -    int fd;
> > > > +    g_autofree char *name = cpr_name(new_block);
> > > > +    int fd = cpr_find_fd(name, 0);
> > > 
> > > If to use the proposed patch in the reply of patch 2, here this should be
> > > able to be moved to qemu_ram_alloc_anonymous_fd(), IIUC.
> > > 
> > > > +
> > > > +    if (fd >= 0) {
> > > > +        if (lseek(fd, 0, SEEK_END) < max_length && ftruncate(fd, max_length)) {
> > > > +            error_setg_errno(errp, errno,
> > > > +                             "cannot grow ram block %s fd %d to %ld bytes",
> > > > +                             name, fd, max_length);
> > > > +            goto err;
> > > > +        }
> > > 
> > > I remember we discussed something similar to this, do we need ftruncate()
> > > at all?  I think not.
> > > 
> > > This happens when booting QEMU, so I don't think it's relevant yet to what
> > > size used in src, as this is dest.
> > > 
> > > It starts to get relevant only when cpr migration starts on src, it sents
> > > ramblocks at the beginning, then parse_ramblock() will properly resize any
> > > ramblock to whatever size it should use.
> > > 
> > > If the resize didn't happen it can only mean that used_length is correctly
> > > matched on both sides.
> > > 
> > > So I don't see why a special truncate() call is needed yet..
> > 
> > You suggested truncate:
> > 
> >   https://lore.kernel.org/qemu-devel/47d6d984-7002-4086-bb10-b191168f141f@oracle.com/
> > 
> >   "So after such system reset, QEMU might start to see new ROM code loaded
> >   here (not the one that got migrated anymore, which will only match the
> >   version installed on src QEMU).  Here the problem is the new firmware can
> >   be larger, so I _think_ we need to make sure max_length is not modified by
> >   CPR to allow resizing happen here, while if we use truncate=true here it
> >   should just work in all cases."
> > 
> > ... but you suggested passing a truncate bool to the file_ram_alloc call after
> > cpr_find_fd.  I could do that instead.  However, if qemu_ram_alloc_shared uses
> > qemu_ram_alloc_from_fd instead of file_ram_alloc, per your suggestion in patch 2,
> > then I will still call ftruncate here, because qemu_ram_alloc_from_fd  does not
> > take a truncate argument.
> 

[begin]

> My memory was when reuse qemu_ram_alloc_from_fd() in that suggestion of
> patch 2, it will only create zero-length fd (with fsize=0) and leave all
> the rest to qemu_ram_alloc_from_fd(), then with that:
> 
> qemu_ram_alloc_from_fd:
>     new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset,
>                                      errp);
> 
> So that'll always have truncate==!file_size==1. Then truncate will be done
> at file_ram_alloc() later, iiuc.
> 
>     if (truncate && ftruncate(fd, offset + memory)) {
>         perror("ftruncate");
>     }
> 
> Would this work?

[end]

Please feel free to ignore [begin]->[end]..  I guess I didn't really answer
it.

Now after I re-read the question.. considering that we have been very
cautious on the fsize here:

    file_size = get_file_size(fd);
    if (file_size > offset && file_size < (offset + size)) {
        error_setg(errp, "backing store size 0x%" PRIx64
                   " does not match 'size' option 0x" RAM_ADDR_FMT,
                   file_size, size);
        return NULL;
    }

I suppose your change makes sense.  So please feel free to keep the
truncation change.  I wished we could already auto-enlarge the file size
there already instead of failing, but I think I see why we're over cautious
on this - we want to still provide some safety in case some wrong file path
passed over to QEMU, to not easily corrupt the file when that happens.  So
we assume the file must be pre-truncated to say this is the right ram file.

Though if you wouldn't mind, I'd still request a comment explaining it,
because it probably isn't obvious..

AFAICT it's only relevant to resizable RAM and also the fact that it'll be
able to present now in fd-based ramblocks.  Maybe also mention the fact of
our cautious on changing file sizes on fd-based, but not avoidable to do it
here to make resizable work for firmwares.  Any form of comment would help.

OTOH, below comments should still worth checking.

> 
> Meanwhile, this whole ram resize discussion reminded me that to reuse
> qemu_ram_alloc_from_fd(), we may also want to make sure to pass ->resized()
> hook from qemu_ram_alloc_internal() to the fd helper too..  IOW, we may
> want to keep qemu_ram_resize() invoke those hooks, even after switching to
> fd-based for aux mems.
> 
> Maybe the size / max_size also need to be passed over?  As for fd ramblock
> it used to be always the same on used_length/max_length, but not anymore
> when we switch aux mem to fd based.  Please feel free to double check..
> 
> -- 
> Peter Xu

-- 
Peter Xu



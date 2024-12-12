Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E8CE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 22:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLryt-0008Gl-Pn; Thu, 12 Dec 2024 17:48:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLryk-0008GX-K4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 17:48:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLrye-0006MB-G2
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 17:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734043689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wxOZgaVnl4I2S+kFZKA4IVc9Y76giRDHboJhTWKs8k0=;
 b=jTdr6dVJJFFV+5/a1rTy1arUzxTprwdAKIaJ9i0d1xr052oWbM4xTLTYIRLi/pSU3qvwSB
 79hXM4Vp4GThsaiVFJt9Op4WyfeICK7DC32lQwDK7xLf0GjaFBIy6QQZk4bQOpOzWdinol
 GDUMRi6JwcyI9dk5M/nKSZfxPRzvV0Y=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-JMcqVEOiNbiRUBmbCm31Bw-1; Thu, 12 Dec 2024 17:48:07 -0500
X-MC-Unique: JMcqVEOiNbiRUBmbCm31Bw-1
X-Mimecast-MFC-AGG-ID: JMcqVEOiNbiRUBmbCm31Bw
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-844e9b88efeso7149939f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 14:48:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734043687; x=1734648487;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wxOZgaVnl4I2S+kFZKA4IVc9Y76giRDHboJhTWKs8k0=;
 b=mtZDnQoCw8WY8eM9ie5HomyjAdNqOeF2oRV3wPrOIV/EAusBPZh7dIAig6hkKfTCjO
 hXZua/bmd3W9dHz3Fo/aBflzflMMJpjWcuso2E3aIStEnnZZD0rGFUhrzuqTld9yDJDJ
 EZXdr3H1g8VekyDMmWmj6qVltXrRj/UahmrxUFmC1uKYW6DbVkkCeU8j92nLUV9y04QC
 q5V70un0w2yauUhAq+atL2EixotupUR71Pcwqkay0La/tPzAfQy5cLVgiRUqVhrIe05j
 nlHw8XDfVvD6Vd4JDltLDxb4QeGJJxE4PqFkIeffL7oCvAmIua1Wm0ZsLtwgG7fz8Ymy
 ET3w==
X-Gm-Message-State: AOJu0YwhTKt2eA628UTd1RU2ckU/6pl41I2Me+H0VMbdLPeMffXwWvQG
 /WBID/grvgJ7+IW+94j+5JZDiho9GPZMbGm1esR7441dgdBC9NtLLXpqN3ZyQDMT6e0UeijWEVG
 dbHqiMFHn2pKSq7ErMV5QY9hOKFgffs0+qyaaUQA3mM/Ek46NLwFs
X-Gm-Gg: ASbGncvVq/7E0Inr9OFsa97+KOACNJb2/BNW4Jxi24oWPDH3bKRlG1E29NJkH/XJWmJ
 t8vUIKyB5XvqbJzXhLiYGlPFfhLYTWV+g3uUdLZ/pMS8kppcOs5Qlbt6xzfgiFX8JFkXKsEColM
 TqNjTc+LoVXaZid7Z0XSqOS6lbrYPNKESCs/f2khV1SWq2bgdtyn5fHopMMUpXCBzY5C/Gat40l
 J25XdWKTjAAoS1X43PvihJGq4W5qX4VugMUoC1oMqPMQNicKqIAffX+V7D2c10L82C5Y3q+JUF2
 X2NjQG710L6lErbeyg==
X-Received: by 2002:a05:6602:2dc8:b0:834:f2d5:c758 with SMTP id
 ca18e2360f4ac-844e88b1ab9mr53097939f.13.1734043687016; 
 Thu, 12 Dec 2024 14:48:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/6hrnEsW85klXCYsIIwJQSRqpriU7bNmwmtnxcICDwjzCSiqYPvFvR+pshrf4y872uWURxQ==
X-Received: by 2002:a05:6602:2dc8:b0:834:f2d5:c758 with SMTP id
 ca18e2360f4ac-844e88b1ab9mr53095739f.13.1734043686623; 
 Thu, 12 Dec 2024 14:48:06 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-844737bc76dsm444189539f.5.2024.12.12.14.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 14:48:05 -0800 (PST)
Date: Thu, 12 Dec 2024 17:48:03 -0500
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
Message-ID: <Z1toIxDzI56ODYcC@x1n>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-7-git-send-email-steven.sistare@oracle.com>
 <Z1dOBioqzQmEwW16@x1n>
 <bbb7b4a9-6078-4cb1-89c9-ec2d57b996f0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bbb7b4a9-6078-4cb1-89c9-ec2d57b996f0@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Dec 12, 2024 at 03:38:14PM -0500, Steven Sistare wrote:
> On 12/9/2024 3:07 PM, Peter Xu wrote:
> > On Mon, Dec 02, 2024 at 05:19:58AM -0800, Steve Sistare wrote:
> > > Save the memfd for ramblocks in CPR state, along with a name that
> > > uniquely identifies it.  The block's idstr is not yet set, so it
> > > cannot be used for this purpose.  Find the saved memfd in new QEMU when
> > > creating a block.  If the block size is larger in new QEMU, extend the
> > > block using fallocate, and the extra space will be useable after a guest
> > > reset.
> > > 
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > > ---
> > >   system/physmem.c | 36 ++++++++++++++++++++++++++++++++++--
> > >   1 file changed, 34 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/system/physmem.c b/system/physmem.c
> > > index 0bcb2cc..aa095a3 100644
> > > --- a/system/physmem.c
> > > +++ b/system/physmem.c
> > > @@ -70,6 +70,7 @@
> > >   #include "qemu/pmem.h"
> > > +#include "migration/cpr.h"
> > >   #include "migration/vmstate.h"
> > >   #include "qemu/range.h"
> > > @@ -1661,6 +1662,19 @@ void qemu_ram_unset_idstr(RAMBlock *block)
> > >       }
> > >   }
> > > +static char *cpr_name(RAMBlock *block)
> > > +{
> > > +    MemoryRegion *mr = block->mr;
> > > +    const char *mr_name = memory_region_name(mr);
> > > +    g_autofree char *id = mr->dev ? qdev_get_dev_path(mr->dev) : NULL;
> > > +
> > > +    if (id) {
> > > +        return g_strdup_printf("%s/%s", id, mr_name);
> > > +    } else {
> > > +        return g_strdup(mr_name);
> > > +    }
> > > +}
> > > +
> > >   size_t qemu_ram_pagesize(RAMBlock *rb)
> > >   {
> > >       return rb->page_size;
> > > @@ -2080,8 +2094,18 @@ static bool qemu_ram_alloc_shared(RAMBlock *new_block, Error **errp)
> > >   {
> > >       size_t max_length = new_block->max_length;
> > >       MemoryRegion *mr = new_block->mr;
> > > -    const char *name = memory_region_name(mr);
> > > -    int fd;
> > > +    g_autofree char *name = cpr_name(new_block);
> > > +    int fd = cpr_find_fd(name, 0);
> > 
> > If to use the proposed patch in the reply of patch 2, here this should be
> > able to be moved to qemu_ram_alloc_anonymous_fd(), IIUC.
> > 
> > > +
> > > +    if (fd >= 0) {
> > > +        if (lseek(fd, 0, SEEK_END) < max_length && ftruncate(fd, max_length)) {
> > > +            error_setg_errno(errp, errno,
> > > +                             "cannot grow ram block %s fd %d to %ld bytes",
> > > +                             name, fd, max_length);
> > > +            goto err;
> > > +        }
> > 
> > I remember we discussed something similar to this, do we need ftruncate()
> > at all?  I think not.
> > 
> > This happens when booting QEMU, so I don't think it's relevant yet to what
> > size used in src, as this is dest.
> > 
> > It starts to get relevant only when cpr migration starts on src, it sents
> > ramblocks at the beginning, then parse_ramblock() will properly resize any
> > ramblock to whatever size it should use.
> > 
> > If the resize didn't happen it can only mean that used_length is correctly
> > matched on both sides.
> > 
> > So I don't see why a special truncate() call is needed yet..
> 
> You suggested truncate:
> 
>   https://lore.kernel.org/qemu-devel/47d6d984-7002-4086-bb10-b191168f141f@oracle.com/
> 
>   "So after such system reset, QEMU might start to see new ROM code loaded
>   here (not the one that got migrated anymore, which will only match the
>   version installed on src QEMU).  Here the problem is the new firmware can
>   be larger, so I _think_ we need to make sure max_length is not modified by
>   CPR to allow resizing happen here, while if we use truncate=true here it
>   should just work in all cases."
> 
> ... but you suggested passing a truncate bool to the file_ram_alloc call after
> cpr_find_fd.  I could do that instead.  However, if qemu_ram_alloc_shared uses
> qemu_ram_alloc_from_fd instead of file_ram_alloc, per your suggestion in patch 2,
> then I will still call ftruncate here, because qemu_ram_alloc_from_fd  does not
> take a truncate argument.

My memory was when reuse qemu_ram_alloc_from_fd() in that suggestion of
patch 2, it will only create zero-length fd (with fsize=0) and leave all
the rest to qemu_ram_alloc_from_fd(), then with that:

qemu_ram_alloc_from_fd:
    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset,
                                     errp);

So that'll always have truncate==!file_size==1. Then truncate will be done
at file_ram_alloc() later, iiuc.

    if (truncate && ftruncate(fd, offset + memory)) {
        perror("ftruncate");
    }

Would this work?

Meanwhile, this whole ram resize discussion reminded me that to reuse
qemu_ram_alloc_from_fd(), we may also want to make sure to pass ->resized()
hook from qemu_ram_alloc_internal() to the fd helper too..  IOW, we may
want to keep qemu_ram_resize() invoke those hooks, even after switching to
fd-based for aux mems.

Maybe the size / max_size also need to be passed over?  As for fd ramblock
it used to be always the same on used_length/max_length, but not anymore
when we switch aux mem to fd based.  Please feel free to double check..

-- 
Peter Xu



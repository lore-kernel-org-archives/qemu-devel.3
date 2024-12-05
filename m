Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4ECE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJINV-0002dF-Qg; Thu, 05 Dec 2024 15:23:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJINT-0002co-UE
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:23:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJINS-0001Sx-75
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:23:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733430189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M/RPtdOhbs5+u5+S3nXbxpqC04BsjCHymsHNk6On+Ek=;
 b=RW4VjN6JQvE5k6GiEO3Dq+5FElclIxs1h9aUNR1qCTw0+cIX/MiJwbZ/+H6fyN82NXte7j
 wdsWMyLvUaU2UkkwfRBhoJebVHJY5PNSknyPX22ocl0WBfjQ+lqOqwyfuXQkIX4Ea8meup
 nmieNTwouxMqh+HWg2Mu0MDbC558wAo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-6WKo_jHwNzyk5RsdCGgokg-1; Thu, 05 Dec 2024 15:23:08 -0500
X-MC-Unique: 6WKo_jHwNzyk5RsdCGgokg-1
X-Mimecast-MFC-AGG-ID: 6WKo_jHwNzyk5RsdCGgokg
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d87efed6c4so22536596d6.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733430187; x=1734034987;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M/RPtdOhbs5+u5+S3nXbxpqC04BsjCHymsHNk6On+Ek=;
 b=Xp2gK5FPt24pqSGiydoyN4p6itfNCKRbDMnMd7vZgYwWXYqFxMHvj1yTycxMnxSVvx
 e8KJC26ILusjP0yw9p/ayh1rJneO3fO/bU6FwpxhZ2eJ5dM8Wnd/qBY5Skl8443IQg4q
 TEeiZIyDPOGgNme90zQy4zJF5lsW3ImsGB4H4DFjwtXsL7toW4FvCcytRQWcMd+wrniv
 rxl/IEQKD4yLVN1uC56/jyZlnvxrC+1chcvDchOQZUU7ci++zqQABWGZGNcpekN1hu3X
 NVJwftJIiZ2EHuNDMjYJr1V66IO2eIgOg/QAmKvIV93ut4Z2NsPPsw2NKPIbOXrFIRMg
 6D8A==
X-Gm-Message-State: AOJu0YxgQZ4xHhB7zTFW526FQ8M8yAHQYmhd8wZX8sW8vuRzTbv9r869
 +0faBt2TCODX3ZJxKl/xAhyNpjqFuiqF6L6oUxiri0E0PqhPoSNye5OI/uA9dVJAbJPtltxW16+
 A6AiTt+0fCMRl8lcP4eckq5uSkXoQAGPM8ijRDo0mn90UzMXUQXHT
X-Gm-Gg: ASbGncvgxeL5L2Qdm6ni0MjNdSRt3domxaYnTRsUWJR4Tg8PA8DkCMcuu962LcZCWmV
 4KMNK04PKIcFUbAyli9CdklCzJBPQqDbjDbtOJiZiKKk+ehZeADt9B6B1qHe9PyecCdaafE4h9A
 6vhqvS5s/CaOhahglk+v1GmT/J9Hdg0o3JZxn0Lv3VMXOI9RsctYhd5jeDEuxIc3msICDb1E9oW
 i6AZS8TO2UmS/2ci/l8+Rzc0yMNncyjeQXcSusY0+YiM5iia7LnZigck3/q1vSdGvyednltythA
 sNcCLwnUPDc=
X-Received: by 2002:a05:6214:d68:b0:6d4:1425:6d2d with SMTP id
 6a1803df08f44-6d8e7227aa5mr3483386d6.43.1733430187624; 
 Thu, 05 Dec 2024 12:23:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMwbDeoA6rRIguoeeoNHxnxAKW6K6/AdoiuRQsDeOjUn2+627mEHxALpqMT8taRv0VZjHorw==
X-Received: by 2002:a05:6214:d68:b0:6d4:1425:6d2d with SMTP id
 6a1803df08f44-6d8e7227aa5mr3483106d6.43.1733430187284; 
 Thu, 05 Dec 2024 12:23:07 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8dabfec80sm9887596d6.98.2024.12.05.12.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 12:23:06 -0800 (PST)
Date: Thu, 5 Dec 2024 15:23:03 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH 1/2] migration/multifd: Further remove the SYNC on complete
Message-ID: <Z1ILpzQk6Q8d1cpg@x1n>
References: <20241205185303.897010-1-peterx@redhat.com>
 <20241205185303.897010-2-peterx@redhat.com>
 <878qstj46b.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878qstj46b.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Thu, Dec 05, 2024 at 04:55:08PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Commit 637280aeb2 ("migration/multifd: Avoid the final FLUSH in
> > complete()") removed the FLUSH operation on complete() which should avoid
> > one global sync on destination side, because it's not needed.
> >
> > However that commit overlooked multifd_ram_flush_and_sync() part of things,
> > as that's always used together with the FLUSH message on the main channel.
> 
> Let's please write the full name of the flags, functions, etc. As we've
> seen in the discussion with Prasad, we're stumbling over ambiguous
> terminology. This is RAM_SAVE_FLAG_MULTIFD_FLUSH.

Sure.

> 
> >
> > For very old binaries (multifd_flush_after_each_section==true), that's
> > still needed because each EOS received on destination will enforce
> > all-channel sync once.
> 
> Ok, but why does this patch not reinstate the flag?

RAM_SAVE_FLAG_MULTIFD_FLUSH?  Because it's not needed?

> 
> >
> > For new binaries (multifd_flush_after_each_section==false), the flush and
> > sync shouldn't be needed just like the FLUSH, with the same reasoning.
> >
> > Currently, on new binaries we'll still send SYNC messages on multifd
> > channels, even if FLUSH is omitted at the end.  It'll make all recv threads
> > hang at SYNC message.
> 
> I don't get this part, is this a bug you're describing? There's not SYNC
> message on the recv side, I think you mean the MULTIFD_FLAG_SYNC and
> this code?
> 
>     if (flags & MULTIFD_FLAG_SYNC) {
>         qemu_sem_post(&multifd_recv_state->sem_sync);
>         qemu_sem_wait(&p->sem_sync);
>     }

Yes.

> 
> That's not a hang, that's the sync.

When recv side never collect that SYNC (by invoke multifd_recv_sync_main),
then it is a hang.

> 
> >
> > Multifd is still all working fine because luckily recv side cleanup
> > code (mostly multifd_recv_sync_main()) is smart enough to make sure even if
> > recv threads are stuck at SYNC it'll get kicked out.  And since this is the
> > completion phase of migration, nothing else will be sent after the SYNCs.
> 
> Hmm, a last sync on the recv side might indeed not be needed.
> 
> >
> > This may be needed for VFIO in the future because VFIO can have data to
> > push after ram_save_complete(), hence we don't want the recv thread to be
> > stuck in SYNC message. Remove this limitation will make src even slightly
> > faster too to avoid some more code.
> >
> > Stable branches do not need this patch, as no real bug I can think of that
> > will go wrong there.. so not attaching Fixes to be clear on the backport
> > not needed.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/ram.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 05ff9eb328..7284c34bd8 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -3283,9 +3283,16 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
> >          }
> >      }
> >  
> > -    ret = multifd_ram_flush_and_sync();
> > -    if (ret < 0) {
> > -        return ret;
> > +    if (migrate_multifd() &&
> > +        migrate_multifd_flush_after_each_section()) {
> > +        /*
> > +         * Only the old dest QEMU will need this sync, because each EOS
> > +         * will require one SYNC message on each channel.
> > +         */
> > +        ret = multifd_ram_flush_and_sync();
> > +        if (ret < 0) {
> > +            return ret;
> > +        }
> 
> I don't think this works. We need one last flush to not lose the last
> few pages of ram. And we need the src side sync of multifd threads to
> make sure this function doesn't return before all IO has been put on the
> wire.

This should be the question for commit 637280aeb2, I thought it got
answered there.. It's almost what the commit message there in 637280aeb2
wanted to justify too.

We don't need to flush the last pages here, because we flushed it already,
in the last find_dirty_block() call where src QEMU finished scanning the
last round.  Then we set complete_round=true, scan one more round, and the
iteration won't complete until the new round sees zero dirty page.

So when reaching this line, multifd send buffer must be empty.  We need to
flush for each round of RAM scan, we can't avoid the flush there, but we
can save this one in complete().

To explain that with code, I hacked a QEMU and assert that.  It ran all
fine here (this is definitely not for merge.. but to show what I meant):

===8<===
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index f64c4c9abd..0bd42c7627 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -21,7 +21,7 @@
 #include "qemu/error-report.h"
 #include "trace.h"

-static MultiFDSendData *multifd_ram_send;
+MultiFDSendData *multifd_ram_send;

 size_t multifd_ram_payload_size(void)
 {
diff --git a/migration/ram.c b/migration/ram.c
index 7284c34bd8..edeb9e28ff 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3228,6 +3228,8 @@ out:
     return done;
 }

+extern MultiFDSendData *multifd_ram_send;
+
 /**
  * ram_save_complete: function called to send the remaining amount of ram
  *
@@ -3283,6 +3285,10 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
     }

+    if (migrate_multifd()) {
+        assert(multifd_payload_empty(multifd_ram_send));
+    }
+
     if (migrate_multifd() &&
         migrate_multifd_flush_after_each_section()) {
         /*
===8<===

> 
> This also doesn't address what the commit message says about the recv
> side never getting the RAM_SAVE_FLAG_MULTIFD_FLUSH message.

The new binaries now always not send RAM_SAVE_FLAG_MULTIFD_FLUSH when
complete(), however it always sends the multifd SYNC messages on the wire.
It means those SYNC messages will always arrive on dest multifd channels,
and then all these channels will wait for the main thread to collect that.
However since RAM_SAVE_FLAG_MULTIFD_FLUSH is not there, they'll hang until
multifd recv cleanups.

-- 
Peter Xu



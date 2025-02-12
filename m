Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD096C021A5
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 14:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiDsP-00018Y-Jt; Wed, 12 Feb 2025 09:38:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiDsN-00016m-HH
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:38:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiDsK-0007ks-M5
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739371082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0G+4wOyF07c+GAnxTELmdhaeWIc0LeaB2PSmldT2fxo=;
 b=ORF4mtu0JIrfGfuClwsreWSvw1PDFI/PBrDtIHJFVCBHQ3oH60VhC0yabannPO/pFTywtn
 gvqZ639ko/VzKh7e0GR/bkrrW/O7uZF3XR9WATrD/F90zFYe6wEirQzW0ohM4DmfCL+odd
 FvlzvHB6n7wO2Q/BZAHNpBZBbgeNbcs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-04uAlm7-OUigpA6UPvek3A-1; Wed, 12 Feb 2025 09:38:01 -0500
X-MC-Unique: 04uAlm7-OUigpA6UPvek3A-1
X-Mimecast-MFC-AGG-ID: 04uAlm7-OUigpA6UPvek3A
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6e659664db8so10337676d6.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 06:38:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739371080; x=1739975880;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0G+4wOyF07c+GAnxTELmdhaeWIc0LeaB2PSmldT2fxo=;
 b=hq68oyocWtcthgmOJq3RyXyT2nzdcWbus+c8JepralUWR1C7FUFJOd4Yk2O/gdQAxe
 0Jj7jqSGQfC4yNouWZFr3FQW5qGCDtxHDHRwiiEQpeFKcJr2acLA8/XT5NsFgHWwR7AE
 WhkA2FWKaDYcW20qy5n0i9GnRJjLcjKe28fyFA3R9PMHakTIpbsZ46gFLLW+oEUHgLeQ
 +fL5cer5HBbCmTfriM3x/FQtrqJBSacgOt/pDLCKFQzkp3NQPe63P+4wxjr9aa8zIUZD
 Lrv22CFBUwe6byfAzGxW3TVMdXFL5PNtM4WrZlo3qGQ8eIoKd/oX5mkxTbaDznPgrDLa
 dfmA==
X-Gm-Message-State: AOJu0Yz68yQndU61dRo1ig84zttPWwDOKaDE6nszyoPyHHq5+JR/lLif
 xngvrNv3kYTgiYYBmvx2lkh1ymPVGrwWBa40V8NEr7ibFsLOCbj6G5QzNusoqCAnMjKshG78dxD
 iYgcwwsGO9B9o6/INF7y3KS/YqAwbK6KISwMIdDHf7EBDvZ0IdyHt
X-Gm-Gg: ASbGncs3Xq74qvrdYw5cvIXijilKNJvUPqE3VpwpbaN8uB0XewL+ZUuY6JHeZRedFm2
 cfl7BUxjCEQBHMY+6peu9hYVT9oWMtKcfz6LdP9iv+0ZgBEcwhT2FI5SO7LPbkL5ypg+UH9Abry
 H7/m0Q2+kDv99E1LlRLto2OWxRGCyaZLeg2KQM2AuBMZItEz2z4A3Md459r84DYAFNzhZzE71yj
 4pr4EtkFQbzO0Ooj+LpbJhCSfzhZhatPe6zOhxqedC0+vw4pqyc2rY6y+M=
X-Received: by 2002:a05:6214:1bca:b0:6d4:25c4:e775 with SMTP id
 6a1803df08f44-6e46ed7f985mr51486086d6.15.1739371080571; 
 Wed, 12 Feb 2025 06:38:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoupYcENgrVt8X15JxVrF/DbkSZDb0hBQL2ini+0VkEhGaIbOIXum7qs8/SrVuQuUanAVxjg==
X-Received: by 2002:a05:6214:1bca:b0:6d4:25c4:e775 with SMTP id
 6a1803df08f44-6e46ed7f985mr51485736d6.15.1739371080259; 
 Wed, 12 Feb 2025 06:38:00 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e452303356sm58572186d6.115.2025.02.12.06.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 06:37:59 -0800 (PST)
Date: Wed, 12 Feb 2025 09:37:57 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v5 3/5] migration: enable multifd and postcopy together
Message-ID: <Z6yyRdDabvoHrYsm@x1.local>
References: <20250205122712.229151-1-ppandit@redhat.com>
 <20250205122712.229151-4-ppandit@redhat.com>
 <Z6VCxEKxn6-_okRx@x1.local>
 <CAE8KmOwJSYq2Ok38_sq29cr7JhbLLh1ZEncP13QpDdnYKOAheQ@mail.gmail.com>
 <Z6YqstgG2bSY45dM@x1.local>
 <CAE8KmOwMTw-m0w+JbFBZ7mn-ZuSNfpk9xbq-_KbLXu7_kDhDVg@mail.gmail.com>
 <Z6owYoktb5nk2yRw@x1.local>
 <CAE8KmOy+C7QzDHJ5hfWg93zSV0ctGYYz30qsQTe-=+iq1vA+fQ@mail.gmail.com>
 <Z6tqq5jpbDHsVtVw@x1.local>
 <CAE8KmOwxobOtw0B4UVECFtgTdbMtOU2Sw09WqYryYYzG+d_UJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOwxobOtw0B4UVECFtgTdbMtOU2Sw09WqYryYYzG+d_UJQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Feb 12, 2025 at 06:57:48PM +0530, Prasad Pandit wrote:
> Hi,
> 
> On Tue, 11 Feb 2025 at 20:50, Peter Xu <peterx@redhat.com> wrote:
> > > * Yes. AFAIU, tls/file channels don't send magic values.
> > Please double check whether TLS will send magics.  AFAICT, they should.
> ===
>   * ... Also tls live migration already does
>   * tls handshake while initializing main channel so with tls this
>   * issue is not possible.
>   */
>   if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
>   } else if (mis->from_src_file
>            && (!strcmp(ioc->name, "migration-tls-incoming")
>             || !strcmp(ioc->name, "migration-file-incoming"))) {
>         channel = CH_MULTIFD;
>   }
> ===
> * From the comment and condition above, both 'tls' and 'file' channels
> are not peekable, ie. no magic value to peek. The
> 'migration-file-incoming' check also helps to cover the
> migrate_mapped_ram() case IIUC.

I think it's not because TLS channels don't send magic, but TLS channels
are not prone to ordering issues.

In general, I'm not convinced we need to check names of iochannels.

> 
> > No.  We need to figure out a way to do that properly, and that's exactly
> > what I mentioned as one of the core changes we need in this series, which
> > is still missing.  We may or may not need an ACK message.  Please think
> > about it.
> 
> * First we tried to call 'multifd_send_shutdown()' to close multifd
> channels before calling postcopy_start(). That's the best case
> scenario wherein multifd channels are closed before postcopy starts.
> So that there's no confusion and/or jumbling of different data
> packets. It did not work, as qemu would crash during
> multifd_shutdown().

Have we debugged the crash? I'm not saying we should go with this, but
crash isn't a reason to not choose a design.

> 
> * Second is we push/flush all multifd pages before calling
> postcopy_start() and let the multifd channels exist/stay till the
> migration ends, after that they are duly shutdown. It is working well
> so far, passing all migration tests too.
> 
> * Third, if we want to confirm that multifd pages are received on the
> destination before calling postcopy_start(), then the best way is for
> the destination to send an acknowledgement to the source side that it
> has received and processed all multifd pages and nothing is pending on
> the multifd channels.
> 
> * Another could be to define a multifd_recv_flush() function, which
> could process and clear the receive side multifd queue, so that no
> multifd pages are pending there. Not sure how best to do this yet.
> Also considering it lacks proper communication and synchronisation
> between source and destination sides, it does not seem like the best
> solution.
> 
> * Do you have any other option/approach in mind?
> 
> > Please consider the case where multifd recv threads may get scheduled out
> > on dest host during precopy phase, not getting chance to be scheduled until
> > postcopy already started running on dst, then the recv thread can stumble
> > upon a page that was sent during precopy.  As long as that can be always
> > avoided, I think we should be good.
> 
> * TBH, this sounds like a remote corner case.

No this is not.  As I mentioned tons of times.. copying page in socket
buffers directly into guest page during vcpus running / postcopy is a very
hard to debug issue.  If it's possible to happen, the design is flawed.

> 
> * I'm testing the revised patch series and will send it shortly.

I don't think passing the unit tests prove the series is correct and should
be merged. We need to understand how it work, or we can't merge it.

I feel very frustrated multiple times that you seem to want to ignore what
I comment.  I don't know why you rush to repost things.

After a 2nd thought, I think maybe multifd flush and sync could work on src
side indeed, because when flush and sync there'll be a message
(MULTIFD_FLUSH) on main channel and that should order against the rest
postcopy messages that will also be sent on the main channel (if we do
multifd flush before all the postcopy processes).  Then it should guarantee
when postcopy starts on dest, dest multifd recv threads flushed all
messages, and no multifd message will arrive anymore.

But again we should guard it with an assert() in recv threads if you want
to postpone recycling of multifd threads, just to double check no outliers
we overlooked.

When proposing the patches you need to justify the design first before
anything.  Please evaluate above, these things are critical to appear in
either code comments or commit messages. Please digest everything before
reposting.

Thanks,

-- 
Peter Xu



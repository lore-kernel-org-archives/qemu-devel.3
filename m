Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3D1E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 19:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJH7h-0007Dp-N2; Thu, 05 Dec 2024 14:02:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJH7g-0007DO-1c
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 14:02:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJH7d-0004o6-UP
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 14:02:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733425365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ob4eZ53MjM8lf7hgTXckxOyH+OYRKCvMdFVbicCWag=;
 b=ZWR3zKEOCBvVFFgeuIK2H3ZxztLtPiQh4dj1CK8ZLLRA0w289DLxjpVuUT6sguFlUInchk
 oGbJVSpqvLy3UoP9tF1SskWxyJK35GYvg4jf6bfvkACaa9xXfEywQ61/p3wPyHusECIf8g
 B+0IGWtFTEiNmbEe8rX4ErYy1/5R3x4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-dLFLTmjKMk6iWvU2501dPQ-1; Thu, 05 Dec 2024 14:02:41 -0500
X-MC-Unique: dLFLTmjKMk6iWvU2501dPQ-1
X-Mimecast-MFC-AGG-ID: dLFLTmjKMk6iWvU2501dPQ
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d87c55ca85so33671626d6.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 11:02:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733425361; x=1734030161;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ob4eZ53MjM8lf7hgTXckxOyH+OYRKCvMdFVbicCWag=;
 b=typJg0YA69PIlhDYnO+FFX1rO+uoUshOOU8xsJ+PWvzGiv4lAraT/UirRjVgdTCpzV
 T+Vnr0+7JWTTF7D2M8yBVKvRoO19TjdTLnxzFR0JkCxbFjWbl4WddMnlxg20EjOwI8Gq
 6cFj06F6tCfvu1yFSM79nzBMm8MwTrZxBI+K/LduUHftobu/7ugWIEoT4fdmSCQnnfdo
 xgfPhrp3XnxouYcrKtCnEQRKaYGYEEWkRI4zag8BTy2nHg+cNb2L+KaPX5VWMLWoAOpu
 3iQCJXHEH7Uzq92muiGERBKUdpjR6LNBNimWCmidEimO8MRkz11UX9bCOcSxPHzFOFLi
 rm3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS6Xq1v0WwwpALGEYK6LjoF50gcRnfk63/8C0BrmjA+0lUUYSPsaUOD6g7VZIw26zIPqlmZtpm5hRs@nongnu.org
X-Gm-Message-State: AOJu0YxM8xSzBKjNeNt1iSP18QRdRK2GhANBPlh7aTvD9Zo5HDjIFZ2A
 iGOhK6obRDAXKcTnJGgjp9U780mGGneOj9iwjQXCbg45VvT2d0uHxtxZw2GpsZjI631k0ZfB+rw
 zcLAEeHqPLKPZ6U57XE7YIDwLrc6xixpHU7aTWTaxOA+KPN2l8R0o
X-Gm-Gg: ASbGncthNcmAEN3GxZOx1UPLKG5mMMTAsxOnKFxK8U9jaybAlU9W+yGiLy8zyMAZyAS
 EGowDsxjUuT/1ebjf81dXOoukFxhIUgRjLWWmhVP03mW3o3fdm8Uh1VO2P2N/ptL6G178ITQiR3
 tSyLXru4SHByugdSwU3h4xRu9ohKqsLG1g5yFPpYmQ9a8CLKmpBNAJ5P6k9Fy0vkBKjnPRzrCo3
 627LkMLTAnDg5OKfIqHSJMVjcT7gIDvIMJNAQjbjLgP9RuoR/Hm8m4HmW7FUClKvBpB4/XQYq/u
 NOR3pUk4xJ0=
X-Received: by 2002:a05:6214:dcb:b0:6d8:898a:a508 with SMTP id
 6a1803df08f44-6d8e70d66c5mr495886d6.16.1733425360958; 
 Thu, 05 Dec 2024 11:02:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNE+XhuZ0hhHrOwsia03/6Ypw1mLzFk+7FEhU6fEZCv/FM5z5LRmXdFJ9sfcdCYazlAb2IAA==
X-Received: by 2002:a05:6214:dcb:b0:6d8:898a:a508 with SMTP id
 6a1803df08f44-6d8e70d66c5mr495406d6.16.1733425360474; 
 Thu, 05 Dec 2024 11:02:40 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8dabfbad5sm9267336d6.105.2024.12.05.11.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 11:02:39 -0800 (PST)
Date: Thu, 5 Dec 2024 14:02:37 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 16/24] migration/multifd: Send final SYNC only after
 device state is complete
Message-ID: <Z1H4zS_TXZtVJOhw@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <0b8131dc6107841969d254e88e9d6e14220f1ea5.1731773021.git.maciej.szmigiero@oracle.com>
 <87mshln2e8.fsf@suse.de>
 <945bab06-b6e6-449e-b810-7800b996ba83@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <945bab06-b6e6-449e-b810-7800b996ba83@maciej.szmigiero.name>
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

On Tue, Nov 26, 2024 at 10:22:42PM +0100, Maciej S. Szmigiero wrote:
> On 26.11.2024 21:52, Fabiano Rosas wrote:
> > "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
> > 
> > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > 
> > > Currently, ram_save_complete() sends a final SYNC multifd packet near this
> > > function end, after sending all of the remaining RAM data.
> > > 
> > > On the receive side, this SYNC packet will cause multifd channel threads
> > > to block, waiting for the final sem_sync posting in
> > > multifd_recv_terminate_threads().
> > > 
> > > However, multifd_recv_terminate_threads() won't be called until the
> > > migration is complete, which causes a problem if multifd channels are
> > > still required for transferring device state data after RAM transfer is
> > > complete but before finishing the migration process.
> > > 
> > > Defer sending the final SYNC packet to the end of sending of
> > > post-switchover iterable data instead if device state transfer is possible.
> > > 
> > > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > 
> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > 
> > I wonder whether we could just defer the sync for the !device_state case
> > as well.
> > 
> 
> AFAIK this should work, just wanted to be extra cautious with bit
> stream timing changes in case there's for example some race in an
> older QEMU version.

I see the issue, but maybe we don't even need this patch..

When I was working on commit 637280aeb2 previously, I forgot that the SYNC
messages are together with the FLUSH which got removed.  It means now in
complete() we will sent SYNCs always, but always without FLUSH.

On new binaries, it means SYNCs are not collected properly on dest threads
so it'll hang all threads there.

So yeah, at least from that part it's me to blame..

I think maybe VFIO doesn't need to change the generic path to sync, because
logically speaking VFIO can also use multifd_send_sync_main() in its own
complete() hook to flush everything.  Here the trick is such sync doesn't
need to be attached to any message (either SYNC or FLUSH, that only RAM
uses).  The sync is about "sync against all sender threads", just like what
we do exactly with mapped-ram.  Mapped-ram tricked that path with a
use_packet check in sender thread, however for VFIO we could already expose
a new parameter to multifd_send_sync_main() saying "let's only sync
threads".

I sent two small patches here:

https://lore.kernel.org/r/20241205185303.897010-1-peterx@redhat.com

The 1st patch should fix the SYNC message hang for 637280aeb2 that I did.
The 2nd patch introduced the flag that I said.  I think after that applied
VFIO should be able to sync directly with:

  multifd_send_sync_main(MULTIFD_SYNC_THREADS);

Then maybe we don't need this patch anymore.  Please have a look.

PS: the two patches could be ready to merge already even before VFIO, if
they're properly reviewed and acked.

Thanks,

-- 
Peter Xu



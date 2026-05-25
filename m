Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02C6CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRX5y-0001cO-D8; Mon, 25 May 2026 11:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wRX5x-0001cF-RP
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wRX5v-0001SF-R7
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779722395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yWqjHJXt3IDJhQ7ssjPOZIgUKq8dLat0BajA0Nj+5N4=;
 b=J0m0aXzmtARelv7p+XfkhULax6vQhnmb6F5dbgM3Zj7aZBf7de4Mts0D1erLR3fJOqk44d
 gcS7aSDTlhjA5/u1Yn7j+CMX0R9jopnQTib3pgokh/rAYs0wkZipuIEORrKhA+ClG7HUCX
 AAj/FKtTPSGlYOJfECzi3OQXhjaC7ss=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-8Xq3FyxIOV6u_o-4YmMx0Q-1; Mon, 25 May 2026 11:19:53 -0400
X-MC-Unique: 8Xq3FyxIOV6u_o-4YmMx0Q-1
X-Mimecast-MFC-AGG-ID: 8Xq3FyxIOV6u_o-4YmMx0Q_1779722393
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-914ac21c562so713383185a.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779722393; x=1780327193; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yWqjHJXt3IDJhQ7ssjPOZIgUKq8dLat0BajA0Nj+5N4=;
 b=pYDB+gBdGYJJKb8oKf0tEoU4M1xk5mzxnOD0T8PlnH7jJextDnr8cwkT9USQtHvXHI
 AUs4HwBDw9F2XB/gzP5c8QqcZYDEXEO4ZykDvmFw3dIxe5QS7AclPGUeq8/Vrsj3qVmB
 8Lmi5DxmDIZS7epzyHUzEjUYiLKJ5gyqS3qZsjWy/ytSLike4Cktpb56VkQNDil7m9fm
 4iq/4yEk1ZgaDegE9SgzBXWqXoA/J9ddXzr4RDoaQVqD6Ja1lKYFFpcX4lDP8CJAfLCx
 oMJXEjADwElg+TzoyTMTmjQYaCuZGAHKHODVRhgmAjWxlOJK3N0xuXwgkeDnZS2OS0kI
 qCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722393; x=1780327193;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWqjHJXt3IDJhQ7ssjPOZIgUKq8dLat0BajA0Nj+5N4=;
 b=EqR50Zi8LLNsxjsZKAzo9mx9GG7kPP8POOyyV60nz22v7RwpMgz0mzzR8OxLDyw3dv
 o3bLOChsVDM27eD1F6ffkgvLtdwzRd6WnZWFgb8Dx2sH50OYa9OtyWny8xIf9nFTEBPi
 nYgGM9HkSPJKdbnBZLSCeTjAxG9RU6x30lkrjj/o8LQJMGYkIW0f2YReiP6rNFtAaA+x
 x1My1LfS8PNGB3+CwMMFyS10hNkIRseE22e1vHqdeYeY7EtzubDi+mstiOJpMJHkW2uA
 RX3GGbto7qwmrudG46nC/LWNYCznb59ZkUMv/iVajJi8u+ktZTQ7RSrUgudXn0JWwz0H
 8vGg==
X-Gm-Message-State: AOJu0YxNbNkk3KviBYGi5KEXujapRz9bACd6LuRyEj2LCcoSCwNJR/Sp
 3u4OR1lvQW7kqTbmy+ym/lgAuYf2CXlVzLWc+banLhIwiu7D5gdiw8CMp3uZ12fklDxKkmbRKse
 LL63W85bwUPA1D9ZWLY0oy7IyhXsFtVqRL9aNV4cjMsYh+yAqdgClRbt4
X-Gm-Gg: Acq92OH5yMP+SbZFD3Bct9abUCV0G/0/a2LYUC9xXG9wJ/VGPsEk3tKElRjFO8Ea9WI
 m+17YXCpOqe3bzGfuTNjFMLtGJ8LOMo8Eh2/QqU2drWnC5vT2p52B86tC4Y3gwf9sLsdoWhsZIt
 +z9e0RblZ+/5nDfSScl4is3sCeBeK7sN2eSUFLd+Vy7RHiyEGkMXf76pavqLh6Bcs+l1tMnldfG
 RdcoYY/Yn3QSDeccN4jvFezKzACTkRoK1t/KDW5Apzco1hoYDUCcHy1jytH0O8fn1qvleVzaF2E
 DqEnOazxtBFhUGE3Lah1c2SGXzPRC8rf7lp4FkpYJKiLeGfSj8y6gJe3M+IWDygP0jaWoalO0b8
 8hl5xTBjYRnPvAZ6uvSomWV1nSN/4LuOOsb8EIzuwbFgGNpA=
X-Received: by 2002:a05:620a:278c:b0:914:bf8a:ba63 with SMTP id
 af79cd13be357-914bf8abf6bmr1877363885a.56.1779722392842; 
 Mon, 25 May 2026 08:19:52 -0700 (PDT)
X-Received: by 2002:a05:620a:278c:b0:914:bf8a:ba63 with SMTP id
 af79cd13be357-914bf8abf6bmr1877358585a.56.1779722392326; 
 Mon, 25 May 2026 08:19:52 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914bb8cd260sm1036298085a.2.2026.05.25.08.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:19:51 -0700 (PDT)
Date: Mon, 25 May 2026 11:19:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH 09/14] vfio/migration: Re-query precopy size before
 sending VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
Message-ID: <ahRoln21IZAO_iOA@x1.local>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-10-avihaih@nvidia.com>
 <agzAzawATnGGMIGO@x1.local>
 <e4803220-4d73-433a-b697-3aa67dc55e12@nvidia.com>
 <ag8e-Czuujdt5hm1@x1.local>
 <5af18c64-267e-4948-98c9-20d94b4db4e9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5af18c64-267e-4948-98c9-20d94b4db4e9@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, May 24, 2026 at 09:45:33AM +0300, Avihai Horon wrote:
> 
> On 5/21/2026 6:04 PM, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Thu, May 21, 2026 at 04:46:31PM +0300, Avihai Horon wrote:
> > > On 5/19/2026 10:58 PM, Peter Xu wrote:
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > On Tue, May 05, 2026 at 11:14:18AM +0300, Avihai Horon wrote:
> > > > > When precopy initial_bytes reaches zero VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
> > > > > flag is sent to the destination to indicate that initial data has been
> > > > > sent, so destination can indicate back to source when it finished
> > > > > loading it.
> > > > > 
> > > > > To get a more accurate estimation of initial_bytes, re-query precopy
> > > > > size before sending the flag. Extract the flag sending logic from
> > > > > vfio_save_iterate() to a new helper for clarity.
> > > > > 
> > > > > This may prevent premature sending of VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
> > > > > flag if, for example, the previously queried initial_bytes was lower
> > > > > than actually is. Additionally, it prevents sending the flag if
> > > > > vfio_query_precopy_size() failed.
> > > > > 
> > > > > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > > > > ---
> > > > >    hw/vfio/migration.c  | 37 ++++++++++++++++++++++++++++++++-----
> > > > >    hw/vfio/trace-events |  1 +
> > > > >    2 files changed, 33 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > > > > index 2911583ee1..243624b5fe 100644
> > > > > --- a/hw/vfio/migration.c
> > > > > +++ b/hw/vfio/migration.c
> > > > > @@ -456,6 +456,37 @@ static void vfio_update_estimated_pending_data(VFIOMigration *migration,
> > > > >                                             data_size);
> > > > >    }
> > > > > 
> > > > > +/* Returns true if the init data flag was sent, false otherwise */
> > > > > +static bool vfio_send_init_data_flag(QEMUFile *f, VFIOMigration *migration)
> > > > > +{
> > > > > +    VFIODevice *vbasedev = migration->vbasedev;
> > > > > +    int ret;
> > > > > +
> > > > > +    if (!migrate_switchover_ack()) {
> > > > > +        return false;
> > > > > +    }
> > > > > +
> > > > > +    if (migration->precopy_init_size || migration->initial_data_sent) {
> > > > > +        return false;
> > > > > +    }
> > [1]
> > 
> > > > > +
> > > > > +    /*
> > > > > +     * precopy_init_size holds an estimation of the initial data size, re-query
> > > > > +     * precopy size to ensure it's really zero before sending init data flag.
> > > > > +     * Don't send the flag if query fails.
> > > > > +     */
> > > > > +    ret = vfio_query_precopy_size(migration);
> > > > > +    if (ret || migration->precopy_init_size) {
> > > > > +        return false;
> > > > > +    }
> > > > IIUC this chunk isn't necessary?  If we don't expect REINIT to happen that
> > > > much (when NIC reconfigures?), then we can still rely on the window where
> > > > the "new switchover ack" will be requested later on during the exact sync.
> > > > 
> > > > Relying on that seems slightly cleaner.
> > > Not sure I follow.
> > > 
> > > New switchover ack is requested in exact sync if we see new init_bytes > 0
> > > (REINIT flag).
> > > This flow happens only after the new switchover ack is requested in exact
> > > sync, when init_bytes = 0 again.
> > > 
> > > So this chunk just makes sure we send the VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
> > > flag at the right time.
> > AFAIU, what this chunk does is, we may save one switchover-ack if REINIT
> > got here.  It doesn't provide much functional difference in reality.
> > 
> > With this code there, when it happens to see REINIT, instead of sending an
> > immediate VFIO_MIG_FLAG_DEV_INIT_DATA_SENT message, it falls back to send
> > init data in the next iteration loop, saving that flag, and saving a
> > "request switchover-ack" on src QEMU too.
> > 
> > If above code removed, IIUC VFIO will send VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
> > immediately causing dest sends ACK.  vfio_query_precopy_size() will be
> > postponed until the next sync query (which must happen at some point before
> > final switchover), then it will be collected there, VFIO src will request
> > for switchover-ack, then another VFIO_MIG_FLAG_DEV_INIT_DATA_SENT is
> > expected.
> > 
> > Both should work, but what I meant is, I think we don't need this random
> > check, because it's optimistic, it's not functionally necessary, IIUC.
> > 
> > IOW, see the current code and how it can still race with a REINIT anyway:
> > 
> >               migration thread                                  some vfio driver thread
> > 
> >      ret = vfio_query_precopy_size(migration);
> >      if (ret || migration->precopy_init_size) {
> >          return false;
> >      }
> >                                                                     got reconfigured,
> >                                                                     set REINIT
> > 
> >      qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
> >      migration->initial_data_sent = true;
> >      trace_vfio_send_init_data_flag(vbasedev->name);
> > 
> > It's the same to me if e.g. we try to vfio_query_precopy_size() in VFIO's
> > iterative loops from time to time, it'll also work, it'll make sync more
> > frequent, but it's not needed.
> 
> I see what you mean now.
> However, the purpose of this chunk is not to check for another REINIT, but
> rather to ensure VFIO_MIG_FLAG_DEV_INIT_DATA_SENT is sent at the right time
> -- when init_bytes is truly 0.

IIUC, that part should normally be guaranteed by this line you added prior
to it:

+    if (migration->precopy_init_size || migration->initial_data_sent) {
+        return false;
+    }

Hence when reaching vfio_query_precopy_size(), precopy_init_size==0.

IOW, I think sending INIT_DATA_SENT is fine once it's guarateed the next
vfio_query_precopy_size() will revoke it by the newly populated REINIT
data.  Essentially, the race window is pretty small here.

If you still want to keep it there, I'm still fine; having this extra check
isn't making this incorrect.  I just want to make sure we're on the same
page.

Thanks,

> 
> If the flag is sent before init_bytes = 0 then dest may ack too early,
> before it did the time-consuming load and we risk having that load during
> downtime (see my next response to the cover letter).
> 
> At first I thought mlx5 may report init_bytes estimate which is a bit lower
> than the actual value but then I realized it can't happen. However, I chose
> to keep this patch because it's aligned with the uapi that defines
> init_bytes as an estimate, and because it covers the case where precopy info
> ioctl fails.
> 
> Granted, if initial_bytes is so important I'd expect drivers to report a
> pretty accurate value, but still, it's aligned with the uapi definition and
> doesn't hurt.
> 
> Thanks.
> 

-- 
Peter Xu



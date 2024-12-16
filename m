Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31C3E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 17:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNEyb-0004WT-SG; Mon, 16 Dec 2024 12:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNEyX-0004UG-KB
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:33:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNEyU-0002zX-SI
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:33:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734370419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lQeA2AkTI5026v6vXxQxE9m9Kj5cDIF1Zu2Z4r7pfvc=;
 b=YAD7XIPsHhE/omoFNWNN1QN11nlYa98DVm5FGWgt4rjEsx36UX8PWiYxOGq41sR0SzDVx0
 Sa6WCvNXN7x2YzKIOz3gxHhSpnVjxchm0DEcpmNJEZgeg1abcyOGY4l7CTje4GrKbMcag1
 vLQSQyFlvv3GohclfTYIfrMq/j6xyNA=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-lqIZOLj2N0OmPn0q_735yw-1; Mon, 16 Dec 2024 12:33:38 -0500
X-MC-Unique: lqIZOLj2N0OmPn0q_735yw-1
X-Mimecast-MFC-AGG-ID: lqIZOLj2N0OmPn0q_735yw
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3ac98b49e4dso43005955ab.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 09:33:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734370417; x=1734975217;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lQeA2AkTI5026v6vXxQxE9m9Kj5cDIF1Zu2Z4r7pfvc=;
 b=wYGmGankk95m/34KeGJeU5rmcsAP4kCKNi5InkGi1cpO+KdRBtZoLHz0EQZCxYQWR+
 glU4AioDj44fLwQcNjpWn53M9bpGKo0xuwYvfn2Pg+p4DcKTq3fHA3QOPdDc/RedQMWz
 RpuGnjJeDtd6xjFeRskdvFeofPBenkiJgV4eKDNuELa8Mdp4dIqhXcw042G6yxPeqTvl
 SMj9SloblODSkaUdvTB3LEehVZHAnn55teqsJ4tXyEbswMIPixXF2B2URrbsPcXzxKAk
 zkSawAYIjpV3UUfLjFCduRtpFmCEKmwCsxqApd3p4u2bUVYSrZ4mh72IN/I+4P4pRooW
 pUdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSAhcg9aJ+VmwC2+TvpdE2Q5PFXe5UupoQw1U8uRHf5d4oj4e8p/EHZivlkszKAK9VOjz1GhLLajgh@nongnu.org
X-Gm-Message-State: AOJu0YzRYQMCOxa2i3LPquXT7qyTmaXL4xfLKfONuEJFAO+7pu5JRgIN
 jukLEyuh1XnmkQzjPjBKjvtJsfs7+cF0jkOoxDWOYM8NX9SbwaVqFBECa6OBL5VvRt6eYylEWtx
 4qr/2zAZzpiclGSY6m/Jf9uaVYFDrxXMc/fBPky9B1Tn77xNlvhRM
X-Gm-Gg: ASbGncuTnW4ULbWXfdajk0wWojGyDrf8+Mkq23IKpRmDa1Z9CgHtOjrdj0gHFYBMQdq
 fEYJO2aqaGPsx6TcccllPnbH/2Mdbv8Y+f3P6uR781MxjQ5zOaMfWNCI4mBm0AVaQw7kRij5FOl
 pzVY68SlmkdiYUw+HeIw3Ix1YQFL12cboa1YvbJiRp0IWlFbcucycFcBzf2JRa8YXNoGbExJbVl
 xFm6UlO7NzRcZqSsssvCpcDEdJsl5lqcLnwHuvmOumFfV9928O07E/BFMIxVYdl21SodurOWVuU
 9avPnT6ABH+kfgFfPw==
X-Received: by 2002:a05:6e02:1a84:b0:3a7:8720:9de8 with SMTP id
 e9e14a558f8ab-3afee9a26a9mr144854235ab.5.1734370417478; 
 Mon, 16 Dec 2024 09:33:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdX5tBf/HaLjwbyDRu+6WN8IUBJJAMQ9KdLx15Gi4u5ZFDowndWPYIBpejovwzOVQRsdPAiQ==
X-Received: by 2002:a05:6e02:1a84:b0:3a7:8720:9de8 with SMTP id
 e9e14a558f8ab-3afee9a26a9mr144853925ab.5.1734370417112; 
 Mon, 16 Dec 2024 09:33:37 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3b24dac9d90sm16372015ab.78.2024.12.16.09.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 09:33:36 -0800 (PST)
Date: Mon, 16 Dec 2024 12:33:34 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Avihai Horon <avihaih@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 24/24] vfio/migration: Multifd device state transfer
 support - send side
Message-ID: <Z2BkbkF6P-2MHNN2@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <4f5c33b97be09fcb4e1885073e31c5e930a39ad0.1731773021.git.maciej.szmigiero@oracle.com>
 <51279885-5229-4c5f-93af-d1214dd65f90@nvidia.com>
 <06360868-95e3-46e2-8960-51348025a1b7@maciej.szmigiero.name>
 <1ea676b5-c52a-4745-b5ce-f0376b1e6473@nvidia.com>
 <8f38a345-ad63-4168-907e-ac1cf736b2d1@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f38a345-ad63-4168-907e-ac1cf736b2d1@maciej.szmigiero.name>
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

On Thu, Dec 12, 2024 at 11:53:05PM +0100, Maciej S. Szmigiero wrote:
> On 12.12.2024 15:54, Avihai Horon wrote:
> > 
> > On 11/12/2024 1:06, Maciej S. Szmigiero wrote:
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > On 9.12.2024 10:28, Avihai Horon wrote:
> > > > 
> > > > On 17/11/2024 21:20, Maciej S. Szmigiero wrote:
> > > > > External email: Use caution opening links or attachments
> > > > > 
> > > > > 
> > > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > > > 
> > > > > Implement the multifd device state transfer via additional per-device
> > > > > thread inside save_live_complete_precopy_thread handler.
> > > > > 
> > > > > Switch between doing the data transfer in the new handler and doing it
> > > > > in the old save_state handler depending on the
> > > > > x-migration-multifd-transfer device property value.
> > > > > 
> > > > > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > > > > ---
> > > > >   hw/vfio/migration.c  | 155 +++++++++++++++++++++++++++++++++++++++++++
> > > > >   hw/vfio/trace-events |   2 +
> > > > >   2 files changed, 157 insertions(+)
> > > > > 
> > > > > diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > > > > index b54879fe6209..8709672ada48 100644
> > > > > --- a/hw/vfio/migration.c
> > > > > +++ b/hw/vfio/migration.c
> > > > > @@ -771,6 +771,24 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
> > > > >       uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
> > > > >       int ret;
> > > > > 
> > > > > +    /*
> > > > > +     * Make a copy of this setting at the start in case it is changed
> > > > > +     * mid-migration.
> > > > > +     */
> > > > > +    if (vbasedev->migration_multifd_transfer == ON_OFF_AUTO_AUTO) {
> > > > > +        migration->multifd_transfer = vfio_multifd_transfer_supported();
> > > > > +    } else {
> > > > > +        migration->multifd_transfer =
> > > > > +            vbasedev->migration_multifd_transfer == ON_OFF_AUTO_ON;
> > > > > +    }
> > > > > +
> > > > > +    if (migration->multifd_transfer && !vfio_multifd_transfer_supported()) {
> > > > > +        error_setg(errp,
> > > > > +                   "%s: Multifd device transfer requested but unsupported in the current config",
> > > > > +                   vbasedev->name);
> > > > > +        return -EINVAL;
> > > > > +    }
> > > > > +
> > > > >       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
> > > > > 
> > > > >       vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
> > > > > @@ -942,13 +960,32 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
> > > > >       return !migration->precopy_init_size && !migration->precopy_dirty_size;
> > > > >   }
> > > > > 
> > > > > +static void vfio_save_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f)
> > > > > +{
> > > > > +    VFIOMigration *migration = vbasedev->migration;
> > > > > +
> > > > > +    assert(migration->multifd_transfer);
> > > > > +
> > > > > +    /*
> > > > > +     * Emit dummy NOP data on the main migration channel since the actual
> > > > > +     * device state transfer is done via multifd channels.
> > > > > +     */
> > > > > +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> > > > > +}
> > > > > +
> > > > >   static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
> > > > >   {
> > > > >       VFIODevice *vbasedev = opaque;
> > > > > +    VFIOMigration *migration = vbasedev->migration;
> > > > >       ssize_t data_size;
> > > > >       int ret;
> > > > >       Error *local_err = NULL;
> > > > > 
> > > > > +    if (migration->multifd_transfer) {
> > > > > +        vfio_save_multifd_emit_dummy_eos(vbasedev, f);
> > > > > +        return 0;
> > > > > +    }
> > > > 
> > > > I wonder whether we should add a .save_live_use_thread SaveVMHandlers through which a device can indicate if it wants to save its data with the async or sync handler.
> > > > This will allow migration layer (i.e., qemu_savevm_state_complete_precopy_iterable) to know which handler to call instead of calling both of them and letting each device implicitly decide.
> > > > IMHO it will make the code clearer and will allow us to drop vfio_save_multifd_emit_dummy_eos().
> > > 
> > > I think that it's not worth adding a new SaveVMHandler just for this specific
> > > use case, considering that it's easy to handle it inside driver by emitting that
> > > FLAG_END_OF_STATE.
> > > 
> > > Especially considering that for compatibility with other drivers that do not
> > > define that hypothetical new SaveVMHandler not having it defined would need to
> > > have the same effect as it always returning "false".
> > 
> > We already have such handlers like .is_active, .has_postcopy and .is_active_iterate.
> > Since VFIO migration with multifd involves a lot of threads and convoluted code paths, I thought this could put some order (even if small) into things, especially if it allows us to avoid the vfio_save_multifd_emit_dummy_eos() which feels a bit hackish.
> > 
> > But anyway, that's only my opinion, and I can understand why this could be seen as an overkill.
> 
> @Cedric, @Peter:
> what's your opinion here?
> 
> Is it better to add a new "flag" SaveVMHandler or keep handling
> the multifd/non-multifd transfer difference in the VFIO driver
> by emitting VFIO_MIG_FLAG_END_OF_STATE in
> vfio_save_complete_precopy() and vfio_save_state()?
> 
> Note that this new "flag" SaveVMHandler would need to have
> semantics of disabling both save_live_complete_precopy and
> save_state handlers and enabling save_live_complete_precopy_thread
> instead.

If it's about adding one more global vmstate hook (even if only used in
vfio), only to conditionally disable two other random vmstate hooks, then
it isn't very attractive idea to me indeed.

PS: when I look at is_active (which is only used by two sites but needs to
be invoked in literally all the rest hooks, and I doubt whether it could
change during migration at all..), or has_postcopy (which is weird in
another way, e.g., should we simply forbid pmem+postcopy setup upfront?), I
doubt whether they were the best solution for the problems.. but that's
separate questions to ask.

Thanks,

-- 
Peter Xu



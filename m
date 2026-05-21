Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFF3CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 15:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ4wv-0003vh-1L; Thu, 21 May 2026 11:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wQ4wt-0003vZ-N6
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:04:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wQ4wq-0007l3-JA
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779375870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4D507b+6WiZy2A/DOR+57cp5mAHYx97R/Rn05JqTByE=;
 b=H2F9vav2YAald2CtcmVLcarzEaL9gUxw6pD17JZFL5w02Za/lJaQRgnRVgE/+MY2ffGDWW
 kz9bYbQw/2B59mNkjrdGguq/IDNe/2NnUMh49/EzWcKTumYrOqTTuHAFuArlKX6qoUamEJ
 SwxEcOpJMLo0pF71llN1Cjqh7xtqy3g=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-xhtF30aJM5mtLW1g0IUtlQ-1; Thu, 21 May 2026 11:04:28 -0400
X-MC-Unique: xhtF30aJM5mtLW1g0IUtlQ-1
X-Mimecast-MFC-AGG-ID: xhtF30aJM5mtLW1g0IUtlQ_1779375868
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-90d2d8dc97bso1440270585a.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779375868; x=1779980668; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4D507b+6WiZy2A/DOR+57cp5mAHYx97R/Rn05JqTByE=;
 b=hl0Qv1mTPgQCQ5s+ZaFxWOTNs1cHaqmPVmny8rxMmDPeHF1NElowBikXN6tTjRtuAn
 ABgI+dFgMYlDpMULdx/PPqTSSLkl3lJiNd8XqVo3L3De/rS+gFWU9NbE8BggdbAK7nOZ
 yes+S6qZPRHBA732weDUDcn1FLo3C/9yw6sSCFp5bWlmkl13Ss22aXzQbnW1IejFCTiR
 dotXjaDv9L50Kgzco9kc9eVlhKaYI9abS57v834AuixH/b5jYT7M4yNHoCdvcEVRepe2
 SPP6DL3Kd/8ePFL0HTQMbE76AEvFd0bCH9oerkF8GdxLxTTkT17nAvyPuWjesoSIIaLw
 S0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779375868; x=1779980668;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4D507b+6WiZy2A/DOR+57cp5mAHYx97R/Rn05JqTByE=;
 b=oUFPnp7+IyViliJdWUfYipq1OGFiaJJ17FMlpf2ChBPn90Ra0JPIciDXkqbPZt0Y28
 bvw4gbTf5NSnSsxbebGs+q6GE6CJkRsS8aKzFUlTzdE+qo7BFwVRde02juF+em+yWOLo
 C3RpGY4daxb0UrQy7IpAhGWiStU5sodwp9VLJ/kqAuaIZ93r8lcWywfwAswP1aAK+18Z
 yW5I5XATcybopNVQhf3y2SZkKfLt0X54LWnTWMwOXznQFK8zd3UZtNEx7bzfi5E62Qj8
 Pg73Pq52v6IAHdzwlC5iq+8wYg551w9aEBeCuxnd1Ep/Ef1GdSGaDUpWuhScx+NakU2S
 yNwA==
X-Gm-Message-State: AOJu0YxWacBJ1pWSlT9YjePQI+wVJoq0epy3WZWPulXRGu7ALi9/aAj2
 PahbW0IpGA41zMwUHrhf7i2fzF3EJ91S9dCYKx0PVtmLYKxoXmtQErpBek3rMM42sJgo10csr0N
 nG5jeLHx1ahtLR4GNq6fxisGS6v/qwXjibV0KFor/64PG459nB2JigHt3
X-Gm-Gg: Acq92OGmJqhP/zXE4cYiPNBMcQyjPOg2UWuhrEJw2xgFgbrHx/KBJGtpTjZ4bZYsWTa
 v7MpuOc7Luz0G5Mz6gq5baVBjKFAQZvotDwo1jppynQq/hCcszjZg75wWDIp9Z/iJUcKjE2ci/3
 sjb5S44AlGlMgUIiyxcy2/oSXq3k5zkA5xKxLvMo+PDVwh6xLdYQgBYhaVtTZbpgrzU82RM/F/N
 OLfBVpEqABlGsy4aPIdMa0n7genxj3wL+2ypzqA9jyOfK4XN9gJOYZTLzkrHCg86FPyf++PBa0q
 ffov3vs0nev4Qr3dy6cLbd37mtKzUN0RxiCVg31gOpvF9yxuayUdFe63KTyOzF9DRo7xbzg8xhQ
 0qaT6ZIYFE3p1nDxtH+BizQZh/4PpIjBzCwQQRMd2yIOW5n0=
X-Received: by 2002:a05:620a:4611:b0:8c6:ae78:f750 with SMTP id
 af79cd13be357-914a2a5dcd6mr443513885a.14.1779375867712; 
 Thu, 21 May 2026 08:04:27 -0700 (PDT)
X-Received: by 2002:a05:620a:4611:b0:8c6:ae78:f750 with SMTP id
 af79cd13be357-914a2a5dcd6mr443502085a.14.1779375866742; 
 Thu, 21 May 2026 08:04:26 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914abbb1af1sm107984985a.37.2026.05.21.08.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 08:04:25 -0700 (PDT)
Date: Thu, 21 May 2026 11:04:24 -0400
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
Message-ID: <ag8e-Czuujdt5hm1@x1.local>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-10-avihaih@nvidia.com>
 <agzAzawATnGGMIGO@x1.local>
 <e4803220-4d73-433a-b697-3aa67dc55e12@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4803220-4d73-433a-b697-3aa67dc55e12@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 21, 2026 at 04:46:31PM +0300, Avihai Horon wrote:
> 
> On 5/19/2026 10:58 PM, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Tue, May 05, 2026 at 11:14:18AM +0300, Avihai Horon wrote:
> > > When precopy initial_bytes reaches zero VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
> > > flag is sent to the destination to indicate that initial data has been
> > > sent, so destination can indicate back to source when it finished
> > > loading it.
> > > 
> > > To get a more accurate estimation of initial_bytes, re-query precopy
> > > size before sending the flag. Extract the flag sending logic from
> > > vfio_save_iterate() to a new helper for clarity.
> > > 
> > > This may prevent premature sending of VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
> > > flag if, for example, the previously queried initial_bytes was lower
> > > than actually is. Additionally, it prevents sending the flag if
> > > vfio_query_precopy_size() failed.
> > > 
> > > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > > ---
> > >   hw/vfio/migration.c  | 37 ++++++++++++++++++++++++++++++++-----
> > >   hw/vfio/trace-events |  1 +
> > >   2 files changed, 33 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > > index 2911583ee1..243624b5fe 100644
> > > --- a/hw/vfio/migration.c
> > > +++ b/hw/vfio/migration.c
> > > @@ -456,6 +456,37 @@ static void vfio_update_estimated_pending_data(VFIOMigration *migration,
> > >                                            data_size);
> > >   }
> > > 
> > > +/* Returns true if the init data flag was sent, false otherwise */
> > > +static bool vfio_send_init_data_flag(QEMUFile *f, VFIOMigration *migration)
> > > +{
> > > +    VFIODevice *vbasedev = migration->vbasedev;
> > > +    int ret;
> > > +
> > > +    if (!migrate_switchover_ack()) {
> > > +        return false;
> > > +    }
> > > +
> > > +    if (migration->precopy_init_size || migration->initial_data_sent) {
> > > +        return false;
> > > +    }

[1]

> > > +
> > > +    /*
> > > +     * precopy_init_size holds an estimation of the initial data size, re-query
> > > +     * precopy size to ensure it's really zero before sending init data flag.
> > > +     * Don't send the flag if query fails.
> > > +     */
> > > +    ret = vfio_query_precopy_size(migration);
> > > +    if (ret || migration->precopy_init_size) {
> > > +        return false;
> > > +    }
> > IIUC this chunk isn't necessary?  If we don't expect REINIT to happen that
> > much (when NIC reconfigures?), then we can still rely on the window where
> > the "new switchover ack" will be requested later on during the exact sync.
> > 
> > Relying on that seems slightly cleaner.
> 
> Not sure I follow.
> 
> New switchover ack is requested in exact sync if we see new init_bytes > 0
> (REINIT flag).
> This flow happens only after the new switchover ack is requested in exact
> sync, when init_bytes = 0 again.
> 
> So this chunk just makes sure we send the VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
> flag at the right time.

AFAIU, what this chunk does is, we may save one switchover-ack if REINIT
got here.  It doesn't provide much functional difference in reality.

With this code there, when it happens to see REINIT, instead of sending an
immediate VFIO_MIG_FLAG_DEV_INIT_DATA_SENT message, it falls back to send
init data in the next iteration loop, saving that flag, and saving a
"request switchover-ack" on src QEMU too.

If above code removed, IIUC VFIO will send VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
immediately causing dest sends ACK.  vfio_query_precopy_size() will be
postponed until the next sync query (which must happen at some point before
final switchover), then it will be collected there, VFIO src will request
for switchover-ack, then another VFIO_MIG_FLAG_DEV_INIT_DATA_SENT is
expected.

Both should work, but what I meant is, I think we don't need this random
check, because it's optimistic, it's not functionally necessary, IIUC.

IOW, see the current code and how it can still race with a REINIT anyway:

             migration thread                                  some vfio driver thread

    ret = vfio_query_precopy_size(migration);
    if (ret || migration->precopy_init_size) {
        return false;
    }
                                                                   got reconfigured,
                                                                   set REINIT

    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
    migration->initial_data_sent = true;
    trace_vfio_send_init_data_flag(vbasedev->name);

It's the same to me if e.g. we try to vfio_query_precopy_size() in VFIO's
iterative loops from time to time, it'll also work, it'll make sync more
frequent, but it's not needed.

Thanks,

-- 
Peter Xu



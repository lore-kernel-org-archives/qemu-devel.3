Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FF0D3F08E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 16:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl8In-0004z1-AT; Wed, 28 Jan 2026 11:21:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vl8Im-0004yD-Ah
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 11:21:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vl8Ik-0006u7-22
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 11:21:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769617310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cxs69YF4yswZ3kY2QAwJX6vhLJq2jXKF8qKWPL2mWAY=;
 b=SAonfGhU+Zdj+Deo2TIltSHmAz+ubTUJCv1FB3VmcCFQ9H+YYZpSX2xTz8eKkdrX94NPME
 wFMWKpc4cXAM1U+HFfgUzOwr5zJShDHKhLmRsqORFgUfDyioLWWK+KphV59ytq1jQvE4N4
 EJiK7Vp4xyPda1bog8v90WJZhz4c0Is=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-Ar5znS0qMQijlGURAS_CWg-1; Wed, 28 Jan 2026 11:21:48 -0500
X-MC-Unique: Ar5znS0qMQijlGURAS_CWg-1
X-Mimecast-MFC-AGG-ID: Ar5znS0qMQijlGURAS_CWg_1769617308
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5014ca48a56so316289121cf.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 08:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769617308; x=1770222108; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cxs69YF4yswZ3kY2QAwJX6vhLJq2jXKF8qKWPL2mWAY=;
 b=gfyKXHgFy7Gg/1V/MPKrSL4+AJN8K1jdYQUbNVKchblMogXmygTdUSmfBq1Bv+5sxs
 EK9fVbhLGP8eXKlH61XnaU1m6lJS9RAB//Nl61W95hNs3/CCvHItquEek7zG5hDN1LpL
 YIEBBlajO9SgHDrDi4Q6Ka8t00PayNCmYctGqfuc7SxJJfc/g15YDFOG3eAOILRCKqUe
 5ErpJn4D01p8FPhxnMy6L23iIaCOzjEmFZufDs3pgTt8XFDcAEZyvWXSW+cy/20w/Pvc
 L6POs7DUJDhCPJbdSMZOaka5/327J7/HO5iJrrNc9rmJM6ES4ym8dQQp0HvyzkGbmJMS
 Nmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769617308; x=1770222108;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cxs69YF4yswZ3kY2QAwJX6vhLJq2jXKF8qKWPL2mWAY=;
 b=QsO85aKk7t0xoXUKC7FFvjyWCvgYX3pA6ecxrcdJautlUY3SLtn7GmgZhGMurb5PGf
 uqTrB1FEFA047xggsUBdSCbaH4pldGdB958K+Q4uA5gxWxVjltn7dCpkl/d5yHovg2mM
 x5h6j4kDHVtjbHoRwjifYL2RpFO7T38/z1QPwmS5jB3x1NW1uWsX6riaKzXtWyB4xLJV
 wGhej1X+p0KsmloCBJlT9tKp+g6rwHFcDB1veBovgprLm+tXjPl4gBOgTk7ThsacSIte
 SGLvVlX3PDhrb8NJOiClozSc2mhUw+3Xhl1LBLjSU9nMR72ZiHk/Sp/hK1TK2TPS7SF6
 TTdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHYYbgobdSXSf9xcAG65qaB7886iHPLmL46DfvXZWn0CpqKJMwyNxSQyVJvqTRj86M6QsQLcQ2vnM5@nongnu.org
X-Gm-Message-State: AOJu0YwOkdeU7O2J7YMTHJi3Qhj593gdWAEXjphaiSYpZT5kD6jQgI3h
 eeq9ZtTvFxq3ii+oLypw3Teo+PDpzexjF58F76lYWaf2Nfs0lFvL4tIV2jyEQUczh+FSCndqRAy
 w70SRv8rREN4htPwu1W9n1KV1CpkYz89ryQtayGZh+dCsKLKPxgsayyPp
X-Gm-Gg: AZuq6aL1ZGI6ayVY1KCHLoJVAW9AzbAowxst7A0PFM0PCfKmo0Exflly5huB+ILoqia
 IP5MnCtrtckcythZKBRHRhJpi39lrBw7dTSdJpryJ9QpiI14ouOPh9xubGCXDVOWyULpCPsNIbG
 46KUQrk8Tlj324bhcblkT4Z1o3h/QK/+/Jeox3FEM9yTs6swzcemriF1QJxasmOV5gxnDE+PULG
 OmMba85Gs3uP0B7gGKiT4B8BiAx1B+aooult2CHGeWsMbUPC+CAq34ZYHzTCXG85Qem4+8AziGS
 +juGMGPpIcRIXsZGyxdHNw7CcxTSWQNXyWKyG5EpO1UQEVP3vxZ811ZyQXjELOM59FKMBQyUxod
 MGx4=
X-Received: by 2002:a05:622a:1451:b0:4f1:ac12:b01b with SMTP id
 d75a77b69052e-5032f8f1766mr78104341cf.38.1769617307949; 
 Wed, 28 Jan 2026 08:21:47 -0800 (PST)
X-Received: by 2002:a05:622a:1451:b0:4f1:ac12:b01b with SMTP id
 d75a77b69052e-5032f8f1766mr78103791cf.38.1769617307281; 
 Wed, 28 Jan 2026 08:21:47 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740d73sm19848516d6.27.2026.01.28.08.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 08:21:46 -0800 (PST)
Date: Wed, 28 Jan 2026 11:21:45 -0500
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] vfio/migration: Send migration event before device state
 transition
Message-ID: <aXo3mcseNxP9bJ15@x1.local>
References: <20260128105159.10282-1-avihaih@nvidia.com>
 <36062a37-0af5-49fc-ac06-212096fb2c30@redhat.com>
 <aXoiAsGCWRv1nwW-@x1.local>
 <cb677add-ef2b-4ec6-9ba5-13aa2a50ec90@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb677add-ef2b-4ec6-9ba5-13aa2a50ec90@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Jan 28, 2026 at 05:32:26PM +0200, Avihai Horon wrote:
> 
> On 1/28/2026 4:49 PM, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, Jan 28, 2026 at 12:03:46PM +0100, Cédric Le Goater wrote:
> > > +Peter, + Fabiano
> > Thanks, looks benign to me from migration POV. I have one question though,
> > and not sure if I'm the only one wondering..
> > 
> > > On 1/28/26 11:51, Avihai Horon wrote:
> > > > Currently, VFIO device migration event is sent after the device state
> > > > transition has been completed. However, it may be useful to additionally
> > > > send a "prepare" event before the state transition, to notify users that
> > > > it's about to happen.
> > > > 
> > > > For example, in some cases with heavy resource utilization, stopping the
> > > > VFIO device may take a long time. In time-sensitive scenarios, the
> > > > management application that consumes the event may be notified about the
> > > > state transition too late.
> > Could there be more elaborations on the problem?
> 
> Of course.
> 
> >    For example:
> > 
> > (1) What would the mgmt do when receiving the notification?  What would go
> >      wrong if the state notification will be very late?
> 
> In our case, upon receiving an event that the VFIO device is stopped (during
> migration switchover), the mgmt app prevents timeout of RDMA connections to
> the migrated VFIO device.
> This is needed because RDMA connections may have very low timeout, even a
> few tens of ms, which is far below the migration downtime we have.

Makes sense, thanks.

Could you be explicit on the "mgmt app"?  Is it libvirt, or something else?

When introducing a new API like this events, IMHO it would always be good
to explicitly state the consumers.

> 
> As I wrote in the commit message, if the VFIO device has a lot of resources
> it may take long time (even a few hundreds of ms) to stop it and in that
> case, by the time the event is sent (after the state transition), the RDMA
> connection can already timeout.
> This is an issue we actually experienced.
> 
> > 
> > (2) Why would a prepare message help this situation?
> 
> Sending the event before the state transition will allow the mgmt app to act
> on time, regardless of how long the VFIO state transition takes.

It might also be good to state explicitly on what is the planned work to be
done as "act on time".  Per my read until now it seems to be some mechanism
that some "mgmt app" would do to mask the RDMA timeout mechanism to avoid
RDMA retries and finally connection got torn down, but maybe I'm wrong.

> 
> > 
> > (3) Doc below says, the prepare message does not imply the event will be
> >      guaranteed to happen.  Would it confuse the mgmt?
> 
> The expectation is for the mgmt app to be robust and handle these kind of
> scenarios.

I wonder if there can be deterministic way of solving this problem rather
than allowing false positive reports. E.g. attaching one explicit message
to a 100% determined state transition that requires the rdma timeout
mechanism to be turned off.

It just seems still a bit weird to need a prepare event for every state
transition, even for e.g. RUNNING and RESUME - when talking about a
possible masking of rdma timeouts, it should really be the existing event
that matters for those (after device got fully recovered, should the mgmt
app re-enable timeout mechanisms).

I do not know VFIO state machine well, also not familiar with this specific
problem.  So please treat them as pure questions. Anyway, it'll be always
nice to attach some more information into the commit log IMHO.

Thanks,

> 
> Hope that clarifies the use case/need.
> 
> Thanks.
> 
> > 
> > Thanks,
> > 
> > > > To overcome this issue, send an additional "prepare" migration event
> > > > before the device state transition.
> > > > 
> > > > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > > > ---
> > > >    qapi/vfio.json      | 33 +++++++++++++++++++++++++++++++++
> > > >    hw/vfio/migration.c | 18 +++++++++++++-----
> > > >    2 files changed, 46 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/qapi/vfio.json b/qapi/vfio.json
> > > > index a1a9c5b673..de41211f1d 100644
> > > > --- a/qapi/vfio.json
> > > > +++ b/qapi/vfio.json
> > > > @@ -66,3 +66,36 @@
> > > >          'qom-path': 'str',
> > > >          'device-state': 'QapiVfioMigrationState'
> > > >      } }
> > > > +
> > > > +##
> > > > +# @VFIO_MIGRATION_PREPARE:
> > > > +#
> > > > +# This event is emitted when a VFIO device migration state is about to
> > > > +# be changed.  Note that even if this event is received for state X,
> > > > +# the VFIO device may transition to a different state if the original
> > > > +# state transition to X failed.
> > > > +#
> > > > +# @device-id: The device's id, if it has one.
> > > > +#
> > > > +# @qom-path: The device's QOM path.
> > > > +#
> > > > +# @device-state: The new device migration state that is about to be
> > > > +#     changed.
> > > > +#
> > > > +# Since: 11.0
> > > > +#
> > > > +# .. qmp-example::
> > > > +#
> > > > +#     <- { "timestamp": { "seconds": 1713771323, "microseconds": 212268 },
> > > > +#          "event": "VFIO_MIGRATION_PREPARE",
> > > > +#          "data": {
> > > > +#              "device-id": "vfio_dev1",
> > > > +#              "qom-path": "/machine/peripheral/vfio_dev1",
> > > > +#              "device-state": "stop" } }
> > > > +##
> > > > +{ 'event': 'VFIO_MIGRATION_PREPARE',
> > > > +  'data': {
> > > > +      'device-id': 'str',
> > > > +      'qom-path': 'str',
> > > > +      'device-state': 'QapiVfioMigrationState'
> > > > +  } }
> > > > diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > > > index b4695030c7..9f887c148f 100644
> > > > --- a/hw/vfio/migration.c
> > > > +++ b/hw/vfio/migration.c
> > > > @@ -90,9 +90,11 @@ mig_state_to_qapi_state(enum vfio_device_mig_state state)
> > > >        }
> > > >    }
> > > > -static void vfio_migration_send_event(VFIODevice *vbasedev)
> > > > +static void vfio_migration_send_event(VFIODevice *vbasedev,
> > > > +                                      enum vfio_device_mig_state state,
> > > > +                                      bool prep)
> > > >    {
> > > > -    VFIOMigration *migration = vbasedev->migration;
> > > > +    QapiVfioMigrationState qapi_state;
> > > >        DeviceState *dev = vbasedev->dev;
> > > >        g_autofree char *qom_path = NULL;
> > > >        Object *obj;
> > > > @@ -105,9 +107,13 @@ static void vfio_migration_send_event(VFIODevice *vbasedev)
> > > >        obj = vbasedev->ops->vfio_get_object(vbasedev);
> > > >        g_assert(obj);
> > > >        qom_path = object_get_canonical_path(obj);
> > > > +    qapi_state = mig_state_to_qapi_state(state);
> > > > -    qapi_event_send_vfio_migration(
> > > > -        dev->id, qom_path, mig_state_to_qapi_state(migration->device_state));
> > > > +    if (prep) {
> > > > +        qapi_event_send_vfio_migration_prepare(dev->id, qom_path, qapi_state);
> > > > +    } else {
> > > > +        qapi_event_send_vfio_migration(dev->id, qom_path, qapi_state);
> > > > +    }
> > > >    }
> > > >    static void vfio_migration_set_device_state(VFIODevice *vbasedev,
> > > > @@ -119,7 +125,7 @@ static void vfio_migration_set_device_state(VFIODevice *vbasedev,
> > > >                                              mig_state_to_str(state));
> > > >        migration->device_state = state;
> > > > -    vfio_migration_send_event(vbasedev);
> > > > +    vfio_migration_send_event(vbasedev, state, false);
> > > >    }
> > > >    int vfio_migration_set_state(VFIODevice *vbasedev,
> > > > @@ -146,6 +152,8 @@ int vfio_migration_set_state(VFIODevice *vbasedev,
> > > >            return 0;
> > > >        }
> > > > +    vfio_migration_send_event(vbasedev, new_state, true);
> > > > +
> > > >        feature->argsz = sizeof(buf);
> > > >        feature->flags =
> > > >            VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE;
> > --
> > Peter Xu
> > 
> 

-- 
Peter Xu



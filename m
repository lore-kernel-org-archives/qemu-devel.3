Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8496DD3F076
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 14:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl6rr-0003ta-QI; Wed, 28 Jan 2026 09:50:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vl6rd-0003pw-HE
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 09:49:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vl6rZ-0007lk-NW
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 09:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769611783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mWpRQAlO8+1q12e9pJeorM0HD41KWcf0AN3KAxUHQyU=;
 b=dxf2QgA32X1ZELaoMJAZiv869AMGeX1wdZ8rnMAba/N4xtGtwr2BgMXFdSZF1b6xEqeb7U
 ri1dokwUcBC8R9qT/lincMXjM22g6nHgidnhaG9pfwedyOztlL4GhHCJiXWuKozRX7++V1
 HSjpwLAXdrC/3ZsUSJWVSiGccW1up8o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-FZTyEkHbMeG8CA6YtvKS1A-1; Wed, 28 Jan 2026 09:49:42 -0500
X-MC-Unique: FZTyEkHbMeG8CA6YtvKS1A-1
X-Mimecast-MFC-AGG-ID: FZTyEkHbMeG8CA6YtvKS1A_1769611781
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-894a861fd7cso142869876d6.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 06:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769611781; x=1770216581; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mWpRQAlO8+1q12e9pJeorM0HD41KWcf0AN3KAxUHQyU=;
 b=BFbXXIrNXWdGlfR7DMq5mHGUXo7Jx57eQ/fNYsEIRzWnfxFJcTPehchE9nqopIAvbZ
 5VaDuVB3FVSJjpMYwCXk65cb+cvFTJr1pzWloEF7Fq1k6f62Qkf8ko3KoGJbhW3KEMu7
 mTGqDajwss2KSnJe7B0t5t++dYoqEZ2nr1jE/6DTOa7Uel/u5mSh4R8xDXGw8fnPkiqp
 QO1BMfMNipk01WweOhy+ZoJ6qeIcP0mbQ/+SP9D2YSvOyF0qbv7THL4y3RkUouzwcVaF
 BWod5jv3w7VPMmK/ikF2Wdwxpj/7RTyJTpjO8mgPMiwCAQhMOsPqcjsyL2A608IMrT5M
 ltXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769611781; x=1770216581;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mWpRQAlO8+1q12e9pJeorM0HD41KWcf0AN3KAxUHQyU=;
 b=UCjRDrC/VU3I0QtRN19JHKPSvFJzs+0SPGo8wFDulnMLiErKRLhpl+vXHZNqtF8vNf
 drKsHxaA9ndWypuA0bFG9RuVF04taLQ8h1ZuNBPKrPPw0ILMOcqsi+oxur7+2meX1KHY
 g8ZDKwN5hni0/wPqlNBs/npZB55yglw70y6vfzJOx2CF85L4nAhh7+eM0j/S6WOsUKLZ
 IO3DcjOffT5s1UGtPQQcwufcW+cVoKkrGwLaifTz2QPYfv0XLYC0cZKPn+e/VXUqv5xM
 hdqX++ZzdAUFPD5TbFtMWH4aI3H31kiBQ3zcMdpjrix+hO+ZxtnQNil+MJK95+sRKWUV
 VQPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGcW50OBcPJEaKLqQypS7yYaIbExH4f5doAUf01s78TTCP8lfIZwpojegvcoDVfi1LffeoLLWNZJ1Z@nongnu.org
X-Gm-Message-State: AOJu0Yz3xmz6H8k+ZZeatm8XzcFC+XH90roTI3zYXqdeVl2vqdP4/ZL9
 mAXEfS+Ck2XOvBTkT1nE2SR4ySXD/tQzrBZ+nwaLbk32WRU8Vt8hGcxWhZ3+1peApPtcMwtBFaU
 stEzHCsb23ygDpESLXvXgU/er1ILGfpvc0nmsLpcrZQpKxBqIJeX+2bniHURC78VS
X-Gm-Gg: AZuq6aKIO18Y2dY2DpoIXWpQ6St7VPBC/jqo0mQbZLZmaiv4Wpw/BKSDSKRY8CJl5A/
 dGjK3j7zQ76wYZ2HMTu69UJmkN0uLfZ/EJO7N3aQSSA/5h50auCLEpOpmHlEJGSpz1tmxd6FB6z
 smZ8eo83sWn3Xg1qCts7xNIIyz2PEs/p6gT1K+Q8xkM0m5fJrRjb0XVgpPSn3MNAMQ9UhPiJi2+
 8fali7ZgMdzwuAqVh0CxRGYGFQiDZYPQ0Q+VzoZfS7nB/7ahI3XCM2hiD8Bu5nOPgN51p0rSECG
 tCmExU35Pns40piNUiHHKN+4+K4I6Ws7WvvJtyicFOaBw41QQPgsXjX8R2k3/Lyn8+DcB5Wc9O2
 jPjQ=
X-Received: by 2002:a05:6214:765:b0:894:67b2:316 with SMTP id
 6a1803df08f44-894cc937da9mr78075546d6.55.1769611781032; 
 Wed, 28 Jan 2026 06:49:41 -0800 (PST)
X-Received: by 2002:a05:6214:765:b0:894:67b2:316 with SMTP id
 6a1803df08f44-894cc937da9mr78075046d6.55.1769611780483; 
 Wed, 28 Jan 2026 06:49:40 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d376da66sm18285696d6.50.2026.01.28.06.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 06:49:40 -0800 (PST)
Date: Wed, 28 Jan 2026 09:49:38 -0500
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex@shazbot.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] vfio/migration: Send migration event before device state
 transition
Message-ID: <aXoiAsGCWRv1nwW-@x1.local>
References: <20260128105159.10282-1-avihaih@nvidia.com>
 <36062a37-0af5-49fc-ac06-212096fb2c30@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36062a37-0af5-49fc-ac06-212096fb2c30@redhat.com>
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

On Wed, Jan 28, 2026 at 12:03:46PM +0100, Cédric Le Goater wrote:
> +Peter, + Fabiano

Thanks, looks benign to me from migration POV. I have one question though,
and not sure if I'm the only one wondering..

> 
> On 1/28/26 11:51, Avihai Horon wrote:
> > Currently, VFIO device migration event is sent after the device state
> > transition has been completed. However, it may be useful to additionally
> > send a "prepare" event before the state transition, to notify users that
> > it's about to happen.
> > 
> > For example, in some cases with heavy resource utilization, stopping the
> > VFIO device may take a long time. In time-sensitive scenarios, the
> > management application that consumes the event may be notified about the
> > state transition too late.

Could there be more elaborations on the problem?  For example:

(1) What would the mgmt do when receiving the notification?  What would go
    wrong if the state notification will be very late?

(2) Why would a prepare message help this situation?

(3) Doc below says, the prepare message does not imply the event will be
    guaranteed to happen.  Would it confuse the mgmt?

Thanks,

> > 
> > To overcome this issue, send an additional "prepare" migration event
> > before the device state transition.
> > 
> > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > ---
> >   qapi/vfio.json      | 33 +++++++++++++++++++++++++++++++++
> >   hw/vfio/migration.c | 18 +++++++++++++-----
> >   2 files changed, 46 insertions(+), 5 deletions(-)
> > 
> > diff --git a/qapi/vfio.json b/qapi/vfio.json
> > index a1a9c5b673..de41211f1d 100644
> > --- a/qapi/vfio.json
> > +++ b/qapi/vfio.json
> > @@ -66,3 +66,36 @@
> >         'qom-path': 'str',
> >         'device-state': 'QapiVfioMigrationState'
> >     } }
> > +
> > +##
> > +# @VFIO_MIGRATION_PREPARE:
> > +#
> > +# This event is emitted when a VFIO device migration state is about to
> > +# be changed.  Note that even if this event is received for state X,
> > +# the VFIO device may transition to a different state if the original
> > +# state transition to X failed.
> > +#
> > +# @device-id: The device's id, if it has one.
> > +#
> > +# @qom-path: The device's QOM path.
> > +#
> > +# @device-state: The new device migration state that is about to be
> > +#     changed.
> > +#
> > +# Since: 11.0
> > +#
> > +# .. qmp-example::
> > +#
> > +#     <- { "timestamp": { "seconds": 1713771323, "microseconds": 212268 },
> > +#          "event": "VFIO_MIGRATION_PREPARE",
> > +#          "data": {
> > +#              "device-id": "vfio_dev1",
> > +#              "qom-path": "/machine/peripheral/vfio_dev1",
> > +#              "device-state": "stop" } }
> > +##
> > +{ 'event': 'VFIO_MIGRATION_PREPARE',
> > +  'data': {
> > +      'device-id': 'str',
> > +      'qom-path': 'str',
> > +      'device-state': 'QapiVfioMigrationState'
> > +  } }
> > diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > index b4695030c7..9f887c148f 100644
> > --- a/hw/vfio/migration.c
> > +++ b/hw/vfio/migration.c
> > @@ -90,9 +90,11 @@ mig_state_to_qapi_state(enum vfio_device_mig_state state)
> >       }
> >   }
> > -static void vfio_migration_send_event(VFIODevice *vbasedev)
> > +static void vfio_migration_send_event(VFIODevice *vbasedev,
> > +                                      enum vfio_device_mig_state state,
> > +                                      bool prep)
> >   {
> > -    VFIOMigration *migration = vbasedev->migration;
> > +    QapiVfioMigrationState qapi_state;
> >       DeviceState *dev = vbasedev->dev;
> >       g_autofree char *qom_path = NULL;
> >       Object *obj;
> > @@ -105,9 +107,13 @@ static void vfio_migration_send_event(VFIODevice *vbasedev)
> >       obj = vbasedev->ops->vfio_get_object(vbasedev);
> >       g_assert(obj);
> >       qom_path = object_get_canonical_path(obj);
> > +    qapi_state = mig_state_to_qapi_state(state);
> > -    qapi_event_send_vfio_migration(
> > -        dev->id, qom_path, mig_state_to_qapi_state(migration->device_state));
> > +    if (prep) {
> > +        qapi_event_send_vfio_migration_prepare(dev->id, qom_path, qapi_state);
> > +    } else {
> > +        qapi_event_send_vfio_migration(dev->id, qom_path, qapi_state);
> > +    }
> >   }
> >   static void vfio_migration_set_device_state(VFIODevice *vbasedev,
> > @@ -119,7 +125,7 @@ static void vfio_migration_set_device_state(VFIODevice *vbasedev,
> >                                             mig_state_to_str(state));
> >       migration->device_state = state;
> > -    vfio_migration_send_event(vbasedev);
> > +    vfio_migration_send_event(vbasedev, state, false);
> >   }
> >   int vfio_migration_set_state(VFIODevice *vbasedev,
> > @@ -146,6 +152,8 @@ int vfio_migration_set_state(VFIODevice *vbasedev,
> >           return 0;
> >       }
> > +    vfio_migration_send_event(vbasedev, new_state, true);
> > +
> >       feature->argsz = sizeof(buf);
> >       feature->flags =
> >           VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE;
> 

-- 
Peter Xu



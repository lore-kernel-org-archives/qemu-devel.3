Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2829BE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 22:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJgYu-0004Ad-MV; Fri, 06 Dec 2024 17:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJgYt-0004AI-5M
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:12:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJgYq-0004Sl-Sl
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733523151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zy4ZNAJLy8CZ03L7o96BcQGFSV2z5bddIXQxfhcMlYw=;
 b=aXAnXy0wlE66qzfN8W0i847aB7uq2p0DS4polbmqxeOwY5Yr45NrZcZ6PJO6QkeCZM61hz
 TzsRwdSPCIQanJEIHlsenMlVz3u8AkaGcGj4qD3VypZ37OJdfzcKXZq550MbMsd9ubIGIp
 ynC3DkcDK+N3VJisDWes3sxGLHZW7Ig=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-DJOMxmy4NEWIMf1L24-tsA-1; Fri, 06 Dec 2024 17:12:29 -0500
X-MC-Unique: DJOMxmy4NEWIMf1L24-tsA-1
X-Mimecast-MFC-AGG-ID: DJOMxmy4NEWIMf1L24-tsA
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3a78421a2e1so38772815ab.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 14:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733523148; x=1734127948;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zy4ZNAJLy8CZ03L7o96BcQGFSV2z5bddIXQxfhcMlYw=;
 b=VGi8t/J5220Cu8/0+jfVjeTDtQ/Hk4Jyc2RiJFkM+pLpO5bCWbhWPgTefpdJmwZBq9
 zMHAxECqwqro6jlDI+mVglMTCOZISCd1gMOjmfKjIp1Ny8NN7e6yHpYBu0EHD+UTbVvK
 1TanGEwS5BbHDGdWVIyMMzANSAWs+dNpkdg0nwGvxaNDqVn3MctPSl7gaUak9men3gk/
 /cckY3aaJoToZfbliwLExMMakxWDLifjnTxnTEE5AcC9YCyxCFb+yF3bIaUy6hLj2JBl
 0pHi3oVEJ2ywh4+kVs02HT3PpzFJgPfRXWCLvnN04FVVrtSMpUYNyyxcW5buhxtJ+91/
 GVVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXk+ukVYM/Ns0FNprb/EqC7advRIuOsXfmvopcc5PacKmB7/clyxHwdTG+9T6wxpgRAJpezZhrdpBS@nongnu.org
X-Gm-Message-State: AOJu0YzS8tXzaTCedKPI+oUWnTfd9+ChVYSa0F+gP7Qzv2+u8Dk2QXZ6
 DWhaV79vG1dj9eXo0aIhTdcgCqYO+ap35I1fVeBcWVHLkKlBj/csbar/JEAZz6eFRS2wOob9HRr
 uB0o3rTsAhNTXENkhc+t+4ooDzVGb8vDsnmDOpn00j4Hbt0poFWo52bBDvIra
X-Gm-Gg: ASbGncvoYKuvMmFFsAXr3a8AGrSxVTB4PdqBFpVWxk7go3ILW7Z6G4wV0fAeq4bLQOD
 NZvB9Dwgu1Gx3dUW45tBAQ9OkHAkx7vXrrMPCPQfNnjoh2VMJITg4PE2AHT8kCQXCw95lNcjZmM
 tGSerN9hV5hxMum81EHPBO9ZuYFeF7+jCG+M7VnW6RGhtkv7RezBdwe+cVAWWK1kT9o3ZSu3IY3
 dL0eFRqMULlJXyT9wUdhnnyOjRVYhC1DkU8z1cc1fBbAFG82pf64h9GaZ6KNzu9TM0SxFKeO3c1
 3Fn7HtNjH8c=
X-Received: by 2002:a05:6e02:1e06:b0:3a6:ad61:7ff8 with SMTP id
 e9e14a558f8ab-3a811db761cmr64103845ab.12.1733523148659; 
 Fri, 06 Dec 2024 14:12:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4qp3SZx13IZBt5b+SOCnr6ZHRED4plFSoSlvRln00YY/HXmV5Dr3ZmXQHuHqg16w0nWrmOQ==
X-Received: by 2002:a05:6e02:1e06:b0:3a6:ad61:7ff8 with SMTP id
 e9e14a558f8ab-3a811db761cmr64103625ab.12.1733523148360; 
 Fri, 06 Dec 2024 14:12:28 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e286108486sm1022994173.25.2024.12.06.14.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 14:12:27 -0800 (PST)
Date: Fri, 6 Dec 2024 17:12:25 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Zhang Chen <zhangckid@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 05/24] migration: Add MIG_CMD_SWITCHOVER_START and its
 load handler
Message-ID: <Z1N2yc18MNFcz2uN@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <624309a8e37f7779336bd5c0573d24f155b2ed41.1731773021.git.maciej.szmigiero@oracle.com>
 <Z1DJroYiKUwK-kMY@x1n>
 <CAK3tnvLsfe2FJ-zVkJRCk1xKDJ0ULP8DFaDMOFgDFCF4d+0j2g@mail.gmail.com>
 <3c40ff15-0b7d-40bc-a11e-c1cb2efd7785@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c40ff15-0b7d-40bc-a11e-c1cb2efd7785@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Fri, Dec 06, 2024 at 07:24:58PM +0100, Maciej S. Szmigiero wrote:
> On 5.12.2024 20:46, Zhang Chen wrote:
> > On Thu, Dec 5, 2024 at 5:30 AM Peter Xu <peterx@redhat.com> wrote:
> > > 
> > > On Sun, Nov 17, 2024 at 08:20:00PM +0100, Maciej S. Szmigiero wrote:
> > > > diff --git a/migration/colo.c b/migration/colo.c
> > > > index 9590f281d0f1..a75c2c41b464 100644
> > > > --- a/migration/colo.c
> > > > +++ b/migration/colo.c
> > > > @@ -452,6 +452,9 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
> > > >           bql_unlock();
> > > >           goto out;
> > > >       }
> > > > +
> > > > +    qemu_savevm_maybe_send_switchover_start(s->to_dst_file);
> > > > +
> > > >       /* Note: device state is saved into buffer */
> > > >       ret = qemu_save_device_state(fb);
> > > 
> > > Looks all good, except I'm not sure whether we should touch colo.  IIUC it
> > > should be safer to remove it.
> > > 
> > 
> > Agree with Peter's comments.
> > If I understand correctly, the current COLO doesn't support multifd migration.
> 
> This patch adds a generic migration bit stream command, which could be used
> for other purposes than multifd device state migration too.
> 
> It just so happens we make use of it for VFIO driver multifd device state
> migration currently since we need a way to achieve the same functionality
> as save_live_complete_precopy_{begin,end} handlers did in the previous
> versions of this patch set.
> 
> Since adding this bit stream command to COLO does not cost anything
> (it's already behind a compatibility migration property) and it may be
> useful in the future I would advise to keep it there.
> 
> On the other hand, if we don't add it to COLO now but it turns out it
> will be needed there to implement some functionality in the future then
> we'll need to add yet another compatibility migration property for that.

There's one thing still slightly off for COLO, where IIUC COLO runs that in
a loop to synchronize device states (colo_do_checkpoint_transaction()) to
the other side, so that's not exactly where the "switchover" (in COLO's
wording, I think it's called "failover") happens for COLO..  Hence the name
qemu_savevm_maybe_send_switchover_start() may be slightly misleading in
COLO's case..

But that's not a huge deal.  At least I checked and I agree the code should
work for COLO too, and I think COLO should need something like machine type
to work properly across upgrades, in that case I think COLO is safe.  So
I'm OK with keeping this, as long as Chen doesn't object.

-- 
Peter Xu



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421C3CA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 16:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwO9M-00062j-BS; Wed, 10 Sep 2025 12:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwO98-0005zL-Bd
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 12:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwO92-0002zD-NC
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 12:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757523486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iOhRCgAyRJXEMcLeQWG0deiOP5qmzjyOQ1uX4+YCtEo=;
 b=RZllqM3qWalZnUXMfrs/s725loF3zyh3quBLTv0fGIofzYgh6TlBMiH9RK0BrRyBZY6FpF
 CqEoZgg8DLIgweI2DVoWvXll8p/pxWEcTX0ekz52PJUH3ihTpSIGpOqcAGcKJeYL81FqMp
 Fy3iwSyrxyI43vNRQ1dQXr5FVuFLtVU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-0lcZUGkaOSyfm1NeV433RA-1; Wed, 10 Sep 2025 12:58:04 -0400
X-MC-Unique: 0lcZUGkaOSyfm1NeV433RA-1
X-Mimecast-MFC-AGG-ID: 0lcZUGkaOSyfm1NeV433RA_1757523484
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-7248ed9f932so88176376d6.3
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 09:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757523484; x=1758128284;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iOhRCgAyRJXEMcLeQWG0deiOP5qmzjyOQ1uX4+YCtEo=;
 b=OjTpBbhyf1l2roJBpuZY8M0gXiEprjsQPXRaYiOcngtpdbH7gTGj1N6tZJSpqo7Bmv
 H64Aoybn50+UJStgm7BHHqOZ0t4470vRw/rawy+3U4uYxKfC1k3bjti0vofkpNG+kfOV
 PufPlvj59vVvMp65bfL86YDcUIokYpXhAprcUusCRt8NycoTQfRAML5+X1qr+v1xr0lh
 RhmdCJPCSTYZSRNEg75g7tHoU1kY11oMgGmi19dACjirTO+5kTYi9+twvpLan5Jhp93s
 9/8ESzKRumqKV8o+eYZ/wEktcu5EOG0Vq4kBigRbxkbdhTZfIR72+0D0EQ9AMZZSHycb
 vVIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWmgsD1IZAeyHZQw8VNcPtQAaZffZT2BJ8gW4gSKZTkC24OKAG5CiuWCY4vzT7EpZ2yNR0huP7yjqs@nongnu.org
X-Gm-Message-State: AOJu0YxI6pPBUULNqGFcfYzBDvLX/Jn3bn+aaBCVIZOwSDNSlRK2olVT
 xXyvje8DXYLQQEnJ/MLxAtJ7w1KveZBA2GGK84af6P4Pw+/HJJlEUN9YUevWc2qgnldT/mr7e8S
 zgJMDG5W80N+cNdgTgK9By4eOC8qdKZ9xQFfq2TmtTAVDaqx2d5ekPIW0bDf2K4r4
X-Gm-Gg: ASbGncuhQYDNBpSE7bz9dmGYa9F6xIQjYmNK69Zr/BBeKPw+c485W7fTyFwYhxQTDV2
 S0c8LrWHwU417Q3bXYfzvptxYzBFrX9LevZDAWwgf2WtOqDxT+UTjnApcg7ZAa93s0STz9iegeL
 v9qBFlRKFSpnFWk0GKVvWILJvFSTvaQlkzNFfpD2EdG/woTDTAUPVnepc3IpOnZiGD6TsVsqNut
 G22Tz4/fTTZJrHyRTC47FRyj5TvpiSJ55jN0tk6j2vBbg/2nG33WEpa9SZk0t6KnZvTE/5H8VCD
 CqJAT646usY5WklUlj3U9tjv+HV/g1B62pYmJBcndkFViTpWoiRt89tisbxhs3tlIokqTvUSMe9
 pRaMDg1ZoVTsRuXqDEUS/xg==
X-Received: by 2002:a05:6214:1c83:b0:70d:fd01:992d with SMTP id
 6a1803df08f44-739256c25b4mr164636336d6.16.1757523483795; 
 Wed, 10 Sep 2025 09:58:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK6HqpGtVbM0zvqVDvnmYUTTA2b55SBs61E2OBK/3jHfjpZ6CDt0Ulv7Kd799DGXWLuXEKqw==
X-Received: by 2002:a05:6214:1c83:b0:70d:fd01:992d with SMTP id
 6a1803df08f44-739256c25b4mr164635996d6.16.1757523483183; 
 Wed, 10 Sep 2025 09:58:03 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7252d6ad05asm140097766d6.62.2025.09.10.09.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 09:58:02 -0700 (PDT)
Date: Wed, 10 Sep 2025 12:58:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Steven Sistare <steven.sistare@oracle.com>,
 "Chaney, Ben" <bchaney@akamai.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hamza Khan <hamza.khan@nutanix.com>, qemu-devel@nongnu.org
Subject: Re: [RFC V2 0/8] Live update: tap and vhost
Message-ID: <aMGuGDnjsfo8wBU-@x1.local>
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
 <ef7fd47a-f7c0-4bca-823c-07005c5f1959@yandex-team.ru>
 <f3cb36ee-e677-4377-9e4d-652085b205aa@oracle.com>
 <3c939b30-2479-4bdd-8fa8-1dcd7adaada5@oracle.com>
 <2e6a35a4-b9b6-444c-90d7-1c748ad1b7d0@yandex-team.ru>
 <ccd353ef-26c7-4590-94ae-d8f6193c2805@oracle.com>
 <c8b799f7-c549-4534-a156-99df204e62ec@yandex-team.ru>
 <aLsM-_Bfj2bYtwSX@x1.local>
 <e93c1318-7530-4d02-95e1-bf60a6142e75@yandex-team.ru>
 <b742f0e7-3ee6-4824-9713-b45ba390df1e@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b742f0e7-3ee6-4824-9713-b45ba390df1e@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Sep 10, 2025 at 12:35:10AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > I wished devices could opt-in to provide its own model so that it is
> > > prepared to boot the QEMU without FDs being there and pause itself at that
> > > stage if a load would happen.
> > 
> > So, you suggest to postpone the initialization up to "start" even for "normal start"
> > of QEMU, to avoid these endless "if (we are in our special local-incoming/CPR mode)".
> > 
> > Actually, that's how normal migratable devices live: we don't have "if (incoming)" for
> > every step of initialization/start currently.
> > 
> > I'll see, could I apply the concept to TAP local migration series.
> 
> 
> Hmm, not so simple.
> 
> OK, my current series behave like this:
> 
> init:  if tap.local_incoming then do nothing else open(/dev/net/tun)
> 
> incoming migration: get fd, and continue initialization
> 
> 
> Assume, we want to avoid extra "if"s, and just postpone the initialization to vm start point, like
> 
> init: do nothing. set fd=-1
> 
> incmoing migration: get fd (if cap-fd-passing enabled)
> 
> start: open(), if fd==-1, continue initialization
> 
> 
> But that mean that we postpone possible errors up to start as well, when we cannot rollback the
> migration..

Yep, doesn't sound like a good idea.  We also don't want to slow down VM
starts.

> 
> 
> Alternatively, we can postpone open() to post-load.. But what for normal start of vm?
> 
> init: if INMIGRATE then do nothing, else open()
> 
> incoming: get fd (if cap-fd-passing)
> 
> post-load: open(), if fd==-1, continue initialization
> 
> start: if fd is still -1, open(), continue initialization
> 
> that avoids extra tap.local_incoming option, but:
> 
> - seems even more complicated
> - open() and some initialization is done in downtime, when we don't enable cap-fd-passing
> 
> 
> So, now I think, that my current approach with additional "local-incoming" per-device option is better.
> 
> What do you think?
> 
> 
> Probably I'm trying to optimize wrong "if". As "if local-incomging .." in generic layer is a lot
> more expensive than checking the options in device code.
> 
> But the idea is generic: for non-fd migration, we do as much initialization at start as possible,

AFAIU, the non-fd migrations works simply because the portion that VMSD
loads will always be over-writeable.  When it's not, a pre_load() or
post_load() would make it work.

> to get early errors and to decrease further downtime. For fd migration, we postpone fd-initialization
> up to post-load stage. So, we have "if"s in device code to handle it, and we have "if"s in generic
> code to support device, which doesn't still have fully initialized backend (no fds during init).

What I meant is, IMHO we should try to not use things like
cpr_is_incoming() too deep into the device stack, and we should use it as
less frequent as possible.

In many cases, IIUC it's because the current device emulation code is not
yet separating the FD installation (and also whatever that can be relevant
to the FD) from the realize() process.  Hence a quick way to make it work
is to add cpr_is_incoming() or similar helpers either to skip some process,
or do something different with an existing FD.

If we can have device emulation be prepared with such, in an ideal world
and just to show what I am thinking.. it could be:

  - realize()
    - realize_frontend()
    - if migration is incoming, and backend should be postponed (for fd
      loading, or maybe something else)?
      - ... realize_backend() postponed until post_load()...
    - else
      - realize_backend()

If all of the devices would support such split of realize() process
v.s. FDs / backends, _maybe_ we can remove all cpr_is_incoming() but move
it upper and upper until qdev code, like:

device_set_realized():
        if (migration_incoming_XXX() && dc->realize_prepare) {
            /*
             * This is only part of realize(), rest done in a separate VMSD
             * post_load().
             */
            dc->realize_prepare(dev, &local_err);
            if (local_err != NULL) {
                goto fail;
            }
        } else if (dc->realize) {
            dc->realize(dev, &local_err);
            if (local_err != NULL) {
                goto fail;
            }
        }

In general, that "whether is incoming fd migration" concept will be passed
down from higher the stack, rather than randomly checked very deep in
stack.  That should IMHO make code more maintenable.

But that's only my two cents.. so please take that with a grain of salt.  I
don't really know device code well to say.

Thanks,

-- 
Peter Xu



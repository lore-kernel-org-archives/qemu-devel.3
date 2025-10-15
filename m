Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833B6CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 20:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v97mm-00015t-8p; Wed, 15 Oct 2025 16:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v97mk-00015S-Ct
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 16:07:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v97mX-0007jB-60
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 16:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760558847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/MJELsQ22RnW6XOLvxUcHE7sj9ogF9LS304LWrTcdPU=;
 b=M6oB5sQeuyc16gjawNPHZJMNcBxZHsQsHzl3vc5/pm3Fa0E3MG8TPpmhTx6LeETuzWaW7U
 0KoxVjEzynVyiI/d3OTBnOy0V52UdRj+ht2B2rQCChSGt3Lgt/bktn4iSpYBZK81M0PQUy
 KcctaqmBYQn/J7BDeWkOsLrqW1mxhs0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-227p7E3GN_yKWDKdMCUEfg-1; Wed, 15 Oct 2025 16:07:26 -0400
X-MC-Unique: 227p7E3GN_yKWDKdMCUEfg-1
X-Mimecast-MFC-AGG-ID: 227p7E3GN_yKWDKdMCUEfg_1760558845
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-88e7bfe5ba7so351866485a.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 13:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760558845; x=1761163645;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MJELsQ22RnW6XOLvxUcHE7sj9ogF9LS304LWrTcdPU=;
 b=YMZiEHnFoBbP2XJXY6wZXiWK4ERR4KDCd4YlN3LH5U2p2rhs4GOtFBydRGf9enaJQ6
 8vKJibPLbS/O90vDwj4lee92oKhLPrEUQn3whz+oQfvYlz8wwVUNJIrFWZEfeln5tI/l
 THG5UECdQkkbk3DJ84Skal8zypSBsqJW+O8ARkAMWpRoZOyJXa04UDPLp0CMrHRQZx6q
 6xsz1wIOrGZZU8Sece+btqTV5E/4yvEzhcpAno8H2Q/l86YNce5RfGjpLZ2WGEdneeBM
 ye0A0wXjOm5d2HaaDsKPVQusnzn0qFxHSN6fn4fwb8ZWNByZez2xMPAzG7eFvku+Mhet
 6VUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCLMpgx80nTbySn1w643S1gTKTSfRSuJhNDQFLCgI935U7AD8mjfbjGQtq9wdXxuU1aoN5+SHIzN0K@nongnu.org
X-Gm-Message-State: AOJu0Yw8jUZAYCeTF2O+YBQTMcZgTgFZ0ytDh/lMPGMvMZ2LSdgG6laH
 dY8iRtWOSRL8PMwDB5vWGH7plqNiCtQXW35ua5dZKCzN+ln8k4bELlstNuzWlfl/2BCIUswsJxP
 ezsnyc0kbA1W32ja+MoR0DqtVgOsiPHB4TY4WTUQJlbpRGLL6/9108lWb
X-Gm-Gg: ASbGncvkQDscEBeBYn4GWxeHeDtpXAmMoaq4XpOqO2qjB5lk6/SBbUMbbAcKK6GOsMi
 QtvS0AP6SAuZ3KgQ9AT8QuogZtxtuMpXFA4SEQvLHZon/zHkXj/9taM5EYSwcxbpFT8R9TA+Vnk
 yYPAFXwI8gkg2DON+ycL7H/OdRzbVSrfiNqSpv/BHZjIPoNmg5azwsmorTUbI9PugjTw/xZdldm
 AeGQN4sdrlAPD2iHdm3opBUStop+kZ8VZAmj02C1sZ6OuY/rV0+sXIRekpmKh+GQ6d6r3vrM/v7
 ODzMIAhSfttLRAslIEw0Fo0NnvmYWzOV0jcG33p/97u3MA7yixYs/X0WDU4+wXqtdx0=
X-Received: by 2002:ac8:57d3:0:b0:4e8:91bb:2636 with SMTP id
 d75a77b69052e-4e891bb2eeemr14447381cf.52.1760558845328; 
 Wed, 15 Oct 2025 13:07:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHi2NFMJCE7ZDWfe189sigvVArKQ4x7y5FDe9WXP91llisgJa30116qB2afl8HW7rkOrQExIw==
X-Received: by 2002:ac8:57d3:0:b0:4e8:91bb:2636 with SMTP id
 d75a77b69052e-4e891bb2eeemr14446751cf.52.1760558844702; 
 Wed, 15 Oct 2025 13:07:24 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e892c0e44bsm1731561cf.12.2025.10.15.13.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 13:07:24 -0700 (PDT)
Date: Wed, 15 Oct 2025 16:07:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, jasowang@redhat.com, farosas@suse.de, sw@weilnetz.de,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 philmd@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org,
 michael.roth@amd.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: Re: [PATCH v8 16/19] qapi: introduce backend-transfer migration
 parameter
Message-ID: <aO_--QWDJO7iOhR4@x1.local>
References: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
 <20251015132136.1083972-17-vsementsov@yandex-team.ru>
 <aO_ll4Lf0bq6vgdm@x1.local>
 <3b9f1da4-6264-45d4-ade1-a6273cc6fa1e@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3b9f1da4-6264-45d4-ade1-a6273cc6fa1e@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 15, 2025 at 10:02:14PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 15.10.25 21:19, Peter Xu wrote:
> > On Wed, Oct 15, 2025 at 04:21:32PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > This parameter enables backend-transfer feature: all devices
> > > which support it will migrate their backends (for example a TAP
> > > device, by passing open file descriptor to migration channel).
> > > 
> > > Currently no such devices, so the new parameter is a noop.
> > > 
> > > Next commit will add support for virtio-net, to migrate its
> > > TAP backend.
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > ---
> 
> [..]
> 
> > > --- a/qapi/migration.json
> > > +++ b/qapi/migration.json
> > > @@ -951,9 +951,16 @@
> > >   #     is @cpr-exec.  The first list element is the program's filename,
> > >   #     the remainder its arguments.  (Since 10.2)
> > >   #
> > > +# @backend-transfer: Enable backend-transfer feature for devices that
> > > +#     supports it. In general that means that backend state and its
> > > +#     file descriptors are passed to the destination in the migraton
> > > +#     channel (which must be a UNIX socket). Individual devices
> > > +#     declare the support for backend-transfer by per-device
> > > +#     backend-transfer option. (Since 10.2)
> > 
> > Thanks.
> > 
> > I still prefer the name "fd-passing" or anything more explicit than
> > "backend-transfer". Maybe the current name is fine for TAP, only because
> > TAP doesn't have its own VMSD to transfer?
> > 
> > Consider a device that would be a backend that supports VMSDs already to be
> > migrated, then if it starts to allow fd-passing, this name will stop being
> > suitable there, because it used to "transfer backend" already, now it's
> > just started to "fd-passing".
> > 
> > Meanwhile, consider another example - what if a device is not a backend at
> > all (e.g. vfio?), has its own VMSD, then want to do fd-passing?
> 
> Reasonable.
> 
> But consider also the discussion with Fabiano in v5, where he argues against fds
> (reasonable too):
> 
> https://lore.kernel.org/qemu-devel/87y0qatqoa.fsf@suse.de/
> 
> (still, they were against my "fds" name for the parameter, which is
> really too generic, fd-passing is not)
> 
> and the arguments for backend-transfer (to read similar with cpr-transfer)
> 
> https://lore.kernel.org/qemu-devel/87ms6qtlgf.fsf@suse.de/
> 
> 
> > 
> > In general, I think "fd" is really a core concept of this whole thing.
> 
> I think, we can call "backend" any external object, linked by the fd.
> 
> Still, backend/frontend terminology is so misleading, when applied to
> complex systems (for me, at least), that I don't really like "-backend"
> word here.
> 
> fd-passing is OK for me, I can resend with it, if arguments by Fabiano
> not change your mind.

Ah, I didn't notice the name has been discussed.

I think it means you can vote for your own preference now because we have
one vote for each. :) Let's also see whether Fabiano will come up with
something better than both.

You mentioned explicitly the file descriptors in the qapi doc, that's what
I would strongly request for.  The other thing is the unix socket check, it
looks all good below now with it, thanks.  No strong feelings on the names.

> 
> >  One
> > thing to complement that idea is, IMHO this patch misses one important
> > change, that migration framework should actually explicitly fail the
> > migration if this feature is enabled but it's not a unix socket protocol
> > (aka, fd-passing REQUIRES scm rights).  Would that look more reliable?
> > Otherwise IIUC it'll throw weird errors when e.g. when we enabled this
> > feature and trying to migrate via either TCP or to a file..
> > 
> 
> Right. I rely on checking in qemu_file_get_fd() / qemu_file_set_fd()
> handlers.
> 
> But of course, earlier clean failure of qmp-migrate / qmp-incoming-migate
> commands would be nice, will do.
> 
> Like this, I think:
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 6ed6a10f57..0c73332706 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -255,6 +255,14 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
>          return false;
>      }
> 
> +    if (migrate_backend_transfer() &&
> +        !(addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
> +          addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX)) {
> +        error_setg(errp, "Migration requires a UNIX domain socket as transport, "
> +                   "because backend-transfer is enabled");
> +        return false;
> +    }
> +
>      return true;
>  }
> 
> 
> 
> 
> 
> -- 
> Best regards,
> Vladimir
> 

-- 
Peter Xu



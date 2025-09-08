Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924EDCAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 18:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvguF-00004u-Jj; Mon, 08 Sep 2025 14:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uvguD-0008WN-BN
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 14:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uvgtz-0004iC-63
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 14:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757357258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=41DU/skBBkDyJb89sXmFdI6jLOCEQn65cQNKmcsj2ng=;
 b=J7SX6iEsiWKlESvi97zESltTGbCXjvP/BhnMpCmSL0cBhWdU74KslqMJs37adRVqeVf+bK
 0yh8sXkNO/GwWLBkMpL/g8INbM/oEVv+08BB0w77qtA1RaLJsrDceJIX5CjGv3EOu0GGRo
 8F1YOCm99b4sdHCNZw2Vsl+wio/kT/Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-Y6Un14TiPg-WuzeHSpJMbA-1; Mon, 08 Sep 2025 14:47:34 -0400
X-MC-Unique: Y6Un14TiPg-WuzeHSpJMbA-1
X-Mimecast-MFC-AGG-ID: Y6Un14TiPg-WuzeHSpJMbA_1757357254
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-7224cb09e84so106333586d6.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 11:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757357254; x=1757962054;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=41DU/skBBkDyJb89sXmFdI6jLOCEQn65cQNKmcsj2ng=;
 b=cwwqO0TPfnDr6JbLdEknlGEEtUwHmcmB6eFK0nyI9qZHlpu6noo/P6gq4hH8BSVF7h
 vyXwwLp+xX3P4AZ/jxjF84rmADOpELhaZz2MNAE/cSUDc3fBouxG9FBObPMMNht2Zy5K
 w1puVAgVxsIUgUu/dwAFt1nVUc8A6ZUvUYKtPPPkc8/wP642Pe67df7CGyKrBMPs+SSh
 QNWL6oZbaJo6vVE3jQ+0P0bhQP/P4idNx9wXTfYRtnYyo66uG46RrhYbCKxAVbRquZPC
 3sJhanA0tzjLYOopV4NDNcAJ5nBxhR7oQXHb6uyRJmQCY6cFBxkcalxaPpWR07r1wZoV
 AaSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZh/qHFSaFRtac6BUHIuV/3JKFXaDUNKltW6nCDVJTaWbGg4tlm8nV6KMtYo4fLnv6VYGlZJxlyro7@nongnu.org
X-Gm-Message-State: AOJu0Ywt3w/iEKs5Zb4uB584j16VZOkqg6zqog4uVyYbh7wQEMerYBxe
 zrgTbcxNkbmBs8kyWsyJ61wXXiQzlIjYrKzxYc7iBk4X/yUXClYMUfFs1hCZLe8oZMOuP7GiNLN
 c+x0aRD9r3xOwnrpUupx6dTBlVRKAwvvykjilLOI4Lt18YgPYQFaP/Xo5
X-Gm-Gg: ASbGncuBslaAtyTUTsYFSj9G/jjWyhXM0ue7FdwjQstkE7E7TxvaWpV/oCo6x4Jbzxs
 im2NWbjugYJ3fpc+3IaNX1x6+dHdZ4JV7Rdel+7xPuANxrP9R24TWlTGJngbb7Pwfu+YZhVVYlX
 cQJ//r6LUbYo2A7PF1iKqAbnYQWGzrAJqu8YCT1fVJr96wVgV2A1AbQ1u+TmT07rpWh9jK6E2ij
 gb7thBBNuH/+flbWo5Kbie42k220dRPVGvGl0Wne3AD/hXf90s2v9IXyjpdJA9tWvNXOzU/a5Il
 B4EpPw24HK5irpAmzOCTkzk6JD+un4hq
X-Received: by 2002:a05:6214:27e4:b0:718:f7d8:c01b with SMTP id
 6a1803df08f44-73a3a6738d9mr83830846d6.17.1757357253960; 
 Mon, 08 Sep 2025 11:47:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXrwiVTTHkWRgScMRX92/jEKBqRRnmDyI/LRYled6A/e7R83IX7iGOaz/1FPEtPnaIyPpMfg==
X-Received: by 2002:a05:6214:27e4:b0:718:f7d8:c01b with SMTP id
 6a1803df08f44-73a3a6738d9mr83830436d6.17.1757357253322; 
 Mon, 08 Sep 2025 11:47:33 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-720add660desm127353246d6.30.2025.09.08.11.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 11:47:32 -0700 (PDT)
Date: Mon, 8 Sep 2025 14:47:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru, mst@redhat.com,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, berrange@redhat.com
Subject: Re: [PATCH v3 4/9] qapi: add interface for local TAP migration
Message-ID: <aL8kuXQ2JF1TV3M7@x1.local>
References: <20250905135039.2202924-1-vsementsov@yandex-team.ru>
 <20250905135039.2202924-5-vsementsov@yandex-team.ru>
 <aL730XiXhM1Vj4Zg@x1.local>
 <2626fb74-a8f4-475b-ab01-3b20c6ff2ae2@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2626fb74-a8f4-475b-ab01-3b20c6ff2ae2@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Sep 08, 2025 at 07:38:45PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 08.09.25 18:35, Peter Xu wrote:
> > On Fri, Sep 05, 2025 at 04:50:34PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > index 2387c21e9c..992a5b1e2b 100644
> > > --- a/qapi/migration.json
> > > +++ b/qapi/migration.json
> > > @@ -517,6 +517,12 @@
> > >   #     each RAM page.  Requires a migration URI that supports seeking,
> > >   #     such as a file.  (since 9.0)
> > >   #
> > > +# @local-tap: Migrate TAPs locally, keeping backend alive. Open file
> > > +#     descriptors and TAP-related state are migrated. Only may be
> > > +#     used when migration channel is unix socket. For target device
> > > +#     also @local-incoming option must be specified (since 10.2)
> > > +#     (since 10.2)
> > 
> > IMHO we should move this into a per-device property, at least we need one
> > there to still control the device behavior; we had a similar discussion
> > recently on iterable virtio-net.
> > 
> > But maybe this one is slightly special?  Maybe the tap device needs to at
> > least know whether in this specific migration, if we want to pass over FD
> > or not (e.g. local upgrade, or remote _real_ migration)?
> > 
> > If that's the case, we may consider providing a generic migration
> > capability, like cap-fd-passing.  Nowadays since Fabiano's moving migration
> > capabilities all over to migration parameters, this one can start with a
> > parameter instead of a capability.  The problem with migration capability
> > is (at least) that it can't by default ON on any machine types.. meanwhile
> > it simply looks like identital to parameters except it's always bool.
> > 
> > The high level rational is that we should never add a per-device cap flag
> > into migration framework.
> > 
> 
> Hmm.
> 
> 1. Yes, we need to distinguish, is that _real_ migration or local. And setting a
> special property for each device (which supports fd-migration) to turn on passing
> FD to the channel seems not comfortable and error prune.
> 
> 2. Initially, I decided separate "local-tap" and "local-vhost-user-blk" capabilities
> just to simplify further testing/debugging in real environment: the possibility to
> enable only "half of magic" helps.
> 
> So, granularity makes sence, but having local-XXX capability for each device class
> looks bad.
> 
> Maybe, having generic cap-fd-passing, together with possibility to disable it on
> per-device basis (like migrate-fd=false) is good compromise.
> 
> 
> Another question is, do we need "local-incoming" option for target device.
> 
> Initially I added this because I thought: ho, I need to distinguish it initialization
> time: do I need to call open(), or wait for incoming fd.
> 
> Now I see that I can just postpone this decision up to "start" point, where
> 
> - either I already have fd from incoming migration
> - or have nothing: in this case, let's call open()
> 
> -
> 
> I'll try to go with one "fd-passing" capability, as any kind of granularity may be
> added later on demand.
> 
> 
> Hmm2. Probably we can avoid even adding such a capability, but just check, is migration
> channel support fd passing or not? Seems too implicit for me.

If we want to expose a feature internally, IIUC we can use QAPI "features"
like this:

https://lore.kernel.org/all/20250603013810.4772-17-farosas@suse.de/

But I'm not yet sure whether it's useful..

In this case the "capability" itself should almost always be present when
using unix sockets..  The problem is, IIUC we're not trying to describe a
capability, but a choice the user made.

For example, when unix socket is the transport, we can still decide to not
use fd passing even if it's fully supported in the current QEMU binary for
any devices that are involved, because any of: (1) it could be a unix
socket to a proxy daemon (of a container?) when fd passing isn't supported
in the daemon, or (2) as you mentioned above, for debugging purpose when we
want to triage whether a bug is relevant to fd-passing.  Maybe more.

The per-device granularity you mentioned also makes sense to me.

An use case is when, imagine, we have a QEMU that (1) supports tap local
migration, but (2) doesn't yet support virtio-blk local migration.  Then we
want to be able to enable the fd-passing for tap/virtio-net, but not for
virtio-blk (even if the src QEMU in the context might support both)?

IOW, it makes sense to me to have two layers of controls here:

  (a) Migration new parameter, "migrate-fds" (or any better name..).

      When set, it enables all devices that supports fd-passing to migrate
      the fds directly.  OTOH, when not set, even if all devices enabled
      fd-passing, it should still do a full migration.  This one is the
      user knob saying "I want to migrate with fd migrated".

      This should imply unix sockets for sure as the transport, and should
      fail upfront if it's not a unix socket.

      We should also auto-select this with cpr migrations..  then in any
      code path (whenever such path exists?) that the fds can be either
      migrated from cpr or main channels.

  (b) Device new parameter, "migrate-fds" (or any better name..).

      When set, the device will declare support migrating fds "whenever the
      migration applies", aka, when above (a) is selected first.

      Taking tap device as example here, setting it ON here means "please
      enable fd-passing whenever the user enables this migration option".
      So in tap code, it should migrate fd if both (a) and (b) are ON.
      When migrating to e.g. old QEMUs, here (b) should be OFF even if (a)
      is ON.

Would above make sense?

-- 
Peter Xu



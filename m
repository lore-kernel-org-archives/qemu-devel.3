Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79397E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 16:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLmD9-0008BX-1r; Thu, 12 Dec 2024 11:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLmD7-0008BO-EF
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 11:38:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLmD4-0002fY-Dl
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 11:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734021520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cvt0pF2PbWOxyYTnVytzT6zo0aW0MQ8Q+QdIpbmwKTk=;
 b=i541necjltDlxv1E+4xhIXI+gjrQ+WjqVV7KDo3AGQfX9PBoGvaZOmgLwFHZ5Z/B6BuNEw
 JjSIqP7TV7V2gDxtVnVUwIirgfJl5gYdbh1HXzmEql+TsCZuaEwemdaKSFxdXe6HG3SIFz
 7QjLe3Joz+LP5hW20KlGvg7XdgSgjVQ=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-puirKwVaM7GTywqcmMLBdg-1; Thu, 12 Dec 2024 11:38:20 -0500
X-MC-Unique: puirKwVaM7GTywqcmMLBdg-1
X-Mimecast-MFC-AGG-ID: puirKwVaM7GTywqcmMLBdg
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3ab68717b73so7504445ab.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 08:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734021500; x=1734626300;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cvt0pF2PbWOxyYTnVytzT6zo0aW0MQ8Q+QdIpbmwKTk=;
 b=Aa0Bb4R0C1EmPynf6OHtxuOSO+KANSgJYp14fpmCzlMRSVHgCUY88nA34xYio/vmVP
 oHRhlgF+MD8a6Z7D+NbwDWxvzSI8YGNaXNPuPsxFZmdS0b0kIkSpSV2RUkp0rT6fA5Nr
 T7pAo9O9Kk4IUk4EgsLS8NQd6Yv1ybxsQaTMjTotiv6bOVybuRAfH68rdOIk/wLtdVms
 yl0XzZGW1LNVLb4thfaZh66LID5PRxwcmHnRn1vgc961QST8Tb7JwbLSYJ/SRGefX67C
 yEnFwwo5DREp4LkKn5bdUZ0JgS1/LpGUTPeGoHl8gUQg8nz0Fm8vu50aCcMl4VJZJvxz
 MYhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcieAhG4ttFwvCueBnoAZTCWPNpQoRyPO2LPt4qWGk1SW4TcStjaBDvNlhnCJ80sBFNWoKr9yQdbcc@nongnu.org
X-Gm-Message-State: AOJu0YxT95FQYJqluim6/zgbBQGW4VfpgnPZFMAIjk8QA7PAOS1ACfAE
 D37ugBNbq2odGDVFE1M9QOmlpPBvn2Q5YTXWYjdEK34Vt6MLnR3HUfrSAJ6pASv/ZPDh+acVLUG
 56vYsei0U0ftGxsaGCSIVCw4q9KxbMpsPXKUOMqwmYyZorMZy2Gjj
X-Gm-Gg: ASbGncuR5ouJUS+4kI8GoVqp9xe0W+8R6pl/Nmio3WwA0u5/dYbckmJAZn/ShTDK8ep
 o7WZQIEdEGFh3zp2DePqc5WwNWLx+vwNnJ0jOEk8feGY5ZFfawHHkX2URUeXCyzi0JqLoouMlR4
 LGmpsAai5/KMDK16Rrxjxo5nEgT1VrqEZNW3U1jLblXxGzGqdd6dU+3JLTIHGKpGXS/XAjr3g4m
 yYXra+WGhYll3d5P3T0Oq88Hp6NPh6KdmQxHUTw1e7neuxBg2Cn7EGA9y+Ji1Asj8kB6Vpat/W/
 5738GdHpE0s/UxSAMg==
X-Received: by 2002:a05:6e02:194c:b0:3a7:e103:3c43 with SMTP id
 e9e14a558f8ab-3ae57ef9e24mr8122745ab.19.1734021500012; 
 Thu, 12 Dec 2024 08:38:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoYKSSJDia12VpvdCNoJTNz1iXOZTvSBsgVTnGSGL0Hd9BqsvLCS1zB6yfFHMUl/UgNuJaFQ==
X-Received: by 2002:a05:6e02:194c:b0:3a7:e103:3c43 with SMTP id
 e9e14a558f8ab-3ae57ef9e24mr8122555ab.19.1734021499704; 
 Thu, 12 Dec 2024 08:38:19 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2ca9c3f89sm1694619173.0.2024.12.12.08.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 08:38:19 -0800 (PST)
Date: Thu, 12 Dec 2024 11:38:16 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 08/24] migration: Add thread pool of optional load
 threads
Message-ID: <Z1sReL5wrlhvO3P5@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <877b7108c9cb9064615606d4c731cb12c549b7f9.1731773021.git.maciej.szmigiero@oracle.com>
 <9a229308-2c80-4ee2-8c49-5fec2207ad74@redhat.com>
 <489d1769-3807-4007-888c-608c1e9407fb@maciej.szmigiero.name>
 <Z1DcVH6j7pzboucr@x1n>
 <366e5477-9d3f-4c11-8042-542e9b4b7f65@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <366e5477-9d3f-4c11-8042-542e9b4b7f65@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
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

On Wed, Dec 11, 2024 at 12:05:23AM +0100, Maciej S. Szmigiero wrote:
> > Maybe move it over to migration_object_init()?  Then we keep
> > qemu_loadvm_state_setup() only invoke the load_setup()s.
> 
> AFAIK migration_object_init() is called unconditionally
> at QEMU startup even if there won't me any migration done?
> 
> Creating a load thread pool there seems wasteful if no
> incoming migration will ever take place (or will but only
> much later).

I was expecting an empty pool to not be a major resource, but if that's a
concern, yes we can do that until later.

[...]

> > > > > @@ -3007,6 +3071,19 @@ int qemu_loadvm_state(QEMUFile *f)
> > > > >            return ret;
> > > > >        }
> > > > > +    if (ret == 0) {
> > > > > +        bql_unlock(); /* Let load threads do work requiring BQL */
> > > > > +        thread_pool_wait(load_threads);
> > > > > +        bql_lock();
> > > > > +
> > > > > +        ret = load_threads_ret;
> > > > > +    }
> > > > > +    /*
> > > > > +     * Set this flag unconditionally so we'll catch further attempts to
> > > > > +     * start additional threads via an appropriate assert()
> > > > > +     */
> > > > > +    qatomic_set(&load_threads_abort, true);
> > 
> > I assume this is only for debugging purpose and not required.
> > 
> > Setting "abort all threads" to make sure "nobody will add more thread
> > tasks" is pretty awkward, IMHO.  If we really want to protect against it
> > and fail hard, it might be easier after the thread_pool_wait() we free the
> > pool directly (destroy() will see NULL so it'll skip; still need to free
> > there in case migration failed before this).  Then any enqueue will access
> > null pointer on the pool.
> 
> We don't want to destroy the thread pool in the path where the downtime
> is still counting.

Yeah this makes sense.

> 
> That's why we only do cleanup after the migration is complete.
> 
> The above setting of load_threads_abort flag also makes sure that we abort
> load threads if the migration is going to fail for other reasons (non-load
> threads related) - in other words, when the above block with thread_pool_wait()
> isn't even entered due to ret already containing an earlier error.

In that case IIUC we should cleanup the load threads in destroy(), not
here?  Especially with the comment that's even more confusing.

-- 
Peter Xu



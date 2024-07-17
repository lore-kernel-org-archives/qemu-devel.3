Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A289C3DA62
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 19:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU9tM-0004CS-W9; Wed, 17 Jul 2024 15:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sU9tD-0003vR-7U
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 15:00:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sU9t5-0007ds-QB
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 15:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721242821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WAbu6UELS1/Ok+sQOTByC2rzCuZxD9s0KMXpmPyD+MA=;
 b=X0RDO+/5Wd3XAPXdrWKPEhYfEMdZM/6TyBYeZb6sP9KlnTEqiYefLDlEkeUwGStl/R4vU+
 u4cBDM4ICoeRitgeWjmh0eMenzgzH1B+ANXrDd+XLIwrkeN031NGUWy450X6T1gypuBsbz
 obPBhpusei0IC4YfK5S3uxLqwIl+tvI=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-ouRWPxyWNHKTEmKzM_fOWA-1; Wed, 17 Jul 2024 15:00:18 -0400
X-MC-Unique: ouRWPxyWNHKTEmKzM_fOWA-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-25e6630f94fso7890fac.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 12:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721242818; x=1721847618;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WAbu6UELS1/Ok+sQOTByC2rzCuZxD9s0KMXpmPyD+MA=;
 b=PG94Mj3+gyjrUtdOkeDoGNCzsWmX/T1bpEEpO4MYreHgd7fLruIe6flPadEA2UzWkk
 aaTLAatRJIKEzlIUSxJnoAkuEbgQqxIV18jLMhYf5z9qr9+I+CvAZMALa3PaksbyMSGM
 Ov4CLVIuSPLIww5455Cj+KMTjLpiJdVVBrkFzuQNbVKHRInuU4/KGgsCQM8aiUxMd3yw
 D9Vs2CPuiaG6qVeXUXwHRUiqatH6JGyH7NNqZFEte3WBp3PTN2V8m6dY9Gta6is9UxDM
 HbiW1Xdsx5RicT9e+hwrKd9DlWTsYW4RflpxOXsuAAPavkPOs9xvz+jFxTSHFuXMVmE7
 L6zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnWvhWajBOIcRVgFO0itw9ATCTzVE0m3Zt1IBlRmnTLZOZR2UCUiUaa9qLtSnYYEuIsAy5BGuj/gJBDven7pk9Su+FCzI=
X-Gm-Message-State: AOJu0Yxy55CI3ZOa454uwUaD0mgrUF64v6RzSJrtm/Bq9Iivejsxmnhu
 /QtRXvqc24FS3Ff7IQ4tH9nbCej+sFs5K2RyE8mC81L1Z3iULjqsoWEAsFoGjrOQyEK/Kl2KjF9
 pzEod+lDlsrS8J87ipUgAg+nEbuNPMHMt2KduHx/3MXPT6IChaOBx
X-Received: by 2002:a05:6870:f295:b0:25e:14d9:da27 with SMTP id
 586e51a60fabf-260ee1409f0mr208683fac.0.1721242817800; 
 Wed, 17 Jul 2024 12:00:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8PKYOaEymgW8c3/IPlT7vSogaB5vzdi30jW5kln79POc0gcyWlgZh3llNdBHDDUqAx+p4Vw==
X-Received: by 2002:a05:6870:f295:b0:25e:14d9:da27 with SMTP id
 586e51a60fabf-260ee1409f0mr208669fac.0.1721242817414; 
 Wed, 17 Jul 2024 12:00:17 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a160c854f7sm432732485a.130.2024.07.17.12.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 12:00:17 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:00:14 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>, "Wang, Lei" <lei4.wang@intel.com>,
 qemu-devel@nongnu.org, Avihai Horon <avihaih@nvidia.com>
Subject: Re: [RFC PATCH 6/7] migration/multifd: Move payload storage out of
 the channel parameters
Message-ID: <ZpgUvsiCB4oP3RLT@x1n>
References: <20240620212111.29319-1-farosas@suse.de>
 <20240620212111.29319-7-farosas@suse.de>
 <e60bc0c7-dc49-400e-88f1-a30c32943f25@intel.com>
 <Zn15y693g0AkDbYD@x1n> <877cdtfcsi.fsf@suse.de>
 <Zo7cncqkxB89AUBe@x1n> <87y169dmu3.fsf@suse.de>
 <53d0ddf0-07f7-430e-a424-b4fcc38a16d0@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53d0ddf0-07f7-430e-a424-b4fcc38a16d0@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 16, 2024 at 10:10:25PM +0200, Maciej S. Szmigiero wrote:
> > > > > The comment I removed is slightly misleading to me too, because right now
> > > > > active_slot contains the data hasn't yet been delivered to multifd, so
> > > > > we're "putting it back to free list" not because of it's free, but because
> > > > > we know it won't get used until the multifd send thread consumes it
> > > > > (because before that the thread will be busy, and we won't use the buffer
> > > > > if so in upcoming send()s).
> > > > > 
> > > > > And then when I'm looking at this again, I think maybe it's a slight
> > > > > overkill, and maybe we can still keep the "opaque data" managed by multifd.
> > > > > One reason might be that I don't expect the "opaque data" payload keep
> > > > > growing at all: it should really be either RAM or device state as I
> > > > > commented elsewhere in a relevant thread, after all it's a thread model
> > > > > only for migration purpose to move vmstates..
> > > > 
> > > > Some amount of flexibility needs to be baked in. For instance, what
> > > > about the handshake procedure? Don't we want to use multifd threads to
> > > > put some information on the wire for that as well?
> > > 
> > > Is this an orthogonal question?
> > 
> > I don't think so. You say the payload data should be either RAM or
> > device state. I'm asking what other types of data do we want the multifd
> > channel to transmit and suggesting we need to allow room for the
> > addition of that, whatever it is. One thing that comes to mind that is
> > neither RAM or device state is some form of handshake or capabilities
> > negotiation.
> 
> The RFC version of my multifd device state transfer patch set introduced
> a new migration channel header (by Avihai) for clean and extensible
> migration channel handshaking but people didn't like so it was removed in v1.

Hmm, I'm not sure this is relevant to the context of discussion here, but I
confess I didn't notice the per-channel header thing in the previous RFC
series.  Link is here:

https://lore.kernel.org/r/636cec92eb801f13ba893de79d4872f5d8342097.1713269378.git.maciej.szmigiero@oracle.com

Maciej, if you want, you can split that out of the seriess. So far it looks
like a good thing with/without how VFIO tackles it.

Thanks,

-- 
Peter Xu



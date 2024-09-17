Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07E0CAC593
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 17:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqcLy-0003t8-A0; Tue, 17 Sep 2024 13:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqcLu-0003sb-1v
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 13:51:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqcLs-0008P1-9m
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 13:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726595458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F7/Fi6PmNfuZpYDoiVI88kcvYhhDj+dpJdMCImVSfEw=;
 b=TBq7xT+dfXFPoCn8OP6HlZ9pcoVr5IBQ/RPKgG1U0e4sdoYQUtOVH9sWMc46BOjjoqII57
 0SSYGXl8CuSnXppxf0Tna6k+mbrLZcczSXTi2UM+crVeaggEuEKWObADIihYy5tuB/Qs5t
 DfZvrDiChgFPkLm/zZtEIAvWRLLuKEU=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-Ch47Z0iONeaf0dIiOssM9w-1; Tue, 17 Sep 2024 13:50:51 -0400
X-MC-Unique: Ch47Z0iONeaf0dIiOssM9w-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-848917ba13aso1070693241.3
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 10:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726595451; x=1727200251;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F7/Fi6PmNfuZpYDoiVI88kcvYhhDj+dpJdMCImVSfEw=;
 b=hLZ5HpAuuIu9zQCjDC3NIKlJlMRnSQ34SweMk7u64FwbeMBEi6DZf17wXRvtU29rtZ
 ApqQRscsocibBIUJGi4iS5/15XafRh+nlPqj21Nf2PLkHzW29Mbmeu0/Kwx3hfA1woTf
 ZtuIoLAdGQnCHcB8Go9vw3V8NqIx0cE+/89IoTPg+ItywrtcgQ+ku53AfmwFkv4PZEAd
 ejnXhq3RYmNidb5dGz5s5G0Uo8npzhwkmZu2caKiOB+tN8nuM/TtNHLcAHEQcfLkeke0
 Uuo1iJZDhvkL10iJrXYD425XMv/ibkVLWB+hdMCXdopuNOr0rtUg6nPslw0TALo9g81f
 cICA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrX4jQ6OKI0XgVj5+zZZM7pdiTXJRuqRYtqp8ApRQiPc2uUKGqrK7KEv8Jzklq+dF3uIIJuHC8EtE8@nongnu.org
X-Gm-Message-State: AOJu0YyY9RFOrFUtL5lBo/WsedPfRCB7V5JH/xk2+rJRSAm5L3j+zX97
 CL4650gwVHA+UwuawZE5vmgUrbVZce+HVi0e3Id57o5WJ6jlZcdZ9goQtlFL9oZPM7z1Agk0Lx7
 2YloPpiZcvw4vhfNWURUjoVKI+ppj/1mOuYyQnn/LkMfusNzF1AZv
X-Received: by 2002:a05:6102:c87:b0:49b:cb56:1083 with SMTP id
 ada2fe7eead31-49d415d6fffmr14774146137.28.1726595451222; 
 Tue, 17 Sep 2024 10:50:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgChNrUCBpbzblUTMcqeS84o+kKJMjH3ZEKf0HtFnsc1JaZ+z37d+tX3gW3oI6c4uESgP1yg==
X-Received: by 2002:a05:6102:c87:b0:49b:cb56:1083 with SMTP id
 ada2fe7eead31-49d415d6fffmr14774115137.28.1726595450817; 
 Tue, 17 Sep 2024 10:50:50 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c58c691deasm36708426d6.80.2024.09.17.10.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 10:50:50 -0700 (PDT)
Date: Tue, 17 Sep 2024 13:50:48 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, mail@maciej.szmigiero.name,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 12/17] migration/multifd: Device state transfer
 support - send side
Message-ID: <ZunBeBnqpgAIpt4Z@x1n>
References: <fdcfd68dfcf3b20278a4495eb639905b2a8e8ff3.1724701542.git.maciej.szmigiero@oracle.com>
 <87h6b4nosy.fsf@suse.de> <ZuCickYhs3nf2ERC@x1n>
 <87zfoc1zms.fsf@suse.de> <ZuOGAb3988ExsrHi@x1n>
 <87o74r1yfw.fsf@suse.de> <ZuRJ8i4T_vUzrawY@x1n>
 <87ldzv1tpb.fsf@suse.de> <ZuRYouLwikc4OYye@x1n>
 <45f44392-cb56-4341-ab1d-7d7f28554c77@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45f44392-cb56-4341-ab1d-7d7f28554c77@redhat.com>
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

On Tue, Sep 17, 2024 at 07:07:10PM +0200, Cédric Le Goater wrote:
> [ ... ]
> 
> > > > I as a patch writer always like to do that when it's essential.  Normally
> > > > the case is I don't have enough reviewer resources to help me get a better
> > > > design, or discuss about it.
> > > 
> > > Right, but we can't keep providing a moving target. See the thread pool
> > > discussion for an example. It's hard to work that way. The discussion
> > > here is similar, we introduced the union, now we're moving to the
> > > struct. And you're right that the changes here are small, so let's not
> > > get caught in that.
> > 
> > What's your suggestion on the thread pool?  Should we merge the change
> > where vfio creates the threads on its own (assuming vfio maintainers are ok
> > with it)?
> > 
> > I would say no, that's what I suggested.  I'd start with reusing
> > ThreadPool, then we found issue when Stefan reported worry on abusing the
> > API.  All these discussions seem sensible to me so far.  We can't rush on
> > these until we figure things out step by step.  I don't see a way.
> > 
> > I saw Cedric suggesting to not even create a thread on recv side.  I am not
> > sure whether that's easy, but I'd agree with Cedric if possible.  I think
> > Maciej could have a point where it can block mutlifd threads, aka, IO
> > threads, which might be unwanted.
> 
> Sorry, If I am adding noise on this topic. I made this suggestion
> because I spotted some asymmetry in the proposal.
> 
> The send and recv implementation in VFIO relies on different
> interfaces with different level of complexity. The send part is
> using a set of multifd callbacks called from multifd threads,
> if I am correct. Whereas the recv part is directly implemented
> in VFIO with local thread(s?) doing their own state receive cookery.

Yeh, the send/recv sides are indeed not fully symmetrical in the case of
multifd - the recv side is more IO-driven, e.g., QEMU reacts based on what
it receives (which was encoded in the headers of the received packets).

The src is more of a generic consumer / producer model where threads can
enqueue tasks / data to different iochannels.

> 
> I was expecting a common interface to minimize assumptions on both
> ends. It doesn't have to be callback based. It could be a set of
> services a subsystem could use to transfer state in parallel.
> <side note>
>      VFIO migration is driven by numerous callbacks and it is
>      difficult to understand the context in which these are called.
>      Adding more callbacks might not be the best approach.
> </side note>
> 
> The other comment was on optimisation. If this is an optimisation
> then I would expect, first, a non-optimized version not using threads
> (on the recv side).

As commented in a previous email, I had a feeling that Maciej wanted to
avoid blocking multifd threads when applying VFIO data chunks to the kernel
driver, but Maciej please correct me.. I could be wrong.

To me I think I'm fine even if it blocks multifd threads, as it'll only
happen when with VFIO (we may want to consider n_multifd_threads to be
based on num of vfio devices then, so we still always have some idle
threads taking IOs out of the NIC buffers).

So I agree with Cedric that if we can provide a functional working version
first then we can at least go with the simpler approach first.

> 
> VFIO Migration is a "new" feature which needs some more run-in.
> That said, it is stable, MLX5 VFs devices have good support, you
> can rely on me to evaluate the future respins.
> 
> Thanks,
> 
> C.
> 

-- 
Peter Xu



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9DDD74940
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 21:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5tNw-00087h-AK; Tue, 29 Oct 2024 17:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5tNs-0007sY-QM
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 17:04:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5tNq-0006Lv-0q
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 17:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730235847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=85WxmzMhpZQeYgkaHTiY5FbNnfr3aaFNr3EqRhkRZMQ=;
 b=i1eKdhK9BkTktG1isBfT7lpItfdi8lr5XUAlWk3YX1egskLstfyGLyPTEh17HW3QVQMMRc
 G13i32e8w2w7KKJLwVnGy3RZJ1JLaOylR7feyFz1QY8QI59vzqtPHmRs8RxJS7HvPeaCQh
 Lj0aa7nc1qCz79It6fC/WztoRo7I3JE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-drLC-RX_OMy792Tieo5GXQ-1; Tue, 29 Oct 2024 17:04:06 -0400
X-MC-Unique: drLC-RX_OMy792Tieo5GXQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6cbd2cb2f78so10218056d6.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 14:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730235846; x=1730840646;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=85WxmzMhpZQeYgkaHTiY5FbNnfr3aaFNr3EqRhkRZMQ=;
 b=TWm4+LxhNgHaI1zNctwBtTo2M/X0g+nJW2eEQAwuyLERNjZBwviNXKUzVZPJ3T2RXE
 pCcCRMuA64/GUAicKL6Rj/ZVj2WRECUrpiRNFgq+OvQgZwXOa+PSKPX6Wl7VQVYKR4yh
 qSkB8LuqO+lKIEKHni1jqIg0wqkZp9eABcIU15y6gc0iJ3O/QXjdZirMNU/wGumEwcyv
 /NdDXliwW3UXBMUWg1umP/kk7HDrPFJDHlcfhMbT40rppbnlCFHKo7tvEHsw4gezVtF/
 qFtoLtRqV1r3oDIf9BE32KfiKE1mKsExAggS17sbONIVE4fvIMLyb2buE/ToYbZMbx7w
 btsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW5uTlFGUWS0GUpHytNcyt3xWldkStxxdxOZvAkNvBXXaBulDkIWPG5D/0vfNUjxpM7DQGvl+IYYYi@nongnu.org
X-Gm-Message-State: AOJu0Yw+LuRjGTBWrPOd92epWHBSfbhT0RMJxJw5j45ePitCbIDYVUOM
 +t/ToJ8gQkn/GJbudXB+1m8Wr2r28l55NvnaObZ41dlT89LD0YTEAFgx2i2rDHfCy+6WgHO+97W
 N8Pb4JXNmjKRzmEGzS/Bx9K8edUXnhxXjimm5mvTsk1zKYV8xftT/
X-Received: by 2002:a05:6214:250c:b0:6cb:440c:c44 with SMTP id
 6a1803df08f44-6d34846f9efmr3125636d6.1.1730235845826; 
 Tue, 29 Oct 2024 14:04:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7PMeHYKBajDi/zLxaIylUNr+NAK9ueo8HfWFMCAw0mupbz+SFohO6USGeeiBpoR9qgRKwsg==
X-Received: by 2002:a05:6214:250c:b0:6cb:440c:c44 with SMTP id
 6a1803df08f44-6d34846f9efmr3125396d6.1.1730235845572; 
 Tue, 29 Oct 2024 14:04:05 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46132119fd6sm48330361cf.4.2024.10.29.14.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 14:04:04 -0700 (PDT)
Date: Tue, 29 Oct 2024 17:04:02 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/4] migration: Document the BQL behavior of load
 SaveVMHandlers
Message-ID: <ZyFNwtFuBrZjRhm1@x1n>
References: <cover.1730203967.git.maciej.szmigiero@oracle.com>
 <6976f129df610c8207da4e531c8c0475ec204fa4.1730203967.git.maciej.szmigiero@oracle.com>
 <ZyFHEOVShZUp-RvO@x1n>
 <4836f787-5e39-441a-b8b1-a2238bdf228e@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4836f787-5e39-441a-b8b1-a2238bdf228e@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
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

On Tue, Oct 29, 2024 at 09:46:01PM +0100, Maciej S. Szmigiero wrote:
> On 29.10.2024 21:35, Peter Xu wrote:
> > On Tue, Oct 29, 2024 at 03:58:16PM +0100, Maciej S. Szmigiero wrote:
> > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > 
> > > Some of these SaveVMHandlers were missing the BQL behavior annotation,
> > > making people wonder what it exactly is.
> > > 
> > > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > > ---
> > >   include/migration/register.h | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/include/migration/register.h b/include/migration/register.h
> > > index f60e797894e5..c411d84876ec 100644
> > > --- a/include/migration/register.h
> > > +++ b/include/migration/register.h
> > > @@ -210,6 +210,8 @@ typedef struct SaveVMHandlers {
> > >       void (*state_pending_exact)(void *opaque, uint64_t *must_precopy,
> > >                                   uint64_t *can_postcopy);
> > > +    /* This runs inside the BQL. */
> > > +
> > >       /**
> > >        * @load_state
> > >        *
> > > @@ -227,6 +229,8 @@ typedef struct SaveVMHandlers {
> > >        */
> > >       int (*load_state)(QEMUFile *f, void *opaque, int version_id);
> > > +    /* The following handlers run inside the BQL. */
> > 
> > If above also requires BQL, why not move this line upper?
> 
> The reason for this is that my main patch set also adds
> "load_state_buffer" handler, which runs without BQL.
> 
> That handler is ordered next after "load_state" and I tried
> to avoid further comment churn here.
> 
> But if you prefer to change these comments in the patch
> introducing "load_state_buffer" handler instead then it's
> fine.

Considering the current change is so small to start benefit readers.. I
think it's ok we do this in one shot after load_state_buffer() change.

> > OTOH, I think resume_prepare() doesn't require BQL..
> 
> Yes, it seems like resume_prepare() is only called outside BQL.
> Will update the patch.

Thanks,

-- 
Peter Xu



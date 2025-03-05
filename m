Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDA8C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tprmc-000737-Ic; Wed, 05 Mar 2025 11:39:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tprmW-0006wk-8y
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:39:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tprmR-0003k4-IL
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741192774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q3EGHs48q2GwBqFDTQArnprZKvDtpiNZKYaiPP3TbMU=;
 b=PPZ2ITQNqppQlksZ3hQan5UpcDC/Qa/1h4Ps5s3br2K58mJ2DSmAoPt+5j1IqfwhP7jGWH
 zCl/hpn64IUvYe4vljRAGZMiLMVwwgedpJAy5ThahxRxInqqcvyfHWzlqAAsMmGOkKGg/s
 iJeiGmZbcf/Xejj+OoLlnUljC1gVikg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-tgy0zbqCNYukxeHtA0wClw-1; Wed, 05 Mar 2025 11:39:27 -0500
X-MC-Unique: tgy0zbqCNYukxeHtA0wClw-1
X-Mimecast-MFC-AGG-ID: tgy0zbqCNYukxeHtA0wClw_1741192767
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6e890855f09so160393196d6.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 08:39:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741192767; x=1741797567;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q3EGHs48q2GwBqFDTQArnprZKvDtpiNZKYaiPP3TbMU=;
 b=H1M+sNaDW5PEFfmeqeLFVMN3CYq1/UdKNzw37hFE86aPpyaBHJOZ0QP/V+6egl8+sf
 NEiOd+LzfRBRB8EVXlqf/1szEdrcX0WqjZD0HLW6ZiQWSxk36BlIozPqgT3wwp6s9UV+
 yq4qXXsem6Cinr23f9ebudlS0toWurUH1n5XKCK4bVPXG4UWYCmPy1RvtbcszPPYTVqR
 +hyg96ENSYoGvp7NiuYp7nic8x7Turv6j7r3oarwSV/zDaZsKm3XK+rkWZ8Gvvi/8s6G
 jV7MMzvb+xrB3g1alZAO0b42wXksUbGfGqF4VS+s1p7TiHO7eyeCJEt1skxr9/k8FjZC
 M9sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj2ZIAfXWq8IH/K24m0zoPTwhfuuxjqnQ6DjJPa9lUdATPq0v+lF99nPz9aUB4a1Yvu+0hH/yCc3i/@nongnu.org
X-Gm-Message-State: AOJu0Yx7cH5n0l4wpxIaTJ4hDyU6YmjvLQBlnKZHN4hbdBfVqSQvs9vv
 2F1neX6+TBqfi9usv/hXQm5IISOwXw98c8EIrtPln3Tiw27leR2Najq/+9LnzLaDDNqlDQt5Zji
 TpZR2krFboK7Q2hH9sHjeFbBBQjQmoz+04FoyQJFOjNEGLIBeEBja
X-Gm-Gg: ASbGncsUIBhfZ+vOBnkDy6pWiAmoJgFCi2vLeQ8iqv8MB5avAGtzW7SUGh6JAwSsD/Y
 /QA77pBORmdCOF1NgpKbhq3USdJ/3b4+8GXEUWOzR93rse3M+1MxYG7RbmhxaS6R4a1TXUh4Cx5
 ZTnKHWwDoMFapBsP5W7PAwvt4CdQnBjfadBIZCQLXyyzYjK/v5Y3pZMKiy9kgO6tdoC/8Xp6+dO
 oNbRNvwnGr+QDOIjr1B4ywDEf/7YNuRurlLr2tiOnPlE4btaQuj9+R1X6IDBL6t0O0YKkZXKuHQ
 bRVGZag=
X-Received: by 2002:a05:6214:c28:b0:6e8:8934:337e with SMTP id
 6a1803df08f44-6e8e6daab83mr52877876d6.38.1741192766961; 
 Wed, 05 Mar 2025 08:39:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmLV9KUmyphKI/H/2SbftI5jrPrztu4/lHlfQOM48Wa9C0zNM4aEGEvVOtFoLXbdhauj85pA==
X-Received: by 2002:a05:6214:c28:b0:6e8:8934:337e with SMTP id
 6a1803df08f44-6e8e6daab83mr52877626d6.38.1741192766631; 
 Wed, 05 Mar 2025 08:39:26 -0800 (PST)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8976da230sm80758806d6.112.2025.03.05.08.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 08:39:25 -0800 (PST)
Date: Wed, 5 Mar 2025 11:39:23 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 25/36] vfio/migration: Setup and cleanup multifd
 transfer in these general methods
Message-ID: <Z8h-Oy2eT6dJZ-WM@x1.local>
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <b1f864a65fafd4fdab1f89230df52e46ae41f2ac.1741124640.git.maciej.szmigiero@oracle.com>
 <Z8h6LGGrw82RgA_Y@x1.local>
 <068929b1-6a07-4dc0-a807-77152d6d7160@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <068929b1-6a07-4dc0-a807-77152d6d7160@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Mar 05, 2025 at 05:27:19PM +0100, Maciej S. Szmigiero wrote:
> On 5.03.2025 17:22, Peter Xu wrote:
> > On Tue, Mar 04, 2025 at 11:03:52PM +0100, Maciej S. Szmigiero wrote:
> > > @@ -509,6 +513,9 @@ static void vfio_save_cleanup(void *opaque)
> > >       Error *local_err = NULL;
> > >       int ret;
> > > +    /* Currently a NOP, done for symmetry with load_cleanup() */
> > > +    vfio_multifd_cleanup(vbasedev);
> > 
> > So I just notice this when looking at the cleanup path.  It can be super
> > confusing to cleanup the load threads in save()..  IIUC we should drop it.
> > 
> 
> It's a NOP since in the save operation migration->multifd is going to be
> NULL so that "g_clear_pointer(&migration->multifd, vfio_multifd_free)"
> inside it won't do anything.
> 
> Cedric suggested calling it anyway since vfio_save_setup() calls
> vfio_multifd_setup() so to be consistent we should call
> vfio_multifd_cleanup() on cleanup too.
> 
> I think calling it makes sense since otherwise that vfio_multifd_setup()
> calls looks unbalanced.

IMHO we should split vfio_multifd_setup() into two functions:

  - vfio_multifd_supported(): covering the first half of the fn, detect
    whether it's supported all over and return the result.

  - vfio_load_setup_multifd(): covering almost only vfio_multifd_new().

Then:

  - the 1st function should be used in both save_setup() and
    load_setup(). Meanwhile vfio_load_setup_multifd() should only be
    invoked in load_setup().

  - we rename vfio_multifd_cleanup() to vfio_multifd_load_cleanup(),
    because that's really only about load..

  - vfio_multifd_setup() (or after it renamed..) can drop the redundant
    alloc_multifd parameter.

-- 
Peter Xu



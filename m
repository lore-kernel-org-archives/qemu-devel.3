Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918D9C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 16:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEXE0-00040M-90; Tue, 04 Jun 2024 12:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEXDt-0003vN-Ms
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 12:41:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEXDr-0001o6-U0
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 12:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717519278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFCVtgZs5hohGVSNCDoe+tPbMCNm1GKM+f2almhm8I8=;
 b=KWtZOASHNpY8x0JCN/OFGhzXtnTWJDgoQ8ANCN2S1uCPALUIlyOEcdzh7RJDPcD4oBFOMu
 VA+6GYG0DN39L21pY9erhwO4sCAGBrLnWcei4slrWQau14zhLIBb0tVkOs2lQzUh5f1nqz
 XDJxC4I6xaH0WzG1jdgRmiuBDZ1GOJ4=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-tHheh9RhOIK7Gj77kcXFrQ-1; Tue, 04 Jun 2024 12:41:17 -0400
X-MC-Unique: tHheh9RhOIK7Gj77kcXFrQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3d1fd81dab0so269998b6e.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 09:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717519276; x=1718124076;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zFCVtgZs5hohGVSNCDoe+tPbMCNm1GKM+f2almhm8I8=;
 b=mIogXhQgg/53F8K6qamNU3z2PPIHwjwbby/A15aEyzzCumOO25xo4rLU+5xSHWdn+x
 g4raiOd0TR47oxPDDDIpSUwEMMhvj3klcyP0o391xRe95v2RENEGy9j0qeCJE4WLvq2H
 uat+EXW8X16kuM302pUwxMZTaTdzdAW5IzDoEaW+hTtMHU0SPEgjfGOiw+AJcodhr7+/
 BDBAzuw/Sxaokuyzc1sCY7aUpUJfxmnWlERc5GOXNhjA9waptbBkagmENH9Tnox4rv3B
 kvTX4rZko+SJx4ogolw03DIN2mzHuQlA29+NdHrp+GZdhLW6QNIoncm2GIeTs0BcvXCh
 ja8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2Nad2dUuCkJFzpOncO5o8iuWC7oahtmKDTu2AxWcFU2Z19OYoYmOoVRdG6rAS8q1wS4QB4E00p4j4N23cjxDQOnafj+g=
X-Gm-Message-State: AOJu0YwmpWtWKmlrJ2iZncCHmy7qSLn81L5dhOm2cF1omDQ4o4apNLUK
 HnokF5a4pgQ6YoBuP5yH4jPPzc9+zfg4LCF5tmElPPo5ywseYM7VkRdxb9+dp2JWQLz+QUfRl91
 /eIaDRi30OmUPxTihwyVKSFtg79+7JO2kzmC1zGpqNq4N09fchibM
X-Received: by 2002:a05:6808:1688:b0:3c8:4e7f:47bd with SMTP id
 5614622812f47-3d1fbf33e4fmr2552446b6e.5.1717519276129; 
 Tue, 04 Jun 2024 09:41:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERarWmWaxY2z9MFQyZpFJqYG+Su1TyLaeaDNzgy5uQ0PkL/xqVIJAwtN6mhz2B7J8zNbVaEA==
X-Received: by 2002:a05:6808:1688:b0:3c8:4e7f:47bd with SMTP id
 5614622812f47-3d1fbf33e4fmr2552417b6e.5.1717519275575; 
 Tue, 04 Jun 2024 09:41:15 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6afbcf61646sm20673676d6.27.2024.06.04.09.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 09:41:15 -0700 (PDT)
Date: Tue, 4 Jun 2024 12:41:12 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 17/26] machine: memfd-alloc option
Message-ID: <Zl9DqCLvOgUDqGKW@x1n>
References: <ZlZIoiH5Dj4XBbLO@x1n>
 <79a8023d-2e19-4d80-821d-a03818a5372e@oracle.com>
 <Zld-iWfa3_yEWgn6@x1n>
 <ea8eb67e-583d-41cd-a545-ab18c032a99b@oracle.com>
 <ZljCHgwJhGcFiP1J@x1n>
 <e6d5f123-37ad-4d77-8536-f7f85213073d@oracle.com>
 <Zl46MIO30mGrtsQk@x1n> <Zl6-f245q-M7A62J@redhat.com>
 <Zl85o3w6ncv63zG5@x1n>
 <1b06eb8d-f6be-4e2b-929b-2f65edf16237@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b06eb8d-f6be-4e2b-929b-2f65edf16237@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jun 04, 2024 at 06:14:08PM +0200, David Hildenbrand wrote:
> On 04.06.24 17:58, Peter Xu wrote:
> > On Tue, Jun 04, 2024 at 08:13:26AM +0100, Daniel P. Berrangé wrote:
> > > On Mon, Jun 03, 2024 at 05:48:32PM -0400, Peter Xu wrote:
> > > > That property, irrelevant of what it is called (and I doubt whether Dan's
> > > > suggestion on "shared-ram" is good, e.g. mmap(MAP_SHARED) doesn't have user
> > > > visible fd but it's shared-ram for sure..), is yet another way to specify
> > > > guest mem types.
> > > > 
> > > > What if the user specified this property but specified something else in
> > > > the -object parameters?  E.g. -machine share-ram=on -object
> > > > memory-backend-ram,share=off.  What should we do?
> > > 
> > > The machine property would only apply to memory regions that are
> > > *NOT* being created via -object. The memory-backend objects would
> > > always honour their own share settnig.
> > 
> > In that case we may want to rename that to share-ram-by-default=on.
> > Otherwise it's not clear which one would take effect from an user POV, even
> > if we can define it like that in the code.
> > 
> > Even with share-ram-by-default=on, it can be still confusing in some form
> > or another. Consider this cmdline:
> > 
> >    -machine q35,share-ram-by-default=on -object memory-backend-ram,id=mem1
> > 
> > Then is mem1 shared or not?  From reading the cmdline, if share ram by
> > default it should be ON if we don't specify it, but it's actually off?
> > It's because -object has its own default values.
> 
> We do have something similar with "merge" and "dump" properties. See
> machine_mem_merge() / machine_dump_guest_core().
> 
> These correspond to the "mem-merge" and "dump-guest-core" machine
> properties.

These look fine so far, as long as -object cmdline doesn't allow to specify
the same thing again.

> 
> But ...
> 
> > 
> > IMHO fundamentally it's just controversial to have two ways to configure
> > guest memory.  If '-object' is the preferred and complete way to configure
> > it, I prefer sticking with it if possible and see what is missing.
> 
> ... I agree with that. With vhost-user we also require a reasonable
> configuration (using proper fd-based shared memory) for it to work.
> 
> > 
> > I think I raised that as the other major reason too, that I think it's so
> > far only about the vram that is out of the picture here.  We don't and
> > shouldn't have complicated RW RAMs floating around that we want this
> > property to cover.
> 
> Agreed. And maybe we can still keep migration of any MAP_PRIVATE thing
> working by migrating that memory? CPR will be "slightly less fast".
> 
> But the biggest piece -- guest RAM -- will be migrated via the fd directly.

I think it should work but only without VFIO.  When with VFIO there must
have no private pages at all or migrating is racy with concurrent DMAs
(yes, AFAICT CPR can run migration with DMA running..).

CPR has a pretty tricky way of using VFIO pgtables in that it requires the
PFNs to not change before/after migration.  Feel free to have a look at
VFIO_DMA_MAP_FLAG_VADDR in vfio.h then you may get a feeling of it.

Thanks,

-- 
Peter Xu



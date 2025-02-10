Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3653C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thUYq-0008I7-Di; Mon, 10 Feb 2025 09:14:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thUYo-0008D4-NX
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:14:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thUYl-0005HL-As
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739196884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2PMBRrivkjfUaWhRN1bT2/4VqOxJ9LmWyNMlDVwIqek=;
 b=CGe+f8Ec+CldYB3iBvD/LSbFg2T0bzegN4WQu0//XiXc3/3QygDP+ffSYPJ8CpmDwrhNRc
 6EKZSiHHyNe3BCJTAaQaIanOIE8n/gnPWqcYGFuy5DRvb84U9qFUSpBT4kvYyQb+xfXvy2
 yiP4D/SHrlqQGka57UaEAFc/QhiA1IM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-5mvi388YMKykDD23EgytDg-1; Mon, 10 Feb 2025 09:14:43 -0500
X-MC-Unique: 5mvi388YMKykDD23EgytDg-1
X-Mimecast-MFC-AGG-ID: 5mvi388YMKykDD23EgytDg
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6e44c1049c5so64471246d6.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 06:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739196882; x=1739801682;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2PMBRrivkjfUaWhRN1bT2/4VqOxJ9LmWyNMlDVwIqek=;
 b=sGoZU4rXCYe41xvDYVUgDA1XPW9POYMRX9Q7dJPQI/N47tCgsKdXMJSAHbbYQrp9uZ
 mYMhJKtGn982t+fXZ9HvZP29HC0radVtMq6b7whdO8J3k+F3n9fp+8z/niu4zeHP6UFr
 ieU8Ki5Rqn67Y2UjOJ/AsmBiYuHjgz/VnWM3kFHwpZ6GEvri6bf7JK244kMLV87qENaV
 +CPLnkR6HppoEOGYE4on+CZLkI/AqmjASDcT8Yno3jkhzjmbuivgm8/WVxGbmhKylu6m
 DRHwveLjeJGi3ChrU1o7gYfx0+Kb91Ez8GBp1nVnzDoX7zt7ZGW1cpcsQx4bKHJUpy+k
 oZ/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDjvVvpX+UzqPUDLS49fR2+V91+IYphncsGL+f0eI7MpqQJpnVpxSrrnlQdpzFpxzic4j65cQ/dLi8@nongnu.org
X-Gm-Message-State: AOJu0Yx6Mar+X8YC6q55NE1148xnbTkCp/qf+r0Que9PF57B6YESHJc3
 cFf+6Uk5rLz8OsZpChEfOSozE12Um0g2x/u6axOye9wIiWYJ165nP9wtx22O9hTdvd6i/SvyDG6
 mQPi8jpbmbANHn7H0HeZrAC/U8H08pUdxBeWN6gKt8wFmRU6nILeW
X-Gm-Gg: ASbGnct8zQU7rqkiqOff991hB0Gc8971PBfmIowcSx3V1gjIrBeV4gu/j9ufptlyvNh
 icxNVZ6jTzISFBb6BOdGpbBXuq8qoLpXwrSie5Q4L9wbRKXdPfi8NdhozdN7BtgyxnXl3BrZZbI
 va11MaP9b64v6joGG1CnvmEeDLVs16sYWJ1RCFaRjjUOA9fhZ8ZaY/NPeT6ayf+rLpuZTsKkF40
 gYOHJ2vXUTn9m1hQQkxf8r3qMKdhjL8ZLYIR2YSqS/7t1NfAK5DhWwK2Xg=
X-Received: by 2002:a05:6214:da6:b0:6e1:a51d:e96f with SMTP id
 6a1803df08f44-6e4455d8764mr191864946d6.8.1739196882650; 
 Mon, 10 Feb 2025 06:14:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF578KG49ExKzhFLwuhXfl7qQYrUiKFFVyFKYUOq1QjxhMUvAO9hnz9WFgLrLMEbKekPVWQUw==
X-Received: by 2002:a05:6214:da6:b0:6e1:a51d:e96f with SMTP id
 6a1803df08f44-6e4455d8764mr191864556d6.8.1739196882208; 
 Mon, 10 Feb 2025 06:14:42 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e44da75f46sm32473116d6.58.2025.02.10.06.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 06:14:40 -0800 (PST)
Date: Mon, 10 Feb 2025 09:14:37 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 imammedo@redhat.com, alex.williamson@redhat.com, clg@redhat.com,
 philmd@linaro.org, zhenzhong.duan@intel.com, ddutile@redhat.com
Subject: Re: [PATCH 4/5] hw/arm/smmuv3: Move reset to exit phase
Message-ID: <Z6oJzRCt_fJLfkmQ@x1.local>
References: <20250206142307.921070-1-eric.auger@redhat.com>
 <20250206142307.921070-5-eric.auger@redhat.com>
 <CAFEAcA_LgrBRbafVQ0vLGPd8xG=wsLjWnKTJ2JSEREYUqgRQBQ@mail.gmail.com>
 <7102d470-ac72-4c02-b8bc-20f1379a4843@redhat.com>
 <CAFEAcA-XK5GwT0b_Ff-8fYnWcDgzaE-0Ei-YqDoXv-aXFGNXUQ@mail.gmail.com>
 <Z6ZHTStx_S9ALdxt@x1.local>
 <CAFEAcA8ovoGsQ9oEco88iw3iUy_3kBOUaYHL+oq5VF-i9xg4+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8ovoGsQ9oEco88iw3iUy_3kBOUaYHL+oq5VF-i9xg4+A@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Feb 07, 2025 at 06:18:50PM +0000, Peter Maydell wrote:
> On Fri, 7 Feb 2025 at 17:48, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Feb 07, 2025 at 04:58:39PM +0000, Peter Maydell wrote:
> > > (I wonder if we ought to suggest quiescing outstanding
> > > DMA in the enter phase? But it's probably easier to fix
> > > the iommus like this series does than try to get every
> > > dma-capable pci device to do something different.)
> >
> > I wonder if we should provide some generic helper to register vIOMMU reset
> > callbacks, so that we'll be sure any vIOMMU model impl that will register
> > at exit() phase only, and do nothing during the initial two phases.  Then
> > we can put some rich comment on that helper on why.
> >
> > Looks like it means the qemu reset model in the future can be a combination
> > of device tree (which resets depth-first) and the three phases model.  We
> > will start to use different approach to solve different problems.
> 
> The tree of QOM devices (i.e. the one based on the qbus buses
> and rooted at the sysbus) resets depth-first, but it does so in
> three phases: first we traverse everything doing 'enter'; then
> we traverse everything doing 'hold'; then we traverse everything
> doing 'exit'. There *used* to be an awkward mix of some things
> being three-phase and some not, but we have now got rid of all
> of those so a system reset does a single three-phase reset run
> which resets everything.

Right.  Sorry I wasn't very clear before indeed on what I wanted to
express.

My understanding is the 3 phases reset, even if existed, was not designed
to order things like vIOMMU and devices that is already described by system
topology.  That's, IMHO, exactly what QOM topology wanted to achieve right
now on ordering device resets and the whole depth-first reset method would
make sense with it.

So from that specific POV, it's a mixture use of both methods on ordering
of devices to reset now (rather than the order of reset process within a
same device, provided into 3 phases).  It may not be very intuitive when
someone reads about the two reset mechanisms, as one would naturally take
vIOMMU as a root object of any other PCIe devices under root complex, and
thinking the order should be guaranteed by QOM on reset already.  In
reality it's not.  So that's the part I wonder if we want to document.

So we must make sure both:

  - All vIOMMUs across all archs must only tear down its mapping at its
    exit() phase, providing the mapping available for all devices during
    the initial 2 phases (probably we could even assert the initial 2 phase
    functions to be NULL when there's a base class).  Meanwhile,

  - All PCIe devices must quiesce their DMA in the initial 2 phases,
    guaranteeing that there's no on-the-fly DMAs possible in the complete
    3rd exit() phase, because any vIOMMU implementation can start to tear
    down its device mappings even as the first entry in 3rd phase (IOW,
    there's also no order constraint for 3rd phase that vIOMMU exit() will
    be invoked before devices' exit()).

I'm not sure if it would be important to document this, but only thought
about it if we want crystal clearance on the choice of this design.

Thanks,

-- 
Peter Xu



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778ABE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 19:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLpEO-0005G9-H9; Thu, 12 Dec 2024 14:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1tLpEM-0005Fl-PS
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:52:14 -0500
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1tLpEK-0003wg-SG
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:52:14 -0500
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b6eb531e13so50187685a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 11:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1734033131; x=1734637931; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eJV3UCNwEAe2Dr+yRJd54EBGWomKGB6Lx2nk3vQKPSg=;
 b=RrYy9oQ0t8Kmy6mBC2WZFRjT9vI37oWU9DIsv9GvCfXiLWH8hMPiE7iJ9HDVEOT81q
 TK/OgQbOvNXy/T6KBRLw1v1FpyO09HpGB/6lXp1UZwTO28JnXdfEjVhkUrBMtuicNnqn
 hXr2tSBTtBMu01BEvZgSO6WsUwuVcuW12k8BQkf7AfeLfbWAq3HgYcsMk3Ty8TS99WpF
 3B5fLcMI7ZlPKUAyx68U6O04BBWWesuKheJKS5WqBFZzA+irB7Wf+lYjtkywgImH9GYE
 qlIRpQHgwAYx+2fczc4RkHFq1QIf58+u6knTTUcx9DA4BN6lja9nRgEsAzdZ5fgUKETD
 wwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734033131; x=1734637931;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eJV3UCNwEAe2Dr+yRJd54EBGWomKGB6Lx2nk3vQKPSg=;
 b=FLHiM2HyoS72dhowf6PCP86zVHE3Yf4XmGITvrtlSrVwuLKrkK9FuD8JlsUqjYEJhH
 NUBqjkD7ZcRjY+pUYdD3vUmD4wzyXFJ1Cuy3KyF6NWSGq1ynwZImSeMTRF1RB32ZljZP
 1+78nCZaR/ztuRI57QrlR58zg9Y1ZQtLh6XrGdtfgET6YHjmUnAH6deB46Pt22gzTA3q
 r+O+OUMLZ7VLTEbZbjonoGohuQ/NHLhaOzVm5uZOMGqekG6WWhc53jADhlr1eB5MdmEP
 TU9sN3zrJsR3Vcz5VtBEMTKra8pPvsAmpPHAL7q4MdeLf3QH1RdXf0EVVW7e4zj8hB4S
 31bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHaJ2xgil6VycdZBsmlBhye/bcOcqD/1nEtKzlP00yWz9gzIPPN69ZpUrg4eVRgbHdZ/8jy1cG2nM2@nongnu.org
X-Gm-Message-State: AOJu0YwZLYL9uKSW3IgGkcfMM57RTi1iNKBPSaY45lRCkWF6sMFegLpD
 C+dQDe23bztra7w3pw1pvW2rrEXym9YJAKbMNwk8XCAcd+wYNWaz255rEgnXLFc=
X-Gm-Gg: ASbGncuH3whGblTltGDJflo4If113N337GxtApSULO1/r24dx7QHSXTRTkyFYC9ug+Q
 fabw+0an5MCb4NW0D6vDCOwKoNUAVV4HiAyMViQWjXfMU/NAtxdoQ2SQTM372e/NNZO913cn909
 hWVnihNdltC61had4U6TVHwAoedVkbI51PNSu1qJ3Y/te7UO7jA/aOcCMXoPsS4xEIPOuZq/NQ4
 g3omM3aCBUwrxcY0sZ+cEBJhYDcPJion4FeqlvPO92GiqcpVMPKh1fXADRaiebSR0u6jd3NCE1k
 /qSh7DAczqoe0uSS5Gpq7hs8Sk4rMUPFHPkCL1RoAQ==
X-Google-Smtp-Source: AGHT+IFyiPL6K5AGYOLsd4p9hQzVnmuIR8XXj1rvfykXI+mzn70MxmL/wiXnotUopZJ8xPiRXmnpjA==
X-Received: by 2002:a05:620a:46a6:b0:7b6:7618:d7ce with SMTP id
 af79cd13be357-7b6f88d08a6mr356836385a.10.1734033130823; 
 Thu, 12 Dec 2024 11:52:10 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com
 (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6f25b2155sm116397185a.91.2024.12.12.11.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 11:52:10 -0800 (PST)
Date: Thu, 12 Dec 2024 14:52:02 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 svetly.todorov@memverge.com, nifan.cxl@gmail.com
Subject: Re: [PATCH RFC v3 3/3] mhsld: implement MHSLD device
Message-ID: <Z1s-4oPjHPFpnnnK@PC2K9PVX.TheFacebook.com>
References: <20241018161252.8896-1-gourry@gourry.net>
 <20241018161252.8896-4-gourry@gourry.net>
 <20241212174016.0000002a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212174016.0000002a@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=gourry@gourry.net; helo=mail-qk1-x732.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Dec 12, 2024 at 05:40:16PM +0000, Jonathan Cameron via wrote:
> On Fri, 18 Oct 2024 12:12:52 -0400
> Gregory Price <gourry@gourry.net> wrote:
> 
> > From: Svetly Todorov <svetly.todorov@memverge.com>
> > 
> > The shared state file only needs to be intialized once. Even if a guest
> > dies without clearing the ownership bits associated with its head-ID,
> > future guests with that ID will clear those bits in cxl_mhsld_realize(),
> > regardless of whether mhd_init is true or false.
> 
> That sounds like a race condition if not all hosts are brought
> up before the first add.
>

We weighed this against having to do an external setup like

# SHMID = ./create_sharedmem.sh
# ./launch_qemu --shmid=$SHMID

Which is what the original non-generalized prototype did.

So yeah, there's a race condition AND a footgun (setting init AFTER
qemu instances are already using the memory will blow the state away).

This was intended.

As you allude to in the next chunk - the only real way to get around
this is to have an entirely external process serialize access.
 
> > 
> > The following command line options create an MHSLD with 4GB of
> > backing memory, whose state is tracked in /dev/shm/mhd_metadata.
> > --mhd-init=true tells this instance to initialize the state as
> > described above.
> > 
> > ./qemu-system_x86-64 \
> > [... other options ...] \
> > -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> > -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
> > -object memory-backend-ram,id=mem0,size=4G \
> > -device cxl-mhsld,bus=rp0,num-dc-regions=1,volatile-dc-memdev=mem0,id=cxl-mem0,sn=66667,mhd-head=0,mhd-state_file=mhd_metadata,mhd-init=true \
> > -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G \
> > -qmp unix:/tmp/qmp-sock-1,server,nowait
> > 
> > Once this guest completes setup, other guests looking to access the
> > device can be booted with the same configuration options, but with
> > --mhd-head != 0,
> > --mhd-init=false,
> > and a different QMP socket.
> > 
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > Signed-off-by: Svetly Todorov <svetly.todorov@memverge.com>
> 
> A few trivial things inline.
> 
> In general the scheme looks workable but I'm not sure the contraints at setup time
> etc are suitable for an upstream solution.  Certainly a useful tool to have
> for kernel development though so I'll try and find time in next few days to apply
> this on my gitlab tree.
> 
> Longer term I think we need a more complex external program or a main / proxy
> type arrangement so that ordering requirements can be enforce

I marginally disagree.  We have to check ownership during memory use.

We should try not to have an external process dependency for deferencing a
pointer backed by an emulated DCD device. The current overhead is bad enough.

The shared memory use here mostly limits that overhead to cache invalidation,
and keeps the entire system fairly simple.

All this is to say - we err'd on the side of keeping it simple, even if it
has a few stupid footguns.  Obviously open to ideas, though.

>  and we can have
> richer info.  Having to chat to each qmp interface independently works fine is
> also a bit more complex than I think we would eventually want.
> 

This is a small component in someone's fabric manager that translates their
requests into QMP commands.  Whatever we ultimately decide on, the complexity
here is about the same.

> Having a solution in place though will make it much easier to move towards
> an eventual upstreamable solution. This is a great place to start from!
> 
> Jonathan
> 
> > +/*
> > + * We limit the number of heads to prevent the shared state
> > + * region from becoming a major memory hog.  We need 512MB of
> > + * memory space to track 8-host ownership of 4GB of memory in
> > + * blocks of 2MB.  This can change if the block size is increased.
> 
> I'm lost what makes up that size?
> 

I think the math is wrong here, we may have calculated based on
a larger capacity.  I need to go back and look at how we came to 512MB.

~Gregory


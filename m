Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562B1C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 17:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uji53-0003tG-FY; Wed, 06 Aug 2025 13:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <markjdb@gmail.com>) id 1uji50-0003sM-RH
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 13:37:34 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <markjdb@gmail.com>) id 1uji4y-0000bH-SK
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 13:37:34 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7e050bd078cso10017785a.3
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 10:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754501851; x=1755106651; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=W5Gc8j+Yah2WBVa5D5q+f9Gu479kK/ramh6diozHE8o=;
 b=jPgFTPy4zB8z7iicz1tJUe5s2Ss7Vai9k7bodNG0c3OudX2KhXwih97qTqhi5adVWV
 Z9BVPO8xcUnTPJ1n8P47745O+5fnsMMs4APgD/dS7fzpM29VKy+oXJzjwJ6YAbmsq0h/
 KbEkZ2yRJJYLRMmWKg+1XhqynCSUBfCUVQvRcYa2VievHR74yYk7hIF5Ih8g6rmcKtOz
 15SjQnhEzsjCi46047/bMXhkU5qcovX3Pci0mlU6bL+c/XSTyvc17Zf775nRqUp4yQZ2
 61Xiu+W6KViRg9PtsxcW1C6Ti4M+HXmFV4nLGPlALAE/5tsN7egleZmQFgR1MzQeXL1J
 72Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754501851; x=1755106651;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W5Gc8j+Yah2WBVa5D5q+f9Gu479kK/ramh6diozHE8o=;
 b=fYibsW813jKvq3LbE2boeNZughOVeEXaNqhgyjb0xOTGO1xN0O1B04SJ6lY/3w5Ub1
 ARXx+xmZTV54AdAQPJ7sgMxVhMkLTKfWh7Ht1HfIZQ5oOdw2FXO8O6Ce0zauUyBaQ7RI
 m0ICyLJoDkeIWKbncBIfEgKcHUtjWvGPFpbBzwS7NBUVJX3sFrKzUez0DyHH8rC/RiFG
 eGWpzN2HleHxR6DmooD0qIacVo0gcO8NDADY4FovmAeLx8QSmaEtuSq1YssIjtABS4ec
 2SD2LoGTcu97MtSKCzrPXC5XFyvtWP6Ihtc7DkM4vIU5q82ciPZDVp0LMSEP834HUst6
 T6qw==
X-Gm-Message-State: AOJu0YzpaOTZWFe8eIoUKAzWOENubLwD553b1PFn37vO4KnmPskf3FU0
 qskHHQfzwwOWI++ewQKuq2LlpxtLU3XwSQc14q+hw7lepFVNCfa42T9P
X-Gm-Gg: ASbGncvAHmRHpJ+yiAe1f1im6GCLlR3nmRRzSmlZUaoAWHExIkJ19Vfc3fLmsnC/6P8
 ehHFRgDSyaKJXygh6b7wXmxQgxvkx2NDuEfHUkf4dtz8I0zygYvCNK6pFA5zbSi00eggOuy10dK
 QfBlJcgblSSRCAxvwyoHRToD0j6RArLeu1NvmDiQn4KtACN/sj++EtAHF4tqJSA1y71mgHiRqDB
 D8ryvuruCC0BqqpR5RkUSbhx1cxRNb74Fg88k7cxeg6xO3gUi8nCaXcycsEx4n/D9J3S7jVH2WC
 FW3CpxUxC/W/jPrsAc1RCfG+PDO8zxCezKWvTiO386Aa2HOd3VPqr/iMurJD/8/xnHBMY7ya88/
 9xd1yrZV6rjtogKTHXuRSDfy2kQP1hmGktrabUk6Et65c1do=
X-Google-Smtp-Source: AGHT+IFIuH+2xAoVztu+oI7P+nuvkKuKozPjVAZ23k/qqr9rtYv4sgOsg50lrKNEZenGn5k1FKbklA==
X-Received: by 2002:a05:622a:1342:b0:4b0:777f:6287 with SMTP id
 d75a77b69052e-4b09250414dmr36547601cf.3.1754501851042; 
 Wed, 06 Aug 2025 10:37:31 -0700 (PDT)
Received: from nuc (192-0-220-237.cpe.teksavvy.com. [192.0.220.237])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b06ac5bd99sm41014781cf.21.2025.08.06.10.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 10:37:30 -0700 (PDT)
Date: Wed, 6 Aug 2025 13:37:28 -0400
From: Mark Johnston <markj@freebsd.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH] 9pfs: Add FreeBSD support
Message-ID: <aJOS2A9dRdqks-fp@nuc>
References: <aIEGDjMex-DG-pmr@nuc> <1989897.fkXqvmx5VE@silver>
 <aIos9lb1dBuDBq2E@nuc> <2268148.dRjqHlHdj4@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2268148.dRjqHlHdj4@silver>
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=markjdb@gmail.com; helo=mail-qk1-x72d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 HK_RANDOM_ENVFROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Aug 05, 2025 at 01:49:44PM +0200, Christian Schoenebeck wrote:
> On Wednesday, July 30, 2025 4:32:22 PM CEST Mark Johnston wrote:
> > On Tue, Jul 29, 2025 at 06:09:35PM +0200, Christian Schoenebeck wrote:
> > > On Wednesday, July 23, 2025 5:55:58 PM CEST Mark Johnston wrote:
> [...]
> > Thank you for taking a look.
> > 
> > I'll certainly be around to help deal with issues and patches relating
> > to 9pfs+FreeBSD hosts.  It's hard to prove that, but for what it's worth
> > I use QEMU fairly extensively for FreeBSD development when I can't use
> > the native hypervisor, and that's not likely to change anytime soon.
> > 
> > Would adding myself to MAINTAINERS for virtio-9pfs (or a new
> > virtio-9pfs-freebsd category) be appropriate in that case?
> 
> Good to hear that you will be around!
> 
> I leave it to you whether you want to add yourself as reviewer of patches to
> MAINTAINER's 9pfs section.

Ok.  I'll leave myself off the list for now then.  If the patch is
applied and any FreeBSD-related problems crop up, please let me know of
course I'll try to fix them ASAP.  If this turns out to be a regular
occurrence (hopefully not), I can add myself and be more proactive about
responding to patches or bug reports.

> > > > diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
> > > > index a1924fe3f0..7315b32591 100644
> > > > --- a/hw/9pfs/9p-util.h
> > > > +++ b/hw/9pfs/9p-util.h
> > > > @@ -21,6 +21,14 @@
> > > >  #define O_PATH_9P_UTIL 0
> > > >  #endif
> > > >  
> > > > +#ifdef CONFIG_FREEBSD
> > > > +/*
> > > > + * FreeBSD does not have these flags, so we can only emulate them (racily).
> > > > + */
> > > > +#define XATTR_CREATE    0x1
> > > > +#define XATTR_REPLACE   0x2
> > > > +#endif
> > > > +
> > > 
> > > What do you mean with "racily" here?
> > 
> > FreeBSD cannot atomically check for the existence of and set an extattr,
> > the system call interface simply doesn't support it today.  This means
> > that fsetxattrat_nofollow() needs back-to-back system calls to check for
> > the existence of an attribute and then potentially set it.
> 
> Ah, I was misinterpreting your comment as if it were "racily defining" the
> macros. Maybe change the comment to something like "... can only emulate their
> intended behaviour (racily) ...".

Done.  I'll send out a v2 shortly.


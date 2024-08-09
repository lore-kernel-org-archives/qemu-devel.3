Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07A1C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 08:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scKv6-0002SX-Vr; Fri, 09 Aug 2024 04:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1scKv5-0002S1-7Y
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:24:19 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1scKv3-0008W4-CH
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:24:18 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 450A161639;
 Fri,  9 Aug 2024 08:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9C8C32782;
 Fri,  9 Aug 2024 08:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723191855;
 bh=eCPYO7k8einZmGW1UrDuHki8qQ6ec/+2EnDneiq2HZ0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=DeBXzDhuqZUaRs00yRhoABN21W0kmvnS+rp31D95QzOB8JtfX8ORd1Ewl0ecdBCaj
 P6nzJD7ELL21XOecdzwwQ8j3Q+AkZDmSoLERd/NTWTMAuuX9yQUvUNVvgEgowKmhsD
 Bm0883My3nWU1pa2Tupw/vwAGwvh/D1eJ96oPUolqpMxY3JqaENs0hj431J2t1MgMS
 fy5L3c9y1R4rDye21rUYqrfeh0ZTvgachzwetEhskgNxTLx1Zezda10e8PG+RiT+yn
 KlSmiPrJA+W6PFvxGun2mpKc8YTh12EJZi75NLAzQEzAYY3cWZRU1huPCoDgh4Xix9
 1+K58H5Wj0UuQ==
Date: Fri, 9 Aug 2024 10:24:09 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: John Snow <jsnow@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Cleber Rosa <crosa@redhat.com>,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 7/7] scripts/ghes_inject: add a script to generate
 GHES error inject
Message-ID: <20240809102409.136837ec@foz.lan>
In-Reply-To: <CAFn=p-ZM8cgKvUx+5v7YU6TaPZySJL1QnHqjmN5rQpF=D_V=8Q@mail.gmail.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <0654a89fe24f4343016b9cecc0752594ad1cd49f.1722634602.git.mchehab+huawei@kernel.org>
 <CAFn=p-Y27zap1P5G3NibdZS26iGwCqh8U0vgW0Vw31f53+oU1w@mail.gmail.com>
 <20240809004137.01f97da2@foz.lan>
 <CAFn=p-ZM8cgKvUx+5v7YU6TaPZySJL1QnHqjmN5rQpF=D_V=8Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Em Thu, 8 Aug 2024 19:33:32 -0400
John Snow <jsnow@redhat.com> escreveu:

> > > Then here you'd use qmp.cmd (raises exception on QMPError) or qmp.cmd_raw
> > > or qmp.cmd_obj (returns the QMP response as the return value even if it  
> > was  
> > > an error.)  
> >
> > Good to know, I'll try and see what fits best.
> >  
> 
> I might *suggest* you try to use the exception-raising interface and catch
> exceptions to interrogate expected errors as it aligns better with the
> "idiomatic python API" - I have no plans to support an external API that
> *returns* error objects except via the exception class. This approach will
> be easier to port when I drop the legacy interface in the future, see below.
> 
> But, that said, whichever is easiest. We use all three interfaces in many
> places in the QEMU tree. I have no grounds to require you to use a specific
> one ;)

While a python-style exception handling is cool, I ended opting to use 
cmd_obj(), as the script needs to catch the end of /machine/unattached/device[]
array, and using cmd_obj() made the conversion easier.

One of the things I missed at the documentation is a description of the
possible exceptions that cmd() could raise.

It is probably worth documenting it and placing them on a QMP-specific
error class, but a change like that would probably be incompatible with
the existing applications. Probably something to be considered on your
TODO list to move this from legacy ;-)

Anyway, I already folded the changes at the branch I'll be using as basis
for the next submission (be careful to use it, as I'm always rebasing it):

	https://gitlab.com/mchehab_kernel/qemu/-/commit/62feb8f6037ab762a9848eb601a041fbbbe2a77a#b665bcbc1e5ae3a488f1c0f20f8c29ae640bfa63_0_17


Thanks,
Mauro


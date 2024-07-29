Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9716C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 12:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYPoP-0001GK-W3; Mon, 29 Jul 2024 08:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sYPoN-0001A6-OV; Mon, 29 Jul 2024 08:49:11 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sYPoL-0004mN-SS; Mon, 29 Jul 2024 08:49:11 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 04331614E2;
 Mon, 29 Jul 2024 12:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3784C32786;
 Mon, 29 Jul 2024 12:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722257346;
 bh=qiXNpi1eTOPDfP97kK82wC1o8JCtBMWHZhQTd5JEvm0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=sHDtvnXkt1avsRE4G2VxEXzbJzZO19bsvalHW82b3sv59QjOGjFxGMlHWv1/kFQCV
 t/Gp8RZ+3WO/lHeLQUowJJz0cj/XpMHuc1mSkINsMCCpYXvC6ZeO9hPkKZoelYMcCU
 vKzlP2YCJmphZTwvUaGcXHxSvGXG+CE7ei9mMB4y/2+Q3avUvpLnzAXL7zPFQ45sTP
 3ZROSt5H8tJuVfMjEYerxXQ5rFe7uHJPA5yBBeLZNXIBL+PhhwTYaPS2peN0UoyP3D
 sW4iqf04vpb73PXpxsULOTzazuippCR+KZEJnrJv3QyPt1SuNIZ9XMpXwMShPakRn7
 2XfMlKYJz/Iyg==
Date: Mon, 29 Jul 2024 14:49:00 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Markus Armbruster <armbru@redhat.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake
 <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 4/7] acpi/ghes: Add a logic to handle block addresses
 and FW first ARM processor error injection
Message-ID: <20240729144900.459c0a42@foz.lan>
In-Reply-To: <20240726134646.000046e3@Huawei.com>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <6a3542a7d8acfbf88c906ec6f6dc5a697257b461.1721630625.git.mchehab+huawei@kernel.org>
 <87bk2lreeb.fsf@pond.sub.org> <20240726134646.000046e3@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

Em Fri, 26 Jul 2024 13:46:46 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> A few quick replies from me.
> I'm sure Mauro will add more info.
> 
> > > +           'tlb-error',
> > > +           'bus-error',
> > > +           'micro-arch-error']
> > > +}
> > > +
> > > +##
> > > +# @arm-inject-error:
> > > +#
> > > +# Inject ARM Processor error.
> > > +#
> > > +# @errortypes: ARM processor error types to inject
> > > +#
> > > +# Features:
> > > +#
> > > +# @unstable: This command is experimental.
> > > +#
> > > +# Since: 9.1
> > > +##
> > > +{ 'command': 'arm-inject-error',
> > > +  'data': { 'errortypes': ['ArmProcessorErrorType'] },    
> > 
> > Please separate words with dashes: 'error-types'.
> >   
> > > +  'features': [ 'unstable' ]
> > > +}    
> > 
> > Is this used only with TARGET_ARM?
> > 
> > Why is being able to inject multiple error types at once useful?  
> 
> It pokes a weird corner of the specification that I think previously 
> tripped up Linux.
> 
> > 
> > I'd expect at least some of these errors to come with additional
> > information.  For instance, I imagine a bus error is associated with
> > some address.  
> 
> Absolutely agree that in sane case you wouldn't have multiple errors
> but we want to hit the insane ones :(

Yes.

> There is only prevision for one set of data in the record despite
> it providing a bitmap for the type of error.

Well, there isn't anything at the UEFI forbidding to use multiple bits.

On a "normal" field with a bitmask, more than one bit set is supported.
So, as spec doesn't deny it, it should be valid to have more than one 
bits filled.

Now, when multiple errors bits from this table are set:

            +-----|---------------------------+
            | Bit | Meaning                   |
            +=====+===========================+
            |  1  | Cache Error               |
            |  2  | TLB Error                 |
            |  3  | Bus Error                 |
            |  4  | Micro-architectural Error |
            +-----|---------------------------+

- if bit 4 is set, as specified at the spec, the error-info field is 
  defined by the ARM vendor, according with:

	"N.2.4.4.1.1. ARM Vendor Specific Micro-Architecture ErrorStructure

	 This is a vendor specific structure. Please refer to your hardware
	 vendor documentation for the format of this structure."

  So, provided that the vendor-specific documentation explicitly allows
  setting bit 4 with other bits, I don't see an UEFI compliance problem.

- if bit 4 is not set, but multiple bits 1 to 3 are set, the content
  of error-info is currently undefined, as tables N.18 to N.20 won't
  apply.

Anyway, from spec PoV, IMO UEFI API requires an errata to clearly enforce
that just one bit should be set or to define the behavior when multiple
ones are set.

Thanks,
Mauro


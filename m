Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20F7C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 14:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc3ry-00024M-IK; Thu, 08 Aug 2024 10:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sc3rx-00022k-0V; Thu, 08 Aug 2024 10:11:57 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sc3ru-0003Ry-Q0; Thu, 08 Aug 2024 10:11:56 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 39748CE1235;
 Thu,  8 Aug 2024 14:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30833C32782;
 Thu,  8 Aug 2024 14:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723126307;
 bh=+8KhZkMTI5fRZGMzqJiKMgxHC07OvLU1UljF56wsFDI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=sgSsRyDFt7OAwOaW34uDzSl+7WLoS2aAgUs/xckW5EK/4cWOfyAlSYT64mTCgLcJb
 s1aexZW+xsPXBmmUNg33vx5AuKwMuALesWFRK/zxpFRo1ewo/4o2uqlaij7JIctLCz
 +5UVeyBMbJQf57ushrLmciG8wwZI0zDiDBddOs9BlQKMnjpb7u0t4V99NmUUYVt9Fr
 q7zEICRDImzWheYij9Vg3Jaa4MnvH9Xf5Z1AWHWBn2MSfb8m6zcATy0NSl5mR9LY++
 KV/zbZ0q413U4IzKvvL7Xz25IMG/FY+u9CpsCyyhFIQMJkO+70iSB1rzBm7r8m67BU
 gG8d9zKVBxbUg==
Date: Thu, 8 Aug 2024 16:11:41 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake
 <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 5/7] qapi/ghes-cper: add an interface to do generic
 CPER error injection
Message-ID: <20240808161141.5ffe730e@foz.lan>
In-Reply-To: <87v80b1jqe.fsf@pond.sub.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <51cbdc8a53e58c69ee17b15c398feeeeeeb64f34.1722634602.git.mchehab+huawei@kernel.org>
 <87v80b1jqe.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
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

Em Thu, 08 Aug 2024 10:50:33 +0200
Markus Armbruster <armbru@redhat.com> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 98eddf7ae155..655edcb6688c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2075,6 +2075,13 @@ F: hw/acpi/ghes.c
> >  F: include/hw/acpi/ghes.h
> >  F: docs/specs/acpi_hest_ghes.rst
> >  
> > +ACPI/HEST/GHES/ARM processor CPER
> > +R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > +S: Maintained
> > +F: hw/arm/ghes_cper.c
> > +F: hw/acpi/ghes_cper_stub.c
> > +F: qapi/ghes-cper.json
> > +  
> 
> Here's the reason for creating a new QAPI module instead of adding to
> existing module acpi.json: different maintainers.
> 
> Hypothetical question: if we didn't care for that, would this go into
> qapi/acpi.json?

Independently of maintainers, GHES is part of ACPI APEI HEST, meaning
to report hardware errors. Such hardware errors are typically handled by 
the host OS, so quest doesn't need to be aware of that[1].

So, IMO the best would be to keep APEI/HEST/GHES in a separate file.

[1] still, I can foresee some scenarios were passing some errors to the
    guest could make sense.

> 
> If yes, then should we call it acpi-ghes-cper.json or acpi-ghes.json
> instead?

Naming it as acpi-ghes,acpi-hest or acpi-ghes-cper would equally work
from my side.

> 
> >  ppc4xx
> >  L: qemu-ppc@nongnu.org
> >  S: Orphan  
> 
> [...]
> 
> > diff --git a/qapi/ghes-cper.json b/qapi/ghes-cper.json
> > new file mode 100644
> > index 000000000000..3cc4f9f2aaa9
> > --- /dev/null
> > +++ b/qapi/ghes-cper.json
> > @@ -0,0 +1,55 @@
> > +# -*- Mode: Python -*-
> > +# vim: filetype=python
> > +
> > +##
> > +# = GHESv2 CPER Error Injection
> > +#
> > +# These are defined at
> > +# ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
> > +# (GHESv2 - Type 10)
> > +##  
> 
> Feels a bit terse.  These what?
> 
> The reference could be clearer: "defined in the ACPI Specification 6.2,
> section 18.3.2.8 Generic Hardware Error Source version 2".  A link would
> be nice, if it's stable.

I can add a link, but only newer ACPI versions are hosted in html format
(e. g. only versions 6.4 and 6.5 are available as html at uefi.org).

Can I place something like:

	Defined since ACPI Specification 6.2,
	section 18.3.2.8 Generic Hardware Error Source version 2. See:

	https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#generic-hardware-error-source-version-2-ghesv2-type-10

e. g. having the link pointing to ACPI 6.4 or 6.5, instead of 6.2?

>   # @raw-data: payload of the CPER encoded in base64
> 
> Have you considered naming this @payload instead?

Works for me.

Thanks,
Mauro


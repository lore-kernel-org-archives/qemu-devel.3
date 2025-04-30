Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D1FC3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA9sC-0003cm-N0; Wed, 30 Apr 2025 12:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uA9rB-00038v-Mx
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:00:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uA9r8-0002xV-1N
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746028816;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SY1n0J+9VqV1Uw97XrZ9GGvHQkdcI3eK/ymZtloU6sQ=;
 b=YFpxbvH9G/TUabZ9Gmp52Egxsb/zPBSZDWMmyzbCCE0NX8gbXGPOn8Y0fg8lUBKj4eR/ht
 99kKWaxHElHGSF5vZtTl1FA7jDGjEQHp33QBg9cdH5iqZ9vfrqo5JRl3+10FMDRTqi7e3Y
 UQROdJoi9SFHwXiCl5rwZ5qErow2qwg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-aH82xG-pOzC96YyIjH8ENw-1; Wed,
 30 Apr 2025 12:00:11 -0400
X-MC-Unique: aH82xG-pOzC96YyIjH8ENw-1
X-Mimecast-MFC-AGG-ID: aH82xG-pOzC96YyIjH8ENw_1746028810
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45F981800989; Wed, 30 Apr 2025 16:00:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.35])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22F7A19560A3; Wed, 30 Apr 2025 16:00:07 +0000 (UTC)
Date: Wed, 30 Apr 2025 17:00:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mario Fleischmann <mario.fleischmann@lauterbach.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, philmd@linaro.org,
 armbru@redhat.com, christian.boenig@lauterbach.com
Subject: Re: [PATCH v2 01/20] mcd: Introduce Multi-Core Debug (MCD) API
Message-ID: <aBJJBbkbO6Eb4Ozw@redhat.com>
References: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
 <20250430052741.21145-2-mario.fleischmann@lauterbach.com>
 <aBHdEz2x_ckyfnF_@redhat.com>
 <8ecb6cb9-1a8a-4feb-a490-032154665ac6@lauterbach.com>
 <aBIdzY2CtPL7j39p@redhat.com>
 <a690015d-3151-4431-a8d0-db0cc587ed1a@lauterbach.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a690015d-3151-4431-a8d0-db0cc587ed1a@lauterbach.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 30, 2025 at 05:22:37PM +0200, Mario Fleischmann wrote:
> On 30.04.2025 14:56, Daniel P. Berrangé wrote:
> > On Wed, Apr 30, 2025 at 02:47:07PM +0200, Mario Fleischmann wrote:
> >> On 30.04.2025 10:20, Daniel P. Berrangé wrote:
> >>> On Wed, Apr 30, 2025 at 07:27:22AM +0200, Mario Fleischmann wrote:
> 
> [...]
> 
> >>>> diff --git a/mcd/mcd_api.h b/mcd/mcd_api.h
> >>>> new file mode 100644
> >>>> index 0000000..8c89353
> >>>> --- /dev/null
> >>>> +++ b/mcd/mcd_api.h
> >>>> @@ -0,0 +1,3963 @@
> >>>> +/*
> >>>> + * Copyright (c) 2008, ARM Ltd., Infineon Technologies, NXP Semiconductors,
> >>>> + * Lauterbach, STMicroelectronics and TIMA Laboratory.
> >>>> + * All rights reserved.
> >>>> + *
> >>>> + * PREAMBLE
> >>>> + *
> >>>> + * The MCD API (Multi-Core Debug) has been designed as an interface between
> >>>> + * software development tools and simulated or real systems with multi-core
> >>>> + * SoCs. The target is to allow consistent software tooling throughout the
> >>>> + * whole SoC development flow.
> >>>> + * The MCD API (the "SOFTWARE") has been developed jointly by ARM Ltd.,
> >>>> + * Infineon Technologies, NXP Semiconductors, Lauterbach,
> >>>> + * STMicroelectronics and TIMA Laboratory as part of the SPRINT project
> >>>> + * (www.sprint-project.net).
> >>>> + * The SPRINT project has been funded by the European Commission.
> >>>> + *
> >>>> + * LICENSE
> >>>> + *
> >>>> + *  Any redistribution and use of the SOFTWARE in source and binary forms,
> >>>> + *  with or without modification constitutes the full acceptance of the
> >>>> + *  following disclaimer as well as of the license herein and is permitted
> >>>> + *  provided that the following conditions are met:
> >>>> + *  - Redistributions of source code must retain the above copyright notice,
> >>>> + *    this list of conditions and the disclaimer detailed below.
> >>>> + *  - Redistributions in binary form must reproduce the above copyright notice,
> >>>> + *    this list of conditions and the disclaimer detailed below in the
> >>>> + *    documentation and/or other materials provided with the distribution.
> >>>> + *  - Neither the name of its copyright holders nor the names of its
> >>>> + *    contributors may be used to endorse or promote products derived from the
> >>>> + *    Software without specific prior written permission.
> >>>> + *  - Modification of any or all of the source code, documentation and other
> >>>> + *    materials provided under this license are subject to acknowledgement of
> >>>> + *    the modification(s) by including a prominent notice on the modification(s)
> >>>> + *    stating the change(s) to the file(s), identifying the date of such change
> >>>> + *    and stating the name of the publisher of any such modification(s).
> 
> [...]
> 
> >>> AFAICT this license is derived from a classic BSD 3 clause, with the
> >>> extra 4th clause added.
> >>>
> >>> I don't see any SPDX license matching this, which is painful as it
> >>> means it is going to need license approval before it can be included
> >>> by distributions downstream.
> >>>
> >>> Does this really have to be under a custom license instead of a
> >>> well known standard license ? There's really no good reason for
> >>> inventing new open source licenses.
> >>
> >> BSD 3-Clause Modification matches the license of the MCD API and is
> >> listed under the SPDX License List. Is it possible to extend
> >> checkpatch's @valid with "BSD-3-Clause-Modification"? That way, we can
> >> also add the SPDX-License-Identifier to mcd_api.h without an error being
> >> generated by the script.
> > 
> > Conceptually this is similar to BSD-3-Clause-Modification, but the
> > actual text of the license does not match
> > 
> >   https://spdx.org/licenses/BSD-3-Clause-Modification.html
> > 
> > so IMHO we can't claim this is BSD-3-Clause-Modification currently.
> > 
> > IIUC, it would have to be submitted to SPDX for review to decide
> > whether it needs to be a new license, or whether the permitted text
> > for BSD-3-Clause-Modification can allow a choice of matches.
> So, according to the SPDX License List matching guidelines, changes to
> BSD-3-Clause-Modification can only be seen as equivalent if at most the
> clauses are stated in a different order, as indicated by the red text?

I believe for matching requirements, ordering of paragraphs must
be a fixed per:

  https://spdx.github.io/spdx-spec/v2.3/license-matching-guidelines-and-templates/#b32-guideline-verbatim-text

In terms of lists, however, they permit the numbers to be substituted
by bullets and vica-verca per

 https://spdx.github.io/spdx-spec/v2.3/license-matching-guidelines-and-templates/#b8-bullets-and-numbering

> I assume we agree that the first three clauses match BSD-3-Clause.

There are some slight wording differences in the first 2 clauses,
but IMHO they don't make a semantic difference.

> To show that the fourth clause matches BSD-3-Clause-Modification, I
> split up both license texts and indented MCD API's license:

For BSD-3-Clause-Modification it currently defines the 4th clause
as

  If any files are modified, you must cause the modified files to
  carry prominent notices stating that you changed the files and
  the date of any change.

vs this file

  Modification of any or all of the source code, documentation and other
  materials provided under this license are subject to acknowledgement of
  the modification(s) by including a prominent notice on the modification(s)
  stating the change(s) to the file(s), identifying the date of such change
  and stating the name of the publisher of any such modification(s).

Even though (IMHO) the legal implications are basically equivalent,
under the SPDX matching guidelines I don't think we can consider
this a match.

> Stated like this, I think it is appropriate to see both clauses as
> equivalent. Since the contributor appendix on the third clause is not
> present in BSD-3-Clause-Modification, we have to specify the composite
> 
> Valid-License-Identifier: BSD-3-Clause-Modification AND BSD-3-Clause

I'm afraid that's not how SPDX license clauses work - the text of
the license in the file needs to match one specific SPDX license,
modulo fuzzy matching to the extent documented in the links above.

> Under which conditions is this Valid-License-Identifier ...well...
> valid? IIUC, we either need a formal approval from SPDX legal team or a
> relicensing of the MCD API. Is there maybe another way?

The quickest option is almost certainly to get this reviewed by
SPDX team as a new BSD variant.

Is there a canonical link where this license originates from ?

In terms of this QEMU series, I don't consider this a hard blocker,
as we can work through it asynchronously.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



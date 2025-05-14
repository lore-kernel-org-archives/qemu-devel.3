Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2225CC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFEDn-0006Iu-Aw; Wed, 14 May 2025 11:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFE3F-0000n3-2l
 for qemu-devel@nongnu.org; Wed, 14 May 2025 11:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFE3C-0000e2-R4
 for qemu-devel@nongnu.org; Wed, 14 May 2025 11:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747236581;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ujc5g4wP7awZPP/3/jYO0KhWUewU++24FB98JsLaKD0=;
 b=fA9mDWP498+PGxrdSIZ1WZa/UmWeKU0iV9g/SCqzCY0gewT3Xj3RiJRTeePZ5/pEFKJg61
 o596ZZCfJH9sfsS2FC0mIfSXuP2JFZX8ImX8GyKnUN/RvIaNsPp1VL8Lkzb8Yb6Mg5SYXT
 aaAiIg7LrU6BmedZRFma/owcE/3oFJQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-7PXd5x_dMUW1RklfQzMz_w-1; Wed,
 14 May 2025 11:29:38 -0400
X-MC-Unique: 7PXd5x_dMUW1RklfQzMz_w-1
X-Mimecast-MFC-AGG-ID: 7PXd5x_dMUW1RklfQzMz_w_1747236574
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAE8E1800EC8; Wed, 14 May 2025 15:29:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.147])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54BB618004A7; Wed, 14 May 2025 15:29:27 +0000 (UTC)
Date: Wed, 14 May 2025 16:29:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com,
 armbru@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v3 02/10] arm/cpu: Add sysreg properties generation
Message-ID: <aCS21A8UmjEedTIP@redhat.com>
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-3-cohuck@redhat.com>
 <aCNj4dFWLkBZrmmh@redhat.com> <878qmzciyg.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878qmzciyg.fsf@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On Wed, May 14, 2025 at 05:25:59PM +0200, Cornelia Huck wrote:
> On Tue, May 13 2025, Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Mon, Apr 14, 2025 at 06:38:41PM +0200, Cornelia Huck wrote:
> >> From: Eric Auger <eric.auger@redhat.com>
> >> 
> >> Introduce a script that automates the generation of system register
> >> properties definitions from a given linux source tree
> >> arch/arm64/tools/sysreg.
> >> 
> >> Invocation of
> >> ./update-aarch64-sysreg-code.sh $PATH_TO_LINUX_SOURCE_TREE
> >> in scripts directory additionally generates
> >> target/arm/cpu-sysreg-properties.c containing definitions for
> >> feature ID registers.
> >> 
> >> update-aarch64-sysreg-code.sh additionally calls
> >> gen-cpu-sysreg-properties.awk which is inherited from kernel
> >> arch/arm64/tools/gen-sysreg.awk. All credits to Mark Rutland
> >> the original author of this script.
> >> 
> >> [CH: split off from original patch adding both sysreg definitions
> >>  and properties]
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >> ---
> >>  scripts/gen-cpu-sysreg-properties.awk | 325 ++++++++++++++++++++++++++
> >>  scripts/update-aarch64-sysreg-code.sh |   5 +-
> >>  2 files changed, 329 insertions(+), 1 deletion(-)
> >>  create mode 100755 scripts/gen-cpu-sysreg-properties.awk
> >> 
> >> diff --git a/scripts/gen-cpu-sysreg-properties.awk b/scripts/gen-cpu-sysreg-properties.awk
> >> new file mode 100755
> >> index 000000000000..76c37938b168
> >> --- /dev/null
> >> +++ b/scripts/gen-cpu-sysreg-properties.awk
> >> @@ -0,0 +1,325 @@
> >> +#!/bin/awk -f
> >> +# SPDX-License-Identifier: GPL-2.0
> >
> > GPL-2.0 is a deprecated SPDX identifier. checkpatch.pl ought to
> > have complained about this, requiring GPL-2.0-or-later as the
> > preference, with GPL-2.0-only requiring justification in the
> > commit.
> 
> GPL-2.0 is inherited from the Linux script mentioned; not sure if
> GPL-2.0-only would be the correct fit here?

Yes, according to the table of deprecated terms at the bottom of

https://spdx.org/licenses/

GPL-2.0-only would indeed be the correct replacement.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



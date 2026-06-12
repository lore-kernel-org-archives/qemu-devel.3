Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3985CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 11:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY015-0001Yh-Hc; Fri, 12 Jun 2026 07:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wY013-0001YL-Kh
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 07:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wY011-0006HB-Uq
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 07:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781263509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aEJtkLPRSIgHIFIU0/rrxmffA42MTYT1FFKMyK/sGAM=;
 b=gw3DX5uRZkwpX9MvguzftPXg8cUOsyMkdw+ZUXNXuBNN3naqw0dCq027Xf7yYWhN0cPbLK
 NrPze1DDbjdiifW84/O+7Dva75DW7RI0V64dQhDNX2aUjHJ/gsgo6PvU++2gXs5kbIvREl
 SOhVgHoTGk9MJO4Eqg0z6uUvF7wV6Fo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-WHrgOT3-MxebZ8ilUpvDmg-1; Fri,
 12 Jun 2026 07:25:04 -0400
X-MC-Unique: WHrgOT3-MxebZ8ilUpvDmg-1
X-Mimecast-MFC-AGG-ID: WHrgOT3-MxebZ8ilUpvDmg_1781263502
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F94D1800845; Fri, 12 Jun 2026 11:25:02 +0000 (UTC)
Received: from localhost (unknown [10.44.49.167])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EFEB1954128; Fri, 12 Jun 2026 11:25:00 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Khushit Shah <khushit.shah@nutanix.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Shaju Abraham
 <shaju.abraham@nutanix.com>, Mark Cave-Ayland
 <mark.caveayland@nutanix.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Shameer
 Kolothum <skolothumtho@nvidia.com>, Jinqian Yang <yangjinqian1@huawei.com>,
 Marc Zyngier <maz@kernel.org>, Sebastian Ott <sebott@redhat.com>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>
Subject: Re: [RFC] arm: property and value naming summary between named CPU
 models vs customizable host model
In-Reply-To: <B820643E-3F14-4CDA-BA6B-09C632F17B9E@nutanix.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <B820643E-3F14-4CDA-BA6B-09C632F17B9E@nutanix.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Fri, 12 Jun 2026 13:24:57 +0200
Message-ID: <87bjdgm25y.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 10 2026, Khushit Shah <khushit.shah@nutanix.com> wrote:

Thank you for the writeup!

(...)

> I have tried to keep the comparison above neutral, but Eric/Cornelia can
> add more. I see real merit in [2]'s simplicity and generalization. But
> for [1], I love a command line that looks like:
> -cpu host,feat_DP=off,feat_AES=off,feat_RAS=0.0,...
>
> instead of:
> -cpu host \
>      SYSREG_ID_AA64ISAR0_DP=0,\
>      SYSREG_ID_AA64ISAR0_AES=0,\
>      SYSREG_ID_AA64PFR0_RAS=0,\
>      SYSREG_ID_AA64PFR1_RAS_FRAC=0 
>
> I have no strong preference on this topic. The named CPU model layer is
> independent of whichever convention we choose here, so I'd like the
> community to decide which direction makes the most sense :)

I see the human-friendliness of providing prop names as in [1], but I
also see the advantages of generating properties automatically from the
ARM specification in [2]. Maybe there's a way to get the best of both
worlds? Can we expose the feat_XXX properties to users by mapping them
to the relevant registers respectively the combinations of them and
still keep the raw sysregs for those cases where something does not
match to feat_XXX (e.g. some cache values), or just as an alternative
way of configuring things?

Also, we've mostly talked about KVM so far. If we also consider TCG, or
other hypervisors such as HVF, I'd be in favour of grabbing definitions
from the spec, instead of from a specific kernel. (We can still choose
to match the Linux names, but we should not have to.)

There are also some pre-existing properties for cpus; can we express
them via the new interfaces, or do we want to deprecate them, only
keeping those that do not match to hardware, but to accelerator
implementation details?



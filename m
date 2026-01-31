Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F339EE6BF3C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 02:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vm0Mi-0002tu-2T; Fri, 30 Jan 2026 21:05:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1vm0MY-0002mk-LD; Fri, 30 Jan 2026 21:05:29 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1vm0MW-00010C-7x; Fri, 30 Jan 2026 21:05:25 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 05C1360008;
 Sat, 31 Jan 2026 02:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C886C4CEF7;
 Sat, 31 Jan 2026 02:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769825121;
 bh=rUvM+mJVQvGOdfCVg7KC2IpoeDqIFA3BYeOqe2gZSN8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jZsdrkJOTKChyCBiPb4Zmnq3e0kfU3udIhISB54fiJ+hQprEA/A7t7FcewTDIJvmv
 4wAivAa5z2ntYPqwC9vCWTbd3P+DFskp3mpkpMhIxDNAJxt9gPbruGp6b59DtcIbRF
 MuIWlNd5cBnaP2NwTQ/sRdDz4qITTWRSCtHeT4fjyqwh66gLZH506Vtt5E0ft6yVrE
 AyouQ+orMp6xFdfE+7bUuxo5NUvYredcuiV51lHr2iKGhyc8AWHN5OvXKQrXaz/h8E
 ldNmvXLHF1rnBo7KvJBuzYHNfmFP0jCSj1JMajH0yUrTLdjvmR7tWxQZhVNtc5Ut3D
 GxETJLB6/iRjA==
Date: Fri, 30 Jan 2026 19:05:19 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: Re: [PATCH 5/5] hw/nvme: Fix bootindex suffix use-after-free
Message-ID: <aX1jX-JZ8V0BhQum@kbusch-mbp>
References: <20260125-nvme-v1-0-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
 <20260125-nvme-v1-5-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
 <d74ef37a-b423-457a-b2c1-31989243b1a8@linaro.org>
 <aXpUD4s7LrC9-AMa@AALNPWKJENSEN.aal.scsc.local>
 <aX1cx3mR-s4pKdDP@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aX1cx3mR-s4pKdDP@kbusch-mbp>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=kbusch@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 30, 2026 at 06:37:11PM -0700, Keith Busch wrote:
> On Wed, Jan 28, 2026 at 10:23:11AM -0800, Klaus Jensen wrote:
> > On Jan 25 17:56, Philippe Mathieu-Daudé wrote:
> > > On 25/1/26 07:42, Akihiko Odaki wrote:
> > > > The bootindex suffix can be used as long as the property is alive.
> > > 
> > > True, so:
> > > 
> > > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > 
> > > But maybe it shouldn't (we should g_strdup it like other QOM fields).
> > > 
> > 
> > Do you mean that device_add_bootindex_property() should g_strdup the
> > suffix? And then free it in property_release_bootindex()? That would
> > make sense to me.
> 
> Doesn't it already do that? 
> 
>   device_add_bootindex_property
>     object_property_add
>       object_property_try_add
>         g_strdup
> 
> ?

Sorry, nevermind. I was tracking the "name", not the "suffix", in which
case I agree with Klaus. If only for consistency between the two "const
char *" parameters.


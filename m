Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56150606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XUQ0NsxU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJnWQ-0001tv-K9; Thu, 22 Oct 2026 03:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xJnWI-0001iL-7y; Thu, 22 Oct 2026 03:47:26 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xJnWG-0002bw-Iv; Thu, 22 Oct 2026 03:47:26 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 749A560DC7;
 Thu, 22 Oct 2026 07:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B721F000C8;
 Thu, 22 Oct 2026 07:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792655241;
 bh=8L6cno+TAIZoiHp891ROfgUE3ULNnUZsfCkHtJ39CPU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=XUQ0NsxU/MAwzjM3rO/13VgK7WFJ++uLGn7IPmgmu/lT/iHUEPOozdPRajQhx0lHI
 Y3UzsE5tgIlwzJUwrL/l49E6w8SGKE1/eBTwo+wduMAe/kv6Iw8Y3aMFQqrq+8SW8R
 MEHW7qi+9X+KULv34T7QOjxK/Qa5+q8XsIySUDzfM/vNnB5HzgkdXbZw2TMz4hl6Vj
 ukr7g9nDZPrzRuh06/p5tSz9GOP7mUEeHAPr9OOVA31Rfs5plAk7vOPgK+o3YVuRCC
 eZw/Yf0+1Cve6iua7NIyM0WpmfCbvjaxRXVUFJ17e2L4iSeNzWBtka4x1QH+wt4cII
 T7y72NSKk4uwA==
Date: Thu, 22 Oct 2026 09:47:16 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Fam Zheng <fam@euphon.net>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 00/15] block: fix the zone write granularity and the
 zone append limit
Message-ID: <atm_hGIVewXV2aNE@ryzen>
References: <20260921142819.2916043-1-cassel@kernel.org>
 <asT0jpj6n2tLoHVx@ryzen> <atCCxTq-lClE-SUX@ryzen>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atCCxTq-lClE-SUX@ryzen>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=cassel@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 15, 2026 at 09:37:47AM +0200, Niklas Cassel wrote:
> On Tue, Oct 06, 2026 at 03:16:04PM +0200, Niklas Cassel wrote:
> > On Mon, Sep 21, 2026 at 04:28:02PM +0200, Niklas Cassel wrote:
> > > Hello Stefan, Kevin, and everyone else,
> > > 
> > > This series fixes how QEMU reports and enforces the two constraints that a
> > > zoned device places on a write to a sequential zone: the write granularity,
> > > and the largest zone append that it accepts. It also fixes two bugs in the
> > > zone append emulation in file-posix, one of which a guest can reach.
> > > 
> > > Most of it is preparation for Sam Li's zoned qcow2 series. The first two
> > > patches are taken directly from there, as they are unrelated to qcow2.
> > > 
> > > Changes since v5:
> > > -Picked up Stefan's Reviewed-by tags that he gave when reviewing v4.
> > >  Patches that have changed significantly since v4 have had tags dropped
> > >  (i.e. they will have neither Damien's nor Stefan's Reviewed-by tags).

Kevin, Hanna, Stefan, anyone,

Gentle ping on this series.


Kind regards,
Niklas


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49A6CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHG2K-00042r-Ds; Thu, 15 Oct 2026 03:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xHG2I-00040U-Ho; Thu, 15 Oct 2026 03:37:58 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xHG2H-0003BI-4M; Thu, 15 Oct 2026 03:37:58 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 246DB40502;
 Thu, 15 Oct 2026 07:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFDB1F000C4;
 Thu, 15 Oct 2026 07:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792049867;
 bh=xkmz9I+yDm/QSgdAV9kslP+Y/gPKe+jczMLkkZK8S/Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RF/yp9xe6TyXXk7RvWTNL/IYR4hJIDGQQlYWLLWGgIgi1376JtF+1bsYbqaQsdDuM
 daTLGJWiglBZb8zckt67Q397ZUZxY1RGnVKvaXueR2HVRq1Man9pM5WKALK47cvCpI
 zDo22FU53T3EN52MRSpIm0j37LNNy+f5ioR832XVMsX37cjsGKWfdM6ZrLJdeJAlPv
 JMlwlT9BBul8CwdYaHuhO4dFXY9ihFKEXAL8uWOostKWwTh7GVi3kaM5NFWmW9E/Ic
 40oifiJaheY3oE7uSPBCjcrd2c4JgRKGekEiyfwNQcQxVKLDT7+uAyQDcivyWOB0uU
 kInCHNiYPHH5Q==
Date: Thu, 15 Oct 2026 09:37:41 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Fam Zheng <fam@euphon.net>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v6 00/15] block: fix the zone write granularity and the
 zone append limit
Message-ID: <atCCxTq-lClE-SUX@ryzen>
References: <20260921142819.2916043-1-cassel@kernel.org>
 <asT0jpj6n2tLoHVx@ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asT0jpj6n2tLoHVx@ryzen>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=cassel@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Tue, Oct 06, 2026 at 03:16:04PM +0200, Niklas Cassel wrote:
> On Mon, Sep 21, 2026 at 04:28:02PM +0200, Niklas Cassel wrote:
> > Hello Stefan, Kevin, and everyone else,
> > 
> > This series fixes how QEMU reports and enforces the two constraints that a
> > zoned device places on a write to a sequential zone: the write granularity,
> > and the largest zone append that it accepts. It also fixes two bugs in the
> > zone append emulation in file-posix, one of which a guest can reach.
> > 
> > Most of it is preparation for Sam Li's zoned qcow2 series. The first two
> > patches are taken directly from there, as they are unrelated to qcow2.
> > 
> > Changes since v5:
> > -Picked up Stefan's Reviewed-by tags that he gave when reviewing v4.
> >  Patches that have changed significantly since v4 have had tags dropped
> >  (i.e. they will have neither Damien's nor Stefan's Reviewed-by tags).

Gentle ping on this series.


Kind regards,
Niklas


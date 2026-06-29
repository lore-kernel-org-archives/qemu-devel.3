Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5815CC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 10:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we9AE-0007mT-Uq; Mon, 29 Jun 2026 06:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1we9AD-0007kz-EA; Mon, 29 Jun 2026 06:24:29 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1we9AB-0003an-Ve; Mon, 29 Jun 2026 06:24:29 -0400
Received: from example.com (unknown [167.220.208.73])
 by linux.microsoft.com (Postfix) with ESMTPSA id 8047F20B716B;
 Mon, 29 Jun 2026 03:24:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8047F20B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1782728658;
 bh=m5dlg2mnwMT3S0rC1PYXNOHRGHJNIN27WNO0I8MSzlo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eRJZmAGjTHpMPcPqTzAnPrZO2TUl6w5PPJ4uMqwgYFlQtcRJ04v4brZp2b+zNms0j
 Ru+PxmxRscg9hUPDOPaPDg0OHYfhM2kSS6vISp6t0f5OVohd/iXlJ8o06PUHFH+KfF
 auvckGwQU+mGOZKP4AKXDRs13Ds3O7d80X6XRkP4=
Date: Mon, 29 Jun 2026 12:24:19 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel <qemu-devel@nongnu.org>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Wei Liu <liuwe@microsoft.com>, Magnus Kulke <magnuskulke@microsoft.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v6 2/9] target/i386/mshv: fix cpuid propagation bug
Message-ID: <akJH0yXcf+BfMCe/@example.com>
References: <20260416121116.527927-1-magnuskulke@linux.microsoft.com>
 <20260416121116.527927-3-magnuskulke@linux.microsoft.com>
 <4d47920e-f7f7-4021-b7d0-0d75ec4fb730@tls.msk.ru>
 <CABgObfaVgKfDbn_K_tqbemoK=q8XLam-GWGMFg9fCFNO9axHiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfaVgKfDbn_K_tqbemoK=q8XLam-GWGMFg9fCFNO9axHiA@mail.gmail.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Jun 28, 2026 at 01:41:02PM +0200, Paolo Bonzini wrote:
> Il dom 28 giu 2026, 13:24 Michael Tokarev <mjt@tls.msk.ru> ha scritto:
> 
> > Hi!
> >
> > Is this a qemu-stable material (11.0.x)?
> > I'm not sure how matur mshww is to begin with, whenever it is worth to
> > consider for the stable series.
> >
> 
> I am not even sure anyone can run it outside Microsoft... That's probably a
> no ;)
> 
> Paolo
> 
> 
> > Thanks,
> >
> > /mjt
> >
> >

yup, I would concur. theoretically yes - it does fix a bug that exists
on the stable release, but the bug only surfaces for -cpu host model
selection, which will only be supported in a future release (with the
patch series of which this commit is a part of).

best,

magnus


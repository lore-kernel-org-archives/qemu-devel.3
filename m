Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112F1D4115F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 10:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgKbh-0004e1-8g; Thu, 15 Jan 2026 05:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <reinoud@gorilla.13thmonkey.org>)
 id 1vgKbf-0004df-Rn
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 05:29:35 -0500
Received: from 77-173-18-117.fixed.kpn.net ([77.173.18.117]
 helo=gorilla.13thmonkey.org) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <reinoud@gorilla.13thmonkey.org>) id 1vgKbd-00005k-Lw
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 05:29:35 -0500
Received: by gorilla.13thmonkey.org (Postfix, from userid 103)
 id 9ECA014D1EB4; Thu, 15 Jan 2026 11:29:31 +0100 (CET)
Date: Thu, 15 Jan 2026 11:29:31 +0100
From: Reinoud Zandijk <reinoud@NetBSD.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Reinoud Zandijk <reinoud@NetBSD.org>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ryo ONODERA <ryoon@netbsd.org>
Subject: Re: [PULL 13/31] accel/nvmm: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Message-ID: <aWjBiwjKpfmnaBSe@gorilla.13thmonkey.org>
References: <20250704101433.8813-1-philmd@linaro.org>
 <20250704101433.8813-14-philmd@linaro.org>
 <44ccfba7-21a3-4c24-aa6a-4b2bdb989792@redhat.com>
 <dd7fbe03-1458-4c44-b8db-a9d5e9ae33f1@linaro.org>
 <87v7h44pal.fsf@pond.sub.org> <aWdfqvJhtDt14lTJ@redhat.com>
 <ea1e0e45-f864-4a43-a40e-48fd82c26c56@redhat.com>
 <87a4yg4gmo.fsf@pond.sub.org>
 <aWd9wP9-9rx0ELhY@gorilla.13thmonkey.org>
 <5279bbb4-a4b8-4c71-8275-92643b8796d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5279bbb4-a4b8-4c71-8275-92643b8796d7@redhat.com>
Received-SPF: none client-ip=77.173.18.117;
 envelope-from=reinoud@gorilla.13thmonkey.org; helo=gorilla.13thmonkey.org
X-Spam_score_int: 18
X-Spam_score: 1.8
X-Spam_bar: +
X-Spam_report: (1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, KHOP_HELO_FCRDNS=0.4,
 NO_DNS_FOR_FROM=0.001, RCVD_IN_PBL=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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

On Wed, Jan 14, 2026 at 01:17:20PM +0100, Paolo Bonzini wrote:
> On 1/14/26 12:28, Reinoud Zandijk wrote:
> > Sorry to break this but even submitting simple patches and getting them into
> > the qemu source tree hasn't been an easy nor enjoyable experience to me to
> > understate it
> 
> Have you actually tried since 2021 when your last commit was?
> https://patchew.org/search?q=project%3AQEMU+from%3Areinoud says you didn't
> but I may be missing something.
> 
> In fact your only contribution was a really big one, and I say this not to
> understate you work but because *almost anything* would be easier than
> submitting a new accelerator.

I can't claim all the credits :) Most of the low level work was done by maxv,
the author of NVMM. IIRC I updated the local patch and modified it to work
with the newer build framework and committed it into the tree. I have to admit
I haven't contributed more since but I still use Qemu daily, with the NVMM
accelerator :) It makes such a big difference.

> > so once in a while, a new version is pulled into pkgsrc and
> > patches are made on top and if they start to grow or diverge too much a patch
> > round can be made requested on the qemu repo. This is just my experience of
> > course.
> 
> We're not asking you to keep CI up-to-date (which Thomas is doing now,
> despite having no specific need that I know of to support NetBSD), just to
> *report* failure to build from source and tell us "hey, that's how we fixed
> it".  Otherwise we have the false impression that no one even cares about
> new QEMU on NetBSD.

As pkgsrc normally tracks releases and has a directory with local patches on
top of that, build errors only show up when we bump the version. Version 10.2
is now in pkgsrc though I am running 10.1.3 so there is surely interest in
keeping it running. I could try to commit some more trivial patches in the
repo here to reduce the diffs some more.

Thanks for the feedback,
Reinoud



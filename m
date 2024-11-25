Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37ECCD58D4C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 14:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFZoQ-0001rz-Q6; Mon, 25 Nov 2024 09:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tFZoN-0001rZ-1b; Mon, 25 Nov 2024 09:11:35 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tFZoL-0007QW-5n; Mon, 25 Nov 2024 09:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=BFKb8Rq8xQMWorM1jMPQkSFjh8eBrzRcxywfh/I+zCE=; b=W4OPQW+yKrB/3D4zBduBZfU7ey
 muKx7jbo+Ot4EUpnCJzvlu1/3PhIC4pFUi8C0/Xo/OWhP7ACJk+ZKPM45rPtcOF75s+GROXxF10vQ
 ZHOt/lgLK0qwJw1I5Ago1R34E2+YBVDw+Ko3h50WkUNPN1Wv5DgxriiSglZnc+vATvEICLbCA58jY
 /p1RHPSknVn3xVk0A8eJbDtNcwN0YXGNCa9Ocx15Bko6iDM8oPv2OqDCD4mftvjz41iNDLsslFnX5
 yDjYsDpz/AG4qez7aMpZoIJK4k1RVYwr0pYJQoUWJoilfXlL4tApnVh4yrk0VeStJdpsedsFBjpeF
 8YmtAghL7x+6EzEogNjrVXh5C6+TkI2HrsZLHRz+HQYC9ZrLtPdQRfJJdCg5Y+FF1TzPbMAoKOiuh
 lwf5uQvtxZ8aUBLvq5AigwGoZWq8j5Lw4mRLYpy/U7byIvb6nfmiOY0IQ6pi90I/ARNbhfiemNj61
 uMvcEHJtXtaPhVfGDHaJdWxRK+wK46O3Mx+B73k4pjCvRhpV2wG21KlbiDPGmpHfl+wwq7GX9zouE
 PDcSG0NyWV/IfblBNCzWgwYE7Wu0UYP4scUMgoSbeWuNn83eQKD77vFDldR0bIKtCSWo87NKdolF9
 Scxm4PTU6IuqdhP/zdKSQnGaaF0jcgvG/ru4zVL5U=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 0/6] 9pfs: fix fstat() after unlink() (with a Linux guest)
Date: Mon, 25 Nov 2024 15:11:26 +0100
Message-ID: <1808065.5Gi7jleHS2@silver>
In-Reply-To: <20241125123505.06ab0568@bahia>
References: <cover.1732465720.git.qemu_oss@crudebyte.com>
 <192504804.CgdclvVjum@silver> <20241125123505.06ab0568@bahia>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Monday, November 25, 2024 12:35:05 PM CET Greg Kurz wrote:
> On Mon, 25 Nov 2024 11:23:39 +0100
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> 
> > On Monday, November 25, 2024 9:45:54 AM CET Greg Kurz wrote:
> > > On Sun, 24 Nov 2024 17:28:40 +0100
> > > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
[...]
> > > > Probably there are still other 9p request types that should be fixed for this
> > > > use-after-unlink idiom, but this series fixes the mentioned bug report as
> > > > described by reporter, so fair enough to round this up here for now.
> > > > 
> > > 
> > > When I last worked on that issue I had spotted some other places to fix.
> > > 
> > > Maybe you can find some ideas for future work at :
> > > 
> > > https://github.com/gkurz/qemu/tree/9p-attr-fixes
> > 
> > Was there a reason why you left those patches on the attic?
> > 
> 
> Lack of cycles

Yeah, that's clear, I more meant in sense of known issues, as I haven't
spotted something obvious (above nit level) that would have spoken against
pushing those patches.

But OK, I also understand the lack of reviewers at that time, etc.

/Christian

> > What I am seeing is that it was not fixing Tgetattr (i.e. fstat() on guest),
> > so it wouldn't have fixed the original reporter's scenario, but they would
> > have brought things forward. So just wondering ...
> > 
> 
> Yeah the fix for Tgetattr was in some other series I had sent at the time but
> I did not get much feeback then...





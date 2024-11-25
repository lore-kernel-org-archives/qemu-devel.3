Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA85D3B7FF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 10:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFWFx-00013O-3Y; Mon, 25 Nov 2024 05:23:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tFWFs-00012t-Sz; Mon, 25 Nov 2024 05:23:44 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tFWFq-0002XJ-F0; Mon, 25 Nov 2024 05:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=K/5+gavxwGbW4JqzPfHXDsIedPXcjCL39kV0DfBe6Vc=; b=JN0XCD09sSXYtAy10WZAUXhzWB
 69ExVxuhR+vuIm41gGPuQIJl+YlLPvxRfsKTekgKq3tJsAkTp2Ha71sdrKsM2rM/b/YZk1D5LYagk
 hj7u0U9zprcRkY59DFQvWBWcW7nZMoxBwMjUY4fwwt1/MN+Br/NAMxpLhNJriTIDSxDg75u9XoM5R
 VQsE3XuvoOarGDZqLq5kbngzC1EXpdiqgKqE4lOWA+Ilcc1BXvGsUHVM1kgl91oHZYi0sYRw9BoZ5
 Dx98VoZVqHhg0450oktLgQ7Cvb6gAflxwFRA9D9mKfBRMLYX65IwpX+djGZgFFv07WLm5H9RVW8uk
 ZPkI44hY15QNf2l21ykAgHicsrptfROthol7QB913md3d1VGk/fhIUIjM4C2lPFMPIyZnkYdG1+qp
 Jw3oIlkqYVEttdRDkN3qcuIwMHSSF0WXTk/S//iRrB4Yfa0ywizTtAtEl0ckKihp9gTFWqjfAddtN
 cN1nyLke1gRhXTDkC5nAqXkmws2qyB9j0ALj1GMwAnZyYDOetgfuuGSTsQZFKEJrkFJy6TWkd+l0d
 Uua35XisULtf2OMoeUHzUxl37pjxecZAKCSBQOQ7xogO/bgfHq9CAQA5WZq1hClmieY5p6jqd5fud
 wMU7f0LNPic7hilIARDHAx+TLNfpRDhqKvwxorkzM=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 0/6] 9pfs: fix fstat() after unlink() (with a Linux guest)
Date: Mon, 25 Nov 2024 11:23:39 +0100
Message-ID: <192504804.CgdclvVjum@silver>
In-Reply-To: <20241125094554.5e1b17ba@bahia>
References: <cover.1732465720.git.qemu_oss@crudebyte.com>
 <20241125094554.5e1b17ba@bahia>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Monday, November 25, 2024 9:45:54 AM CET Greg Kurz wrote:
> On Sun, 24 Nov 2024 17:28:40 +0100
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> 
> > This fixes an infamous, long standing bug:
> > https://gitlab.com/qemu-project/qemu/-/issues/103
> > 
> 
> \o/
> 
> It is great if you manage to fix that once and far all !
> 
> > * Actual fix of this bug is patch 5.
> > 
> > * Patches 1 and 6 add a test case to verify the expected behaviour.
> > 
> > * The other patches (2, 3, 4) are basically just minor cleanup patches more
> >   or less (un)related that I simply did not bother to send separately.
> > 
> > Probably there are still other 9p request types that should be fixed for this
> > use-after-unlink idiom, but this series fixes the mentioned bug report as
> > described by reporter, so fair enough to round this up here for now.
> > 
> 
> When I last worked on that issue I had spotted some other places to fix.
> 
> Maybe you can find some ideas for future work at :
> 
> https://github.com/gkurz/qemu/tree/9p-attr-fixes

Was there a reason why you left those patches on the attic?

What I am seeing is that it was not fixing Tgetattr (i.e. fstat() on guest),
so it wouldn't have fixed the original reporter's scenario, but they would
have brought things forward. So just wondering ...

/Christian




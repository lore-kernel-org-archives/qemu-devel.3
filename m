Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0F1C88E63
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 16:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5n6O-0003wV-GB; Sun, 13 Sep 2026 12:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asmadeus@codewreck.org>)
 id 1x5n6J-0003wB-Qb
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 12:30:44 -0400
Received: from submarine.notk.org ([62.210.214.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asmadeus@codewreck.org>)
 id 1x5n6H-0000tN-V2
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 12:30:43 -0400
Received: from gaia.codewreck.org (localhost [127.0.0.1])
 by submarine.notk.org (Postfix) with ESMTPS id C305C14C2D6;
 Sun, 13 Sep 2026 18:30:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
 s=2; t=1789317030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tvmaiIU5PddctNQD7UfqypasD+Yj4SWTiUXRtO7KUcw=;
 b=uuv6UN8qiqJ+HmRv28s0aZ5AqKplDFCjnjryYvhy92cpG82wRZuK2Hvqjbw2dqtGL2ZBou
 tWGgtCm396btk/IrGwlz7F0SmmGBwukXWpSjc3isOjs6cxsdiQOfXMQOQPotnAAizPeXdd
 v82xQH0+TY8Zvh5CFaWgtsh0DqFxZ2/HMwdlScl50r1OZmBHRuzcHY/L+X0BuTMODOckls
 nWz9LtTYCtqRlHgvnmI5ZeLfu+tRJBsJjG9rjctg09IrZ5asn+hcLHsckbCCl/gnIQ0kMw
 rx8yy2iX7EpnKszo1ADbECNnD2DdaGC8CcYw4hHizkPXahofRv7tFngHVtM3+Q==
Received: from localhost (gaia.codewreck.org [local])
 by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 266e6f96;
 Sun, 13 Sep 2026 16:30:24 +0000 (UTC)
Date: Mon, 14 Sep 2026 01:30:09 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Tingmao Wang <m@maowtm.org>
Cc: Greg Kurz <groug@kaod.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 qemu-devel@nongnu.org, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
 =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
 linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org, Justin Suess <utilityemal77@gmail.com>
Subject: Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to
 qid)
Message-ID: <aqbPkWJBrphVwOKW@codewreck.org>
References: <aMih5XYYrpP559de@codewreck.org>
 <20250917.Eip1ahj6neij@digikod.net>
 <f1228978-dac0-4d1a-a820-5ac9562675d0@maowtm.org>
 <3061192.c3ltI2prpg@silver> <20251013112424.6b93659c@bahia>
 <15ccd30e-e5f2-4612-b0ac-e495748732e6@maowtm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15ccd30e-e5f2-4612-b0ac-e495748732e6@maowtm.org>
Received-SPF: pass client-ip=62.210.214.84;
 envelope-from=asmadeus@codewreck.org; helo=submarine.notk.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Tingmao Wang wrote on Tue, Jul 14, 2026 at 02:14:00AM +0100:
> Does anyone have preferences / suggestions on whether to keep going with
> the path-tracking based approach (perhaps subject to figuring out a way to
> handle parent renames), or an approach where Landlock simply stores the
> fhandle (or (i_ino, i_generation (but this is u32 whereas st_gen within 9p
> is u64))) as the rule key?

st_gen comes from FS_IOC_GETVERSION which is exactly i_generation on at
least ext4/btrfs/xfs, so it's not like that brings you anything
(and it's also stored in the 9p inode's i_generation afaics?)

My understanding is that if the underlying filesystem supports it then
yes mountpoint + i_ino + i_generation ought to be unique when combined
together, but that leaves you with what to do with filesystems that
don't support it (at least tmpfs?) and 9p mounts sharing multiple
filesystems (even if qemu has been warning about it for a while and that
brings its own share of bugs around cache)

If you're fine not supporting them, I think that definitely looks more
promising, but otherwise you don't have much choice


Either way I'm afraid I don't have time to look much into it (I'm afraid
I have to admit I didn't read your full mail, and I have to get up in 4
hours so I should probably stop processing this 9p backlog...), and it
doesn't look like Greg is much more reactive, so you're on your own and
I'm really sorry about it :/
I wish you best though!

> If I find some time over the next couple of weeks I will try out the
> second approach since it might be turning out to be the simpler option,
> but the drawback is that it doesn't enable i/fanotify on 9pfs, which I
> originally hoped to achieve together with fixing Landlock on 9pfs.

(inotify/fanotify would need a protocol overhaul to get "right" and is a
much bigger can of works, because if you get it to work locally then
you'll get people to expect the server to notify clients of remote
changes (some network filesystems can do it with leases, but 9p doesn't
have any such mechanism);
I can understand it is useful even if it only works within the client
local changes but I'm not sure I want to push much here either.)

-- 
Domnique


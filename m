Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81945C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 00:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Eep-00052Q-6s; Sun, 28 Apr 2024 20:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1s1Eem-000527-CT
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 20:14:08 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1s1Eel-0007gv-4E; Sun, 28 Apr 2024 20:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=AS4t2jnU8wCn26mvQi3JriGTqPEM+C1Gay0FpUMC0f8=; b=eeSl4SlEqc+HgMxhXGzl
 LpKg0eNfdv3Zc1u6tFF5/lvnbdh+xhSVM5VeXV8bSYOXl5NbCB+yePRupw83QN+Ek4EF1z580nZnj
 4KPJFak38uxD/yfov7slfYpAJJ9z5jQ7mC7JI0FpvF03MUCn7UtbUZC/FiSp1zSWKYGjpBdKqqKn/
 HVP3ln/de/nlzUzFa35BTWLrsq/YrdbS3hAYmPIIsNkxNtRhYZ/p5l3AwAvo/ZPS9Nwvcp/hDudL/
 +pxX8n2nsdUyjgYzfhNLJIZCXkpwEzT5KKRPvFVRVX8h3Z9YIhQfnMkIIcDtFsAHlaFt2pygZBo/t
 sj1iyilhAkcDBg==;
Date: Mon, 29 Apr 2024 02:14:04 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Nicholas Ngai <nicholas@ngai.me>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] net/slirp: Use newer slirp_*_hostxfwd API
Message-ID: <20240429001404.faq5jr4rbshilemi@begin>
References: <20210925214820.18078-1-nicholas@ngai.me>
 <8143f015-056c-6362-2d3e-7fed66aaffe7@ngai.me>
 <20211005235613.kuwbfixvp74sv5en@begin>
 <807f262d-bc28-865f-dda5-2e503f5ebf31@ngai.me>
 <20240222111726-198aca86-5ac7-4177-a7d7-3aeb1808add1@linutronix.de>
 <20240428172303.wfmxpslfkjuqucro@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240428172303.wfmxpslfkjuqucro@begin>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
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

Samuel Thibault, le dim. 28 avril 2024 19:23:03 +0200, a ecrit:
> Thomas Weißschuh, le jeu. 22 févr. 2024 11:44:13 +0100, a ecrit:
> > On Tue, Mar 22, 2022 at 06:58:36PM -0700, Nicholas Ngai wrote:
> > > Pinging this. It’s a bit old, though the patch still applies cleanly to
> > > master as far as I can tell.
> > > 
> > > Link to patchew is
> > > https://patchew.org/QEMU/20210925214820.18078-1-nicholas@ngai.me/.
> > > 
> > > I’d love to get https://gitlab.com/qemu-project/qemu/-/issues/347 addressed
> > > once libslirp makes a release with added Unix-to-TCP support in the hostxfwd
> > > API, but this patch is a requirement for that first.
> > 
> > I'm also interested in this PATCH and a resolution to issue 347.
> > 
> > FYI your patch triggers checkpatch warnings, see [0].
> 
> Indeed, the code should be fixed to use qemu_strtoi, like already done
> elsewhere in net/slirp.c
> 
> > Maybe you can resend the patch with the review tags and the checkpatch
> > warnings cleaned up.
> > 
> > Also it would be useful to know how the patch changes the version
> > requirements of the libslirp dependency.
> > (The version requirement should also be enforced in meson.build)
> > Also the commit in subprojects/slirp.wrap should be high enough,
> > which seems to already be the case however.
> > 
> > It seems it requires libslirp 4.6.0 from 2021-06-14, which is only
> > available from Debian 12 or Ubuntu 22.04 and no release of RHEL.
> 
> The code can easily be made optional with SLIRP_CHECK_VERSION(4,5,0)
> 
> (the hostxfwd interface was added in 4.5.0, not 4.6.0 ; the unix socket
> part was added in 4.7.0)

I went ahead and just fixed the code, by sticking more to the original
code, and use a #if between the hostxfwd and hostfwd APIs. I sent the
corresponding pull request for inclusion.

Nicholas, you'll be able to rebase your unix work on top of it. Be sure
however to update the documentation of the options, we won't commit it
unless it is documented (hint: anything that is not documented does
*not* exist for users)

There's also the IPv6 support which some people were having a look at,
and which'd need to be revived...

Samuel


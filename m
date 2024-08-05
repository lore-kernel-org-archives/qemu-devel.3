Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16677C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 15:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sazlu-00058r-QQ; Mon, 05 Aug 2024 11:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1sazlt-00054B-IT
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 11:37:17 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1sazlr-00009a-IC
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 11:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=yLJBN+Y/YYb1fd/767W/nNpRUe+JX+MCjCDaZ6KhrVs=; b=R24eVERxMQUXIHs
 eP8l538X01HFXEo/gwqAODhH5EPI8jXjzRtD2bXoOl0RKybD/VPrJiwNCox6/HgbHg7uWikfSP7fP
 9LGO0gY/n5XdoXaSLFK49+T3+WPICC4iAkTnNfYcXHI0ZnP8s0haV5AHXanvk3XjpW09zpZp4w/OU
 78=;
Date: Mon, 5 Aug 2024 17:39:09 +0200
To: Brian Cain <quic_bcain@quicinc.com>
Cc: Alyssa Ross <hi@alyssa.is>, Brian Cain <bcain@quicinc.com>, 
 qemu-devel@nongnu.org, ale@rev.ng
Subject: Re: [PATCH] target/hexagon: don't look for static glib
Message-ID: <myyizd4ooua6rl456uwwi6ctkuflwbhfgfypkdyi7tgqqajabt@fw2z2j3evx2w>
References: <20240805104921.4035256-1-hi@alyssa.is>
 <11ae16b4-8d3f-4b45-8a66-95b6d431471c@quicinc.com>
 <5d3f84b2-db1e-4bdf-ac7b-6c48f1c3bf63@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d3f84b2-db1e-4bdf-ac7b-6c48f1c3bf63@quicinc.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 05/08/24, Brian Cain wrote:
> 
> On 8/5/2024 8:57 AM, Brian Cain wrote:
> > 
> > On 8/5/2024 5:49 AM, Alyssa Ross wrote:
> > > When cross compiling QEMU configured with --static, I've been getting
> > > configure errors like the following:
> > > 
> > >      Build-time dependency glib-2.0 found: NO
> > > 
> > >      ../target/hexagon/meson.build:303:15: ERROR: Dependency lookup
> > > for glib-2.0 with method 'pkgconfig' failed: Could not generate libs
> > > for glib-2.0:
> > >      Package libpcre2-8 was not found in the pkg-config search path.
> > >      Perhaps you should add the directory containing `libpcre2-8.pc'
> > >      to the PKG_CONFIG_PATH environment variable
> > >      Package 'libpcre2-8', required by 'glib-2.0', not found
> > > 
> > > This happens because --static sets the prefer_static Meson option, but
> > > my build machine doesn't have a static libpcre2.  I don't think it
> > > makes sense to insist that native dependencies are static, just
> > > because I want the non-native QEMU binaries to be static.
> > > 
> > > Signed-off-by: Alyssa Ross <hi@alyssa.is>
> > > ---
> > 
> > Thanks for the patch, Alyssa - I'll give it a try.
> > 
> Hmm - ok, I misunderstood the intent of the change because I didn't read the
> commit message too carefully.  I understand the goal now.
> 
> This seems appropriate in most situations, and I guess configure doesn't
> have a way to distinguish between whether host tools should be static or
> not.  So it LGTM.
> 
> Anton, Alessandro -- thoughts?

This makes sense, and assuming glib2 is shared seems more sensible.  We might
get the inverse problem where a static glib2 would not be found.  I'm a bit
surprised meson wouldn't fallback on trying to find a shared version of
glib2 when prefer_static is set, hmm.

-- 
Anton Johansson
rev.ng Labs Srl.


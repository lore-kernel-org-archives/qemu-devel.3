Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28902CD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZn3F-0001pU-Js; Wed, 17 Jun 2026 05:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wZn38-0001ox-VZ; Wed, 17 Jun 2026 05:59:11 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wZn37-0005v6-Is; Wed, 17 Jun 2026 05:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=YL3dqJWdFY7RMVw5jE0CljEblvCOt1oEQkGnV13DrBk=; b=CNJRO7nUrB1gzVh657owpdHCl1
 w+zpoJZjyzh+YiqZuy+BjuMiVpbFniJuFwyqxcUzJDyKPaKTzVnaSuWTTYcRCvUIf7tmyDYl/k5X1
 BKGPzymHnSpcstYsO4znZ6N/a6D0OYbTNwUD0k9rTGS2iKk6yQPkH27Uq+5wMynh5xJq/YUMmgqQM
 dU9XaA1o9ns9UDJ4nmZk6g0itnzhTFAf20JYWQAiaoYuQ5zbw7Iy06mynVCziE7lb00Ql6jNT/l41
 Dg9v9mkK92Z+0AVbXnQFxGsFac1rnHOIJAxEUJ1D9NC4A1RdHk/DxT6F0Xfgrb5nn0ISG8U+6Ygch
 ls8kCYOi5E3sq4sy8arqQIBojMaw7Z0iqr9I6usLFOn5ZJzwMwnKyBssJF646ioJIYzaRCmx32lNu
 nu4vfdRic7s2H+XbVpqRlb9q86QV3bhTlwqA8bIb/MSPkelATjQrtTcJ5ov7A0bxDBngDMWDiq7kC
 KVJSKXWL9JDaVylA6feFED0jInoAVIdwhgq10qh5dG9IK6sXb/KjQFko9WvypJvkdje07NQhW/otF
 zEWK9A4suhcdfqWV2zsmCZGBmPF6iXCrVl61AKjMtNriPL//rVFC/2edLanDnTLG6fNK2Ul20fHA4
 mpeajXI7JWndBxC4voKN4Q7XNrhq/aakXGA+KieMs=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: Greg Kurz <groug@kaod.org>, Feifan Qian <bea1e@proton.me>
Subject: Re: [PATCH 0/3] 9pfs: fix invalid union V9fsFidOpenState access
Date: Wed, 17 Jun 2026 11:59:04 +0200
Message-ID: <2353743.iZASKD2KPV@weasel>
In-Reply-To: <dcede4ae-4dff-4a46-ac45-903171786522@tls.msk.ru>
References: <cover.1781621428.git.qemu_oss@crudebyte.com>
 <5079251.GXAFRqVoOG@weasel>
 <dcede4ae-4dff-4a46-ac45-903171786522@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
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

On Wednesday, 17 June 2026 11:35:04 CEST Michael Tokarev wrote:
> On 17.06.2026 11:10, Christian Schoenebeck wrote:
[...]
> > At least I currently don't have further reports to work on. So all bugfix
> > patches are posted.
> 
> Yeah, that's excellent.  Thank you for this stuff!
> The next step is for all this to land in the master branch in the main
> qemu repository - where I can pick it up for the stable branches :)

I know, I just wanted to point out that I am usually not inclined to send out 
a PR with patches that only have been posted few days before, especially as 
they are going to pushed through several stables branches. You know, 
regressions, etc. ;-)

What about delaying the stable release for a week? Does that sound like a 
viable compromise?

/Christian




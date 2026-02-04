Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C634DEA7943
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 23:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnmBH-0001ok-0G; Wed, 04 Feb 2026 18:21:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jpoimboe@kernel.org>)
 id 1vnmBF-0001oW-Sw
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 18:21:05 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jpoimboe@kernel.org>)
 id 1vnmBC-00067P-6A
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 18:21:05 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C08D460010;
 Wed,  4 Feb 2026 23:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02FAC4CEF7;
 Wed,  4 Feb 2026 23:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770247253;
 bh=LpwE8aiQz2TVND2Jy9Y6s1DgfxEiJaZB3N8/NSLtsY0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NI8xdpd6UbuTQQUqrjksRVvwfP0p0r6u/q7scmPGC3cHXKY9y/gmW5qnNmyu2zmAe
 OG9ZXvS6BDDBC3GZfo9laSx5IdTApMDBXdRivpsO8N00yzX0OB7L8+0IBv5gmOzMYl
 xqBp2MQ/nx0IZdxlbinrzoPvNPuDLICta4MK3sV5Br+y66mi2NW4hoe+9+8HT5Vcnk
 qOYYzvY1Fyqny98w6tx99C6wSwdjvlPE+NjazTBVapA0JaUb8GCP4ILm42xRAGbzbQ
 yivS20SPrNG4lU6GnAWrrFcRb+GYOJFcpgwjnofRW4uiOguO6iNRHUdd77chjp1hng
 dX4LH5lS8hE/g==
Date: Wed, 4 Feb 2026 15:20:51 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Justin Forbes <jforbes@fedoraproject.org>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] hw/i386/vmmouse: Fix hypercall clobbers
Message-ID: <pdtkpdg52ijsmoknnuwe2geylnqonm7wvbwh2g77de4vyg6tdx@muqauymjdw5s>
References: <ae0b8f2c574abe8053e742260c794adcaeda975a.1769110562.git.jpoimboe@kernel.org>
 <479166c0-8135-4c99-a2bb-0532633d384d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <479166c0-8135-4c99-a2bb-0532633d384d@linaro.org>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=jpoimboe@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Sun, Feb 01, 2026 at 03:27:46PM +0100, Philippe Mathieu-Daudé wrote:
> > @@ -221,7 +221,7 @@ static void vmmouse_data(VMMouseState *s, uint32_t *data, uint32_t size)
> >   static uint32_t vmmouse_ioport_read(void *opaque, uint32_t addr)
> >   {
> >       VMMouseState *s = opaque;
> > -    uint32_t data[6];
> > +    target_ulong data[6];
> 
> Could we use uint64_t instead (also in the callees) and let
> the implicit 32-bit truncation when assigning env->regs[] on
> 32-bit guests?

That would work, is there a reason that would be preferable?

-- 
Josh


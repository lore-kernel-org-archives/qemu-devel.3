Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500CDC61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 19:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNcY7-0001Mz-6q; Fri, 06 Jun 2025 15:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uNcY4-0001Ma-2A
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 15:16:16 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uNcY2-0004J7-C0
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 15:16:15 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4C35861136;
 Fri,  6 Jun 2025 19:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17B9C4CEEB;
 Fri,  6 Jun 2025 19:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749237372;
 bh=cT8p/sxCwkVsEIf2VO3h9sW12C9C03P0UhrDuwADIJI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PdaC/p4ScBuG5oLjqd2TcssR72IzYVboAjwDnTakwGe+5MIvrN1hHObJKSofAxrm/
 N40OxfdteofmZjO4ueVSV891P3+WpnI3VfkK0/0qVdkGr4P2uWqzg492mP3eKs4fUp
 hkOZ/2eZ7pVkah/ErBaSONuxwe++mtvPg/9wDb8Q4kunxabXTEOKIrnqpnVm5rdwux
 6QAJRiXwT7da79MbYyuvYf5Px62AszvZofTIxdKaxxTAizt5aQol8gt5fOG92Z/VL1
 56X6X3vxRgNQ80VaOXTGLB0/Bbhkge7Wl3c9wCHIEb2fPz4JEb5qg9t08gZnOTrJpf
 7RDmeavGl1Caw==
Date: Fri, 6 Jun 2025 19:16:10 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, magnuskulke@microsoft.com,
 qemu-devel@nongnu.org, liuwe@microsoft.com,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 jinankjain@microsoft.com, muislam@microsoft.com
Subject: Re: [RFC PATCH 18/25] target/i386/mshv: Implement
 mshv_arch_put_registers()
Message-ID: <aEM-epmqAv3kiwjX@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-19-magnuskulke@linux.microsoft.com>
 <aC0Ao4TQnV6ZE6Aa@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
 <aDceHy3zjGgwBFNm@example.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDceHy3zjGgwBFNm@example.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=wei.liu@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, May 28, 2025 at 04:30:55PM +0200, Magnus Kulke wrote:
> On Tue, May 20, 2025 at 10:22:27PM +0000, Wei Liu wrote:
> > On Tue, May 20, 2025 at 01:30:11PM +0200, Magnus Kulke wrote:
> > > +    /*
> > > +     * TODO: support asserting an interrupt using interrup_bitmap
> > > +     * it should be possible if we use the vm_fd
> > > +     */
> > > +
> > 
> > Why is there a need to assert an interrupt here?
> > 
> 
> The comment has been carried over from the mshv-ioctl crate:
> 
> https://github.com/rust-vmm/mshv/blob/main/mshv-ioctls/src/ioctls/vcpu.rs#L778
> 
> I was wondering whether we can/want to set the bitmap here, since we do
> have access to the vm_fd, but I didn't follow up on that yet.

In the code snippet you quoted, an error is returned if the bitmap is
not empty.

Please at least print a warning if the bitmap is not empty to catch any
issues. Debugging lost interrupts is hard enough as it is.

CC the Rust-VMM code co-owners for awareness.

Thanks,
Wei.


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F08BFF885C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 08:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGY5t-0000GK-PS; Sat, 25 Apr 2026 04:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wGY5p-0000F9-9n; Sat, 25 Apr 2026 04:10:25 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wGY5n-0003tp-Ld; Sat, 25 Apr 2026 04:10:25 -0400
Received: from example.com (p57a1bc69.dip0.t-ipconnect.de [87.161.188.105])
 by linux.microsoft.com (Postfix) with ESMTPSA id 9D6F320B7165;
 Sat, 25 Apr 2026 01:10:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9D6F320B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1777104620;
 bh=3GxSJ6kytQKpqnWpr5MCdCt6Ddf9VC6mjcFel6DBbqE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oLLTVq7ZHBU9Zf53+Rk4Couv3FfSMbjZWsYkA4XtwVexEpYC74YP8UTELMMJnVc90
 EsFM3/cDqUMAN+o/c2U10QyT4h2AZMRyKN70BDgvcXs3cPcbKm9tz6kgJEujJvUg9g
 7CU7oF+HI4uiTgdjPh6hRiFLn80WP+kLnONS3mKI=
Date: Sat, 25 Apr 2026 10:10:14 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@microsoft.com>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Wei Liu <wei.liu@kernel.org>, Wei Liu <liuwe@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH] target/i386/mshv: Fix segment regression in MMIO emu
Message-ID: <aex25q67R3TxXTzN@example.com>
References: <20260410142652.367541-1-magnuskulke@linux.microsoft.com>
 <24a2d178-b674-4355-870e-415c259658e3@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24a2d178-b674-4355-870e-415c259658e3@tls.msk.ru>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Apr 25, 2026 at 12:35:27AM +0300, Michael Tokarev wrote:
> On 10.04.2026 17:26, Magnus Kulke wrote:
> > When the segmentation code has been reworked, there is now an
> > unconditional call to emul_ops->read_segment_descriptor(). The MSHV impl
> > was delegating this to x86_read_segement_descriptor(), which read from
> > the GDT in guest memory. This fails for selector.idx == 0 and when no
> > GDT is set up (which is the case in real mode).
> > 
> > In the fix we change the MSHV impl to fill segment descriptor from
> > SegmentCache, that was populated from the hypervisor by mshv_load_regs()
> > before instruction emulation.
> > 
> > Fixes: 09442d98ab (target/i386: emulate: segmentation rework)
> > 
> > Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> > ---
> >   target/i386/mshv/mshv-cpu.c | 39 ++++++++++++++++++++++++++++++-------
> >   1 file changed, 32 insertions(+), 7 deletions(-)
> 
> This looks like a qemu-stable material (11.0.x).
> 
> Please let me know if it isn't.
> 
> Thanks,
> 
> /mjt

I think so, yes. real mode mmio-emu will not work, which affects pretty
much all (x86) workloads for mshv.

best,

magnus


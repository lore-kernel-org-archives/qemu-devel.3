Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1673A606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 22:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cHqFMEi4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX4nc-0004P5-MS; Fri, 27 Nov 2026 17:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1xX4na-0004Oa-Vj
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 17:52:11 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1xX4nZ-00010A-FS
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 17:52:10 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E91574388E;
 Fri, 27 Nov 2026 22:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858681F00893;
 Fri, 27 Nov 2026 22:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795819927;
 bh=vGIqN5Xr4P1ID5b70nEDS7FUtSDTGDE69l0IuZDu1uU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cHqFMEi4QG/1QoUl69NsAL1oAYErggGnI0RCQ49ocqeDcBC6Y1ORSPByOPNIrW1a8
 37L1pHRBwBGkF+RdgHfjKmf2GncMUgMTcMOn+uRDMgjhZnC7uwgnohrDp808C9N4Td
 2C3LxzzX26IDHCyPZUhbDDV9mzgTHlklOFXG3ULkMVSLQSgA3ZE01f2rCj13hBBssu
 NsCw3xSM74rrpou5W6O2mlZPLrdXHKtBc845k3YmPfOYpxLAQLTtRz1naXkU8I/dUo
 THaatbt2ikorT8hvlI24C+FcYCrZ3tXWKRRyz7G4JP3yRtkUBJGviozkZKqthIxS5f
 BrvSR0tjiU8MA==
Date: Fri, 27 Nov 2026 14:52:06 -0800
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] target/i386/mshv: add SynIC MSR init routine
Message-ID: <20261127225206.GC5355@liuwe-devbox-debian-v2.local>
References: <20261125144911.52270-1-magnuskulke@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125144911.52270-1-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=wei.liu@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 03:49:11PM +0100, Magnus Kulke wrote:
> Windows guests on Microsoft Hypervisor expect to be initialized with a
> specific set of values in its SynIC MSRs, otherwise the paravirtualized
> timers will not work and boot will stall.
> 
> Reference:
> 
> https://github.com/microsoft/openvmm/blob/8d4e0313/vmm_core/virt/src/x86/vp.rs
> 
> L1801-L1813
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Acked-by: Wei Liu <wei.liu@kernel.org>


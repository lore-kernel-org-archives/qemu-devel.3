Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BAB103E2E7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 20:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0QdT-0007aX-N8; Wed, 11 Mar 2026 16:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1w0QdS-0007a6-HS
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 16:58:30 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1w0QdR-0000mq-2J
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 16:58:30 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F7F14436A;
 Wed, 11 Mar 2026 20:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63456C4CEF7;
 Wed, 11 Mar 2026 20:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773262707;
 bh=SlXWbzImwroAOa9RTfLmZWPEKH3uP3bLdy3AXaVpb3w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cMi3vO49ZpXNP3NbBYwowmAM2V5rbae6th/VAqFjIF5y4xRkkERe3PWB6pryCUpKs
 35NMiX0YEr61dNbrMBRXxQHZcGn8lfFrOXIC6E//yPe6BPyTpzg/qRVTI9tHtLEAWJ
 Jyyd6zgHwlr3Bm0/orn3gOs/lBSKOk9wxIpsdeeD37GClC0MELw5EyX8rFRNyWWZNM
 7zxsmCSCl0klnuHXQPCImhv+bR7y54OHK8d1SuHDhaWJybux5qLbPOMgXhQPNhENND
 syCxok9mqkh9wCTqixgWnBT34NWYE9cUCQkUTKktsFhaCzGZ1QiG+Sz3P4tvcl8kx2
 iyj/VxtUa14Gg==
Date: Wed, 11 Mar 2026 20:58:26 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2 3/9] target/i386/mshv: fix various cpuid traversal bugs
Message-ID: <20260311205826.GE3612627@liuwe-devbox-debian-v2.local>
References: <20260311113505.1177878-1-magnuskulke@linux.microsoft.com>
 <20260311113505.1177878-4-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311113505.1177878-4-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=wei.liu@kernel.org; helo=sea.source.kernel.org
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

On Wed, Mar 11, 2026 at 12:34:59PM +0100, Magnus Kulke wrote:
> - Hardcoded max_leaf was not accurate. We query leaf 0x0 and 0x80000000 to
>   get the actual max leaves
> 
> - On all 0 zeroes on leaf 0x0d, we register 0-63 subleaves with zeros
>   indicating XSAVE is disabled
> 
> - Subleaf 0 was hardcoded, so the Hypervisor returned defaults for other
>   subleaves
> 
> - Subleaf 0 war hardcoded, so we were passing 0 instead of actual subleaf
>   when adding entries. We now pass the correct subleaf value to
>   add_cpuid_entry()
> 
> - Leaves 0x04,0x07,0d,0f,10 weren't marked as subleaf-specific
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

I didn't check whether the changes matched what the manuals say, but if
things were not working before but are working now, then I guess the
changes are correct.

Acked-by: Wei Liu <wei.liu@kernel.org>


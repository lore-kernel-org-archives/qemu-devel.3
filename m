Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4404CD2F326
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 16:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfh1j-0003Jy-J8; Tue, 13 Jan 2026 11:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1vfh1T-0002zB-Tt
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 11:13:39 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1vfh1R-0005hd-PK
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 11:13:35 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D10D860018;
 Tue, 13 Jan 2026 16:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7E6C116C6;
 Tue, 13 Jan 2026 16:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768320800;
 bh=w9MDFSRJjVrv2k2HfbOFSTurzehQgK1rH8je49ZFpMc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FLubW/Tv2zWdIMPfT8cqAag29P+l6FARSnswOfLf2Jh8VWBWf2eH4jShAvszCwGgx
 hgZYbIzNWNhrjsABlSI26UzXFMIcfacNH6XrlxvuZgaf6yQm7sxOe3aSXvFuwUpNsL
 shGak5GcbfUHcP1IDCgsSTFzA3Z762Aj375EX4sB8DAywtzDm0/rtAleEHRwuVjeao
 M2aWy//ru0bI0/PfEKVbkSXeVIL1nx9ehDWMKY6p6MEFQkjywIUvMKvv7vreywAb1L
 E+ERnRd4Sh0v57gbYYj4Xn4QHlqkp29RRBSt17GQ9wwpUULJpuwtv/yrb9m5z+E/yL
 Qwxi7S7W/wCMQ==
Date: Tue, 13 Jan 2026 16:13:19 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] accel/mshv: Remove remap overlapping mappings code
Message-ID: <20260113161319.GA3192261@liuwe-devbox-debian-v2.local>
References: <20260113153708.448968-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113153708.448968-1-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=wei.liu@kernel.org; helo=tor.source.kernel.org
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

On Tue, Jan 13, 2026 at 04:37:08PM +0100, Magnus Kulke wrote:
> This change removes userland code that worked around a restriction
> in the mshv driver in the 6.18 kernel: regions from userland
> couldn't be mapped to multiple regions in the kernel. We maintained a
> shadow mapping table in qemu and used a heuristic to swap in a requested
> region in case of UNMAPPED_GPA exits.
> 
> However, this heuristic wasn't reliable in all cases, since HyperV
> behaviour is not 100% reliable across versions. HyperV itself doesn't
> prohibit to map regions at multiple places into the guest, so the
> restriction has been removed in the mshv driver.
> 
> Hence we can remove the remapping code. Effectively this will mandate a
> 6.19 kernel, if the workload attempt to map e.g. BIOS to multiple
> reagions. I still think it's the right call to remove this logic:
> 
> - The workaround only seems to work reliably with a certain revision
>   of HyperV as a nested hypervisor.
> - We expect Direct Virtualization (L1VH) to be the main platform for
>   the mshv accelerator, which also requires a 6.19 kernel
> 
> This reverts commit efc4093358511a58846a409b965213aa1bb9f31a.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Acked-by: Wei Liu (Microsoft) <wei.liu@kernel.org>


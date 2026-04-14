Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53263F9D0ED
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCiCk-0003NS-Ui; Tue, 14 Apr 2026 14:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1wCiCT-0003FN-1S; Tue, 14 Apr 2026 14:09:25 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1wCiCR-0002oO-5w; Tue, 14 Apr 2026 14:09:24 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8ABC760018;
 Tue, 14 Apr 2026 18:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C41C19425;
 Tue, 14 Apr 2026 18:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776190161;
 bh=iwVHGO5Ym0gmkdK/Sv1lH/0PcGMOCM9PxF8cMi/2L4A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gP7b09P5vflXvXR4+Kz+9QXcTzuo+VV4nXwsEK5PW0q9HIDw97ZjEUi1L01UDvQ0x
 3vccRaVsi0AhWnBET54dlYvOU1PuSgjkMHPKTY/tKAKlQ4BMr+z3XawTOrh8nPuJfS
 AAsO8einmpCYBObiOqik/+8FuQndbRzOfLOVgyf8J1PHscVROF8fDbymERrsPe/T65
 0KyWY7EGsN4sChlKNihL5M+Mz6CdxpJoqEpRiKWaW3ge8zJw4IfadubwEiuV5jHIrr
 dPltLLFGjD3D4kLL+tD5XU3Fg4sCzMfewowBcugjafB3wBoExI6mJrMHpAqOYvQfDX
 Uspfb4fb0CB7Q==
Date: Tue, 14 Apr 2026 12:09:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Matthieu Rolla <matthieu@minio.io>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mr-083 <matthieu@min.io>, John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH 0/2] NVMe namespace hotplug and drive reconnection support
Message-ID: <ad6Cz4XmrrDc2yRH@kbusch-mbp>
References: <20260409060155.94704-1-matthieu@min.io>
 <ad0lMYOrRa-K1Ach@AALNPWKJENSEN.aal.scsc.local>
 <20260414124221.GB111076@fedora>
 <A0EE1F55-E562-4315-BE08-1D3CF70706AD@minio.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A0EE1F55-E562-4315-BE08-1D3CF70706AD@minio.io>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=kbusch@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Apr 14, 2026 at 03:36:19PM +0200, Matthieu Rolla wrote:
> Regarding `drive_insert`,  I found that `device_del` + `device_add` works well when no filesystem is mounted on the namespace. 
> 
> However, when XFS is mounted (e.g. via DirectPV/CSI), the Linux kernel doesn't reuse the block device number (nvme0n1 becomes nvme0n2) because the stale mount holds a reference to the old `nvme_ns_head`, preventing `ida_free()`. 
> 
> This causes XFS "duplicate UUID" errors on remount.
> 
> `drive_insert` avoids this by keeping the namespace device alive which means no ida cycle, same block device name. 

Are you attempting some kind of covert way to swap out the backend
without the host knowing you did that? Isn't that just going to confuse
the filesystem that's actively using the previous backend when it's
in-memory context no longer aligns with the on-disk format?


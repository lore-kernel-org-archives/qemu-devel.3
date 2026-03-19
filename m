Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B9C1075275
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w38tf-0003MS-H2; Thu, 19 Mar 2026 04:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1w38tK-0003IX-Uk; Thu, 19 Mar 2026 04:38:09 -0400
Received: from mail.avm.de ([212.42.244.119])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1w38tF-0001Uo-IL; Thu, 19 Mar 2026 04:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1773909467; bh=FW6qPzw3cOxRYuhBKvXUBlB8tyXIJow2/Dn8NSZVppo=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=ZBL3t2M98cSVO3JLLH7y1p0JrYz7X74xpBBWhWgMZ0ZL4Nyj5rET1YyLfwVHrC1Yo
 Ww3eXcV40ppxRbFZiha4lQ+3eaO96fuvPlM0DnGTxuW8g4RXjxG6Kv3AuLMkyxhjkL
 8iFApdS5T3EA5o5jHG/XWa9QAJWycGEFsf/ukZVs=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <c.speich@avm.de>)
 id 69bbb5db-76f5-7f0000032729-7f000001b80e-1
 for <multiple-recipients>; Thu, 19 Mar 2026 09:37:47 +0100
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Thu, 19 Mar 2026 09:37:47 +0100 (CET)
Received: from l-cspeich ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2026031909374728-3254 ;
 Thu, 19 Mar 2026 09:37:47 +0100 
Date: Thu, 19 Mar 2026 09:37:45 +0100
From: Christian Speich <c.speich@avm.de>
To: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v3 0/6] hw/sd: Improve performance of read/write/erase
Message-ID: <drbptkndzj4malncmyecbeab4bhpsjfglxq7mxrdolonlkte3o@fsrfbjw2hw4s>
References: <20260204-sdcard-performance-b4-v3-0-dc1cf172ee57@avm.de>
MIME-Version: 1.0
In-Reply-To: <20260204-sdcard-performance-b4-v3-0-dc1cf172ee57@avm.de>
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 19.03.2026 09:37:47,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 19.03.2026 09:37:47, Serialize complete at 19.03.2026 09:37:47
X-TNEFEvaluated: 1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-purgate-ID: 149429::1773909467-755AFBF8-6A5818E2/0/0
X-purgate-type: clean
X-purgate-size: 2829
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=212.42.244.119; envelope-from=c.speich@avm.de;
 helo=mail.avm.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

Ping :) Anything I can do to move this forward?

Kind Regards,
Christian

On Wed, Feb 04, 2026 at 02:22:24PM +0100, Christian Speich via qemu development wrote:
> This patch series improves the performance of read/write/erase operations
> on sdcards.
> 
> This is done by increasing the maximum buffer size that is worked on.
> >From 1 byte (master) to 512 bytes (commit 1-3) to larger than 512
> (adma commit).
> 
> Testing on my system with fio I see the following rough performance
> values in MiB/s.
> 
>               read write readwrite
>        master:   6     6     3/  3
>  first commit:  51    43    23/ 23
> second commit: 392   180   144/143
> 
> Tested on a 2GiB raw image with:
>   fio --filename=/dev/mmcblk0 --direct=1 --runtime=60 --time_based --bs=128k --rw={mode}
> 
> The adma values are somewhat unstable but always >100MiB/s, I'm not sure
> why but I guess it has something to do with the host side caching.
> 
> The fifth commit fixes the DATA_STAT_AFTER_ERASE bit in SCR and
> introduces an option to allow to erase blocks to 0x00.
> 
> The sixth commit optimizes block erase when erase-blocks-as-zero=true
> is used, by passing the zeroing request down the to the block device.
> Erasing 2GiB now takes 0.1s instead of 26s.
> 
> Signed-off-by: Christian Speich <c.speich@avm.de>
> ---
> Changes in v3:
> - Rebase onto master, updating read/write path for newly added RBMP
> - Split up commit 1 into multiple commits
>   - change interface to allow "short" read/writes that are continued
>     by the core later by calling again
> - Link to v2: https://lore.kernel.org/qemu-devel/20251202-sdcard-performance-b4-v2-0-d42490b11322@avm.de
> 
> Changes in v2:
> - Properly set DATA_STAT_AFTER_ERASE in SCR
> - Add erase-blocks-as-zero option to allow the user to switch between
>   0x00 and 0xFF for erased blocks.
> - Link to v1: https://lore.kernel.org/qemu-devel/20250919-sdcard-performance-b4-v1-0-e1037e481a19@avm.de
> 
> ---
> Christian Speich (6):
>       hw/sd: Switch read/write primitive to buf+len
>       hw/sd/sd: Allow multi-byte read/write for generic paths
>       hw/sd/sd: Use multi-byte/block writes for block path
>       hw/sd/sdhci: Don't use bounce buffer for ADMA
>       hw/sd/sdcard: Add erase-blocks-as-zero option.
>       hw/sd/sdcard: Optimize erase blocks as zero.
> 
>  hw/sd/core.c       |  26 +++--
>  hw/sd/sd.c         | 333 ++++++++++++++++++++++++++++++++++++++++-------------
>  hw/sd/sdhci.c      | 102 ++++++++--------
>  include/hw/sd/sd.h |  22 ++--
>  4 files changed, 341 insertions(+), 142 deletions(-)
> ---
> base-commit: 28a6ca268c2cd3718b5bf24c2d97e3d1e95fc604
> change-id: 20250912-sdcard-performance-b4-d908bbb5a004
> 
> Best regards,
> -- 
> Christian Speich <c.speich@avm.de>
> 
> 


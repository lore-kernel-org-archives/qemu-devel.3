Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C06CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 09:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHISj-0003cm-HG; Fri, 07 Nov 2025 04:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vHISh-0003cQ-0D; Fri, 07 Nov 2025 04:08:51 -0500
Received: from mail.avm.de ([212.42.244.119])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vHISe-0002Rw-CC; Fri, 07 Nov 2025 04:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1762506522; bh=hajdHmPU/rv2sjcsRpHPelEIpjWizr5FM89Rfm9uTxU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AaqVz6UeoV74+hDh7pfke/1XRZIbdLWnr2kKB/Pxvs2thtNnKyMShXAUhbWFtMbVE
 GiU3p9N74BhqinIDhoJYQe+SFdK9eoPCk4h36z9i9YfRYkG/sc3oXfemsiRecTbZGS
 4ZRZtIKILEjBRWjGW6CEEYWpVMwIbw2urnuB+AZQ=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.53.4)
 (envelope-from <c.speich@avm.de>)
 id 690db71a-ed76-7f0000032729-7f000001d060-1
 for <multiple-recipients>; Fri, 07 Nov 2025 10:08:42 +0100
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Fri,  7 Nov 2025 10:08:42 +0100 (CET)
Received: from l-cspeich ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2025110710084203-4244 ; Fri, 7 Nov 2025 10:08:42 +0100 
Date: Fri, 7 Nov 2025 10:08:40 +0100
From: Christian Speich <c.speich@avm.de>
To: qemu-devel@nongnu.org
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 0/4] hw/sd: Improve performance of read/write/erase
Message-ID: <4eal54pkozivg367yzt76irxmxn46pjtexvbm2xl7qpbiyfyah@n6milralmryq>
References: <20250919-sdcard-performance-b4-v1-0-e1037e481a19@avm.de>
MIME-Version: 1.0
In-Reply-To: <20250919-sdcard-performance-b4-v1-0-e1037e481a19@avm.de>
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 07.11.2025 10:08:42,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 07.11.2025 10:08:42, Serialize complete at 07.11.2025 10:08:42
X-TNEFEvaluated: 1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-purgate-ID: 149429::1762506522-72CCD0DA-10CAE116/0/0
X-purgate-type: clean
X-purgate-size: 2099
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=212.42.244.119; envelope-from=c.speich@avm.de;
 helo=mail.avm.de
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

ping, I've not received any reaction on this series[1]. Is there anything I can do to
move this forward?

Greetings,
Christian

[1]: https://patchew.org/QEMU/20250919-sdcard-performance-b4-v1-0-e1037e481a19@avm.de/

On Fri, Sep 19, 2025 at 02:34:39PM +0200, Christian Speich wrote:
> This patch series improves the performance of read/write/erase operations
> on sdcards.
> 
> This is done by increasing the maximum buffer size that is worked on.
> >From 1 byte (master) to 512 bytes (first commit) to larger than 512
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
> For erasing the third commit changes the erase operation to write zeros,
> as indicated by DATA_STAT_AFTER_ERASE in SCR.
> 
> The fourth commit allows erasure in large blocks, to speed it up
> significantly. Erasing 2GiB now takes 0.1s instead of 26s.
> 
> Signed-off-by: Christian Speich <c.speich@avm.de>
> ---
> Christian Speich (4):
>       hw/sd: Switch from byte-wise to buf+len read/writes
>       hw/sd/sdhci: Don't use bounce buffer for ADMA
>       hw/sd/sdcard: Erase blocks to zero
>       hw/sd/sdcard: Erase in large blocks
> 
>  hw/sd/core.c       |  16 +---
>  hw/sd/sd.c         | 277 ++++++++++++++++++++++++++++++++++++++++-------------
>  hw/sd/sdhci.c      | 102 +++++++++++---------
>  include/hw/sd/sd.h |  13 +--
>  4 files changed, 277 insertions(+), 131 deletions(-)
> ---
> base-commit: e7c1e8043a69c5a8efa39d4f9d111f7c72c076e6
> change-id: 20250912-sdcard-performance-b4-d908bbb5a004
> 
> Best regards,
> -- 
> Christian Speich <c.speich@avm.de>
> 
> 


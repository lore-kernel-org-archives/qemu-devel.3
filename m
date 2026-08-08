Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C781C55174
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wshHZ-0004nN-5y; Sat, 08 Aug 2026 09:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andreas@kemnade.info>)
 id 1wshHX-0004nE-MR
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 09:40:11 -0400
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andreas@kemnade.info>)
 id 1wshHV-0005xv-S6
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 09:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=GE2YmfZ3v8lqCUJREfFlss7wMXi+jG9wMS3r+4TWuGU=; t=1786196407; x=1787406007; 
 b=aZTNPRVCA9OEhCUklIN8FtuC9ZZ6K9xWgrJPRcfDT7GIe5l5hIsLD1QZVCq151W74rYAWYg5Kqp
 6qUA3fel7r7bV/nto8u6ACmMzAbM3EV6a6SeEN09cS6XIgIvy1LyGgQoMKhORDXJKbH2Lde1E+S0g
 KXdOPznMxB7iqtSur3Z6XohNFVBgO6DMnTsKBuRpa4AeqVES8UkSWiQK9AdpYJ2cj03W2a1rKnwuz
 ZjPsoXPRxnKWUoeOBSGB3gsvpaNFYbtPgqV/iQvqgwrmuWiu5PF7vKnDC0hXeUtkfWrDGV6X1hCi9
 nVqOoipbiDuPkLO0xNfxTkkPJahDsUyLkNww==;
Date: Sat, 8 Aug 2026 15:40:00 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org, sre@kernel.org
Subject: Re: [PATCH] linux-user: fix issues with mmap on 4K guest on 16K
 host and library load
Message-ID: <20260808154000.149b159f@kemnade.info>
In-Reply-To: <6f98eb42-54ae-4909-b4f1-4ff683d3d6f9@gmx.de>
References: <20260805164052.199608-1-andreas@kemnade.info>
 <6f98eb42-54ae-4909-b4f1-4ff683d3d6f9@gmx.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:c205:3004:2154::1;
 envelope-from=andreas@kemnade.info; helo=mail.andi.de1.cc
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Fri, 7 Aug 2026 23:26:07 +0200
Helge Deller <deller@gmx.de> wrote:

> On 8/5/26 18:40, Andreas Kemnade wrote:
> > Strace in qemu:
> > 198005 openat(AT_FDCWD,"/lib/arm-linux-gnueabihf/libselinux.so.1",O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
> > 198005 read(3,0x40802570,512) = 512
> > 198005 statx(3,"",AT_EMPTY_PATH|AT_NO_AUTOMOUNT|AT_STATX_SYNC_AS_STAT,STATX_BASIC_STATS,0x408022a8) = 0
> > 198005 mmap2(NULL,269428,PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_DENYWRITE,-1,0) = 0x40868000
> > 198005 mmap2(0x40870000,203892,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE|MAP_FIXED,3,0) = 0x40870000

Size of the file: 132612: allocated: 203892

End address: 0x408a1c74

> > 198005 munmap(0x40868000,32768) = 0
> > 198005 munmap(0x408a2000,31860) = 0
> > 198005 mprotect(0x40890000,61440,PROT_NONE) = 0
which just ends at 0x4089f000 (not 16K aligned)

> > 198005 mmap2(0x4089f000,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWRITE|MAP_FIXED,3,0x1f) = -1 errno=14 (Bad address)
> > 
mmap2 sitting in that area mapping a part of the same file.

> > strace outside qemu:
> > [pid 195331] readlinkat(AT_FDCWD, "/usr/lib", 0x7fffd1a7fd00, 1023) = -1 EINVAL (Invalid argument)
> > [pid 195331] readlinkat(AT_FDCWD, "/usr/lib/arm-linux-gnueabihf", 0x7fffd1a7fd00, 1023) = -1 EINVAL (Invalid argument)
> > [pid 195331] readlinkat(AT_FDCWD, "/usr/lib/arm-linux-gnueabihf/libselinux.so.1", 0x7fffd1a7fd00, 1023) = -1 EINVAL (Invalid argument)
> > [pid 195331] faccessat(AT_FDCWD, "/usr/gnemul/qemu-arm/lib/arm-linux-gnueabihf/libselinux.so.1", F_OK) = -1 ENOENT (No such file or directory)
> > [pid 195331] openat(AT_FDCWD, "/lib/arm-linux-gnueabihf/libselinux.so.1", O_RDONLY|O_CLOEXEC) = 3
> > [pid 195331] read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\0\0\0\0004\0\0\0"..., 512) = 512
> > [pid 195331] statx(3, "", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT|AT_EMPTY_PATH, STATX_BASIC_STATS, {stx_mask=STATX_ALL|STATX_MNT_ID|STATX_SUBVOL, stx_attributes=0, stx_mode=S_IFREG|0644, stx_size=132612, ...}) = 0
> > [pid 195331] mmap(0x408a8000, 16384, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS|MAP_DENYWRITE, -1, 0) = 0x408a8000
> > [pid 195331] mprotect(0x408a8000, 16384, PROT_WRITE) = 0
> > [pid 195331] mprotect(0x408a8000, 16384, PROT_NONE) = 0
> > [pid 195331] mmap(0x40868000, 262144, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS|MAP_DENYWRITE, -1, 0) = 0x40868000
> > [pid 195331] mprotect(0x408a0000, 16384, PROT_WRITE) = 0
> > [pid 195331] pread64(3, "", 8192, 196608) = 0
> > [pid 195331] mprotect(0x408a0000, 16384, PROT_READ) = 0
> > [pid 195331] mmap(0x40870000, 196608, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0) = 0x40870000
> > [pid 195331] mmap(0x40868000, 32768, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) = 0x40868000
> > [pid 195331] mmap(0x408a4000, 32768, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) = 0x408a4000
> > [pid 195331] mprotect(0x4089c000, 16384, PROT_READ) = 0
> > [pid 195331] mprotect(0x40890000, 49152, PROT_NONE) = 0

ends at 0x4089c000

> > [pid 195331] mprotect(0x4089c000, 16384, PROT_WRITE) = 0
> > [pid 195331] pread64(3, 0x4089f000, 4096, 126976) = -1 EFAULT (Bad address)
> > 
reads from write-only area created by the mprotect before. 

> > That makes simple commands like ls --version to fail.
> > Tested was arm32 on a arm64 only host.
> > 
> > Fix that issue by truncating file mapping and replacing out-of-file
> > mappings by anonymous mappings.  
> 
> Could you please explain "the issue" and not just referring to the strace?
> It's not that easy to see the problem.
> 
> Thanks!
> Helge
> 
> Btw: you patch might fix this problem, but you may run into other problems too,
> see e.g.: https://gitlab.com/qemu-project/qemu/-/work_items/3410
> 
That is correct, but at least increases the amount of platforms to be
debootstrappable. Or maybe some better chances for same bitbake run
to get through.

Regards,
Andreas


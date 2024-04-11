Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D13C001CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 15:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruvzQ-0004i0-2h; Thu, 11 Apr 2024 11:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ruvzN-0004hV-Pm
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 11:05:22 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ruvzK-0007ch-DI
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 11:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712847918; x=1744383918;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gMvSDgW8IeuU4FT+ofiid+nRw4xJBILFhxPjFd/HkS8=;
 b=KRH1qB9qsZBaKkZgrFGzltXTIVEj/jV5lmqQXQDYeDY16NdGkWmU96In
 5mXeg/w83FRNg+gRsVRYvpBgS3enyXThlKFX9gkKElqXgjBqQvg6HaYdV
 qwsQZCopkopljVTy42vgW0v4ErBjmZSU/IMGhMay6ZmIdw/A+8/Ye1mLd
 CR6E4ORInZi9qcBmFbKundm5bhHdrvd9dYQ/NYEN4AriWlB4KSksh5LSC
 9l8cYp2tITJ8PC7jqe+mHcWWnUUlWQiRx/gABPbYiQ2dbGg5ebPt0aRS3
 3uyUUwUYHDHO/RtRTUeCrL+yU8XG6EBvxcWueb4a4PqGgaDdu2aqX7xg3 A==;
X-CSE-ConnectionGUID: 1aU5sIO0QEW63WEgjXaxkA==
X-CSE-MsgGUID: csJjabrnSQGZnfurKVRvpw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="12113183"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; d="scan'208";a="12113183"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2024 08:05:15 -0700
X-CSE-ConnectionGUID: mx9fXN3YQVmqEKy0Tr4fTQ==
X-CSE-MsgGUID: E76cW2ZPSaWwL4lYUZ0Fzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; d="scan'208";a="25700572"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 11 Apr 2024 08:05:14 -0700
Date: Thu, 11 Apr 2024 23:19:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH for-9.1 09/19] target/i386: move 60-BF opcodes to new
 decoder
Message-ID: <Zhf/czBP8LaaGORr@intel.com>
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409164323.776660-10-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Tue, Apr 09, 2024 at 06:43:13PM +0200, Paolo Bonzini wrote:
> Date: Tue,  9 Apr 2024 18:43:13 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH for-9.1 09/19] target/i386: move 60-BF opcodes to new
>  decoder
> X-Mailer: git-send-email 2.44.0
> 
> Compared to the old decoder, the main differences in translation
> are for the little-used ARPL instruction.  IMUL is adjusted a bit
> to share more code to produce flags, but is otherwise very similar.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/tcg/decode-new.h     |   2 +
>  target/i386/tcg/translate.c      |   9 +-
>  target/i386/tcg/decode-new.c.inc | 171 +++++++++++++++++
>  target/i386/tcg/emit.c.inc       | 317 +++++++++++++++++++++++++++++++
>  4 files changed, 497 insertions(+), 2 deletions(-)

HMM, I met Guest boot failure on this patch because of ata unrecognized.
I haven't located the exact error yet, so let me post my log first.
If there are other means I can use to dig further, I'd be happy to try
that too.

# Command (boot a ubuntu Guest via TCG)

./qemu/build/qemu-system-x86_64 \
-smp 1 \
-name ubuntu -m 4G \
-cpu max -accel tcg \
-hda ../img_qemu/test.qcow2 -nographic \
-kernel ../img_qemu/kernel/vmlinuz-6.4.0-rc6+ \
-initrd ../img_qemu/kernel/initrd.img-6.4.0-rc6+ \
-append "root=/dev/sda ro console=ttyS0" \
-qmp unix:/tmp/qmp-sock,server=on,wait=off

# Guest log

...
[    1.567002] scsi host0: ata_piix
[    1.570945] scsi host1: ata_piix
[    1.571446] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq 14
[    1.571592] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq 15
[    1.577016] tun: Universal TUN/TAP device driver, 1.6
[    1.579437] PPP generic driver version 2.4.2
[    1.583207] VFIO - User Level meta-driver version: 0.3
[    1.585787] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    1.593520] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.593847] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.599632] mousedev: PS/2 mouse device common for all mice
[    1.602405] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    1.604135] rtc_cmos 00:05: RTC can wake from S4
[    1.611641] rtc_cmos 00:05: registered as rtc0
[    1.612271] rtc_cmos 00:05: setting system clock to 2024-04-11T14:59:56 UTC (1712847596)
[    1.613380] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
[    1.613669] i2c_dev: i2c /dev entries driver
[    1.614302] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    1.614687] device-mapper: uevent: version 1.0.3
[    1.619437] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
[    1.620134] platform eisa.0: Probing EISA bus 0
[    1.620388] platform eisa.0: EISA: Cannot allocate resource for mainboard
[    1.620608] platform eisa.0: Cannot allocate resource for EISA slot 1
[    1.620749] platform eisa.0: Cannot allocate resource for EISA slot 2
[    1.621045] platform eisa.0: Cannot allocate resource for EISA slot 3
[    1.621178] platform eisa.0: Cannot allocate resource for EISA slot 4
[    1.621291] platform eisa.0: Cannot allocate resource for EISA slot 5
[    1.621400] platform eisa.0: Cannot allocate resource for EISA slot 6
[    1.621510] platform eisa.0: Cannot allocate resource for EISA slot 7
[    1.621621] platform eisa.0: Cannot allocate resource for EISA slot 8
[    1.621745] platform eisa.0: EISA: Detected 0 cards
[    1.621873] amd_pstate: driver load is disabled, boot with specific mode to enable this
[    1.622309] ledtrig-cpu: registered to indicate activity on CPUs
[    1.628983] drop_monitor: Initializing network drop monitor service
[    1.735074] ata1: found unknown device (class 0)
[    1.748551] ata2: found unknown device (class 0)
[    1.763380] NET: Registered PF_INET6 protocol family
[    1.771260] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
[    2.330777] tsc: Refined TSC clocksource calibration: 2903.979 MHz
[    2.331349] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x29dbf1ca37e, max_idle_ns: 440795233019 ns
[    2.332227] clocksource: Switched to clocksource tsc
[    5.375200] Freeing initrd memory: 72840K
[    5.526057] Segment Routing with IPv6
[    5.526392] In-situ OAM (IOAM) with IPv6
[    5.527164] NET: Registered PF_PACKET protocol family
[    5.527709] Key type dns_resolver registered
[    5.530256] IPI shorthand broadcast: enabled
[    5.545746] sched_clock: Marking stable (5512061965, 30528485)->(5548999115, -6408665)
[    5.548071] registered taskstats version 1
[    5.550142] Loading compiled-in X.509 certificates
[    5.563141] Key type .fscrypt registered
[    5.563275] Key type fscrypt-provisioning registered
[    5.594426] Key type encrypted registered
[    5.594760] AppArmor: AppArmor sha1 policy hashing enabled
[    5.595336] ima: No TPM chip found, activating TPM-bypass!
[    5.595621] Loading compiled-in module X.509 certificates
[    5.595865] ima: Allocated hash algorithm: sha1
[    5.600207] ima: No architecture policies found
[    5.601022] evm: Initialising EVM extended attributes:
[    5.601215] evm: security.selinux
[    5.601329] evm: security.SMACK64
[    5.601408] evm: security.SMACK64EXEC
[    5.601496] evm: security.SMACK64TRANSMUTE
[    5.601608] evm: security.SMACK64MMAP
[    5.601737] evm: security.apparmor
[    5.601854] evm: security.ima
[    5.601927] evm: security.capability
[    5.602031] evm: HMAC attrs: 0x1
[    5.604746] PM:   Magic number: 4:740:990
[    5.605067] memory memory33: hash matches
[    5.606782] RAS: Correctable Errors collector initialized.
[    5.608451] clk: Disabling unused clocks
[    6.885887] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x2)
[    7.035230] ata1: found unknown device (class 0)
[    7.045928] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
[Thread 0x7ffff4c40640 (LWP 695720) exited]
[   12.251691] ata2: found unknown device (class 0)
[   12.262338] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x2)
[   17.371176] ata1: found unknown device (class 0)
[   17.381770] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
[   22.491447] ata2: found unknown device (class 0)
[   22.502088] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x2)
[   27.611394] ata1: found unknown device (class 0)
[   27.771117] ata2: found unknown device (class 0)
[   27.794539] Freeing unused decrypted memory: 2036K
[   27.855183] Freeing unused kernel image (initmem) memory: 4632K
[   27.855513] Write protecting the kernel read-only data: 34816k
[   27.857829] Freeing unused kernel image (rodata/data gap) memory: 1960K
[   27.985357] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   27.985661] Run /init as init process
Loading, please wait...
Starting version 249.11-0ubuntu3.7
[   29.631358] Floppy drive(s): fd0 is 2.88M AMI BIOS
[   29.652292] FDC 0 is a S82078B
[   29.662353] piix4_smbus 0000:00:01.3: SMBus Host Controller at 0x700, revision 0
[   29.778444] e1000: Intel(R) PRO/1000 Network Driver
[   29.778562] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   30.673420] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[   30.872005] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input3
[   31.020279] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[   31.020856] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[   31.052677] e1000 0000:00:03.0 ens3: renamed from eth0
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top ... done.
Begin: Running /scripts/local-premount ... done.
Begin: Waiting for root file system ... Begin: Running /scripts/local-block ... done.
done.
Gave up waiting for root file system device.  Common problems:
 - Boot args (cat /proc/cmdline)
   - Check rootdelay= (did the system wait long enough?)
 - Missing modules (cat /proc/modules; ls /dev)
ALERT!  /dev/sda does not exist.  Dropping to a shell!

Regards,
Zhao




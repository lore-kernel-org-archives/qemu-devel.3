Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404BDCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 05:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHaRZ-0000lC-Bl; Fri, 16 Oct 2026 01:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xHaRV-0000kd-1r
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 01:25:21 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xHaRS-00018G-Rc
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 01:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=cBDwmZLo1PXpKuuYvIeErTpIiuXBZfKyFvn9gh7un80=; b=CCma9iyqkteC9Xd
 N4tkYvv3u1/5PlA9j2ZYAVYKo1nmnqLUZHvrUlRXP1/VhKr0M6mWTW2iMfyPubQh06wrgI7p/cZRz
 5Qd5pbgTm3e5kp4V6bxevBZaxrEEIvv/gFX/3yCs+FhsdcsMNiviwolT3PqMRmgov8znooq/D8vzt
 Qo=;
Date: Fri, 16 Oct 2026 07:31:02 +0200
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v2 00/19] multi-target: remove dump functions duplication
Message-ID: <atG2dl5Ez2F-tmBH@hive.localdomain>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15/10/26, Pierrick Bouvier wrote:
> This series removes duplication of cpu_get_note_size and cpu_get_dump_info per
> target. For this, we define a new set of Dump operations for a given cpu, and
> implement it per target.
> 
> Existing implementations were using first_cpu, which is what we continue to do.
> When we'll work on heterogeneous later, we can revisit this to either forbid a
> dump, or perform a dump for each target active.
> 
> Based-on: 20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com
> "[PATCH v3 00/12] multi-target: add hexagon"
> This base is only needed due to conflicts with current wip, it's not important
> for this series implementation.
> 
> Pierrick Bouvier (19):
>   hw/core/sysemu-cpu-ops: add get_dump_info
>   target/arm: implement get_dump_info sysemu op
>   target/i386: implement get_dump_info sysemu op
>   target/ppc/cpu: constify cpu parameter for
>     ppc_interrupts_little_endian
>   target/ppc: implement get_dump_info sysemu op
>   target/riscv: implement get_dump_info sysemu op
>   target/s390x: implement get_dump_info sysemu op
>   target/loongarch: implement get_dump_info sysemu op
>   dump: use get_dump_info sysemu op
>   dump: remove cpu_get_dump_info
>   hw/core/sysemu-cpu-ops: add get_note_size
>   target/arm: implement get_note_size sysemu op
>   target/i386: implement get_note_size sysemu op
>   target/ppc: implement get_note_size sysemu op
>   target/riscv: implement get_note_size sysemu op
>   target/s390x: implement get_note_size sysemu op
>   target/loongarch: implement get_note_size sysemu op
>   dump: use get_note_size sysemu op
>   dump: remove cpu_get_note_size
> 
>  dump/dump.c                      | 21 +++++++++++++--------
>  include/hw/core/sysemu-cpu-ops.h | 14 ++++++++++++++
>  include/system/dump-arch.h       |  3 ---
>  stubs/dump.c                     | 27 ---------------------------
>  stubs/meson.build                |  1 -
>  target/arm/arch_dump.c           | 18 ++++++------------
>  target/arm/cpu.c                 |  2 ++
>  target/arm/internals.h           |  5 +++++
>  target/i386/arch_dump.c          | 10 ++++++----
>  target/i386/cpu-internal.h       |  7 +++++++
>  target/i386/cpu.c                |  2 ++
>  target/loongarch/arch_dump.c     |  7 ++++---
>  target/loongarch/cpu.c           |  2 ++
>  target/loongarch/internals.h     |  7 +++++++
>  target/ppc/arch_dump.c           | 14 +++++---------
>  target/ppc/cpu.h                 |  6 +++---
>  target/ppc/cpu_init.c            |  2 ++
>  target/ppc/internal.h            |  8 ++++++++
>  target/riscv/arch_dump.c         | 18 +++++++-----------
>  target/riscv/cpu.c               |  2 ++
>  target/riscv/internals.h         |  5 +++++
>  target/s390x/arch_dump.c         |  7 ++++---
>  target/s390x/cpu-system.c        |  2 ++
>  target/s390x/s390x-internal.h    |  6 ++++++
>  24 files changed, 112 insertions(+), 84 deletions(-)
>  delete mode 100644 stubs/dump.c
> 
> -- 
> 2.43.0
> 

Series:

Reviewed-by: Anton Johansson <anjo@rev.ng>


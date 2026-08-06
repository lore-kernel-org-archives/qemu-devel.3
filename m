Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B313C56207
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 15:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrzmR-000747-TK; Thu, 06 Aug 2026 11:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wrzmL-00073B-6E
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 11:13:05 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wrzmH-0007je-H0
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 11:13:04 -0400
Received: from [192.168.10.145] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 676FCpA0088133
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 7 Aug 2026 00:12:51 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Eozvc9GoUoglzE+rDLUtztaA3E0xJmwBFYrTp0k8J0U=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1786029171; v=1;
 b=Z8Yim5vUxqu+/bapNYNH9016R1vBDEN4hpQWbrSHTdiwQCkdy0fm0W0wjMX0ZYvA
 VHKkj1893PWe5DUw8SQ40ZmTCAV0ytekB++gWAEHI/FfBet2kitCHrnjn/1y0QhU
 vlrIYdI+uNT85DkemRKAS0GpNheeVgAIcHVPFOaDMJmZzi2miTHBa7VmG7Zr/sgI
 KrqqjyfqRJbXJ2UbCHzaXEb6CUDvIM2bSkb5Tt7PMbSnh4hiDDuzoae5XVv8Gyqz
 siMpS+tB+DvVJRIJDMfVtyumg9N8hdT9kip5kRxlublr1TZ09a5Xbm6n/Uaip7wB
 XvMsIfrUsqFpS09gfPGpYw==
Message-ID: <9f4a8188-0f6b-4465-98e0-2c5b7793eff3@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 7 Aug 2026 00:12:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] elf2dmp: identify faulting CPU in Windows crash
 dumps
To: Zhengrong Li <zhengrong_li@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: philmd@qualcomm.com, pbonzini@redhat.com, viktor.prutyanov@phystech.edu
References: <178601709477.48495.9850518471453430873@linux.alibaba.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <178601709477.48495.9850518471453430873@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/08/06 20:51, Zhengrong Li wrote:
> When a Windows guest crashes and QEMU generates a memory dump via
> pvpanic, elf2dmp currently always sets CPU 0's context in the dump
> header. This makes WinDbg default to CPU 0 when opening the dump,
> even if the actual crash happened on a different CPU.
> 
> This series adds crash_occurred tracking from the runstate layer
> through to the QEMUCPUState in the ELF dump, and teaches elf2dmp
> to identify and use the faulting CPU's context.
> 
> Changes since v2:
>     - Remove unused fault_cpu variable in fill_context()
>     - Use per-CPU size check (s->size >= offsetof + sizeof) instead
>       of global has_is_crash_occurred_cpu flag, fixing heterogeneous
>       dumps where CPU notes have different sizes
>     - Remove has_is_crash_occurred_cpu from QEMU_Elf struct and
>       init_states() since per-CPU check makes it unnecessary
>     - Move QEMUCPUState struct growth from patch 2 to patch 3 so
>       sizeof() change and init_states() update stay together
>       (bisectability)
>     - Fix patch 1 commit message: soften "is never called" to
>       "is not always called when crash dumping is enabled"
>     - Fix patch 2 commit message: clarify compatibility description
>       for both old-tools/new-dumps and new-tools/old-dumps directions
>     - Clamp state->size to MIN(state->size, n_descsz) in init_states()
>       to prevent reading beyond note descriptor boundary
>     - Compare state_size against offsetof + sizeof(kernel_gs_base)
>       instead of sizeof(*state) to avoid misclassifying valid old
>       440-byte notes as lacking kernel_gs_base
> 
> Changes since v1:
>     - Set header context before best-effort guest memory operations
>       to avoid losing faulting CPU context on partial dump failures
>     - Use LIVE_SYSTEM_DUMP when BugcheckCode is zero
>     - Use PRIx32 for BugcheckCode format specifier
>     - Use linux.alibaba.com identity
> 
> Zhengrong Li (3):
>    runstate: set crash_occurred on guest crashloaded
>    dump: add crash_occurred flag to QEMUCPUState
>    elf2dmp: fill ContextBuffer with faulting CPU context
> 
>   contrib/elf2dmp/kdbg.h     |  9 +++++++
>   contrib/elf2dmp/main.c     | 50 ++++++++++++++++++++++++++++++++++++--
>   contrib/elf2dmp/qemu_elf.c | 10 +++++++-
>   contrib/elf2dmp/qemu_elf.h |  2 ++
>   system/runstate.c          |  5 ++++
>   target/i386/arch_dump.c    |  6 +++++
>   6 files changed, 79 insertions(+), 3 deletions(-)
> 

The whole series now looks good to me:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki


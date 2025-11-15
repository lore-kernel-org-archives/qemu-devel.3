Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43113CE8D6B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Nov 2025 02:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK5wv-0004rL-Kr; Fri, 14 Nov 2025 21:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vK5wn-0004nK-KJ; Fri, 14 Nov 2025 21:23:30 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vK5wk-0004Oa-PM; Fri, 14 Nov 2025 21:23:29 -0500
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AF2Mefl098890
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 15 Nov 2025 11:22:40 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Tb0yRBS5b+CywSCmNXmKdViMa5KOfPGxpxM2o/zn+Dk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1763173360; v=1;
 b=oFUIue63xSpQ4Hk7d2VD+Byp5HA2bPEKY+nZPOdUlyquYzsKeyoR5IinmKVMxJ9L
 6EjILXWZ4Sd9JDOW8FDsbbdu26cFXzXSfEBjcnzVam+6YPBl8s72WblxXqapRfXC
 ZdD1kCmV/Zkerayx6GzoXachxAXu6Z+7mW+r9nxRia/l8WH24aA6raQ6JQAaLStz
 TvllI2REfSHYv0es2GKYazkcAWWkofeqog4L9C5hyx4ie/Fy7uX54KrV19SA5Gxl
 PvFR/2E8dnKqL/Dcj3pdLaleJvIaQ4GVswr419I0v2rK5Cg1eX2Qsqi7ULu/+L1o
 5xglE2uXuy2P9kko0CCDdg==
Message-ID: <b0b2fdce-9f4a-47a5-bba0-209f2c8ac0cc@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 15 Nov 2025 11:22:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/19] target/arm/hvf: Consolidate
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>
References: <20251114200422.4280-1-philmd@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251114200422.4280-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/11/15 5:04, Philippe Mathieu-Daudé wrote:
> Missing review: #8
> 
> - Patches 1-11 fix migration on HVF
> - Patches 12-14 remove a signal race with WFI
> - Patches 15-18 correct guest timer frequency
> 
> Since v4:
> - Rename gva -> gpa in hvf_set_phys_mem (Akihiko)
> - Dropped missing VTimer synchronization patches for 10.2
> 
> Since v3:
> - Call qemu_real_host_page_mask/size once (rth)
> 
> Since v2:
> - Improve host page size/mask uses (rth)
> - Remove cpu_test_interrupt in hvf_wfi (rth)
> 
> Since v1:
> - Addressed Mads & Richard comments
> - Fixed migration by reworking memory listeners
>    (unfortunately the current broken code has been
>     used as base for WHPX)
> - Sync CNTV_CTL/CVAL_EL0
> - Remove WFI racy signal implementation
> - Simplify PSCI Suspend (I expect the same can be
>    done for the other hvf_psci_cpu_off() calls).
> - Emulate more missing registers (PMU & Monitor Dbg)
> 
>  From v1:
> - Fix a pair of memory leak
> - Check a pair of return values
> - Mention calls which must be run on vCPU thread
> - Force MIDR
> - Use hv_vcpu_config_create/hv_vcpu_config_get_feature_reg
>    when not running on vCPU thread
> - Factor hvf_handle_vmexit() / hvf_handle_exception(() out
> - Call hv_vcpu_run() in loop
> - Guard hv_vcpu_run() between cpu_exec_start/end()
> - Restrict ARM specific in AccelCPUState
> 
> Based-on: <20250829152909.1589668-14-pbonzini@redhat.com>
> 
> Philippe Mathieu-Daudé (10):
>    target/i386/hvf: Use host page alignment in ept_emulation_fault()
>    accel/hvf: Enforce host alignment in hv_vm_protect()
>    accel/hvf: Skip WFI if CPU has work to do
>    accel/hvf: Implement WFI without using pselect()
>    accel/hvf: Have PSCI CPU_SUSPEND halt the vCPU
>    accel: Introduce AccelOpsClass::cpu_target_realize() hook
>    accel/hvf: Add hvf_arch_cpu_realize() stubs
>    target/arm: Create GTimers *after* features finalized / accel realized
>    target/arm/hvf: Really set Generic Timer counter frequency
>    target/arm: Only allow disabling NEON when using TCG
> 
> Richard Henderson (9):
>    accel/hvf: Create hvf_protect_clean_range, hvf_unprotect_dirty_range
>    target/i386/hvf: Use hvf_unprotect_dirty_range
>    target/i386/hvf: Use address_space_translate in ept_emulation_fault
>    accel/hvf: Simplify hvf_log_*
>    accel/hvf: Move hvf_log_sync to hvf_log_clear
>    accel/hvf: Simplify hvf_set_phys_mem
>    accel/hvf: Drop hvf_slot and hvf_find_overlap_slot
>    accel/hvf: Remove mac_slots
>    target/arm/hvf: Implement dirty page tracking
> 
>   include/accel/accel-cpu-ops.h |   1 +
>   include/system/hvf_int.h      |  22 +---
>   accel/accel-common.c          |   5 +
>   accel/hvf/hvf-accel-ops.c     |  19 +---
>   accel/hvf/hvf-all.c           | 186 ++++++++++------------------------
>   target/arm/cpu.c              |  67 ++++++------
>   target/arm/hvf/hvf.c          | 167 +++++++++++++++---------------
>   target/i386/hvf/hvf.c         |  44 ++++----
>   accel/hvf/trace-events        |   1 +
>   9 files changed, 208 insertions(+), 304 deletions(-)
> 

For the whole series:
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


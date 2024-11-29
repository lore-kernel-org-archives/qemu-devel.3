Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDE4D6EC07
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 13:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH11D-0002xv-Kg; Fri, 29 Nov 2024 08:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tH11B-0002xl-SS
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 08:26:46 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tH119-0000bn-CK
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 08:26:45 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:f69e:0:640:3ef4:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id CBE92610AF;
 Fri, 29 Nov 2024 16:26:33 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a409::1:12] (unknown
 [2a02:6b8:b081:a409::1:12])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VQb7NM1IdiE0-BJHmwVsd; Fri, 29 Nov 2024 16:26:32 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1732886792;
 bh=NUSxPfXEY6EwxxtF0lWDS8vBlLCqiaBJcHCjgosdbjk=;
 h=Cc:To:Subject:From:Date:Message-ID;
 b=QtBzdtJFIGLTTB5yqWeHzkDs8wWmXcl76Z7FS9M8Z1kvajohY7KUFarLJZT+MRBp3
 wSd+UqGg0cYmML5LEhH/DJq+LdXE3G31rHxiPaDAm9y7N+0d4kTg1p+4s3NiqElZGw
 1daA1x0quuatDgHPhEys6cqjd3lsLnZWMQpUd16I=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0d1fb30f-0b45-4797-82da-4c1d2e801499@yandex-team.ru>
Date: Fri, 29 Nov 2024 16:26:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [BUG] qemu crashes on assertion in cpu_asidx_from_attrs when cpu is
 in smm mode
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, mtosatti@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>,
 yc-core@yandex-team.ru, Daniil Tatianin <d-tatianin@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Hi all!

First, I see this issue: https://gitlab.com/qemu-project/qemu/-/issues/1198. where some kvm/hardware failure leads to guest crash, and finally to this assertion:

    cpu_asidx_from_attrs: Assertion `ret < cpu->num_ases && ret >= 0' failed.

But in the ticket the talk is about the guest crash and fixing the kernel, not about the final QEMU assertion (which definitely show that something should be fixed in QEMU code too).


We've faced same stack one time:

(gdb) bt
#0  raise () from /lib/x86_64-linux-gnu/libc.so.6
#1  abort () from /lib/x86_64-linux-gnu/libc.so.6
#2  ?? () from /lib/x86_64-linux-gnu/libc.so.6
#3  __assert_fail () from /lib/x86_64-linux-gnu/libc.so.6
#4  cpu_asidx_from_attrs  at ../hw/core/cpu-sysemu.c:76
#5  cpu_memory_rw_debug  at ../softmmu/physmem.c:3529
#6  x86_cpu_dump_state  at ../target/i386/cpu-dump.c:560
#7  kvm_cpu_exec  at ../accel/kvm/kvm-all.c:3000
#8  kvm_vcpu_thread_fn  at ../accel/kvm/kvm-accel-ops.c:51
#9  qemu_thread_start  at ../util/qemu-thread-posix.c:505
#10 start_thread () from /lib/x86_64-linux-gnu/libpthread.so.0
#11 clone () from /lib/x86_64-linux-gnu/libc.so.6


And what I see:

static inline int x86_asidx_from_attrs(CPUState *cs, MemTxAttrs attrs)
{
     return !!attrs.secure;
}

int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs)
{
     int ret = 0;

     if (cpu->cc->sysemu_ops->asidx_from_attrs) {
         ret = cpu->cc->sysemu_ops->asidx_from_attrs(cpu, attrs);
         assert(ret < cpu->num_ases && ret >= 0);         <<<<<<<<<<<<<<<<<
     }
     return ret;
}

(gdb) p cpu->num_ases
$3 = 1

(gdb) fr 5
#5  0x00005578c8814ba3 in cpu_memory_rw_debug (cpu=c...
(gdb) p attrs
$6 = {unspecified = 0, secure = 1, user = 0, memory = 0, requester_id = 0, byte_swap = 0, target_tlb_bit0 = 0, target_tlb_bit1 = 0, target_tlb_bit2 = 0}

so .secure is 1, therefore ret is 1, in the same time num_ases is 1 too and assertion fails.



Where is .secure from?

static inline MemTxAttrs cpu_get_mem_attrs(CPUX86State *env)
{
     return ((MemTxAttrs) { .secure = (env->hflags & HF_SMM_MASK) != 0 });
}

Ok, it means we in SMM mode.



On the other hand, it seems that num_ases seems to be always 1 for x86:

vsementsov@vsementsov-lin:~/work/src/qemu/yc-7.2$ git grep 'num_ases = '
cpu.c:    cpu->num_ases = 0;
softmmu/cpus.c:        cpu->num_ases = 1;
target/arm/cpu.c:        cs->num_ases = 3 + has_secure;
target/arm/cpu.c:        cs->num_ases = 1 + has_secure;
target/i386/tcg/sysemu/tcg-cpu.c:    cs->num_ases = 2;


So, something is wrong around cpu->num_ases and x86_asidx_from_attrs() which may return more in SMM mode.


The stack starts in
//7  0x00005578c882f539 in kvm_cpu_exec (cpu=cpu@entry=0x5578ca2eb340) at ../accel/kvm/kvm-all.c:3000
     if (ret < 0) {
         cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
         vm_stop(RUN_STATE_INTERNAL_ERROR);
     }

So that was some kvm error, and we decided to call cpu_dump_state(). And it crashes. cpu_dump_state() is also called from hmp_info_registers, so I can reproduce the crash with a tiny patch to master (as only CPU_DUMP_CODE path calls cpu_memory_rw_debug(), as it is in kvm_cpu_exec()):

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index ff01cf9d8d..dcf0189048 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -116,7 +116,7 @@ void hmp_info_registers(Monitor *mon, const QDict *qdict)
          }

          monitor_printf(mon, "\nCPU#%d\n", cs->cpu_index);
-        cpu_dump_state(cs, NULL, CPU_DUMP_FPU);
+        cpu_dump_state(cs, NULL, CPU_DUMP_CODE);
      }
  }


Than run

yes "info registers" | ./build/qemu-system-x86_64 -accel kvm -monitor stdio \
    -global driver=cfi.pflash01,property=secure,value=on \
    -blockdev "{'driver': 'file', 'filename': '/usr/share/OVMF/OVMF_CODE_4M.secboot.fd', 'node-name': 'ovmf-code', 'read-only': true}" \
    -blockdev "{'driver': 'file', 'filename': '/usr/share/OVMF/OVMF_VARS_4M.fd', 'node-name': 'ovmf-vars', 'read-only': true}" \
    -machine q35,smm=on,pflash0=ovmf-code,pflash1=ovmf-vars -m 2G -nodefaults

And after some time (less than 20 seconds for me) it leads to

qemu-system-x86_64: ../hw/core/cpu-sysemu.c:76: cpu_asidx_from_attrs: Assertion `ret < cpu->num_ases && ret >= 0' failed.
Aborted (core dumped)


I've no idea how to correctly fix this bug, but I hope that my reproducer and investigation will help a bit.

-- 
Best regards,
Vladimir


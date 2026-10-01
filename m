Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F6DCA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCBjw-0005lM-U5; Thu, 01 Oct 2026 04:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xCBjr-0005hq-39; Thu, 01 Oct 2026 04:01:59 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xCBjo-0000Ng-0h; Thu, 01 Oct 2026 04:01:58 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 69180mtc019025
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 1 Oct 2026 17:00:48 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=gBeo4zNov0MTvuBL9k++6OZxquvuRij2R9kUJGaP8z0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1790841648; v=1;
 b=a7CO+4+d+Lw8xb2ymBUC7U7rEj4v8zhYRdiH61D92fVMSlX+M/2D8Q2jJzgjWJQ8
 OdfUC0W2zmwZvp5IQZ7f9aKsC8fZtNEIP/6WFzXAQAa2JLIj4kK5EsU3SqVyO/eD
 XqCo9T0PMY26pmI4kWCm+6izPFFJeVm9+pUJbU/hvxRf5jFfphUkSfD+d+3ADyaU
 jScaL/j6OUF0Y+SXnqhZNKcFBTewqwtHKrqfHDjV64+lv6MGlDjC4dfT2CCdRCnV
 070v4wI5nFHnoXbTz2oIuLhlUIjkBsGvKKFV48DCmgX1o8Z6nZfs47lbc5qk1nXg
 egzjv4bAd9T+zWnAQO1zsw==
Message-ID: <33ad7803-82ad-49f0-b39d-d3a23807ab75@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 1 Oct 2026 17:00:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] monitor/hmp: replace MonitorDef with GDB registers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
References: <20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com>
 <1b9d9cef-8f65-4e96-9e7b-fd136f64a75d@oss.qualcomm.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <1b9d9cef-8f65-4e96-9e7b-fd136f64a75d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2026/10/01 2:18, Philippe Mathieu-Daudé wrote:
> Cc'ing Akihiko who worked on gdbstub.
> 
> On 11/9/26 14:27, Marc-AndrÃ© Lureau wrote:
>> Hi,
>>
>> HMP monitor supports printing $register expression. The lookup
>> was done via GDB stub registers, and supplementary MonitorDef
>> HMP-specific tables.
>>
>> Migrate HMP registers to use the GDB infrastructure and remove the
>> legacy HMP MonitorDef. Use a "qemu-debug" register group, as they are
>> aliases or synthetic registers, but gdb doesn't seem to care.

Unfortunately, these aliases and synthetic registers appear to have 
several problems:

- GDB already provides writable pseudo-registers for SPARC64's asi and
   pstate. The new QEMU registers shadow them but ignore writes, breaking
   previously supported functionality. See:
  
https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gdb/sparc64-tdep.c;h=93db3417a2a9f64790acab33288eb05764112e0b;hb=6a5e5259790e5a854ddbb69eb486b9245fcfeee8#l976

- GDB caches each raw register independently. Updating one alias can
   leave another stale, causing incorrect reads or skipped writes.

- The new raw aliases do not inherit the original registers' unwind
   rules, leading to incorrect register values when selecting older
   call frames.

The latter two issues also affect the RISC-V aliases and cannot be 
resolved merely by changing QEMU's register read/write callbacks. I 
therefore think we need to retain HMP-specific handling for these aliases.

Regards,
Akihiko Odaki

>>
>> Known behavioural changes on RISC-V: CSR lookup is now case-sensitive
>> and vector registers now report "unkown register" instead of a
>> target-specific message ("Unable to print the value of vector vreg 'v0'
>> from this API")
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>> Marc-André Lureau (10):
>>        hmp: don't crash on invalid register
>>        gdbstub: fix next register base after register gaps
>>        gdbstub: set feature->base_reg for dynamic features
>>        target/i386: expose segment limits via GDB
>>        monitor/hmp: add CPUClass::get_pc fallback for HMP $pc
>>        target/m68k: expose system registers via GDB
>>        target/sparc64: expose system registers via GDB
>>        target/riscv: bypass smstateen check in debugger mode
>>        target/riscv: expose register aliases via GDB
>>        monitor/hmp: remove legacy MonitorDef infrastructure
>>
>>   configs/targets/i386-softmmu.mak          |   2 +-
>>   configs/targets/m68k-softmmu.mak          |   2 +-
>>   configs/targets/riscv32-linux-user.mak    |   2 +-
>>   configs/targets/riscv32-softmmu.mak       |   2 +-
>>   configs/targets/riscv64-bsd-user.mak      |   2 +-
>>   configs/targets/riscv64-linux-user.mak    |   2 +-
>>   configs/targets/riscv64-softmmu.mak       |   2 +-
>>   configs/targets/sparc64-softmmu.mak       |   2 +-
>>   configs/targets/x86_64-softmmu.mak        |   2 +-
>>   gdbstub/gdb-xml/i386-segments.xml         |  14 +++
>>   gdbstub/gdb-xml/m68k-system.xml           |  32 +++++++
>>   gdbstub/gdb-xml/riscv-32bit-alias.xml     | 105 ++++++++++++++++++++++
>>   gdbstub/gdb-xml/riscv-32bit-fpu-alias.xml |  40 +++++++++
>>   gdbstub/gdb-xml/riscv-64bit-alias.xml     | 105 ++++++++++++++++++++++
>>   gdbstub/gdb-xml/riscv-64bit-fpu-alias.xml |  46 ++++++++++
>>   gdbstub/gdb-xml/sparc64-system.xml        |  22 +++++
>>   gdbstub/gdbstub.c                         |  14 +--
>>   include/hw/core/cpu.h                     |   2 +-
>>   include/hw/core/sysemu-cpu-ops.h          |  16 ----
>>   include/monitor/hmp.h                     |   6 --
>>   include/qemu/typedefs.h                   |   1 -
>>   monitor/hmp.c                             |  52 ++---------
>>   target/arm/gdbstub.c                      |   8 +-
>>   target/arm/gdbstub64.c                    |  10 ++-
>>   target/i386/cpu.c                         |  32 -------
>>   target/i386/gdbstub.c                     |  24 +++++
>>   target/m68k/cpu.c                         |  22 -----
>>   target/m68k/helper.c                      |  47 ++++++++++
>>   target/ppc/gdbstub.c                      |   2 +-
>>   target/riscv/cpu.c                        |   1 -
>>   target/riscv/gdbstub.c                    |  52 ++++++++++-
>>   target/riscv/internals.h                  |   3 -
>>   target/riscv/monitor.c                    | 140 
>> ------------------------------
>>   target/riscv/tcg/csr.c                    |   3 +-
>>   target/sparc/cpu.c                        |  19 ----
>>   target/sparc/gdbstub.c                    |  38 ++++++++
>>   target/xtensa/cpu.c                       |   2 +-
>>   37 files changed, 562 insertions(+), 314 deletions(-)
>> ---
>> base-commit: 209b2afaface001c7d4d981e38f186afe7b24a50
>> change-id: 20260910-query-reg-80cd59cf4707
>>
>> Best regards,
>> -- 
>> Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>>
> 



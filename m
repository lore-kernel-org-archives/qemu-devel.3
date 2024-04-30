Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0957AC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 17:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1ri4-0004nL-I6; Tue, 30 Apr 2024 13:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1s1rhr-0004m8-Av
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:55:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1s1rhp-0004uL-9S
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:55:55 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43UHMvWd016691; Tue, 30 Apr 2024 17:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=0EAyBGkbFfYSBfZ/BtCpY+jKs6wGGm/hRVTqznX8UJk=;
 b=a65KiJCzyfxVzAVRwJ8yGWfgeoMEsYgfhaIgfvdMBQWIcEERd1wMWPdOYjnA9plsw3oN
 PCYcrLcYr8f9/ixrJcGoYmkilnm+jfsLtnvFlTtV9//nZYYf9rwla7hNXvhkKMlJvz9+
 bhhpfGN+/45pHsz4cdFP8Ei5I6txuPc4ng5Rel6qFXn8TxhDyBtNJCvRFgoi6tQql0ZR
 CnzLOF15Yb3wPzMPlY9xF0KuSOrmElzXkE3CcFtdL4tQTjfSn+OKWSaG5sshuPX74qPM
 sdnzjY9M+PaKY0WCu+Y1FPUTuS8BtulHSVWiVf2BvZaCsBmuMz77IFvhGEf+VecS+58r Fw== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xu508r3b5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Apr 2024 17:55:50 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43UEeq5B011750; Tue, 30 Apr 2024 17:55:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xsdwm62n6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Apr 2024 17:55:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43UHtkaG27656954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Apr 2024 17:55:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1CDD20049;
 Tue, 30 Apr 2024 17:55:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E58820040;
 Tue, 30 Apr 2024 17:55:45 +0000 (GMT)
Received: from heavy (unknown [9.171.51.254])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 30 Apr 2024 17:55:45 +0000 (GMT)
Date: Tue, 30 Apr 2024 19:55:44 +0200
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 00/13] exec: Rework around CPUState user fields (part 2)
Message-ID: <363wwielvdpy37h7cqo7jo5luyys2aqmfgeb4t3wypsb3myqxg@kvasyjy4e767>
References: <20240430122808.72025-1-philmd@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240430122808.72025-1-philmd@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sAn-GWhFAIwEoWFeAIWn-QeKwQ5bXNO8
X-Proofpoint-GUID: sAn-GWhFAIwEoWFeAIWn-QeKwQ5bXNO8
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_10,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404300128
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Apr 30, 2024 at 02:27:54PM +0200, Philippe Mathieu-Daudé wrote:
> Missing WASM testing by Ilya (branch available at
> https://gitlab.com/philmd/qemu/-/commits/tcg_flush_jmp_cache)

Hmm, it dies very early now:

  # gdb --args ./qemu-s390x -L /usr/s390x-linux-gnu /build/wasmtime/target/s390x-unknown-linux-gnu/debug/deps/component_fuzz_util-d10a3a6b4ad8af47

  Thread 1 "qemu-s390x" received signal SIGSEGV, Segmentation fault.
  0x000055555559b718 in cpu_common_realizefn (dev=0x5555557c28c0, errp=<optimized out>) at ../home/iii/myrepos/qemu/hw/core/cpu-common.c:217
  217             cpu->accel->plugin_state = qemu_plugin_create_vcpu_state();

  (gdb) bt
  #0  0x000055555559b718 in cpu_common_realizefn (dev=0x5555557c28c0, errp=<optimized out>) at ../home/iii/myrepos/qemu/hw/core/cpu-common.c:217
  #1  0x000055555559f59a in s390_cpu_realizefn (dev=0x5555557c28c0, errp=0x7fffffffe1a0) at ../home/iii/myrepos/qemu/target/s390x/cpu.c:284
  #2  0x000055555563f76b in device_set_realized (obj=<optimized out>, value=<optimized out>, errp=0x7fffffffe2e0) at ../home/iii/myrepos/qemu/hw/core/qdev.c:510
  #3  0x000055555564363d in property_set_bool (obj=0x5555557c28c0, v=<optimized out>, name=<optimized out>, opaque=0x5555557a9140, errp=0x7fffffffe2e0) at ../home/iii/myrepos/qemu/qom/object.c:2362
  #4  0x0000555555646b9b in object_property_set (obj=obj@entry=0x5555557c28c0, name=name@entry=0x5555556e8ae2 "realized", v=v@entry=0x5555557c6650, errp=errp@entry=0x7fffffffe2e0)
      at ../home/iii/myrepos/qemu/qom/object.c:1471
  #5  0x000055555564a43f in object_property_set_qobject (obj=obj@entry=0x5555557c28c0, name=name@entry=0x5555556e8ae2 "realized", value=value@entry=0x5555557a7a90, errp=errp@entry=0x7fffffffe2e0)
      at ../home/iii/myrepos/qemu/qom/qom-qobject.c:28
  #6  0x0000555555647204 in object_property_set_bool (obj=0x5555557c28c0, name=name@entry=0x5555556e8ae2 "realized", value=value@entry=true, errp=errp@entry=0x7fffffffe2e0)
      at ../home/iii/myrepos/qemu/qom/object.c:1541
  #7  0x000055555564025c in qdev_realize (dev=<optimized out>, bus=bus@entry=0x0, errp=errp@entry=0x7fffffffe2e0) at ../home/iii/myrepos/qemu/hw/core/qdev.c:291
  #8  0x000055555559bbb4 in cpu_create (typename=<optimized out>) at ../home/iii/myrepos/qemu/hw/core/cpu-common.c:61
  #9  0x000055555559a467 in main (argc=4, argv=0x7fffffffeaa8, envp=<optimized out>) at ../home/iii/myrepos/qemu/linux-user/main.c:811

  (gdb) p cpu
  $1 = (CPUState *) 0x5555557c28c0
  (gdb) p cpu->accel
  $2 = (AccelCPUState *) 0x0

Configured with: '/home/iii/myrepos/qemu/configure' '--target-list=s390x-linux-user' '--disable-tools' '--disable-slirp' '--disable-fdt' '--disable-capstone' '--disable-docs'

If you don't see what can be wrong here right away, I can debug this.

> Since v2:
> - Move cpu_loop_exit_requested() to "exec/cpu-loop.h"
> - Added R-b tags
> 
> Since v1:
> - First 13 patches queued
> - Restrict qemu_plugin_vcpu_exit_hook() to (TCG) plugins
> - Restrict cpu_plugin_mem_cbs_enabled() to TCG (plugins)
> - Addressed Richard review comments on the others:
>   - Move cpu_plugin_mem_cbs_enabled()
>   - Do not move mem_io_pc, waiting for [*]
>   - Mention can_do_io restricted
> 
> Finish extracting TCG fields from CPUState:
> - Extract tcg_cpu_exit() from cpu_exit()
> - Introduce AccelOpsClass::exit_vcpu_thread()
> - cpu_exit() calls exit_vcpu_thread=tcg_cpu_exit for TCG
> - Forward declare TaskState and more uses of get_task_state()
> - Introduce TCG AccelCPUState
> - Move TCG specific fields from CPUState to AccelCPUState
> - Restrict "exec/tlb-common.h" to TCG
> - Restrict iommu_notifiers, icount to system emulation
> 
> [*] https://lore.kernel.org/qemu-devel/20240416040609.1313605-3-richard.henderson@linaro.org/
> 
> Based-on: https://gitlab.com/philmd/qemu/-/commits/accel-next
> 
> Philippe Mathieu-Daudé (13):
>   accel/tcg: Restrict qemu_plugin_vcpu_exit_hook() to TCG plugins
>   accel/tcg: Restrict cpu_plugin_mem_cbs_enabled() to TCG
>   accel/tcg: Move @plugin_mem_cbs from CPUState to
>     CPUNegativeOffsetState
>   accel/tcg: Move @plugin_state from CPUState to TCG AccelCPUState
>   accel/tcg: Restrict cpu_loop_exit_requested() to TCG
>   accel/tcg: Restrict IcountDecr / can_do_io / CPUTLB to TCG
>   accel/tcg: Move @jmp_env from CPUState to TCG AccelCPUState
>   accel/tcg: Move @cflags_next_tb from CPUState to TCG AccelCPUState
>   accel/tcg: Move @iommu_notifiers from CPUState to TCG AccelCPUState
>   accel/tcg: Move @tcg_cflags from CPUState to TCG AccelCPUState
>   accel/tcg: Restrict icount to system emulation
>   accel/tcg: Move icount fields from CPUState to TCG AccelCPUState
>   accel/tcg: Move @tb_jmp_cache from CPUState to TCG AccelCPUState
> 
>  accel/tcg/internal-common.h      | 18 ++++++++++
>  accel/tcg/tb-jmp-cache.h         |  4 +--
>  accel/tcg/tcg-accel-ops.h        |  1 +
>  accel/tcg/vcpu-state.h           | 20 +++++++++++
>  include/exec/cpu-loop.h          | 35 +++++++++++++++++++
>  include/exec/exec-all.h          | 17 ----------
>  include/exec/tlb-common.h        |  4 +++
>  include/hw/core/cpu.h            | 58 ++++++++------------------------
>  include/qemu/plugin.h            |  2 +-
>  include/qemu/typedefs.h          |  1 -
>  accel/tcg/cpu-exec-common.c      |  2 +-
>  accel/tcg/cpu-exec.c             | 52 +++++++++++++++-------------
>  accel/tcg/cputlb.c               |  2 +-
>  accel/tcg/icount-common.c        |  7 ++--
>  accel/tcg/plugin-gen.c           |  9 +++--
>  accel/tcg/tb-maint.c             |  6 ++--
>  accel/tcg/tcg-accel-ops-icount.c | 14 ++++----
>  accel/tcg/tcg-accel-ops.c        |  2 ++
>  accel/tcg/translate-all.c        |  9 ++---
>  accel/tcg/watchpoint.c           |  5 +--
>  hw/core/cpu-common.c             |  9 +++--
>  linux-user/main.c                |  2 +-
>  plugins/core.c                   |  9 ++---
>  system/physmem.c                 | 37 +++++++++++++++-----
>  target/arm/tcg/helper-a64.c      |  1 +
>  target/s390x/tcg/mem_helper.c    |  1 +
>  26 files changed, 195 insertions(+), 132 deletions(-)
>  create mode 100644 include/exec/cpu-loop.h
> 
> -- 
> 2.41.0
> 

